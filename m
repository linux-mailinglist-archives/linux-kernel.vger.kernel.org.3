Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4535033CE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiDPDB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 23:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiDPDBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 23:01:22 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E61C5F258;
        Fri, 15 Apr 2022 19:58:51 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g20so11793514edw.6;
        Fri, 15 Apr 2022 19:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZQkWUnAkPP3u4wDz+lMwV1hykNAjw95szW9gvxsGCSo=;
        b=mEbB3krDIW75iC5+4cIhaXylVcw1BGskjQp0Ie5anGqFXmYfRVl7DJ0RNd55QbWhYq
         DMcBlD6K9yqvHFAYMz329UxQRxuH2DY0TC7WLAkyt2gfNmjoNLMONXRvEMuL0pXGtj4F
         GPkGh4Rvy6Y8NeCYZCRHtZxISMIS6t6KOcRCbsiEKALVgH+AGxpif1BAAsvKOWM0go08
         PnN6p4F8PZkq1MtPWvWz9Z9mvErs7h+kliy1VLijuNihxDiMLT8bFEx2enMhUKcWlRAl
         4PBmw7rV76lkcOPBguidS3WFzCQbfRbPI/X69qy6NIUTGFvZxSDgxufjH+0k0kOi0Km6
         JI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZQkWUnAkPP3u4wDz+lMwV1hykNAjw95szW9gvxsGCSo=;
        b=yjPB6kip1zSgq4tYv6hPlKiPbdOm9xgLGOj56+sFtmbrjzORUuslbmWAsI7LHLPZrP
         MUnOUdIG6q0jUBvYvhw9AEKra8nFaruN1rt4yJNcOR096bHm/o3hzstiIcPbbZ2NRv6t
         DwTtcSZdlSElAWDCfblwAro6OsxcHACxlTvf2MDEqNyLPnmyVasRsrEPoJMQpVpaHc2R
         sUNzZW6rpwdZ/IbJWvYTegISpl9EM9wgafyq7QgdeQnbqxIQMrZ2o5H2d15mYwY++sVd
         CtBdz/hbyt70ZhaQt3nb4UeJnG39L3WN4Ga85Nj945FZQs/anK+kAyKAYYknuq7eBhlh
         97hA==
X-Gm-Message-State: AOAM532Y1Ol0lW3aB9k+MU4nSg3b40eE2b9EkRun38tKvKzDNhdcpv7Q
        wWIx2aogskzO07GF3wlt8eM=
X-Google-Smtp-Source: ABdhPJzwNrPggzMgLHIl78M6jF7LvWuJfTU8GCLc8NNJo0pgq651DFmkcVGAY5WvhKPVche/BtPKSQ==
X-Received: by 2002:aa7:de93:0:b0:418:d700:662a with SMTP id j19-20020aa7de93000000b00418d700662amr1924630edv.107.1650077929526;
        Fri, 15 Apr 2022 19:58:49 -0700 (PDT)
Received: from localhost.localdomain ([138.199.7.159])
        by smtp.gmail.com with ESMTPSA id oz20-20020a170906cd1400b006e872188edbsm2200915ejb.104.2022.04.15.19.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 19:58:49 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH RESEND v2 3/9] clk: qcom: msm8996-cpu: Add MSM8996 Pro CBF support
Date:   Sat, 16 Apr 2022 06:56:31 +0400
Message-Id: <20220416025637.83484-4-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220416025637.83484-1-y.oudjana@protonmail.com>
References: <20220416025637.83484-1-y.oudjana@protonmail.com>
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

MSM8996 Pro (MSM8996SG) has a /4 divisor on the CBF clock
instead of /2. This allows it to reach a lower minimum frequency
of 192000000Hz compared to 307200000Hz on regular MSM8996.
Add support for setting the CBF clock divisor to /4 for MSM8996 Pro.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 drivers/clk/qcom/clk-cpu-8996.c | 61 +++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
index 8afc271f92d0..231d8224fa16 100644
--- a/drivers/clk/qcom/clk-cpu-8996.c
+++ b/drivers/clk/qcom/clk-cpu-8996.c
@@ -70,11 +70,11 @@ enum _pmux_input {
 
 enum {
 	CBF_PLL_INDEX = 1,
-	CBF_DIV_2_INDEX,
+	CBF_DIV_INDEX,
 	CBF_SAFE_INDEX
 };
 
-#define DIV_2_THRESHOLD		600000000
+#define DIV_THRESHOLD		600000000
 #define PWRCL_REG_OFFSET 0x0
 #define PERFCL_REG_OFFSET 0x80000
 #define MUX_OFFSET	0x40
@@ -142,6 +142,17 @@ static const struct alpha_pll_config cbfpll_config = {
 	.early_output_mask = BIT(3),
 };
 
+static const struct alpha_pll_config cbfpll_config_pro = {
+	.l = 72,
+	.config_ctl_val = 0x200d4aa8,
+	.config_ctl_hi_val = 0x006,
+	.pre_div_mask = BIT(12),
+	.post_div_mask = 0x3 << 8,
+	.post_div_val = 0x3 << 8,
+	.main_output_mask = BIT(0),
+	.early_output_mask = BIT(3),
+};
+
 static struct clk_alpha_pll perfcl_pll = {
 	.offset = PERFCL_REG_OFFSET,
 	.regs = prim_pll_regs,
@@ -230,7 +241,8 @@ struct clk_cpu_8996_mux {
 	u8	width;
 	struct notifier_block nb;
 	struct clk_hw	*pll;
-	struct clk_hw	*pll_div_2;
+	struct clk_hw	*pll_div;
+	u8 div;
 	struct clk_regmap clkr;
 };
 
@@ -280,11 +292,11 @@ static int clk_cpu_8996_mux_determine_rate(struct clk_hw *hw,
 	struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_hw(hw);
 	struct clk_hw *parent = cpuclk->pll;
 
-	if (cpuclk->pll_div_2 && req->rate < DIV_2_THRESHOLD) {
-		if (req->rate < (DIV_2_THRESHOLD / 2))
+	if (cpuclk->pll_div && req->rate < DIV_THRESHOLD) {
+		if (req->rate < (DIV_THRESHOLD / cpuclk->div))
 			return -EINVAL;
 
-		parent = cpuclk->pll_div_2;
+		parent = cpuclk->pll_div;
 	}
 
 	req->best_parent_rate = clk_hw_round_rate(parent, req->rate);
@@ -336,7 +348,8 @@ static struct clk_cpu_8996_mux pwrcl_pmux = {
 	.shift = 0,
 	.width = 2,
 	.pll = &pwrcl_pll.clkr.hw,
-	.pll_div_2 = &pwrcl_smux.clkr.hw,
+	.pll_div = &pwrcl_smux.clkr.hw,
+	.div = 2,
 	.nb.notifier_call = cpu_clk_notifier_cb,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "pwrcl_pmux",
@@ -358,7 +371,8 @@ static struct clk_cpu_8996_mux perfcl_pmux = {
 	.shift = 0,
 	.width = 2,
 	.pll = &perfcl_pll.clkr.hw,
-	.pll_div_2 = &perfcl_smux.clkr.hw,
+	.pll_div = &perfcl_smux.clkr.hw,
+	.div = 2,
 	.nb.notifier_call = cpu_clk_notifier_cb,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "perfcl_pmux",
@@ -481,19 +495,23 @@ static int qcom_cbf_clk_msm8996_register_clks(struct device *dev,
 					      struct regmap *regmap)
 {
 	int ret;
+	bool is_pro = of_device_is_compatible(dev->of_node, "qcom,msm8996pro-apcc");
 
-	cbf_mux.pll_div_2 = clk_hw_register_fixed_factor(dev, "cbf_pll_main",
-						      "cbf_pll", CLK_SET_RATE_PARENT,
-						      1, 2);
-	if (IS_ERR(cbf_mux.pll_div_2)) {
+	cbf_mux.div = is_pro ? 4 : 2;
+	cbf_mux.pll_div = clk_hw_register_fixed_factor(dev, "cbf_pll_main",
+						       "cbf_pll", CLK_SET_RATE_PARENT,
+						       1, cbf_mux.div);
+
+	if (IS_ERR(cbf_mux.pll_div)) {
 		dev_err(dev, "Failed to initialize cbf_pll_main\n");
-		return PTR_ERR(cbf_mux.pll_div_2);
+		return PTR_ERR(cbf_mux.pll_div);
 	}
 
 	ret = devm_clk_register_regmap(dev, cbf_msm8996_clks[0]);
 	ret = devm_clk_register_regmap(dev, cbf_msm8996_clks[1]);
 
-	clk_alpha_pll_configure(&cbf_pll, regmap, &cbfpll_config);
+	clk_alpha_pll_configure(&cbf_pll, regmap, is_pro ?
+				&cbfpll_config_pro : &cbfpll_config);
 	clk_set_rate(cbf_pll.clkr.hw.clk, 614400000);
 	clk_prepare_enable(cbf_pll.clkr.hw.clk);
 	clk_notifier_register(cbf_mux.clkr.hw.clk, &cbf_mux.nb);
@@ -575,7 +593,7 @@ static int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 		qcom_cpu_clk_msm8996_acd_init(base);
 		break;
 	case POST_RATE_CHANGE:
-		if (cnd->new_rate < DIV_2_THRESHOLD)
+		if (cnd->new_rate < DIV_THRESHOLD)
 			ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw,
 							  DIV_2_INDEX);
 		else
@@ -600,15 +618,15 @@ static int cbf_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 
 	switch (event) {
 	case PRE_RATE_CHANGE:
-		parent = clk_hw_get_parent_by_index(&cbfclk->clkr.hw, CBF_DIV_2_INDEX);
-		ret = clk_cpu_8996_mux_set_parent(&cbfclk->clkr.hw, CBF_DIV_2_INDEX);
+		parent = clk_hw_get_parent_by_index(&cbfclk->clkr.hw, CBF_DIV_INDEX);
+		ret = clk_cpu_8996_mux_set_parent(&cbfclk->clkr.hw, CBF_DIV_INDEX);
 
-		if (cnd->old_rate > DIV_2_THRESHOLD && cnd->new_rate < DIV_2_THRESHOLD)
-			ret = clk_set_rate(parent->clk, cnd->old_rate / 2);
+		if (cnd->old_rate > DIV_THRESHOLD && cnd->new_rate < DIV_THRESHOLD)
+			ret = clk_set_rate(parent->clk, cnd->old_rate / cbfclk->div);
 		break;
 	case POST_RATE_CHANGE:
-		if (cnd->new_rate < DIV_2_THRESHOLD)
-			ret = clk_cpu_8996_mux_set_parent(&cbfclk->clkr.hw, CBF_DIV_2_INDEX);
+		if (cnd->new_rate < DIV_THRESHOLD)
+			ret = clk_cpu_8996_mux_set_parent(&cbfclk->clkr.hw, CBF_DIV_INDEX);
 		else {
 			parent = clk_hw_get_parent_by_index(&cbfclk->clkr.hw, CBF_PLL_INDEX);
 			ret = clk_set_rate(parent->clk, cnd->new_rate);
@@ -676,6 +694,7 @@ static int qcom_cpu_clk_msm8996_driver_remove(struct platform_device *pdev)
 
 static const struct of_device_id qcom_cpu_clk_msm8996_match_table[] = {
 	{ .compatible = "qcom,msm8996-apcc" },
+	{ .compatible = "qcom,msm8996pro-apcc" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_cpu_clk_msm8996_match_table);
-- 
2.35.1

