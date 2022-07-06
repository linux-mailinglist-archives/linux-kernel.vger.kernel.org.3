Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AE2568E19
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbiGFPtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbiGFPtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:49:14 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0502AE22
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 08:43:48 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z41so19836074ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 08:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=76zEyoHlE3xRaXMA7si+WlFLP1h6q6WX4M6K9Zw6gpI=;
        b=RzHYCqiH6aG8XKSKJqIwdvGAd56Rl2QLsoAraAolIflX17FymVWulbDm+8vLq3CFbQ
         0ONeenaS0g3CR2Fla6+QAOY9nGoJRLgrJsxVTzMEarUT2PvxXjRMB5VJc0+QGVKeSQ0w
         C+kSoR53E7ylX3UGX35fL5ccDTJquwWLiJbCCICKbBt4oqN/cBc0+LeV0UVTaSEHhit3
         nd7pC7OG3GfUA2Xq1cNGn8Pr95duzGNZemFkEyAlMcfbgGOIaig0hJXiDvF+/2rQSvH2
         orl1I59nmmYMedF4F6dabMe9rlhR8bVF8/zKf39ALk4PR2DbshYHk+uPy6KOngqrtQyi
         HBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=76zEyoHlE3xRaXMA7si+WlFLP1h6q6WX4M6K9Zw6gpI=;
        b=Io6q5O1cWCXQUoVDiwDjrmTped0PlYs97ZO/3AroboWvqEHEU1/xNX6DLXVNpn9zaO
         Y9psiXGPmjymuMlgXmS+GCmDfEVDTkWjos//5dnKLrVhXcmDihETH4UO53QoX7g1JnDO
         GcJeGOIB4h/cMBc91BRZ1JfZqWJxNhYJDMBTqoluJd76RDNZnXYiANHDHMks3yxZbuV0
         Kn/I6jSnmXtvhY+2DG8GQfi7eKdJx79NoiPQCIYYixky7kRBdNEl9US8ebPcCn/2mnXY
         CFFVzFYbybD2k0dB6npo0boacavap1CyMxVHKUo46kIpJ5y2xp2UTFEyM9CC9+CWg+Ua
         MqOw==
X-Gm-Message-State: AJIora8x78AqDCj3iz0YZSfkLyti/yQWgDJSDKtyUOWgH2O0z61QxAp1
        YuRyGsNxb2mf995LUjkvEi+Bzw==
X-Google-Smtp-Source: AGRyM1sOIGOELGDmeUg4Yp3A9qviV+kWJJa7Zx9OJAEu2yT70SMVWUtrpd3GPp8q3vAND+YdMvIoog==
X-Received: by 2002:a05:6402:3881:b0:43a:691f:8e3b with SMTP id fd1-20020a056402388100b0043a691f8e3bmr20355189edb.217.1657122227682;
        Wed, 06 Jul 2022 08:43:47 -0700 (PDT)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id fi18-20020a056402551200b0043a43fcde13sm7711033edb.13.2022.07.06.08.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 08:43:47 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jonathan@marek.ca,
        robert.foss@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v8 4/5] clk: qcom: add support for SM8350 DISPCC
Date:   Wed,  6 Jul 2022 17:43:36 +0200
Message-Id: <20220706154337.2026269-5-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706154337.2026269-1-robert.foss@linaro.org>
References: <20220706154337.2026269-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---

Changes since v1
 - Remove comment - Dmitry

Changes since v2
 - Add my SoB - Bjorn
 - Remove CLK_ASSUME_ENABLED_WHEN_UNUSED flag

Changes since v3
 - Add kconfig dependency on SM_GCC_8350 - Konrad
 - Change hex to lowercase - Konrad
 - Split from dispcc-sm8250.c implementation
 - Switch from .fw_name to .index

Changes since v4
 - Hex to lowercase - Konrad
 - Remove bad match table entries - Konrad

Changes since v5
 - Reverted split from dispcc-sm8250
 - Re-added tags from v3

Changes since v6
 - Added kconfig dependency - Konrad
 - Don't remove comment - Konrad



 drivers/clk/qcom/Kconfig         |  6 +--
 drivers/clk/qcom/dispcc-sm8250.c | 63 +++++++++++++++++++++++++++++++-
 2 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 4c5bae4fb38d..f197e99aef84 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -619,11 +619,11 @@ config SM_DISPCC_6125
 	  splash screen
 
 config SM_DISPCC_8250
-	tristate "SM8150 and SM8250 Display Clock Controller"
-	depends on SM_GCC_8150 || SM_GCC_8250
+	tristate "SM8150/SM8250/SM8350 Display Clock Controller"
+	depends on SM_GCC_8150 || SM_GCC_8250 || SM_GCC_8350
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc
-	  SM8150 and SM8250 devices.
+	  SM8150/SM8250/SM8350 devices.
 	  Say Y if you want to support display devices and functionality such as
 	  splash screen.
 
diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
index db9379634fb2..39b344ebb049 100644
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
@@ -1270,6 +1275,62 @@ static int disp_cc_sm8250_probe(struct platform_device *pdev)
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
+		/*
+		 * note: trion == lucid, except for the prepare() op
+		 * only apply the offsets once (in case of deferred probe)
+		 */
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
+		disp_cc_pll0_config.config_ctl_hi1_val = 0x2a9a699c;
+		disp_cc_pll0_config.test_ctl_hi1_val = 0x01800000;
+		disp_cc_pll0_init.ops = &clk_alpha_pll_lucid_5lpe_ops;
+		disp_cc_pll0.vco_table = lucid_5lpe_vco;
+		disp_cc_pll1_config.config_ctl_hi1_val = 0x2a9a699c;
+		disp_cc_pll1_config.test_ctl_hi1_val = 0x01800000;
+		disp_cc_pll1_init.ops = &clk_alpha_pll_lucid_5lpe_ops;
+		disp_cc_pll1.vco_table = lucid_5lpe_vco;
 	}
 
 	clk_lucid_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
-- 
2.34.1

