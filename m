Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F5348A56D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 03:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346505AbiAKCEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 21:04:31 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:59312 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344038AbiAKCE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 21:04:28 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1n76WI-0004ju-QP; Tue, 11 Jan 2022 13:04:19 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 11 Jan 2022 13:04:19 +1100
Date:   Tue, 11 Jan 2022 13:04:19 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Update for 5.17
Message-ID: <Ydzlo+UmL5bbDgUZ@gondor.apana.org.au>
References: <20200803044024.GA6429@gondor.apana.org.au>
 <20201012033249.GA25179@gondor.apana.org.au>
 <20201214055515.GA14196@gondor.apana.org.au>
 <20210215024721.GA20593@gondor.apana.org.au>
 <20210426123200.kgbyk6ayey4l4lrw@gondor.apana.org.au>
 <20210628110050.GA12162@gondor.apana.org.au>
 <20210830082818.GA30921@gondor.apana.org.au>
 <20211102035201.GA23331@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211102035201.GA23331@gondor.apana.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus:

This update includes the following changes:

Algorithms:

- Drop alignment requirement for data in aesni.
- Use synchronous seeding from the /dev/random in DRBG.
- Reseed nopr DRBGs every 5 minutes from /dev/random.
- Add KDF algorithms currently used by security/DH.
- Fix lack of entropy on some AMD CPUs with jitter RNG.

Drivers:

- Add support for the D1 variant in sun8i-ce.
- Add SEV_INIT_EX support in ccp.
- PFVF support for GEN4 host driver in qat.
- Compression support for GEN4 devices in qat.
- Add cn10k random number generator support.

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus 

for you to fetch changes up to 5f21d7d283dd82865bdb0123795b3accf0d42b67:

  crypto: af_alg - rewrite NULL pointer check (2022-01-07 14:30:01 +1100)

----------------------------------------------------------------
Andy Shevchenko (1):
      crypto: api - Replace kernel.h with the necessary inclusions

Chengfeng Ye (3):
      crypto: qce - fix uaf on qce_aead_register_one
      crypto: qce - fix uaf on qce_ahash_register_one
      crypto: qce - fix uaf on qce_skcipher_register_one

Christophe JAILLET (1):
      crypto: ccree - remove redundant 'flush_workqueue()' calls

Colin Ian King (1):
      crypto: x86/des3 - remove redundant assignment of variable nbytes

Corentin Labbe (2):
      crypto: sun8i-ce - Add support for the D1 variant
      crypto: omap - increase priority of DES/3DES

Dan Carpenter (3):
      crypto: octeontx2 - uninitialized variable in kvf_limits_store()
      crypto: octeontx2 - out of bounds access in otx2_cpt_dl_custom_egrp_delete()
      crypto: octeontx2 - prevent underflow in get_cores_bmap()

David Rientjes (1):
      crypto: ccp - Add SEV_INIT_EX support

Etienne Carriere (2):
      crypto: stm32/cryp - defer probe for reset controller
      crypto: stm32/cryp - don't print error on probe deferral

Gaurav Jain (1):
      crypto: caam - save caam memory to support crypto engine retry mechanism.

Geert Uytterhoeven (1):
      crypto: sa2ul - Use bitfield helpers

Giovanni Cabiddu (13):
      crypto: qat - do not handle PFVF sources for qat_4xxx
      crypto: qat - fix undetected PFVF timeout in ACK loop
      crypto: qat - move vf2pf interrupt helpers
      crypto: qat - change PFVF ACK behaviour
      crypto: qat - re-enable interrupts for legacy PFVF messages
      crypto: qat - relocate PFVF disabled function
      crypto: qat - abstract PFVF receive logic
      crypto: qat - get compression extended capabilities
      crypto: qat - set CIPHER capability for QAT GEN2
      crypto: qat - set COMPRESSION capability for QAT GEN2
      crypto: qat - extend crypto capability detection for 4xxx
      crypto: qat - allow detection of dc capabilities for 4xxx
      crypto: qat - fix definition of ring reset results

Guo Zhengkui (1):
      crypto: dh - remove duplicate includes

Gustavo A. R. Silva (2):
      crypto: cavium - Use kcalloc() instead of kzalloc()
      crypto: marvell/octeontx - Use kcalloc() instead of kzalloc()

Heiner Kallweit (1):
      crypto: omap-aes - Fix broken pm_runtime_and_get() usage

Herbert Xu (1):
      crypto: stm32 - Revert broken pm_runtime_resume_and_get changes

Jakub Kicinski (1):
      crypto: x86/aesni - don't require alignment of data

Jason A. Donenfeld (1):
      crypto: x86/curve25519 - use in/out register constraints more precisely

Jason Wang (1):
      crypto: ccp - no need to initialise statics to 0

Jiapeng Chong (1):
      crypto: octeontx2 - Use swap() instead of swap_engines()

Jiasheng Jiang (1):
      crypto: af_alg - rewrite NULL pointer check

Kai Ye (5):
      crypto: hisilicon - modify the value of engine type rate
      crypto: hisilicon/qm - modify the value of qos initialization
      crypto: hisilicon/qm - some optimizations of ths qos write process
      crypto: hisilicon/qm - simplified the calculation of qos shaper parameters
      MAINTAINERS: update SEC2 driver maintainers list

Lad Prabhakar (1):
      crypto: ux500 - Use platform_get_irq() to get the interrupt

Lei He (1):
      crypto: testmgr - Fix wrong test case of RSA

Lukas Bulwahn (1):
      MAINTAINERS: rectify entry for INTEL KEEM BAY OCS ECC CRYPTO DRIVER

Marco Chiappero (36):
      crypto: qat - refactor PF top half for PFVF
      crypto: qat - move VF message handler to adf_vf2pf_msg.c
      crypto: qat - move interrupt code out of the PFVF handler
      crypto: qat - split PFVF message decoding from handling
      crypto: qat - handle retries due to collisions in adf_iov_putmsg()
      crypto: qat - relocate PFVF PF related logic
      crypto: qat - relocate PFVF VF related logic
      crypto: qat - add pfvf_ops
      crypto: qat - differentiate between pf2vf and vf2pf offset
      crypto: qat - abstract PFVF send function
      crypto: qat - reorganize PFVF code
      crypto: qat - reorganize PFVF protocol definitions
      crypto: qat - use enums for PFVF protocol codes
      crypto: qat - pass the PF2VF responses back to the callers
      crypto: qat - refactor pfvf version request messages
      crypto: qat - do not rely on min version
      crypto: qat - fix VF IDs in PFVF log messages
      crypto: qat - improve logging of PFVF messages
      crypto: qat - support the reset of ring pairs on PF
      crypto: qat - add the adf_get_pmisc_base() helper function
      crypto: qat - make PFVF message construction direction agnostic
      crypto: qat - make PFVF send and receive direction agnostic
      crypto: qat - set PFVF_MSGORIGIN just before sending
      crypto: qat - abstract PFVF messages with struct pfvf_message
      crypto: qat - leverage bitfield.h utils for PFVF messages
      crypto: qat - leverage read_poll_timeout in PFVF send
      crypto: qat - improve the ACK timings in PFVF send
      crypto: qat - store the PFVF protocol version of the endpoints
      crypto: qat - store the ring-to-service mapping
      crypto: qat - introduce support for PFVF block messages
      crypto: qat - exchange device capabilities over PFVF
      crypto: qat - support fast ACKs in the PFVF protocol
      crypto: qat - exchange ring-to-service mappings over PFVF
      crypto: qat - config VFs based on ring-to-svc mapping
      crypto: qat - add PFVF support to the GEN4 host driver
      crypto: qat - add PFVF support to enable the reset of ring pairs

Marek Vasut (1):
      crypto: stm32/crc32 - Fix kernel BUG triggered in probe()

Meng Li (1):
      crypto: caam - replace this_cpu_ptr with raw_cpu_ptr

Nicolai Stange (9):
      crypto: drbg - prepare for more fine-grained tracking of seeding state
      crypto: drbg - track whether DRBG was seeded with !rng_is_initialized()
      crypto: drbg - move dynamic ->reseed_threshold adjustments to __drbg_seed()
      crypto: drbg - make reseeding from get_random_bytes() synchronous
      crypto: drbg - make drbg_prepare_hrng() handle jent instantiation errors
      crypto: drbg - reseed 'nopr' drbgs periodically from get_random_bytes()
      crypto: drbg - ignore jitterentropy errors if not in FIPS mode
      crypto: jitter - don't limit ->health_failure check to FIPS mode
      crypto: jitter - quit sample collection loop upon RCT failure

Nicolas Toromanoff (7):
      crypto: stm32/cryp - fix CTR counter carry
      crypto: stm32/cryp - fix xts and race condition in crypto_engine requests
      crypto: stm32/cryp - check early input data
      crypto: stm32/cryp - fix double pm exit
      crypto: stm32/cryp - fix lrw chaining mode
      crypto: stm32/cryp - fix bugs and crash in tests
      crypto: stm32/cryp - reorder hw initialization

Pankaj Gupta (1):
      MAINTAINERS: update caam crypto driver maintainers list

Peter Gonda (4):
      crypto: ccp - Add SEV_INIT rc error logging on init
      crypto: ccp - Move SEV_INIT retry for corrupted data
      crypto: ccp - Refactor out sev_fw_alloc()
      crypto: ccp - Add psp_init_on_probe module parameter

Srujana Challa (2):
      crypto: octeontx2 - add apis for custom engine groups
      crypto: octeontx2 - parameters for custom engine groups

Stephan Müller (10):
      crypto: kdf - Add key derivation self-test support code
      crypto: kdf - add SP800-108 counter key derivation function
      security: DH - remove dead code for zero padding
      security: DH - use KDF implementation from crypto API
      crypto: jitter - consider 32 LSB for APT
      crypto: rsa - limit key size to 2048 in FIPS mode
      crypto: dh - limit key size to 2048 in FIPS mode
      crypto: des - disallow des3 in FIPS mode
      crypto: jitter - add oversampling of noise source
      crypto: kdf - select SHA-256 required for self-test

Sunil Goutham (2):
      hwrng: cavium - Check health status while reading random data
      hwrng: cn10k - Add random number generator support

Tianjia Zhang (5):
      crypto: sha256 - remove duplicate generic hash init function
      crypto: mips/sha - remove duplicate hash init function
      crypto: powerpc/sha - remove duplicate hash init function
      crypto: sparc/sha - remove duplicate hash init function
      crypto: s390/sha512 - Use macros instead of direct IV numbers

Tom Rix (1):
      crypto: hisilicon - cleanup warning in qm_get_qos_value()

Tomasz Kowalik (1):
      crypto: qat - add support for compression for 4xxx

Tudor Ambarus (1):
      crypto: atmel-aes - Reestablish the correct tfm context at dequeue

Wei Yongjun (1):
      crypto: keembay-ocs-ecc - Fix error return code in kmb_ocs_ecc_probe()

Weili Qian (9):
      crypto: hisilicon/qm - fix incorrect return value of hisi_qm_resume()
      crypto: hisilicon/hpre - fix memory leak in hpre_curve25519_src_init()
      crypto: hisilicon/qm - remove unnecessary device memory reset
      crypto: hisilicon/qm - code movement
      crypto: hisilicon/qm - modify the handling method after abnormal interruption
      crypto: hisilicon/qm - use request_threaded_irq instead
      crypto: hisilicon/qm - reset function if event queue overflows
      crypto: hisilicon/qm - disable queue when 'CQ' error
      crypto: hisilicon/qm - disable qm clock-gating

Yang Guang (1):
      crypto: hisilicon/hpre - use swap() to make code cleaner

Yang Li (1):
      crypto: ccp - remove unneeded semicolon

Yang Shen (3):
      crypto: hisilicon/zip - enable ssid for sva sgl
      crypto: hisilicon/qm - fix deadlock for remove driver
      crypto: hisilicon/zip - add new algorithms for uacce device

Zizhuang Deng (1):
      lib/mpi: Add the return value check of kcalloc()

chiminghao (1):
      crypto: octeontx2 - use swap() to make code cleaner

 Documentation/virt/kvm/amd-memory-encryption.rst   |   6 +
 MAINTAINERS                                        |   3 +-
 arch/mips/cavium-octeon/crypto/octeon-sha1.c       |  17 +-
 arch/mips/cavium-octeon/crypto/octeon-sha256.c     |  39 +-
 arch/mips/cavium-octeon/crypto/octeon-sha512.c     |  39 +-
 arch/powerpc/crypto/sha1-spe-glue.c                |  17 +-
 arch/powerpc/crypto/sha1.c                         |  14 +-
 arch/powerpc/crypto/sha256-spe-glue.c              |  39 +-
 arch/s390/crypto/sha512_s390.c                     |  32 +-
 arch/sparc/crypto/sha1_glue.c                      |  14 +-
 arch/sparc/crypto/sha256_glue.c                    |  37 +-
 arch/sparc/crypto/sha512_glue.c                    |  37 +-
 arch/x86/crypto/aesni-intel_glue.c                 |   4 +-
 arch/x86/crypto/curve25519-x86_64.c                | 767 ++++++++++------
 arch/x86/crypto/des3_ede_glue.c                    |   4 +-
 crypto/Kconfig                                     |   4 +
 crypto/Makefile                                    |   5 +
 crypto/af_alg.c                                    |   7 +-
 crypto/dh.c                                        |   5 +-
 crypto/drbg.c                                      | 150 ++--
 crypto/jitterentropy-kcapi.c                       |   6 -
 crypto/jitterentropy.c                             |  32 +-
 crypto/jitterentropy.h                             |   1 -
 crypto/kdf_sp800108.c                              | 153 ++++
 crypto/rsa.c                                       |   4 +
 crypto/sha256_generic.c                            |  16 +-
 crypto/testmgr.c                                   |   9 -
 crypto/testmgr.h                                   |   6 +-
 drivers/char/hw_random/Kconfig                     |  13 +-
 drivers/char/hw_random/Makefile                    |   1 +
 drivers/char/hw_random/cavium-rng-vf.c             | 194 +++-
 drivers/char/hw_random/cavium-rng.c                |  11 +-
 drivers/char/hw_random/cn10k-rng.c                 | 181 ++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c  |  21 +
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h       |   1 +
 drivers/crypto/atmel-aes.c                         |   6 +-
 drivers/crypto/caam/caamalg.c                      |   6 +
 drivers/crypto/caam/caamalg_qi2.c                  |   2 +-
 drivers/crypto/caam/caamhash.c                     |   3 +
 drivers/crypto/caam/caampkc.c                      |   3 +
 drivers/crypto/cavium/cpt/cptvf_main.c             |   5 +-
 drivers/crypto/ccp/ccp-dev.c                       |   2 +-
 drivers/crypto/ccp/sev-dev.c                       | 259 +++++-
 drivers/crypto/ccree/cc_request_mgr.c              |   1 -
 drivers/crypto/hisilicon/hpre/hpre_crypto.c        |   7 +-
 drivers/crypto/hisilicon/hpre/hpre_main.c          |   2 +-
 drivers/crypto/hisilicon/qm.c                      | 483 ++++++----
 drivers/crypto/hisilicon/sec2/sec_main.c           |   2 +-
 drivers/crypto/hisilicon/zip/zip_main.c            |  12 +-
 drivers/crypto/keembay/keembay-ocs-ecc.c           |   1 +
 drivers/crypto/marvell/octeontx/otx_cptvf_main.c   |   4 +-
 drivers/crypto/marvell/octeontx2/Makefile          |   2 +-
 drivers/crypto/marvell/octeontx2/otx2_cpt_common.h |   1 +
 .../crypto/marvell/octeontx2/otx2_cpt_devlink.c    | 108 +++
 .../crypto/marvell/octeontx2/otx2_cpt_devlink.h    |  20 +
 drivers/crypto/marvell/octeontx2/otx2_cptpf.h      |   3 +
 drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c |  18 +-
 .../crypto/marvell/octeontx2/otx2_cptpf_ucode.c    | 315 ++++++-
 .../crypto/marvell/octeontx2/otx2_cptpf_ucode.h    |   7 +-
 drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c |   5 +-
 drivers/crypto/omap-aes.c                          |   2 +-
 drivers/crypto/omap-des.c                          |   8 +-
 drivers/crypto/qat/Kconfig                         |   1 +
 drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c     | 151 +++-
 drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h     |   2 +
 drivers/crypto/qat/qat_4xxx/adf_drv.c              |  33 +
 drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c   |  12 +-
 .../crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c   |  15 +-
 .../crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.h   |   1 -
 drivers/crypto/qat/qat_c3xxxvf/adf_drv.c           |   6 +-
 drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c     |  12 +-
 drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c |  15 +-
 drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.h |   1 -
 drivers/crypto/qat/qat_c62xvf/adf_drv.c            |   6 +-
 drivers/crypto/qat/qat_common/Makefile             |   6 +-
 drivers/crypto/qat/qat_common/adf_accel_devices.h  |  47 +-
 drivers/crypto/qat/qat_common/adf_accel_engine.c   |   8 +-
 drivers/crypto/qat/qat_common/adf_admin.c          |  47 +-
 drivers/crypto/qat/qat_common/adf_cfg.c            |   1 +
 drivers/crypto/qat/qat_common/adf_cfg_common.h     |  13 +
 drivers/crypto/qat/qat_common/adf_cfg_strings.h    |   3 +
 drivers/crypto/qat/qat_common/adf_common_drv.h     |  42 +-
 drivers/crypto/qat/qat_common/adf_gen2_hw_data.c   | 105 +--
 drivers/crypto/qat/qat_common/adf_gen2_hw_data.h   |  22 +-
 drivers/crypto/qat/qat_common/adf_gen2_pfvf.c      | 381 ++++++++
 drivers/crypto/qat/qat_common/adf_gen2_pfvf.h      |  29 +
 drivers/crypto/qat/qat_common/adf_gen4_hw_data.c   |  69 +-
 drivers/crypto/qat/qat_common/adf_gen4_hw_data.h   |  17 +
 drivers/crypto/qat/qat_common/adf_gen4_pfvf.c      | 148 +++
 drivers/crypto/qat/qat_common/adf_gen4_pfvf.h      |  17 +
 drivers/crypto/qat/qat_common/adf_init.c           |  11 +-
 drivers/crypto/qat/qat_common/adf_isr.c            | 111 ++-
 drivers/crypto/qat/qat_common/adf_pf2vf_msg.c      | 416 ---------
 drivers/crypto/qat/qat_common/adf_pf2vf_msg.h      |  93 --
 drivers/crypto/qat/qat_common/adf_pfvf_msg.h       | 259 ++++++
 drivers/crypto/qat/qat_common/adf_pfvf_pf_msg.c    |  52 ++
 drivers/crypto/qat/qat_common/adf_pfvf_pf_msg.h    |  18 +
 drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.c  | 346 ++++++++
 drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.h  |  13 +
 drivers/crypto/qat/qat_common/adf_pfvf_utils.c     |  65 ++
 drivers/crypto/qat/qat_common/adf_pfvf_utils.h     |  31 +
 drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.c    | 167 ++++
 drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.h    |  23 +
 drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.c  | 368 ++++++++
 drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.h  |  17 +
 drivers/crypto/qat/qat_common/adf_sriov.c          |  59 +-
 drivers/crypto/qat/qat_common/adf_vf2pf_msg.c      |  48 -
 drivers/crypto/qat/qat_common/adf_vf_isr.c         | 106 +--
 .../crypto/qat/qat_common/icp_qat_fw_init_admin.h  |   4 +-
 drivers/crypto/qat/qat_common/icp_qat_hw.h         |  13 +-
 drivers/crypto/qat/qat_common/qat_crypto.c         |  25 +
 drivers/crypto/qat/qat_common/qat_hal.c            |  41 +-
 .../crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c |  44 +-
 .../crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.h |   2 +
 .../qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c    |  15 +-
 .../qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.h    |   1 -
 drivers/crypto/qat/qat_dh895xccvf/adf_drv.c        |   6 +-
 drivers/crypto/qce/aead.c                          |   2 +-
 drivers/crypto/qce/sha.c                           |   2 +-
 drivers/crypto/qce/skcipher.c                      |   2 +-
 drivers/crypto/sa2ul.c                             |  19 +-
 drivers/crypto/stm32/stm32-crc32.c                 |   4 +-
 drivers/crypto/stm32/stm32-cryp.c                  | 988 +++++++++------------
 drivers/crypto/stm32/stm32-hash.c                  |   6 +-
 drivers/crypto/ux500/cryp/cryp.h                   |   2 +
 drivers/crypto/ux500/cryp/cryp_core.c              |  26 +-
 include/crypto/aead.h                              |   4 +-
 include/crypto/algapi.h                            |   5 +-
 include/crypto/blake2b.h                           |   1 -
 include/crypto/blake2s.h                           |   2 +-
 include/crypto/cryptd.h                            |   3 +-
 include/crypto/drbg.h                              |  11 +-
 include/crypto/engine.h                            |   6 +-
 include/crypto/internal/kdf_selftest.h             |  71 ++
 include/crypto/kdf_sp800108.h                      |  61 ++
 include/crypto/pcrypt.h                            |   2 +-
 include/crypto/scatterwalk.h                       |   3 +-
 include/crypto/skcipher.h                          |   6 +-
 include/linux/psp-sev.h                            |  21 +
 lib/mpi/mpi-mod.c                                  |   2 +
 security/keys/Kconfig                              |   2 +-
 security/keys/dh.c                                 | 130 +--
 142 files changed, 5484 insertions(+), 2637 deletions(-)
 create mode 100644 crypto/kdf_sp800108.c
 create mode 100644 drivers/char/hw_random/cn10k-rng.c
 create mode 100644 drivers/crypto/marvell/octeontx2/otx2_cpt_devlink.c
 create mode 100644 drivers/crypto/marvell/octeontx2/otx2_cpt_devlink.h
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen2_pfvf.c
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen2_pfvf.h
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen4_pfvf.c
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen4_pfvf.h
 delete mode 100644 drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
 delete mode 100644 drivers/crypto/qat/qat_common/adf_pf2vf_msg.h
 create mode 100644 drivers/crypto/qat/qat_common/adf_pfvf_msg.h
 create mode 100644 drivers/crypto/qat/qat_common/adf_pfvf_pf_msg.c
 create mode 100644 drivers/crypto/qat/qat_common/adf_pfvf_pf_msg.h
 create mode 100644 drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.c
 create mode 100644 drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.h
 create mode 100644 drivers/crypto/qat/qat_common/adf_pfvf_utils.c
 create mode 100644 drivers/crypto/qat/qat_common/adf_pfvf_utils.h
 create mode 100644 drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.c
 create mode 100644 drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.h
 create mode 100644 drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.c
 create mode 100644 drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.h
 delete mode 100644 drivers/crypto/qat/qat_common/adf_vf2pf_msg.c
 create mode 100644 include/crypto/internal/kdf_selftest.h
 create mode 100644 include/crypto/kdf_sp800108.h

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
