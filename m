Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D744C31F9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiBXQtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiBXQtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:49:25 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD191B3083;
        Thu, 24 Feb 2022 08:48:47 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id y5so239492wmi.0;
        Thu, 24 Feb 2022 08:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=E6v+WweN+XX8zOwZWKbcf1APJlUMI4b9QbNs4mxk2pE=;
        b=MqlGGg8yMQo04sBA8Mh88KAnHHtbYtYhPhi0xzCmRj9orhMEYbnocRIPumRxx0ajdk
         cFal2289NAQEjc67DnAItjapURl/+wE5ZDd81VdwUiqgjHvcBBYEGXjtbOCTSAFX492o
         R/MAi77GPkWwgTB7YBpXAHW8U8dEFo6p2yRHXbqFUogBGfV5ScVM+25azJbNO8V6UKT7
         D7+oPnZrCL0s4DWBDq9zn5/vZm1V3EANruJt9jeuK/uvSJ14mVSoQCz27ZsoqINwmN/I
         QkfqA6691Kkd86iJdNKtW4zV84ZSBRzC3IEDdrsyFhoFe4iuv2U7qCBQS47OMnoYK01h
         1GMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E6v+WweN+XX8zOwZWKbcf1APJlUMI4b9QbNs4mxk2pE=;
        b=Y0x/y5AEqPrGvZ3tey3kuF6I84oNu8jDPDLVbqxw5ByT6impjMm7zH5H/I6fyh0XLy
         PNnT+lgdb+gtOP20eHw6Bxnam2MjaXvn7j47znp9OYaMRzGPn8nmdHdG1TjDvfsiEzZT
         rYhAkfVG7elp3rbabjP9/Mn1GLvLaQQBVLbLZVuyGOfQYts5nEh/Y0booCa31SKgfu7l
         Xi4rkBLXoD10E3AThIfkwaWNKBsCMYUKxDGrjn26UQV+nbOiM09Tac01E042ZIVbKuLP
         Lj0ZoJ12ipibK7I4626HrEHMysylAUf2K2zB+3GhBtvgqmU/FLtyhDx3YeLCw5vP1AyK
         eR6w==
X-Gm-Message-State: AOAM533xnLkpxpaMi6f4QFPXVnF1QfpVuclEOuDtg8HgIYkDpfaTkmxa
        R+mssfNNWit6YQVktSWvC1k=
X-Google-Smtp-Source: ABdhPJxNpkEhdCs3sPux42QDVbS/WX6lVnIMFXDDHHYLi7lo93OG9g2af8njy6hJ/6X4tMKwJBzwQA==
X-Received: by 2002:a7b:c94e:0:b0:37b:ea2f:788c with SMTP id i14-20020a7bc94e000000b0037bea2f788cmr3091525wml.14.1645721326233;
        Thu, 24 Feb 2022 08:48:46 -0800 (PST)
Received: from Ansuel-xps.localdomain ([5.170.140.187])
        by smtp.googlemail.com with ESMTPSA id k18sm2694095wrp.104.2022.02.24.08.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:48:45 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/15] clk: qcom: gcc-ipq806x: use ARRAY_SIZE for num_parents
Date:   Thu, 24 Feb 2022 17:48:22 +0100
Message-Id: <20220224164831.21475-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224164831.21475-1-ansuelsmth@gmail.com>
References: <20220224164831.21475-1-ansuelsmth@gmail.com>
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

Use ARRAY_SIZE for num_parents instead of hardcoding the value.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/clk/qcom/gcc-ipq806x.c | 68 +++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index f18888454b4f..3a9001830f0c 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -380,7 +380,7 @@ static struct clk_rcg gsbi1_uart_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi1_uart_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -431,7 +431,7 @@ static struct clk_rcg gsbi2_uart_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi2_uart_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -482,7 +482,7 @@ static struct clk_rcg gsbi4_uart_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi4_uart_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -533,7 +533,7 @@ static struct clk_rcg gsbi5_uart_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi5_uart_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -584,7 +584,7 @@ static struct clk_rcg gsbi6_uart_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi6_uart_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -635,7 +635,7 @@ static struct clk_rcg gsbi7_uart_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi7_uart_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -699,7 +699,7 @@ static struct clk_rcg gsbi1_qup_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi1_qup_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -750,7 +750,7 @@ static struct clk_rcg gsbi2_qup_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi2_qup_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -801,7 +801,7 @@ static struct clk_rcg gsbi4_qup_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi4_qup_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -852,7 +852,7 @@ static struct clk_rcg gsbi5_qup_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi5_qup_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -903,7 +903,7 @@ static struct clk_rcg gsbi6_qup_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi6_qup_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -954,7 +954,7 @@ static struct clk_rcg gsbi7_qup_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi7_qup_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -1106,7 +1106,7 @@ static struct clk_rcg gp0_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gp0_src",
 			.parent_data = gcc_pxo_pll8_cxo,
-			.num_parents = 3,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_cxo),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -1157,7 +1157,7 @@ static struct clk_rcg gp1_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gp1_src",
 			.parent_data = gcc_pxo_pll8_cxo,
-			.num_parents = 3,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_cxo),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -1208,7 +1208,7 @@ static struct clk_rcg gp2_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gp2_src",
 			.parent_data = gcc_pxo_pll8_cxo,
-			.num_parents = 3,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_cxo),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -1264,7 +1264,7 @@ static struct clk_rcg prng_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "prng_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 		},
 	},
@@ -1328,7 +1328,7 @@ static struct clk_rcg sdc1_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "sdc1_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 		},
 	}
@@ -1378,7 +1378,7 @@ static struct clk_rcg sdc3_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "sdc3_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 		},
 	}
@@ -1463,7 +1463,7 @@ static struct clk_rcg tsif_ref_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "tsif_ref_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 		},
 	}
@@ -1627,7 +1627,7 @@ static struct clk_rcg pcie_ref_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "pcie_ref_src",
 			.parent_data = gcc_pxo_pll3,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll3),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -1721,7 +1721,7 @@ static struct clk_rcg pcie1_ref_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "pcie1_ref_src",
 			.parent_data = gcc_pxo_pll3,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll3),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -1815,7 +1815,7 @@ static struct clk_rcg pcie2_ref_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "pcie2_ref_src",
 			.parent_data = gcc_pxo_pll3,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll3),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -1914,7 +1914,7 @@ static struct clk_rcg sata_ref_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "sata_ref_src",
 			.parent_data = gcc_pxo_pll3,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll3),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -2055,7 +2055,7 @@ static struct clk_rcg usb30_master_clk_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "usb30_master_ref_src",
 			.parent_data = gcc_pxo_pll8_pll0,
-			.num_parents = 3,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll0),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -2129,7 +2129,7 @@ static struct clk_rcg usb30_utmi_clk = {
 		.hw.init = &(struct clk_init_data){
 			.name = "usb30_utmi_clk",
 			.parent_data = gcc_pxo_pll8_pll0,
-			.num_parents = 3,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll0),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -2203,7 +2203,7 @@ static struct clk_rcg usb_hs1_xcvr_clk_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "usb_hs1_xcvr_src",
 			.parent_data = gcc_pxo_pll8_pll0,
-			.num_parents = 3,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll0),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -2269,7 +2269,7 @@ static struct clk_rcg usb_fs1_xcvr_clk_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "usb_fs1_xcvr_src",
 			.parent_data = gcc_pxo_pll8_pll0,
-			.num_parents = 3,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll0),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -2405,7 +2405,7 @@ static struct clk_dyn_rcg gmac_core1_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core1_src",
 			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
-			.num_parents = 5,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll14_pll18_pll0),
 			.ops = &clk_dyn_rcg_ops,
 		},
 	},
@@ -2477,7 +2477,7 @@ static struct clk_dyn_rcg gmac_core2_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core2_src",
 			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
-			.num_parents = 5,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll14_pll18_pll0),
 			.ops = &clk_dyn_rcg_ops,
 		},
 	},
@@ -2549,7 +2549,7 @@ static struct clk_dyn_rcg gmac_core3_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core3_src",
 			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
-			.num_parents = 5,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll14_pll18_pll0),
 			.ops = &clk_dyn_rcg_ops,
 		},
 	},
@@ -2621,7 +2621,7 @@ static struct clk_dyn_rcg gmac_core4_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core4_src",
 			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
-			.num_parents = 5,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll14_pll18_pll0),
 			.ops = &clk_dyn_rcg_ops,
 		},
 	},
@@ -2681,7 +2681,7 @@ static struct clk_dyn_rcg nss_tcm_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "nss_tcm_src",
 			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
-			.num_parents = 5,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll14_pll18_pll0),
 			.ops = &clk_dyn_rcg_ops,
 		},
 	},
@@ -2759,7 +2759,7 @@ static struct clk_dyn_rcg ubi32_core1_src_clk = {
 		.hw.init = &(struct clk_init_data){
 			.name = "ubi32_core1_src_clk",
 			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
-			.num_parents = 5,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll14_pll18_pll0),
 			.ops = &clk_dyn_rcg_ops,
 			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
 		},
@@ -2812,7 +2812,7 @@ static struct clk_dyn_rcg ubi32_core2_src_clk = {
 		.hw.init = &(struct clk_init_data){
 			.name = "ubi32_core2_src_clk",
 			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
-			.num_parents = 5,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll14_pll18_pll0),
 			.ops = &clk_dyn_rcg_ops,
 			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
 		},
-- 
2.34.1

