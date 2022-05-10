Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE805220B6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347150AbiEJQJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348646AbiEJQIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:08:37 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754732415E5;
        Tue, 10 May 2022 09:02:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id i19so33879607eja.11;
        Tue, 10 May 2022 09:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KwBHBrCOzaPYxgl3AstELVJc4wpliFOl1Du3UkH+nLE=;
        b=jqnXP0anYPvGgYq18yJFpXZ0sCCy1JopSDSWnfo/L7s3UOMSNzjNKHJhFUHyspjRtJ
         qyqv7EslLNo810znPr+ve6j8T9bh3smXcx+EFtXRwO/Zy+YKyHl0nlURkucheVEa2m4r
         r487Gdk/dqXHCMss0CTLo/3fAABppDsa+ITDtBpx0o3q16jAW7jjmekzJPCUJbKf9K0g
         tcNMNIdi8kSXF3EBSn0ywNGdDyJOS10xUXGZp97bA5SXaD5zu6z7OqG6UgtuMlFPUPwJ
         oQ3BDjg4aOxT1x/SPRu22hPY17rRW2Zq3SR3vd76ZajckixcjT+9kLUrOmDFIKOEvlO7
         mYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KwBHBrCOzaPYxgl3AstELVJc4wpliFOl1Du3UkH+nLE=;
        b=DWIw74C268srSasxKT+icw4oYTWjHyOG1qTBrwAFWJki2c5te7lwrs1ZqEAeRUDWyQ
         R1scKJnzdPMVbxy4/44wSdgCz60/BtefZM559egDVvD0r9uwJaRA9VXwhPnH2WZDAD6c
         LZMuhdSGIR3Bi9CmjxzCLOFdhjZNL2bcZIafKld+8zQqyDZAPvW2qMtPjWOFZNHFxxlG
         J3tki6ncnfE3J9npBSrTWZG7UnjwSrBYJCBP8OVG6sNCrFo1IDo6ONHxB2+gpQAG+0Xg
         lAQc54vC1hzfgYi3VhwkIZRtmnry5FR1oCvd6RYNfhU02TR01OlJW89XKdwObD2GNwjq
         veSw==
X-Gm-Message-State: AOAM532sdv0yphSrXanh3v95rpPyO/KyzwNctCz/TH9SaWB7hxI/1ZT/
        uGowU8f/jp09zdskAqu5AeedM6W6JtkS4g==
X-Google-Smtp-Source: ABdhPJwRX3QHmUR2XKO32GHcynOrBvCijOxguDMdlMibeqO73V8iXTzu4SLzE8ZHzeZsnTmbarurDA==
X-Received: by 2002:a17:906:5d11:b0:6f5:942e:bc60 with SMTP id g17-20020a1709065d1100b006f5942ebc60mr18276017ejt.254.1652198558737;
        Tue, 10 May 2022 09:02:38 -0700 (PDT)
Received: from localhost.localdomain (89-38-99-188.hosted-by-worldstream.net. [89.38.99.188])
        by smtp.gmail.com with ESMTPSA id qk13-20020a170906d9cd00b006f3ef214df3sm6300148ejb.89.2022.05.10.09.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 09:02:38 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: [PATCH v2 2/3] clk: qcom: msm8996-cpu: Add CBF support
Date:   Tue, 10 May 2022 19:59:41 +0400
Message-Id: <20220510155940.812565-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220510155744.812471-1-y.oudjana@protonmail.com>
References: <20220510155744.812471-1-y.oudjana@protonmail.com>
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

From: Konrad Dybcio <konrad.dybcio@somainline.org>

Add the required code to support the CBF clock, which is responsible for
core cluster interconnect frequency on msm8996.

Somewhat based on AngeloGioacchino del Regno's work at:
https://github.com/sonyxperiadev/kernel/blob/aosp/LE.UM.2.3.2.r1.4/drivers/clk/qcom/clk-cpu-8996.c

This fixes the issue with booting with all 4 cores enabled.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Yassine Oudjana <yassine.oudjana@gmail.com>
---
 drivers/clk/qcom/clk-cpu-8996.c | 162 +++++++++++++++++++++++++++++++-
 1 file changed, 159 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
index 4a4fde8dd12d..8afc271f92d0 100644
--- a/drivers/clk/qcom/clk-cpu-8996.c
+++ b/drivers/clk/qcom/clk-cpu-8996.c
@@ -68,10 +68,19 @@ enum _pmux_input {
 	NUM_OF_PMUX_INPUTS
 };
 
+enum {
+	CBF_PLL_INDEX = 1,
+	CBF_DIV_2_INDEX,
+	CBF_SAFE_INDEX
+};
+
 #define DIV_2_THRESHOLD		600000000
 #define PWRCL_REG_OFFSET 0x0
 #define PERFCL_REG_OFFSET 0x80000
 #define MUX_OFFSET	0x40
+#define CBF_REG_OFFSET	0x0
+#define CBF_PLL_OFFSET	0xf000
+#define CBF_MUX_OFFSET 0x18
 #define ALT_PLL_OFFSET	0x100
 #define SSSCTL_OFFSET 0x160
 
@@ -98,6 +107,17 @@ static const u8 alt_pll_regs[PLL_OFF_MAX_REGS] = {
 	[PLL_OFF_STATUS] = 0x28,
 };
 
+static const u8 cbf_pll_regs[PLL_OFF_MAX_REGS] = {
+	[PLL_OFF_L_VAL] = 0x08,
+	[PLL_OFF_ALPHA_VAL] = 0x10,
+	[PLL_OFF_USER_CTL] = 0x18,
+	[PLL_OFF_CONFIG_CTL] = 0x20,
+	[PLL_OFF_CONFIG_CTL_U] = 0x24,
+	[PLL_OFF_TEST_CTL] = 0x30,
+	[PLL_OFF_TEST_CTL_U] = 0x34,
+	[PLL_OFF_STATUS] = 0x28,
+};
+
 /* PLLs */
 
 static const struct alpha_pll_config hfpll_config = {
@@ -111,6 +131,17 @@ static const struct alpha_pll_config hfpll_config = {
 	.early_output_mask = BIT(3),
 };
 
+static const struct alpha_pll_config cbfpll_config = {
+	.l = 72,
+	.config_ctl_val = 0x200d4aa8,
+	.config_ctl_hi_val = 0x006,
+	.pre_div_mask = BIT(12),
+	.post_div_mask = 0x3 << 8,
+	.post_div_val = 0x1 << 8,
+	.main_output_mask = BIT(0),
+	.early_output_mask = BIT(3),
+};
+
 static struct clk_alpha_pll perfcl_pll = {
 	.offset = PERFCL_REG_OFFSET,
 	.regs = prim_pll_regs,
@@ -135,6 +166,18 @@ static struct clk_alpha_pll pwrcl_pll = {
 	},
 };
 
+static struct clk_alpha_pll cbf_pll = {
+	.offset = CBF_PLL_OFFSET,
+	.regs = cbf_pll_regs,
+	.flags = SUPPORTS_DYNAMIC_UPDATE | SUPPORTS_FSM_MODE,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cbf_pll",
+		.parent_names = (const char *[]){ "xo" },
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_huayra_ops,
+	},
+};
+
 static const struct pll_vco alt_pll_vco_modes[] = {
 	VCO(3,  250000000,  500000000),
 	VCO(2,  500000000,  750000000),
@@ -194,6 +237,9 @@ struct clk_cpu_8996_mux {
 static int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 			       void *data);
 
+static int cbf_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
+			       void *data);
+
 #define to_clk_cpu_8996_mux_nb(_nb) \
 	container_of(_nb, struct clk_cpu_8996_mux, nb)
 
@@ -329,6 +375,35 @@ static struct clk_cpu_8996_mux perfcl_pmux = {
 	},
 };
 
+static struct clk_cpu_8996_mux cbf_mux = {
+	.reg = CBF_REG_OFFSET + CBF_MUX_OFFSET,
+	.shift = 0,
+	.width = 2,
+	.pll = &cbf_pll.clkr.hw,
+	.nb.notifier_call = cbf_clk_notifier_cb,
+	.clkr.hw.init = &(struct clk_init_data) {
+		.name = "cbf_mux",
+		.parent_names = (const char *[]){
+			"xo",
+			"cbf_pll",
+			"cbf_pll_main",
+		},
+		.num_parents = 3,
+		.ops = &clk_cpu_8996_mux_ops,
+		/* CPU clock is critical and should never be gated */
+		.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+	},
+};
+
+static const struct regmap_config cbf_msm8996_regmap_config = {
+	.reg_bits		= 32,
+	.reg_stride		= 4,
+	.val_bits		= 32,
+	.max_register		= 0x10000,
+	.fast_io		= true,
+	.val_format_endian	= REGMAP_ENDIAN_LITTLE,
+};
+
 static const struct regmap_config cpu_msm8996_regmap_config = {
 	.reg_bits		= 32,
 	.reg_stride		= 4,
@@ -397,6 +472,35 @@ static int qcom_cpu_clk_msm8996_register_clks(struct device *dev,
 	return ret;
 }
 
+static struct clk_regmap *cbf_msm8996_clks[] = {
+	&cbf_pll.clkr,
+	&cbf_mux.clkr,
+};
+
+static int qcom_cbf_clk_msm8996_register_clks(struct device *dev,
+					      struct regmap *regmap)
+{
+	int ret;
+
+	cbf_mux.pll_div_2 = clk_hw_register_fixed_factor(dev, "cbf_pll_main",
+						      "cbf_pll", CLK_SET_RATE_PARENT,
+						      1, 2);
+	if (IS_ERR(cbf_mux.pll_div_2)) {
+		dev_err(dev, "Failed to initialize cbf_pll_main\n");
+		return PTR_ERR(cbf_mux.pll_div_2);
+	}
+
+	ret = devm_clk_register_regmap(dev, cbf_msm8996_clks[0]);
+	ret = devm_clk_register_regmap(dev, cbf_msm8996_clks[1]);
+
+	clk_alpha_pll_configure(&cbf_pll, regmap, &cbfpll_config);
+	clk_set_rate(cbf_pll.clkr.hw.clk, 614400000);
+	clk_prepare_enable(cbf_pll.clkr.hw.clk);
+	clk_notifier_register(cbf_mux.clkr.hw.clk, &cbf_mux.nb);
+
+	return ret;
+}
+
 static int qcom_cpu_clk_msm8996_unregister_clks(void)
 {
 	int ret = 0;
@@ -409,8 +513,13 @@ static int qcom_cpu_clk_msm8996_unregister_clks(void)
 	if (ret)
 		return ret;
 
+	ret = clk_notifier_unregister(cbf_mux.clkr.hw.clk, &cbf_mux.nb);
+	if (ret)
+		return ret;
+
 	clk_hw_unregister(perfcl_smux.pll);
 	clk_hw_unregister(pwrcl_smux.pll);
+	clk_hw_unregister(cbf_mux.pll);
 
 	return 0;
 }
@@ -481,14 +590,48 @@ static int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 	return notifier_from_errno(ret);
 };
 
+static int cbf_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
+			       void *data)
+{
+	struct clk_cpu_8996_mux *cbfclk = to_clk_cpu_8996_mux_nb(nb);
+	struct clk_notifier_data *cnd = data;
+	struct clk_hw *parent;
+	int ret;
+
+	switch (event) {
+	case PRE_RATE_CHANGE:
+		parent = clk_hw_get_parent_by_index(&cbfclk->clkr.hw, CBF_DIV_2_INDEX);
+		ret = clk_cpu_8996_mux_set_parent(&cbfclk->clkr.hw, CBF_DIV_2_INDEX);
+
+		if (cnd->old_rate > DIV_2_THRESHOLD && cnd->new_rate < DIV_2_THRESHOLD)
+			ret = clk_set_rate(parent->clk, cnd->old_rate / 2);
+		break;
+	case POST_RATE_CHANGE:
+		if (cnd->new_rate < DIV_2_THRESHOLD)
+			ret = clk_cpu_8996_mux_set_parent(&cbfclk->clkr.hw, CBF_DIV_2_INDEX);
+		else {
+			parent = clk_hw_get_parent_by_index(&cbfclk->clkr.hw, CBF_PLL_INDEX);
+			ret = clk_set_rate(parent->clk, cnd->new_rate);
+			ret = clk_cpu_8996_mux_set_parent(&cbfclk->clkr.hw, CBF_PLL_INDEX);
+		}
+		break;
+	default:
+		ret = 0;
+		break;
+	}
+
+	return notifier_from_errno(ret);
+};
+
 static int qcom_cpu_clk_msm8996_driver_probe(struct platform_device *pdev)
 {
-	struct regmap *regmap;
+	struct regmap *regmap, *regmap_cbf;
 	struct clk_hw_onecell_data *data;
 	struct device *dev = &pdev->dev;
+	static void __iomem *cbf_base;
 	int ret;
 
-	data = devm_kzalloc(dev, struct_size(data, hws, 2), GFP_KERNEL);
+	data = devm_kzalloc(dev, struct_size(data, hws, 3), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -506,9 +649,22 @@ static int qcom_cpu_clk_msm8996_driver_probe(struct platform_device *pdev)
 
 	qcom_cpu_clk_msm8996_acd_init(base);
 
+	cbf_base = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(cbf_base))
+		return PTR_ERR(cbf_base);
+
+	regmap_cbf = devm_regmap_init_mmio(dev, cbf_base, &cbf_msm8996_regmap_config);
+	if (IS_ERR(regmap_cbf))
+		return PTR_ERR(regmap_cbf);
+
+	ret = qcom_cbf_clk_msm8996_register_clks(dev, regmap_cbf);
+	if (ret)
+		return ret;
+
 	data->hws[0] = &pwrcl_pmux.clkr.hw;
 	data->hws[1] = &perfcl_pmux.clkr.hw;
-	data->num = 2;
+	data->hws[2] = &cbf_mux.clkr.hw;
+	data->num = 3;
 
 	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, data);
 }
-- 
2.36.0

