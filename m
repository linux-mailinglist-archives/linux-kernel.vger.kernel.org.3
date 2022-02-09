Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1504AF2FE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbiBINhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbiBINh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:37:26 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2E5C03CA49
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 05:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644413829; x=1675949829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=csMWGGqwyJOn5ODRm2zWMJY6PKgfI+luK/C34/+qqRk=;
  b=k/08jTxyGN5PfDZeOQPWWJr6UiIWTiY9BkIBgmNcttLIdCZaSjgMlRPZ
   qYuf6NFqa23bXhDWVayR+5zZFt8HS1QTBe8xNPLDbtSpHDyppZf6VmWli
   naFKcJxjWTMoMSUnJRpqQeDuuOD6jaomcvMj05V6g7AgRXESFWImVxwvN
   nlNPY+ZLq20s0J6+k862ajzDrCWBmTM1kbrpW/g4zg9igJTMUz59zrs2w
   VPwkB/u4AXByo2orhmbaDY5gvpwnmk+8DE7LZSvdABYn7IZbrGnXYa8jn
   ACv+RLByhJGB5gUh4uXDS/069pLccUGhLulcLENwjAoapubOi0GG7gRW8
   w==;
IronPort-SDR: XVixCb1Es2Oko7EPztHA/LfuIsuG3pNt/2DbzMr72NScI4+CV+lZKdkX93NY8yTBrXiCNQJj/Q
 sNWTodayr8lfiPm85j8InjL22OrEtMqdAR7miuWSUkt1kZd/0TNFFWpfFQSB8WTOF11zTo/p47
 2GoLPf5ZwHMxxNBo2XzkIfKH69iT1iHjp13EYwRtvdtHO1EwxCSMqgpLo4HyHOywyK/FbIbFcH
 WESGS0nxNgYx7cwqaN2bN0SOdf/JWzmrbBkm/1Bhl8cNVmFjopY4Lin3rjn4PRvkpqciv9PBmc
 Bif1iyllgnMEA8Fy4u9Qo66C
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="152460072"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 06:37:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 06:37:07 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 9 Feb 2022 06:37:02 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <zhengxunli@mxic.com.tw>,
        <jaimeliao@mxic.com.tw>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v6 1/7] mtd: spi-nor: Rename method, s/spi_nor_match_id/spi_nor_match_name
Date:   Wed, 9 Feb 2022 15:36:50 +0200
Message-ID: <20220209133656.374903-2-tudor.ambarus@microchip.com>
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

The method is matching a flash_info entry by searching by name. Rename
the method for better clarity.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 04ea180118e3..345f9da96fab 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3109,8 +3109,8 @@ void spi_nor_restore(struct spi_nor *nor)
 }
 EXPORT_SYMBOL_GPL(spi_nor_restore);
 
-static const struct flash_info *spi_nor_match_id(struct spi_nor *nor,
-						 const char *name)
+static const struct flash_info *spi_nor_match_name(struct spi_nor *nor,
+						   const char *name)
 {
 	unsigned int i, j;
 
@@ -3132,7 +3132,7 @@ static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
 	const struct flash_info *info = NULL;
 
 	if (name)
-		info = spi_nor_match_id(nor, name);
+		info = spi_nor_match_name(nor, name);
 	/* Try to auto-detect if chip name wasn't specified or not found */
 	if (!info)
 		info = spi_nor_read_id(nor);
-- 
2.25.1

