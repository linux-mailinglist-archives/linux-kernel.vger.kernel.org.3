Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6301A553751
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353685AbiFUQH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353653AbiFUQHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:07:25 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F639593;
        Tue, 21 Jun 2022 09:07:24 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id o9so10793715edt.12;
        Tue, 21 Jun 2022 09:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CXPjLPecJruydocgfpfwjtoFmsZbdRkFyw772HfQkOE=;
        b=D+4g1zumSM8FFfBGWHVhla8AUSTUpeGLjVpnIyUP5fCPIVoq3OxQjzmLK4ELdP08/F
         0ZCawGIEjtr8smBURwirqdUgaQaPpphVLl9gq3R+ZWuLg5d/TthlWjd9ovDmgHWOlkL0
         CvXMaoQDQWEu8/8tPzOqfbW5+J4OyfbNi171bmgqeeOsen8Q3GpS7Yh1Xywx2d8QzqWk
         i9MJkMlj/GzC/s9WpPQl36NNX837/nBQFvd/9OrPMvJXTa9G7gi0kPKNWJunilOqmXUr
         IDW2QLCPnDCTLqsZwKGzpGxFL13Rw9nl12N8y8XxGO86u1BsDpav/Gr8KvEPnUaR8U3M
         4eBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CXPjLPecJruydocgfpfwjtoFmsZbdRkFyw772HfQkOE=;
        b=rtF9jRWGw9DsWUrrTy62YhV/25/7T+4I3DfGYjPOwp1KivOTc1VVwbIS4/NjR6QflI
         ObflgFXvQoPTqxaVkPafMks3sgymB9f0oCRIXZWDYsJ1D/rwupdJHKjUty7wm3gBVFbj
         BZf/zOW8PwiOc81XchjgKXE3g98SSRq1/y5UsbegxSNeucFecASZuoy38nIhjticQSr9
         JJf80cat2Gt4ywOFsYN4hA6EDwdcQyoelTxiIceh+Vi9rb4W2IoSSItEhew+Odm7UoYH
         K7O9xPevB2J9MnAiAJQODLUVLoPCRG2NqWbsgOHpWgAqudSoLQuFwm2ppY2Qdd9Q+DGn
         Jc3w==
X-Gm-Message-State: AJIora/+hUfqpPD6Xn3w5QfWpOX+T1eKE5TQXGnMxh2Pi4b5xeUzqOV7
        SMRlvvO4VQC69uOKSjOBO/xJEhfbO7ayXrUDk5c=
X-Google-Smtp-Source: AGRyM1urWBzh7lugwKJx2neEL0NFi/42kDj2d/B3S0673nKdO55a1YwmvYGV+r78VVQlQaUuryqqWA==
X-Received: by 2002:a05:6402:c44:b0:431:52cc:f933 with SMTP id cs4-20020a0564020c4400b0043152ccf933mr36007134edb.41.1655827643264;
        Tue, 21 Jun 2022 09:07:23 -0700 (PDT)
Received: from localhost.localdomain ([185.107.57.61])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090653c600b00722e0b1fa8esm1772943ejo.164.2022.06.21.09.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 09:07:22 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] clk: qcom: msm8996-cpu: Convert secondary muxes to clk_regmap_mux
Date:   Tue, 21 Jun 2022 20:06:19 +0400
Message-Id: <20220621160621.24415-5-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621160621.24415-1-y.oudjana@protonmail.com>
References: <20220621160621.24415-1-y.oudjana@protonmail.com>
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

There is nothing special about the secondary muxes, unlike the
primary muxes which need some extra logic to handle ACD and
switching between primary PLL and secondary mux sources. Turn
them into clk_regmap_mux and rename cpu_clk_msm8996_mux into
cpu_clk_msm8996_pmux to make it specific to primary muxes.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/clk/qcom/clk-cpu-8996.c | 62 ++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
index b6761a74d5ac..b3ad9245874d 100644
--- a/drivers/clk/qcom/clk-cpu-8996.c
+++ b/drivers/clk/qcom/clk-cpu-8996.c
@@ -59,6 +59,7 @@
 
 #include "clk-alpha-pll.h"
 #include "clk-regmap.h"
+#include "clk-regmap-mux.h"
 
 enum _pmux_input {
 	SMUX_INDEX = 0,
@@ -209,7 +210,7 @@ static struct clk_alpha_pll perfcl_alt_pll = {
 	},
 };
 
-struct clk_cpu_8996_mux {
+struct clk_cpu_8996_pmux {
 	u32	reg;
 	u8	shift;
 	u8	width;
@@ -222,18 +223,18 @@ struct clk_cpu_8996_mux {
 static int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 			       void *data);
 
-#define to_clk_cpu_8996_mux_nb(_nb) \
-	container_of(_nb, struct clk_cpu_8996_mux, nb)
+#define to_clk_cpu_8996_pmux_nb(_nb) \
+	container_of(_nb, struct clk_cpu_8996_pmux, nb)
 
-static inline struct clk_cpu_8996_mux *to_clk_cpu_8996_mux_hw(struct clk_hw *hw)
+static inline struct clk_cpu_8996_pmux *to_clk_cpu_8996_pmux_hw(struct clk_hw *hw)
 {
-	return container_of(to_clk_regmap(hw), struct clk_cpu_8996_mux, clkr);
+	return container_of(to_clk_regmap(hw), struct clk_cpu_8996_pmux, clkr);
 }
 
-static u8 clk_cpu_8996_mux_get_parent(struct clk_hw *hw)
+static u8 clk_cpu_8996_pmux_get_parent(struct clk_hw *hw)
 {
 	struct clk_regmap *clkr = to_clk_regmap(hw);
-	struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_hw(hw);
+	struct clk_cpu_8996_pmux *cpuclk = to_clk_cpu_8996_pmux_hw(hw);
 	u32 mask = GENMASK(cpuclk->width - 1, 0);
 	u32 val;
 
@@ -243,10 +244,10 @@ static u8 clk_cpu_8996_mux_get_parent(struct clk_hw *hw)
 	return val & mask;
 }
 
-static int clk_cpu_8996_mux_set_parent(struct clk_hw *hw, u8 index)
+static int clk_cpu_8996_pmux_set_parent(struct clk_hw *hw, u8 index)
 {
 	struct clk_regmap *clkr = to_clk_regmap(hw);
-	struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_hw(hw);
+	struct clk_cpu_8996_pmux *cpuclk = to_clk_cpu_8996_pmux_hw(hw);
 	u32 mask = GENMASK(cpuclk->width + cpuclk->shift - 1, cpuclk->shift);
 	u32 val;
 
@@ -256,10 +257,10 @@ static int clk_cpu_8996_mux_set_parent(struct clk_hw *hw, u8 index)
 	return regmap_update_bits(clkr->regmap, cpuclk->reg, mask, val);
 }
 
-static int clk_cpu_8996_mux_determine_rate(struct clk_hw *hw,
+static int clk_cpu_8996_pmux_determine_rate(struct clk_hw *hw,
 					   struct clk_rate_request *req)
 {
-	struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_hw(hw);
+	struct clk_cpu_8996_pmux *cpuclk = to_clk_cpu_8996_pmux_hw(hw);
 	struct clk_hw *parent = cpuclk->pll;
 
 	if (cpuclk->pll_div_2 && req->rate < DIV_2_THRESHOLD) {
@@ -275,13 +276,13 @@ static int clk_cpu_8996_mux_determine_rate(struct clk_hw *hw,
 	return 0;
 }
 
-static const struct clk_ops clk_cpu_8996_mux_ops = {
-	.set_parent = clk_cpu_8996_mux_set_parent,
-	.get_parent = clk_cpu_8996_mux_get_parent,
-	.determine_rate = clk_cpu_8996_mux_determine_rate,
+static const struct clk_ops clk_cpu_8996_pmux_ops = {
+	.set_parent = clk_cpu_8996_pmux_set_parent,
+	.get_parent = clk_cpu_8996_pmux_get_parent,
+	.determine_rate = clk_cpu_8996_pmux_determine_rate,
 };
 
-static struct clk_cpu_8996_mux pwrcl_smux = {
+static struct clk_regmap_mux pwrcl_smux = {
 	.reg = PWRCL_REG_OFFSET + MUX_OFFSET,
 	.shift = 2,
 	.width = 2,
@@ -292,12 +293,12 @@ static struct clk_cpu_8996_mux pwrcl_smux = {
 			"pwrcl_pll_postdiv",
 		},
 		.num_parents = 2,
-		.ops = &clk_cpu_8996_mux_ops,
+		.ops = &clk_regmap_mux_closest_ops,
 		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
-static struct clk_cpu_8996_mux perfcl_smux = {
+static struct clk_regmap_mux perfcl_smux = {
 	.reg = PERFCL_REG_OFFSET + MUX_OFFSET,
 	.shift = 2,
 	.width = 2,
@@ -308,12 +309,12 @@ static struct clk_cpu_8996_mux perfcl_smux = {
 			"perfcl_pll_postdiv",
 		},
 		.num_parents = 2,
-		.ops = &clk_cpu_8996_mux_ops,
+		.ops = &clk_regmap_mux_closest_ops,
 		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
-static struct clk_cpu_8996_mux pwrcl_pmux = {
+static struct clk_cpu_8996_pmux pwrcl_pmux = {
 	.reg = PWRCL_REG_OFFSET + MUX_OFFSET,
 	.shift = 0,
 	.width = 2,
@@ -329,13 +330,13 @@ static struct clk_cpu_8996_mux pwrcl_pmux = {
 			"pwrcl_alt_pll",
 		},
 		.num_parents = 4,
-		.ops = &clk_cpu_8996_mux_ops,
+		.ops = &clk_cpu_8996_pmux_ops,
 		/* CPU clock is critical and should never be gated */
 		.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
 	},
 };
 
-static struct clk_cpu_8996_mux perfcl_pmux = {
+static struct clk_cpu_8996_pmux perfcl_pmux = {
 	.reg = PERFCL_REG_OFFSET + MUX_OFFSET,
 	.shift = 0,
 	.width = 2,
@@ -351,7 +352,7 @@ static struct clk_cpu_8996_mux perfcl_pmux = {
 			"perfcl_alt_pll",
 		},
 		.num_parents = 4,
-		.ops = &clk_cpu_8996_mux_ops,
+		.ops = &clk_cpu_8996_pmux_ops,
 		/* CPU clock is critical and should never be gated */
 		.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
 	},
@@ -394,9 +395,6 @@ static int qcom_cpu_clk_msm8996_register_clks(struct device *dev,
 		return ret;
 	}
 
-	pwrcl_smux.pll = &pwrcl_pll_postdiv.hw;
-	perfcl_smux.pll = &perfcl_pll_postdiv.hw;
-
 	for (i = 0; i < ARRAY_SIZE(cpu_msm8996_clks); i++) {
 		ret = devm_clk_register_regmap(dev, cpu_msm8996_clks[i]);
 		if (ret)
@@ -474,22 +472,22 @@ static void qcom_cpu_clk_msm8996_acd_init(void __iomem *base)
 static int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 			       void *data)
 {
-	struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_nb(nb);
+	struct clk_cpu_8996_pmux *cpuclk = to_clk_cpu_8996_pmux_nb(nb);
 	struct clk_notifier_data *cnd = data;
 	int ret;
 
 	switch (event) {
 	case PRE_RATE_CHANGE:
-		ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw, ALT_INDEX);
+		ret = clk_cpu_8996_pmux_set_parent(&cpuclk->clkr.hw, ALT_INDEX);
 		qcom_cpu_clk_msm8996_acd_init(base);
 		break;
 	case POST_RATE_CHANGE:
 		if (cnd->new_rate < DIV_2_THRESHOLD)
-			ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw,
-							  SMUX_INDEX);
+			ret = clk_cpu_8996_pmux_set_parent(&cpuclk->clkr.hw,
+							   SMUX_INDEX);
 		else
-			ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw,
-							  ACD_INDEX);
+			ret = clk_cpu_8996_pmux_set_parent(&cpuclk->clkr.hw,
+							   ACD_INDEX);
 		break;
 	default:
 		ret = 0;
-- 
2.36.1

