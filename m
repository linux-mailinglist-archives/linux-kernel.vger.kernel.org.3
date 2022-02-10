Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C4D4B0364
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiBJCeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 21:34:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiBJCdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 21:33:52 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4312237D4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 18:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644460434; x=1675996434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yykgA2NLZMLLQxzpDi7wv3MT1+A8SrBWEcGrIX62WjE=;
  b=WdQfWryltyfEtQZvopxMPaZ6xyS8h8tMopfYYF+rpF9M6wQcDYFAr6OL
   RXyDnWmRQidJxEkOqDKT9k394wLClfxjCykpnGpy9XcEGI+3klUHNK1hU
   PV+6vY6Syj3yGC+PH+ckX7CWjFQ9PHOeaaI9O+z+A9ooKH9VZAaJOJuS1
   O08ARg+9bhd1MIfVWn6/NmKRgDxHTs3n/oU338AA39UY9NhkCqhHDz2HE
   tXl5NuLXrK0YzYuPixVnMjGW/5CGzgJGSu2H96M2FGxYGZR6c7aPglZdu
   nq+d2HnGsipboBZOO9RugHK11CNxxzIgjKZZS6z1hJvW96gs7lb8s+2Ig
   A==;
IronPort-SDR: TvyNYGn4gqiblmgJVpHdKMY2JuE1dQyGi5TBoa7QPaT42tIulPKshTHwzmZR/wuJEXe+wXwrXJ
 ppnkM8Xx9MqqD6/tNDPv9zTpvA2Zu88Nbtd62yE5txSa7pV2+PdGA8pxY6eojzFyMnIkZ8wkq2
 vachgoRQoi9ueyWslOPCfeIjn57WCEFq2G8vsXp/F6Pls9N6SKZnJWhvVGTxHa9y0BatDXBr5A
 twR1bzYvDGHmVNpJLn7AdRNt2qp8XHMUyJ8U3sFwtpRBjG9y03X5uW5+QJUyB3y8/ulFxImU37
 jogw3UxcXczxCtztm3FaIMaz
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="153075495"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 19:33:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 19:33:53 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 9 Feb 2022 19:33:50 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>,
        <Takahiro.Kuwano@infineon.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <zhengxunli@mxic.com.tw>,
        <jaimeliao@mxic.com.tw>, <Bacem.Daassi@infineon.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 3/3] mtd: spi-nor: spansion: Rework spi_nor_cypress_octal_dtr_enable()
Date:   Thu, 10 Feb 2022 04:33:34 +0200
Message-ID: <20220210023334.408926-4-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220210023334.408926-1-tudor.ambarus@microchip.com>
References: <20220210023334.408926-1-tudor.ambarus@microchip.com>
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

Introduce template operation to remove code duplication.
Split spi_nor_cypress_octal_dtr_enable() in
spi_nor_cypress_octal_dtr_ena() spi_nor_cypress_octal_dtr_dis() as it no
longer made sense to try to keep everything alltogether: too many
"if (enable)" throughout the code, which made the code difficult to read.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spansion.c | 135 ++++++++++++++++++---------------
 1 file changed, 72 insertions(+), 63 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index d69a569f31e4..9bb239f1e142 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -19,85 +19,78 @@
 #define SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_DS	0
 #define SPINOR_OP_CYPRESS_RD_FAST		0xee
 
-/**
- * spi_nor_cypress_octal_dtr_enable() - Enable octal DTR on Cypress flashes.
- * @nor:		pointer to a 'struct spi_nor'
- * @enable:              whether to enable or disable Octal DTR
- *
- * This also sets the memory access latency cycles to 24 to allow the flash to
- * run at up to 200MHz.
- *
- * Return: 0 on success, -errno otherwise.
- */
-static int spi_nor_cypress_octal_dtr_enable(struct spi_nor *nor, bool enable)
+/* Spansion/Cypress SPI NOR flash operations. */
+#define SPI_NOR_SPANSION_WR_ANY_REG_OP(naddr, addr, ndata, buf)		\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 0),		\
+		   SPI_MEM_OP_ADDR(naddr, addr, 0),			\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_DATA_OUT(ndata, buf, 0))
+
+static int spi_nor_cypress_octal_dtr_en(struct spi_nor *nor)
 {
 	struct spi_mem_op op;
 	u8 *buf = nor->bouncebuf;
 	int ret;
 
-	if (enable) {
-		/* Use 24 dummy cycles for memory array reads. */
-		ret = spi_nor_write_enable(nor);
-		if (ret)
-			return ret;
-
-		*buf = SPINOR_REG_CYPRESS_CFR2V_MEMLAT_11_24;
-		op = (struct spi_mem_op)
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 1),
-				   SPI_MEM_OP_ADDR(3, SPINOR_REG_CYPRESS_CFR2V,
-						   1),
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_OUT(1, buf, 1));
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-		if (ret)
-			return ret;
-
-		ret = spi_nor_wait_till_ready(nor);
-		if (ret)
-			return ret;
-
-		nor->read_dummy = 24;
-	}
-
-	/* Set/unset the octal and DTR enable bits. */
-	ret = spi_nor_write_enable(nor);
+	/* Use 24 dummy cycles for memory array reads. */
+	*buf = SPINOR_REG_CYPRESS_CFR2V_MEMLAT_11_24;
+	op = (struct spi_mem_op)
+		SPI_NOR_SPANSION_WR_ANY_REG_OP(3, SPINOR_REG_CYPRESS_CFR2V,
+					       1, buf);
+
+	ret = spi_nor_write_reg(nor, &op, nor->reg_proto);
 	if (ret)
 		return ret;
 
-	if (enable) {
-		buf[0] = SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_EN;
-	} else {
-		/*
-		 * The register is 1-byte wide, but 1-byte transactions are not
-		 * allowed in 8D-8D-8D mode. Since there is no register at the
-		 * next location, just initialize the value to 0 and let the
-		 * transaction go on.
-		 */
-		buf[0] = SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_DS;
-		buf[1] = 0;
-	}
+	ret = spi_nor_wait_till_ready(nor);
+	if (ret)
+		return ret;
+
+	nor->read_dummy = 24;
 
+	/* Set the octal and DTR enable bits. */
+	buf[0] = SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_EN;
 	op = (struct spi_mem_op)
-		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 1),
-			   SPI_MEM_OP_ADDR(enable ? 3 : 4,
-					   SPINOR_REG_CYPRESS_CFR5V,
-					   1),
-			   SPI_MEM_OP_NO_DUMMY,
-			   SPI_MEM_OP_DATA_OUT(enable ? 1 : 2, buf, 1));
+		SPI_NOR_SPANSION_WR_ANY_REG_OP(3, SPINOR_REG_CYPRESS_CFR5V,
+					       1, buf);
 
-	if (!enable)
-		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
+	ret = spi_nor_write_reg(nor, &op, nor->reg_proto);
+	if (ret)
+		return ret;
 
-	ret = spi_mem_exec_op(nor->spimem, &op);
+	/* Read flash ID to make sure the switch was successful. */
+	ret = spi_nor_read_id(nor, 4, 3, buf, SNOR_PROTO_8_8_8_DTR);
+	if (ret)
+		return ret;
+
+	if (memcmp(buf, nor->info->id, nor->info->id_len))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int spi_nor_cypress_octal_dtr_dis(struct spi_nor *nor)
+{
+	struct spi_mem_op op;
+	u8 *buf = nor->bouncebuf;
+	int ret;
+
+	/*
+	 * The register is 1-byte wide, but 1-byte transactions are not allowed
+	 * in 8D-8D-8D mode. Since there is no register at the next location,
+	 * just initialize the value to 0 and let the transaction go on.
+	 */
+	buf[0] = SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_DS;
+	buf[1] = 0;
+	op = (struct spi_mem_op)
+		SPI_NOR_SPANSION_WR_ANY_REG_OP(4, SPINOR_REG_CYPRESS_CFR5V,
+					       2, buf);
+	ret = spi_nor_write_reg(nor, &op, SNOR_PROTO_8_8_8_DTR);
 	if (ret)
 		return ret;
 
 	/* Read flash ID to make sure the switch was successful. */
-	if (enable)
-		ret = spi_nor_read_id(nor, 4, 3, buf, SNOR_PROTO_8_8_8_DTR);
-	else
-		ret = spi_nor_read_id(nor, 0, 0, buf, nor->reg_proto);
+	ret = spi_nor_read_id(nor, 0, 0, buf, nor->reg_proto);
 	if (ret)
 		return ret;
 
@@ -107,6 +100,22 @@ static int spi_nor_cypress_octal_dtr_enable(struct spi_nor *nor, bool enable)
 	return 0;
 }
 
+/**
+ * spi_nor_cypress_octal_dtr_enable() - Enable octal DTR on Cypress flashes.
+ * @nor:		pointer to a 'struct spi_nor'
+ * @enable:              whether to enable or disable Octal DTR
+ *
+ * This also sets the memory access latency cycles to 24 to allow the flash to
+ * run at up to 200MHz.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_cypress_octal_dtr_enable(struct spi_nor *nor, bool enable)
+{
+	return enable ? spi_nor_cypress_octal_dtr_en(nor) :
+			spi_nor_cypress_octal_dtr_dis(nor);
+}
+
 static void s28hs512t_default_init(struct spi_nor *nor)
 {
 	nor->params->octal_dtr_enable = spi_nor_cypress_octal_dtr_enable;
-- 
2.25.1

