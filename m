Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FE54BDC8A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357449AbiBUMKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:10:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357304AbiBUMIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:08:50 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58595205D8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:08:26 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A18F422452;
        Mon, 21 Feb 2022 13:08:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645445304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=toZmYMnm+du58DgEiyl/+z7EezURQIhbZ+ekj4hpZoY=;
        b=RYRjQQkvI0ytLYuG2Mh986w8voOGv0ZlYXFcIjaqO0afOGJiToAo7781ijl2ssDRERPH65
        Rpv82ZRr4kN76Cw0ZfYLemoCC5slKoaaYKzN6qOtBm86Hl02QI9O5gJguGbR5TgwEZDT7X
        1Nh7/ZLRERKtUDuOTVbzqDX6ECfVAr8=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v4 13/32] mtd: spi-nor: sst: unify function names
Date:   Mon, 21 Feb 2022 13:07:50 +0100
Message-Id: <20220221120809.1531502-14-michael@walle.cc>
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

To avoid name clashes unify all the function and static object names and
use one of the following prefixes which should be sufficiently unique:
 - <vendor>_nor_
 - <flash_family>_nor_
 - <flash_part>_

There are no functional changes.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/sst.c | 44 +++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 30183e9189b9..63bcc97bf978 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -13,12 +13,12 @@
 
 #define SST26VF_CR_BPNV		BIT(3)
 
-static int sst26vf_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+static int sst26vf_nor_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 {
 	return -EOPNOTSUPP;
 }
 
-static int sst26vf_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+static int sst26vf_nor_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 {
 	int ret;
 
@@ -38,27 +38,27 @@ static int sst26vf_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 	return spi_nor_global_block_unlock(nor);
 }
 
-static int sst26vf_is_locked(struct spi_nor *nor, loff_t ofs, uint64_t len)
+static int sst26vf_nor_is_locked(struct spi_nor *nor, loff_t ofs, uint64_t len)
 {
 	return -EOPNOTSUPP;
 }
 
-static const struct spi_nor_locking_ops sst26vf_locking_ops = {
-	.lock = sst26vf_lock,
-	.unlock = sst26vf_unlock,
-	.is_locked = sst26vf_is_locked,
+static const struct spi_nor_locking_ops sst26vf_nor_locking_ops = {
+	.lock = sst26vf_nor_lock,
+	.unlock = sst26vf_nor_unlock,
+	.is_locked = sst26vf_nor_is_locked,
 };
 
-static void sst26vf_late_init(struct spi_nor *nor)
+static void sst26vf_nor_late_init(struct spi_nor *nor)
 {
-	nor->params->locking_ops = &sst26vf_locking_ops;
+	nor->params->locking_ops = &sst26vf_nor_locking_ops;
 }
 
-static const struct spi_nor_fixups sst26vf_fixups = {
-	.late_init = sst26vf_late_init,
+static const struct spi_nor_fixups sst26vf_nor_fixups = {
+	.late_init = sst26vf_nor_late_init,
 };
 
-static const struct flash_info sst_parts[] = {
+static const struct flash_info sst_nor_parts[] = {
 	/* SST -- large erase sizes are "overlays", "sectors" are 4K */
 	{ "sst25vf040b", INFO(0xbf258d, 0, 64 * 1024,  8)
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
@@ -114,11 +114,11 @@ static const struct flash_info sst_parts[] = {
 	{ "sst26vf064b", INFO(0xbf2643, 0, 64 * 1024, 128)
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		.fixups = &sst26vf_fixups },
+		.fixups = &sst26vf_nor_fixups },
 };
 
-static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
-		     size_t *retlen, const u_char *buf)
+static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
+			 size_t *retlen, const u_char *buf)
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
 	size_t actual = 0;
@@ -203,19 +203,19 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 	return ret;
 }
 
-static void sst_late_init(struct spi_nor *nor)
+static void sst_nor_late_init(struct spi_nor *nor)
 {
 	if (nor->info->mfr_flags & SST_WRITE)
-		nor->mtd._write = sst_write;
+		nor->mtd._write = sst_nor_write;
 }
 
-static const struct spi_nor_fixups sst_fixups = {
-	.late_init = sst_late_init,
+static const struct spi_nor_fixups sst_nor_fixups = {
+	.late_init = sst_nor_late_init,
 };
 
 const struct spi_nor_manufacturer spi_nor_sst = {
 	.name = "sst",
-	.parts = sst_parts,
-	.nparts = ARRAY_SIZE(sst_parts),
-	.fixups = &sst_fixups,
+	.parts = sst_nor_parts,
+	.nparts = ARRAY_SIZE(sst_nor_parts),
+	.fixups = &sst_nor_fixups,
 };
-- 
2.30.2

