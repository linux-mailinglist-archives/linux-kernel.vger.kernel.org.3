Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A8D556F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 01:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377478AbiFVX3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 19:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377362AbiFVX3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 19:29:02 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245A1424B9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 16:29:01 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q140so17467601pgq.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 16:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kOuRlogJlISSUuhoPrdGlX4HtJb8KRIbCtQdJSjTJ80=;
        b=gVNgju02wyEdMONFSVTm5rM4W1+RuFdWkoOZov6Wn+B1tccRI1n6akQAmndPzLGuS1
         kojsGnjjFSrMsNNFVRWlcxrwr9x1HUtzIU/ZIP7WQwuFSq0sUFe4WB2g533MKbqjyobI
         K+jxjwQeDjy5+nPFNg7uQ+6vHGHKJGr5KQ0a7g4aZ9HcnnH9I9iL8jfyD8JHFiz0m2Pl
         8E7vviw7JjAYPTZqBGsDM301l2S2VpmERYQDyjoyngsqOhvaHHVLdN1TLqhjBIQuNpxS
         0P9JE72CUCQCjhwa3Acz4icRVgqc1lz06DGrmUVMb0rq7MJjd7E604tNJto8DiQRGgQn
         qp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kOuRlogJlISSUuhoPrdGlX4HtJb8KRIbCtQdJSjTJ80=;
        b=xGEYGOUo8dSZvHLpviB/E51uMMOr8JcJD1c7zMSP5pyjZMEaUegpyESFeab1CfoDEl
         dQ19k/eRZn/LfrZBUfIcJNM8Wn0wJIP65QF6YiarXjo/3L8zZLZXl7sa8j7fFnbSz+3L
         HITM3kqeUCO0ippPvmgky6C/oBh7y19BI3p1UdTmUZlZSFvugDkqUGK5CmvQBFyVOgjK
         jtCoBQkfv2hQiJ0yVO3UzXcIA3tdpA0yCSlP3jBRStu1ehsvcOAC4B7v9jgYR8NekPzY
         iTcu43ckcso8AmBbqdfbFKgBWmvuEjoyb16fmtQIBMIsALI27QR4hoiu+UTlFxxk+faE
         tBqQ==
X-Gm-Message-State: AJIora9nOXqZpkcQVEv6bNtQkbDjWdYnIImWA5L7+4K4ewncZVxjWq1o
        IlKpatTJQhBjhUOo28XW2YEL5g==
X-Google-Smtp-Source: AGRyM1ujMNgtP1ufAw+LiDAqmEI8zhGI22PKa61FiRsoqBCXTFpV6aDfOM4FmJ+ANFE3X121FZGbSQ==
X-Received: by 2002:a05:6a00:2402:b0:4e1:46ca:68bd with SMTP id z2-20020a056a00240200b004e146ca68bdmr37528941pfh.70.1655940540554;
        Wed, 22 Jun 2022 16:29:00 -0700 (PDT)
Received: from prec5560.. (71-212-119-14.tukw.qwest.net. [71.212.119.14])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f70200b001622c377c3esm13297863plo.117.2022.06.22.16.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 16:29:00 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, jonathan@marek.ca, robert.foss@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH v7 4/6] clk: qcom: add support for SM8350 DISPCC
Date:   Thu, 23 Jun 2022 01:28:44 +0200
Message-Id: <20220622232846.852771-5-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220622232846.852771-1-robert.foss@linaro.org>
References: <20220622232846.852771-1-robert.foss@linaro.org>
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
index b11235c21952..efdef8fbf008 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -618,11 +618,11 @@ config SM_DISPCC_6125
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

