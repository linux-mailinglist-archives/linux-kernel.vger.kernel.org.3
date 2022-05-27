Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F347535F3E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 13:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350930AbiE0L3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 07:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236784AbiE0L3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 07:29:13 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9498D5BD30;
        Fri, 27 May 2022 04:29:10 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1nuY9N-000a7X-NG; Fri, 27 May 2022 21:29:03 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 May 2022 19:29:02 +0800
Date:   Fri, 27 May 2022 19:29:02 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Fixes for 5.19
Message-ID: <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
References: <20210108035450.GA6191@gondor.apana.org.au>
 <20210708030913.GA32097@gondor.apana.org.au>
 <20210817013601.GA14148@gondor.apana.org.au>
 <20210929023843.GA28594@gondor.apana.org.au>
 <20211029041408.GA3192@gondor.apana.org.au>
 <20211112104815.GA14105@gondor.apana.org.au>
 <YcKz4wHYTe3qlW7L@gondor.apana.org.au>
 <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au>
 <YkUdKiJflWqxBmx5@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YkUdKiJflWqxBmx5@gondor.apana.org.au>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus:

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v5.19-p1 

for you to fetch changes up to e4e62bbc6aba49a5edb3156ec65f6698ff37d228:

  hwrng: omap3-rom - fix using wrong clk_disable() in omap_rom_rng_runtime_resume() (2022-05-20 13:54:45 +0800)

----------------------------------------------------------------
This update includes the following changes:

API:

- Test in-place en/decryption with two sglists in testmgr.
- Fix process vs. softirq race in cryptd.

Algorithms:

- Add arm64 acceleration for sm4.
- Add s390 acceleration for chacha20.

Drivers:

- Add polarfire soc hwrng support in mpsf.
- Add support for TI SoC AM62x in sa2ul.
- Add support for ATSHA204 cryptochip in atmel-sha204a.
- Add support for PRNG in caam.
- Restore support for storage encryption in qat.
- Restore support for storage encryption in hisilicon/sec.

----------------------------------------------------------------
Colin Ian King (1):
      hwrng: optee - remove redundant initialization to variable rng_size

Conor Dooley (1):
      hwrng: mpfs - add polarfire soc hwrng support

Corentin Labbe (20):
      crypto: marvell/cesa - ECB does not IV
      crypto: sun8i-ce - Fix minor style issue
      crypto: sun8i-ce - do not allocate memory when handling requests
      crypto: sun4i-ss - do not allocate backup IV on requests
      crypto: sun8i-ss - rework handling of IV
      crypto: sun8i-ss - handle zero sized sg
      crypto: sun8i-ss - remove redundant test
      crypto: sun8i-ss - test error before assigning
      crypto: sun8i-ss - use sg_nents_for_len
      crypto: sun8i-ss - do not allocate memory when handling hash requests
      crypto: sun8i-ss - do not zeroize all pad
      crypto: sun8i-ss - handle requests if last block is not modulo 64
      crypto: sun8i-ss - rework debugging
      crypto: sun8i-ss - Add function for handling hash padding
      crypto: sun8i-ss - add hmac(sha1)
      crypto: sun8i-ss - do not fallback if cryptlen is less than sg length
      crypto: sun8i-ce - Add function for handling hash padding
      crypto: sun8i-ce - use sg_nents_for_len
      crypto: sun8i-ce - rework debugging
      crypto: sun8i-ce - do not fallback if cryptlen is less than sg length

Eric Biggers (1):
      crypto: testmgr - test in-place en/decryption with two sglists

Fabio Estevam (1):
      crypto: caam - fix i.MX6SX entropy delay value

Gilad Ben-Yossef (2):
      crypto: ccree - rearrange init calls to avoid race
      crypto: ccree - use fine grained DMA mapping dir

Giovanni Cabiddu (15):
      crypto: qat - set CIPHER capability for DH895XCC
      crypto: qat - set COMPRESSION capability for DH895XCC
      crypto: qat - remove unused PFVF stubs
      crypto: qat - set to zero DH parameters before free
      crypto: qat - use pre-allocated buffers in datapath
      crypto: qat - refactor submission logic
      crypto: qat - add backlog mechanism
      crypto: qat - fix memory leak in RSA
      crypto: qat - remove dma_free_coherent() for RSA
      crypto: qat - remove dma_free_coherent() for DH
      crypto: qat - add param check for RSA
      crypto: qat - add param check for DH
      crypto: qat - honor CRYPTO_TFM_REQ_MAY_SLEEP flag
      crypto: qat - re-enable registration of algorithms
      crypto: qat - add support for 401xx devices

Haowen Bai (1):
      crypto: qat - Fix unsigned function returning negative constant

Herbert Xu (3):
      hwrng: mpfs - Enable COMPILE_TEST
      Revert "hwrng: mpfs - Enable COMPILE_TEST"
      hwrng: cn10k - Enable compile testing

Hui Tang (1):
      crypto: hisilicon/qm - optimize the barrier operation

Jacky Li (1):
      crypto: ccp - Fix the INIT_EX data file open failure

Jakob Koschel (1):
      crypto: cavium/nitrox - remove check of list iterator against head past the loop body

Jason A. Donenfeld (1):
      crypto: sm3,sm4 - move into crypto directory

Jayesh Choudhary (2):
      dt-bindings: crypto: ti,sa2ul: Add a new compatible for AM62
      crypto: sa2ul - Add the new compatible for AM62

Juerg Haefliger (1):
      crypto: inside-secure - Add MODULE_FIRMWARE macros

Kai Ye (13):
      crypto: hisilicon/qm - add register checking for ACC
      crypto: hisilicon/hpre - support register checking
      crypto: hisilicon/sec - support register checking
      crypto: hisilicon/zip - support register checking
      Documentation: update debugfs doc for Hisilicon HPRE
      Documentation: update debugfs doc for Hisilicon SEC
      Documentation: update debugfs doc for Hisilicon ZIP
      crypto: hisilicon/qm - add last word dumping for ACC
      crypto: hisilicon/sec - support last word dumping
      crypto: hisilicon/hpre - support last word dumping
      crypto: hisilicon/zip - support last word dumping
      crypto: hisilicon/sec - add sm4 generic selection
      crypto: hisilicon/sec - delete the flag CRYPTO_ALG_ALLOCATES_MEMORY

Lv Ruyi (1):
      crypto: keembay - Make use of devm helper function devm_platform_ioremap_resource()

Marco Chiappero (12):
      crypto: qat - fix ETR sources enabled by default on GEN2 devices
      crypto: qat - remove unneeded braces
      crypto: qat - remove unnecessary tests to detect PFVF support
      crypto: qat - add missing restarting event notification in VFs
      crypto: qat - test PFVF registers for spurious interrupts on GEN4
      crypto: qat - fix wording and formatting in code comment
      crypto: qat - fix off-by-one error in PFVF debug print
      crypto: qat - rework the VF2PF interrupt handling logic
      crypto: qat - leverage the GEN2 VF mask definiton
      crypto: qat - replace disable_vf2pf_interrupts()
      crypto: qat - use u32 variables in all GEN4 pfvf_ops
      crypto: qat - remove line wrapping for pfvf_ops functions

Mario Limonciello (4):
      crypto: ccp - cache capability into psp device
      crypto: ccp - Export PSP security bits to userspace
      crypto: ccp - Allow PSP driver to load without SEV/TEE support
      crypto: ccp - When TSME and SME both detected notify user

Masahiro Yamada (2):
      crypto: vmx - Align the short log with Makefile cleanups
      crypto: vmx - Fix build error

Meenakshi Aggarwal (1):
      crypto: caam/rng - Add support for PRNG

Minghao Chi (3):
      crypto: sun8i-ss - using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      crypto: sun8i-ce - using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      crypto: octeontx2 - simplify the return expression of otx2_cpt_aead_cbc_aes_sha_setkey()

Pali Rohár (1):
      crypto: atmel-sha204a - Add support for ATSHA204 cryptochip

Peter Gonda (1):
      crypto: ccp - Log when resetting PSP SEV state

Randy Dunlap (1):
      crypto: x86 - eliminate anonymous module_init & module_exit

Robin Murphy (1):
      crypto: qat - stop using iommu_present()

Sebastian Andrzej Siewior (1):
      crypto: cryptd - Protect per-CPU resource by disabling BH.

Tetsuo Handa (1):
      crypto: atmel - Avoid flush_scheduled_work() usage

Tianjia Zhang (5):
      crypto: sm4 - export sm4 constant arrays
      crypto: arm64/sm4-ce - rename to sm4-ce-cipher
      crypto: arm64/sm4 - add ARMv8 NEON implementation
      crypto: arm64/sm4 - add ARMv8 Crypto Extensions implementation
      crypto: arm64/sm4 - Fix wrong dependency of NEON/CE implementation

Uwe Kleine-König (3):
      crypto: atmel-sha204a - Remove useless check
      crypto: atmel-sha204a - Suppress duplicate error message
      crypto: atmel-i2c - Simplify return code in probe function

Vitaly Chikunov (1):
      crypto: ecrdsa - Fix incorrect use of vli_cmp

Vladis Dronov (3):
      hwrng: cn10k - Optimize cn10k_rng_read()
      hwrng: cn10k - Make check_rng_health() return an error code
      crypto: s390 - add crypto library interface for ChaCha20

Weili Qian (4):
      crypto: hisilicon/qm - remove unused function declaration
      crypto: hisilicon/qm - set function with static
      crypto: hisilicon/qm - replace hisi_qm_release_qp() with hisi_qm_free_qps()
      crypto: hisilicon/qm - remove hisi_qm_get_free_qp_num()

Wojciech Ziemba (1):
      crypto: qat - add check for invalid PFVF protocol version 0

Yang Li (1):
      crypto: engine - Add parameter description in crypto_transfer_request() kernel-doc comment

Yang Shen (1):
      crypto: hisilicon/sgl - align the hardware sgl dma address

Yang Yingliang (1):
      hwrng: omap3-rom - fix using wrong clk_disable() in omap_rom_rng_runtime_resume()

Yihao Han (1):
      crypto: ux500/hash - simplify if-if to if-else

jianchunfu (1):
      crypto: talitos - Uniform coding style with defined variable

 Documentation/ABI/testing/debugfs-hisi-hpre        |  14 +
 Documentation/ABI/testing/debugfs-hisi-sec         |  14 +
 Documentation/ABI/testing/debugfs-hisi-zip         |  14 +
 Documentation/ABI/testing/sysfs-driver-ccp         |  87 +++
 .../devicetree/bindings/crypto/ti,sa2ul.yaml       |   1 +
 .../devicetree/bindings/trivial-devices.yaml       |   4 +-
 arch/arm64/crypto/Kconfig                          |  16 +-
 arch/arm64/crypto/Makefile                         |   8 +-
 arch/arm64/crypto/sm4-ce-cipher-core.S             |  36 ++
 arch/arm64/crypto/sm4-ce-cipher-glue.c             |  82 +++
 arch/arm64/crypto/sm4-ce-core.S                    | 688 ++++++++++++++++++++-
 arch/arm64/crypto/sm4-ce-glue.c                    | 386 ++++++++++--
 arch/arm64/crypto/sm4-neon-core.S                  | 487 +++++++++++++++
 arch/arm64/crypto/sm4-neon-glue.c                  | 442 +++++++++++++
 arch/s390/crypto/chacha-glue.c                     |  34 +-
 arch/x86/crypto/blowfish_glue.c                    |   8 +-
 arch/x86/crypto/camellia_glue.c                    |   8 +-
 arch/x86/crypto/serpent_avx2_glue.c                |   8 +-
 arch/x86/crypto/twofish_glue.c                     |   8 +-
 arch/x86/crypto/twofish_glue_3way.c                |   8 +-
 crypto/Kconfig                                     |  18 +-
 crypto/Makefile                                    |   6 +-
 crypto/cryptd.c                                    |  23 +-
 crypto/crypto_engine.c                             |   1 +
 crypto/ecrdsa.c                                    |   8 +-
 {lib/crypto => crypto}/sm3.c                       |   0
 {lib/crypto => crypto}/sm4.c                       |  10 +-
 crypto/testmgr.c                                   |  75 ++-
 drivers/char/hw_random/Kconfig                     |  15 +-
 drivers/char/hw_random/Makefile                    |   1 +
 drivers/char/hw_random/cn10k-rng.c                 |  31 +-
 drivers/char/hw_random/mpfs-rng.c                  | 104 ++++
 drivers/char/hw_random/omap3-rom-rng.c             |   2 +-
 drivers/char/hw_random/optee-rng.c                 |   2 +-
 drivers/crypto/Kconfig                             |   4 +-
 drivers/crypto/Makefile                            |   1 +
 .../crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c    |  22 +-
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h       |   1 +
 .../crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c    | 102 +--
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c  |  54 +-
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c  | 130 ++--
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c  |   6 +-
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h       |  19 +-
 .../crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c    | 180 ++++--
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c  |  92 ++-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c  | 385 ++++++++++--
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c  |   6 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h       |  33 +-
 drivers/crypto/atmel-ecc.c                         |   2 +-
 drivers/crypto/atmel-i2c.c                         |  30 +-
 drivers/crypto/atmel-i2c.h                         |   1 +
 drivers/crypto/atmel-sha204a.c                     |  11 +-
 drivers/crypto/caam/Kconfig                        |   8 +
 drivers/crypto/caam/Makefile                       |   1 +
 drivers/crypto/caam/caamprng.c                     | 235 +++++++
 drivers/crypto/caam/ctrl.c                         |  18 +
 drivers/crypto/caam/intern.h                       |  15 +
 drivers/crypto/caam/jr.c                           |   3 +-
 drivers/crypto/cavium/nitrox/nitrox_main.c         |  10 +-
 drivers/crypto/ccp/psp-dev.c                       |  49 +-
 drivers/crypto/ccp/psp-dev.h                       |  22 +
 drivers/crypto/ccp/sev-dev.c                       |  32 +-
 drivers/crypto/ccp/sp-pci.c                        |  62 ++
 drivers/crypto/ccree/cc_buffer_mgr.c               |  27 +-
 drivers/crypto/ccree/cc_driver.c                   |  24 +-
 drivers/crypto/hisilicon/Kconfig                   |   1 +
 drivers/crypto/hisilicon/hpre/hpre_main.c          | 222 +++++--
 drivers/crypto/hisilicon/qm.c                      | 282 ++++++++-
 drivers/crypto/hisilicon/sec2/sec_crypto.c         |   2 -
 drivers/crypto/hisilicon/sec2/sec_main.c           | 108 +++-
 drivers/crypto/hisilicon/sgl.c                     |   6 +-
 drivers/crypto/hisilicon/zip/zip_crypto.c          |   2 +-
 drivers/crypto/hisilicon/zip/zip_main.c            | 185 +++++-
 drivers/crypto/inside-secure/safexcel.c            |   9 +
 drivers/crypto/keembay/keembay-ocs-aes-core.c      |   9 +-
 drivers/crypto/marvell/cesa/cipher.c               |   1 -
 drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c |   7 +-
 drivers/crypto/qat/qat_4xxx/adf_drv.c              |   8 +-
 drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c   |  15 +-
 drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.h   |   4 -
 drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c     |  15 +-
 drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.h     |   4 -
 drivers/crypto/qat/qat_common/Makefile             |   1 +
 drivers/crypto/qat/qat_common/adf_accel_devices.h  |   6 +-
 drivers/crypto/qat/qat_common/adf_common_drv.h     |  18 +-
 drivers/crypto/qat/qat_common/adf_gen2_hw_data.c   |  13 +
 drivers/crypto/qat/qat_common/adf_gen2_hw_data.h   |   6 +
 drivers/crypto/qat/qat_common/adf_gen2_pfvf.c      |  78 ++-
 drivers/crypto/qat/qat_common/adf_gen4_pfvf.c      |  61 +-
 drivers/crypto/qat/qat_common/adf_isr.c            |  21 +-
 drivers/crypto/qat/qat_common/adf_pfvf_msg.h       |   4 +-
 drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.c  |   6 +-
 drivers/crypto/qat/qat_common/adf_sriov.c          |  16 +-
 drivers/crypto/qat/qat_common/adf_transport.c      |  11 +
 drivers/crypto/qat/qat_common/adf_transport.h      |   1 +
 .../crypto/qat/qat_common/adf_transport_internal.h |   1 +
 drivers/crypto/qat/qat_common/adf_vf_isr.c         |   1 +
 drivers/crypto/qat/qat_common/qat_algs.c           | 153 +++--
 drivers/crypto/qat/qat_common/qat_algs_send.c      |  86 +++
 drivers/crypto/qat/qat_common/qat_algs_send.h      |  11 +
 drivers/crypto/qat/qat_common/qat_asym_algs.c      | 307 +++++----
 drivers/crypto/qat/qat_common/qat_crypto.c         |  10 +-
 drivers/crypto/qat/qat_common/qat_crypto.h         |  44 ++
 drivers/crypto/qat/qat_common/qat_hal.c            |   1 +
 drivers/crypto/qat/qat_common/qat_uclo.c           |   3 +-
 .../crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c | 126 ++--
 .../crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.h |   4 -
 drivers/crypto/sa2ul.c                             |   1 +
 drivers/crypto/talitos.c                           |  10 +-
 drivers/crypto/ux500/hash/hash_core.c              |   4 +-
 drivers/crypto/vmx/Makefile                        |  17 +-
 include/crypto/sm4.h                               |   4 +
 include/linux/hisi_acc_qm.h                        |  23 +-
 lib/crypto/Kconfig                                 |   6 -
 lib/crypto/Makefile                                |   6 -
 tools/testing/crypto/chacha20-s390/Makefile        |  12 +
 tools/testing/crypto/chacha20-s390/run-tests.sh    |  34 +
 tools/testing/crypto/chacha20-s390/test-cipher.c   | 372 +++++++++++
 118 files changed, 5534 insertions(+), 1058 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-ccp
 create mode 100644 arch/arm64/crypto/sm4-ce-cipher-core.S
 create mode 100644 arch/arm64/crypto/sm4-ce-cipher-glue.c
 create mode 100644 arch/arm64/crypto/sm4-neon-core.S
 create mode 100644 arch/arm64/crypto/sm4-neon-glue.c
 rename {lib/crypto => crypto}/sm3.c (100%)
 rename {lib/crypto => crypto}/sm4.c (94%)
 create mode 100644 drivers/char/hw_random/mpfs-rng.c
 create mode 100644 drivers/crypto/caam/caamprng.c
 create mode 100644 drivers/crypto/qat/qat_common/qat_algs_send.c
 create mode 100644 drivers/crypto/qat/qat_common/qat_algs_send.h
 create mode 100644 tools/testing/crypto/chacha20-s390/Makefile
 create mode 100644 tools/testing/crypto/chacha20-s390/run-tests.sh
 create mode 100644 tools/testing/crypto/chacha20-s390/test-cipher.c

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
