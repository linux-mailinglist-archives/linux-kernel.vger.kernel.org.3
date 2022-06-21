Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DB255374B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353666AbiFUQHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353653AbiFUQHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:07:19 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA069594;
        Tue, 21 Jun 2022 09:07:17 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id es26so18324714edb.4;
        Tue, 21 Jun 2022 09:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wFX3cKIYPDA5jOA0LlRPg99r8BaDTbP86VBtDe9JGY4=;
        b=eOCGlLOp4137HpTdNX+AplQr8eL9rHYMo4y9kDeVYWfiPmoW+eCdAi8OqkFhoJN5FS
         LVqhdPf82WAUWGv4pIGwPNhPKfGDJ7FWLMdIDmkLahPBgEtJ4vYv/KdFTOaqYKhBiw7K
         PO/hiouZFV8q5n1roLmCuPH9FphjK3Twvc4Ybbmno+qvGwfuc2OcKhY4rN7l0JAtf7U9
         exRjhY/2CkiAQb7RiWZnJjTgylBtz/2dxZ61+QC3RbB2RCANUtOap1gFiBbbfyvCiXFn
         a24PEj7s9+MAWTeqV5pxsNlukejH2LbpGzV4OLob2vgK0WkBNEPzoFK/i2A//vlP/Q4i
         F1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wFX3cKIYPDA5jOA0LlRPg99r8BaDTbP86VBtDe9JGY4=;
        b=Pc/DmDABEEmz1cqWRcx1aOvQ6B5T+PTZvFfBhY91xqRtD4R2lUwxRRIaYCVeJMha/G
         83FpRdFXFC3MaGFCNmdFRzNoHdJWIWVBcCdYFv5Lf0BZZN72Dy4eU3uo4CpooyAotGoQ
         B0oCeuVXuTyAdHPVEq8w0ztSeT9F2NXtZQqN0Oj+M4rrRGGS4/iA4nSUwLwHyIDfYWbE
         N9YfZRZao2KxezzSYfHLW6AjrDt7Gw0Tpff8aNWJ1cOs2QoIdngwdj7FHqgpahTJ6nKe
         TxebSM1wix/RNnsOYoMYcUYEjKirLwo5/uDIHuu9gQ+/ZHN8uKeaKUalh40Gof+Jvnwz
         Bfpw==
X-Gm-Message-State: AJIora+ZNc1HNn+vJ2ExHiwV3EB722te6WmNUWCRvsqnrt0kKm/KkuoG
        u2wmHeLmJJDzZq/NhpPK67g=
X-Google-Smtp-Source: AGRyM1se+JEKo32UuANFLMv8SfjHAQ09NoxOLRMy9jxLyNUcEnm+tVGdr8/3MitmLoE0HEQHVt3s7w==
X-Received: by 2002:a05:6402:3224:b0:435:80fd:333 with SMTP id g36-20020a056402322400b0043580fd0333mr13154371eda.76.1655827635653;
        Tue, 21 Jun 2022 09:07:15 -0700 (PDT)
Received: from localhost.localdomain ([185.107.57.61])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090653c600b00722e0b1fa8esm1772943ejo.164.2022.06.21.09.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 09:07:15 -0700 (PDT)
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
Subject: [PATCH 3/6] clk: qcom: msm8996-cpu: Unify cluster order
Date:   Tue, 21 Jun 2022 20:06:18 +0400
Message-Id: <20220621160621.24415-4-y.oudjana@protonmail.com>
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

The power cluster comes before the performance cluster. Make
everything in the driver follow this order.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/clk/qcom/clk-cpu-8996.c | 36 ++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
index 217f9392c23d..b6761a74d5ac 100644
--- a/drivers/clk/qcom/clk-cpu-8996.c
+++ b/drivers/clk/qcom/clk-cpu-8996.c
@@ -111,24 +111,24 @@ static const struct alpha_pll_config hfpll_config = {
 	.early_output_mask = BIT(3),
 };
 
-static struct clk_alpha_pll perfcl_pll = {
-	.offset = PERFCL_REG_OFFSET,
+static struct clk_alpha_pll pwrcl_pll = {
+	.offset = PWRCL_REG_OFFSET,
 	.regs = prim_pll_regs,
 	.flags = SUPPORTS_DYNAMIC_UPDATE | SUPPORTS_FSM_MODE,
 	.clkr.hw.init = &(struct clk_init_data){
-		.name = "perfcl_pll",
+		.name = "pwrcl_pll",
 		.parent_names = (const char *[]){ "xo" },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_huayra_ops,
 	},
 };
 
-static struct clk_alpha_pll pwrcl_pll = {
-	.offset = PWRCL_REG_OFFSET,
+static struct clk_alpha_pll perfcl_pll = {
+	.offset = PERFCL_REG_OFFSET,
 	.regs = prim_pll_regs,
 	.flags = SUPPORTS_DYNAMIC_UPDATE | SUPPORTS_FSM_MODE,
 	.clkr.hw.init = &(struct clk_init_data){
-		.name = "pwrcl_pll",
+		.name = "perfcl_pll",
 		.parent_names = (const char *[]){ "xo" },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_huayra_ops,
@@ -181,28 +181,28 @@ static const struct alpha_pll_config altpll_config = {
 	.early_output_mask = BIT(3),
 };
 
-static struct clk_alpha_pll perfcl_alt_pll = {
-	.offset = PERFCL_REG_OFFSET + ALT_PLL_OFFSET,
+static struct clk_alpha_pll pwrcl_alt_pll = {
+	.offset = PWRCL_REG_OFFSET + ALT_PLL_OFFSET,
 	.regs = alt_pll_regs,
 	.vco_table = alt_pll_vco_modes,
 	.num_vco = ARRAY_SIZE(alt_pll_vco_modes),
 	.flags = SUPPORTS_OFFLINE_REQ | SUPPORTS_FSM_MODE,
 	.clkr.hw.init = &(struct clk_init_data) {
-		.name = "perfcl_alt_pll",
+		.name = "pwrcl_alt_pll",
 		.parent_names = (const char *[]){ "xo" },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_hwfsm_ops,
 	},
 };
 
-static struct clk_alpha_pll pwrcl_alt_pll = {
-	.offset = PWRCL_REG_OFFSET + ALT_PLL_OFFSET,
+static struct clk_alpha_pll perfcl_alt_pll = {
+	.offset = PERFCL_REG_OFFSET + ALT_PLL_OFFSET,
 	.regs = alt_pll_regs,
 	.vco_table = alt_pll_vco_modes,
 	.num_vco = ARRAY_SIZE(alt_pll_vco_modes),
 	.flags = SUPPORTS_OFFLINE_REQ | SUPPORTS_FSM_MODE,
 	.clkr.hw.init = &(struct clk_init_data) {
-		.name = "pwrcl_alt_pll",
+		.name = "perfcl_alt_pll",
 		.parent_names = (const char *[]){ "xo" },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_hwfsm_ops,
@@ -367,14 +367,14 @@ static const struct regmap_config cpu_msm8996_regmap_config = {
 };
 
 static struct clk_regmap *cpu_msm8996_clks[] = {
-	&perfcl_pll.clkr,
 	&pwrcl_pll.clkr,
-	&perfcl_alt_pll.clkr,
+	&perfcl_pll.clkr,
 	&pwrcl_alt_pll.clkr,
-	&perfcl_smux.clkr,
+	&perfcl_alt_pll.clkr,
 	&pwrcl_smux.clkr,
-	&perfcl_pmux.clkr,
+	&perfcl_smux.clkr,
 	&pwrcl_pmux.clkr,
+	&perfcl_pmux.clkr,
 };
 
 static int qcom_cpu_clk_msm8996_register_clks(struct device *dev,
@@ -403,10 +403,10 @@ static int qcom_cpu_clk_msm8996_register_clks(struct device *dev,
 			return ret;
 	}
 
-	clk_alpha_pll_configure(&perfcl_pll, regmap, &hfpll_config);
 	clk_alpha_pll_configure(&pwrcl_pll, regmap, &hfpll_config);
-	clk_alpha_pll_configure(&perfcl_alt_pll, regmap, &altpll_config);
+	clk_alpha_pll_configure(&perfcl_pll, regmap, &hfpll_config);
 	clk_alpha_pll_configure(&pwrcl_alt_pll, regmap, &altpll_config);
+	clk_alpha_pll_configure(&perfcl_alt_pll, regmap, &altpll_config);
 
 	/* Enable alt PLLs */
 	clk_prepare_enable(pwrcl_alt_pll.clkr.hw.clk);
-- 
2.36.1

