Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518284DBAED
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 00:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241010AbiCPXVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 19:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiCPXVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 19:21:33 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2D6F2F;
        Wed, 16 Mar 2022 16:20:17 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id p15so7306386ejc.7;
        Wed, 16 Mar 2022 16:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5PWRN4CUYhoR381p11PiQXmEqMMATa6d5BV3wQxA/IY=;
        b=OV95KzFvOqrFH3A9xjvMYS22qyNIYxh00c64A4G1Jx1Rkgw6z9f9g5wguO/tfGgCDp
         XO9nzb+4TAI0mk7vGxMcViOcbYs7iFMc7s6oe7gPzB0cRb4awsNJjcTQPuZ176QPgZv+
         SzIOpRASQd8u6dh6quNUakVkutiY7EP3OORqZhZ2WZgJ/L2GiY4KqU17LD+zay/4rhKc
         mZtrYhnkbBtOZ//V8GUyoLMUnELEEYmX05ZBEMdI1pcKyudT1gnOWWiJLg6wUygo/MvY
         DMCmeKIPDZuF9EKYA6Lp7cL+xjZMP8Cz45hKysJEbO+2QcdAWHUBUZTu2xbWkHLPtjdt
         16Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5PWRN4CUYhoR381p11PiQXmEqMMATa6d5BV3wQxA/IY=;
        b=Cd02T8ERWZFQvgrc+44zpOuWxWVDxTDPCyuyemhzc52/8xxKb6neD2OD5j36pdJ6OE
         LCZTt6NsZyHyHyW52bMAnCw9jTdun1IeaeGxDscm5lS03DlzHAn8kCHv7aYq1FKVHs+i
         46lVOuapgQDBCHx8VJCakiPrmsvU+bcdWZ9M6+J0l0919E54Je8oOCkd9uZGs7yUPY3h
         gd2bG6g+GJMbQDgXz1H4iuJpxRH9xAsM03RD4zkwUJ56I7wKidM/02FPLPUxtWh/JosA
         QJ/GpH1GKke88jA7alRz+Pfyq6W8jlSZS5kZCQ7FxmjSNW8D0cNzSvFyzRCxA8YEi1Pn
         TLzg==
X-Gm-Message-State: AOAM530JnxI6Y8TcDl6XDTsnaO8aN2pV4NQrWbwc0oQduSD0T0l+Sbaz
        ulT6oZzw9w0C2OQRnf91CNaUWCfsY9k=
X-Google-Smtp-Source: ABdhPJw8XDyy8LT9U7vhSnVkGLqA6S4rE8mLjRRPx2cq1flL9cA7B7/xTQmcTdWiPe9GE+QaVsrRZA==
X-Received: by 2002:a17:906:d41:b0:6ce:78b0:8113 with SMTP id r1-20020a1709060d4100b006ce78b08113mr1912884ejh.357.1647472815777;
        Wed, 16 Mar 2022 16:20:15 -0700 (PDT)
Received: from localhost (92.40.202.150.threembb.co.uk. [92.40.202.150])
        by smtp.gmail.com with ESMTPSA id d2-20020a50cf42000000b004135b6eef60sm1685908edk.94.2022.03.16.16.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 16:20:15 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, linus.walleij@linaro.org
Cc:     linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] pinctrl: ingenic: Fix regmap on X series SoCs
Date:   Wed, 16 Mar 2022 23:20:30 +0000
Message-Id: <20220316232029.965361-1-aidanmacdonald.0x0@gmail.com>
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
v1 -> v2: use regmap_access_table
v2 -> v3: compute max_register instead of putting it in chip_info

 drivers/pinctrl/pinctrl-ingenic.c | 46 ++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 2712f51eb238..fa6becca1788 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -119,6 +119,8 @@ struct ingenic_chip_info {
 	unsigned int num_functions;
 
 	const u32 *pull_ups, *pull_downs;
+
+	const struct regmap_access_table *access_table;
 };
 
 struct ingenic_pinctrl {
@@ -2179,6 +2181,17 @@ static const struct function_desc x1000_functions[] = {
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
@@ -2189,6 +2202,7 @@ static const struct ingenic_chip_info x1000_chip_info = {
 	.num_functions = ARRAY_SIZE(x1000_functions),
 	.pull_ups = x1000_pull_ups,
 	.pull_downs = x1000_pull_downs,
+	.access_table = &x1000_access_table,
 };
 
 static int x1500_uart0_data_pins[] = { 0x4a, 0x4b, };
@@ -2300,6 +2314,7 @@ static const struct ingenic_chip_info x1500_chip_info = {
 	.num_functions = ARRAY_SIZE(x1500_functions),
 	.pull_ups = x1000_pull_ups,
 	.pull_downs = x1000_pull_downs,
+	.access_table = &x1000_access_table,
 };
 
 static const u32 x1830_pull_ups[4] = {
@@ -2506,6 +2521,16 @@ static const struct function_desc x1830_functions[] = {
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
@@ -2516,6 +2541,7 @@ static const struct ingenic_chip_info x1830_chip_info = {
 	.num_functions = ARRAY_SIZE(x1830_functions),
 	.pull_ups = x1830_pull_ups,
 	.pull_downs = x1830_pull_downs,
+	.access_table = &x1830_access_table,
 };
 
 static const u32 x2000_pull_ups[5] = {
@@ -2969,6 +2995,17 @@ static const struct function_desc x2000_functions[] = {
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
@@ -2979,6 +3016,7 @@ static const struct ingenic_chip_info x2000_chip_info = {
 	.num_functions = ARRAY_SIZE(x2000_functions),
 	.pull_ups = x2000_pull_ups,
 	.pull_downs = x2000_pull_downs,
+	.access_table = &x2000_access_table,
 };
 
 static const u32 x2100_pull_ups[5] = {
@@ -3189,6 +3227,7 @@ static const struct ingenic_chip_info x2100_chip_info = {
 	.num_functions = ARRAY_SIZE(x2100_functions),
 	.pull_ups = x2100_pull_ups,
 	.pull_downs = x2100_pull_downs,
+	.access_table = &x2000_access_table,
 };
 
 static u32 ingenic_gpio_read_reg(struct ingenic_gpio_chip *jzgc, u8 reg)
@@ -4168,7 +4207,12 @@ static int __init ingenic_pinctrl_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	regmap_config = ingenic_pinctrl_regmap_config;
-	regmap_config.max_register = chip_info->num_chips * chip_info->reg_offset;
+	if (chip_info->access_table) {
+		regmap_config.rd_table = chip_info->access_table;
+		regmap_config.wr_table = chip_info->access_table;
+	} else {
+		regmap_config.max_register = chip_info->num_chips * chip_info->reg_offset - 4;
+	}
 
 	jzpc->map = devm_regmap_init_mmio(dev, base, &regmap_config);
 	if (IS_ERR(jzpc->map)) {
-- 
2.34.1

