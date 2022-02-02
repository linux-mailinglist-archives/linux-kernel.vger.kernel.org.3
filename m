Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9E44A7419
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345379AbiBBO7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345272AbiBBO7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:59:05 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEB8C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 06:59:04 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3884A223F0;
        Wed,  2 Feb 2022 15:59:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1643813942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fmAquychthIKrgzA1gE1u+HXxd7GY+EGxyYUz3rjGHo=;
        b=dQGwZzjVdVI200OR/VgcXl18HfdgDkZ5fdIkl43hUXjh5/U444iTp2QfsxDHijQMAaRNNb
        Y1qp0NnMqD8ygHrB3S1ChiSx1B5u/sblnONMRi6c+XdyuK7EhHiDLNNpxlvSRUzsz9M5dc
        qgKxghS9EWtHMjzYUbk+m4fe8MpwS04=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v1 04/14] mtd: spi-nor: move all xilinx specifics into xilinx.c
Date:   Wed,  2 Feb 2022 15:58:43 +0100
Message-Id: <20220202145853.4187726-5-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202145853.4187726-1-michael@walle.cc>
References: <20220202145853.4187726-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mechanically move all the xilinx functions to its own module.

Then register the new flash specific ready() function.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/core.c   | 64 +------------------------------
 drivers/mtd/spi-nor/core.h   | 18 ---------
 drivers/mtd/spi-nor/xilinx.c | 73 ++++++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h  |  9 -----
 4 files changed, 74 insertions(+), 90 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index c181f2680df2..fdc8ef623254 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -598,57 +598,6 @@ int spi_nor_write_ear(struct spi_nor *nor, u8 ear)
 	return ret;
 }
 
-/**
- * spi_nor_xread_sr() - Read the Status Register on S3AN flashes.
- * @nor:	pointer to 'struct spi_nor'.
- * @sr:		pointer to a DMA-able buffer where the value of the
- *              Status Register will be written.
- *
- * Return: 0 on success, -errno otherwise.
- */
-int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
-{
-	int ret;
-
-	if (nor->spimem) {
-		struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_XRDSR, 0),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_IN(1, sr, 0));
-
-		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = spi_nor_controller_ops_read_reg(nor, SPINOR_OP_XRDSR, sr,
-						      1);
-	}
-
-	if (ret)
-		dev_dbg(nor->dev, "error %d reading XRDSR\n", ret);
-
-	return ret;
-}
-
-/**
- * spi_nor_xsr_ready() - Query the Status Register of the S3AN flash to see if
- * the flash is ready for new commands.
- * @nor:	pointer to 'struct spi_nor'.
- *
- * Return: 1 if ready, 0 if not ready, -errno on errors.
- */
-static int spi_nor_xsr_ready(struct spi_nor *nor)
-{
-	int ret;
-
-	ret = spi_nor_xread_sr(nor, nor->bouncebuf);
-	if (ret)
-		return ret;
-
-	return !!(nor->bouncebuf[0] & XSR_RDY);
-}
-
 /**
  * spi_nor_clear_sr() - Clear the Status Register.
  * @nor:	pointer to 'struct spi_nor'.
@@ -798,10 +747,7 @@ static int spi_nor_ready(struct spi_nor *nor)
 	if (nor->params->ready)
 		return nor->params->ready(nor);
 
-	if (nor->flags & SNOR_F_READY_XSR_RDY)
-		sr = spi_nor_xsr_ready(nor);
-	else
-		sr = spi_nor_sr_ready(nor);
+	sr = spi_nor_sr_ready(nor);
 	if (sr < 0)
 		return sr;
 	fsr = nor->flags & SNOR_F_USE_FSR ? spi_nor_fsr_ready(nor) : 1;
@@ -2677,14 +2623,6 @@ static void spi_nor_init_flags(struct spi_nor *nor)
 
 	if (flags & USE_FSR)
 		nor->flags |= SNOR_F_USE_FSR;
-
-	/*
-	 * Make sure the XSR_RDY flag is set before calling
-	 * spi_nor_wait_till_ready(). Xilinx S3AN share MFR
-	 * with Atmel SPI NOR.
-	 */
-	if (flags & SPI_NOR_XSR_RDY)
-		nor->flags |=  SNOR_F_READY_XSR_RDY;
 }
 
 /**
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 446218b0e017..fabc01ae9a81 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -15,7 +15,6 @@ enum spi_nor_option_flags {
 	SNOR_F_USE_FSR		= BIT(0),
 	SNOR_F_HAS_SR_TB	= BIT(1),
 	SNOR_F_NO_OP_CHIP_ERASE	= BIT(2),
-	SNOR_F_READY_XSR_RDY	= BIT(3),
 	SNOR_F_USE_CLSR		= BIT(4),
 	SNOR_F_BROKEN_RESET	= BIT(5),
 	SNOR_F_4B_OPCODES	= BIT(6),
@@ -351,8 +350,6 @@ struct spi_nor_fixups {
  *   SPI_NOR_NO_FR:           can't do fastread.
  *   USE_CLSR:                use CLSR command.
  *   USE_FSR:                 use flag status register
- *   SPI_NOR_XSR_RDY:         S3AN flashes have specific opcode to read the
- *                            status register.
  *
  * @no_sfdp_flags:  flags that indicate support that can be discovered via SFDP.
  *                  Used when SFDP tables are not defined in the flash. These
@@ -405,7 +402,6 @@ struct flash_info {
 #define SPI_NOR_NO_FR			BIT(8)
 #define USE_CLSR			BIT(9)
 #define USE_FSR				BIT(10)
-#define SPI_NOR_XSR_RDY			BIT(11)
 
 	u8 no_sfdp_flags;
 #define SPI_NOR_SKIP_SFDP		BIT(0)
@@ -462,19 +458,6 @@ struct flash_info {
 		.addr_width = (_addr_width),				\
 		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,		\
 
-#define S3AN_INFO(_jedec_id, _n_sectors, _page_size)			\
-		.id = {							\
-			((_jedec_id) >> 16) & 0xff,			\
-			((_jedec_id) >> 8) & 0xff,			\
-			(_jedec_id) & 0xff				\
-			},						\
-		.id_len = 3,						\
-		.sector_size = (8*_page_size),				\
-		.n_sectors = (_n_sectors),				\
-		.page_size = _page_size,				\
-		.addr_width = 3,					\
-		.flags = SPI_NOR_NO_FR | SPI_NOR_XSR_RDY,
-
 #define OTP_INFO(_len, _n_regions, _base, _offset)			\
 		.otp_org = {						\
 			.len = (_len),					\
@@ -564,7 +547,6 @@ int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len);
 int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 sr1);
 int spi_nor_write_16bit_cr_and_check(struct spi_nor *nor, u8 cr);
 
-int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr);
 ssize_t spi_nor_read_data(struct spi_nor *nor, loff_t from, size_t len,
 			  u8 *buf);
 ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
diff --git a/drivers/mtd/spi-nor/xilinx.c b/drivers/mtd/spi-nor/xilinx.c
index 580562bc1e45..a865dadc2e5d 100644
--- a/drivers/mtd/spi-nor/xilinx.c
+++ b/drivers/mtd/spi-nor/xilinx.c
@@ -8,6 +8,27 @@
 
 #include "core.h"
 
+#define SPINOR_OP_XSE		0x50	/* Sector erase */
+#define SPINOR_OP_XPP		0x82	/* Page program */
+#define SPINOR_OP_XRDSR		0xd7	/* Read status register */
+
+#define XSR_PAGESIZE		BIT(0)	/* Page size in Po2 or Linear */
+#define XSR_RDY			BIT(7)	/* Ready */
+
+#define S3AN_INFO(_jedec_id, _n_sectors, _page_size)			\
+		.id = {							\
+			((_jedec_id) >> 16) & 0xff,			\
+			((_jedec_id) >> 8) & 0xff,			\
+			(_jedec_id) & 0xff				\
+			},						\
+		.id_len = 3,						\
+		.sector_size = (8*_page_size),				\
+		.n_sectors = (_n_sectors),				\
+		.page_size = _page_size,				\
+		.addr_width = 3,					\
+		.flags = SPI_NOR_NO_FR
+
+/* Xilinx S3AN share MFR with Atmel SPI NOR */
 static const struct flash_info xilinx_parts[] = {
 	/* Xilinx S3AN Internal Flash */
 	{ "3S50AN", S3AN_INFO(0x1f2200, 64, 264) },
@@ -38,6 +59,57 @@ static u32 s3an_convert_addr(struct spi_nor *nor, u32 addr)
 	return page | offset;
 }
 
+/**
+ * spi_nor_xread_sr() - Read the Status Register on S3AN flashes.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @sr:		pointer to a DMA-able buffer where the value of the
+ *              Status Register will be written.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
+{
+	int ret;
+
+	if (nor->spimem) {
+		struct spi_mem_op op =
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_XRDSR, 0),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_DATA_IN(1, sr, 0));
+
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
+		ret = spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret = spi_nor_controller_ops_read_reg(nor, SPINOR_OP_XRDSR, sr,
+						      1);
+	}
+
+	if (ret)
+		dev_dbg(nor->dev, "error %d reading XRDSR\n", ret);
+
+	return ret;
+}
+
+/**
+ * spi_nor_xsr_ready() - Query the Status Register of the S3AN flash to see if
+ * the flash is ready for new commands.
+ * @nor:	pointer to 'struct spi_nor'.
+ *
+ * Return: 1 if ready, 0 if not ready, -errno on errors.
+ */
+static int spi_nor_xsr_ready(struct spi_nor *nor)
+{
+	int ret;
+
+	ret = spi_nor_xread_sr(nor, nor->bouncebuf);
+	if (ret)
+		return ret;
+
+	return !!(nor->bouncebuf[0] & XSR_RDY);
+}
+
 static int xilinx_nor_setup(struct spi_nor *nor,
 			    const struct spi_nor_hwcaps *hwcaps)
 {
@@ -83,6 +155,7 @@ static int xilinx_nor_setup(struct spi_nor *nor,
 static void xilinx_late_init(struct spi_nor *nor)
 {
 	nor->params->setup = xilinx_nor_setup;
+	nor->params->ready = spi_nor_xsr_ready;
 }
 
 static const struct spi_nor_fixups xilinx_fixups = {
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index fc90fce26e33..b44b05a6f934 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -86,15 +86,6 @@
 #define SPINOR_OP_BP		0x02	/* Byte program */
 #define SPINOR_OP_AAI_WP	0xad	/* Auto address increment word program */
 
-/* Used for S3AN flashes only */
-#define SPINOR_OP_XSE		0x50	/* Sector erase */
-#define SPINOR_OP_XPP		0x82	/* Page program */
-#define SPINOR_OP_XRDSR		0xd7	/* Read status register */
-
-#define XSR_PAGESIZE		BIT(0)	/* Page size in Po2 or Linear */
-#define XSR_RDY			BIT(7)	/* Ready */
-
-
 /* Used for Macronix and Winbond flashes. */
 #define SPINOR_OP_EN4B		0xb7	/* Enter 4-byte mode */
 #define SPINOR_OP_EX4B		0xe9	/* Exit 4-byte mode */
-- 
2.30.2

