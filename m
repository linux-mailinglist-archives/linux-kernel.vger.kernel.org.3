Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3E6586B3A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbiHAMrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbiHAMrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:47:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDAB2314A;
        Mon,  1 Aug 2022 05:38:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75E6BB81196;
        Mon,  1 Aug 2022 12:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E2EC433D6;
        Mon,  1 Aug 2022 12:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659357513;
        bh=lpkeeEGnbHYXaYsdZmTigYZ6q+Wyz9lzV6GrtxhtCrg=;
        h=From:To:Cc:Subject:Date:From;
        b=G/x+T31VPzNrbnrRKR0BVv22C45b00Bq6PuTS9ihPVsnRqVdL4JgnMreB2kVwuDW0
         SNEzVxL9Z4vOr4/lFIRWf/Gw3y+ZH8NCP1NGY4mPGd1HhTaQYSlQvwY+LhIao3K9VO
         8OcfvBaNstvOrF1D7NEdIejHQ70De6DZX7Qe8zkYjmGPLe5ibj/I+kDjTdlEvYbS8F
         oSv/I6z1xYEJHGnBCfx5Y8YDzI9+JDRT6kT6W6DCUx8/mmdWThoZ8I1sBzv7FaZVvH
         Kix1Nl49uh/+7cC+IyXoV3G0o/CQr4pYZrHtQwtGfK2WnIxewEbw44qF30ipIwRSN6
         xaCrqSdbXgQ/A==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v5.20
Date:   Mon, 01 Aug 2022 13:38:22 +0100
Message-Id: <20220801123832.C1E2EC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6ece49c56965544262523dae4a071ace3db63507:

  spi: amd: Limit max transfer and message size (2022-07-06 15:20:46 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.20

for you to fetch changes up to 69243df953e70c134c6735b31ba0e658c53d3cda:

  Add SPI Driver to HPE GXP Architecture (2022-07-29 20:22:22 +0100)

----------------------------------------------------------------
spi: Updates for v5.20

The big update this time around is some excellent work from David Jander
who went through the fast path and really eliminated overheads, meaning
that we are seeing a huge reduction in the time spent between transfers
for single threaded clients. Benchmarking has been coming out at about a
halving of overhead which is clearly visible in system level usage that
stresses SPI like some CAN and IIO applications, especially with small
transfers. Thanks to David for taking the time to drill down into this
and push the work upstream.

Otherwise there's been a bunch of new device support and the usual

 - Optimisation of the fast path, particularly around the number and
   types of locking operations, from David Jander.
 - Support for Arbel NPCM845, HP GXP, Intel Meteor Lake and Thunder Bay,
   MediaTek MT8188 and MT8365, Microchip FPGAs, nVidia Tegra 241 and
   Samsung Exynos Auto v9 and 4210.

----------------------------------------------------------------
Adithya K V (1):
      spi: s3c64xx: requests spi-dma channel only during data transfer

Allen-KH Cheng (1):
      spi: dt-bindings: mediatek,spi-mtk-nor: Update bindings for nor flash

Amit Kumar Mahapatra (1):
      spi: spi-zynqmp-gqspi: Add two chip select support

Andy Chiu (1):
      spi: sifive: add PM callbacks to support suspend/resume

Andy Shevchenko (3):
      spi: Return deferred probe error when controller isn't yet available
      spi: propagate error code to the caller of acpi_spi_device_alloc()
      spi: remove duplicate parameters check in acpi_spi_add_resource()

Atsushi Nemoto (1):
      spi: spi-ti-qspi: Support per-transfer and per-slave speed_hz settings

Biju Das (1):
      ASoC: dt-bindings: renesas,rz-ssi: Document RZ/G2UL SoC

Chanho Park (5):
      spi: s3c64xx: move dma_release_channel to unprepare
      spi: s3c64xx: support loopback mode
      spi: s3c64xx: support custom value of internal clock divider
      spi: s3c64xx: add spi port configuration for Exynos Auto v9 SoC
      spi: s3c64xx: define exynosautov9 compatible

Christophe JAILLET (2):
      spi: spi-altera-dfl: Fix an error handling path
      spi: intel: Use correct order for the parameters of devm_kcalloc()

Claudiu Beznea (4):
      spi: atmel-quadspi: add runtime pm support
      spi: atmel-quadspi: use pm_ptr()
      spi: atmel-quadspi: align condition to parenthesis
      spi: atmel: remove #ifdef CONFIG_{PM, SLEEP}

Colin Ian King (2):
      spi: s3c64xx: Fix spelling mistake "hannel" -> "channel"
      spi: s3c64xx: set pointers to null using NULL rather than 0

Conor Dooley (5):
      spi: add support for microchip fpga spi controllers
      MAINTAINERS: add spi to PolarFire SoC entry
      spi: microchip-core: fix potentially incorrect return from probe
      spi: microchip-core: fix passing zero to PTR_ERR warning
      spi: dt-bindings: dw-apb-ssi: update spi-{r,t}x-bus-width

Cristian Ciocaltea (4):
      spi: amd: Make use of devm_spi_alloc_master()
      spi: amd: Make use of dev_err_probe()
      spi: amd: Drop io_base_addr member from struct amd_spi
      spi: amd: Add struct and enum kernel-doc comments

Dan Carpenter (1):
      spi: core: Fix error code in spi_register_controller()

David Fries (1):
      spi: spidev_test: Warn when the mode is not the requested mode

David Jander (17):
      spi: spi.c: Convert statistics to per-cpu u64_stats_t
      spi: <linux/spi/spi.h>: Add missing documentation for struct members
      spi: Fix per-cpu stats access on 32 bit systems
      spi: Move ctlr->cur_msg_prepared to struct spi_message
      spi: Don't use the message queue if possible in spi_sync
      spi: Lock controller idling transition inside the io_mutex
      spi: __spi_pump_messages: Consolidate spin_unlocks to goto target
      spi: Remove check for controller idling in spi sync path
      spi: Remove check for idling in __spi_pump_messages()
      spi: Remove the now unused ctlr->idling flag
      spi: Remove unneeded READ_ONCE for ctlr->busy flag
      spi: Set ctlr->cur_msg also in the sync transfer case
      spi: Ensure the io_mutex is held until spi_finalize_current_message()
      spi: opportunistically skip ctlr->cur_msg_completion
      spi: spi.c: White-space fix in __spi_pump_messages()
      spi: spi.c: Fix comment style
      spi: spi.c: Remove redundant else block

Eddie James (1):
      spi: fsi: Increase timeout and ensure status is checked

Fabien Parent (1):
      spi: mt65xx: add MT8365 SoC bindings

Guo Mengqi (1):
      spi: synquacer: Add missing clk_disable_unprepare()

Jarkko Nikula (1):
      spi: pxa2xx: Add support for Intel Meteor Lake-P

Johnson Wang (1):
      spi: dt-bindings: Add compatible for MediaTek MT8188

Julia Lawall (1):
      spi: fix typo in comment

Krishna Yarlagadda (3):
      spi: tegra210-quad: Multi-cs support
      spi: dt-bindings: split peripheral prods
      spi: dt-bindings: Add compatible for Tegra241 QSPI

Krzysztof Kozlowski (7):
      spi: s3c64xx: constify fsd_spi_port_config
      spi: dt-bindings: samsung: Add Exynos4210 SPI
      spi: dt-bindings: cadence: add missing 'required'
      spi: dt-bindings: zynqmp-qspi: add missing 'required'
      spi: dt-bindings: qcom,spi-geni-qcom: allow three interconnects
      spi: dt-bindings: spi-controller: correct example indentation
      spi/panel: dt-bindings: drop CPHA and CPOL from common properties

Mark Brown (15):
      spi: stm32-qspi: Remove unused parameters
      Add support for PolarFire SoC's spi controllers
      spi: atmel-quadspi: add runtime pm support
      spi: tegra quad: Add Tegra Grace features
      spi: topcliff-pch: Use core message validation
      spi: sh: Switch to using core message queue
      spi: mpc52xx-psc: Switch to using core message queue
      Optimize spi_sync path
      spi support for Exynos Auto v9 SoC
      Fix some coding style issues
      spi: AMD SPI controller driver bug fix and cleanups
      spi: microchip-core: fix and cleanups
      Add support for Intel Thunder Bay SPI controller
      spi: npcm-fiu: add Arbel NPCM8XX support
      Add SPI Driver to HPE GXP Architecture

Martin Sperl (1):
      spi: bcm2835: enable shared interrupt support

Mika Westerberg (1):
      spi: intel: Add support for Intel Meteor Lake-P SPI serial flash

Nandhini Srikandan (4):
      spi: dw: Fix IP-core versions macro
      spi: Add bindings for Intel Thunder Bay SOC
      spi: dw: Add support for master mode selection for DWC SSI controller
      spi: dw: Add support for Intel Thunder Bay SPI controller

Nick Hawkins (3):
      spi: spi-gxp: Add support for HPE GXP SoCs
      spi: dt-bindings: add documentation for hpe,gxp-spifi
      MAINTAINERS: add spi support to GXP

Noam (1):
      spi: a3700: support BE for AC5 SPI driver

Patrice Chotard (3):
      spi: stm32-qspi: Remove stm32_qspi_get_mode() unused parameter
      spi: stm32-qspi: Remove stm32_qspi_wait_cmd() unused parameter
      spi: stm32-qspi: Remove stm32_qspi_wait_poll_status() unused parameter

Peng Wu (1):
      spi: micro: fix unreasonable clk_prepare_enable() on error in mchp_corespi_probe()

Rob Herring (1):
      spi: dt-bindings: Move 'rx-sample-delay-ns' to spi-peripheral-props.yaml

Serge Semin (1):
      spi: dw: Add deferred DMA-channels setup support

Sergiu Moga (1):
      spi: dt-bindings: atmel,at91rm9200-spi: convert to json-schema

Tomer Maimon (3):
      spi: npcm-fiu: Modify direct read dummy configuration
      dt-binding: spi: Add npcm845 compatible to npcm-fiu document
      spi: npcm-fiu: Add NPCM8XX support

Vaishnav Achath (1):
      spi: cadence-quadspi: Remove spi_master_put() in probe failure path

Yang Li (2):
      spi: fix platform_no_drv_owner.cocci warning
      spi: Return true/false (not 1/0) from bool function

Yang Yingliang (5):
      spi: microchip-core: fix UAF in mchp_corespi_remove()
      spi: microchip-core: switch to use devm_spi_alloc_master()
      spi: microchip-core: switch to use dev_err_probe()
      spi: Fix simplification of devm_spi_register_controller
      spi: tegra20-slink: fix UAF in tegra_slink_remove()

 .../bindings/display/panel/lgphilips,lb035q02.yaml |   3 +
 .../bindings/display/panel/samsung,ld9040.yaml     |   3 +
 .../bindings/display/panel/sitronix,st7789v.yaml   |   3 +
 .../devicetree/bindings/display/panel/tpo,td.yaml  |   3 +
 .../devicetree/bindings/sound/renesas,rz-ssi.yaml  |   3 +-
 .../bindings/spi/atmel,at91rm9200-spi.yaml         |  75 +++
 .../devicetree/bindings/spi/hpe,gxp-spifi.yaml     |  56 ++
 .../bindings/spi/mediatek,spi-mt65xx.yaml          |   2 +
 .../bindings/spi/mediatek,spi-mtk-nor.yaml         |  15 +-
 .../devicetree/bindings/spi/nuvoton,npcm-fiu.txt   |  13 +-
 .../spi/nvidia,tegra210-quad-peripheral-props.yaml |  33 ++
 .../bindings/spi/nvidia,tegra210-quad.yaml         |  22 +-
 .../bindings/spi/qcom,spi-geni-qcom.yaml           |   5 +-
 .../devicetree/bindings/spi/samsung,spi.yaml       |   6 +-
 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   |  26 +-
 .../devicetree/bindings/spi/spi-cadence.yaml       |   7 +
 .../devicetree/bindings/spi/spi-controller.yaml    |  19 +-
 .../bindings/spi/spi-peripheral-props.yaml         |  16 +-
 .../devicetree/bindings/spi/spi-zynqmp-qspi.yaml   |   7 +
 .../devicetree/bindings/spi/spi_atmel.txt          |  36 --
 MAINTAINERS                                        |   3 +
 drivers/spi/Kconfig                                |  16 +
 drivers/spi/Makefile                               |   2 +
 drivers/spi/atmel-quadspi.c                        | 104 +++-
 drivers/spi/spi-altera-dfl.c                       |  14 +-
 drivers/spi/spi-amd.c                              |  45 +-
 drivers/spi/spi-armada-3700.c                      |   4 +-
 drivers/spi/spi-atmel.c                            |  15 +-
 drivers/spi/spi-bcm2835.c                          |   8 +-
 drivers/spi/spi-cadence-quadspi.c                  |  19 +-
 drivers/spi/spi-dw-core.c                          |  10 +-
 drivers/spi/spi-dw-dma.c                           |  25 +-
 drivers/spi/spi-dw-mmio.c                          |   8 +-
 drivers/spi/spi-dw.h                               |  13 +-
 drivers/spi/spi-fsi.c                              |  19 +-
 drivers/spi/spi-gxp.c                              | 325 +++++++++++
 drivers/spi/spi-intel-pci.c                        |   1 +
 drivers/spi/spi-intel.c                            |   4 +-
 drivers/spi/spi-microchip-core.c                   | 617 +++++++++++++++++++++
 drivers/spi/spi-mpc52xx-psc.c                      | 116 ++--
 drivers/spi/spi-npcm-fiu.c                         |  28 +-
 drivers/spi/spi-pxa2xx.c                           |   4 +
 drivers/spi/spi-s3c64xx.c                          | 123 ++--
 drivers/spi/spi-sh.c                               |  94 +---
 drivers/spi/spi-sifive.c                           |  39 ++
 drivers/spi/spi-stm32-qspi.c                       |  18 +-
 drivers/spi/spi-synquacer.c                        |   1 +
 drivers/spi/spi-tegra20-slink.c                    |   3 +-
 drivers/spi/spi-tegra210-quad.c                    |  33 +-
 drivers/spi/spi-ti-qspi.c                          |  75 +--
 drivers/spi/spi-topcliff-pch.c                     |  30 +-
 drivers/spi/spi-zynqmp-gqspi.c                     |  25 +-
 drivers/spi/spi.c                                  | 566 +++++++++++--------
 include/linux/spi/spi.h                            | 169 +++---
 tools/spi/spidev_test.c                            |  11 +
 55 files changed, 2183 insertions(+), 757 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi_atmel.txt
 create mode 100644 drivers/spi/spi-gxp.c
 create mode 100644 drivers/spi/spi-microchip-core.c
