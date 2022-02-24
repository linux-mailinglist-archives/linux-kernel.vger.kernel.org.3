Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA084C2ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 15:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbiBXO7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 09:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbiBXO7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 09:59:12 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1E319E0B0;
        Thu, 24 Feb 2022 06:58:41 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l1-20020a7bcf01000000b0037f881182a8so3654768wmg.2;
        Thu, 24 Feb 2022 06:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r+Ap09YkV/WFyV+S/aswBxVGWwiQEj8kB/0esliku3c=;
        b=O2A+WqV+Ik/cjprvWHQqK1Y5StFgdqAKoF5ODyMioDcztFamCvdQ+isDJnfCVPDAYL
         sCEPIAOs8YTwM3OTKLoIRV7dOryXNKQcYQJ9aVo+DPyAQLhpnK5JBopro9D8/j45GDQw
         7uh+SGOEfoTHlClpT094Bo9cP3yt+4aSQ7w3dOsC8LzfcDbCBi9ll9F5ClOA0gQS1fdN
         zqIGsKsELxaovJd+eTmDKboEge/QECYCkEyQyYPOzpxqafHeA/qYOf8ie76V7oJlrDeC
         Ean6aOPaWqgNoG0hIlTlc+b7e7OhyjeKkUGAQ3c17Gna33ybE7MBqqUl6gwbxJx/m13R
         pMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r+Ap09YkV/WFyV+S/aswBxVGWwiQEj8kB/0esliku3c=;
        b=E+4vyhtqRJOaywBxK0GMtFECEJuzT2058NGJVdiIeSJQC9f4jQGWOyaFF2YcpIAd57
         8Ky0ZSqPtGtx/DabVIDt2rExc0zBArcjZFeB2MyLE1c28dHaDz1INmOWNFKKQk7ztKQR
         FE79fOepkTvAvK7IOH68gv8D5EQ4KJNCgGS51h2jIy2YppIyrJ5/YsV1jyEW23Pg3Iu/
         kzPHqZiXDZoOcZQZqU7FYZ4xMq5UWAINNnInVPQw3pCR7ubURGWI30HkuDf9DvrWp3xq
         PoKiX7t26Vdg5ozkssk1yHk+2vZQkyNHvV6v/UBEdnf8KxBJfD5bchbAuuIP1SkgQwkz
         TV8w==
X-Gm-Message-State: AOAM533Wpnar7iMv5AJ2XW2A/ovsVtsvOiLL9lisYRuLfHmRZICFWoGk
        +tC2Ya+s1Nc9IuHdzM82M+E=
X-Google-Smtp-Source: ABdhPJzQNqxzFZj0lqn+nkgIo1mwE4Gk6B7ru14iFerK833ARMJ5Djcia7s0wlypzvgDrb1/2MaTGw==
X-Received: by 2002:a05:600c:4f14:b0:353:32b7:b47 with SMTP id l20-20020a05600c4f1400b0035332b70b47mr12499441wmq.126.1645714720148;
        Thu, 24 Feb 2022 06:58:40 -0800 (PST)
Received: from localhost (92.40.203.111.threembb.co.uk. [92.40.203.111])
        by smtp.gmail.com with ESMTPSA id p12sm2800962wmg.36.2022.02.24.06.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 06:58:39 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, linus.walleij@linaro.org
Cc:     linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] pinctrl: ingenic: Fix regmap on X series SoCs
Date:   Thu, 24 Feb 2022 14:58:22 +0000
Message-Id: <20220224145821.518835-1-aidanmacdonald.0x0@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The X series Ingenic SoCs have a shadow GPIO group which is at a higher
offset than the other groups, and is used for all GPIO configuration.
The regmap did not take this offset into account and set max_register
too low, so the regmap API blocked writes to the shadow group, which
made the pinctrl driver unable to configure any pins.

Fix this by adding regmap access tables to the chip info.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
v1: https://lore.kernel.org/linux-mips/20220209230452.19535-1-aidanmacdonald.0x0@gmail.com/

 drivers/pinctrl/pinctrl-ingenic.c | 53 ++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 2712f51eb238..074c94edd90b 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -119,6 +119,9 @@ struct ingenic_chip_info {
 	unsigned int num_functions;
 
 	const u32 *pull_ups, *pull_downs;
+
+	unsigned int max_register;
+	const struct regmap_access_table* access_table;
 };
 
 struct ingenic_pinctrl {
@@ -228,6 +231,7 @@ static const struct ingenic_chip_info jz4730_chip_info = {
 	.num_functions = ARRAY_SIZE(jz4730_functions),
 	.pull_ups = jz4730_pull_ups,
 	.pull_downs = jz4730_pull_downs,
+	.max_register = 4 * 0x30 - 4,
 };
 
 static const u32 jz4740_pull_ups[4] = {
@@ -337,6 +341,7 @@ static const struct ingenic_chip_info jz4740_chip_info = {
 	.num_functions = ARRAY_SIZE(jz4740_functions),
 	.pull_ups = jz4740_pull_ups,
 	.pull_downs = jz4740_pull_downs,
+	.max_register = 4 * 0x100 - 4,
 };
 
 static int jz4725b_mmc0_1bit_pins[] = { 0x48, 0x49, 0x5c, };
@@ -439,6 +444,7 @@ static const struct ingenic_chip_info jz4725b_chip_info = {
 	.num_functions = ARRAY_SIZE(jz4725b_functions),
 	.pull_ups = jz4740_pull_ups,
 	.pull_downs = jz4740_pull_downs,
+	.max_register = 4 * 0x100 - 4,
 };
 
 static const u32 jz4750_pull_ups[6] = {
@@ -576,6 +582,7 @@ static const struct ingenic_chip_info jz4750_chip_info = {
 	.num_functions = ARRAY_SIZE(jz4750_functions),
 	.pull_ups = jz4750_pull_ups,
 	.pull_downs = jz4750_pull_downs,
+	.max_register = 6 * 0x100 - 4,
 };
 
 static const u32 jz4755_pull_ups[6] = {
@@ -741,6 +748,7 @@ static const struct ingenic_chip_info jz4755_chip_info = {
 	.num_functions = ARRAY_SIZE(jz4755_functions),
 	.pull_ups = jz4755_pull_ups,
 	.pull_downs = jz4755_pull_downs,
+	.max_register = 6 * 0x100 - 4,
 };
 
 static const u32 jz4760_pull_ups[6] = {
@@ -1089,6 +1097,7 @@ static const struct ingenic_chip_info jz4760_chip_info = {
 	.num_functions = ARRAY_SIZE(jz4760_functions),
 	.pull_ups = jz4760_pull_ups,
 	.pull_downs = jz4760_pull_downs,
+	.max_register = 6 * 0x100 - 4,
 };
 
 static const u32 jz4770_pull_ups[6] = {
@@ -1429,6 +1438,7 @@ static const struct ingenic_chip_info jz4770_chip_info = {
 	.num_functions = ARRAY_SIZE(jz4770_functions),
 	.pull_ups = jz4770_pull_ups,
 	.pull_downs = jz4770_pull_downs,
+	.max_register = 6 * 0x100 - 4,
 };
 
 static const u32 jz4775_pull_ups[7] = {
@@ -1702,6 +1712,7 @@ static const struct ingenic_chip_info jz4775_chip_info = {
 	.num_functions = ARRAY_SIZE(jz4775_functions),
 	.pull_ups = jz4775_pull_ups,
 	.pull_downs = jz4775_pull_downs,
+	.max_register = 7 * 0x100 - 4,
 };
 
 static const u32 jz4780_pull_ups[6] = {
@@ -1966,6 +1977,7 @@ static const struct ingenic_chip_info jz4780_chip_info = {
 	.num_functions = ARRAY_SIZE(jz4780_functions),
 	.pull_ups = jz4780_pull_ups,
 	.pull_downs = jz4780_pull_downs,
+	.max_register = 6 * 0x100 - 4,
 };
 
 static const u32 x1000_pull_ups[4] = {
@@ -2179,6 +2191,17 @@ static const struct function_desc x1000_functions[] = {
 	{ "mac", x1000_mac_groups, ARRAY_SIZE(x1000_mac_groups), },
 };
 
+static const struct regmap_range x1000_access_ranges[] = {
+	regmap_reg_range(0x000, 0x400 - 4),
+	regmap_reg_range(0x700, 0x800 - 4),
+};
+
+/* shared with X1500 */
+static const struct regmap_access_table x1000_access_table = {
+	.yes_ranges = x1000_access_ranges,
+	.n_yes_ranges = ARRAY_SIZE(x1000_access_ranges),
+};
+
 static const struct ingenic_chip_info x1000_chip_info = {
 	.num_chips = 4,
 	.reg_offset = 0x100,
@@ -2189,6 +2212,7 @@ static const struct ingenic_chip_info x1000_chip_info = {
 	.num_functions = ARRAY_SIZE(x1000_functions),
 	.pull_ups = x1000_pull_ups,
 	.pull_downs = x1000_pull_downs,
+	.access_table = &x1000_access_table,
 };
 
 static int x1500_uart0_data_pins[] = { 0x4a, 0x4b, };
@@ -2300,6 +2324,7 @@ static const struct ingenic_chip_info x1500_chip_info = {
 	.num_functions = ARRAY_SIZE(x1500_functions),
 	.pull_ups = x1000_pull_ups,
 	.pull_downs = x1000_pull_downs,
+	.access_table = &x1000_access_table,
 };
 
 static const u32 x1830_pull_ups[4] = {
@@ -2506,6 +2531,16 @@ static const struct function_desc x1830_functions[] = {
 	{ "mac", x1830_mac_groups, ARRAY_SIZE(x1830_mac_groups), },
 };
 
+static const struct regmap_range x1830_access_ranges[] = {
+	regmap_reg_range(0x0000, 0x4000 - 4),
+	regmap_reg_range(0x7000, 0x8000 - 4),
+};
+
+static const struct regmap_access_table x1830_access_table = {
+	.yes_ranges = x1830_access_ranges,
+	.n_yes_ranges = ARRAY_SIZE(x1830_access_ranges),
+};
+
 static const struct ingenic_chip_info x1830_chip_info = {
 	.num_chips = 4,
 	.reg_offset = 0x1000,
@@ -2516,6 +2551,7 @@ static const struct ingenic_chip_info x1830_chip_info = {
 	.num_functions = ARRAY_SIZE(x1830_functions),
 	.pull_ups = x1830_pull_ups,
 	.pull_downs = x1830_pull_downs,
+	.access_table = &x1830_access_table,
 };
 
 static const u32 x2000_pull_ups[5] = {
@@ -2969,6 +3005,17 @@ static const struct function_desc x2000_functions[] = {
 	{ "otg", x2000_otg_groups, ARRAY_SIZE(x2000_otg_groups), },
 };
 
+static const struct regmap_range x2000_access_ranges[] = {
+	regmap_reg_range(0x000, 0x500 - 4),
+	regmap_reg_range(0x700, 0x800 - 4),
+};
+
+/* shared with X2100 */
+static const struct regmap_access_table x2000_access_table = {
+	.yes_ranges = x2000_access_ranges,
+	.n_yes_ranges = ARRAY_SIZE(x2000_access_ranges),
+};
+
 static const struct ingenic_chip_info x2000_chip_info = {
 	.num_chips = 5,
 	.reg_offset = 0x100,
@@ -2979,6 +3026,7 @@ static const struct ingenic_chip_info x2000_chip_info = {
 	.num_functions = ARRAY_SIZE(x2000_functions),
 	.pull_ups = x2000_pull_ups,
 	.pull_downs = x2000_pull_downs,
+	.access_table = &x2000_access_table,
 };
 
 static const u32 x2100_pull_ups[5] = {
@@ -3189,6 +3237,7 @@ static const struct ingenic_chip_info x2100_chip_info = {
 	.num_functions = ARRAY_SIZE(x2100_functions),
 	.pull_ups = x2100_pull_ups,
 	.pull_downs = x2100_pull_downs,
+	.access_table = &x2000_access_table,
 };
 
 static u32 ingenic_gpio_read_reg(struct ingenic_gpio_chip *jzgc, u8 reg)
@@ -4168,7 +4217,9 @@ static int __init ingenic_pinctrl_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	regmap_config = ingenic_pinctrl_regmap_config;
-	regmap_config.max_register = chip_info->num_chips * chip_info->reg_offset;
+	regmap_config.rd_table = chip_info->access_table;
+	regmap_config.wr_table = chip_info->access_table;
+	regmap_config.max_register = chip_info->max_register;
 
 	jzpc->map = devm_regmap_init_mmio(dev, base, &regmap_config);
 	if (IS_ERR(jzpc->map)) {
-- 
2.34.1

