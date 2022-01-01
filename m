Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DBE4826DE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 08:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiAAHnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 02:43:46 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41820 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiAAHnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 02:43:45 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2017gv8e103728;
        Sat, 1 Jan 2022 01:42:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641022977;
        bh=pcQIy4e3o4+nMzvakDQ0s6AhMzKjUhVgfo34VY6QNfs=;
        h=From:To:CC:Subject:Date;
        b=x6ME+4rMf+8Ew7WLgjoI62z3iAeifE3tkfrVwx6xHAxgqtI58v4DPuWKAHU1z7AKz
         yNpXYTElfZGExz2feFv9Dq59p3pYXB/JGx/SqGU3NkgC+HZBhMYACdFdbrqPm6oGv7
         3E6JsqsTtXUt0L7uZ3kFzHK1bjPaV1PZCypzAT7o=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2017gvq4088985
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 1 Jan 2022 01:42:57 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 1
 Jan 2022 01:42:56 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 1 Jan 2022 01:42:56 -0600
Received: from LT5CD112GSQZ.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2017gpwV033162;
        Sat, 1 Jan 2022 01:42:52 -0600
From:   Apurva Nandan <a-nandan@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Apurva Nandan <a-nandan@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Alexander Lobakin <alobakin@pm.me>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC:     <p.yadav@ti.com>
Subject: [PATCH v3 00/17] mtd: spinand: Add Octal DTR SPI (8D-8D-8D) mode support
Date:   Sat, 1 Jan 2022 13:12:33 +0530
Message-ID: <20220101074250.14443-1-a-nandan@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This series proposes patches for adding the following functionality
in SPI NAND core:

- Octal DTR SPI (8D-8D-8D) mode support

- ctrl_ops support

- Winbond W35N01JW SPI NAND chip support

This series has been tested on TI J721e EVM with the Winbond W35N01JW
flash with following test utilities:

- nandtest
  Test log: https://pastebin.com/raw/PusiLYVQ

- mtd_stresstest
  Test log: https://pastebin.com/raw/gBtV2CAf

- UBIFS LTP stress test (NAND_XL_STRESS_DD_RW_UBIFS).
  Test log: https://pastebin.com/raw/J8WyLsz1

Datasheet: https://www.winbond.com/export/sites/winbond/datasheet/W35N01JW_Datasheet_Brief.pdf

---
Changes in v3:

- Added support for ctrl_ops, data_ops and ctrl_ops_variants.

- Made the implementation generic in terms of spinand protocol and SPI mode
  changes.

- Added option to disable Octal DTR mode.

- Removed spinand_patch_op(), adjust_op() manufacturer_op.

- Removed Power-on-Reset functionality and its call from mtd_suspend(), now 
  just disable Octal DTR at suspend.


Changes in v2:

- Removed *_ALL_ARGS() macros from spi-mem.h, and redefined DTR macros.

- Renamed spinand_setup_op() to spinand_patch_op(). Reduced one
  conditional check from this function. Had to keep tweaking in hot-path
  to avoid complicated implementation "hacks".

- Changes in commit messages and added comments.

- Dropped "Reject 8D-8D-8D op_templates if octal_dtr_enale() is
  missing in manufacturer_op" patch.

- Reduced PoR reset delay.

- Splitted "mtd: spinand: Add support for Winbond W35N01JW SPI NAND
  flash" into 3 independent patches.


Apurva Nandan (17):
  spi: spi-mem: Add DTR templates for cmd, address, dummy and data phase
  mtd: spinand: Define macros for Octal DTR ops
  mtd: spinand: Add enum spinand_protocol to indicate current SPI IO
    mode
  mtd: spinand: Rename 'op_templates' to 'data_ops'
  mtd: spinand: Define ctrl_ops for non-page read/write op templates
  mtd: spinand: Define default ctrl_ops in the core
  mtd: spinand: Switch from op macros usage to 'ctrl_ops' in the core
  mtd: spinand: Add support for manufacturer-based ctrl_ops variations
  mtd: spinand: Add change_mode() in manufacturer_ops
  mtd: spinand: Add pointer to probed flash's spinand_info
  mtd: spinand: Allow enabling/disabling Octal DTR mode in the core
  mtd: spinand: Add mtd_suspend() to disable Octal DTR mode at suspend
  mtd: spinand: winbond: Add support for write volatile configuration
    register op
  mtd: spinand: winbond: Add octal_dtr_enable/disable() in
    manufacturer_ops
  mtd: spianand: winbond: Add change_mode() manufacturer_ops
  mtd: spinand: winbond: Rename cache op_variants struct variable
  mtd: spinand: winbond: Add support for Winbond W35N01JW SPI NAND flash

 drivers/mtd/nand/spi/core.c    | 213 +++++++++++++++++++++++++----
 drivers/mtd/nand/spi/winbond.c | 242 +++++++++++++++++++++++++++++++--
 include/linux/mtd/spinand.h    | 154 +++++++++++++++++++--
 include/linux/spi/spi-mem.h    |  41 ++++++
 4 files changed, 599 insertions(+), 51 deletions(-)

-- 
2.25.1

