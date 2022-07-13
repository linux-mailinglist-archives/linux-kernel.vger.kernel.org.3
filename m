Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E612573D32
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 21:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbiGMTeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 15:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiGMTeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:34:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A471F220FD;
        Wed, 13 Jul 2022 12:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657740841; x=1689276841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H7RWMMYujXqvojJ9xxxElCDGxgPhF72C+WxWSjwMkAw=;
  b=0LBkAXkLBPBI54ALLsg8pi+5hwAMPWaUcYg5mtv5lBIypX0HGLRb54j7
   CETONYSLrJO4Y7zRUU/YT+ncoJniGMaWudD5WAB7NN1so7oY5i9ZT2PpZ
   Wetyry9ZGsdcPjCMwCCLIaAYUyhssT4E2SBcNVaCn2snocb4pBsDBvSpk
   dJbtwLg6yvuiJrEW+BmLGsQWR6/+Ef9Q+J3bYY1HqzdWpxAg3/bbbVbDK
   f1djSsY1ocvf5w/BDx83vmzsdzWTOZnAV50wxTQ2dGJi2hu1TdPNJ0+IJ
   yo3wNavF9/mWm3UWHFla4oXGK/+zSgrK3smQggOCLbPedXCKHgZuP6k6C
   A==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="167716423"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2022 12:33:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Jul 2022 12:33:57 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 13 Jul 2022 12:33:55 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <alexandre.belloni@bootlin.com>,
        <kavyasree.kotagiri@microchip.com>,
        <colin.foster@in-advantage.com>, <UNGLinuxDriver@microchip.com>,
        <maxime.chevallier@bootlin.com>, <michael@walle.cc>,
        <andy.shevchenko@gmail.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v5 2/2] pinctrl: ocelot: Fix pincfg
Date:   Wed, 13 Jul 2022 21:37:50 +0200
Message-ID: <20220713193750.4079621-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220713193750.4079621-1-horatiu.vultur@microchip.com>
References: <20220713193750.4079621-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blamed commit changed to use regmaps instead of __iomem. But it
didn't update the register offsets to be at word offset, so it uses byte
offset.
Another issue with the same commit is that it has a limit of 32 registers
which is incorrect. The sparx5 has 64 while lan966x has 77.

Fixes: 076d9e71bcf8 ("pinctrl: ocelot: convert pinctrl to regmap")
Acked-by: Colin Foster <colin.foster@in-advantage.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/pinctrl/pinctrl-ocelot.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index c6e0232770b7..dfc8ea9f3843 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -1334,7 +1334,9 @@ static int ocelot_hw_get_value(struct ocelot_pinctrl *info,
 		const struct ocelot_pincfg_data *opd = info->pincfg_data;
 		u32 regcfg;
 
-		ret = regmap_read(info->pincfg, pin, &regcfg);
+		ret = regmap_read(info->pincfg,
+				  pin * regmap_get_reg_stride(info->pincfg),
+				  &regcfg);
 		if (ret)
 			return ret;
 
@@ -1366,14 +1368,18 @@ static int ocelot_pincfg_clrsetbits(struct ocelot_pinctrl *info, u32 regaddr,
 	u32 val;
 	int ret;
 
-	ret = regmap_read(info->pincfg, regaddr, &val);
+	ret = regmap_read(info->pincfg,
+			  regaddr * regmap_get_reg_stride(info->pincfg),
+			  &val);
 	if (ret)
 		return ret;
 
 	val &= ~clrbits;
 	val |= setbits;
 
-	ret = regmap_write(info->pincfg, regaddr, val);
+	ret = regmap_write(info->pincfg,
+			   regaddr * regmap_get_reg_stride(info->pincfg),
+			   val);
 
 	return ret;
 }
@@ -1933,7 +1939,8 @@ static const struct of_device_id ocelot_pinctrl_of_match[] = {
 	{},
 };
 
-static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev)
+static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev,
+						   const struct ocelot_pinctrl *info)
 {
 	void __iomem *base;
 
@@ -1941,7 +1948,7 @@ static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev)
 		.reg_bits = 32,
 		.val_bits = 32,
 		.reg_stride = 4,
-		.max_register = 32,
+		.max_register = info->desc->npins * 4,
 		.name = "pincfg",
 	};
 
@@ -2009,7 +2016,7 @@ static int ocelot_pinctrl_probe(struct platform_device *pdev)
 
 	/* Pinconf registers */
 	if (info->desc->confops) {
-		pincfg = ocelot_pinctrl_create_pincfg(pdev);
+		pincfg = ocelot_pinctrl_create_pincfg(pdev, info);
 		if (IS_ERR(pincfg))
 			dev_dbg(dev, "Failed to create pincfg regmap\n");
 		else
-- 
2.33.0

