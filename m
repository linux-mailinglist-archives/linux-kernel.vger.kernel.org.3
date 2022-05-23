Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F335310A4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbiEWNN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236008AbiEWNNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:13:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7571D3CFCB;
        Mon, 23 May 2022 06:12:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 267A9B810AD;
        Mon, 23 May 2022 13:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90060C385A9;
        Mon, 23 May 2022 13:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653311570;
        bh=kLr4V/v2wG0N32Fp8e129QAuzJ7u0W5YAfYJO0LuWZ8=;
        h=From:To:Cc:Subject:Date:From;
        b=VYntHnKTR+WugKEt/szd5upGIcrEUtbGXkxwkf+Ec+v5D98vNDK/lLmThU0MAk5yt
         a/dKlXKxP19zJWabfKqyY47d1olru9VL0ejrz/m/XLhZxSa9RlZVY7eTArCkTHQZbP
         RZYTUiYvQPElcKL2vd7LDRIAAfG47I9Vo2E2NnMhdQhknyI0pxj9IQvGTTy73ff2Om
         SZDEcH1cxrc0zQwAcYw2m6ULj8fQak0rrNje8uT1VcuBFVj/GmtP4XP1T7oUIqTfif
         b3EtykEexskuQ5ikUpZG5FRP+i7p2mXLyVGUIN7uRH4YzsvEyCWPaGDk/d/Kg//Xvi
         K7RVNzEwyjaMg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v5.19
Date:   Mon, 23 May 2022 14:12:36 +0100
Message-Id: <20220523131250.90060C385A9@smtp.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8c235cc25087495c4288d94f547e9d3061004991:

  spi: atmel-quadspi: Fix the buswidth adjustment between spi-mem and controller (2022-04-13 16:43:12 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.19

for you to fetch changes up to 9c63b846e6df43e5b3d31263f7db545f32deeda3:

  spi: spi-mem: Convert Aspeed SMC driver to spi-mem (2022-05-16 19:38:40 +0100)

----------------------------------------------------------------
spi: Updates for v5.19

This is quite a quiet release but some new drivers mean that the
diffstat is fairly large, the new drivers include the aspeed driver
which is migrated from MTD as part of the ongoing move of controllers
with specialised support for SPI flashes into the SPI subsystem.

 - Support for devices which flip CPHA during recieve only transfers
   (eg, if MOSI and MISO have inverted polarity).
 - Overhaul of the i.MX driver, including the addition of PIO support
   for better performance on small transfers.
 - Migration of the Aspeed driver from MTD.
 - Support for Aspeed AST2400, Ingenic JZ4775 and X1/2000 and MediaTek
   IPM and SFI.

----------------------------------------------------------------
Alexander Shiyan (1):
      spi: clps711x: Use syscon_regmap_lookup_by_phandle

Amit Kumar Mahapatra (1):
      spi: spi-cadence: Update ISR status variable type to irqreturn_t

Andrea Zanotti (1):
      spi: omap2-mcspi: add support for interword delay

Andy Shevchenko (3):
      spi: spidev: Convert BUILD_BUG_ON() to static_assert()
      spi: spidev: Replace ACPI specific code by device_get_match_data()
      spi: spidev: Replace OF specific code by device property API

AngeloGioacchino Del Regno (8):
      spi: mt65xx: Simplify probe function with devm_spi_alloc_master
      spi: mt65xx: Switch to device_get_match_data()
      spi: mt65xx: Add and use pointer to struct device in mtk_spi_probe()
      spi: mt65xx: Move clock parent setting to remove clock disable gotos
      spi: mt65xx: Move pm_runtime_enable() call to remove all gotos
      spi: mt65xx: Simplify probe function with dev_err_probe()
      spi: mt65xx: Add kerneldoc for driver structures
      spi: mt65xx: Fix definitions indentation

Baruch Siach (3):
      spi: add SPI_RX_CPHA_FLIP mode bit
      spi: spidev: add SPI_RX_CPHA_FLIP
      spi: spi-imx: add support for SPI_RX_CPHA_FLIP

Biju Das (2):
      spi: spi-rspi: Remove setting {src,dst}_{addr,addr_width} based on DMA direction
      spi: dt-bindings: renesas,rspi: Document RZ/G2UL SoC

Christophe Leroy (1):
      spi: Prepare cleanup of powerpc's asm/prom.h

Chuanhong Guo (4):
      mtd: nand: make mtk_ecc.c a separated module
      mtd: nand: mtk-ecc: also parse nand-ecc-engine if available
      spi: add driver for MTK SPI NAND Flash Interface
      spi: dt-bindings: add binding doc for spi-mtk-snfi

Cédric Le Goater (7):
      spi: Convert the Aspeed SMC controllers device tree binding
      spi: spi-mem: Convert Aspeed SMC driver to spi-mem
      spi: aspeed: Add support for direct mapping
      spi: aspeed: Adjust direct mapping to device size
      spi: aspeed: Workaround AST2500 limitations
      spi: aspeed: Add support for the AST2400 SPI controller
      spi: aspeed: Calibrate read timings

Dan Carpenter (1):
      spi: mtk-snfi: preserve dma_mapping_error() error codes

Guo Zhengkui (1):
      spi: spi-au1550: replace ternary operator with min()

Ian Abbott (3):
      spi: cadence-quadspi: fix Direct Access Mode disable for SoCFPGA
      spi: cadence-quadspi: Add missing blank line in cqspi_request_mmap_dma()
      spi: cadence-quadspi: remove unnecessary (void *) casts

Jakob Koschel (1):
      spi: spidev: replace usage of found with dedicated list iterator variable

Kuldeep Singh (1):
      spi: qcom-qspi: Add minItems to interconnect-names

Leilk Liu (3):
      spi: mediatek: add spi memory support for ipm design
      spi: mediatek: support hclk
      spi: support hclk

Li-hao Kuo (1):
      spi: remove spin_lock_irq and variable in the irq procress

Luca Ceresoli (1):
      spi: rockchip: fix missing error on unsupported SPI_CS_HIGH

Marc Kleine-Budde (9):
      spi: spi-imx: fix sparse warning: add identifier name to function definition
      spi: spi-imx: avoid unnecessary line continuations
      spi: spi-imx: mx51_ecspi_intctrl(): prefer 'unsigned int' to bare use of 'unsigned'
      spi: spi-imx: spi_imx_buf_rx_swap_u32(): fix sparse warning: use swab32s() instead of cpu_to_be32()
      spi: spi-imx: spi_imx_buf_rx_swap_u32(): replace open coded swahw32s()
      spi: spi-imx: complete conversion from master -> controller
      spi: spi-imx: replace struct spi_imx_data::bitbang by pointer to struct spi_controller
      spi: spi-imx: add PIO polling support
      spi: spi-imx: mx51_ecspi_prepare_message(): skip writing MX51_ECSPI_CONFIG register if unchanged

Mark Brown (7):
      spi: mediatek: add single/quad mode support
      spi: Pull in Atmel fix
      MediaTek SPI controller cleanups and documentation
      Improve SPI support for Ingenic SoCs.
      spi: Pull Mediatek ECC changes
      spi: stm32-qspi: flags management fixes
      spi: spi-mem: Convert Aspeed SMC driver to spi-mem

Matthias Schiffer (2):
      spi: cadence-quadspi: drop cqspi_set_protocol()
      spi: cadence-quadspi: allow operations with cmd/addr buswidth >1

Miaoqian Lin (1):
      spi: spi-ti-qspi: Fix return value handling of wait_for_completion_timeout

Michal Simek (1):
      spi: spi-cadence: Fix kernel-doc format for resume/suspend

Mika Westerberg (2):
      spi: intel: Fix typo in kernel-doc of intel_spi_probe()
      spi: intel: Implement dirmap hooks

Minghao Chi (13):
      spi: spi-stm32-qspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      spi: spi-cadence-quadspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      spi: spi-tegra114: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      spi: spi-ti-qspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      spi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      spi: spi-sprd: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      spi: spi-imx: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      spi: mxs: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      spi: spi-omap2-mcspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      spi: spi-tegra20-sflash: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      spi: spi-tegra20-slink: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      spi: spi-cadence-quadspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      spi: stm32: using pm_runtime_resume_and_get instead of pm_runtime_get_sync

Patrice Chotard (3):
      spi: stm32-qspi: Fix wait_cmd timeout in APM mode
      spi: stm32-qspi: Always check SR_TCF flags in stm32_qspi_wait_cmd()
      spi: stm32-qspi: Remove SR_BUSY bit check before sending command

Paul Kocialkowski (2):
      spi: core: Only check bits_per_word validity when explicitly provided
      spi: core: Initialize returned status in spi_setup

Potin Lai (1):
      mtd: spi-nor: aspeed: set the decoding size to at least 2MB for AST2600

Pratyush Yadav (1):
      spi: spi-mem: check if data buffers are on stack

Siddh Raman Pant (1):
      spi: Doc fix - Describe add_lock and dma_map_dev in spi_controller

Tudor Ambarus (1):
      spi: atmel-quadspi: Remove duplicated DTR checks

Vaishnav Achath (1):
      spi: cadence-quadspi: Handle spi_unregister_master() in remove()

Yang Yingliang (1):
      spi: spi-fsl-qspi: check return value after calling platform_get_resource_byname()

Zheng Yongjun (1):
      spi: img-spfi: Fix pm_runtime_get_sync() error checking

周琰杰 (Zhou Yanjie) (3):
      spi: ingenic: Add support for use GPIO as chip select line.
      spi: Add bindings for new Ingenic SoCs.
      spi: ingenic: Add support for new Ingenic SoCs.

 .../devicetree/bindings/mtd/aspeed-smc.txt         |   51 -
 .../bindings/spi/aspeed,ast2600-fmc.yaml           |   82 ++
 .../devicetree/bindings/spi/ingenic,spi.yaml       |    3 +
 .../bindings/spi/mediatek,spi-mt65xx.yaml          |    4 +
 .../bindings/spi/mediatek,spi-mtk-snfi.yaml        |   88 ++
 .../bindings/spi/qcom,spi-qcom-qspi.yaml           |    1 +
 .../devicetree/bindings/spi/renesas,rspi.yaml      |    2 +
 MAINTAINERS                                        |   10 +
 drivers/mtd/nand/Kconfig                           |    7 +
 drivers/mtd/nand/Makefile                          |    1 +
 drivers/mtd/nand/{raw/mtk_ecc.c => ecc-mtk.c}      |    8 +-
 drivers/mtd/nand/raw/Kconfig                       |    1 +
 drivers/mtd/nand/raw/Makefile                      |    2 +-
 drivers/mtd/nand/raw/mtk_nand.c                    |    2 +-
 drivers/mtd/spi-nor/controllers/Kconfig            |   10 -
 drivers/mtd/spi-nor/controllers/Makefile           |    1 -
 drivers/mtd/spi-nor/controllers/aspeed-smc.c       |  921 ------------
 drivers/spi/Kconfig                                |   26 +-
 drivers/spi/Makefile                               |    2 +
 drivers/spi/atmel-quadspi.c                        |    6 -
 drivers/spi/spi-aspeed-smc.c                       | 1210 ++++++++++++++++
 drivers/spi/spi-au1550.c                           |    4 +-
 drivers/spi/spi-cadence-quadspi.c                  |  159 +--
 drivers/spi/spi-cadence.c                          |   11 +-
 drivers/spi/spi-clps711x.c                         |    5 +-
 drivers/spi/spi-fsl-qspi.c                         |    4 +
 drivers/spi/spi-img-spfi.c                         |    2 +-
 drivers/spi/spi-imx.c                              |  356 +++--
 drivers/spi/spi-ingenic.c                          |   47 +-
 drivers/spi/spi-intel.c                            |   51 +-
 drivers/spi/spi-mem.c                              |   13 +-
 drivers/spi/spi-mpc52xx-psc.c                      |    1 +
 drivers/spi/spi-mpc52xx.c                          |    3 +
 drivers/spi/spi-mt65xx.c                           |  702 +++++++---
 drivers/spi/spi-mtk-snfi.c                         | 1472 ++++++++++++++++++++
 drivers/spi/spi-mxs.c                              |    3 +-
 drivers/spi/spi-omap2-mcspi.c                      |   19 +-
 drivers/spi/spi-rockchip.c                         |    8 +
 drivers/spi/spi-rspi.c                             |   15 +-
 drivers/spi/spi-sprd.c                             |    3 +-
 drivers/spi/spi-stm32-qspi.c                       |   41 +-
 drivers/spi/spi-stm32.c                            |    3 +-
 drivers/spi/spi-sunplus-sp7021.c                   |    6 -
 drivers/spi/spi-tegra114.c                         |    9 +-
 drivers/spi/spi-tegra20-sflash.c                   |    6 +-
 drivers/spi/spi-tegra20-slink.c                    |    6 +-
 drivers/spi/spi-ti-qspi.c                          |    8 +-
 drivers/spi/spi.c                                  |   25 +-
 drivers/spi/spidev.c                               |  104 +-
 .../mtk_ecc.h => include/linux/mtd/nand-ecc-mtk.h  |    0
 include/linux/spi/spi.h                            |    2 +
 include/uapi/linux/spi/spi.h                       |    3 +-
 52 files changed, 3927 insertions(+), 1602 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/aspeed-smc.txt
 create mode 100644 Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
 rename drivers/mtd/nand/{raw/mtk_ecc.c => ecc-mtk.c} (98%)
 delete mode 100644 drivers/mtd/spi-nor/controllers/aspeed-smc.c
 create mode 100644 drivers/spi/spi-aspeed-smc.c
 create mode 100644 drivers/spi/spi-mtk-snfi.c
 rename drivers/mtd/nand/raw/mtk_ecc.h => include/linux/mtd/nand-ecc-mtk.h (100%)
