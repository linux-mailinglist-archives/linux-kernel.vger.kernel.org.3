Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0604A7420
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241029AbiBBO7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:59:16 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:39231 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345260AbiBBO7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:59:04 -0500
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DF802223F6;
        Wed,  2 Feb 2022 15:59:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1643813943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Mb7Hw57gwlsZsvaib7xEeRanv0buA9g96Lty7UwaOw=;
        b=lsIhkBAJku+V9hddMsy4XsCV4J5o7+uMMQvfL0vlcy+4QAdehLB1Lge7z8l0dDgYmYZeZP
        znNaSz8J5cKtjRYL85Lu+GyQQUMiRRqX6a6872/CvAKbJt87ljn/J0R3f+0N0LHuzU8l1v
        OF2BURVC8bytFjnN51LkuUzgaMDO/Bc=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v1 05/14] mtd: spi-nor: xilinx: rename vendor specific functions and defines
Date:   Wed,  2 Feb 2022 15:58:44 +0100
Message-Id: <20220202145853.4187726-6-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202145853.4187726-1-michael@walle.cc>
References: <20220202145853.4187726-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the generic spi_nor prefix for all the xilinx functions.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/xilinx.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/spi-nor/xilinx.c b/drivers/mtd/spi-nor/xilinx.c
index a865dadc2e5d..3e85530df1e4 100644
--- a/drivers/mtd/spi-nor/xilinx.c
+++ b/drivers/mtd/spi-nor/xilinx.c
@@ -8,9 +8,9 @@
 
 #include "core.h"
 
-#define SPINOR_OP_XSE		0x50	/* Sector erase */
-#define SPINOR_OP_XPP		0x82	/* Page program */
-#define SPINOR_OP_XRDSR		0xd7	/* Read status register */
+#define XILINX_OP_SE		0x50	/* Sector erase */
+#define XILINX_OP_PP		0x82	/* Page program */
+#define XILINX_OP_RDSR		0xd7	/* Read status register */
 
 #define XSR_PAGESIZE		BIT(0)	/* Page size in Po2 or Linear */
 #define XSR_RDY			BIT(7)	/* Ready */
@@ -60,20 +60,20 @@ static u32 s3an_convert_addr(struct spi_nor *nor, u32 addr)
 }
 
 /**
- * spi_nor_xread_sr() - Read the Status Register on S3AN flashes.
+ * xilinx_read_sr() - Read the Status Register on S3AN flashes.
  * @nor:	pointer to 'struct spi_nor'.
  * @sr:		pointer to a DMA-able buffer where the value of the
  *              Status Register will be written.
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
+static int xilinx_read_sr(struct spi_nor *nor, u8 *sr)
 {
 	int ret;
 
 	if (nor->spimem) {
 		struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_XRDSR, 0),
+			SPI_MEM_OP(SPI_MEM_OP_CMD(XILINX_OP_RDSR, 0),
 				   SPI_MEM_OP_NO_ADDR,
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_DATA_IN(1, sr, 0));
@@ -82,7 +82,7 @@ static int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = spi_nor_controller_ops_read_reg(nor, SPINOR_OP_XRDSR, sr,
+		ret = spi_nor_controller_ops_read_reg(nor, XILINX_OP_RDSR, sr,
 						      1);
 	}
 
@@ -99,11 +99,11 @@ static int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
  *
  * Return: 1 if ready, 0 if not ready, -errno on errors.
  */
-static int spi_nor_xsr_ready(struct spi_nor *nor)
+static int xilinx_sr_ready(struct spi_nor *nor)
 {
 	int ret;
 
-	ret = spi_nor_xread_sr(nor, nor->bouncebuf);
+	ret = xilinx_read_sr(nor, nor->bouncebuf);
 	if (ret)
 		return ret;
 
@@ -116,12 +116,12 @@ static int xilinx_nor_setup(struct spi_nor *nor,
 	u32 page_size;
 	int ret;
 
-	ret = spi_nor_xread_sr(nor, nor->bouncebuf);
+	ret = xilinx_read_sr(nor, nor->bouncebuf);
 	if (ret)
 		return ret;
 
-	nor->erase_opcode = SPINOR_OP_XSE;
-	nor->program_opcode = SPINOR_OP_XPP;
+	nor->erase_opcode = XILINX_OP_SE;
+	nor->program_opcode = XILINX_OP_PP;
 	nor->read_opcode = SPINOR_OP_READ;
 	nor->flags |= SNOR_F_NO_OP_CHIP_ERASE;
 
@@ -155,7 +155,7 @@ static int xilinx_nor_setup(struct spi_nor *nor,
 static void xilinx_late_init(struct spi_nor *nor)
 {
 	nor->params->setup = xilinx_nor_setup;
-	nor->params->ready = spi_nor_xsr_ready;
+	nor->params->ready = xilinx_sr_ready;
 }
 
 static const struct spi_nor_fixups xilinx_fixups = {
-- 
2.30.2

