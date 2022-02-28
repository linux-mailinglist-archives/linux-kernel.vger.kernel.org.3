Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759B44C6A04
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbiB1LS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbiB1LSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:18:14 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD66A1A2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 03:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646047055; x=1677583055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+858RdAMNjlEkMUdfziJy7i+wtZ5Om3Lqcya2mdiono=;
  b=iGwN+7YUtBHP0V8Xm9rmnwNJNdG92mTMWLRnCRSqTF1gnOj0hzL7Jq6R
   2FZHCStOimrNUR2VH20hcj+5J4mzBd9RySeu9HIX6lnoPthdX8JHtXLIV
   1H1mNQPEbg0w+e1HSyWznob3L4dQGtNYkzVJWDLkw8Gx2tEv3EoypGApB
   L3Xk5g+Vv6ZV0PhQa8ytzQmhPZYZZEmPrOpVkjbtZrcmt0Hcc7Oz6JVIi
   J9amJkGormlKXE6Or/y/60Jl+sfXET8PesqQj4dQbbcdo0yNAxvYc7pGm
   9guph9RHwWJqYLiRjMJUKhc306UVwNLisdOySJed6PWPmmAX18EXVTl/y
   w==;
X-IronPort-AV: E=Sophos;i="5.90,142,1643698800"; 
   d="scan'208";a="155099347"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Feb 2022 04:17:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 28 Feb 2022 04:17:24 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 28 Feb 2022 04:17:21 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 2/8] mtd: spi-nor: Introduce spi_nor_match_id()
Date:   Mon, 28 Feb 2022 13:17:06 +0200
Message-ID: <20220228111712.111737-3-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228111712.111737-1-tudor.ambarus@microchip.com>
References: <20220228111712.111737-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to spi_nor_match_name() extend the search of flash_info through
all the manufacturers, this time doing the match by ID. There's no reason
to limit the search per manufacturer yet, do it globally, search the flash
in all the parts of all manufacturers in a single method.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c | 40 ++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index f3c359d03163..f87cb7d3daab 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1629,16 +1629,21 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
 	&spi_nor_xmc,
 };
 
-static const struct flash_info *
-spi_nor_search_part_by_id(const struct flash_info *parts, unsigned int nparts,
-			  const u8 *id)
+static const struct flash_info *spi_nor_match_id(struct spi_nor *nor,
+						 const u8 *id)
 {
-	unsigned int i;
+	const struct flash_info *part;
+	unsigned int i, j;
 
-	for (i = 0; i < nparts; i++) {
-		if (parts[i].id_len &&
-		    !memcmp(parts[i].id, id, parts[i].id_len))
-			return &parts[i];
+	for (i = 0; i < ARRAY_SIZE(manufacturers); i++) {
+		for (j = 0; j < manufacturers[i]->nparts; j++) {
+			part = &manufacturers[i]->parts[j];
+			if (part->id_len &&
+			    !memcmp(part->id, id, part->id_len)) {
+				nor->manufacturer = manufacturers[i];
+				return part;
+			}
+		}
 	}
 
 	return NULL;
@@ -1648,7 +1653,6 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
 {
 	const struct flash_info *info;
 	u8 *id = nor->bouncebuf;
-	unsigned int i;
 	int ret;
 
 	if (nor->spimem) {
@@ -1668,19 +1672,13 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
 		return ERR_PTR(ret);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(manufacturers); i++) {
-		info = spi_nor_search_part_by_id(manufacturers[i]->parts,
-						 manufacturers[i]->nparts,
-						 id);
-		if (info) {
-			nor->manufacturer = manufacturers[i];
-			return info;
-		}
+	info = spi_nor_match_id(nor, id);
+	if (!info) {
+		dev_err(nor->dev, "unrecognized JEDEC id bytes: %*ph\n",
+			SPI_NOR_MAX_ID_LEN, id);
+		return ERR_PTR(-ENODEV);
 	}
-
-	dev_err(nor->dev, "unrecognized JEDEC id bytes: %*ph\n",
-		SPI_NOR_MAX_ID_LEN, id);
-	return ERR_PTR(-ENODEV);
+	return info;
 }
 
 static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
-- 
2.25.1

