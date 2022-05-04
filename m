Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78965519F65
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349504AbiEDMbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349489AbiEDMbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:31:16 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FA22C654
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 05:27:38 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id y3so2528458ejo.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 05:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8yQv7sPHp2MFInhIaa2OViHGxJArb/DI811sduLPJCk=;
        b=FY8pTjCy4o+S26j8vzaNVz0steta5PQqiARBvA1tFfr1QUciC5jfqLzujqrRqwxz0q
         IbR7bjEOEiF0/c7jIl8qG4vwSgXlMx27aqGwR5w0vjl6qdLYp8itLrzRbJfR9lprZPve
         xPQ0Jhkgjjok2Jo8i7g8Z4OaBmUp7vj2JjzA8rSO9Sln5yNri9X55Q0THmfJRbvZALT6
         VKH/YhZSljxwf/cps8ur3lDcZA4lsLpInQolnVSMenblD4GMNAviVwrTwNFDoUIVAxPS
         CKKGsOqmpIk86FfMe15/CyMw2fDnNcO1ndzXDP5FKjWB7AeWyjoNk9X7XF4BwgEH9WpM
         a6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8yQv7sPHp2MFInhIaa2OViHGxJArb/DI811sduLPJCk=;
        b=2Sgf3bc2hCim6YI+ZI7ZjXsv+opLCpgdIhqi3TPQsKUywWdVYiJRuQeU0yET7stgXS
         1DlnGSaTNWBO7soeb5wM/qPilqPgJ8/GJMIhQFrqVZc/1oi1uQ593Fsl7zBZJdtGa9IF
         ei8BNIaJweFc9UPngEaZFwsXl8dCRb68qAshmWtTrCiCDDAW6WWanMhvZwkq7sZSr63T
         8bjyzzai3q1NGABDYB6ZnYSuE75gil4WfyHMmADi0389q8nuO6QWNJ+q5d7HCCt9z2Tg
         ZewJDv1kOdeGHihpxkfGJOoxpL7hYRwYwMbae6nfcCtUSQkkjA741skqxb068jVmKSY0
         pr0w==
X-Gm-Message-State: AOAM530j67ut19x6YLk6eteCkJb1tau2hnvorB3hB3kRGlFQw/1zyvzM
        tqMpRZXottWDNZ0scYUoHXAw+Q==
X-Google-Smtp-Source: ABdhPJy/m2fd8w0CCNuqZQghcyRpWZjDcLth2YFgSdzKh3lSp8R2l2sKXrs9ou+B7FB/2TTr8wm/RQ==
X-Received: by 2002:a17:907:8a12:b0:6f4:a586:de8f with SMTP id sc18-20020a1709078a1200b006f4a586de8fmr5251137ejc.514.1651667256735;
        Wed, 04 May 2022 05:27:36 -0700 (PDT)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id mm30-20020a170906cc5e00b006f3ef214e06sm5675557ejb.108.2022.05.04.05.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 05:27:36 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, jonathan@marek.ca, tdas@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v3 4/6] clk: qcom: add support for SM8350 DISPCC
Date:   Wed,  4 May 2022 14:27:23 +0200
Message-Id: <20220504122725.179262-5-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220504122725.179262-1-robert.foss@linaro.org>
References: <20220504122725.179262-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Marek <jonathan@marek.ca>

Add support to the SM8350 display clock controller by extending the SM8250
display clock controller, which is almost identical but has some minor
differences.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---

Changes since v1
 - Remove comment - Dmitry

Changes since v2
 - Add my SoB - Bjorn
 - Remove CLK_ASSUME_ENABLED_WHEN_UNUSED flag


 drivers/clk/qcom/Kconfig         |  4 +--
 drivers/clk/qcom/dispcc-sm8250.c | 60 +++++++++++++++++++++++++++++++-
 2 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 9b1f54e634b9..1752ca0ee405 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -609,11 +609,11 @@ config SM_DISPCC_6125
 	  splash screen
 
 config SM_DISPCC_8250
-	tristate "SM8150 and SM8250 Display Clock Controller"
+	tristate "SM8150/SM8250/SM8350 Display Clock Controller"
 	depends on SM_GCC_8150 || SM_GCC_8250
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc
-	  SM8150 and SM8250 devices.
+	  SM8150/SM8250/SM8350 devices.
 	  Say Y if you want to support display devices and functionality such as
 	  splash screen.
 
diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
index db9379634fb2..8e6cb990e387 100644
--- a/drivers/clk/qcom/dispcc-sm8250.c
+++ b/drivers/clk/qcom/dispcc-sm8250.c
@@ -43,6 +43,10 @@ static struct pll_vco vco_table[] = {
 	{ 249600000, 2000000000, 0 },
 };
 
+static struct pll_vco lucid_5lpe_vco[] = {
+	{ 249600000, 1750000000, 0 },
+};
+
 static struct alpha_pll_config disp_cc_pll0_config = {
 	.l = 0x47,
 	.alpha = 0xE000,
@@ -1228,6 +1232,7 @@ static const struct of_device_id disp_cc_sm8250_match_table[] = {
 	{ .compatible = "qcom,sc8180x-dispcc" },
 	{ .compatible = "qcom,sm8150-dispcc" },
 	{ .compatible = "qcom,sm8250-dispcc" },
+	{ .compatible = "qcom,sm8350-dispcc" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, disp_cc_sm8250_match_table);
@@ -1258,7 +1263,7 @@ static int disp_cc_sm8250_probe(struct platform_device *pdev)
 		return PTR_ERR(regmap);
 	}
 
-	/* note: trion == lucid, except for the prepare() op */
+	/* Apply differences for SM8150 and SM8350 */
 	BUILD_BUG_ON(CLK_ALPHA_PLL_TYPE_TRION != CLK_ALPHA_PLL_TYPE_LUCID);
 	if (of_device_is_compatible(pdev->dev.of_node, "qcom,sc8180x-dispcc") ||
 	    of_device_is_compatible(pdev->dev.of_node, "qcom,sm8150-dispcc")) {
@@ -1270,6 +1275,59 @@ static int disp_cc_sm8250_probe(struct platform_device *pdev)
 		disp_cc_pll1_config.config_ctl_hi1_val = 0x00000024;
 		disp_cc_pll1_config.user_ctl_hi1_val = 0x000000D0;
 		disp_cc_pll1_init.ops = &clk_alpha_pll_trion_ops;
+	} else if (of_device_is_compatible(pdev->dev.of_node, "qcom,sm8350-dispcc")) {
+		static struct clk_rcg2 * const rcgs[] = {
+			&disp_cc_mdss_byte0_clk_src,
+			&disp_cc_mdss_byte1_clk_src,
+			&disp_cc_mdss_dp_aux1_clk_src,
+			&disp_cc_mdss_dp_aux_clk_src,
+			&disp_cc_mdss_dp_link1_clk_src,
+			&disp_cc_mdss_dp_link_clk_src,
+			&disp_cc_mdss_dp_pixel1_clk_src,
+			&disp_cc_mdss_dp_pixel2_clk_src,
+			&disp_cc_mdss_dp_pixel_clk_src,
+			&disp_cc_mdss_esc0_clk_src,
+			&disp_cc_mdss_mdp_clk_src,
+			&disp_cc_mdss_pclk0_clk_src,
+			&disp_cc_mdss_pclk1_clk_src,
+			&disp_cc_mdss_rot_clk_src,
+			&disp_cc_mdss_vsync_clk_src,
+		};
+		static struct clk_regmap_div * const divs[] = {
+			&disp_cc_mdss_byte0_div_clk_src,
+			&disp_cc_mdss_byte1_div_clk_src,
+			&disp_cc_mdss_dp_link1_div_clk_src,
+			&disp_cc_mdss_dp_link_div_clk_src,
+		};
+		unsigned int i;
+		static bool offset_applied;
+
+		/* only apply the offsets once (in case of deferred probe) */
+		if (!offset_applied) {
+			for (i = 0; i < ARRAY_SIZE(rcgs); i++)
+				rcgs[i]->cmd_rcgr -= 4;
+
+			for (i = 0; i < ARRAY_SIZE(divs); i++) {
+				divs[i]->reg -= 4;
+				divs[i]->width = 4;
+			}
+
+			disp_cc_mdss_ahb_clk.halt_reg -= 4;
+			disp_cc_mdss_ahb_clk.clkr.enable_reg -= 4;
+
+			offset_applied = true;
+		}
+
+		disp_cc_mdss_ahb_clk_src.cmd_rcgr = 0x22a0;
+
+		disp_cc_pll0_config.config_ctl_hi1_val = 0x2A9A699C;
+		disp_cc_pll0_config.test_ctl_hi1_val = 0x01800000;
+		disp_cc_pll0_init.ops = &clk_alpha_pll_lucid_5lpe_ops;
+		disp_cc_pll0.vco_table = lucid_5lpe_vco;
+		disp_cc_pll1_config.config_ctl_hi1_val = 0x2A9A699C;
+		disp_cc_pll1_config.test_ctl_hi1_val = 0x01800000;
+		disp_cc_pll1_init.ops = &clk_alpha_pll_lucid_5lpe_ops;
+		disp_cc_pll1.vco_table = lucid_5lpe_vco;
 	}
 
 	clk_lucid_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
-- 
2.34.1

