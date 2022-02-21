Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAA44BDE97
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357691AbiBUMLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:11:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357317AbiBUMIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:08:55 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66A8201B6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:08:30 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 03F5422464;
        Mon, 21 Feb 2022 13:08:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645445309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y6Gbu5ONm2hlRADzx/R6Xoo589VHVIGFuGyeHW81kPk=;
        b=QEllJi8xjl46bvXn+hYXfeWYozoAfrDmJwS9tdzApnAbgbarB7TslIMWiThticZSr8G90F
        3WwSKHTJERUTNfhyqnubkszs7RP/T9H/QnFpIuYT4Z2Kj5U/O2HDmSJwVoPl+qux37qKaG
        s+NIKlyoceQs58SOZVe7Zf1CItrN37E=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v4 24/32] mtd: spi-nor: move all micron-st specifics into micron-st.c
Date:   Mon, 21 Feb 2022 13:08:01 +0100
Message-Id: <20220221120809.1531502-25-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220221120809.1531502-1-michael@walle.cc>
References: <20220221120809.1531502-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flag status register is only available on micron flashes. Move all
the functions around that into the micron module.

This is almost a mechanical move except for the spi_nor_fsr_ready()
which now also checks the normal status register. Previously, this was
done in spi_nor_ready().

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/core.c      | 123 +----------------------------
 drivers/mtd/spi-nor/micron-st.c | 133 ++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h     |   8 --
 3 files changed, 134 insertions(+), 130 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index ae1560250c48..5b56d718692b 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -412,50 +412,6 @@ int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
 	return ret;
 }
 
-/**
- * spi_nor_read_fsr() - Read the Flag Status Register.
- * @nor:	pointer to 'struct spi_nor'
- * @fsr:	pointer to a DMA-able buffer where the value of the
- *              Flag Status Register will be written. Should be at least 2
- *              bytes.
- *
- * Return: 0 on success, -errno otherwise.
- */
-static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
-{
-	int ret;
-
-	if (nor->spimem) {
-		struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDFSR, 0),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_IN(1, fsr, 0));
-
-		if (nor->reg_proto == SNOR_PROTO_8_8_8_DTR) {
-			op.addr.nbytes = nor->params->rdsr_addr_nbytes;
-			op.dummy.nbytes = nor->params->rdsr_dummy;
-			/*
-			 * We don't want to read only one byte in DTR mode. So,
-			 * read 2 and then discard the second byte.
-			 */
-			op.data.nbytes = 2;
-		}
-
-		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = spi_nor_controller_ops_read_reg(nor, SPINOR_OP_RDFSR, fsr,
-						      1);
-	}
-
-	if (ret)
-		dev_dbg(nor->dev, "error %d reading FSR\n", ret);
-
-	return ret;
-}
-
 /**
  * spi_nor_read_cr() - Read the Configuration Register using the
  * SPINOR_OP_RDCR (35h) command.
@@ -664,75 +620,6 @@ int spi_nor_sr_ready(struct spi_nor *nor)
 	return !(nor->bouncebuf[0] & SR_WIP);
 }
 
-/**
- * spi_nor_clear_fsr() - Clear the Flag Status Register.
- * @nor:	pointer to 'struct spi_nor'.
- */
-static void spi_nor_clear_fsr(struct spi_nor *nor)
-{
-	int ret;
-
-	if (nor->spimem) {
-		struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLFSR, 0),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_NO_DATA);
-
-		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_CLFSR,
-						       NULL, 0);
-	}
-
-	if (ret)
-		dev_dbg(nor->dev, "error %d clearing FSR\n", ret);
-}
-
-/**
- * spi_nor_fsr_ready() - Query the Flag Status Register to see if the flash is
- * ready for new commands.
- * @nor:	pointer to 'struct spi_nor'.
- *
- * Return: 1 if ready, 0 if not ready, -errno on errors.
- */
-static int spi_nor_fsr_ready(struct spi_nor *nor)
-{
-	int ret = spi_nor_read_fsr(nor, nor->bouncebuf);
-
-	if (ret)
-		return ret;
-
-	if (nor->bouncebuf[0] & (FSR_E_ERR | FSR_P_ERR)) {
-		if (nor->bouncebuf[0] & FSR_E_ERR)
-			dev_err(nor->dev, "Erase operation failed.\n");
-		else
-			dev_err(nor->dev, "Program operation failed.\n");
-
-		if (nor->bouncebuf[0] & FSR_PT_ERR)
-			dev_err(nor->dev,
-			"Attempted to modify a protected sector.\n");
-
-		spi_nor_clear_fsr(nor);
-
-		/*
-		 * WEL bit remains set to one when an erase or page program
-		 * error occurs. Issue a Write Disable command to protect
-		 * against inadvertent writes that can possibly corrupt the
-		 * contents of the memory.
-		 */
-		ret = spi_nor_write_disable(nor);
-		if (ret)
-			return ret;
-
-		return -EIO;
-	}
-
-	return !!(nor->bouncebuf[0] & FSR_READY);
-}
-
 /**
  * spi_nor_ready() - Query the flash to see if it is ready for new commands.
  * @nor:	pointer to 'struct spi_nor'.
@@ -741,19 +628,11 @@ static int spi_nor_fsr_ready(struct spi_nor *nor)
  */
 static int spi_nor_ready(struct spi_nor *nor)
 {
-	int sr, fsr;
-
 	/* Flashes might override the standard routine. */
 	if (nor->params->ready)
 		return nor->params->ready(nor);
 
-	sr = spi_nor_sr_ready(nor);
-	if (sr < 0)
-		return sr;
-	fsr = nor->flags & SNOR_F_USE_FSR ? spi_nor_fsr_ready(nor) : 1;
-	if (fsr < 0)
-		return fsr;
-	return sr && fsr;
+	return spi_nor_sr_ready(nor);
 }
 
 /**
diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 7a68f2ad3ea1..8877b122cf42 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -8,6 +8,8 @@
 
 #include "core.h"
 
+#define SPINOR_OP_RDFSR		0x70	/* Read flag status register */
+#define SPINOR_OP_CLFSR		0x50	/* Clear flag status register */
 #define SPINOR_OP_MT_DTR_RD	0xfd	/* Fast Read opcode in DTR mode */
 #define SPINOR_OP_MT_RD_ANY_REG	0x85	/* Read volatile register */
 #define SPINOR_OP_MT_WR_ANY_REG	0x81	/* Write volatile register */
@@ -17,6 +19,12 @@
 #define SPINOR_MT_OCT_DTR	0xe7	/* Enable Octal DTR. */
 #define SPINOR_MT_EXSPI		0xff	/* Enable Extended SPI (default) */
 
+/* Flag Status Register bits */
+#define FSR_READY		BIT(7)	/* Device status, 0 = Busy, 1 = Ready */
+#define FSR_E_ERR		BIT(5)	/* Erase operation status */
+#define FSR_P_ERR		BIT(4)	/* Program operation status */
+#define FSR_PT_ERR		BIT(1)	/* Protection error bit */
+
 static int micron_st_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
 {
 	struct spi_mem_op op;
@@ -273,6 +281,124 @@ static int micron_st_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 	return spi_nor_write_disable(nor);
 }
 
+/**
+ * spi_nor_read_fsr() - Read the Flag Status Register.
+ * @nor:	pointer to 'struct spi_nor'
+ * @fsr:	pointer to a DMA-able buffer where the value of the
+ *              Flag Status Register will be written. Should be at least 2
+ *              bytes.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
+{
+	int ret;
+
+	if (nor->spimem) {
+		struct spi_mem_op op =
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDFSR, 0),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_DATA_IN(1, fsr, 0));
+
+		if (nor->reg_proto == SNOR_PROTO_8_8_8_DTR) {
+			op.addr.nbytes = nor->params->rdsr_addr_nbytes;
+			op.dummy.nbytes = nor->params->rdsr_dummy;
+			/*
+			 * We don't want to read only one byte in DTR mode. So,
+			 * read 2 and then discard the second byte.
+			 */
+			op.data.nbytes = 2;
+		}
+
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
+		ret = spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret = spi_nor_controller_ops_read_reg(nor, SPINOR_OP_RDFSR, fsr,
+						      1);
+	}
+
+	if (ret)
+		dev_dbg(nor->dev, "error %d reading FSR\n", ret);
+
+	return ret;
+}
+
+/**
+ * spi_nor_clear_fsr() - Clear the Flag Status Register.
+ * @nor:	pointer to 'struct spi_nor'.
+ */
+static void spi_nor_clear_fsr(struct spi_nor *nor)
+{
+	int ret;
+
+	if (nor->spimem) {
+		struct spi_mem_op op =
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLFSR, 0),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_NO_DATA);
+
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
+		ret = spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_CLFSR,
+						       NULL, 0);
+	}
+
+	if (ret)
+		dev_dbg(nor->dev, "error %d clearing FSR\n", ret);
+}
+
+/**
+ * spi_nor_fsr_ready() - Query the Flag Status Register to see if the flash is
+ * ready for new commands.
+ * @nor:	pointer to 'struct spi_nor'.
+ *
+ * Return: 1 if ready, 0 if not ready, -errno on errors.
+ */
+static int spi_nor_fsr_ready(struct spi_nor *nor)
+{
+	int sr_ready, ret;
+
+	sr_ready = spi_nor_sr_ready(nor);
+	if (sr_ready < 0)
+		return sr_ready;
+
+	ret = spi_nor_read_fsr(nor, nor->bouncebuf);
+	if (ret)
+		return ret;
+
+	if (nor->bouncebuf[0] & (FSR_E_ERR | FSR_P_ERR)) {
+		if (nor->bouncebuf[0] & FSR_E_ERR)
+			dev_err(nor->dev, "Erase operation failed.\n");
+		else
+			dev_err(nor->dev, "Program operation failed.\n");
+
+		if (nor->bouncebuf[0] & FSR_PT_ERR)
+			dev_err(nor->dev,
+				"Attempted to modify a protected sector.\n");
+
+		spi_nor_clear_fsr(nor);
+
+		/*
+		 * WEL bit remains set to one when an erase or page program
+		 * error occurs. Issue a Write Disable command to protect
+		 * against inadvertent writes that can possibly corrupt the
+		 * contents of the memory.
+		 */
+		ret = spi_nor_write_disable(nor);
+		if (ret)
+			return ret;
+
+		return -EIO;
+	}
+
+	return sr_ready && !!(nor->bouncebuf[0] & FSR_READY);
+}
+
 static void micron_st_nor_default_init(struct spi_nor *nor)
 {
 	nor->flags |= SNOR_F_HAS_LOCK;
@@ -281,8 +407,15 @@ static void micron_st_nor_default_init(struct spi_nor *nor)
 	nor->params->set_4byte_addr_mode = micron_st_nor_set_4byte_addr_mode;
 }
 
+static void micron_st_nor_late_init(struct spi_nor *nor)
+{
+	if (nor->flags & SNOR_F_USE_FSR)
+		nor->params->ready = spi_nor_fsr_ready;
+}
+
 static const struct spi_nor_fixups micron_st_nor_fixups = {
 	.default_init = micron_st_nor_default_init,
+	.late_init = micron_st_nor_late_init,
 };
 
 const struct spi_nor_manufacturer spi_nor_micron = {
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index b44b05a6f934..4622251a79ff 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -47,8 +47,6 @@
 #define SPINOR_OP_RDID		0x9f	/* Read JEDEC ID */
 #define SPINOR_OP_RDSFDP	0x5a	/* Read SFDP */
 #define SPINOR_OP_RDCR		0x35	/* Read configuration register */
-#define SPINOR_OP_RDFSR		0x70	/* Read flag status register */
-#define SPINOR_OP_CLFSR		0x50	/* Clear flag status register */
 #define SPINOR_OP_RDEAR		0xc8	/* Read Extended Address Register */
 #define SPINOR_OP_WREAR		0xc5	/* Write Extended Address Register */
 #define SPINOR_OP_SRSTEN	0x66	/* Software Reset Enable */
@@ -126,12 +124,6 @@
 /* Enhanced Volatile Configuration Register bits */
 #define EVCR_QUAD_EN_MICRON	BIT(7)	/* Micron Quad I/O */
 
-/* Flag Status Register bits */
-#define FSR_READY		BIT(7)	/* Device status, 0 = Busy, 1 = Ready */
-#define FSR_E_ERR		BIT(5)	/* Erase operation status */
-#define FSR_P_ERR		BIT(4)	/* Program operation status */
-#define FSR_PT_ERR		BIT(1)	/* Protection error bit */
-
 /* Status Register 2 bits. */
 #define SR2_QUAD_EN_BIT1	BIT(1)
 #define SR2_LB1			BIT(3)	/* Security Register Lock Bit 1 */
-- 
2.30.2

