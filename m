Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D274AF302
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbiBINh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbiBINh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:37:27 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2413AC05CB88
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 05:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644413845; x=1675949845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AMDAzkCO6VtpHBpPGSD8CUkZAbDSmGi3bql97WILRCY=;
  b=uQx/Lpmh92SeLQJzMYkciYaGAzc+n8Sodh8Ob027u9nVEDoUogzlw6MV
   Yfjzvfypj0e/cBOvHow38xrKVseZdcygpO3HP9pcawllkLc/fD5WHeSy2
   dltrGkjWEYajKJApJRlfyvwh7remeTicDeTiLsLOkOJ01p/Or0lVzz08B
   tIADN2z+4l5Qjt9doXs9oCMA0UohA15GMReuAiccCrXdv56yk3cvAhd5H
   0lniysjEK56flXKTd4gSNKnuCdUQvLYKz6gRKPyJ/kkhbprKAEuRrQo8q
   QmrYl3Nigl0eGfvpldgNpFbdxKcwl0BNOpEmYRGIvPkmE+EvDH3PoTBDj
   A==;
IronPort-SDR: l9typNhaQocq0jnEj5ImK+sXqfoWQauVZz+OB0jOZ+vEvPRUsas7eHAiWeDbIFYEGHtVB+HG6Y
 TYaMRkaTMa2lo+vv0P/TPGHwn8pAKKpPL2z2shJqnzChKvZRIi25fWiEjHiOLr3Ns6ChckrQeA
 OZ5UAlpyA3C5AAhZmpswcYeRKwJTlgxcWlFQRDMSo5ypE8SS9C1WKDL2a61QPigmXzj7ZkW1Gr
 UIxNn52sjIm+CigohPlyO7Nz0IEL2qzsRb1rGQ/tbI5oWjhYNbQ6nMLOYKRER30iLgOUeimzMz
 4xHyr5uFOE9LLxgZlymLCYjV
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="145394848"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 06:37:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 06:37:23 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 9 Feb 2022 06:37:19 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <zhengxunli@mxic.com.tw>,
        <jaimeliao@mxic.com.tw>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v6 4/7] mtd: spi-nor: core: Introduce method for RDID op
Date:   Wed, 9 Feb 2022 15:36:53 +0200
Message-ID: <20220209133656.374903-5-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209133656.374903-1-tudor.ambarus@microchip.com>
References: <20220209133656.374903-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RDID is used in the core to auto detect the flash, but also by some
manufacturer drivers that contain flashes that support Octal DTR mode,
so that they can read the flash ID after the switch to Octal DTR was made
to test if the switch was successful. Introduce a core method for RDID op
to avoid code duplication.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c | 58 ++++++++++++++++++++++++++------------
 drivers/mtd/spi-nor/core.h | 11 ++++++++
 2 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 9b740f77174e..35280994a179 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -369,6 +369,41 @@ int spi_nor_write_disable(struct spi_nor *nor)
 	return ret;
 }
 
+/**
+ * spi_nor_read_id() - Read the JEDEC ID.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @naddr:	number of address bytes to send. Can be zero if the operation
+ *		does not need to send an address.
+ * @ndummy:	number of dummy bytes to send after an opcode or address. Can
+ *		be zero if the operation does not require dummy bytes.
+ * @id:		pointer to a DMA-able buffer where the value of the JEDEC ID
+ *		will be written.
+ * @reg_proto:	the SPI protocol for register operation.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int spi_nor_read_id(struct spi_nor *nor, u8 naddr, u8 ndummy, u8 *id,
+		    enum spi_nor_protocol reg_proto)
+{
+	int ret;
+
+	if (nor->spimem) {
+		struct spi_mem_op op = SPI_NOR_READID_OP(
+			naddr, ndummy, id, SPI_NOR_MAX_ID_LEN);
+
+		spi_nor_spimem_setup_op(nor, &op, reg_proto);
+		ret = spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDID, id,
+						    SPI_NOR_MAX_ID_LEN);
+	}
+
+	if (ret)
+		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", ret);
+
+	return ret;
+}
+
 /**
  * spi_nor_read_sr() - Read the Status Register.
  * @nor:	pointer to 'struct spi_nor'.
@@ -1868,28 +1903,15 @@ static const struct flash_info *spi_nor_match_id(struct spi_nor *nor,
 	return NULL;
 }
 
-static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
+static const struct flash_info *spi_nor_detect(struct spi_nor *nor)
 {
 	const struct flash_info *info;
 	u8 *id = nor->bouncebuf;
 	int ret;
 
-	if (nor->spimem) {
-		struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_IN(SPI_NOR_MAX_ID_LEN, id, 1));
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDID, id,
-						    SPI_NOR_MAX_ID_LEN);
-	}
-	if (ret) {
-		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", ret);
+	ret = spi_nor_read_id(nor, 0, 0, id, nor->reg_proto);
+	if (ret)
 		return ERR_PTR(ret);
-	}
 
 	info = spi_nor_match_id(nor, id);
 	if (!info) {
@@ -3133,7 +3155,7 @@ static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
 		info = spi_nor_match_name(nor, name);
 	/* Try to auto-detect if chip name wasn't specified or not found */
 	if (!info) {
-		detected_info = spi_nor_read_id(nor);
+		detected_info = spi_nor_detect(nor);
 		info = detected_info;
 	}
 	if (IS_ERR_OR_NULL(info))
@@ -3146,7 +3168,7 @@ static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
 	if (name && !detected_info && info->id_len) {
 		const struct flash_info *jinfo;
 
-		jinfo = spi_nor_read_id(nor);
+		jinfo = spi_nor_detect(nor);
 		if (IS_ERR(jinfo)) {
 			return jinfo;
 		} else if (jinfo != info) {
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 2afb610853a9..04d4cc13d13b 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -11,6 +11,15 @@
 
 #define SPI_NOR_MAX_ID_LEN	6
 
+/**
+ * Standard SPI NOR flash operations.
+ */
+#define SPI_NOR_READID_OP(naddr, ndummy, buf, len)			\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 0),			\
+		   SPI_MEM_OP_ADDR(naddr, 0, 0),			\
+		   SPI_MEM_OP_DUMMY(ndummy, 0),				\
+		   SPI_MEM_OP_DATA_IN(len, buf, 0))
+
 enum spi_nor_option_flags {
 	SNOR_F_USE_FSR		= BIT(0),
 	SNOR_F_HAS_SR_TB	= BIT(1),
@@ -553,6 +562,8 @@ void spi_nor_unlock_and_unprep(struct spi_nor *nor);
 int spi_nor_sr1_bit6_quad_enable(struct spi_nor *nor);
 int spi_nor_sr2_bit1_quad_enable(struct spi_nor *nor);
 int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor);
+int spi_nor_read_id(struct spi_nor *nor, u8 naddr, u8 ndummy, u8 *id,
+		    enum spi_nor_protocol reg_proto);
 int spi_nor_read_sr(struct spi_nor *nor, u8 *sr);
 int spi_nor_read_cr(struct spi_nor *nor, u8 *cr);
 int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len);
-- 
2.25.1

