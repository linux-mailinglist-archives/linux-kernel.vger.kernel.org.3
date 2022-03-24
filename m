Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5F94E6110
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349215AbiCXJ1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiCXJ1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:27:16 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9D66D4FD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:25:42 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 400E51C000D;
        Thu, 24 Mar 2022 09:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1648113941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=iLaYjuI0ghcZeOe/8bQP5tuGxnVtliMrfkL/x84b/Do=;
        b=eGwoGr+lAnfVLwr81FsrcgtOBWcrh20sQ6P2oiZ9tHvlGTIUTJhiLY8tDS7SdwfMj2kFYw
        XHpIdl1zVsjAvDM0+GIFDi2N3cb7CkdV8Ja0VkiuvwI/+idYDDHyAcPvSkiLuERZy2cYO2
        Pgbth/H18IbSr9MDBj1sZBrAuypZ+h0q7H5JtJsu0ESPfwA8ttv8hWH+nP17kB/EGO078r
        /nzlvIY6oxeb4m1WRkCGr04XlSGSqMM1FbYFc2xfuaqb0zP0nlXbijHnB7Gtk32DzEhbEx
        SzeHcuoCz0z0xVCXF0DUiOatOAiBJycmK4PALDJ9ptXiwVuHQ8cXPPDXl/NmHg==
Date:   Thu, 24 Mar 2022 10:25:37 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Changes for 5.18
Message-ID: <20220324102537.074f3a73@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is the MTD PR for 5.18-rc1. As you can see, there has been a lot
of activity in the MTD subsystem recently, with a number of SPI-NOR
cleanups as well as the introduction of ECC engines that can be used by
SPI controllers (hence a few SPI patches in this PR).

Thanks,
Miqu=C3=A8l


The following changes since commit cfb92440ee71adcc2105b0890bb01ac3cddb8507:

  Linux 5.17-rc5 (2022-02-20 13:07:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/chan=
ges-for-5.18

for you to fetch changes up to 6cadd424abb63120f8346a4509dc43bddc9401d3:

  Merge tag 'nand/for-5.18' into mtd/next (2022-03-23 18:08:03 +0100)

----------------------------------------------------------------
Core MTD changes:
* Replace the expert mode symbols with a single helper
* Fix misuses of of_match_ptr()
* Remove partid and partname debugfs files
* tests: Fix eraseblock read speed miscalculation for lower partition sizes
* TRX parser: Allow to use on MediaTek MIPS SoCs

MTD driver changes:
* spear_smi: use GFP_KERNEL
* mchp48l640: Add SPI ID table
* mchp23k256: Add SPI ID table
* blkdevs: Avoid soft lockups with some mtd/spi devices
* aspeed-smc: Improve probe resilience

Hyperbus changes:
* HBMC_AM654 should depend on ARCH_K3

NAND core changes:
* ECC:
  - Add infrastructure to support hardware engines
  - Add a new helper to retrieve the ECC context
  - Provide a helper to retrieve a pilelined engine device

NAND-ECC changes:
* Macronix ECC engine:
  - Add Macronix external ECC engine support
  - Support SPI pipelined mode
  - Make two read-only arrays static const
  - Fix compile test issue

Raw NAND core changes:
* Fix misuses of of_match_node()
* Rework of_get_nand_bus_width()
* Remove of_get_nand_on_flash_bbt() wrapper
* Protect access to rawnand devices while in suspend
* bindings: Document the wp-gpios property

Rax NAND controller driver changes:
* atmel: Fix refcount issue in atmel_nand_controller_init
* nandsim:
  - Add NS_PAGE_BYTE_SHIFT macro to replace the repeat pattern
  - Merge repeat codes in ns_switch_state
  - Replace overflow check with kzalloc to single kcalloc
* rockchip: Fix platform_get_irq.cocci warning
* stm32_fmc2: Add NAND Write Protect support
* pl353: Set the nand chip node as the flash node
* brcmnand: Fix sparse warnings in bcma_nand
* omap_elm: Remove redundant variable 'errors'
* gpmi:
  - Support fast edo timings for mx28
  - Validate controller clock rate
  - Fix controller timings setting
* brcmnand:
  - Add BCMA shim
  - BCMA controller uses command shift of 0
  - Allow platform data instantation
  - Add platform data structure for BCMA
  - Allow working without interrupts
  - Move OF operations out of brcmnand_init_cs()
  - Avoid pdev in brcmnand_init_cs()
  - Allow SoC to provide I/O operations
  - Assign soc as early as possible

Onenand changes:
* Check for error irq

SPI-NAND core changes:
* Delay a little bit the dirmap creation
* Create direct mapping descriptors for ECC operations

SPI-NAND driver changes:
* macronix: Use random program load

SPI NOR core changes:
* Move vendor specific code out of the core into vendor drivers.
* Unify all function and object names in the vendor modules.
* Make setup() callback optional to improve readability.
* Skip erase logic when the SPI_NOR_NO_ERASE flag is set at flash
  declaration.

SPI changes:
* Macronix SPI controller:
  - Fix the transmit path
  - Create a helper to configure the controller before an operation
  - Create a helper to ease the start of an operation
  - Add support for direct mapping
  - Add support for pipelined ECC operations
* spi-mem:
  - Introduce a capability structure
  - Check the controller extra capabilities
  - cadence-quadspi/mxic: Provide capability structures
  - Kill the spi_mem_dtr_supports_op() helper
  - Add an ecc parameter to the spi_mem_op structure

Binding changes:
* Dropped mtd/cortina,gemini-flash.txt
* Convert BCM47xx partitions to json-schema
* Vendor prefixes: Clarify Macronix prefix
* SPI NAND: Convert spi-nand description file to yaml
* Raw NAND chip: Create a NAND chip description
* Raw NAND controller:
  - Harmonize the property types
  - Fix a comment in the examples
  - Fix the reg property description
* Describe Macronix NAND ECC engine
* Macronix SPI controller:
  - Document the nand-ecc-engine property
  - Convert to yaml
  - The interrupt property is not mandatory

----------------------------------------------------------------
Amit Kumar Mahapatra (2):
      mtd: rawnand: pl353: Set the nand chip node as the flash node
      mtd: tests: Fix eraseblock read speed miscalculation for lower partit=
ion sizes

Christophe Kerello (2):
      dt-binding: mtd: nand: Document the wp-gpios property
      mtd: rawnand: stm32_fmc2: Add NAND Write Protect support

Colin Ian King (2):
      mtd: rawnand: omap_elm: remove redundant variable 'errors'
      mtd: nand: mxic-ecc: make two read-only arrays static const

Corentin Labbe (1):
      dt-bindings: mtd: drop mtd/cortina,gemini-flash.txt

Dario Binacchi (3):
      mtd: rawnand: gpmi: fix controller timings setting
      mtd: rawnand: gpmi: validate controller clock rate
      mtd: rawnand: gpmi: support fast edo timings for mx28

David Decotigny (1):
      mtd_blkdevs: avoid soft lockups with some mtd/spi devices

Florian Fainelli (10):
      mtd: rawnand: brcmnand: Assign soc as early as possible
      mtd: rawnand: brcmnand: Allow SoC to provide I/O operations
      mtd: rawnand: brcmnand: Avoid pdev in brcmnand_init_cs()
      mtd: rawnand: brcmnand: Move OF operations out of brcmnand_init_cs()
      mtd: rawnand: brcmnand: Allow working without interrupts
      mtd: rawnand: brcmnand: Add platform data structure for BCMA
      mtd: rawnand: brcmnand: Allow platform data instantation
      mtd: rawnand: brcmnand: BCMA controller uses command shift of 0
      mtd: rawnand: brcmnand: Add BCMA shim
      mtd: rawnand: brcmnand: Fix sparse warnings in bcma_nand

Geert Uytterhoeven (1):
      mtd: hyperbus: HBMC_AM654 should depend on ARCH_K3

INAGAKI Hiroshi (1):
      mtd: parsers: trx: allow to use on MediaTek MIPS SoCs

Jiasheng Jiang (1):
      mtd: onenand: Check for error irq

Julia Lawall (1):
      mtd: spear_smi: use GFP_KERNEL

Mark Brown (2):
      mtd: mchp23k256: Add SPI ID table
      mtd: mchp48l640: Add SPI ID table

Mason Yang (1):
      mtd: spinand: macronix: Use random program load

Michael Walle (32):
      mtd: spi-nor: atmel: unify function names
      mtd: spi-nor: catalyst: unify function names
      mtd: spi-nor: eon: unify function names
      mtd: spi-nor: esmt: unify function names
      mtd: spi-nor: everspin: unify function names
      mtd: spi-nor: fujitsu: unify function names
      mtd: spi-nor: gigadevice: unify function names
      mtd: spi-nor: intel: unify function names
      mtd: spi-nor: issi: unify function names
      mtd: spi-nor: macronix: unify function names
      mtd: spi-nor: micron-st: unify function names
      mtd: spi-nor: spansion: unify function names
      mtd: spi-nor: sst: unify function names
      mtd: spi-nor: winbond: unify function names
      mtd: spi-nor: xilinx: unify function names
      mtd: spi-nor: xmc: unify function names
      mtd: spi-nor: slightly refactor the spi_nor_setup()
      mtd: spi-nor: allow a flash to define its own ready() function
      mtd: spi-nor: export more functions to be used in vendor modules
      mtd: spi-nor: guard _page_size parameter in S3AN_INFO()
      mtd: spi-nor: move all xilinx specifics into xilinx.c
      mtd: spi-nor: xilinx: rename vendor specific functions and defines
      mtd: spi-nor: xilinx: correct the debug message
      mtd: spi-nor: move all micron-st specifics into micron-st.c
      mtd: spi-nor: micron-st: convert USE_FSR to a manufacturer flag
      mtd: spi-nor: micron-st: rename vendor specific functions and defines
      mtd: spi-nor: spansion: slightly rework control flow in late_init()
      mtd: spi-nor: move all spansion specifics into spansion.c
      mtd: spi-nor: spansion: convert USE_CLSR to a manufacturer flag
      mtd: spi-nor: spansion: rename vendor specific functions and defines
      mtd: spi-nor: slightly change code style in spi_nor_sr_ready()
      mtd: spi-nor: renumber flags

Miquel Raynal (35):
      dt-bindings: mtd: nand-controller: Fix the reg property description
      dt-bindings: mtd: nand-controller: Fix a comment in the examples
      dt-bindings: mtd: nand-controller: Harmonize the property types
      dt-bindings: mtd: nand-chip: Create a NAND chip description
      dt-bindings: mtd: spi-nand: Convert spi-nand description file to yaml
      dt-bindings: vendor-prefixes: Clarify Macronix prefix
      dt-bindings: spi: mxic: The interrupt property is not mandatory
      dt-bindings: spi: mxic: Convert to yaml
      dt-bindings: spi: mxic: Document the nand-ecc-engine property
      dt-bindings: mtd: Describe Macronix NAND ECC engine
      mtd: nand: ecc: Add infrastructure to support hardware engines
      mtd: nand: Add a new helper to retrieve the ECC context
      mtd: Fix misuses of of_match_ptr()
      mtd: rawnand: Fix misuses of of_match_node()
      mtd: Replace the expert mode symbols with a single helper
      mtd: nand: mxic-ecc: Add Macronix external ECC engine support
      mtd: nand: ecc: Provide a helper to retrieve a pilelined engine device
      mtd: nand: mxic-ecc: Support SPI pipelined mode
      spi: spi-mem: Introduce a capability structure
      spi: spi-mem: Check the controller extra capabilities
      spi: cadence-quadspi: Provide a capability structure
      spi: mxic: Provide a capability structure
      spi: spi-mem: Kill the spi_mem_dtr_supports_op() helper
      spi: spi-mem: Add an ecc parameter to the spi_mem_op structure
      mtd: spinand: Delay a little bit the dirmap creation
      mtd: spinand: Create direct mapping descriptors for ECC operations
      spi: mxic: Fix the transmit path
      spi: mxic: Create a helper to configure the controller before an oper=
ation
      spi: mxic: Create a helper to ease the start of an operation
      spi: mxic: Add support for direct mapping
      spi: mxic: Add support for pipelined ECC operations
      Merge tag 'mtd/spi-mem-ecc-for-5.18' into mtd/next
      mtd: nand: ecc: mxic: Fix compile test issue
      Merge tag 'spi-nor/for-5.18' into mtd/next
      Merge tag 'nand/for-5.18' into mtd/next

Patrick Williams (1):
      mtd: aspeed-smc: improve probe resilience

Rafa=C5=82 Mi=C5=82ecki (1):
      dt-bindings: mtd: partitions: convert BCM47xx to the json-schema

RinHizakura (3):
      mtd: rawnand: nandsim: Replace overflow check with kzalloc to single =
kcalloc
      mtd: rawnand: nandsim: Merge repeat codes in ns_switch_state
      mtd: rawnand: nandsim: Add NS_PAGE_BYTE_SHIFT macro to replace the re=
peat pattern

Sean Nyekjaer (1):
      mtd: rawnand: protect access to rawnand devices while in suspend

Tudor Ambarus (4):
      mtd: rawnand: Remove of_get_nand_on_flash_bbt() wrapper
      mtd: rawnand: Rework of_get_nand_bus_width()
      mtd: spi-nor: Skip erase logic when SPI_NOR_NO_ERASE is set
      mtd: core: Remove partid and partname debugfs files

Xin Xiong (1):
      mtd: rawnand: atmel: fix refcount issue in atmel_nand_controller_init

Yihao Han (1):
      mtd: rawnand: rockchip: fix platform_get_irq.cocci warning

 Documentation/devicetree/bindings/mtd/cortina,gemini-flash.txt            =
         |  24 ---
 Documentation/devicetree/bindings/mtd/mtd-physmap.yaml                    =
         |  18 +-
 Documentation/devicetree/bindings/mtd/mxicy,nand-ecc-engine.yaml          =
         |  77 +++++++++
 Documentation/devicetree/bindings/mtd/nand-chip.yaml                      =
         |  70 ++++++++
 Documentation/devicetree/bindings/mtd/nand-controller.yaml                =
         |  75 ++-------
 Documentation/devicetree/bindings/mtd/partitions/brcm,bcm947xx-cfe-partiti=
ons.txt  |  42 -----
 Documentation/devicetree/bindings/mtd/partitions/brcm,bcm947xx-cfe-partiti=
ons.yaml |  48 ++++++
 Documentation/devicetree/bindings/mtd/spi-nand.txt                        =
         |   5 -
 Documentation/devicetree/bindings/mtd/spi-nand.yaml                       =
         |  27 +++
 Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml              =
         |  65 ++++++++
 Documentation/devicetree/bindings/spi/spi-mxic.txt                        =
         |  34 ----
 Documentation/devicetree/bindings/vendor-prefixes.yaml                    =
         |   3 +
 MAINTAINERS                                                               =
         |   1 +
 drivers/bcma/driver_chipcommon_nflash.c                                   =
         |  20 ++-
 drivers/mtd/devices/mchp23k256.c                                          =
         |  16 +-
 drivers/mtd/devices/mchp48l640.c                                          =
         |  12 +-
 drivers/mtd/devices/spear_smi.c                                           =
         |   2 +-
 drivers/mtd/hyperbus/Kconfig                                              =
         |   2 +-
 drivers/mtd/mtd_blkdevs.c                                                 =
         |   1 +
 drivers/mtd/mtdcore.c                                                     =
         |  48 ++----
 drivers/mtd/nand/Kconfig                                                  =
         |   7 +
 drivers/mtd/nand/Makefile                                                 =
         |   1 +
 drivers/mtd/nand/core.c                                                   =
         |  12 +-
 drivers/mtd/nand/ecc-mxic.c                                               =
         | 879 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++
 drivers/mtd/nand/ecc.c                                                    =
         | 119 ++++++++++++++
 drivers/mtd/nand/onenand/generic.c                                        =
         |   7 +-
 drivers/mtd/nand/raw/Kconfig                                              =
         |  13 ++
 drivers/mtd/nand/raw/atmel/nand-controller.c                              =
         |  18 +-
 drivers/mtd/nand/raw/atmel/pmecc.c                                        =
         |   4 +-
 drivers/mtd/nand/raw/brcmnand/Makefile                                    =
         |   2 +
 drivers/mtd/nand/raw/brcmnand/bcma_nand.c                                 =
         | 132 +++++++++++++++
 drivers/mtd/nand/raw/brcmnand/brcmnand.c                                  =
         | 162 ++++++++++++------
 drivers/mtd/nand/raw/brcmnand/brcmnand.h                                  =
         |  29 ++++
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c                                =
         |  27 ++-
 drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c                           =
         |   2 +-
 drivers/mtd/nand/raw/ingenic/jz4780_bch.c                                 =
         |   2 +-
 drivers/mtd/nand/raw/mtk_ecc.c                                            =
         |   2 +-
 drivers/mtd/nand/raw/nand_base.c                                          =
         |  83 +++++-----
 drivers/mtd/nand/raw/nand_bbt.c                                           =
         |   2 +-
 drivers/mtd/nand/raw/nandsim.c                                            =
         |  47 ++----
 drivers/mtd/nand/raw/omap2.c                                              =
         |   2 +-
 drivers/mtd/nand/raw/omap_elm.c                                           =
         |   4 +-
 drivers/mtd/nand/raw/pl35x-nand-controller.c                              =
         |   2 +-
 drivers/mtd/nand/raw/renesas-nand-controller.c                            =
         |   2 +-
 drivers/mtd/nand/raw/rockchip-nand-controller.c                           =
         |   1 -
 drivers/mtd/nand/raw/sh_flctl.c                                           =
         |   2 +-
 drivers/mtd/nand/raw/stm32_fmc2_nand.c                                    =
         |  40 ++++-
 drivers/mtd/nand/spi/core.c                                               =
         |  51 ++++--
 drivers/mtd/nand/spi/macronix.c                                           =
         |   2 +-
 drivers/mtd/parsers/Kconfig                                               =
         |   2 +-
 drivers/mtd/spi-nor/atmel.c                                               =
         |  81 ++++-----
 drivers/mtd/spi-nor/catalyst.c                                            =
         |   6 +-
 drivers/mtd/spi-nor/controllers/aspeed-smc.c                              =
         |  15 +-
 drivers/mtd/spi-nor/core.c                                                =
         | 268 ++----------------------------
 drivers/mtd/spi-nor/core.h                                                =
         |  70 ++++----
 drivers/mtd/spi-nor/eon.c                                                 =
         |   6 +-
 drivers/mtd/spi-nor/esmt.c                                                =
         |   6 +-
 drivers/mtd/spi-nor/everspin.c                                            =
         |   6 +-
 drivers/mtd/spi-nor/fujitsu.c                                             =
         |   6 +-
 drivers/mtd/spi-nor/gigadevice.c                                          =
         |   6 +-
 drivers/mtd/spi-nor/intel.c                                               =
         |   6 +-
 drivers/mtd/spi-nor/issi.c                                                =
         |  10 +-
 drivers/mtd/spi-nor/macronix.c                                            =
         |  14 +-
 drivers/mtd/spi-nor/micron-st.c                                           =
         | 259 +++++++++++++++++++++++------
 drivers/mtd/spi-nor/spansion.c                                            =
         | 168 ++++++++++++++-----
 drivers/mtd/spi-nor/sst.c                                                 =
         |  44 ++---
 drivers/mtd/spi-nor/winbond.c                                             =
         |  29 ++--
 drivers/mtd/spi-nor/xilinx.c                                              =
         |  97 +++++++++--
 drivers/mtd/spi-nor/xmc.c                                                 =
         |   6 +-
 drivers/mtd/tests/speedtest.c                                             =
         |  11 +-
 drivers/spi/Kconfig                                                       =
         |   1 +
 drivers/spi/spi-cadence-quadspi.c                                         =
         |  10 +-
 drivers/spi/spi-mem.c                                                     =
         |  32 ++--
 drivers/spi/spi-mxic.c                                                    =
         | 340 +++++++++++++++++++++++++++++++-------
 include/linux/bcma/bcma_driver_chipcommon.h                               =
         |   5 +
 include/linux/mtd/mtd.h                                                   =
         |  11 +-
 include/linux/mtd/nand-ecc-mxic.h                                         =
         |  49 ++++++
 include/linux/mtd/nand.h                                                  =
         |  49 ++++++
 include/linux/mtd/rawnand.h                                               =
         |   2 +
 include/linux/mtd/spi-nor.h                                               =
         |  18 --
 include/linux/mtd/spinand.h                                               =
         |   2 +
 include/linux/platform_data/brcmnand.h                                    =
         |  12 ++
 include/linux/spi/spi-mem.h                                               =
         |  26 +--
 include/linux/spi/spi.h                                                   =
         |   3 +
 84 files changed, 2922 insertions(+), 1000 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/cortina,gemini-fl=
ash.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/mxicy,nand-ecc-en=
gine.yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/nand-chip.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/partitions/brcm,b=
cm947xx-cfe-partitions.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/brcm,b=
cm947xx-cfe-partitions.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi=
.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-mxic.txt
 create mode 100644 drivers/mtd/nand/ecc-mxic.c
 create mode 100644 drivers/mtd/nand/raw/brcmnand/bcma_nand.c
 create mode 100644 include/linux/mtd/nand-ecc-mxic.h
 create mode 100644 include/linux/platform_data/brcmnand.h
