Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7AD4BE129
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244887AbiBUIzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:55:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345678AbiBUIxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:53:24 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEFE1B797
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:52:56 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 172AF223ED;
        Mon, 21 Feb 2022 09:52:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645433574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h7zaNDx+xivNa+dXA2W3QIZqvaWPcNR2U/9NPZ5jG3k=;
        b=vqqTMFH5AZAg1wiZgzAJ4OJFiTdXyK5plDkR87y8N7eSF2iNNGG1A+p0iMUOIad1bOBzo7
        oE/LT0js6kw2EDerZ2inJJdUuYqFDijvHA6ijNkcV1n64jpxdMbFovwFtkgKh51EPhYS/A
        ywD/XOexW7/Nt+oZQzJ+7RQEfgSredo=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v3 12/32] mtd: spi-nor: spansion: unify function names
Date:   Mon, 21 Feb 2022 09:52:16 +0100
Message-Id: <20220221085236.1452024-13-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220221085236.1452024-1-michael@walle.cc>
References: <20220221085236.1452024-1-michael@walle.cc>
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

To avoid name clashes unify all the function and static object names and
use one of the following prefixes which should be sufficiently unique:
 - <vendor>_nor_
 - <flash_family>_nor_
 - <flash_part>_

There are no functional changes.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/spansion.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 534196b1d3e7..dea021a8c9e4 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -20,7 +20,7 @@
 #define SPINOR_OP_CYPRESS_RD_FAST		0xee
 
 /**
- * spi_nor_cypress_octal_dtr_enable() - Enable octal DTR on Cypress flashes.
+ * cypress_nor_octal_dtr_enable() - Enable octal DTR on Cypress flashes.
  * @nor:		pointer to a 'struct spi_nor'
  * @enable:              whether to enable or disable Octal DTR
  *
@@ -29,7 +29,7 @@
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int spi_nor_cypress_octal_dtr_enable(struct spi_nor *nor, bool enable)
+static int cypress_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
 {
 	struct spi_mem_op op;
 	u8 *buf = nor->bouncebuf;
@@ -116,7 +116,7 @@ static int spi_nor_cypress_octal_dtr_enable(struct spi_nor *nor, bool enable)
 
 static void s28hs512t_default_init(struct spi_nor *nor)
 {
-	nor->params->octal_dtr_enable = spi_nor_cypress_octal_dtr_enable;
+	nor->params->octal_dtr_enable = cypress_nor_octal_dtr_enable;
 	nor->params->writesize = 16;
 }
 
@@ -183,9 +183,9 @@ static const struct spi_nor_fixups s28hs512t_fixups = {
 };
 
 static int
-s25fs_s_post_bfpt_fixups(struct spi_nor *nor,
-			 const struct sfdp_parameter_header *bfpt_header,
-			 const struct sfdp_bfpt *bfpt)
+s25fs_s_nor_post_bfpt_fixups(struct spi_nor *nor,
+			     const struct sfdp_parameter_header *bfpt_header,
+			     const struct sfdp_bfpt *bfpt)
 {
 	/*
 	 * The S25FS-S chip family reports 512-byte pages in BFPT but
@@ -198,11 +198,11 @@ s25fs_s_post_bfpt_fixups(struct spi_nor *nor,
 	return 0;
 }
 
-static const struct spi_nor_fixups s25fs_s_fixups = {
-	.post_bfpt = s25fs_s_post_bfpt_fixups,
+static const struct spi_nor_fixups s25fs_s_nor_fixups = {
+	.post_bfpt = s25fs_s_nor_post_bfpt_fixups,
 };
 
-static const struct flash_info spansion_parts[] = {
+static const struct flash_info spansion_nor_parts[] = {
 	/* Spansion/Cypress -- single (large) sector size only, at least
 	 * for the chips listed here (without boot sectors).
 	 */
@@ -294,7 +294,7 @@ static const struct flash_info spansion_parts[] = {
 	},
 };
 
-static void spansion_late_init(struct spi_nor *nor)
+static void spansion_nor_late_init(struct spi_nor *nor)
 {
 	if (nor->params->size <= SZ_16M)
 		return;
@@ -305,13 +305,13 @@ static void spansion_late_init(struct spi_nor *nor)
 	nor->mtd.erasesize = nor->info->sector_size;
 }
 
-static const struct spi_nor_fixups spansion_fixups = {
-	.late_init = spansion_late_init,
+static const struct spi_nor_fixups spansion_nor_fixups = {
+	.late_init = spansion_nor_late_init,
 };
 
 const struct spi_nor_manufacturer spi_nor_spansion = {
 	.name = "spansion",
-	.parts = spansion_parts,
-	.nparts = ARRAY_SIZE(spansion_parts),
-	.fixups = &spansion_fixups,
+	.parts = spansion_nor_parts,
+	.nparts = ARRAY_SIZE(spansion_nor_parts),
+	.fixups = &spansion_nor_fixups,
 };
-- 
2.30.2

