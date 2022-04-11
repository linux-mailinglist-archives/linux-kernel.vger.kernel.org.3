Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D171D4FB700
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbiDKJNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344205AbiDKJM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:12:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C689B19014
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649668247; x=1681204247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AkkbZWjZRlH9312vjiduNujt5vMVxf/XLruKiXMySs0=;
  b=e0mLrdJ2gjKNFgIaAp1W6Rj6NISj/Sv70zJPjcSosC8db/AQp1cMCXut
   e2Ei2geyqm7VoO7lqKaBooTzwiHRLHeBfzKAJtfdpy48AX3kKl7IpWSkQ
   ffLfa/J2uPbxLXfOtx9RqFGwZhY9zAxM7P1yjRvHEGhcKe0I93pw1BqEo
   H+EjSSI7xcfzxkX3Mq+e9B+L4m5DCw8bh/1qN0f6Ev9QY67rrcbAWCG+t
   BZDMw3oKcYpvksasKPo2ROUEKrLQoCdG+3IE4Hu2Y0IHqCGQGO0DhDw+n
   4X5NNNKqsaitLzFsS5iRmfTrRTz782/1WmSTq6rTxj7lFaX34gnVFdUiV
   A==;
X-IronPort-AV: E=Sophos;i="5.90,251,1643698800"; 
   d="scan'208";a="159624238"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Apr 2022 02:10:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Apr 2022 02:10:46 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 11 Apr 2022 02:10:43 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v3 3/9] mtd: spi-nor: core: Use auto-detection only once
Date:   Mon, 11 Apr 2022 12:10:27 +0300
Message-ID: <20220411091033.98754-4-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220411091033.98754-1-tudor.ambarus@microchip.com>
References: <20220411091033.98754-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
v3:                                                                             
- caller of spi_nor_get_flash_info now handles NULL and translates it to        
ENOENT.

 drivers/mtd/spi-nor/core.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index b9cc8bbf1f62..b55d922d46dd 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2896,13 +2896,14 @@ static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
 {
 	const struct flash_info *info = NULL;
 
-	if (name)
+	if (name) {
 		info = spi_nor_match_name(nor, name);
+		if (IS_ERR(info))
+			return info;
+	}
 	/* Try to auto-detect if chip name wasn't specified or not found */
 	if (!info)
-		info = spi_nor_read_id(nor);
-	if (IS_ERR_OR_NULL(info))
-		return ERR_PTR(-ENOENT);
+		return spi_nor_read_id(nor);
 
 	/*
 	 * If caller has specified name of flash model that can normally be
@@ -2994,7 +2995,9 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 		return -ENOMEM;
 
 	info = spi_nor_get_flash_info(nor, name);
-	if (IS_ERR(info))
+	if (!info)
+		return -ENOENT;
+	else if (IS_ERR(info))
 		return PTR_ERR(info);
 
 	nor->info = info;
-- 
2.25.1

