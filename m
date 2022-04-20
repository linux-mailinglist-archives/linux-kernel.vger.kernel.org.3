Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F87B508606
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377685AbiDTKiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377681AbiDTKhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:37:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE822DA4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650450891; x=1681986891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=35s8zzgaSLVt8GRMDwieLQnpD+4vW72LtpsgbSJB94o=;
  b=Ki+Kwf/9DnMkNJtcjiF/tHhv/HyO84NrmAuMJlWbIzHidV0n7XMTad17
   nCZH/2/AqAW6lL5EWpT7XiQ2eAyd1BlO7wAXuZYcswerk51eI4f9dWrTn
   /v19USaMGwihUAKkPxpyCf1nXFZSNNKtjQfx9K9cKGOTigIfFjS6bamrP
   P+6G41Sh+wcdwomSoIrYWSHPecgdekW69UfiRSRovblppr0GtYF/HcdTL
   RsW0XJE9BywMEUWXKJdPcUmAsxoEypNWrCfXKdKRml11MT5zj8earyU6x
   mWgNGY/5m2QW/j6rb9U9yImTk2cwmvNPIIxwxLeDV8nc+7QUDS4ULgnY4
   A==;
X-IronPort-AV: E=Sophos;i="5.90,275,1643698800"; 
   d="scan'208";a="161091319"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Apr 2022 03:34:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 20 Apr 2022 03:34:51 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 20 Apr 2022 03:34:49 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Takahiro.Kuwano@infineon.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v4 08/11] mtd: spi-nor: spansion: Rework spi_nor_cypress_octal_dtr_enable()
Date:   Wed, 20 Apr 2022 13:34:24 +0300
Message-ID: <20220420103427.47867-9-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420103427.47867-1-tudor.ambarus@microchip.com>
References: <20220420103427.47867-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Add debug messages in case spi_nor_read_id() fails.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/spansion.c | 128 ++++++++++++++++++---------------
 1 file changed, 69 insertions(+), 59 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index c5988312cc91..56b43074ef17 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -23,87 +23,81 @@
 #define SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_DS	0
 #define SPINOR_OP_CYPRESS_RD_FAST		0xee
 
-/**
- * cypress_nor_octal_dtr_enable() - Enable octal DTR on Cypress flashes.
- * @nor:		pointer to a 'struct spi_nor'
- * @enable:              whether to enable or disable Octal DTR
- *
- * This also sets the memory access latency cycles to 24 to allow the flash to
- * run at up to 200MHz.
- *
- * Return: 0 on success, -errno otherwise.
- */
-static int cypress_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
+/* Cypress SPI NOR flash operations. */
+#define CYPRESS_NOR_WR_ANY_REG_OP(naddr, addr, ndata, buf)		\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 0),		\
+		   SPI_MEM_OP_ADDR(naddr, addr, 0),			\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_DATA_OUT(ndata, buf, 0))
+
+static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
 {
 	struct spi_mem_op op;
 	u8 *buf = nor->bouncebuf;
 	int ret;
 
-	if (enable) {
-		/* Use 24 dummy cycles for memory array reads. */
-		ret = spi_nor_write_enable(nor);
-		if (ret)
-			return ret;
+	/* Use 24 dummy cycles for memory array reads. */
+	*buf = SPINOR_REG_CYPRESS_CFR2V_MEMLAT_11_24;
+	op = (struct spi_mem_op)
+		CYPRESS_NOR_WR_ANY_REG_OP(3, SPINOR_REG_CYPRESS_CFR2V, 1, buf);
 
-		*buf = SPINOR_REG_CYPRESS_CFR2V_MEMLAT_11_24;
-		op = (struct spi_mem_op)
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 1),
-				   SPI_MEM_OP_ADDR(3, SPINOR_REG_CYPRESS_CFR2V,
-						   1),
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_OUT(1, buf, 1));
+	ret = spi_nor_write_any_volatile_reg(nor, &op, nor->reg_proto);
+	if (ret)
+		return ret;
 
-		ret = spi_mem_exec_op(nor->spimem, &op);
-		if (ret)
-			return ret;
+	ret = spi_nor_wait_till_ready(nor);
+	if (ret)
+		return ret;
 
-		ret = spi_nor_wait_till_ready(nor);
-		if (ret)
-			return ret;
+	nor->read_dummy = 24;
 
-		nor->read_dummy = 24;
-	}
+	/* Set the octal and DTR enable bits. */
+	buf[0] = SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_EN;
+	op = (struct spi_mem_op)
+		CYPRESS_NOR_WR_ANY_REG_OP(3, SPINOR_REG_CYPRESS_CFR5V, 1, buf);
 
-	/* Set/unset the octal and DTR enable bits. */
-	ret = spi_nor_write_enable(nor);
+	ret = spi_nor_write_any_volatile_reg(nor, &op, nor->reg_proto);
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
+	/* Read flash ID to make sure the switch was successful. */
+	ret = spi_nor_read_id(nor, 4, 3, buf, SNOR_PROTO_8_8_8_DTR);
+	if (ret) {
+		dev_dbg(nor->dev, "error %d reading JEDEC ID after enabling 8D-8D-8D mode\n", ret);
+		return ret;
 	}
 
-	op = (struct spi_mem_op)
-		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 1),
-			   SPI_MEM_OP_ADDR(enable ? 3 : 4,
-					   SPINOR_REG_CYPRESS_CFR5V,
-					   1),
-			   SPI_MEM_OP_NO_DUMMY,
-			   SPI_MEM_OP_DATA_OUT(enable ? 1 : 2, buf, 1));
+	if (memcmp(buf, nor->info->id, nor->info->id_len))
+		return -EINVAL;
 
-	if (!enable)
-		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
+	return 0;
+}
 
-	ret = spi_mem_exec_op(nor->spimem, &op);
+static int cypress_nor_octal_dtr_dis(struct spi_nor *nor)
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
+		CYPRESS_NOR_WR_ANY_REG_OP(4, SPINOR_REG_CYPRESS_CFR5V, 2, buf);
+	ret = spi_nor_write_any_volatile_reg(nor, &op, SNOR_PROTO_8_8_8_DTR);
 	if (ret)
 		return ret;
 
 	/* Read flash ID to make sure the switch was successful. */
-	if (enable)
-		ret = spi_nor_read_id(nor, 4, 3, buf, SNOR_PROTO_8_8_8_DTR);
-	else
-		ret = spi_nor_read_id(nor, 0, 0, buf, SNOR_PROTO_1_1_1);
-	if (ret)
+	ret = spi_nor_read_id(nor, 0, 0, buf, SNOR_PROTO_1_1_1);
+	if (ret) {
+		dev_dbg(nor->dev, "error %d reading JEDEC ID after disabling 8D-8D-8D mode\n", ret);
 		return ret;
+	}
 
 	if (memcmp(buf, nor->info->id, nor->info->id_len))
 		return -EINVAL;
@@ -111,6 +105,22 @@ static int cypress_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
 	return 0;
 }
 
+/**
+ * cypress_nor_octal_dtr_enable() - Enable octal DTR on Cypress flashes.
+ * @nor:		pointer to a 'struct spi_nor'
+ * @enable:              whether to enable or disable Octal DTR
+ *
+ * This also sets the memory access latency cycles to 24 to allow the flash to
+ * run at up to 200MHz.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int cypress_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
+{
+	return enable ? cypress_nor_octal_dtr_en(nor) :
+			cypress_nor_octal_dtr_dis(nor);
+}
+
 static void s28hs512t_default_init(struct spi_nor *nor)
 {
 	nor->params->octal_dtr_enable = cypress_nor_octal_dtr_enable;
-- 
2.25.1

