Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340E14FBC8E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346264AbiDKM4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346251AbiDKM4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:56:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B019338AD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649681634; x=1681217634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YxGwEXdiW2HWJutHcMnKMQvWB9GLiCYZWJLMxk1Flq0=;
  b=rDTNCJzCUnDQzBoiKUsj8WlxIRCzR43EXWpHtsSjCEfnPC+8tKCMj4U3
   DVhrGF1bzrZy+05eIcS8+VRYeQ2C9CkUPbUCZna5GdTcDfknrlGKCMGPQ
   Bssx+6wRUAtIdECpMknJNXew2ftDwaZldm4bYuW5A53THgeBK2DuR2P6Q
   6IuokJaVi7BuJDHAtjdJcGqm5LDn031490SRPG6owGoL1lxfxOckWxRZ7
   PPchsQ+hpsMxzCIQmmq9xpPoNF0LvdGYdgud4QlHiQJXkyo0O03SIbBLM
   TzpOfDQFDGNcrmnqed+YJpMryC1shP5kBrNAgiV5vBZmSCgJKAWT1b6F8
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,251,1643698800"; 
   d="scan'208";a="169171556"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Apr 2022 05:53:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Apr 2022 05:53:53 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 11 Apr 2022 05:53:51 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v3 1/3] mtd: spi-nor: Parse BFPT to determine the 4-Byte Address Mode methods
Date:   Mon, 11 Apr 2022 15:53:44 +0300
Message-ID: <20220411125346.118274-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220411125346.118274-1-tudor.ambarus@microchip.com>
References: <20220411125346.118274-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
---
v3: move BFPT definitions in sfdp.h as they may be used by manufacturer
drivers to handle flash ID collisions.

 drivers/mtd/spi-nor/core.c      |  63 -------------------
 drivers/mtd/spi-nor/core.h      |   1 -
 drivers/mtd/spi-nor/micron-st.c |  24 --------
 drivers/mtd/spi-nor/sfdp.c      | 105 ++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/sfdp.h      |  29 +++++++++
 drivers/mtd/spi-nor/winbond.c   |  16 +++--
 6 files changed, 144 insertions(+), 94 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index fe853532204c..2b26a8cef0c3 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -502,69 +502,6 @@ int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)
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
index 26b9a1c2309d..d2903c5b5b87 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -298,30 +298,6 @@ static const struct flash_info st_nor_parts[] = {
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
index a5211543d30d..2e40eba3744d 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -401,6 +401,93 @@ static void spi_nor_regions_sort_erase_types(struct spi_nor_erase_map *map)
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
 /**
  * spi_nor_parse_bfpt() - read and parse the Basic Flash Parameter Table.
  * @nor:		pointer to a 'struct spi_nor'
@@ -606,6 +693,24 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
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
index bbf80d2990ab..3a3744da78ba 100644
--- a/drivers/mtd/spi-nor/sfdp.h
+++ b/drivers/mtd/spi-nor/sfdp.h
@@ -90,6 +90,32 @@ struct sfdp_bfpt {
 #define BFPT_DWORD15_QER_SR2_BIT1_NO_RD		(0x4UL << 20)
 #define BFPT_DWORD15_QER_SR2_BIT1		(0x5UL << 20) /* Spansion */
 
+#define BFPT_DWORD16_EN4B_MASK			GENMASK(31, 24)
+#define BFPT_DWORD16_EN4B_ALWAYS_4B		BIT(30)
+#define BFPT_DWORD16_EN4B_4B_OPCODES		BIT(29)
+#define BFPT_DWORD16_EN4B_16BIT_NV_CR		BIT(28)
+#define BFPT_DWORD16_EN4B_BRWR			BIT(27)
+#define BFPT_DWORD16_EN4B_WREAR			BIT(26)
+#define BFPT_DWORD16_EN4B_WREN_EN4B		BIT(25)
+#define BFPT_DWORD16_EN4B_EN4B			BIT(24)
+#define BFPT_DWORD16_EX4B_MASK			GENMASK(18, 14)
+#define BFPT_DWORD16_EX4B_16BIT_NV_CR		BIT(18)
+#define BFPT_DWORD16_EX4B_BRWR			BIT(17)
+#define BFPT_DWORD16_EX4B_WREAR			BIT(16)
+#define BFPT_DWORD16_EX4B_WREN_EX4B		BIT(15)
+#define BFPT_DWORD16_EX4B_EX4B			BIT(14)
+#define BFPT_DWORD16_4B_ADDR_MODE_MASK			\
+	(BFPT_DWORD16_EN4B_MASK | BFPT_DWORD16_EX4B_MASK)
+#define BFPT_DWORD16_4B_ADDR_MODE_16BIT_NV_CR		\
+	(BFPT_DWORD16_EN4B_16BIT_NV_CR | BFPT_DWORD16_EX4B_16BIT_NV_CR)
+#define BFPT_DWORD16_4B_ADDR_MODE_BRWR			\
+	(BFPT_DWORD16_EN4B_BRWR | BFPT_DWORD16_EX4B_BRWR)
+#define BFPT_DWORD16_4B_ADDR_MODE_WREAR			\
+	(BFPT_DWORD16_EN4B_WREAR | BFPT_DWORD16_EX4B_WREAR)
+#define BFPT_DWORD16_4B_ADDR_MODE_WREN_EN4B_EX4B	\
+	(BFPT_DWORD16_EN4B_WREN_EN4B | BFPT_DWORD16_EX4B_WREN_EX4B)
+#define BFPT_DWORD16_4B_ADDR_MODE_EN4B_EX4B		\
+	(BFPT_DWORD16_EN4B_EN4B | BFPT_DWORD16_EX4B_EX4B)
 #define BFPT_DWORD16_SWRST_EN_RST		BIT(12)
 
 #define BFPT_DWORD18_CMD_EXT_MASK		GENMASK(30, 29)
@@ -107,6 +133,9 @@ struct sfdp_parameter_header {
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

