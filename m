Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA445A5D7A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiH3H4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiH3H4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:56:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8475D11D5;
        Tue, 30 Aug 2022 00:56:40 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m16so13020393wru.9;
        Tue, 30 Aug 2022 00:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=IUZioTUBv9o3dbpyPj/5grK5U+N5/kWbXEapquaWyxY=;
        b=gyEa+eYO/WKk7ezu1Jlr2/dvfZyVOFsx9viRX2fJSqryGxfpZcsxVdds0dfwQlR5x7
         RC2w3o4bB60ZwrTuZil65nK1s7N2vhFDMg//7Mx4FYyd85v7dXIzNq8GUXA8HMDiZLFA
         05GcTuTgktqpTsdaGbGqQuH2WPM+FBkQIP3PcSs5HHJ6AAyi1lKT7eXr35k+cz19BOYL
         p8ebtJLtESwnHmnxZMVFJYShH+HKGYueoE/h2v1C5n+NB+Kf7knttnPs1xgAPoT/NOVr
         5oSUNttL5AIcODKN8BCx2UMEPPf2SYZ66ulw2PycGaDWCMazbGJEhx3zsilLF2rpSzwi
         Sd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=IUZioTUBv9o3dbpyPj/5grK5U+N5/kWbXEapquaWyxY=;
        b=bGrWQl8U84LLN9rbc5Hiw4g+UEOmrX8SCrScX0VkU4gLHrMkKtb0eZrBlUi70yJMPq
         vEjGimJw+sHwsaxjZAADi9A0UcdGR6QA9k7+YWBdKj0SVHAtN68VMFO0jxwEK6ve+Xon
         p1GThIQH8OiTJRm32GY7nkOQ4bZ0cKYCWGX7zrHyTZZAfHJh4bFdMmkErPgLHH6Vj/Jw
         NsqXU8r7+oPPlqIQzuBmenUBTKKhyM9mN2R/S7oJaeMCcofPbVbRVXb/F690aYwM+qN1
         LdyMwoiNwOlAdNwPVvyaz/yzwzfN2/rfG0+e3iMoFNFn0nTVoXUMjp0nqwftauNg1Jgz
         mNtw==
X-Gm-Message-State: ACgBeo2jFlxAYBFPUQSqgkD/T0mt98LIyEVUIeUG5vhxxH0o1rbHnBRA
        A2X8Esn0o4ZlwnoSAugyciM=
X-Google-Smtp-Source: AA6agR6FDLWIWklPkD9fYsBzb7cb+sVuamN5e3/2YB3JFdaFgBrfUAIklJxuBh7Kdl6bTT5O3OvrXQ==
X-Received: by 2002:adf:ea91:0:b0:226:dce6:c344 with SMTP id s17-20020adfea91000000b00226dce6c344mr3594023wrm.3.1661846199221;
        Tue, 30 Aug 2022 00:56:39 -0700 (PDT)
Received: from localhost (87-126-55-15.ip.btc-net.bg. [87.126.55.15])
        by smtp.gmail.com with ESMTPSA id v12-20020adfebcc000000b00224f5bfa890sm8930714wrn.97.2022.08.30.00.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 00:56:38 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Adam Skladowski <a_skl39@protonmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH 1/3] clk: qcom: gcc-sm6115: Override default Alpha PLL regs
Date:   Tue, 30 Aug 2022 10:56:18 +0300
Message-Id: <20220830075620.974009-2-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830075620.974009-1-iskren.chernev@gmail.com>
References: <20220830075620.974009-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Skladowski <a_skl39@protonmail.com>

The DEFAULT and BRAMMO PLL offsets are non-standard in downstream, but
currently only BRAMMO ones are overridden. Override DEFAULT ones too.

A very similar thing is happening in gcc-qcm2290 driver.

Fixes: cbe63bfdc54f ("clk: qcom: Add Global Clock controller (GCC) driver for SM6115")
Signed-off-by: Adam Skladowski <a_skl39@protonmail.com>
Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 drivers/clk/qcom/gcc-sm6115.c | 46 +++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm6115.c b/drivers/clk/qcom/gcc-sm6115.c
index 68fe9f6f0d2f..e24a977c2580 100644
--- a/drivers/clk/qcom/gcc-sm6115.c
+++ b/drivers/clk/qcom/gcc-sm6115.c
@@ -53,11 +53,25 @@ static struct pll_vco gpll10_vco[] = {
 	{ 750000000, 1500000000, 1 },
 };
 
+static const u8 clk_alpha_pll_regs_offset[][PLL_OFF_MAX_REGS] = {
+	[CLK_ALPHA_PLL_TYPE_DEFAULT] =  {
+		[PLL_OFF_L_VAL] = 0x04,
+		[PLL_OFF_ALPHA_VAL] = 0x08,
+		[PLL_OFF_ALPHA_VAL_U] = 0x0c,
+		[PLL_OFF_TEST_CTL] = 0x10,
+		[PLL_OFF_TEST_CTL_U] = 0x14,
+		[PLL_OFF_USER_CTL] = 0x18,
+		[PLL_OFF_USER_CTL_U] = 0x1c,
+		[PLL_OFF_CONFIG_CTL] = 0x20,
+		[PLL_OFF_STATUS] = 0x24,
+	},
+};
+
 static struct clk_alpha_pll gpll0 = {
 	.offset = 0x0,
 	.vco_table = default_vco,
 	.num_vco = ARRAY_SIZE(default_vco),
-	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
 	.clkr = {
 		.enable_reg = 0x79000,
 		.enable_mask = BIT(0),
@@ -83,7 +97,7 @@ static struct clk_alpha_pll_postdiv gpll0_out_aux2 = {
 	.post_div_table = post_div_table_gpll0_out_aux2,
 	.num_post_div = ARRAY_SIZE(post_div_table_gpll0_out_aux2),
 	.width = 4,
-	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpll0_out_aux2",
 		.parent_hws = (const struct clk_hw *[]){ &gpll0.clkr.hw },
@@ -115,7 +129,7 @@ static struct clk_alpha_pll_postdiv gpll0_out_main = {
 	.post_div_table = post_div_table_gpll0_out_main,
 	.num_post_div = ARRAY_SIZE(post_div_table_gpll0_out_main),
 	.width = 4,
-	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpll0_out_main",
 		.parent_hws = (const struct clk_hw *[]){ &gpll0.clkr.hw },
@@ -137,7 +151,7 @@ static struct clk_alpha_pll gpll10 = {
 	.offset = 0xa000,
 	.vco_table = gpll10_vco,
 	.num_vco = ARRAY_SIZE(gpll10_vco),
-	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
 	.clkr = {
 		.enable_reg = 0x79000,
 		.enable_mask = BIT(10),
@@ -163,7 +177,7 @@ static struct clk_alpha_pll_postdiv gpll10_out_main = {
 	.post_div_table = post_div_table_gpll10_out_main,
 	.num_post_div = ARRAY_SIZE(post_div_table_gpll10_out_main),
 	.width = 4,
-	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpll10_out_main",
 		.parent_hws = (const struct clk_hw *[]){ &gpll10.clkr.hw },
@@ -189,7 +203,7 @@ static struct clk_alpha_pll gpll11 = {
 	.vco_table = default_vco,
 	.num_vco = ARRAY_SIZE(default_vco),
 	.flags = SUPPORTS_DYNAMIC_UPDATE,
-	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
 	.clkr = {
 		.enable_reg = 0x79000,
 		.enable_mask = BIT(11),
@@ -215,7 +229,7 @@ static struct clk_alpha_pll_postdiv gpll11_out_main = {
 	.post_div_table = post_div_table_gpll11_out_main,
 	.num_post_div = ARRAY_SIZE(post_div_table_gpll11_out_main),
 	.width = 4,
-	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpll11_out_main",
 		.parent_hws = (const struct clk_hw *[]){ &gpll11.clkr.hw },
@@ -229,7 +243,7 @@ static struct clk_alpha_pll gpll3 = {
 	.offset = 0x3000,
 	.vco_table = default_vco,
 	.num_vco = ARRAY_SIZE(default_vco),
-	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
 	.clkr = {
 		.enable_reg = 0x79000,
 		.enable_mask = BIT(3),
@@ -248,7 +262,7 @@ static struct clk_alpha_pll gpll4 = {
 	.offset = 0x4000,
 	.vco_table = default_vco,
 	.num_vco = ARRAY_SIZE(default_vco),
-	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
 	.clkr = {
 		.enable_reg = 0x79000,
 		.enable_mask = BIT(4),
@@ -274,7 +288,7 @@ static struct clk_alpha_pll_postdiv gpll4_out_main = {
 	.post_div_table = post_div_table_gpll4_out_main,
 	.num_post_div = ARRAY_SIZE(post_div_table_gpll4_out_main),
 	.width = 4,
-	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpll4_out_main",
 		.parent_hws = (const struct clk_hw *[]){ &gpll4.clkr.hw },
@@ -287,7 +301,7 @@ static struct clk_alpha_pll gpll6 = {
 	.offset = 0x6000,
 	.vco_table = default_vco,
 	.num_vco = ARRAY_SIZE(default_vco),
-	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
 	.clkr = {
 		.enable_reg = 0x79000,
 		.enable_mask = BIT(6),
@@ -313,7 +327,7 @@ static struct clk_alpha_pll_postdiv gpll6_out_main = {
 	.post_div_table = post_div_table_gpll6_out_main,
 	.num_post_div = ARRAY_SIZE(post_div_table_gpll6_out_main),
 	.width = 4,
-	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpll6_out_main",
 		.parent_hws = (const struct clk_hw *[]){ &gpll6.clkr.hw },
@@ -326,7 +340,7 @@ static struct clk_alpha_pll gpll7 = {
 	.offset = 0x7000,
 	.vco_table = default_vco,
 	.num_vco = ARRAY_SIZE(default_vco),
-	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
 	.clkr = {
 		.enable_reg = 0x79000,
 		.enable_mask = BIT(7),
@@ -352,7 +366,7 @@ static struct clk_alpha_pll_postdiv gpll7_out_main = {
 	.post_div_table = post_div_table_gpll7_out_main,
 	.num_post_div = ARRAY_SIZE(post_div_table_gpll7_out_main),
 	.width = 4,
-	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpll7_out_main",
 		.parent_hws = (const struct clk_hw *[]){ &gpll7.clkr.hw },
@@ -380,7 +394,7 @@ static struct clk_alpha_pll gpll8 = {
 	.offset = 0x8000,
 	.vco_table = default_vco,
 	.num_vco = ARRAY_SIZE(default_vco),
-	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
 	.flags = SUPPORTS_DYNAMIC_UPDATE,
 	.clkr = {
 		.enable_reg = 0x79000,
@@ -407,7 +421,7 @@ static struct clk_alpha_pll_postdiv gpll8_out_main = {
 	.post_div_table = post_div_table_gpll8_out_main,
 	.num_post_div = ARRAY_SIZE(post_div_table_gpll8_out_main),
 	.width = 4,
-	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpll8_out_main",
 		.parent_hws = (const struct clk_hw *[]){ &gpll8.clkr.hw },
-- 
2.37.2

