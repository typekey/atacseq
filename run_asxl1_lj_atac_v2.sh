module load singularity
BASEPATH=/project/mengjiechen/leizheng/workspace/asxl1_lj/atacseq_v2
WORKDIR=$BASEPATH/work_macs2_spikein
OUTDIR=$BASEPATH/results_macs2_spikein
DATAPATH=$BASEPATH/data.csv
FASTA=/project/mengjiechen/leizheng/references/Homo_sapiens/GENCODE/GRCh38/sequence/genome/GRCh38.genome.fa
GTF=/project/mengjiechen/leizheng/references/Homo_sapiens/GENCODE/GRCh38/annotation/gencode.v44.annotation.gtf
Blacklist=/project/mengjiechen/leizheng/references/Homo_sapiens/ENCODE/hg38-blacklist.bed
Spikein_fasta="/project/mengjiechen/leizheng/references/Drosophila_melanogaster/ensembl/Drosophila_melanogaster.BDGP6.46.dna.toplevel.fa"
Spikein_index="/project/mengjiechen/leizheng/references/Drosophila_melanogaster/ensembl/bowtie2"
current_datetime=$(date "+%Y%m%d%H%M%S")
LOGPATH=$BASEPATH/log

# nextflow clean -f
nextflow -log $LOGPATH/${current_datetime}.log \
        run main.nf \
        --outdir $OUTDIR \
        -work-dir $WORKDIR \
        --input $DATAPATH \
        --macs_gsize 2913022398 \
        --peakcaller macs2 \
        --read_length 150 \
        --blacklist $Blacklist \
        --spikein_fasta $Spikein_fasta \
        --spikein_bowtie2 $Spikein_index \
        --save_reference \
        --use_control 'false' \
        --fasta $FASTA \
        --gtf $GTF \
        -profile singularity \
        -resume \
	-bg

