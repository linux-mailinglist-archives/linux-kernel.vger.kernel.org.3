Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166D34D312C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbiCIOnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiCIOnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:43:25 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E9F99
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 06:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646836945; x=1678372945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T7tMDbk1Ye4y/SoGkEwlM0IIC2ycbt6cb4WImKg4D28=;
  b=mNBGojho/3rnbqSGbUQr59da4xpcE8scLj5vX6EIIQqTAfqiNr5uQdoG
   wg9cRXogAjOQcbUWru8ByRaVlNRLGwg4R3kd16LHRA6LnpluIBW0CL6EX
   16aWUKSMJVBt0vI18ndNWjcEavhxPL5Cj2kPm6saShJNnaIoDcCF4C5O7
   wN1Pz/a8kMXyWTJqEi7Ne9epU06Z+GhTbeucMytvLmVm1/0eQ4t8rTG/O
   aYOhB7N4mtICeEFD3YrBbbwUp/RHahPCwVITIAlec9ZuoAskATq8ZN2WH
   8afYM51nqixCjaJccA+xwSVeQp8Xo1Ph4J98pSoRSWlaMgNcSb/l4/qyh
   g==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643698800"; 
   d="scan'208";a="88364485"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Mar 2022 07:42:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Mar 2022 07:42:24 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 9 Mar 2022 07:42:22 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 1/4] mtd: spi-nor: Parse BFPT to determine the 4-Byte Address Mode methods
Date:   Wed, 9 Mar 2022 16:42:12 +0200
Message-ID: <20220309144215.179449-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309144215.179449-1-tudor.ambarus@microchip.com>
References: <20220309144215.179449-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BFPT[DWORD(16)] defines the methods to enter and exit the 4-Byte Address
Mode. Parse BFPT to determine the method. Will rename the methods with
generic names in a further patch, to keep things trackable in this one.

Some regressions may be introduced by this patch, because the
params->set_4byte_addr_mode method that was set either in
spi_nor_init_default_params() or later overwritten in default_init() hooks,
may now be overwritten with a different value based on the BFPT data. If
that's the case, the fix is to introduce a post_bfpt fixup hook where one
should fix the wrong BFPT info.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c      |  63 ---------------
 drivers/mtd/spi-nor/core.h      |   1 -
 drivers/mtd/spi-nor/micron-st.c |  24 ------
 drivers/mtd/spi-nor/sfdp.c      | 139 ++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/sfdp.h      |   3 +
 drivers/mtd/spi-nor/winbond.c   |  16 ++--
 6 files changed, 152 insertions(+), 94 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 98cda4063c07..452d0f91a8df 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -506,69 +506,6 @@ int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)
 	return ret;
 }
 
-/**
- * spi_nor_set_4byte_addr_mode() - Enter/Exit 4-byte address mode.
- * @nor:	pointer to 'struct spi_nor'.
- * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
- *		address mode.
- *
- * Return: 0 on success, -errno otherwise.
- */
-int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
-{
-	int ret;
-
-	if (nor->spimem) {
-		struct spi_mem_op op = SPI_NOR_EN4B_EX4B_OP(enable);
-
-		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = spi_nor_controller_ops_write_reg(nor,
-						       enable ? SPINOR_OP_EN4B :
-								SPINOR_OP_EX4B,
-						       NULL, 0);
-	}
-
-	if (ret)
-		dev_dbg(nor->dev, "error %d setting 4-byte mode\n", ret);
-
-	return ret;
-}
-
-/**
- * spansion_set_4byte_addr_mode() - Set 4-byte address mode for Spansion
- * flashes.
- * @nor:	pointer to 'struct spi_nor'.
- * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
- *		address mode.
- *
- * Return: 0 on success, -errno otherwise.
- */
-static int spansion_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
-{
-	int ret;
-
-	nor->bouncebuf[0] = enable << 7;
-
-	if (nor->spimem) {
-		struct spi_mem_op op = SPI_NOR_BRWR_OP(nor->bouncebuf);
-
-		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_BRWR,
-						       nor->bouncebuf, 1);
-	}
-
-	if (ret)
-		dev_dbg(nor->dev, "error %d setting 4-byte mode\n", ret);
-
-	return ret;
-}
-
 /**
  * spi_nor_write_ear() - Write Extended Address Register.
  * @nor:	pointer to 'struct spi_nor'.
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 8b7e597fd38c..c83d5e75c563 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -634,7 +634,6 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
 			     const enum spi_nor_protocol proto);
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
-int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
 int spi_nor_write_ear(struct spi_nor *nor, u8 ear);
 int spi_nor_wait_till_ready(struct spi_nor *nor);
 int spi_nor_global_block_unlock(struct spi_nor *nor);
diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index dcdf461e2b53..c348419d24a0 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -294,30 +294,6 @@ static const struct flash_info st_nor_parts[] = {
 	{ "m25px80",    INFO(0x207114,  0, 64 * 1024, 16) },
 };
 
-/**
- * micron_st_nor_set_4byte_addr_mode() - Set 4-byte address mode for ST and
- * Micron flashes.
- * @nor:	pointer to 'struct spi_nor'.
- * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
- *		address mode.
- *
- * Return: 0 on success, -errno otherwise.
- */
-static int micron_st_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
-{
-	int ret;
-
-	ret = spi_nor_write_enable(nor);
-	if (ret)
-		return ret;
-
-	ret = spi_nor_set_4byte_addr_mode(nor, enable);
-	if (ret)
-		return ret;
-
-	return spi_nor_write_disable(nor);
-}
-
 /**
  * micron_st_nor_read_fsr() - Read the Flag Status Register.
  * @nor:	pointer to 'struct spi_nor'
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index a5211543d30d..108a74ce38e0 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -401,6 +401,127 @@ static void spi_nor_regions_sort_erase_types(struct spi_nor_erase_map *map)
 	}
 }
 
+/**
+ * spansion_set_4byte_addr_mode() - Set 4-byte address mode for Spansion
+ * flashes.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
+ *		address mode.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int spansion_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
+{
+	int ret;
+
+	nor->bouncebuf[0] = enable << 7;
+
+	if (nor->spimem) {
+		struct spi_mem_op op = SPI_NOR_BRWR_OP(nor->bouncebuf);
+
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
+		ret = spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_BRWR,
+						       nor->bouncebuf, 1);
+	}
+
+	if (ret)
+		dev_dbg(nor->dev, "error %d setting 4-byte mode\n", ret);
+
+	return ret;
+}
+
+/**
+ * spi_nor_set_4byte_addr_mode() - Enter/Exit 4-byte address mode.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
+ *		address mode.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
+{
+	int ret;
+
+	if (nor->spimem) {
+		struct spi_mem_op op = SPI_NOR_EN4B_EX4B_OP(enable);
+
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
+		ret = spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret = spi_nor_controller_ops_write_reg(nor,
+						       enable ? SPINOR_OP_EN4B :
+								SPINOR_OP_EX4B,
+						       NULL, 0);
+	}
+
+	if (ret)
+		dev_dbg(nor->dev, "error %d setting 4-byte mode\n", ret);
+
+	return ret;
+}
+
+/**
+ * micron_st_nor_set_4byte_addr_mode() - Set 4-byte address mode for ST and
+ * Micron flashes.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
+ *		address mode.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int micron_st_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
+{
+	int ret;
+
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
+	ret = spi_nor_set_4byte_addr_mode(nor, enable);
+	if (ret)
+		return ret;
+
+	return spi_nor_write_disable(nor);
+}
+
+#define BFPT_DWORD16_EN4B_MASK			GENMASK(31, 24)
+#define BFPT_DWORD16_EN4B_ALWAYS_4B		BIT(30)
+#define BFPT_DWORD16_EN4B_4B_OPCODES		BIT(29)
+#define BFPT_DWORD16_EN4B_16BIT_NV_CR		BIT(28)
+#define BFPT_DWORD16_EN4B_BRWR			BIT(27)
+#define BFPT_DWORD16_EN4B_WREAR			BIT(26)
+#define BFPT_DWORD16_EN4B_WREN_EN4B		BIT(25)
+#define BFPT_DWORD16_EN4B_EN4B			BIT(24)
+
+#define BFPT_DWORD16_EX4B_MASK			GENMASK(18, 14)
+#define BFPT_DWORD16_EX4B_16BIT_NV_CR		BIT(18)
+#define BFPT_DWORD16_EX4B_BRWR			BIT(17)
+#define BFPT_DWORD16_EX4B_WREAR			BIT(16)
+#define BFPT_DWORD16_EX4B_WREN_EX4B		BIT(15)
+#define BFPT_DWORD16_EX4B_EX4B			BIT(14)
+
+#define BFPT_DWORD16_4B_ADDR_MODE_MASK			\
+	(BFPT_DWORD16_EN4B_MASK | BFPT_DWORD16_EX4B_MASK)
+
+#define BFPT_DWORD16_4B_ADDR_MODE_16BIT_NV_CR		\
+	(BFPT_DWORD16_EN4B_16BIT_NV_CR | BFPT_DWORD16_EX4B_16BIT_NV_CR)
+
+#define BFPT_DWORD16_4B_ADDR_MODE_BRWR			\
+	(BFPT_DWORD16_EN4B_BRWR | BFPT_DWORD16_EX4B_BRWR)
+
+#define BFPT_DWORD16_4B_ADDR_MODE_WREAR			\
+	(BFPT_DWORD16_EN4B_WREAR | BFPT_DWORD16_EX4B_WREAR)
+
+#define BFPT_DWORD16_4B_ADDR_MODE_WREN_EN4B_EX4B	\
+	(BFPT_DWORD16_EN4B_WREN_EN4B | BFPT_DWORD16_EX4B_WREN_EX4B)
+
+#define BFPT_DWORD16_4B_ADDR_MODE_EN4B_EX4B		\
+	(BFPT_DWORD16_EN4B_EN4B | BFPT_DWORD16_EX4B_EX4B)
+
 /**
  * spi_nor_parse_bfpt() - read and parse the Basic Flash Parameter Table.
  * @nor:		pointer to a 'struct spi_nor'
@@ -606,6 +727,24 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 		break;
 	}
 
+	switch (bfpt.dwords[BFPT_DWORD(16)] & BFPT_DWORD16_4B_ADDR_MODE_MASK) {
+	case BFPT_DWORD16_4B_ADDR_MODE_BRWR:
+		params->set_4byte_addr_mode = spansion_set_4byte_addr_mode;
+		break;
+
+	case BFPT_DWORD16_4B_ADDR_MODE_WREN_EN4B_EX4B:
+		params->set_4byte_addr_mode = micron_st_nor_set_4byte_addr_mode;
+		break;
+
+	case BFPT_DWORD16_4B_ADDR_MODE_EN4B_EX4B:
+		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode;
+		break;
+
+	default:
+		dev_dbg(nor->dev, "BFPT: 4-Byte Address Mode method is not recognized or not implemented\n");
+		break;
+	}
+
 	/* Soft Reset support. */
 	if (bfpt.dwords[BFPT_DWORD(16)] & BFPT_DWORD16_SWRST_EN_RST)
 		nor->flags |= SNOR_F_SOFT_RESET;
diff --git a/drivers/mtd/spi-nor/sfdp.h b/drivers/mtd/spi-nor/sfdp.h
index bbf80d2990ab..b56849079aea 100644
--- a/drivers/mtd/spi-nor/sfdp.h
+++ b/drivers/mtd/spi-nor/sfdp.h
@@ -107,6 +107,9 @@ struct sfdp_parameter_header {
 	u8		id_msb;
 };
 
+int spansion_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
+int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
+int micron_st_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
 int spi_nor_parse_sfdp(struct spi_nor *nor);
 
 #endif /* __LINUX_MTD_SFDP_H */
diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index fe80dffc2e70..374ba82bff49 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -170,19 +170,23 @@ static const struct spi_nor_otp_ops winbond_nor_otp_ops = {
 	.is_locked = spi_nor_otp_is_locked_sr2,
 };
 
-static void winbond_nor_default_init(struct spi_nor *nor)
-{
-	nor->params->set_4byte_addr_mode = winbond_nor_set_4byte_addr_mode;
-}
-
 static void winbond_nor_late_init(struct spi_nor *nor)
 {
 	if (nor->params->otp.org->n_regions)
 		nor->params->otp.ops = &winbond_nor_otp_ops;
+
+	/*
+	 * Winbond seems to require that the Extended Address Register to be set
+	 * to zero when exiting the 4-Byte Address Mode, at least for W25Q256FV.
+	 * This requirement is not described in the JESD216 SFDP standard, thus
+	 * it is Winbond specific. Since we do not know if other Winbond flashes
+	 * have the same requirement, play safe and overwrite the method parsed
+	 * from BFPT, if any.
+	 */
+	nor->params->set_4byte_addr_mode = winbond_nor_set_4byte_addr_mode;
 }
 
 static const struct spi_nor_fixups winbond_nor_fixups = {
-	.default_init = winbond_nor_default_init,
 	.late_init = winbond_nor_late_init,
 };
 
-- 
2.25.1

