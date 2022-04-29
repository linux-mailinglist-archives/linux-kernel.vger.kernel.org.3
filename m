Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3990C51462F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 12:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357216AbiD2KFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 06:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbiD2KFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:05:18 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7DA7C7BE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 03:01:59 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 861F022175;
        Fri, 29 Apr 2022 12:01:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1651226517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bHN+YVFNkrHS+uDny6aHJLOVATrXzxHFkucKsPmJ/eE=;
        b=miFygrRzKWMimTPiBfIl7coTuWiymwwhZfYmBDQiNVNEdnFgIVs0amV30UMLUiBM6UBUxP
        dbYSflOTKGtSZ4G6VNyQ9PxawnLCHySYQZ6Ds0/1bw5csh+XaRI/6SX4RiNAVl3Byv4KEE
        b5NNEkCnBYKt/IbTc4autOqF04gmHRM=
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2] mtd: spi-nor: move spi_nor_write_ear() to winbond module
Date:   Fri, 29 Apr 2022 12:01:53 +0200
Message-Id: <20220429100153.2338501-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "Extended Address Register" is winbond specific. If the flash is
larger than 16MiB and is used in 3 byte address mode, it is used to set
the remaining address bits. Move the write_ear() function, the opcode
macros and the spimem op template into the winbond module and rename
them accordingly.

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v1:
 - rebase to latest next
 - also move the opcode defines

 drivers/mtd/spi-nor/core.c    | 30 -------------------------
 drivers/mtd/spi-nor/core.h    |  7 ------
 drivers/mtd/spi-nor/winbond.c | 42 ++++++++++++++++++++++++++++++++++-
 include/linux/mtd/spi-nor.h   |  2 --
 4 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 6bf3921541b5..94f9847858bd 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -570,36 +570,6 @@ static int spansion_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 	return ret;
 }
 
-/**
- * spi_nor_write_ear() - Write Extended Address Register.
- * @nor:	pointer to 'struct spi_nor'.
- * @ear:	value to write to the Extended Address Register.
- *
- * Return: 0 on success, -errno otherwise.
- */
-int spi_nor_write_ear(struct spi_nor *nor, u8 ear)
-{
-	int ret;
-
-	nor->bouncebuf[0] = ear;
-
-	if (nor->spimem) {
-		struct spi_mem_op op = SPI_NOR_WREAR_OP(nor->bouncebuf);
-
-		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_WREAR,
-						       nor->bouncebuf, 1);
-	}
-
-	if (ret)
-		dev_dbg(nor->dev, "error %d writing EAR\n", ret);
-
-	return ret;
-}
-
 /**
  * spi_nor_sr_ready() - Query the Status Register to see if the flash is ready
  * for new commands.
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 658ed1779faa..c6a64c8e3a5a 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -72,12 +72,6 @@
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_DATA_OUT(1, buf, 0))
 
-#define SPI_NOR_WREAR_OP(buf)						\
-	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WREAR, 0),			\
-		   SPI_MEM_OP_NO_ADDR,					\
-		   SPI_MEM_OP_NO_DUMMY,					\
-		   SPI_MEM_OP_DATA_OUT(1, buf, 0))
-
 #define SPI_NOR_GBULK_OP						\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_GBULK, 0),			\
 		   SPI_MEM_OP_NO_ADDR,					\
@@ -635,7 +629,6 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
 int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
-int spi_nor_write_ear(struct spi_nor *nor, u8 ear);
 int spi_nor_wait_till_ready(struct spi_nor *nor);
 int spi_nor_global_block_unlock(struct spi_nor *nor);
 int spi_nor_lock_and_prep(struct spi_nor *nor);
diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 1e8fb571680b..5a7fa0b4142e 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -8,6 +8,15 @@
 
 #include "core.h"
 
+#define WINBOND_NOR_OP_RDEAR	0xc8	/* Read Extended Address Register */
+#define WINBOND_NOR_OP_WREAR	0xc5	/* Write Extended Address Register */
+
+#define WINBOND_NOR_WREAR_OP(buf)					\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(WINBOND_NOR_OP_WREAR, 0),		\
+		   SPI_MEM_OP_NO_ADDR,					\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_DATA_OUT(1, buf, 0))
+
 static int
 w25q256_post_bfpt_fixups(struct spi_nor *nor,
 			 const struct sfdp_parameter_header *bfpt_header,
@@ -130,6 +139,37 @@ static const struct flash_info winbond_nor_parts[] = {
 			      SPI_NOR_QUAD_READ) },
 };
 
+/**
+ * winbond_nor_write_ear() - Write Extended Address Register.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @ear:	value to write to the Extended Address Register.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int winbond_nor_write_ear(struct spi_nor *nor, u8 ear)
+{
+	int ret;
+
+	nor->bouncebuf[0] = ear;
+
+	if (nor->spimem) {
+		struct spi_mem_op op = WINBOND_NOR_WREAR_OP(nor->bouncebuf);
+
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
+		ret = spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret = spi_nor_controller_ops_write_reg(nor,
+						       WINBOND_NOR_OP_WREAR,
+						       nor->bouncebuf, 1);
+	}
+
+	if (ret)
+		dev_dbg(nor->dev, "error %d writing EAR\n", ret);
+
+	return ret;
+}
+
 /**
  * winbond_nor_set_4byte_addr_mode() - Set 4-byte address mode for Winbond
  * flashes.
@@ -156,7 +196,7 @@ static int winbond_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 	if (ret)
 		return ret;
 
-	ret = spi_nor_write_ear(nor, 0);
+	ret = winbond_nor_write_ear(nor, 0);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 5e25a7b75ae2..e505c4a5c530 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -47,8 +47,6 @@
 #define SPINOR_OP_RDID		0x9f	/* Read JEDEC ID */
 #define SPINOR_OP_RDSFDP	0x5a	/* Read SFDP */
 #define SPINOR_OP_RDCR		0x35	/* Read configuration register */
-#define SPINOR_OP_RDEAR		0xc8	/* Read Extended Address Register */
-#define SPINOR_OP_WREAR		0xc5	/* Write Extended Address Register */
 #define SPINOR_OP_SRSTEN	0x66	/* Software Reset Enable */
 #define SPINOR_OP_SRST		0x99	/* Software Reset */
 #define SPINOR_OP_GBULK		0x98    /* Global Block Unlock */
-- 
2.30.2

