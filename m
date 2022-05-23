Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E0D530E24
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbiEWJZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbiEWJZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:25:08 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4964F488A2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:25:03 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C8787240016;
        Mon, 23 May 2022 09:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653297902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CSpj4P3cSa7Eoa9aH/nytSU+/0+KVCKfLPgNmaULh7U=;
        b=D2poIJLdGXrHrsoUYftpiVy16i9liEGmxShcmfhFTT1X/KF8nIpJjIBUGLOyLatCLBrMGq
        NH4+Ke9M55X4U9XIwXppMfKR0DRJGJPsAxRQmGLD0IroFLN1dT6mzX/NlEfZ7uSC1txzWQ
        53zzDQxr2/6k0w2xk0BZCsMUtJMar1oM9p8BvSyNPUVcTRZb5IOdOyxODjsUyBijPVQCx/
        CobiHCmwHVdYFzwP+AVG93ZH+cUvDCAB5oMxb3uPuwQX0/xkSgfT0rwJnF+UVkBW4ATQRc
        KGCtDe2s7jzBlUQ9lFid/FwPwd8ivufAe6q2w1nnUaRp5N5WwpBC5YYQ1KKsgw==
Date:   Mon, 23 May 2022 11:24:59 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Changes for 5.19
Message-ID: <20220523112459.29000c2d@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is the MTD PR for 5.19-rc1.

Thanks,
Miqu=C3=A8l

The following changes since commit b2d229d4ddb17db541098b83524d901257e93845:

  Linux 5.18-rc3 (2022-04-17 13:57:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-=
5.19

for you to fetch changes up to 2c51d0d88020b4d3c9bbe7d9df2796b2c2ce05b8:

  Merge tag 'nand/for-5.19' into mtd/next (2022-05-20 13:59:25 +0200)

----------------------------------------------------------------
MTD core changes:
* Call of_platform_populate() for MTD partitions
* Check devicetree alias for index
* mtdoops:
  - Add a timestamp to the mtdoops header.
  - Create a header structure for the saved mtdoops.
  - Fix the size of the header read buffer.
* mtdblock: Warn if opened on NAND
* Bindings:
  - reserved-memory: Support MTD/block device
  - jedec,spi-nor: remove unneeded properties
  - Extend fixed-partitions binding
  - Add Sercomm (Suzhou) Corporation vendor prefix

MTD driver changes:
* st_spi_fsm: add missing clk_disable_unprepare() in stfsm_remove()
* phram:
  - Allow cached mappings
  - Allow probing via reserved-memory
* maps: ixp4xx: Drop driver
* bcm47xxpart: Print correct offset on read error

CFI driver changes:
* Rename chip_ready variables
* Add S29GL064N ID definition
* Use chip_ready() for write on S29GL064N
* Move and rename chip_check/chip_ready/chip_good_for_write

NAND core changes:
* Print offset instead of page number for bad blocks

Raw NAND controller drivers:
* Cadence: Fix possible null-ptr-deref in cadence_nand_dt_probe()
* CS553X: simplify the return expression of cs553x_write_ctrl_byte()
* Davinci: Remove redundant unsigned comparison to zero
* Denali: Use managed device resources
* GPMI:
  - Add large oob bch setting support
  - Rename the variable ecc_chunk_size
  - Uninline the gpmi_check_ecc function
  - Add strict ecc strength check
  - Refactor BCH geometry settings function
* Intel: Fix possible null-ptr-deref in ebu_nand_probe()
* MPC5121: Check before clk_disable_unprepare() not needed
* Mtk:
  - MTD_NAND_ECC_MEDIATEK should depend on ARCH_MEDIATEK
  - Also parse the default nand-ecc-engine property if available
  - Make mtk_ecc.c a separated module
* OMAP ELM:
  - Convert the bindings to yaml
  - Describe the bindings for AM64 ELM
  - Add support for its compatible
* Renesas: Use runtime PM instead of the raw clock API and update the
           bindings accordingly
* Rockchip: Check before clk_disable_unprepare() not needed
* TMIO: Check return value after calling platform_get_resource()

Raw NAND chip driver:
* Kioxia: Add support for TH58NVG3S0HBAI4 and TC58NVG0S3HTA00

SPI-NAND chip drivers:
* Gigadevice:
  - Add support for:
    - GD5FxGM7xExxG
    - GD5F{2,4}GQ5xExxG
    - GD5F1GQ5RExxG
    - GD5FxGQ4xExxG
  - Fix Quad IO for GD5F1GQ5UExxG
* XTX: Add support for XT26G0xA

SPI NOR core changes:
* Read back written SR value to make sure the write was done correctly.
* Introduce a common function for Read ID that manufacturer drivers can
  use to verify the Octal DTR switch worked correctly.
* Add helpers for read/write any register commands so manufacturer
  drivers don't open code it every time.
* Clarify rdsr dummy cycles documentation.
* Add debugfs entry to expose internal flash parameters and state.

SPI NOR manufacturer drivers changes:
* Add support for Winbond W25Q512NW-IM, and Eon EN25QH256A.
* Move spi_nor_write_ear() to Winbond module since only Winbond flashes
  use it.
* Rework Micron and Cypress Octal DTR enable methods to improve
  readability.
* Use the common Read ID function to verify switch to Octal DTR mode for
  Micron and Cypress flashes.
* Skip polling status on volatile register writes for Micron and Cypress
  flashes since the operation is instant.

----------------------------------------------------------------
Andreas B=C3=B6hler (1):
      mtd: rawnand: add support for Toshiba TC58NVG0S3HTA00 NAND flash

Bj=C3=B8rn Mork (1):
      mtdblock: warn if opened on NAND

Chen-Tsung Hsieh (1):
      mtd: spi-nor: core: Check written SR value in spi_nor_write_16bit_sr_=
and_check()

Chuanhong Guo (7):
      mtd: spinand: gigadevice: fix Quad IO for GD5F1GQ5UExxG
      mtd: spinand: gigadevice: add support for GD5FxGQ4xExxG
      mtd: spinand: gigadevice: add support for GD5F1GQ5RExxG
      mtd: spinand: gigadevice: add support for GD5F{2, 4}GQ5xExxG
      mtd: spinand: gigadevice: add support for GD5FxGM7xExxG
      mtd: nand: make mtk_ecc.c a separated module
      mtd: nand: mtk-ecc: also parse nand-ecc-engine if available

Felix Matouschek (1):
      mtd: spinand: Add support for XTX XT26G0xA

Geert Uytterhoeven (1):
      mtd: nand: MTD_NAND_ECC_MEDIATEK should depend on ARCH_MEDIATEK

Han Xu (5):
      mtd: rawnand: gpmi: Refactor bch geometry settings function
      mtd: rawnand: gpmi: Add strict ecc strength check
      mtd: rawnand: gpmi: Uninline the gpmi_check_ecc function
      mtd: rawnand: gpmi: Rename the variable ecc_chunk_size
      mtd: rawnand: gpmi: Add large oob bch setting support

Jean-Marc Eurin (3):
      mtd: mtdoops: Fix the size of the header read buffer.
      mtd: mtdoops: Create a header structure for the saved mtdoops.
      mtd: mtdoops: Add a timestamp to the mtdoops header.

Krzysztof Kozlowski (1):
      dt-bindings: mtd: jedec, spi-nor: remove unneeded properties

Leon M. George (1):
      mtd: spi-nor: support eon en25qh256a variant

Linus Walleij (1):
      mtd: maps: ixp4xx: Drop driver

Michael Walle (5):
      mtd: spi-nor: amend the rdsr dummy cycles documentation
      mtd: spi-nor: move spi_nor_write_ear() to winbond module
      mtd: spi-nor: export spi_nor_hwcaps_pp2cmd()
      mtd: spi-nor: expose internal parameters via debugfs
      mtd: spi-nor: debugfs: fix format specifier

Mikhail Zhilkin (2):
      dt-bindings: Add Sercomm (Suzhou) Corporation vendor prefix
      dt-bindings: mtd: partitions: Extend fixed-partitions binding

Minghao Chi (1):
      mtd: rawnand: cs553x: simplify the return expression of cs553x_write_=
ctrl_byte()

Miquel Raynal (5):
      Merge tag 'mtd/mtk-spi-nand-for-5.19' into nand/next
      dt-bindings: mtd: renesas: Fix the NAND controller description
      mtd: rawnand: renesas: Use runtime PM instead of the raw clock API
      Merge tag 'spi-nor/for-5.19' into mtd/next
      Merge tag 'nand/for-5.19' into mtd/next

Phil Edworthy (2):
      mtd: rawnand: rockchip: Check before clk_disable_unprepare() not need=
ed
      mtd: rawnand: mpc5121: Check before clk_disable_unprepare() not needed

Rafa=C5=82 Mi=C5=82ecki (3):
      mtd: parsers: bcm47xxpart: print correct offset on read error
      mtd: rawnand: print offset instead of page number for bad blocks
      mtd: call of_platform_populate() for MTD partitions

Rickard x Andersson (1):
      mtd: rawnand: kioxia: Add support for TH58NVG3S0HBAI4

Roger Quadros (3):
      dt-bindings: mtd: ti,elm: Convert to yaml
      dt-bindings: mtd: ti,elm: Add support for AM64 ELM
      mtd: rawnand: omap_elm: Add compatible for AM64 ELM

Shaik Sajida Bhanu (1):
      mtd: spi-nor: winbond: add support for W25Q512NW-IM

Tokunori Ikegami (4):
      mtd: cfi_cmdset_0002: Move and rename chip_check/chip_ready/chip_good=
_for_write
      mtd: cfi_cmdset_0002: Use chip_ready() for write on S29GL064N
      mtd: cfi_cmdset_0002: Add S29GL064N ID definition
      mtd: cfi_cmdset_0002: Rename chip_ready variables

Tudor Ambarus (11):
      mtd: spi-nor: Rename method, s/spi_nor_match_id/spi_nor_match_name
      mtd: spi-nor: Introduce spi_nor_match_id()
      mtd: spi-nor: core: Use auto-detection only once
      mtd: spi-nor: core: Introduce method for RDID op
      mtd: spi-nor: manufacturers: Use spi_nor_read_id() core method
      mtd: spi-nor: core: Add helpers to read/write any register
      mtd: spi-nor: micron-st: Rework spi_nor_micron_octal_dtr_enable()
      mtd: spi-nor: spansion: Rework spi_nor_cypress_octal_dtr_enable()
      mtd: spi-nor: Introduce templates for SPI NOR operations
      mtd: spi-nor: spansion: Remove status polling on volatile registers w=
rite
      mtd: spi-nor: micron-st: Remove status polling on volatile registers =
write

Vincent Whitchurch (4):
      mtd: core: Check devicetree alias for index
      dt-bindings: reserved-memory: Support MTD/block device
      mtd: phram: Allow probing via reserved-memory
      mtd: phram: Allow cached mappings

Wang Weiyang (1):
      mtd: rawnand: davinci: Remove redundant unsigned comparison to zero

Yang Yingliang (4):
      mtd: rawnand: cadence: fix possible null-ptr-deref in cadence_nand_dt=
_probe()
      mtd: rawnand: intel: fix possible null-ptr-deref in ebu_nand_probe()
      mtd: rawnand: tmio: check return value after calling platform_get_res=
ource()
      mtd: st_spi_fsm: add missing clk_disable_unprepare() in stfsm_remove()

Zheyu Ma (1):
      mtd: rawnand: denali: Use managed device resources

 Documentation/devicetree/bindings/mtd/elm.txt                   |  16 --
 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml        |   8 -
 .../devicetree/bindings/mtd/partitions/fixed-partitions.yaml    |  55 ++++=
+-
 Documentation/devicetree/bindings/mtd/renesas-nandc.yaml        |   5 +
 Documentation/devicetree/bindings/mtd/ti,elm.yaml               |  72 ++++=
+++
 Documentation/devicetree/bindings/reserved-memory/phram.yaml    |  47 +++++
 Documentation/devicetree/bindings/vendor-prefixes.yaml          |   2 +
 drivers/mtd/chips/cfi_cmdset_0002.c                             | 112 ++++=
+------
 drivers/mtd/devices/phram.c                                     | 108 ++++=
+++++-
 drivers/mtd/devices/st_spi_fsm.c                                |   2 +
 drivers/mtd/maps/Kconfig                                        |   9 -
 drivers/mtd/maps/Makefile                                       |   1 -
 drivers/mtd/maps/ixp4xx.c                                       | 262 ----=
--------------------
 drivers/mtd/mtdblock.c                                          |   8 +-
 drivers/mtd/mtdcore.c                                           |  11 +-
 drivers/mtd/mtdoops.c                                           |  61 +++-=
--
 drivers/mtd/mtdpart.c                                           |   9 +
 drivers/mtd/nand/Kconfig                                        |   8 +
 drivers/mtd/nand/Makefile                                       |   1 +
 drivers/mtd/nand/{raw/mtk_ecc.c =3D> ecc-mtk.c}                   |   8 +-
 drivers/mtd/nand/raw/Kconfig                                    |   1 +
 drivers/mtd/nand/raw/Makefile                                   |   2 +-
 drivers/mtd/nand/raw/cadence-nand-controller.c                  |   5 +-
 drivers/mtd/nand/raw/cs553x_nand.c                              |   7 +-
 drivers/mtd/nand/raw/davinci_nand.c                             |   2 +-
 drivers/mtd/nand/raw/denali_pci.c                               |  15 +-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c                      | 296 ++++=
++++++++++++++++++++----
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h                      |  12 +-
 drivers/mtd/nand/raw/intel-nand-controller.c                    |   2 +-
 drivers/mtd/nand/raw/mpc5121_nfc.c                              |   3 +-
 drivers/mtd/nand/raw/mtk_nand.c                                 |   2 +-
 drivers/mtd/nand/raw/nand_base.c                                |   9 +-
 drivers/mtd/nand/raw/nand_ids.c                                 |   6 +
 drivers/mtd/nand/raw/nand_toshiba.c                             |   6 +-
 drivers/mtd/nand/raw/omap_elm.c                                 |   1 +
 drivers/mtd/nand/raw/renesas-nand-controller.c                  |  51 +++--
 drivers/mtd/nand/raw/rockchip-nand-controller.c                 |  20 +-
 drivers/mtd/nand/raw/tmio_nand.c                                |   3 +
 drivers/mtd/nand/spi/Makefile                                   |   2 +-
 drivers/mtd/nand/spi/core.c                                     |   1 +
 drivers/mtd/nand/spi/gigadevice.c                               | 158 ++++=
++++++++++-
 drivers/mtd/nand/spi/xtx.c                                      | 129 ++++=
++++++++
 drivers/mtd/parsers/bcm47xxpart.c                               |   2 +-
 drivers/mtd/spi-nor/Makefile                                    |   1 +
 drivers/mtd/spi-nor/core.c                                      | 286 ++++=
+++++++++--------------
 drivers/mtd/spi-nor/core.h                                      | 123 ++++=
+++++++-
 drivers/mtd/spi-nor/debugfs.c                                   | 249 ++++=
+++++++++++++++++++
 drivers/mtd/spi-nor/eon.c                                       |   3 +-
 drivers/mtd/spi-nor/micron-st.c                                 | 181 ++++=
++++---------
 drivers/mtd/spi-nor/spansion.c                                  | 187 ++++=
+++++---------
 drivers/mtd/spi-nor/winbond.c                                   |  45 ++++-
 drivers/mtd/spi-nor/xilinx.c                                    |  12 +-
 drivers/of/platform.c                                           |   1 +
 include/linux/mtd/cfi.h                                         |   1 +
 .../mtd/nand/raw/mtk_ecc.h =3D> include/linux/mtd/nand-ecc-mtk.h  |   0
 include/linux/mtd/spi-nor.h                                     |   4 +-
 include/linux/mtd/spinand.h                                     |   1 +
 57 files changed, 1772 insertions(+), 862 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/elm.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/ti,elm.yaml
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/phram=
.yaml
 delete mode 100644 drivers/mtd/maps/ixp4xx.c
 rename drivers/mtd/nand/{raw/mtk_ecc.c =3D> ecc-mtk.c} (98%)
 create mode 100644 drivers/mtd/nand/spi/xtx.c
 create mode 100644 drivers/mtd/spi-nor/debugfs.c
 rename drivers/mtd/nand/raw/mtk_ecc.h =3D> include/linux/mtd/nand-ecc-mtk.=
h (100%)
