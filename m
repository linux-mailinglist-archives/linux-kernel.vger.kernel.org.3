Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93297504F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbiDRL0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiDRL0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:26:50 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2521A3B0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 04:24:12 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 040AA22175;
        Mon, 18 Apr 2022 13:24:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650281050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=J2oZS6njRbW/e53awOChfnSOtco2+8cX206eZmrgK1I=;
        b=JRfy1r/rkKXUDXoTE57Lam4U23codb5EUkQl3fM/m0loGkFFOn+yOdIWyuJhtPg6BiB+HL
        5SFP6nY+32GdmPExEYXR+pyQ4fCNE3vTdb1tbHG8/0U03p3UeOvcf6W9X9jhXinGDdpt7O
        pgqLYxYT8c6YGPzzUYyYNuBOjDSP9kc=
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] mtd: spi-nor: move spi_nor_write_ear() to winbond module
Date:   Mon, 18 Apr 2022 13:24:04 +0200
Message-Id: <20220418112404.2790469-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
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

The "Extended Address Register" is winbond specific. If the flash is
larger than 16MiB and is used in 3 byte address mode, it is used to set
the remaining address bits. Move the write_ear() function the winbond
module and rename it accordingly.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/core.c    | 34 ---------------------------------
 drivers/mtd/spi-nor/core.h    |  1 -
 drivers/mtd/spi-nor/winbond.c | 36 ++++++++++++++++++++++++++++++++++-
 3 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index b4f141ad9c9c..848836535cdd 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -520,40 +520,6 @@ static int spansion_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
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
-		struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WREAR, 0),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 0));
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
index b7fd760e3b47..14bf28473cf3 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -526,7 +526,6 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
 int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
-int spi_nor_write_ear(struct spi_nor *nor, u8 ear);
 int spi_nor_wait_till_ready(struct spi_nor *nor);
 int spi_nor_global_block_unlock(struct spi_nor *nor);
 int spi_nor_lock_and_prep(struct spi_nor *nor);
diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 1e8fb571680b..0ca96efee5c9 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -130,6 +130,40 @@ static const struct flash_info winbond_nor_parts[] = {
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
+		struct spi_mem_op op =
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WREAR, 0),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 0));
+
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
+		ret = spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_WREAR,
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
@@ -156,7 +190,7 @@ static int winbond_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 	if (ret)
 		return ret;
 
-	ret = spi_nor_write_ear(nor, 0);
+	ret = winbond_nor_write_ear(nor, 0);
 	if (ret)
 		return ret;
 
-- 
2.30.2

