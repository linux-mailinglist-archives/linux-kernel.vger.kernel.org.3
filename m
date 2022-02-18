Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31124BB840
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbiBRLhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 06:37:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbiBRLgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:36:40 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72294389A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:36:23 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 26C3022455;
        Fri, 18 Feb 2022 12:36:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645184178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mAAklKio0JJkGw53kWM7gFAN8lZmsvKpPSFctQzn+dA=;
        b=Q4wG2obFYxqxCm2/+QCY4HDCh4BIZEenfqLIlVwzlJj6Q70JWuwNmt3ezO3La3Qzctz0s2
        CCQWVkH0cs60B3YHaOU7nHZfSqcn9kixKlSOe1taVJYI2XKbQQKtJozcPR4w4uwLSGx/IP
        VJ2oAqKOju2k1vga/ufkt9er2LlSkuI=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v2 13/32] mtd: spi-nor: sst: unify function names
Date:   Fri, 18 Feb 2022 12:35:48 +0100
Message-Id: <20220218113607.1360020-14-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220218113607.1360020-1-michael@walle.cc>
References: <20220218113607.1360020-1-michael@walle.cc>
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
 - <flash_family>_
 - <flash_part>_

There are no functional changes.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/sst.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 30183e9189b9..45d277d62584 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -58,7 +58,7 @@ static const struct spi_nor_fixups sst26vf_fixups = {
 	.late_init = sst26vf_late_init,
 };
 
-static const struct flash_info sst_parts[] = {
+static const struct flash_info sst_nor_parts[] = {
 	/* SST -- large erase sizes are "overlays", "sectors" are 4K */
 	{ "sst25vf040b", INFO(0xbf258d, 0, 64 * 1024,  8)
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
@@ -117,8 +117,8 @@ static const struct flash_info sst_parts[] = {
 		.fixups = &sst26vf_fixups },
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

