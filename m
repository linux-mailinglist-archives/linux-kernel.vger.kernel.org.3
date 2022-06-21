Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59146553747
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353593AbiFUQHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353533AbiFUQHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:07:11 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3F1F1E;
        Tue, 21 Jun 2022 09:07:10 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ej4so16076983edb.7;
        Tue, 21 Jun 2022 09:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3LdhXVBayXK2e6Gfdh/Miku3QTiOMf+8T69vVZwmwlA=;
        b=oNA6/Va8UeNlBq3nBOHnKyoEY09VwNX0gquv7rHz0G8pJUMK5rw+T5N9F125e4Nv6R
         eE9pVODJ9XcLtfUyRdwKk7TqqEmAl9JFX+mpLTKvgmurUlOFQsj5VmnZsi0JYqRTRcAZ
         QEB2QLB0I1dL2pOeOpRmVLuv1j/dAo5b0GfCA/5/BonE/H4vOq/wE0MrU7xDHVq40JVS
         yxDqA+lXtLbVJ97NdZn0RiSLU7hEKo6U900Y7TxxabOw/oDRNWefFg78xjaGDqmXmeib
         67gPmxgaL27SDGfI9C2H0QHENqlRCxBbozwqUTJgQpjmk7DSjNIZrMbXGEelFrtU+4s1
         Or5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3LdhXVBayXK2e6Gfdh/Miku3QTiOMf+8T69vVZwmwlA=;
        b=T9k0V+mfGrEeoIrFFVHI7e7lx+7FB4z9opjOwkkQqPaOoVgTGslWEB92WtGTPRnkGd
         sq5iJGI/2m4DbLEBEzQymqJKc6JXrNG7ylXdJS9iS7APrFq9NqWisxUjvbp4v7YfW2uP
         xZiUH4VcLKj4nN8z38dkxBAGtszwQC9Gyt5t5LvJSiy3C2tUHrq/qldRy5/8Ksnx8iKT
         kkcKoVzE5qK/nM12yJRLvV0xixJ4nUORC+4e+nYU4M7AXzgc+3gtG+699h2bB89+wsV6
         XaqrdcNCgA3jtW2FDTGmCmpHE24jEZ8/mttBkCT7hqtBRry49R1ObOTjQgHdGf0vzncT
         987A==
X-Gm-Message-State: AJIora/1tWvEsNBZOwKBlHhhfDQXUDfIflTHId9N9qxpadkl3iZbpbf+
        FEZz4x3sC1e5ym9bYCaGRic=
X-Google-Smtp-Source: AGRyM1tSZNwg9gxlJeS6FN1z8jYK+VAxmhC+DdcE9F7d/vK03wrbTpD1uZfRJoUn4DKeuYL3YRViNw==
X-Received: by 2002:a05:6402:1386:b0:431:6911:a151 with SMTP id b6-20020a056402138600b004316911a151mr36186645edv.105.1655827628627;
        Tue, 21 Jun 2022 09:07:08 -0700 (PDT)
Received: from localhost.localdomain ([185.107.57.61])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090653c600b00722e0b1fa8esm1772943ejo.164.2022.06.21.09.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 09:07:08 -0700 (PDT)
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
Subject: [PATCH 2/6] clk: qcom: msm8996-cpu: Statically define PLL dividers
Date:   Tue, 21 Jun 2022 20:06:17 +0400
Message-Id: <20220621160621.24415-3-y.oudjana@protonmail.com>
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

This will allow for adding them to clk_parent_data arrays
in an upcoming patch.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/clk/qcom/clk-cpu-8996.c | 66 +++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
index 5dc68dc3621f..217f9392c23d 100644
--- a/drivers/clk/qcom/clk-cpu-8996.c
+++ b/drivers/clk/qcom/clk-cpu-8996.c
@@ -135,6 +135,34 @@ static struct clk_alpha_pll pwrcl_pll = {
 	},
 };
 
+static struct clk_fixed_factor pwrcl_pll_postdiv = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(struct clk_init_data){
+		.name = "pwrcl_pll_postdiv",
+		.parent_data = &(const struct clk_parent_data){
+			.hw = &pwrcl_pll.clkr.hw
+		},
+		.num_parents = 1,
+		.ops = &clk_fixed_factor_ops,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_fixed_factor perfcl_pll_postdiv = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(struct clk_init_data){
+		.name = "perfcl_pll_postdiv",
+		.parent_data = &(const struct clk_parent_data){
+			.hw = &perfcl_pll.clkr.hw
+		},
+		.num_parents = 1,
+		.ops = &clk_fixed_factor_ops,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 static const struct pll_vco alt_pll_vco_modes[] = {
 	VCO(3,  250000000,  500000000),
 	VCO(2,  500000000,  750000000),
@@ -261,7 +289,7 @@ static struct clk_cpu_8996_mux pwrcl_smux = {
 		.name = "pwrcl_smux",
 		.parent_names = (const char *[]){
 			"xo",
-			"pwrcl_pll_main",
+			"pwrcl_pll_postdiv",
 		},
 		.num_parents = 2,
 		.ops = &clk_cpu_8996_mux_ops,
@@ -277,7 +305,7 @@ static struct clk_cpu_8996_mux perfcl_smux = {
 		.name = "perfcl_smux",
 		.parent_names = (const char *[]){
 			"xo",
-			"perfcl_pll_main",
+			"perfcl_pll_postdiv",
 		},
 		.num_parents = 2,
 		.ops = &clk_cpu_8996_mux_ops,
@@ -354,32 +382,25 @@ static int qcom_cpu_clk_msm8996_register_clks(struct device *dev,
 {
 	int i, ret;
 
-	perfcl_smux.pll = clk_hw_register_fixed_factor(dev, "perfcl_pll_main",
-						       "perfcl_pll",
-						       CLK_SET_RATE_PARENT,
-						       1, 2);
-	if (IS_ERR(perfcl_smux.pll)) {
-		dev_err(dev, "Failed to initialize perfcl_pll_main\n");
-		return PTR_ERR(perfcl_smux.pll);
+	ret = devm_clk_hw_register(dev, &pwrcl_pll_postdiv.hw);
+	if (ret) {
+		dev_err(dev, "Failed to register pwrcl_pll_postdiv: %d", ret);
+		return ret;
 	}
 
-	pwrcl_smux.pll = clk_hw_register_fixed_factor(dev, "pwrcl_pll_main",
-						      "pwrcl_pll",
-						      CLK_SET_RATE_PARENT,
-						      1, 2);
-	if (IS_ERR(pwrcl_smux.pll)) {
-		dev_err(dev, "Failed to initialize pwrcl_pll_main\n");
-		clk_hw_unregister(perfcl_smux.pll);
-		return PTR_ERR(pwrcl_smux.pll);
+	ret = devm_clk_hw_register(dev, &perfcl_pll_postdiv.hw);
+	if (ret) {
+		dev_err(dev, "Failed to register perfcl_pll_postdiv: %d", ret);
+		return ret;
 	}
 
+	pwrcl_smux.pll = &pwrcl_pll_postdiv.hw;
+	perfcl_smux.pll = &perfcl_pll_postdiv.hw;
+
 	for (i = 0; i < ARRAY_SIZE(cpu_msm8996_clks); i++) {
 		ret = devm_clk_register_regmap(dev, cpu_msm8996_clks[i]);
-		if (ret) {
-			clk_hw_unregister(perfcl_smux.pll);
-			clk_hw_unregister(pwrcl_smux.pll);
+		if (ret)
 			return ret;
-		}
 	}
 
 	clk_alpha_pll_configure(&perfcl_pll, regmap, &hfpll_config);
@@ -409,9 +430,6 @@ static int qcom_cpu_clk_msm8996_unregister_clks(void)
 	if (ret)
 		return ret;
 
-	clk_hw_unregister(perfcl_smux.pll);
-	clk_hw_unregister(pwrcl_smux.pll);
-
 	return 0;
 }
 
-- 
2.36.1

