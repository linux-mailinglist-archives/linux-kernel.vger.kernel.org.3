Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3094826E6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 08:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiAAHn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 02:43:58 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49304 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiAAHn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 02:43:56 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2017hKUw066361;
        Sat, 1 Jan 2022 01:43:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641023000;
        bh=v/jIaCrlEy5p0YTrPv7vUlZclUT2wBU4tUSlv6+EDEY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=PdXf+IdfWlDzdtC75/ynTMc7qjJpDJrUE/mJ2WHVQZHxDXBv4ED91zBHB4zRHD1Qy
         49IWgw2LPBDCVOoa1p4T/GSuyDReQFC3GqIQiheKnL1my7xb1SCxsSvHRNQ0/1myHx
         PzLEPjXLLD+KID9NhMm0Y8+Vi8SQnyDD20+TxoQk=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2017hKa6089644
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 1 Jan 2022 01:43:20 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 1
 Jan 2022 01:43:20 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 1 Jan 2022 01:43:20 -0600
Received: from LT5CD112GSQZ.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2017gpwZ033162;
        Sat, 1 Jan 2022 01:43:15 -0600
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
Subject: [PATCH v3 04/17] mtd: spinand: Rename 'op_templates' to 'data_ops'
Date:   Sat, 1 Jan 2022 13:12:37 +0530
Message-ID: <20220101074250.14443-5-a-nandan@ti.com>
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

Manufacturers have been deviating from the standard SPI operations for
NAND flashes. There have been variations in non-page read/write
instructions too. Additionally, operations, including non-page r/w ops,
vary when flash is in different SPI mode, eg. Octal DTR.

To avoid live-patching in hot-paths or vendor-specific adjustment,
it is better to have a set of operation templates and variants for
non-page read/write operations as well. These would get initialized at
the probe time or when flash changes modes. These would be called
'ctrl_ops'.

To make code better understandable, create two types of op templates
which are: data_ops and ctrl_ops. Reason for having two different type
of templates is the difference in their use cases i.e. it is possible
to have ops of different protocol for read/write/update simulatneously
in the data_ops, but all the ops in the ctrl_ops follow same protocol.

Rename op_templates to data_ops, and the ctrl_ops would be introduced
in later commits.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/mtd/nand/spi/core.c | 32 ++++++++++++++++----------------
 include/linux/mtd/spinand.h | 26 +++++++++++++-------------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 7d8c2873ab29..481516c9db79 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -184,9 +184,9 @@ static int spinand_init_quad_enable(struct spinand_device *spinand)
 	if (!(spinand->flags & SPINAND_HAS_QE_BIT))
 		return 0;
 
-	if (spinand->op_templates.read_cache->data.buswidth == 4 ||
-	    spinand->op_templates.write_cache->data.buswidth == 4 ||
-	    spinand->op_templates.update_cache->data.buswidth == 4)
+	if (spinand->data_ops.read_cache->data.buswidth == 4 ||
+	    spinand->data_ops.write_cache->data.buswidth == 4 ||
+	    spinand->data_ops.update_cache->data.buswidth == 4)
 		enable = true;
 
 	return spinand_upd_cfg(spinand, CFG_QUAD_ENABLE,
@@ -849,7 +849,7 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	/* The plane number is passed in MSB just above the column address */
 	info.offset = plane << fls(nand->memorg.pagesize);
 
-	info.op_tmpl = *spinand->op_templates.update_cache;
+	info.op_tmpl = *spinand->data_ops.update_cache;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
 					  spinand->spimem, &info);
 	if (IS_ERR(desc))
@@ -857,7 +857,7 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc = desc;
 
-	info.op_tmpl = *spinand->op_templates.read_cache;
+	info.op_tmpl = *spinand->data_ops.read_cache;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
 					  spinand->spimem, &info);
 	if (IS_ERR(desc))
@@ -976,8 +976,8 @@ static void spinand_manufacturer_cleanup(struct spinand_device *spinand)
 }
 
 static const struct spi_mem_op *
-spinand_select_op_variant(struct spinand_device *spinand,
-			  const struct spinand_op_variants *variants)
+spinand_select_data_op_variant(struct spinand_device *spinand,
+			       const struct spinand_op_variants *variants)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	unsigned int i;
@@ -1050,23 +1050,23 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
 
-		op = spinand_select_op_variant(spinand,
-					       info->op_variants.read_cache);
+		op = spinand_select_data_op_variant(spinand,
+					info->data_ops_variants.read_cache);
 		if (!op)
 			return -ENOTSUPP;
 
-		spinand->op_templates.read_cache = op;
+		spinand->data_ops.read_cache = op;
 
-		op = spinand_select_op_variant(spinand,
-					       info->op_variants.write_cache);
+		op = spinand_select_data_op_variant(spinand,
+					info->data_ops_variants.write_cache);
 		if (!op)
 			return -ENOTSUPP;
 
-		spinand->op_templates.write_cache = op;
+		spinand->data_ops.write_cache = op;
 
-		op = spinand_select_op_variant(spinand,
-					       info->op_variants.update_cache);
-		spinand->op_templates.update_cache = op;
+		op = spinand_select_data_op_variant(spinand,
+					info->data_ops_variants.update_cache);
+		spinand->data_ops.update_cache = op;
 
 		return 0;
 	}
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 77927afcea0f..439d8ce40e1d 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -391,10 +391,10 @@ struct spinand_ondie_ecc_conf {
  * @memorg: memory organization
  * @eccreq: ECC requirements
  * @eccinfo: on-die ECC info
- * @op_variants: operations variants
- * @op_variants.read_cache: variants of the read-cache operation
- * @op_variants.write_cache: variants of the write-cache operation
- * @op_variants.update_cache: variants of the update-cache operation
+ * @data_ops_variants: operations variants for page read/writes
+ * @data_ops_variants.read_cache: variants of the read-cache operation
+ * @data_ops_variants.write_cache: variants of the write-cache operation
+ * @data_ops_variants.update_cache: variants of the update-cache operation
  * @select_target: function used to select a target/die. Required only for
  *		   multi-die chips
  *
@@ -412,7 +412,7 @@ struct spinand_info {
 		const struct spinand_op_variants *read_cache;
 		const struct spinand_op_variants *write_cache;
 		const struct spinand_op_variants *update_cache;
-	} op_variants;
+	} data_ops_variants;
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
 };
@@ -440,14 +440,14 @@ struct spinand_info {
 #define SPINAND_SELECT_TARGET(__func)					\
 	.select_target = __func,
 
-#define SPINAND_INFO(__model, __id, __memorg, __eccreq, __op_variants,	\
-		     __flags, ...)					\
+#define SPINAND_INFO(__model, __id, __memorg, __eccreq,			\
+		     __data_ops_variants, __flags, ...)			\
 	{								\
 		.model = __model,					\
 		.devid = __id,						\
 		.memorg = __memorg,					\
 		.eccreq = __eccreq,					\
-		.op_variants = __op_variants,				\
+		.data_ops_variants = __data_ops_variants,		\
 		.flags = __flags,					\
 		__VA_ARGS__						\
 	}
@@ -464,10 +464,10 @@ struct spinand_dirmap {
  * @lock: lock used to serialize accesses to the NAND
  * @id: NAND ID as returned by READ_ID
  * @flags: NAND flags
- * @op_templates: various SPI mem op templates
- * @op_templates.read_cache: read cache op template
- * @op_templates.write_cache: write cache op template
- * @op_templates.update_cache: update cache op template
+ * @data_ops: various SPI mem op templates for reading and writing on pages
+ * @data_ops.read_cache: read cache op template
+ * @data_ops.write_cache: write cache op template
+ * @data_ops.update_cache: update cache op template
  * @select_target: select a specific target/die. Usually called before sending
  *		   a command addressing a page or an eraseblock embedded in
  *		   this die. Only required if your chip exposes several dies
@@ -496,7 +496,7 @@ struct spinand_device {
 		const struct spi_mem_op *read_cache;
 		const struct spi_mem_op *write_cache;
 		const struct spi_mem_op *update_cache;
-	} op_templates;
+	} data_ops;
 
 	struct spinand_dirmap *dirmaps;
 
-- 
2.25.1

