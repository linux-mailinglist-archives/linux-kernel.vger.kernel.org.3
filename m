Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2342A4DBB7F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 01:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344396AbiCQAI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 20:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiCQAI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 20:08:26 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E561C913;
        Wed, 16 Mar 2022 17:07:11 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a8so7452426ejc.8;
        Wed, 16 Mar 2022 17:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ulUxnTUsYR6KfkBVjLDy5nWlu5Zsp3IoA/hxl7MBCIA=;
        b=ZWaIk+1B8z2e6yf5z8Pyt40DH1CJpIThUpnuaCoTZrNRVItWFJfYQNwjUDJT28WTya
         wqgiBJfZmFKsy2On+mCIO6l7RDao1lOOvq43Jhi2bO0nLvCWTeYoWtU/q2MXnQyNlAFl
         e0Q0Wel36O1tM84enVvNCDWa1hmj4gtOh7aPyJKpy23uOTo0UdYdq8catfuVJThQ9OHb
         ayGm5BSwGT5jZfXbeDG0YqK3XCC+vrBoXddHxZUUV3jAfucJgfCfuDDNv21dA7Zy7t4m
         Fhj9Bjqg1ZpR+nRhNZ5TTpLRYdfJol7WSZEv7pFKZfFuzjLo1IRg1QG3fc94S+kaRiJq
         tuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ulUxnTUsYR6KfkBVjLDy5nWlu5Zsp3IoA/hxl7MBCIA=;
        b=WA7yVODwXmTkJOzYGHz+y+iImPysca08/2/KOGydrQV1SdB0nrnC4Lu1ATCVLintfn
         5GkVwLnFZ7GoGdnHU2DDIR8qZQC4hS8DgYF6p3GCWJdSLi51NnzLLtW/xRZ9NJRovZtO
         YuKGjGUmsrfRgwibUcZ+8uerCpxHujyWnR4POZnq0NcCfItLoHDkLLzq/8GiXrgrIp0a
         C4OSso26FLP6GwWgWINd3PT2EUgABJT1wvJYIt3Fr0jY3gQhfP5uPJlfGXVstZBhSjPI
         5aar3LoUM28DW250u+zG1LqEiPXdtGWrMKYCvSIlxn0Zb7OdbaEWaZ2bGeBo4QS+xXvW
         vW6Q==
X-Gm-Message-State: AOAM533WNINHFtifT81y1QqycvsHSdW5iKFzseWh1s+O8KA8dV4sqDwh
        ZQosW7BJGekSKcZOQpivYQE=
X-Google-Smtp-Source: ABdhPJzqK7BkiabAt36R6gWwrFbucKdnBPmuNRhib2BMBaM1mmLWf154xtRu87y3011vXx9S+e1WqA==
X-Received: by 2002:a17:906:18b2:b0:6d0:ee54:1add with SMTP id c18-20020a17090618b200b006d0ee541addmr1971946ejf.499.1647475629726;
        Wed, 16 Mar 2022 17:07:09 -0700 (PDT)
Received: from localhost (92.40.202.150.threembb.co.uk. [92.40.202.150])
        by smtp.gmail.com with ESMTPSA id d23-20020aa7d5d7000000b00418f7b2f1dbsm309509eds.71.2022.03.16.17.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 17:07:09 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, linus.walleij@linaro.org
Cc:     linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] pinctrl: ingenic: Fix regmap on X series SoCs
Date:   Thu, 17 Mar 2022 00:07:40 +0000
Message-Id: <20220317000740.1045204-1-aidanmacdonald.0x0@gmail.com>
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

Fix this by adding regmap access tables to the chip info. The way that
max_register was computed was also off by one, since max_register is an
inclusive bound, not an exclusive bound; this has been fixed.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
v1 -> v2: use regmap_access_table
v2 -> v3: compute max_register instead of putting it in chip_info
v3 -> v4: explain the fix to the max_register calculation

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

