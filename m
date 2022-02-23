Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB3C4C1482
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241147AbiBWNpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241086AbiBWNow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:44:52 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80A1AC92C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:44:15 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2689822247;
        Wed, 23 Feb 2022 14:44:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645623854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IYl3MKifzSCwZWqS6/ku6kfSrHMIJbi0hdEtx6Zps4Q=;
        b=f4uQw8k2do7sbYOn3ZVI0bhMOfRKBUnSrIsgaiHyYYAAOj6cL9VKOY4/3KFx/PcdhrrezF
        mTf8ya9Yr5uPLNe/jUbpqUuQV4Z5YsVXcQbprNdpfZPiWyD6luiRM8ijSX8HthWTXjX4A0
        DNC5h/WAjC+RBWeZVQJzXWPbaC18sc4=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v5 22/32] mtd: spi-nor: xilinx: rename vendor specific functions and defines
Date:   Wed, 23 Feb 2022 14:43:48 +0100
Message-Id: <20220223134358.1914798-23-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220223134358.1914798-1-michael@walle.cc>
References: <20220223134358.1914798-1-michael@walle.cc>
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

Drop the generic spi_nor prefix for all the xilinx functions.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/xilinx.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/spi-nor/xilinx.c b/drivers/mtd/spi-nor/xilinx.c
index 05c7fe843a7d..ffd5579d45cb 100644
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
@@ -60,20 +60,20 @@ static u32 s3an_nor_convert_addr(struct spi_nor *nor, u32 addr)
 }
 
 /**
- * spi_nor_xread_sr() - Read the Status Register on S3AN flashes.
+ * xilinx_nor_read_sr() - Read the Status Register on S3AN flashes.
  * @nor:	pointer to 'struct spi_nor'.
  * @sr:		pointer to a DMA-able buffer where the value of the
  *              Status Register will be written.
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
+static int xilinx_nor_read_sr(struct spi_nor *nor, u8 *sr)
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
 
@@ -93,17 +93,17 @@ static int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
 }
 
 /**
- * spi_nor_xsr_ready() - Query the Status Register of the S3AN flash to see if
- * the flash is ready for new commands.
+ * xilinx_nor_sr_ready() - Query the Status Register of the S3AN flash to see
+ * if the flash is ready for new commands.
  * @nor:	pointer to 'struct spi_nor'.
  *
  * Return: 1 if ready, 0 if not ready, -errno on errors.
  */
-static int spi_nor_xsr_ready(struct spi_nor *nor)
+static int xilinx_nor_sr_ready(struct spi_nor *nor)
 {
 	int ret;
 
-	ret = spi_nor_xread_sr(nor, nor->bouncebuf);
+	ret = xilinx_nor_read_sr(nor, nor->bouncebuf);
 	if (ret)
 		return ret;
 
@@ -116,12 +116,12 @@ static int xilinx_nor_setup(struct spi_nor *nor,
 	u32 page_size;
 	int ret;
 
-	ret = spi_nor_xread_sr(nor, nor->bouncebuf);
+	ret = xilinx_nor_read_sr(nor, nor->bouncebuf);
 	if (ret)
 		return ret;
 
-	nor->erase_opcode = SPINOR_OP_XSE;
-	nor->program_opcode = SPINOR_OP_XPP;
+	nor->erase_opcode = XILINX_OP_SE;
+	nor->program_opcode = XILINX_OP_PP;
 	nor->read_opcode = SPINOR_OP_READ;
 	nor->flags |= SNOR_F_NO_OP_CHIP_ERASE;
 
@@ -155,7 +155,7 @@ static int xilinx_nor_setup(struct spi_nor *nor,
 static void xilinx_nor_late_init(struct spi_nor *nor)
 {
 	nor->params->setup = xilinx_nor_setup;
-	nor->params->ready = spi_nor_xsr_ready;
+	nor->params->ready = xilinx_nor_sr_ready;
 }
 
 static const struct spi_nor_fixups xilinx_nor_fixups = {
-- 
2.30.2

