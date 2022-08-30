Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D995A5D7E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiH3H5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiH3H4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:56:52 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F45D076B;
        Tue, 30 Aug 2022 00:56:49 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n17so13059921wrm.4;
        Tue, 30 Aug 2022 00:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lu/ZR5+AQVLMMZtQ2GPvpBPZqeDdYDFNiK3/CkVjR1E=;
        b=KZlsE3I22pW4CV+9iiwRqZycneUmgKM3rHW1+MebcHlNwXfVeKWq11Tr5bh7wzjN/O
         rGv3WlI3f7M66x6On/MK9VzEf1E39PQz/gEBuxovqXdVLYgNf+2F1w8LCVsel4EvRX+g
         sWquy2JY5W5ZOPqyqOaOCzvMHMVOyJ4cjh8KrQGRoyxpJa2SSS03CkoN1TdO/anxhYSj
         rM0wWx/4eh18aTPC+6Y1IhE+vC4eWQnYR3DtIoQha/JO5mKv2vLYM9tOWoXsqIxqGXaH
         /joB+VJDFbsLfle4t3CGshAvwyH1yS1BtwbZVZ6vQv6im320k8VB7HP+Cw93qM1g6lhi
         ZlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lu/ZR5+AQVLMMZtQ2GPvpBPZqeDdYDFNiK3/CkVjR1E=;
        b=J4ItjkuAQinwOSROJ44SQHuUW3ejk4aK+uThvEsU/kzBAU3zFHvFS93+RdF64q6t6P
         WYgdI+l7EHwHPg0VuE9x7m/Npsz9BrClCacvUKu4PcMyIK148DT2aUM/rBcZqF0WbLBG
         gigejig9h47LGkc2AuJyLcq8Cgvcz1/QvWUxXZorULDUVCgBrCepQ0+LXm1QmeINbAit
         Jrb3SC0q1rkWN3aSTQoIEqvTy9jXy7qEaiRS0ZcFEAPYINVIEtlGHck317TTt2oPoPyc
         +C7xVfvXttTGNiLyT/drMvWJPLejVCPO66HAWnaU/RSkjvsl6La0zClKVcNayfRnT/8K
         zSvw==
X-Gm-Message-State: ACgBeo1JnWSS+v7Si+guoaEQS66+Fqo1s0a31iZZL85B2R7Y7Igu8BQU
        4KoKH7uJ7ZWuszJa9tlRv68=
X-Google-Smtp-Source: AA6agR6VYs00XxT5SxhrnFAVWtvM0vhUg4POQGtQEapDJfPGmN+DkWf0/dVTNSs8tW/HBYNJjXapBA==
X-Received: by 2002:a05:6000:178a:b0:225:6dff:90b3 with SMTP id e10-20020a056000178a00b002256dff90b3mr8849109wrg.378.1661846207802;
        Tue, 30 Aug 2022 00:56:47 -0700 (PDT)
Received: from localhost (87-126-55-15.ip.btc-net.bg. [87.126.55.15])
        by smtp.gmail.com with ESMTPSA id u6-20020a5d4346000000b0020fff0ea0a3sm8912903wrr.116.2022.08.30.00.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 00:56:47 -0700 (PDT)
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
Subject: [PATCH 3/3] clk: qcom: Merge alt alpha plls for qcm2260, sm6115
Date:   Tue, 30 Aug 2022 10:56:20 +0300
Message-Id: <20220830075620.974009-4-iskren.chernev@gmail.com>
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

The qcom2260 and sm6115 GCC drivers use a common modified DEFAULT and
BRAMMO alpha pll offsets. Move these common offsets to the shared place
to avoid duplication. The new layouts have a suffix EVO similar to LUCID
and RIVIAN.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 drivers/clk/qcom/clk-alpha-pll.c | 21 +++++++++++
 drivers/clk/qcom/clk-alpha-pll.h |  2 ++
 drivers/clk/qcom/gcc-qcm2290.c   | 56 +++++++++--------------------
 drivers/clk/qcom/gcc-sm6115.c    | 60 ++++++++++----------------------
 4 files changed, 57 insertions(+), 82 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index b42684703fbb..5c368447697d 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -166,6 +166,27 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
 		[PLL_OFF_TEST_CTL] = 0x28,
 		[PLL_OFF_TEST_CTL_U] = 0x2c,
 	},
+	[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO] =  {
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
+	[CLK_ALPHA_PLL_TYPE_BRAMMO_EVO] =  {
+		[PLL_OFF_L_VAL] = 0x04,
+		[PLL_OFF_ALPHA_VAL] = 0x08,
+		[PLL_OFF_ALPHA_VAL_U] = 0x0c,
+		[PLL_OFF_TEST_CTL] = 0x10,
+		[PLL_OFF_TEST_CTL_U] = 0x14,
+		[PLL_OFF_USER_CTL] = 0x18,
+		[PLL_OFF_CONFIG_CTL] = 0x1C,
+		[PLL_OFF_STATUS] = 0x20,
+	},
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
 
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index 447efb82fe59..0cbdae7b5b77 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -19,6 +19,8 @@ enum {
 	CLK_ALPHA_PLL_TYPE_ZONDA,
 	CLK_ALPHA_PLL_TYPE_LUCID_EVO,
 	CLK_ALPHA_PLL_TYPE_RIVIAN_EVO,
+	CLK_ALPHA_PLL_TYPE_DEFAULT_EVO,
+	CLK_ALPHA_PLL_TYPE_BRAMMO_EVO,
 	CLK_ALPHA_PLL_TYPE_MAX,
 };
 
diff --git a/drivers/clk/qcom/gcc-qcm2290.c b/drivers/clk/qcom/gcc-qcm2290.c
index b6fa7b8e8006..7792b8f23704 100644
--- a/drivers/clk/qcom/gcc-qcm2290.c
+++ b/drivers/clk/qcom/gcc-qcm2290.c
@@ -54,33 +54,9 @@ static const struct pll_vco spark_vco[] = {
 	{ 750000000, 1500000000, 1 },
 };
 
-static const u8 clk_alpha_pll_regs_offset[][PLL_OFF_MAX_REGS] = {
-	[CLK_ALPHA_PLL_TYPE_DEFAULT] =  {
-		[PLL_OFF_L_VAL] = 0x04,
-		[PLL_OFF_ALPHA_VAL] = 0x08,
-		[PLL_OFF_ALPHA_VAL_U] = 0x0c,
-		[PLL_OFF_TEST_CTL] = 0x10,
-		[PLL_OFF_TEST_CTL_U] = 0x14,
-		[PLL_OFF_USER_CTL] = 0x18,
-		[PLL_OFF_USER_CTL_U] = 0x1C,
-		[PLL_OFF_CONFIG_CTL] = 0x20,
-		[PLL_OFF_STATUS] = 0x24,
-	},
-	[CLK_ALPHA_PLL_TYPE_BRAMMO] =  {
-		[PLL_OFF_L_VAL] = 0x04,
-		[PLL_OFF_ALPHA_VAL] = 0x08,
-		[PLL_OFF_ALPHA_VAL_U] = 0x0c,
-		[PLL_OFF_TEST_CTL] = 0x10,
-		[PLL_OFF_TEST_CTL_U] = 0x14,
-		[PLL_OFF_USER_CTL] = 0x18,
-		[PLL_OFF_CONFIG_CTL] = 0x1C,
-		[PLL_OFF_STATUS] = 0x20,
-	},
-};
-
 static struct clk_alpha_pll gpll0 = {
 	.offset = 0x0,
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.clkr = {
 		.enable_reg = 0x79000,
 		.enable_mask = BIT(0),
@@ -106,7 +82,7 @@ static struct clk_alpha_pll_postdiv gpll0_out_aux2 = {
 	.post_div_table = post_div_table_gpll0_out_aux2,
 	.num_post_div = ARRAY_SIZE(post_div_table_gpll0_out_aux2),
 	.width = 4,
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpll0_out_aux2",
 		.parent_hws = (const struct clk_hw *[]){ &gpll0.clkr.hw },
@@ -117,7 +93,7 @@ static struct clk_alpha_pll_postdiv gpll0_out_aux2 = {
 
 static struct clk_alpha_pll gpll1 = {
 	.offset = 0x1000,
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.clkr = {
 		.enable_reg = 0x79000,
 		.enable_mask = BIT(1),
@@ -147,7 +123,7 @@ static struct clk_alpha_pll gpll10 = {
 	.offset = 0xa000,
 	.vco_table = spark_vco,
 	.num_vco = ARRAY_SIZE(spark_vco),
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.clkr = {
 		.enable_reg = 0x79000,
 		.enable_mask = BIT(10),
@@ -179,7 +155,7 @@ static struct clk_alpha_pll gpll11 = {
 	.offset = 0xb000,
 	.vco_table = default_vco,
 	.num_vco = ARRAY_SIZE(default_vco),
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.flags = SUPPORTS_DYNAMIC_UPDATE,
 	.clkr = {
 		.enable_reg = 0x79000,
@@ -197,7 +173,7 @@ static struct clk_alpha_pll gpll11 = {
 
 static struct clk_alpha_pll gpll3 = {
 	.offset = 0x3000,
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.clkr = {
 		.enable_reg = 0x79000,
 		.enable_mask = BIT(3),
@@ -223,7 +199,7 @@ static struct clk_alpha_pll_postdiv gpll3_out_main = {
 	.post_div_table = post_div_table_gpll3_out_main,
 	.num_post_div = ARRAY_SIZE(post_div_table_gpll3_out_main),
 	.width = 4,
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpll3_out_main",
 		.parent_hws = (const struct clk_hw *[]){ &gpll3.clkr.hw },
@@ -234,7 +210,7 @@ static struct clk_alpha_pll_postdiv gpll3_out_main = {
 
 static struct clk_alpha_pll gpll4 = {
 	.offset = 0x4000,
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.clkr = {
 		.enable_reg = 0x79000,
 		.enable_mask = BIT(4),
@@ -251,7 +227,7 @@ static struct clk_alpha_pll gpll4 = {
 
 static struct clk_alpha_pll gpll5 = {
 	.offset = 0x5000,
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.clkr = {
 		.enable_reg = 0x79000,
 		.enable_mask = BIT(5),
@@ -268,7 +244,7 @@ static struct clk_alpha_pll gpll5 = {
 
 static struct clk_alpha_pll gpll6 = {
 	.offset = 0x6000,
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.clkr = {
 		.enable_reg = 0x79000,
 		.enable_mask = BIT(6),
@@ -294,7 +270,7 @@ static struct clk_alpha_pll_postdiv gpll6_out_main = {
 	.post_div_table = post_div_table_gpll6_out_main,
 	.num_post_div = ARRAY_SIZE(post_div_table_gpll6_out_main),
 	.width = 4,
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpll6_out_main",
 		.parent_hws = (const struct clk_hw *[]){ &gpll6.clkr.hw },
@@ -305,7 +281,7 @@ static struct clk_alpha_pll_postdiv gpll6_out_main = {
 
 static struct clk_alpha_pll gpll7 = {
 	.offset = 0x7000,
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.clkr = {
 		.enable_reg = 0x79000,
 		.enable_mask = BIT(7),
@@ -340,7 +316,7 @@ static struct clk_alpha_pll gpll8 = {
 	.offset = 0x8000,
 	.vco_table = default_vco,
 	.num_vco = ARRAY_SIZE(default_vco),
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.flags = SUPPORTS_DYNAMIC_UPDATE,
 	.clkr = {
 		.enable_reg = 0x79000,
@@ -367,7 +343,7 @@ static struct clk_alpha_pll_postdiv gpll8_out_main = {
 	.post_div_table = post_div_table_gpll8_out_main,
 	.num_post_div = ARRAY_SIZE(post_div_table_gpll8_out_main),
 	.width = 4,
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpll8_out_main",
 		.parent_hws = (const struct clk_hw *[]){ &gpll8.clkr.hw },
@@ -393,7 +369,7 @@ static struct clk_alpha_pll gpll9 = {
 	.offset = 0x9000,
 	.vco_table = brammo_vco,
 	.num_vco = ARRAY_SIZE(brammo_vco),
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_BRAMMO],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_BRAMMO_EVO],
 	.clkr = {
 		.enable_reg = 0x79000,
 		.enable_mask = BIT(9),
@@ -419,7 +395,7 @@ static struct clk_alpha_pll_postdiv gpll9_out_main = {
 	.post_div_table = post_div_table_gpll9_out_main,
 	.num_post_div = ARRAY_SIZE(post_div_table_gpll9_out_main),
 	.width = 2,
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_BRAMMO],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_BRAMMO_EVO],
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpll9_out_main",
 		.parent_hws = (const struct clk_hw *[]){ &gpll9.clkr.hw },
diff --git a/drivers/clk/qcom/gcc-sm6115.c b/drivers/clk/qcom/gcc-sm6115.c
index dc2a99c3bc06..565f9912039f 100644
--- a/drivers/clk/qcom/gcc-sm6115.c
+++ b/drivers/clk/qcom/gcc-sm6115.c
@@ -53,35 +53,11 @@ static struct pll_vco gpll10_vco[] = {
 	{ 750000000, 1500000000, 1 },
 };
 
-static const u8 clk_alpha_pll_regs_offset[][PLL_OFF_MAX_REGS] = {
-	[CLK_ALPHA_PLL_TYPE_DEFAULT] =  {
-		[PLL_OFF_L_VAL] = 0x04,
-		[PLL_OFF_ALPHA_VAL] = 0x08,
-		[PLL_OFF_ALPHA_VAL_U] = 0x0c,
-		[PLL_OFF_TEST_CTL] = 0x10,
-		[PLL_OFF_TEST_CTL_U] = 0x14,
-		[PLL_OFF_USER_CTL] = 0x18,
-		[PLL_OFF_USER_CTL_U] = 0x1c,
-		[PLL_OFF_CONFIG_CTL] = 0x20,
-		[PLL_OFF_STATUS] = 0x24,
-	},
-	[CLK_ALPHA_PLL_TYPE_BRAMMO] =  {
-		[PLL_OFF_L_VAL] = 0x04,
-		[PLL_OFF_ALPHA_VAL] = 0x08,
-		[PLL_OFF_ALPHA_VAL_U] = 0x0c,
-		[PLL_OFF_TEST_CTL] = 0x10,
-		[PLL_OFF_TEST_CTL_U] = 0x14,
-		[PLL_OFF_USER_CTL] = 0x18,
-		[PLL_OFF_CONFIG_CTL] = 0x1C,
-		[PLL_OFF_STATUS] = 0x20,
-	},
-};
-
 static struct clk_alpha_pll gpll0 = {
 	.offset = 0x0,
 	.vco_table = default_vco,
 	.num_vco = ARRAY_SIZE(default_vco),
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.clkr = {
 		.enable_reg = 0x79000,
 		.enable_mask = BIT(0),
@@ -107,7 +83,7 @@ static struct clk_alpha_pll_postdiv gpll0_out_aux2 = {
 	.post_div_table = post_div_table_gpll0_out_aux2,
 	.num_post_div = ARRAY_SIZE(post_div_table_gpll0_out_aux2),
 	.width = 4,
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpll0_out_aux2",
 		.parent_hws = (const struct clk_hw *[]){ &gpll0.clkr.hw },
@@ -127,7 +103,7 @@ static struct clk_alpha_pll_postdiv gpll0_out_main = {
 	.post_div_table = post_div_table_gpll0_out_main,
 	.num_post_div = ARRAY_SIZE(post_div_table_gpll0_out_main),
 	.width = 4,
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpll0_out_main",
 		.parent_hws = (const struct clk_hw *[]){ &gpll0.clkr.hw },
@@ -149,7 +125,7 @@ static struct clk_alpha_pll gpll10 = {
 	.offset = 0xa000,
 	.vco_table = gpll10_vco,
 	.num_vco = ARRAY_SIZE(gpll10_vco),
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.clkr = {
 		.enable_reg = 0x79000,
 		.enable_mask = BIT(10),
@@ -175,7 +151,7 @@ static struct clk_alpha_pll_postdiv gpll10_out_main = {
 	.post_div_table = post_div_table_gpll10_out_main,
 	.num_post_div = ARRAY_SIZE(post_div_table_gpll10_out_main),
 	.width = 4,
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpll10_out_main",
 		.parent_hws = (const struct clk_hw *[]){ &gpll10.clkr.hw },
@@ -201,7 +177,7 @@ static struct clk_alpha_pll gpll11 = {
 	.vco_table = default_vco,
 	.num_vco = ARRAY_SIZE(default_vco),
 	.flags = SUPPORTS_DYNAMIC_UPDATE,
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.clkr = {
 		.enable_reg = 0x79000,
 		.enable_mask = BIT(11),
@@ -227,7 +203,7 @@ static struct clk_alpha_pll_postdiv gpll11_out_main = {
 	.post_div_table = post_div_table_gpll11_out_main,
 	.num_post_div = ARRAY_SIZE(post_div_table_gpll11_out_main),
 	.width = 4,
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpll11_out_main",
 		.parent_hws = (const struct clk_hw *[]){ &gpll11.clkr.hw },
@@ -241,7 +217,7 @@ static struct clk_alpha_pll gpll3 = {
 	.offset = 0x3000,
 	.vco_table = default_vco,
 	.num_vco = ARRAY_SIZE(default_vco),
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.clkr = {
 		.enable_reg = 0x79000,
 		.enable_mask = BIT(3),
@@ -260,7 +236,7 @@ static struct clk_alpha_pll gpll4 = {
 	.offset = 0x4000,
 	.vco_table = default_vco,
 	.num_vco = ARRAY_SIZE(default_vco),
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.clkr = {
 		.enable_reg = 0x79000,
 		.enable_mask = BIT(4),
@@ -286,7 +262,7 @@ static struct clk_alpha_pll_postdiv gpll4_out_main = {
 	.post_div_table = post_div_table_gpll4_out_main,
 	.num_post_div = ARRAY_SIZE(post_div_table_gpll4_out_main),
 	.width = 4,
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpll4_out_main",
 		.parent_hws = (const struct clk_hw *[]){ &gpll4.clkr.hw },
@@ -299,7 +275,7 @@ static struct clk_alpha_pll gpll6 = {
 	.offset = 0x6000,
 	.vco_table = default_vco,
 	.num_vco = ARRAY_SIZE(default_vco),
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.clkr = {
 		.enable_reg = 0x79000,
 		.enable_mask = BIT(6),
@@ -325,7 +301,7 @@ static struct clk_alpha_pll_postdiv gpll6_out_main = {
 	.post_div_table = post_div_table_gpll6_out_main,
 	.num_post_div = ARRAY_SIZE(post_div_table_gpll6_out_main),
 	.width = 4,
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpll6_out_main",
 		.parent_hws = (const struct clk_hw *[]){ &gpll6.clkr.hw },
@@ -338,7 +314,7 @@ static struct clk_alpha_pll gpll7 = {
 	.offset = 0x7000,
 	.vco_table = default_vco,
 	.num_vco = ARRAY_SIZE(default_vco),
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.clkr = {
 		.enable_reg = 0x79000,
 		.enable_mask = BIT(7),
@@ -364,7 +340,7 @@ static struct clk_alpha_pll_postdiv gpll7_out_main = {
 	.post_div_table = post_div_table_gpll7_out_main,
 	.num_post_div = ARRAY_SIZE(post_div_table_gpll7_out_main),
 	.width = 4,
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpll7_out_main",
 		.parent_hws = (const struct clk_hw *[]){ &gpll7.clkr.hw },
@@ -392,7 +368,7 @@ static struct clk_alpha_pll gpll8 = {
 	.offset = 0x8000,
 	.vco_table = default_vco,
 	.num_vco = ARRAY_SIZE(default_vco),
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.flags = SUPPORTS_DYNAMIC_UPDATE,
 	.clkr = {
 		.enable_reg = 0x79000,
@@ -419,7 +395,7 @@ static struct clk_alpha_pll_postdiv gpll8_out_main = {
 	.post_div_table = post_div_table_gpll8_out_main,
 	.num_post_div = ARRAY_SIZE(post_div_table_gpll8_out_main),
 	.width = 4,
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpll8_out_main",
 		.parent_hws = (const struct clk_hw *[]){ &gpll8.clkr.hw },
@@ -443,7 +419,7 @@ static struct clk_alpha_pll gpll9 = {
 	.offset = 0x9000,
 	.vco_table = gpll9_vco,
 	.num_vco = ARRAY_SIZE(gpll9_vco),
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_BRAMMO],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_BRAMMO_EVO],
 	.clkr = {
 		.enable_reg = 0x79000,
 		.enable_mask = BIT(9),
@@ -469,7 +445,7 @@ static struct clk_alpha_pll_postdiv gpll9_out_main = {
 	.post_div_table = post_div_table_gpll9_out_main,
 	.num_post_div = ARRAY_SIZE(post_div_table_gpll9_out_main),
 	.width = 2,
-	.regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_BRAMMO],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_BRAMMO_EVO],
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpll9_out_main",
 		.parent_hws = (const struct clk_hw *[]){ &gpll9.clkr.hw },
-- 
2.37.2

