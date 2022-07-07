Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5324B56AB07
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbiGGSuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbiGGSt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:49:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E57D201A6;
        Thu,  7 Jul 2022 11:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657219796; x=1688755796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lLRTGNYtwXnxq+fPi8sGlOmQc4+DsD09icLC+QCdOPI=;
  b=dbD1ar8xBIuMsYp+8uG0Kl4rIw+lOBs4tU4q6T79Fd3/8kaE/1ZWociQ
   pG02Wvzs9jgxA8UBl6zA8XTdX+CmLJTasUi2fcQwJeZGPyvCi4XC2yTSz
   G5EMeBl/v8EbYSn86dnUN74c0yDOGaLxlIBo3MZ5hLzw/MefqHBy0QWYr
   3DIcuDBfl+98nyyDHNJrIYalqI9Xz7Gv2q7JssX2yOmi3vxt4D5mkC6TX
   vkpe+Fu3mLa2m6ZXq8D3BqRsz5XtvcTAmk88fSWJaAMQD/3SY3B6zUO8x
   OpsbKzic4m9knWoYyZqGYjb8y7QJoA56qnKxcZUbxpoz4q/FVsy9iJgZJ
   w==;
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="171212514"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jul 2022 11:49:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Jul 2022 11:49:55 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 7 Jul 2022 11:49:53 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <kavyasree.kotagiri@microchip.com>,
        <alexandre.belloni@bootlin.com>, <colin.foster@in-advantage.com>,
        <UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>,
        "Horatiu Vultur" <horatiu.vultur@microchip.com>
Subject: [PATCH 2/2] pinctrl: ocelot: Fix pincfg
Date:   Thu, 7 Jul 2022 20:53:42 +0200
Message-ID: <20220707185342.2697569-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220707185342.2697569-1-horatiu.vultur@microchip.com>
References: <20220707185342.2697569-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Fixes: 076d9e71bcf8 ("pinctrl: ocelot: convert pinctrl to regmap")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/pinctrl/pinctrl-ocelot.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 6212abe2b66f..e84f2f82901f 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -303,6 +303,13 @@ static const char *const ocelot_function_names[] = {
 	[FUNC_RCVRD_CLK]	= "rcvrd_clk",
 };
 
+const struct regmap_config regmap_pincfg = {
+		.reg_bits = 32,
+		.val_bits = 32,
+		.reg_stride = 4,
+		.name = "pincfg",
+};
+
 struct ocelot_pmx_func {
 	const char **groups;
 	unsigned int ngroups;
@@ -1334,7 +1341,8 @@ static int ocelot_hw_get_value(struct ocelot_pinctrl *info,
 	if (info->pincfg) {
 		u32 regcfg;
 
-		ret = regmap_read(info->pincfg, pin, &regcfg);
+		ret = regmap_read(info->pincfg, pin * regmap_pincfg.reg_stride,
+				  &regcfg);
 		if (ret)
 			return ret;
 
@@ -1368,14 +1376,16 @@ static int ocelot_pincfg_clrsetbits(struct ocelot_pinctrl *info, u32 regaddr,
 	u32 val;
 	int ret;
 
-	ret = regmap_read(info->pincfg, regaddr, &val);
+	ret = regmap_read(info->pincfg, regaddr * regmap_pincfg.reg_stride,
+			  &val);
 	if (ret)
 		return ret;
 
 	val &= ~clrbits;
 	val |= setbits;
 
-	ret = regmap_write(info->pincfg, regaddr, val);
+	ret = regmap_write(info->pincfg, regaddr * regmap_pincfg.reg_stride,
+			   val);
 
 	return ret;
 }
@@ -1940,21 +1950,13 @@ static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev)
 {
 	void __iomem *base;
 
-	const struct regmap_config regmap_config = {
-		.reg_bits = 32,
-		.val_bits = 32,
-		.reg_stride = 4,
-		.max_register = 32,
-		.name = "pincfg",
-	};
-
-	base = devm_platform_ioremap_resource(pdev, 1);
+		base = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(base)) {
 		dev_dbg(&pdev->dev, "Failed to ioremap config registers (no extended pinconf)\n");
 		return NULL;
 	}
 
-	return devm_regmap_init_mmio(&pdev->dev, base, &regmap_config);
+	return devm_regmap_init_mmio(&pdev->dev, base, &regmap_pincfg);
 }
 
 static int ocelot_pinctrl_probe(struct platform_device *pdev)
-- 
2.33.0

