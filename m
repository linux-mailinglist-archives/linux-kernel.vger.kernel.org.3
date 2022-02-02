Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC83B4A7414
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345454AbiBBO7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:59:39 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:43019 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345289AbiBBO7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:59:06 -0500
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8D7D622450;
        Wed,  2 Feb 2022 15:59:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1643813945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7whRIAEN3XV+TYJgN8JQzN2CwvVyIpxN+ADDsSc+jig=;
        b=ELnToSwbFXckAhUeV+uQx3cBa9wmSwXey1Lx8PmU1XK1GR0vqE0YPMD5gdNLD2HwMZ9vnG
        hBswexYmaUlGNdpVyzXv9xPjtawnBfcsL7eIGWqfNq5eOomgyvWUYX4myWh9nNAA071eRw
        2Dg+3AjyBcof0pM/Vizjn8M9tcdIupY=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v1 12/14] mtd: spi-nor: move all spansion specifics into spansion.c
Date:   Wed,  2 Feb 2022 15:58:51 +0100
Message-Id: <20220202145853.4187726-13-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202145853.4187726-1-michael@walle.cc>
References: <20220202145853.4187726-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clear status register flags is only available on spansion flashes.
Move all the functions around that into the spanion module.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/core.c     | 52 +------------------------
 drivers/mtd/spi-nor/spansion.c | 70 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h    |  1 -
 3 files changed, 72 insertions(+), 51 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index be65aaa954ca..5b00dfab77a6 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -554,33 +554,6 @@ int spi_nor_write_ear(struct spi_nor *nor, u8 ear)
 	return ret;
 }
 
-/**
- * spi_nor_clear_sr() - Clear the Status Register.
- * @nor:	pointer to 'struct spi_nor'.
- */
-static void spi_nor_clear_sr(struct spi_nor *nor)
-{
-	int ret;
-
-	if (nor->spimem) {
-		struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLSR, 0),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_NO_DATA);
-
-		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_CLSR,
-						       NULL, 0);
-	}
-
-	if (ret)
-		dev_dbg(nor->dev, "error %d clearing SR\n", ret);
-}
-
 /**
  * spi_nor_sr_ready() - Query the Status Register to see if the flash is ready
  * for new commands.
@@ -590,33 +563,12 @@ static void spi_nor_clear_sr(struct spi_nor *nor)
  */
 int spi_nor_sr_ready(struct spi_nor *nor)
 {
-	int ret = spi_nor_read_sr(nor, nor->bouncebuf);
+	int ret;
 
+	ret = spi_nor_read_sr(nor, nor->bouncebuf);
 	if (ret)
 		return ret;
 
-	if (nor->flags & SNOR_F_USE_CLSR &&
-	    nor->bouncebuf[0] & (SR_E_ERR | SR_P_ERR)) {
-		if (nor->bouncebuf[0] & SR_E_ERR)
-			dev_err(nor->dev, "Erase Error occurred\n");
-		else
-			dev_err(nor->dev, "Programming Error occurred\n");
-
-		spi_nor_clear_sr(nor);
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
 	return !(nor->bouncebuf[0] & SR_WIP);
 }
 
diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index dedc2de90cb8..4756fb88eab2 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -8,6 +8,7 @@
 
 #include "core.h"
 
+#define SPINOR_OP_CLSR		0x30	/* Clear status register 1 */
 #define SPINOR_OP_RD_ANY_REG			0x65	/* Read any register */
 #define SPINOR_OP_WR_ANY_REG			0x71	/* Write any register */
 #define SPINOR_REG_CYPRESS_CFR2V		0x00800003
@@ -294,6 +295,72 @@ static const struct flash_info spansion_parts[] = {
 	},
 };
 
+/**
+ * spi_nor_clear_sr() - Clear the Status Register.
+ * @nor:	pointer to 'struct spi_nor'.
+ */
+static void spi_nor_clear_sr(struct spi_nor *nor)
+{
+	int ret;
+
+	if (nor->spimem) {
+		struct spi_mem_op op =
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLSR, 0),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_NO_DATA);
+
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
+		ret = spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_CLSR,
+						       NULL, 0);
+	}
+
+	if (ret)
+		dev_dbg(nor->dev, "error %d clearing SR\n", ret);
+}
+
+/**
+ * spi_nor_sr_ready_and_clear() - Query the Status Register to see if the flash
+ * is ready for new commands and clear it.
+ * @nor:	pointer to 'struct spi_nor'.
+ *
+ * Return: 1 if ready, 0 if not ready, -errno on errors.
+ */
+int spi_nor_sr_ready_and_clear(struct spi_nor *nor)
+{
+	int ret;
+
+	ret = spi_nor_read_sr(nor, nor->bouncebuf);
+	if (ret)
+		return ret;
+
+	if (nor->bouncebuf[0] & (SR_E_ERR | SR_P_ERR)) {
+		if (nor->bouncebuf[0] & SR_E_ERR)
+			dev_err(nor->dev, "Erase Error occurred\n");
+		else
+			dev_err(nor->dev, "Programming Error occurred\n");
+
+		spi_nor_clear_sr(nor);
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
+	return !(nor->bouncebuf[0] & SR_WIP);
+}
+
 static void spansion_late_init(struct spi_nor *nor)
 {
 	if (nor->params->size > SZ_16M) {
@@ -302,6 +369,9 @@ static void spansion_late_init(struct spi_nor *nor)
 		nor->erase_opcode = SPINOR_OP_SE;
 		nor->mtd.erasesize = nor->info->sector_size;
 	}
+
+	if (nor->flags & SNOR_F_USE_CLSR)
+		nor->params->ready = spi_nor_sr_ready_and_clear;
 }
 
 static const struct spi_nor_fixups spansion_fixups = {
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 4622251a79ff..5e25a7b75ae2 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -90,7 +90,6 @@
 
 /* Used for Spansion flashes only. */
 #define SPINOR_OP_BRWR		0x17	/* Bank register write */
-#define SPINOR_OP_CLSR		0x30	/* Clear status register 1 */
 
 /* Used for Micron flashes only. */
 #define SPINOR_OP_RD_EVCR      0x65    /* Read EVCR register */
-- 
2.30.2

