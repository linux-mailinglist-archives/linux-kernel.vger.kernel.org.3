Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB9D5085FF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377714AbiDTKhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352261AbiDTKhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:37:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75913FBD3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650450876; x=1681986876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4wzFQsZmZ98FaEgGawwjLvUzNU/hfRAMoTc4fQNV+FA=;
  b=ehEK/rAoMiHetC82WEAfGtqwakwBth1bCifIEyiz4nEYqJX05M97ac93
   rR7mgXy2RnD2pgMFYSwBSf4f1NgeNjC0DzkTSFQXhgpnMkuNWBzQUIILe
   PAkbgqOhCjM3co8k3H7BQ+v3v21I4m8asWs39hSs78QoAJqyFgxbl8VB1
   GsUSQ4gA/fbAyLBSaTun//fvvFIBHBBl1MxdX3i+VQCv4Tf5ORDEXIdQL
   KtLAgvOBmZJoFzF9vEd6m9E4i/j4jd1l/m3bRlaLVJDK3+OpcWBNPoEWH
   UyQU9/Wm5JSM1NLPldOQFVhsDG/gwE5EL+B227K8Y6kGL6xPNYoS1UlNg
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,275,1643698800"; 
   d="scan'208";a="161091280"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Apr 2022 03:34:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 20 Apr 2022 03:34:35 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 20 Apr 2022 03:34:33 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Takahiro.Kuwano@infineon.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v4 02/11] mtd: spi-nor: Introduce spi_nor_match_id()
Date:   Wed, 20 Apr 2022 13:34:18 +0300
Message-ID: <20220420103427.47867-3-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420103427.47867-1-tudor.ambarus@microchip.com>
References: <20220420103427.47867-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/core.c | 40 ++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 214d3a1ac6b0..b9cc8bbf1f62 100644
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

