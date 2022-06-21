Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF45553F07
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 01:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354786AbiFUXeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 19:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355282AbiFUXea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 19:34:30 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF59A30564
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 16:34:23 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d14so10928672pjs.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 16:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=y+LkzwE9CLPAwLU1RCIQwI5Aun5N4bi7E1YSzG64o8A=;
        b=Kx82lzO/JyrINRKp1QZWgmQTZ28bwgxOOqq6Eam0AFegRtGHCok+uGoNUiAg4EpIuT
         r0gUtZS7MsuVtZIdxHWUEKkoGBcncQimKxs3wgYyqAMQ6wCxKyoCQ1PJ2m02Tr1oWa09
         8ICPNsUbcD37jMIc3a8Gi9ui+CnT8CU/TEZzCTIlHOC3OAu1grAPARvL77fmPAGQFNM+
         5evaUd46/doZytb/acAzNyWXFFWvqmcQpdS2e7+6da0KL3ykzQbKr+6cVuRO5TJetyLU
         eL3GXucrUPLAv/WKAAWINcFKnH6IxnCEGWeiWmcqSY3KUPYu/zPO37ODx3WbjOedyEGx
         70xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y+LkzwE9CLPAwLU1RCIQwI5Aun5N4bi7E1YSzG64o8A=;
        b=W8/CBX2VylZYTQ+5u0ON3rIyFQ4IX/CHGBKGD/Cii1Bni3dvyFeFWPV6Zn39ajTas9
         6fQ6AIlR6KzuQXd9MVWmLxV4Kdo03Gmzfz4DbFPUOL+CKahHULeSMbtxvPlQJs7IZ2Wf
         Ph6sOx1abfP9luRbTRYOo+XShJiwO5LVv5cTIVUQPlkq8pUMNVN7wwQPuGjIcK8FyH+z
         9OefueZfVh/xpMeV+zQwWgXqfsmpff+dnd3gOcyGX3YxIgiEidi/O4cm1dZR7KzYpiLe
         yQjo0oHVFyYN2sqs7K/mt5jRVden5VXNbLYMqqF5FnbPpbZhX7I+aFpENb+s57LXFprB
         ZR9A==
X-Gm-Message-State: AJIora+DjWtVNdCBGISc2szr7SteKuvyXnJA/EoyhbfqMdI5SiDkzzac
        8aV24aRol3PYrl+uQ2SuOCopPQ==
X-Google-Smtp-Source: AGRyM1tHobCbs637ogg3rfCLhkpSbErP9PaiqgNf5BTWo6k0JKA3d8mQo40fvX/g1V+YC8EVzN072A==
X-Received: by 2002:a17:903:2452:b0:16a:38f9:ade9 with SMTP id l18-20020a170903245200b0016a38f9ade9mr5397376pls.152.1655854463080;
        Tue, 21 Jun 2022 16:34:23 -0700 (PDT)
Received: from prec5560.. (71-212-119-14.tukw.qwest.net. [71.212.119.14])
        by smtp.gmail.com with ESMTPSA id s7-20020a17090302c700b00168e83eda56sm11297873plk.3.2022.06.21.16.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 16:34:22 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, jonathan@marek.ca, robert.foss@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH v6 4/6] clk: qcom: add support for SM8350 DISPCC
Date:   Wed, 22 Jun 2022 01:34:10 +0200
Message-Id: <20220621233412.506768-5-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220621233412.506768-1-robert.foss@linaro.org>
References: <20220621233412.506768-1-robert.foss@linaro.org>
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


 drivers/clk/qcom/Kconfig         |  4 +--
 drivers/clk/qcom/dispcc-sm8250.c | 60 +++++++++++++++++++++++++++++++-
 2 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index b11235c21952..4c3d1a548b7a 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -618,11 +618,11 @@ config SM_DISPCC_6125
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
index db9379634fb2..4e101d584115 100644
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

