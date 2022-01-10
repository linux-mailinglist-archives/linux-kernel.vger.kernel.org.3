Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0683448968C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244085AbiAJKkM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jan 2022 05:40:12 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:51485 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244040AbiAJKkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:40:09 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 616A6240011;
        Mon, 10 Jan 2022 10:40:05 +0000 (UTC)
Date:   Mon, 10 Jan 2022 11:40:03 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Changes for 5.17
Message-ID: <20220110114003.7f297088@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is the MTD PR for v5.17-rc1.

Thanks,
Miquèl

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.17

for you to fetch changes up to 9ce47e43a0f088653aa25ca465836a84114e0940:

  Merge tag 'nand/for-5.17' into mtd/next (2021-12-31 13:31:34 +0100)

----------------------------------------------------------------
MTD core changes:
* mtdchar: Prevent unbounded allocation in MEMWRITE ioctl
* gen_probe: Use bitmap_zalloc() when applicable
* Introduce an expert mode for forensics and debugging purposes
* Clear out unregistered devices a bit more
* Provide unique name for nvmem device
* Remove unused header file <linux/mtd/latch-addr-flash.h>
* Fixed breaking list in __mtd_del_partition.

MTD device changes:
* sst25l, mchp48l640, mchp23k256, dataflash:
  - Warn about failure to unregister mtd device

Raw NAND core changes:
* Export nand_read_page_hwecc_oob_first()

GPMC memory controller for OMAP2 NAND controller changes:
* GPMC:
  - Add support for AM64 SoC and allow build on K3 platforms
  - Use a compatible match table when checking for NAND controller
  - Use platform_get_irq() to get the interrupt

Raw NAND controller changes:
* OMAP2 NAND controller:
  - Document the missing 'rb-gpios' DT property
  - Drop unused variable
  - Fix force_8bit flag behaviour for DMA mode
  - Move to exec_op interface
  - Use platform_get_irq() to get the interrupt
* Renesas:
  - Add new NAND controller driver with its bindings and MAINTAINERS entry
* Onenand:
  - Remove redundant variable ooblen
* MPC5121:
  - Remove unused variable in ads5121_select_chip()
* GPMI:
  - Add ERR007117 protection for nfc_apply_timings
  - Remove explicit default gpmi clock setting for i.MX6
  - Use platform_get_irq_byname() to get the interrupt
  - Remove unneeded variable
* Ingenic:
  - JZ4740 needs 'oob_first' read page function
* Davinci:
  - Rewrite function description
  - Avoid duplicated page read
  - Don't calculate ECC when reading page

SPI NOR core changes:
* Add Pratyush as SPI NOR co-maintainer.
* Flash parameters initialization was done in a spaghetti way. Clean
  flash parameters initialization.
* Rework the flash_info flags and clarify where one should be used.
* Initialize all flash parameters based on JESD216 SFDP where possible.
  Flash parameters and settings that are SFDP discoverable should not be
  duplicated via flash_info flags at flash declaration.
* Remove debugfs entries that duplicate sysfs entries.

SPI NOR manufacturer driver changes:
* Use late_init() hook in various drivers to make it clear that those
  flash parameters are either not declared in the JESD216 SFDP standard,
  or the SFDP tables which define those flash parameters are not defined
  by the flash.
* Fix mtd size for s3an flashes.
* Write 2 bytes when disabling Octal DTR mode: 1 byte long transactions are
  not allowed in 8D-8D-8D mode.

Hyperbus changes:
* Couple of fixes in Renesas hyperbus rpc-if driver to avoid crash on
  module remove and for missing check for error value in probe.

----------------------------------------------------------------
Andreas Oetken (1):
      mtd: Fixed breaking list in __mtd_del_partition.

Christian Eggers (1):
      mtd: rawnand: gpmi: Add ERR007117 protection for nfc_apply_timings

Christophe JAILLET (1):
      mtd: gen_probe: Use bitmap_zalloc() when applicable

Colin Ian King (1):
      mtd: onenand: remove redundant variable ooblen

Flavio Suligoi (1):
      mtd: spi-nor: core: Remove reference to spi-nor.c

Geert Uytterhoeven (1):
      mtd: rawnand: mpc5121: Remove unused variable in ads5121_select_chip()

George G. Davis (1):
      mtd: hyperbus: rpc-if: fix bug in rpcif_hb_remove

Jonathan Corbet (1):
      mtd: remove unused header file <linux/mtd/latch-addr-flash.h>

Lad Prabhakar (4):
      mtd: hyperbus: rpc-if: Check return value of rpcif_sw_init()
      memory: omap-gpmc: Use platform_get_irq() to get the interrupt
      mtd: rawnand: omap_elm: Use platform_get_irq() to get the interrupt
      mtd: rawnand: gpmi: Use platform_get_irq_byname() to get the interrupt

Michael Walle (1):
      mtd: core: provide unique name for nvmem device

Michał Kępień (1):
      mtdchar: prevent unbounded allocation in MEMWRITE ioctl

Minghao Chi (1):
      mtd: rawnand: gpmi: remove unneeded variable

Miquel Raynal (8):
      mtd: Introduce an expert mode for forensics and debugging purposes
      dt-bindings: mtd: renesas: Describe Renesas R-Car Gen3 & RZ/N1 NAND controller
      mtd: rawnand: renesas: Add new NAND controller driver
      MAINTAINERS: Add an entry for Renesas NAND controller
      Merge tag 'memory-controller-drv-omap-5.17' into nand/next
      Merge tag 'cfi/for-5.17' into mtd/next
      Merge tag 'spi-nor/for-5.17' into mtd/next
      Merge tag 'nand/for-5.17' into mtd/next

Paul Cercueil (5):
      mtd: rawnand: davinci: Don't calculate ECC when reading page
      mtd: rawnand: davinci: Avoid duplicated page read
      mtd: rawnand: davinci: Rewrite function description
      mtd: rawnand: Export nand_read_page_hwecc_oob_first()
      mtd: rawnand: ingenic: JZ4740 needs 'oob_first' read page function

Pratyush Yadav (4):
      MAINTAINERS: Add myself as SPI NOR co-maintainer
      mtd: spi-nor: core: use 2 data bytes for template ops
      mtd: spi-nor: spansion: write 2 bytes when disabling Octal DTR mode
      mtd: spi-nor: micron-st: write 2 bytes when disabling Octal DTR mode

Rob Herring (1):
      dt-bindings: mtd: ti,gpmc-nand: Add missing 'rb-gpios'

Roger Quadros (10):
      dt-bindings: mtd: ti, gpmc-nand: Add compatible for AM64 NAND
      mtd: rawnand: omap2: Allow build on K3 platforms
      mtd: rawnand: omap2: move to exec_op interface
      mtd: rawnand: omap2: Add compatible for AM64 SoC
      mtd: rawnand: omap2: fix force_8bit flag behaviour for DMA mode
      mtd: rawnand: omap2: drop unused variable
      dt-bindings: memory-controllers: ti,gpmc: Add compatible for AM64
      memory: omap-gpmc: Add support for GPMC on AM64 SoC
      memory: omap-gpmc: Use a compatible match table when checking for NAND controller
      mtd: rawnand: omap2: Select GPMC device driver for ARCH_K3

Stefan Riedmueller (1):
      mtd: rawnand: gpmi: Remove explicit default gpmi clock setting for i.MX6

Tudor Ambarus (26):
      mtd: spi-nor: core: Fix spi_nor_flash_parameter otp description
      mtd: spi-nor: core: Use container_of to get the pointer to struct spi_nor
      mtd: spi-nor: Get rid of nor->page_size
      mtd: spi-nor: core: Introduce the late_init() hook
      mtd: spi-nor: atmel: Use flash late_init() for locking
      mtd: spi-nor: sst: Use flash late_init() for locking
      mtd: spi-nor: winbond: Use manufacturer late_init() for OTP ops
      mtd: spi-nor: xilinx: Use manufacturer late_init() to set setup method
      mtd: spi-nor: sst: Use manufacturer late_init() to set _write()
      mtd: spi-nor: spansion: Use manufacturer late_init()
      mtd: spi-nor: Fix mtd size for s3an flashes
      mtd: spi-nor: core: Don't use mtd_info in the NOR's probe sequence of calls
      mtd: spi-nor: Introduce spi_nor_set_mtd_info()
      mtd: spi-nor: core: Call spi_nor_post_sfdp_fixups() only when SFDP is defined
      mtd: spi-nor: core: Introduce flash_info mfr_flags
      mtd: spi-nor: Rework the flash_info flags
      mtd: spi-nor: Introduce spi_nor_init_flags()
      mtd: spi-nor: Introduce spi_nor_init_fixup_flags()
      mtd: spi-nor: core: Init all flash parameters based on SFDP where possible
      mtd: spi-nor: core: Move spi_nor_set_addr_width() in spi_nor_setup()
      mtd: spi-nor: winbond: w25q256jvm: Init flash based on SFDP
      mtd: spi-nor: spansion: s25fl256s0: Skip SFDP parsing
      mtd: spi-nor: gigadevice: gd25q256: Init flash based on SFDP
      mtd: spi-nor: issi: is25lp256: Init flash based on SFDP
      mtd: spi-nor: Constify part specific fixup hooks
      mtd: spi-nor: Remove debugfs entries that duplicate sysfs entries

Uwe Kleine-König (4):
      mtd: dataflash: Warn about failure to unregister mtd device
      mtd: mchp23k256: Warn about failure to unregister mtd device
      mtd: mchp48l640: Warn about failure to unregister mtd device
      mtd: sst25l: Warn about failure to unregister mtd device

Zev Weiss (1):
      mtd: core: clear out unregistered devices a bit more

 Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml |   23 +-
 Documentation/devicetree/bindings/mtd/renesas-nandc.yaml          |   61 +++++
 Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml           |   10 +-
 MAINTAINERS                                                       |   10 +-
 drivers/memory/omap-gpmc.c                                        |   50 ++--
 drivers/mtd/chips/gen_probe.c                                     |    9 +-
 drivers/mtd/devices/mchp23k256.c                                  |    4 +-
 drivers/mtd/devices/mchp48l640.c                                  |    4 +-
 drivers/mtd/devices/mtd_dataflash.c                               |   10 +-
 drivers/mtd/devices/sst25l.c                                      |    4 +-
 drivers/mtd/hyperbus/rpc-if.c                                     |    8 +-
 drivers/mtd/mtdchar.c                                             |  110 +++++++--
 drivers/mtd/mtdcore.c                                             |   21 +-
 drivers/mtd/mtdpart.c                                             |    2 +-
 drivers/mtd/nand/core.c                                           |    3 +
 drivers/mtd/nand/onenand/onenand_bbt.c                            |    4 +-
 drivers/mtd/nand/raw/Kconfig                                      |   10 +-
 drivers/mtd/nand/raw/Makefile                                     |    1 +
 drivers/mtd/nand/raw/davinci_nand.c                               |   73 +-----
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c                        |   53 +++--
 drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c                   |    5 +
 drivers/mtd/nand/raw/mpc5121_nfc.c                                |    1 -
 drivers/mtd/nand/raw/nand_base.c                                  |   70 ++++++
 drivers/mtd/nand/raw/nand_bbt.c                                   |    3 +
 drivers/mtd/nand/raw/omap2.c                                      |  507 ++++++++++++++++++-----------------------
 drivers/mtd/nand/raw/omap_elm.c                                   |   16 +-
 drivers/mtd/nand/raw/renesas-nand-controller.c                    | 1424 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/atmel.c                                       |   79 ++++---
 drivers/mtd/spi-nor/catalyst.c                                    |   15 +-
 drivers/mtd/spi-nor/core.c                                        |  556 +++++++++++++++++++++++++--------------------
 drivers/mtd/spi-nor/core.h                                        |  209 ++++++++++-------
 drivers/mtd/spi-nor/eon.c                                         |   33 +--
 drivers/mtd/spi-nor/esmt.c                                        |   15 +-
 drivers/mtd/spi-nor/everspin.c                                    |   12 +-
 drivers/mtd/spi-nor/fujitsu.c                                     |    3 +-
 drivers/mtd/spi-nor/gigadevice.c                                  |   59 ++---
 drivers/mtd/spi-nor/intel.c                                       |   12 +-
 drivers/mtd/spi-nor/issi.c                                        |   62 ++---
 drivers/mtd/spi-nor/macronix.c                                    |  107 +++++----
 drivers/mtd/spi-nor/micron-st.c                                   |  224 ++++++++++--------
 drivers/mtd/spi-nor/otp.c                                         |    2 +-
 drivers/mtd/spi-nor/sfdp.c                                        |   20 ++
 drivers/mtd/spi-nor/spansion.c                                    |  184 ++++++++-------
 drivers/mtd/spi-nor/sst.c                                         |   96 +++++---
 drivers/mtd/spi-nor/swp.c                                         |    2 +-
 drivers/mtd/spi-nor/winbond.c                                     |  168 ++++++++------
 drivers/mtd/spi-nor/xilinx.c                                      |   21 +-
 drivers/mtd/spi-nor/xmc.c                                         |   10 +-
 include/linux/mtd/latch-addr-flash.h                              |   29 ---
 include/linux/mtd/mtd.h                                           |    3 +
 include/linux/mtd/rawnand.h                                       |    2 +
 include/linux/mtd/spi-nor.h                                       |    2 -
 include/linux/platform_data/mtd-nand-omap2.h                      |   10 +-
 53 files changed, 3124 insertions(+), 1307 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/renesas-nandc.yaml
 create mode 100644 drivers/mtd/nand/raw/renesas-nand-controller.c
 delete mode 100644 include/linux/mtd/latch-addr-flash.h
