FROM ubuntu:16.04
MAINTAINER volcano <maintainer@volcano.sh>
RUN  apt-get update --fix-missing \
     && apt-get install -y libopenmpi-dev openmpi-bin openmpi-common\
     && apt-get install -y git \
     && apt-get install -y make \
     && apt-get install -y build-essential \
     && apt-get install -y ssh \
     && apt-get install -y vim \
     && apt-get install -y wget \
     && apt-get install -y gcc \
     && apt-get install -y g++ \
     && apt-get install -y libfftw3-dev \
     && apt-get install -y libjpeg-dev \
     && apt-get install -y libpng12-dev \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/*

COPY lammps-3Mar20.tar.gz /
RUN tar -zxf /lammps-3Mar20.tar.gz && \
    cd lammps-3Mar20/src && \
    cp MAKE/MACHINES/Makefile.ubuntu MAKE && \
    make package-status && \
    make yes-rigid && \
    make yes-manybody && \
    make yes-kspace && \
    make yes-molecule && \
    make yes-peri && \
    make ubuntu -j4 && \
    rm -rf /lammps-3Mar20.tar.gz
CMD mkdir -p /var/run/sshd; /usr/sbin/sshd;