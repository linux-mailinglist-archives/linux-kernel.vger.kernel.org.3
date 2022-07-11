Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962E8570A8D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbiGKTRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGKTRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:17:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF83661125;
        Mon, 11 Jul 2022 12:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657567064; x=1689103064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IC+pTgndhB6NKnax7zFopR1qRB0pAZnrTs6ljHMSmnM=;
  b=a4ksQc/GKJ8pvKs7SPmM10PLUn5blreaFFv9cWjAjAtNsEZ5BjYe6f8y
   WyT+O1xgwtJawt3rF0p+hmLZtE/cO9tAd41UYxPZZYYQh3x3mycOFQNVQ
   SqOFHFqqVfoWwbvAY0r/yR0bU7IbI+icrqGF7wiouYAnTxuHPADQYLaPV
   mlxwGprfapmG6BRBPTYnNRHcSXzT+LlaBTOZWat+KQWUGGujtIijk69tV
   rIa/Vl8tjOJcT57om0QvJurDFBr9lk5kKcEQ77XulLdoRDWsf597rDfk0
   Ac0zrSKcTfltbP/NRthKjRZfAu77iAlBcsUHuE9tmZqy43+7Bz/nXaXvg
   g==;
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="181678626"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2022 12:17:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Jul 2022 12:17:44 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 11 Jul 2022 12:17:41 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <kavyasree.kotagiri@microchip.com>,
        <alexandre.belloni@bootlin.com>, <colin.foster@in-advantage.com>,
        <UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>,
        <michael@walle.cc>, <andy.shevchenko@gmail.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v3 2/2] pinctrl: ocelot: Fix pincfg
Date:   Mon, 11 Jul 2022 21:21:13 +0200
Message-ID: <20220711192113.3522664-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220711192113.3522664-1-horatiu.vultur@microchip.com>
References: <20220711192113.3522664-1-horatiu.vultur@microchip.com>
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
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/pinctrl/pinctrl-ocelot.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 4edb36cfa161..b859e5caed09 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -1334,7 +1334,9 @@ static int ocelot_hw_get_value(struct ocelot_pinctrl *info,
 	if (info->pincfg) {
 		u32 regcfg;
 
-		ret = regmap_read(info->pincfg, pin, &regcfg);
+		ret = regmap_read(info->pincfg,
+				  pin * regmap_get_reg_stride(info->pincfg),
+				  &regcfg);
 		if (ret)
 			return ret;
 
@@ -1368,14 +1370,18 @@ static int ocelot_pincfg_clrsetbits(struct ocelot_pinctrl *info, u32 regaddr,
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
@@ -1935,7 +1941,8 @@ static const struct of_device_id ocelot_pinctrl_of_match[] = {
 	{},
 };
 
-static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev)
+static struct regmap *ocelot_pinctrl_create_pincfg(struct ocelot_pinctrl *info,
+						   struct platform_device *pdev)
 {
 	void __iomem *base;
 
@@ -1943,7 +1950,7 @@ static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev)
 		.reg_bits = 32,
 		.val_bits = 32,
 		.reg_stride = 4,
-		.max_register = 32,
+		.max_register = info->desc->npins * 4,
 		.name = "pincfg",
 	};
 
@@ -2010,7 +2017,7 @@ static int ocelot_pinctrl_probe(struct platform_device *pdev)
 
 	/* Pinconf registers */
 	if (info->desc->confops) {
-		pincfg = ocelot_pinctrl_create_pincfg(pdev);
+		pincfg = ocelot_pinctrl_create_pincfg(info, pdev);
 		if (IS_ERR(pincfg))
 			dev_dbg(dev, "Failed to create pincfg regmap\n");
 		else
-- 
2.33.0

