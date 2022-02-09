Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8311B4AF303
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbiBINiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbiBINh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:37:26 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9104EC05CB9E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 05:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644413835; x=1675949835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/CMjglc7GXjGxSQwp6Yw7IR1ZYGUEHdQnQhIO0fo1b8=;
  b=aTZkgRhRm+akKAn+mXAFlw4RvR8iSQK8a16K8YcQ4XUNN6LkH1eyu6dg
   WeyfQUhvG0xnY6iqMDqgfQht2cDqBiRaAuxc8h34Rx+3FWiwnzWG+Zhr2
   ShnDEZ1lCzE8wcJdX74vQQqRVpHiiqhXdWgNM+x1CMRFZUQPQU8AsHf++
   Xgf0GUT/0RmgYSjRFr1+H8LozIVcNg1Xi3f9tjkEZvemVGf4mVCHcAbhR
   6YBNw/Ba1WBETP0GmUptz1Pcx52jYIfZNoIZz1icSYGRgY0TC4EVZU5ie
   CWdWtQSpMQuAglSmuzz1PO9uhqzIVjgrSVZ3DLXW7PZfxYNyUB41UcGFk
   w==;
IronPort-SDR: xi/Zx1nNoDCg2sQC3WLhK5Wzx5fEgzKGYKSF71yE4UeIQKTHNOwNAsbhdXbO/ELNTvRJKR49Ga
 bcizM52sqMtDQ7sevNWwKROf18rKkULXzKNLUX7PtYiQvx02CjtX7/g3RWCsQJz/CjribmLVOR
 +NRjZ2iOEAtD/98md0tD2KzrvzkR0X5XIBmdNzXj3MFBCmUBE2585CviWj8yWZyaofSGufmC8V
 VmMYEGOf/NvSitx+KGa1lMk3hp6HyeDxPTSE2Masj9n4pozMsF/lBoFgQ6IadRnCxlGJtpwgam
 bksvnOSX0a2RRUJKR40tg7RA
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="145394778"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 06:37:14 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 06:37:13 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 9 Feb 2022 06:37:07 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <zhengxunli@mxic.com.tw>,
        <jaimeliao@mxic.com.tw>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v6 2/7] mtd: spi-nor: Introduce spi_nor_match_id()
Date:   Wed, 9 Feb 2022 15:36:51 +0200
Message-ID: <20220209133656.374903-3-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209133656.374903-1-tudor.ambarus@microchip.com>
References: <20220209133656.374903-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 345f9da96fab..335170fc2438 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1848,16 +1848,21 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
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
@@ -1867,7 +1872,6 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
 {
 	const struct flash_info *info;
 	u8 *id = nor->bouncebuf;
-	unsigned int i;
 	int ret;
 
 	if (nor->spimem) {
@@ -1887,19 +1891,13 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
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

