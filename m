Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0C14AF2FB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbiBINhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbiBINh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:37:27 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D52C05CBA2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 05:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644413839; x=1675949839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nsTTGEHEMLT+hG0N17ACM28ae/UOHeO88gwXFA2N3WI=;
  b=MouiQg3cynp8pgvspHvbiAr4b8biceWtmARNDrIx5Azrpuc9eXR1LSTY
   vuMMrTx6YSYBJNC4i+1EKAiK2mgBk8UtKdEbxa07smUPjLkOFYogqadwZ
   gz4mCJRUQxStzO5dInMGdIm/LH22hIc7Y0i1cQX57xNm8xCeGkQvFJip6
   9FxMQyzuci+nSEjzXGaPLws5VD41wElkV7evUax2ZzMJ8RkiFcAj0DWu6
   zzJVEPLy66xgKDQEYwTjJNpCc/YrxSAlWy4LvKDXpYNBO0cilFUBuCITY
   EmgVZ2irPgia+aBjY6h6rHU96plSqOG57zTXSYfJctopyVkzG8C4MnxDs
   g==;
IronPort-SDR: AK/UwFO4PzbP0AtYFKVyw9EN/IHhm09P19SPCG6BR6p6cw1gUSiQxcPShOEyLFAdiNYWY2oFTK
 /CGNpSE0YENYC9jKPcqcdA1SduLy9+tcf4KFekUA7Jr2RzCGSN2QR6FvUAHeWeowUyUqBRGb7Z
 WBrkK7/sl4/KrY0PBiJdjC97uSnQktfwGrZAoJo7IPk7OuL5re/cZyj2eY3PDN6r7yOy/HNAiS
 KDEUdmWbWPZLdcK6hDQ6yFsVA9zxt9xeFF4bJGBdOBRzLtrvPNkKFga3Pog0Wo+oCz0/WziXCo
 M1LN596SxwhAXtmmw4dVaxs5
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="145394818"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 06:37:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 06:37:18 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 9 Feb 2022 06:37:14 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <zhengxunli@mxic.com.tw>,
        <jaimeliao@mxic.com.tw>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v6 3/7] mtd: spi-nor: core: Use auto-detection only once
Date:   Wed, 9 Feb 2022 15:36:52 +0200
Message-ID: <20220209133656.374903-4-tudor.ambarus@microchip.com>
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

In case spi_nor_match_name() returned NULL, the auto detection was
issued twice. There's no reason to try to detect the same chip twice,
do the auto detection only once.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 335170fc2438..9b740f77174e 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3127,13 +3127,15 @@ static const struct flash_info *spi_nor_match_name(struct spi_nor *nor,
 static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
 						       const char *name)
 {
-	const struct flash_info *info = NULL;
+	const struct flash_info *info = NULL, *detected_info = NULL;
 
 	if (name)
 		info = spi_nor_match_name(nor, name);
 	/* Try to auto-detect if chip name wasn't specified or not found */
-	if (!info)
-		info = spi_nor_read_id(nor);
+	if (!info) {
+		detected_info = spi_nor_read_id(nor);
+		info = detected_info;
+	}
 	if (IS_ERR_OR_NULL(info))
 		return ERR_PTR(-ENOENT);
 
@@ -3141,7 +3143,7 @@ static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
 	 * If caller has specified name of flash model that can normally be
 	 * detected using JEDEC, let's verify it.
 	 */
-	if (name && info->id_len) {
+	if (name && !detected_info && info->id_len) {
 		const struct flash_info *jinfo;
 
 		jinfo = spi_nor_read_id(nor);
-- 
2.25.1

