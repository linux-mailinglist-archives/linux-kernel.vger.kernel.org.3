Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFBD58B0FC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237993AbiHEVBu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 5 Aug 2022 17:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbiHEVBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:01:49 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D1B120B8
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 14:01:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E699B615CC86;
        Fri,  5 Aug 2022 23:01:40 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3iyyf1dXrnE0; Fri,  5 Aug 2022 23:01:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 423FD61F1103;
        Fri,  5 Aug 2022 23:01:40 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id h96QZXm-UAyt; Fri,  5 Aug 2022 23:01:40 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1F970615CC86;
        Fri,  5 Aug 2022 23:01:40 +0200 (CEST)
Date:   Fri, 5 Aug 2022 23:01:40 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        miquel.raynal@bootlin.com, vigneshr@ti.com
Message-ID: <1047109049.69854.1659733300067.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] MTD changes for v5.20-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: asPtL/kLql9/4nWO0950+Wy6u7sp8g==
Thread-Topic: MTD changes for v5.20-rc1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9a:

  Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.20

for you to fetch changes up to 7ec4cdb321738d44ae5d405e7b6ac73dfbf99caa:

  mtd: core: check partition before dereference (2022-08-01 21:33:11 +0200)

----------------------------------------------------------------
MTD core changes:
* Dynamic partition support
* Fix deadlock in sm_ftl
* Various refcount fixes in maps, partitions and parser code
* Integer overflow fixes in mtdchar
* Support for Sercomm partitions

NAND driver changes:
* Clockrate fix for arasan
* Add ATO25D1GA support
* Double free fix for meson driver
* Fix probe/remove methods in cafe NAND
* Support unprotected spare data pages in qcom_nandc

SPI NOR core changes:
* move SECT_4K_PMC flag out of the core as it's a vendor specific flag
* s/addr_width/addr_nbytes: address width means the number of IO lines
used for the address, whereas in the code it is used as the number of
address bytes.
* do not change nor->addr_nbytes at SFDP parsing time. At the SFDP parsing
time we should not change members of struct spi_nor, but instead fill
members of struct spi_nor_flash_parameters which could later on be used
by the callers.
* track flash's internal address mode so that we can use 4B opcodes
together with opcodes that don't have a 4B opcode correspondent.

SPI NOR manufacturer drivers changes:
* esmt: Rename "f25l32qa" flash name to "f25l32qa-2s".
* micron-st: Skip FSR reading if SPI controller does not support it to
allow flashes that support FSR to work even when attached to such SPI
controllers.
* spansion: Add s25hl-t/s25hs-t IDs and fixups.

----------------------------------------------------------------
Aidan MacDonald (1):
      mtd: spinand: Add support for ATO25D1GA

Amit Kumar Mahapatra (1):
      mtd: rawnand: arasan: Update NAND bus clock instead of system clock

Christian Marangi (6):
      mtd: nand: raw: qcom_nandc: reorder qcom_nand_host struct
      mtd: nand: raw: qcom_nandc: add support for unprotected spare data pages
      dt-bindings: mtd: qcom_nandc: document qcom,boot-partitions binding
      dt-bindings: mtd: partitions: support label/name only partition
      dt-bindings: mtd: partitions: add additional example for qcom,smem-part
      mtd: core: introduce of support for dynamic partitions

Christophe JAILLET (1):
      mtd: rawnand: meson: Fix a potential double free issue

Duoming Zhou (1):
      mtd: sm_ftl: Fix deadlock caused by cancel_work_sync in sm_release

Geert Uytterhoeven (1):
      mtd: hyperbus: rpc-if: Fix RPM imbalance in probe error path

Jiang Jian (1):
      mtd: rawnand: sm_common: drop unexpected word 'is' in the comments

Mark Brown (1):
      mtd: dataflash: Add SPI ID table

Miaoqian Lin (4):
      mtd: maps: Fix refcount leak in of_flash_probe_versatile
      mtd: maps: Fix refcount leak in ap_flash_init
      mtd: partitions: Fix refcount leak in parse_redboot_of
      mtd: parsers: ofpart: Fix refcount leak in bcm4908_partitions_fw_offset

Michael Walle (1):
      mtd: spi-nor: move SECT_4K_PMC special handling

Michał Kępień (2):
      mtdchar: prevent integer overflow in a safety check
      mtdchar: use kvmalloc() for potentially large allocations

Mika Westerberg (1):
      mtd: spi-nor: micron-st: Skip FSR reading if SPI controller does not support it

Mikhail Zhilkin (1):
      mtd: parsers: add support for Sercomm partitions

Olga Kitaina (1):
      mtd: rawnand: arasan: Fix clock rate in NV-DDR

Patrice Chotard (1):
      mtd: spi-nor: fix spi_nor_spimem_setup_op() call in spi_nor_erase_{sector,chip}()

Peng Wu (1):
      mtd: rawnand: cafe: fix drivers probe/remove methods

Pratyush Yadav (1):
      MAINTAINERS: Use my kernel.org email

Richard Weinberger (2):
      Merge remote-tracking branch 'korg_git/nand/next' into mtd/next
      Merge tag 'spi-nor/for-5.20' into mtd/next

Rob Herring (1):
      dt-bindings: mtd: mxc-nand: Drop undocumented properties from example

Sungbo Eo (1):
      mtd: spi-nor: esmt: Use correct name of f25l32qa

Takahiro Kuwano (3):
      mtd: spi-nor: core: Return error code from set_4byte_addr_mode()
      mtd: spi-nor: spansion: Add local function to discover page size
      mtd: spi-nor: spansion: Add s25hl-t/s25hs-t IDs and fixups

Tetsuo Handa (1):
      mtd: core: check partition before dereference

Tudor Ambarus (4):
      mtd: spi-nor: s/addr_width/addr_nbytes
      mtd: spi-nor: core: Shrink the storage size of the flash_info's addr_nbytes
      mtd: spi-nor: Do not change nor->addr_nbytes at SFDP parsing time
      mtd: spi-nor: core: Track flash's internal address mode

Uwe Kleine-König (16):
      mtd: hyperbus: Make hyperbus_unregister_device() return void
      mtd: powernv_flash: Warn about failure to unregister mtd device
      mtd: lpddr2_nvm: Warn about failure to unregister mtd device
      mtd: spear_smi: Don't skip cleanup after mtd_device_unregister() failed
      mtd: spear_smi: Drop if with an always false condition
      mtd: rawnand: omap2: Suppress error message after WARN in .remove()
      mtd: rawnand: tegra: Don't skip cleanup after mtd_device_unregister() failed
      mtd: rawnand: meson: Don't skip cleanup after mtd_device_unregister() failed
      mtd: rawnand: meson: Drop cleaning platform data in .remove()
      mtd: physmap: Don't skip cleanup after mtd_device_unregister() failed
      mtd: physmap: Drop if with an always false condition
      mtd: rawnand: atmel: Warn about failure to unregister mtd device
      mtd: st_spi_fsm: Add a clk_disable_unprepare() in .probe()'s error path
      mtd: st_spi_fsm: Warn about failure to unregister mtd device
      mtd: st_spi_fsm: Disable clock only after device was unregistered
      mtd: st_spi_fsm: Simplify error checking in .probe() a bit

Yang Yingliang (1):
      mtd: parsers: scpart: add missing of_node_put() in scpart_parse()

 .../devicetree/bindings/mtd/mxc-nand.yaml          |   2 -
 .../bindings/mtd/partitions/partition.yaml         |  20 +-
 .../bindings/mtd/partitions/qcom,smem-part.yaml    |  27 ++
 .../devicetree/bindings/mtd/qcom,nandc.yaml        |  27 ++
 MAINTAINERS                                        |   2 +-
 drivers/mtd/devices/mtd_dataflash.c                |   8 +
 drivers/mtd/devices/powernv_flash.c                |   4 +-
 drivers/mtd/devices/spear_smi.c                    |  10 +-
 drivers/mtd/devices/st_spi_fsm.c                   |  23 +-
 drivers/mtd/hyperbus/hbmc-am654.c                  |   6 +-
 drivers/mtd/hyperbus/hyperbus-core.c               |   8 +-
 drivers/mtd/hyperbus/rpc-if.c                      |  13 +-
 drivers/mtd/lpddr/lpddr2_nvm.c                     |   4 +-
 drivers/mtd/maps/physmap-core.c                    |  13 +-
 drivers/mtd/maps/physmap-versatile.c               |   2 +
 drivers/mtd/mtdchar.c                              |  13 +-
 drivers/mtd/mtdcore.c                              |  63 +++++
 drivers/mtd/nand/raw/arasan-nand-controller.c      |  16 +-
 drivers/mtd/nand/raw/atmel/nand-controller.c       |   4 +-
 drivers/mtd/nand/raw/cafe_nand.c                   |   9 +-
 drivers/mtd/nand/raw/meson_nand.c                  |  17 +-
 drivers/mtd/nand/raw/omap2.c                       |   6 +-
 drivers/mtd/nand/raw/qcom_nandc.c                  | 306 +++++++++++++++++----
 drivers/mtd/nand/raw/sm_common.c                   |   2 +-
 drivers/mtd/nand/raw/tegra_nand.c                  |   5 +-
 drivers/mtd/nand/spi/Makefile                      |   2 +-
 drivers/mtd/nand/spi/ato.c                         |  86 ++++++
 drivers/mtd/nand/spi/core.c                        |   1 +
 drivers/mtd/parsers/Kconfig                        |   9 +
 drivers/mtd/parsers/Makefile                       |   1 +
 drivers/mtd/parsers/ofpart_bcm4908.c               |   3 +
 drivers/mtd/parsers/redboot.c                      |   1 +
 drivers/mtd/parsers/scpart.c                       | 249 +++++++++++++++++
 drivers/mtd/sm_ftl.c                               |   2 +-
 drivers/mtd/spi-nor/controllers/hisi-sfc.c         |   2 +-
 drivers/mtd/spi-nor/controllers/nxp-spifi.c        |   8 +-
 drivers/mtd/spi-nor/core.c                         |  70 +++--
 drivers/mtd/spi-nor/core.h                         |  21 +-
 drivers/mtd/spi-nor/debugfs.c                      |   2 +-
 drivers/mtd/spi-nor/esmt.c                         |   2 +-
 drivers/mtd/spi-nor/issi.c                         |  31 ++-
 drivers/mtd/spi-nor/micron-st.c                    |  12 +-
 drivers/mtd/spi-nor/otp.c                          |  12 +-
 drivers/mtd/spi-nor/sfdp.c                         |  34 +--
 drivers/mtd/spi-nor/spansion.c                     | 185 +++++++++++--
 drivers/mtd/spi-nor/xilinx.c                       |   2 +-
 include/linux/mtd/hyperbus.h                       |   4 +-
 include/linux/mtd/spi-nor.h                        |   4 +-
 include/linux/mtd/spinand.h                        |   1 +
 include/uapi/mtd/mtd-abi.h                         |   4 +-
 50 files changed, 1108 insertions(+), 250 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/ato.c
 create mode 100644 drivers/mtd/parsers/scpart.c
