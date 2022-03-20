Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EBD4E1E4C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 00:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343827AbiCTXoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 19:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbiCTXoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 19:44:10 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39D45D18B;
        Sun, 20 Mar 2022 16:42:43 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nW5Bz-0003PC-Nu; Mon, 21 Mar 2022 10:42:36 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 21 Mar 2022 11:42:35 +1200
Date:   Mon, 21 Mar 2022 11:42:35 +1200
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Update for 5.18
Message-ID: <Yje766s7fIqYg1Tk@gondor.apana.org.au>
References: <20200803044024.GA6429@gondor.apana.org.au>
 <20201012033249.GA25179@gondor.apana.org.au>
 <20201214055515.GA14196@gondor.apana.org.au>
 <20210215024721.GA20593@gondor.apana.org.au>
 <20210426123200.kgbyk6ayey4l4lrw@gondor.apana.org.au>
 <20210628110050.GA12162@gondor.apana.org.au>
 <20210830082818.GA30921@gondor.apana.org.au>
 <20211102035201.GA23331@gondor.apana.org.au>
 <Ydzlo+UmL5bbDgUZ@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ydzlo+UmL5bbDgUZ@gondor.apana.org.au>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus:

This update includes the following changes:

API:

- hwrng core now credits for low-quality RNG devices.

Algorithms:

- Optimisations for neon aes on arm/arm64.
- Add accelerated crc32_be on arm64.
- Add ffdheXYZ(dh) templates.
- Disallow hmac keys < 112 bits in FIPS mode.
- Add AVX assembly implementation for sm3 on x86.

Drivers:

- Add missing local_bh_disable calls for crypto_engine callback.
- Ensure BH is disabled in crypto_engine callback path.
- Fix zero length DMA mappings in ccree.
- Add synchronization between mailbox accesses in octeontx2.
- Add Xilinx SHA3 driver.
- Add support for the TDES IP available on sama7g5 SoC in atmel.

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus 

for you to fetch changes up to 0e03b8fd29363f2df44e2a7a176d486de550757a:

  crypto: xilinx - Turn SHA into a tristate and allow COMPILE_TEST (2022-03-14 14:45:45 +1200)

----------------------------------------------------------------
Andy Shevchenko (2):
      crypto: qat - don't cast parameter in bit operations
      crypto: cavium/nitrox - don't cast parameter in bit operations

Ard Biesheuvel (8):
      crypto: memneq - avoid implicit unaligned accesses
      crypto: arm64/aes-neon-ctr - improve handling of single tail block
      crypto: arm/aes-neonbs-ctr - deal with non-multiples of AES block size
      crypto: arm64/aes-neonbs-ctr - fallback to plain NEON for final chunk
      crypto: arm64/aes-neonbs-xts - use plain NEON for non-power-of-2 input sizes
      lib/xor: make xor prototypes more friendly to compiler vectorization
      crypto: arm/xor - make vectorized C code Clang-friendly
      crypto: crypto_xor - use helpers for unaligned accesses

Claudiu Beznea (7):
      hwrng: atmel - add wait for ready support on read
      hwrng: atmel - disable trng on failure path
      hwrng: atmel - rename enable/disable functions to init/cleanup
      hwrng: atmel - move set of TRNG_HALFR in atmel_trng_init()
      hwrng: atmel - use __maybe_unused and pm_ptr() for pm ops
      hwrng: atmel - add runtime pm support
      hwrng: atmel - remove extra line

Colin Ian King (2):
      crypto: marvell/octeontx - remove redundant initialization of variable c_size
      crypto: sl3516 - remove redundant initializations of pointers in_sg and out_sg

Corentin Labbe (10):
      crypto: sun8i-ss - really disable hash on A80
      crypto: cavium/nitrox - fix typo on crypto
      crypto: rockchip - ECB does not need IV
      crypto: cavium/zip - register algorithm only if hardware is present
      crypto: sun8i-ss - call finalize with bh disabled
      crypto: sun8i-ce - call finalize with bh disabled
      crypto: amlogic - call finalize with bh disabled
      crypto: gemini - call finalize with bh disabled
      crypto: engine - check if BH is disabled during completion
      crypto: xilinx: prevent probing on non-xilinx hardware

Dan Carpenter (1):
      crypto: qat - fix a signedness bug in get_service_enabled()

Dominik Brodowski (10):
      hwrng: core - explicit ordering of initcalls
      hwrng: core - read() callback must be called for size of 32 or more bytes
      hwrng: core - use rng_fillbuf in add_early_randomness()
      hwrng: core - only set cur_rng_set_by_user if it is working
      hwrng: core - break out of hwrng_fillfn if current rng is not trusted
      hwrng: core - credit entropy for low quality sources of randomness
      hwrng: core - do not bother to order list of devices by quality
      hwrng: core - start and stop in-kernel rngd in separate function
      hwrng: core - use per-rng quality value instead of global setting
      hwrng: core - introduce rng_quality sysfs attribute

Dāvis Mosāns (1):
      crypto: ccp - ccp_dmaengine_unregister release dma channels

Eric Biggers (5):
      crypto: rsa-pkcs1pad - only allow with rsa
      crypto: rsa-pkcs1pad - correctly get hash from source scatterlist
      crypto: rsa-pkcs1pad - restore signature length check
      crypto: rsa-pkcs1pad - fix buffer overread in pkcs1pad_verify_complete()
      crypto: rsa-pkcs1pad - use clearer variable names

Geert Uytterhoeven (1):
      hwrng: cavium - HW_RANDOM_CAVIUM should depend on ARCH_THUNDER

Gilad Ben-Yossef (1):
      crypto: ccree - don't attempt 0 len DMA mappings

Giovanni Cabiddu (5):
      crypto: qat - fix access to PFVF interrupt registers for GEN4
      crypto: qat - disable registration of algorithms
      crypto: qat - remove unneeded assignment
      crypto: qat - fix initialization of pfvf cap_msg structures
      crypto: qat - fix initialization of pfvf rts_map_msg structures

Harman Kalra (1):
      crypto: octeontx2 - add synchronization between mailbox accesses

Harsha (4):
      crypto: xilinx - Updated Makefile for xilinx subdirectory
      firmware: xilinx: Add ZynqMP SHA API for SHA3 functionality
      crypto: xilinx - Add Xilinx SHA3 driver
      MAINTAINERS: Add maintainer for Xilinx ZynqMP SHA3 driver

Herbert Xu (6):
      crypto: testmgr - Move crypto_simd_disabled_for_test out
      crypto: kdf - Select hmac in addition to sha256
      crypto: authenc - Fix sleep in atomic context in decrypt_tail
      crypto: xts - Add softdep on ecb
      crypto: lrw - Add dependency on ecb
      crypto: xilinx - Turn SHA into a tristate and allow COMPILE_TEST

Jianglei Nie (1):
      crypto: ccree - Fix use after free in cc_cipher_exit()

Jiapeng Chong (2):
      crypto: marvell/octeontx - Use swap() instead of open coding it
      crypto: dh - Remove the unused function dh_safe_prime_dh_alg()

Julia Lawall (1):
      crypto: ux500 - use GFP_KERNEL

Kai Ye (14):
      Documentation: use the tabs on all acc documentation
      Documentation: update debugfs doc for Hisilicon SEC
      Documentation: update debugfs doc for Hisilicon ZIP
      Documentation: update debugfs doc for Hisilicon HPRE
      crypto: hisilicon/sec - fixup icv checking enabled on Kunpeng 930
      crypto: hisilicon/sec - add some comments for soft fallback
      crypto: hisilicon/sec - fix the max length of AAD for the CCM mode
      crypto: hisilicon/sec - fix the CTR mode BD configuration
      crypto: hisilicon/sec - use the correct print format
      crypto: hisilicon/qm - cleanup warning in qm_vf_read_qos
      crypto: hisilicon/sec - add the register configuration for HW V3
      crypto: hisilicon/sec - not need to enable sm4 extra mode at HW V3
      crypto: hisilicon/sec - fix the aead software fallback for engine
      crypto: hisilicon/qm - fix memset during queues clearing

Kavyasree Kotagiri (1):
      crypto: atmel - add support for AES and SHA IPs available on lan966x SoC

Kevin Bracey (4):
      lib/crc32: remove unneeded casts
      lib/crc32: Make crc32_be weak for arch override
      lib/crc32test: correct printed bytes count
      arm64: lib: accelerate crc32_be

Longfang Liu (1):
      MAINTAINERS: update HPRE/SEC2/TRNG driver maintainers list

Miaoqian Lin (1):
      hwrng: nomadik - Change clk_disable to clk_disable_unprepare

Minghao Chi (1):
      crypto: ccp - remove redundant ret variable

Nathan Huckleberry (1):
      crypto: x86 - Convert to SPDX identifier

Nicolai Stange (15):
      crypto: kpp - provide support for KPP template instances
      crypto: kpp - provide support for KPP spawns
      crypto: dh - remove struct dh's ->q member
      crypto: dh - constify struct dh's pointer members
      crypto: dh - split out deserialization code from crypto_dh_decode()
      crypto: dh - introduce common code for built-in safe-prime group support
      crypto: dh - implement ffdheXYZ(dh) templates
      crypto: testmgr - add known answer tests for ffdheXYZ(dh) templates
      crypto: dh - implement private key generation primitive for ffdheXYZ(dh)
      crypto: testmgr - add keygen tests for ffdheXYZ(dh) templates
      crypto: dh - allow for passing NULL to the ffdheXYZ(dh)s' ->set_secret()
      crypto: api - allow algs only in specific constructions in FIPS mode
      crypto: dh - disallow plain "dh" usage in FIPS mode
      lib/mpi: export mpi_rshift
      crypto: dh - calculate Q from P for the full public key verification

Peter Gonda (1):
      crypto: ccp - Ensure psp_ret is always init'd in __sev_platform_init_locked()

Petr Vorel (1):
      crypto: vmx - add missing dependencies

Rikard Falkeborn (3):
      crypto: omap-aes - Constify static attribute_group
      crypto: omap-sham - Constify static attribute_group
      crypto: nx - Constify static attribute_group structs

Shijith Thotton (2):
      crypto: octeontx2 - select CONFIG_NET_DEVLINK
      crypto: octeontx2 - remove CONFIG_DM_CRYPT check

Srujana Challa (3):
      crypto: octeontx2 - CN10K CPT to RNM workaround
      crypto: octeontx2 - disable DMA black hole on an DMA fault
      crypto: octeontx2 - increase CPT HW instruction queue length

Stephan Müller (2):
      crypto: hmac - add fips_skip support
      crypto: hmac - disallow keys < 112 bits in FIPS mode

Tianjia Zhang (7):
      crypto: sm3 - create SM3 stand-alone library
      crypto: arm64/sm3-ce - make dependent on sm3 library
      crypto: sm2 - make dependent on sm3 library
      crypto: sm3 - make dependent on sm3 library
      crypto: x86/sm3 - add AVX assembly implementation
      crypto: tcrypt - add asynchronous speed test for SM3
      crypto: tcrypt - remove all multibuffer ahash tests

Tom Rix (2):
      crypto: cleanup comments
      crypto: arm64 - cleanup comments

Tomas Paukrt (1):
      crypto: mxs-dcp - Fix scatterlist processing

Tudor Ambarus (1):
      crypto: atmel-tdes - Add support for the TDES IP available on sama7g5 SoC

Wan Jiabing (1):
      hwrng: cavium - fix NULL but dereferenced coccicheck error

Wojciech Ziemba (3):
      crypto: qat - add misc workqueue
      crypto: qat - move and rename GEN4 error register definitions
      crypto: qat - enable power management for QAT GEN4

Yang Yingliang (1):
      crypto: octeontx2 - fix missing unlock

YueHaibing (2):
      crypto: x86/blowfish - Remove unused inline functions
      crypto: x86/des3 - Remove unused inline function des3_ede_enc_blk_3way()

Yury Norov (1):
      padata: replace cpumask_weight with cpumask_empty in padata.c

 Documentation/ABI/testing/debugfs-hisi-hpre        |  178 +--
 Documentation/ABI/testing/debugfs-hisi-sec         |  146 +-
 Documentation/ABI/testing/debugfs-hisi-zip         |  146 +-
 MAINTAINERS                                        |   11 +-
 arch/alpha/include/asm/xor.h                       |   53 +-
 arch/arm/crypto/aes-neonbs-core.S                  |  105 +-
 arch/arm/crypto/aes-neonbs-glue.c                  |   35 +-
 arch/arm/include/asm/xor.h                         |   42 +-
 arch/arm/lib/xor-neon.c                            |   12 +-
 arch/arm64/crypto/Kconfig                          |    2 +-
 arch/arm64/crypto/aes-glue.c                       |   22 +-
 arch/arm64/crypto/aes-modes.S                      |   18 +-
 arch/arm64/crypto/aes-neonbs-core.S                |  264 +---
 arch/arm64/crypto/aes-neonbs-glue.c                |   97 +-
 arch/arm64/crypto/sha3-ce-glue.c                   |    2 +-
 arch/arm64/crypto/sha512-armv8.pl                  |    2 +-
 arch/arm64/crypto/sha512-ce-glue.c                 |    2 +-
 arch/arm64/crypto/sm3-ce-glue.c                    |   28 +-
 arch/arm64/include/asm/xor.h                       |   21 +-
 arch/arm64/lib/crc32.S                             |   87 +-
 arch/arm64/lib/xor-neon.c                          |   46 +-
 arch/ia64/include/asm/xor.h                        |   21 +-
 arch/powerpc/include/asm/xor_altivec.h             |   25 +-
 arch/powerpc/lib/xor_vmx.c                         |   28 +-
 arch/powerpc/lib/xor_vmx.h                         |   27 +-
 arch/powerpc/lib/xor_vmx_glue.c                    |   32 +-
 arch/s390/lib/xor.c                                |   21 +-
 arch/sparc/include/asm/xor_32.h                    |   21 +-
 arch/sparc/include/asm/xor_64.h                    |   42 +-
 arch/x86/crypto/Makefile                           |    3 +
 arch/x86/crypto/aes_ctrby8_avx-x86_64.S            |   63 +-
 arch/x86/crypto/blowfish_glue.c                    |   12 -
 arch/x86/crypto/des3_ede_glue.c                    |    8 -
 arch/x86/crypto/sm3-avx-asm_64.S                   |  517 +++++++
 arch/x86/crypto/sm3_avx_glue.c                     |  134 ++
 arch/x86/include/asm/xor.h                         |   42 +-
 arch/x86/include/asm/xor_32.h                      |   42 +-
 arch/x86/include/asm/xor_avx.h                     |   21 +-
 crypto/Kconfig                                     |   25 +-
 crypto/algapi.c                                    |   48 +-
 crypto/api.c                                       |   19 +-
 crypto/asymmetric_keys/signature.c                 |    2 +-
 crypto/asymmetric_keys/x509_parser.h               |    2 +-
 crypto/async_tx/async_xor.c                        |    8 +-
 crypto/async_tx/raid6test.c                        |    4 +-
 crypto/authenc.c                                   |    2 +-
 crypto/cfb.c                                       |    2 +-
 crypto/crypto_engine.c                             |    1 +
 crypto/dh.c                                        |  681 ++++++++-
 crypto/dh_helper.c                                 |   42 +-
 crypto/hmac.c                                      |    4 +
 crypto/kpp.c                                       |   29 +
 crypto/lrw.c                                       |    1 +
 crypto/memneq.c                                    |   22 +-
 crypto/rsa-pkcs1pad.c                              |   38 +-
 crypto/sm2.c                                       |   40 +-
 crypto/sm3_generic.c                               |  142 +-
 crypto/tcrypt.c                                    |  226 +--
 crypto/testmgr.c                                   |   67 +-
 crypto/testmgr.h                                   | 1456 +++++++++++++++++++-
 crypto/xts.c                                       |    1 +
 drivers/char/hw_random/Kconfig                     |    2 +-
 drivers/char/hw_random/atmel-rng.c                 |  148 +-
 drivers/char/hw_random/cavium-rng-vf.c             |    2 +-
 drivers/char/hw_random/core.c                      |  161 ++-
 drivers/char/hw_random/nomadik-rng.c               |    4 +-
 drivers/crypto/Kconfig                             |   10 +
 drivers/crypto/Makefile                            |    2 +-
 .../crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c    |    3 +
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c  |    3 +
 .../crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c    |    3 +
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c  |    2 +
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c  |    3 +
 drivers/crypto/amlogic/amlogic-gxl-cipher.c        |    2 +
 drivers/crypto/atmel-aes.c                         |    1 +
 drivers/crypto/atmel-sha.c                         |    1 +
 drivers/crypto/atmel-tdes.c                        |    1 +
 drivers/crypto/cavium/nitrox/nitrox_mbx.c          |    8 +-
 drivers/crypto/cavium/nitrox/nitrox_req.h          |    2 +-
 drivers/crypto/cavium/zip/zip_main.c               |   83 +-
 drivers/crypto/ccp/ccp-crypto-aes.c                |    5 +-
 drivers/crypto/ccp/ccp-dmaengine.c                 |   16 +
 drivers/crypto/ccp/sev-dev.c                       |    2 +-
 drivers/crypto/ccree/cc_buffer_mgr.c               |    7 +
 drivers/crypto/ccree/cc_cipher.c                   |    2 +-
 drivers/crypto/gemini/sl3516-ce-cipher.c           |    6 +-
 drivers/crypto/hisilicon/qm.c                      |    4 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.c         |   43 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.h         |    6 +-
 drivers/crypto/hisilicon/sec2/sec_main.c           |   59 +-
 drivers/crypto/marvell/Kconfig                     |    1 +
 drivers/crypto/marvell/octeontx/otx_cptvf_algs.c   |    5 +-
 drivers/crypto/marvell/octeontx/otx_cptvf_main.c   |    1 -
 drivers/crypto/marvell/octeontx2/otx2_cpt_common.h |    1 +
 .../marvell/octeontx2/otx2_cpt_mbox_common.c       |   14 +
 drivers/crypto/marvell/octeontx2/otx2_cptlf.h      |   19 +-
 drivers/crypto/marvell/octeontx2/otx2_cptpf.h      |    1 +
 drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c |   25 +-
 drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c |   27 +-
 .../crypto/marvell/octeontx2/otx2_cptpf_ucode.c    |   56 +-
 drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c |   17 +-
 drivers/crypto/mxs-dcp.c                           |    2 +-
 drivers/crypto/nx/nx-common-pseries.c              |    4 +-
 drivers/crypto/omap-aes.c                          |    2 +-
 drivers/crypto/omap-sham.c                         |    2 +-
 drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c     |   23 +-
 drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h     |   24 -
 drivers/crypto/qat/qat_4xxx/adf_drv.c              |    7 +
 drivers/crypto/qat/qat_common/Makefile             |    1 +
 drivers/crypto/qat/qat_common/adf_accel_devices.h  |    2 +
 drivers/crypto/qat/qat_common/adf_admin.c          |   37 +
 drivers/crypto/qat/qat_common/adf_common_drv.h     |    4 +
 drivers/crypto/qat/qat_common/adf_ctl_drv.c        |    6 +
 drivers/crypto/qat/qat_common/adf_gen4_hw_data.h   |   14 +
 drivers/crypto/qat/qat_common/adf_gen4_pfvf.c      |   42 +-
 drivers/crypto/qat/qat_common/adf_gen4_pm.c        |  137 ++
 drivers/crypto/qat/qat_common/adf_gen4_pm.h        |   44 +
 drivers/crypto/qat/qat_common/adf_init.c           |    6 +
 drivers/crypto/qat/qat_common/adf_isr.c            |   42 +
 drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.c    |    4 +-
 .../crypto/qat/qat_common/icp_qat_fw_init_admin.h  |    1 +
 drivers/crypto/qat/qat_common/qat_crypto.c         |    7 +
 drivers/crypto/qat/qat_common/qat_uclo.c           |    9 +-
 drivers/crypto/rockchip/rk3288_crypto_skcipher.c   |    1 -
 drivers/crypto/ux500/cryp/cryp_core.c              |    2 +-
 drivers/crypto/ux500/hash/hash_core.c              |    2 +-
 drivers/crypto/vmx/Kconfig                         |    4 +
 drivers/crypto/xilinx/Makefile                     |    1 +
 drivers/crypto/xilinx/zynqmp-sha.c                 |  264 ++++
 drivers/firmware/xilinx/zynqmp.c                   |   26 +
 .../net/ethernet/marvell/octeontx2/af/rvu_cpt.c    |    1 +
 include/asm-generic/xor.h                          |   84 +-
 include/crypto/algapi.h                            |   10 +-
 include/crypto/dh.h                                |   26 +-
 include/crypto/internal/kpp.h                      |  158 +++
 include/crypto/sm3.h                               |   34 +-
 include/linux/crypto.h                             |    9 +
 include/linux/firmware/xlnx-zynqmp.h               |    8 +
 include/linux/raid/xor.h                           |   21 +-
 kernel/padata.c                                    |    2 +-
 lib/crc32.c                                        |   14 +-
 lib/crc32test.c                                    |    2 +-
 lib/crypto/Kconfig                                 |    3 +
 lib/crypto/Makefile                                |    3 +
 lib/crypto/sm3.c                                   |  246 ++++
 lib/mpi/mpi-bit.c                                  |    1 +
 security/keys/dh.c                                 |    2 +-
 147 files changed, 5673 insertions(+), 1669 deletions(-)
 create mode 100644 arch/x86/crypto/sm3-avx-asm_64.S
 create mode 100644 arch/x86/crypto/sm3_avx_glue.c
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen4_pm.c
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen4_pm.h
 create mode 100644 drivers/crypto/xilinx/zynqmp-sha.c
 create mode 100644 lib/crypto/sm3.c

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
