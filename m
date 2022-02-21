Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFABE4BDC5F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346031AbiBUIzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:55:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345642AbiBUIxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:53:23 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDC21AD9A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:52:55 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 138152244E;
        Mon, 21 Feb 2022 09:52:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645433573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h59sIJ19TU9KRoi6jqsNtCtVCMchssKrtqw3t16scK0=;
        b=dr8RvJnx6wG855NqELkPpLq3prl7UnDi9MFcr+eQmrmdypomgVhwfRBy7mTMckt7fgq6+p
        hfzZs/cWoPhn1rN/NVCh6Z3nMNsqswFYl/KkR1qkaPTLM7i8j+asr1M6NuCMh5xR7xdKQm
        GmO/TSFBQOOxhXcq/8B7gDzAvmEnCtw=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v3 11/32] mtd: spi-nor: micron-st: unify function names
Date:   Mon, 21 Feb 2022 09:52:15 +0100
Message-Id: <20220221085236.1452024-12-michael@walle.cc>
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
 drivers/mtd/spi-nor/micron-st.c | 34 ++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index bb95b1aabf74..7a68f2ad3ea1 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -17,7 +17,7 @@
 #define SPINOR_MT_OCT_DTR	0xe7	/* Enable Octal DTR. */
 #define SPINOR_MT_EXSPI		0xff	/* Enable Extended SPI (default) */
 
-static int spi_nor_micron_octal_dtr_enable(struct spi_nor *nor, bool enable)
+static int micron_st_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
 {
 	struct spi_mem_op op;
 	u8 *buf = nor->bouncebuf;
@@ -102,7 +102,7 @@ static int spi_nor_micron_octal_dtr_enable(struct spi_nor *nor, bool enable)
 
 static void mt35xu512aba_default_init(struct spi_nor *nor)
 {
-	nor->params->octal_dtr_enable = spi_nor_micron_octal_dtr_enable;
+	nor->params->octal_dtr_enable = micron_st_nor_octal_dtr_enable;
 }
 
 static void mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor)
@@ -130,7 +130,7 @@ static const struct spi_nor_fixups mt35xu512aba_fixups = {
 	.post_sfdp = mt35xu512aba_post_sfdp_fixup,
 };
 
-static const struct flash_info micron_parts[] = {
+static const struct flash_info micron_nor_parts[] = {
 	{ "mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512)
 		FLAGS(USE_FSR)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_READ |
@@ -143,7 +143,7 @@ static const struct flash_info micron_parts[] = {
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
 };
 
-static const struct flash_info st_parts[] = {
+static const struct flash_info st_nor_parts[] = {
 	{ "n25q016a",	 INFO(0x20bb15, 0, 64 * 1024,   32)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ) },
 	{ "n25q032",	 INFO(0x20ba16, 0, 64 * 1024,   64)
@@ -250,15 +250,15 @@ static const struct flash_info st_parts[] = {
 };
 
 /**
- * st_micron_set_4byte_addr_mode() - Set 4-byte address mode for ST and Micron
- * flashes.
+ * micron_st_nor_set_4byte_addr_mode() - Set 4-byte address mode for ST and
+ * Micron flashes.
  * @nor:	pointer to 'struct spi_nor'.
  * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
  *		address mode.
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int st_micron_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
+static int micron_st_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 {
 	int ret;
 
@@ -273,28 +273,28 @@ static int st_micron_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 	return spi_nor_write_disable(nor);
 }
 
-static void micron_st_default_init(struct spi_nor *nor)
+static void micron_st_nor_default_init(struct spi_nor *nor)
 {
 	nor->flags |= SNOR_F_HAS_LOCK;
 	nor->flags &= ~SNOR_F_HAS_16BIT_SR;
 	nor->params->quad_enable = NULL;
-	nor->params->set_4byte_addr_mode = st_micron_set_4byte_addr_mode;
+	nor->params->set_4byte_addr_mode = micron_st_nor_set_4byte_addr_mode;
 }
 
-static const struct spi_nor_fixups micron_st_fixups = {
-	.default_init = micron_st_default_init,
+static const struct spi_nor_fixups micron_st_nor_fixups = {
+	.default_init = micron_st_nor_default_init,
 };
 
 const struct spi_nor_manufacturer spi_nor_micron = {
 	.name = "micron",
-	.parts = micron_parts,
-	.nparts = ARRAY_SIZE(micron_parts),
-	.fixups = &micron_st_fixups,
+	.parts = micron_nor_parts,
+	.nparts = ARRAY_SIZE(micron_nor_parts),
+	.fixups = &micron_st_nor_fixups,
 };
 
 const struct spi_nor_manufacturer spi_nor_st = {
 	.name = "st",
-	.parts = st_parts,
-	.nparts = ARRAY_SIZE(st_parts),
-	.fixups = &micron_st_fixups,
+	.parts = st_nor_parts,
+	.nparts = ARRAY_SIZE(st_nor_parts),
+	.fixups = &micron_st_nor_fixups,
 };
-- 
2.30.2

