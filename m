Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0504826EE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 08:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiAAHoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 02:44:22 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58006 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiAAHoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 02:44:15 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2017hs9c034659;
        Sat, 1 Jan 2022 01:43:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641023035;
        bh=yaG+MRp6i5Q9AgNtz6EkmbKt/8BQv9sW+DzhOTyeyS4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LOYJXjrzk4h0sLRJA6JKlrd3/AC7UjFB6I/UhkftrJF65PS5UPCSmw7PWaeXhLILI
         qeE6YrR0UcHmqYzWNbwDvLriCLLma2eRz6kkiFnNyf3j97eoPX9lKCuGMsuUrKN9TC
         KUPvz6j5UHoF9npBMPl6R21Lx8Uu6ndvgw1epiyY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2017hsI8039599
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 1 Jan 2022 01:43:54 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 1
 Jan 2022 01:43:54 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 1 Jan 2022 01:43:54 -0600
Received: from LT5CD112GSQZ.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2017gpwf033162;
        Sat, 1 Jan 2022 01:43:48 -0600
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
Subject: [PATCH v3 10/17] mtd: spinand: Add pointer to probed flash's spinand_info
Date:   Sat, 1 Jan 2022 13:12:43 +0530
Message-ID: <20220101074250.14443-11-a-nandan@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220101074250.14443-1-a-nandan@ti.com>
References: <20220101074250.14443-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The data_ops_variants and ctrl_ops_variants defined in manufacturer's
code are required again when changing flash modes, because they hold
the op templates for the new protocol. It would be useful to have a
pointer to the device description entry i.e. probed flash's
spinand_info table in the spinand_device struct itself.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/mtd/nand/spi/core.c | 1 +
 include/linux/mtd/spinand.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 9688fdfc174e..1a602e4dd6bd 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1107,6 +1107,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->flags = table[i].flags;
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
+		spinand->desc_entry = &table[i];
 
 		op = spinand_select_data_op_variant(spinand,
 					info->data_ops_variants.read_cache);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index ad924271a248..a8c071983a27 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -534,6 +534,8 @@ struct spinand_dirmap {
  *		passed in spi_mem_op be DMA-able, so we can't based the bufs on
  *		the stack
  * @manufacturer: SPI NAND manufacturer information
+ * @desc_entry: pointer to device description entry in the manufacturer's
+ *		spinand_info tables
  * @priv: manufacturer private data
  */
 struct spinand_device {
@@ -566,6 +568,7 @@ struct spinand_device {
 	u8 *oobbuf;
 	u8 *scratchbuf;
 	const struct spinand_manufacturer *manufacturer;
+	const struct spinand_info *desc_entry;
 	void *priv;
 };
 
-- 
2.25.1

