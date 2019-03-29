FROM condaforge/linux-anvil:root


MAINTAINER Michael Burgess <jburgess@mpe.mpg.de>

USER root
ENV USER='root'


ENV CHANNELS="-c conda-forge -c fermi -c threeML"
# Install conda packages and build externals
ENV PATH=/opt/conda/bin:${PATH}


# First, let's build the meta package
# This downloads all packages as specified into recipe/meta.yaml
RUN conda build ${CHANNELS} recipe --python=2.7 && \
    conda create -y --name threeML_env ${CHANNELS}   python \
     pip \
     algopy \
     astropy \
     astroquery \
     blas \
     boost=1.63 \
#     boostcpp \
     corner=2.0.* \
     cppzmq=4.3.* \
     dill=0.2.* \
     emcee=2.2.* \
     fermipy \
     gsl=2.2.* \
     hdf5=1.8.* \
     healpix_cxx=3.31 \
     healpy \
     iminuit=1.3.* \
     ipyparallel=6.2.* \
     ipython=5.8.* \
     ipywidgets=7.4.* \
     jupyter \
     jupyterthemes \
     autopep8 \
     jupyter_nbextensions_configurator \
     matplotlib=2.1.* \
     mpi=1.0.* \
     multinest=3.10.* \
     nlopt=2.4.* \
     numba=0.40.* \
     numdifftools=0.9.* \
     numexpr=2.6.* \
     numpy=1.12.* \
     pandas=0.23.* \
     py=1.7.* \
     pygmo=2.4.* \
     pymultinest=2.6.* \
     pytables=3.4.* \
     pytest=3.6.* \
     pyyaml=3.13.* \
     requests=2.21.* \
     reproject=0.4.* \
     root5=5.34.38.* \
     root_numpy \
     scipy=0.19.* \
     speclite=0.7.* \
     uncertainties=3.0.* \
     zeromq=4.2.* \
     fermitools \
     threeml root5 xspec-modelsonly && \
     mkdir /workdir && source activate threeML_env \
     && python -c "from GtBurst.updater import update; update()" && \
     conda clean --all && echo "source activate threeML_env" > ~/.bashrc



RUN source activate threeML_env
ENV MPLBACKEND='Agg'
#ENV PATH="${CONDA_PREFIX}/lib/python2.7/site-packages/fermitools/GtBurst/commands/:${PATH}"


CMD ["usleep 10  && export PATH=${CONDA_PREFIX}/lib/python2.7/site-packages/fermitools/GtBurst/commands/:${PATH} && python -c 'from GtBurst.updater import update; update()'  &&  jupyter notebook --notebook-dir=/workdir --ip='0.0.0.0' --port=8888 --no-browser --allow-root"]
ENTRYPOINT ["/bin/bash","--login","-c"]

