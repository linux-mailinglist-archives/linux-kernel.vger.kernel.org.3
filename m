Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F964956DB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 00:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378316AbiATXVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 18:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378169AbiATXUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 18:20:40 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F08C061574;
        Thu, 20 Jan 2022 15:20:40 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id v123so14913297wme.2;
        Thu, 20 Jan 2022 15:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uhs8yO3Tw+6wvqO+3KXCFZjOTAYX1wXl4HfqPcifPzU=;
        b=CM6wh34zPpdPYKwnxRRmcdM+NEftIriBZKtAji8rZLzuMsUxvZgEx3/PMsPBAPXkew
         rqF1BYntNcmtvaY/Kxt1wxo626+4enA+wRBixfBykM7DIf2qK7YWWqj/qFChj1Wl6hGJ
         NxOFl7ODRBrF4HAJToLvXwf/MvvxBM9bzgsPevyQ+xs/k1OHSbHfs9rn2qoMzLW8HQJK
         4CblLT04pEUPLCal+fqOq8L3fSg6uPkRQxDgf8wpyIIoQum8T1FpYUvc/CD+H6uToo9Q
         n9zysv0JfUmooRvSJAMS1oJIW4/JLzEidpl49mJUZ4iwKoj2ISqnKCtWjOZZCwczE6Ss
         ab2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uhs8yO3Tw+6wvqO+3KXCFZjOTAYX1wXl4HfqPcifPzU=;
        b=texPi3dXgu8X5ZQMheDjkswcUuSEPuEiEheU13t3txKqG7rs0PqQnb/B4Zl9q6rk6f
         /tLIMZ6Ov/WyoUV/MZItMmn3zKHRqvwPOg/y2VDRSISc1AbWK9bKiXvVoa9xCmTenPhq
         Iexve4P8bT++t1ceGfacYNJRV9/P3sUQwkJmRrT21uMCczBjFziDQWxBcsC1KDzeVqvd
         xJEN8rSZHWdF6sausgg7kPUEjez5gAaE1oHVWdwYELoYqjQQGKylfWIHsqlBmdOiSQnI
         UV+FuSKxvYCnHiW6cYMBNwrtolQ1rfQ6Vszrxrb0N1endeIFc8rGqsj7+FWeIpFmF2Ma
         V3Sg==
X-Gm-Message-State: AOAM5314v7CGOBqjbtRw4/Ok0pumfcMgr5rqtaLAcR8EgBzBVlVGrfoB
        +bLELzLLPx2ZfKkLtZuTD60=
X-Google-Smtp-Source: ABdhPJw2gZbmybGx74zX8kNg2CJf/wovRVJezZ6yE/i0XqN1fs9d4EmeDtIB6oL28VA2kFUes2n0pA==
X-Received: by 2002:a05:600c:3847:: with SMTP id s7mr11497357wmr.101.1642720838861;
        Thu, 20 Jan 2022 15:20:38 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id a9sm3939283wmm.32.2022.01.20.15.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 15:20:38 -0800 (PST)
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
Subject: [PATCH v2 06/15] drivers: clk: qcom: gcc-ipq806x: use ARRAY_SIZE for num_parents
Date:   Fri, 21 Jan 2022 00:20:19 +0100
Message-Id: <20220120232028.6738-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220120232028.6738-1-ansuelsmth@gmail.com>
References: <20220120232028.6738-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ARRAY_SIZE for num_parents instead of hardcoding the value.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 68 +++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 828383c30322..f6db7247835e 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -373,7 +373,7 @@ static struct clk_rcg gsbi1_uart_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi1_uart_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -424,7 +424,7 @@ static struct clk_rcg gsbi2_uart_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi2_uart_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -475,7 +475,7 @@ static struct clk_rcg gsbi4_uart_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi4_uart_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -526,7 +526,7 @@ static struct clk_rcg gsbi5_uart_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi5_uart_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -577,7 +577,7 @@ static struct clk_rcg gsbi6_uart_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi6_uart_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -628,7 +628,7 @@ static struct clk_rcg gsbi7_uart_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi7_uart_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -692,7 +692,7 @@ static struct clk_rcg gsbi1_qup_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi1_qup_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -743,7 +743,7 @@ static struct clk_rcg gsbi2_qup_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi2_qup_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -794,7 +794,7 @@ static struct clk_rcg gsbi4_qup_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi4_qup_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -845,7 +845,7 @@ static struct clk_rcg gsbi5_qup_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi5_qup_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -896,7 +896,7 @@ static struct clk_rcg gsbi6_qup_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi6_qup_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -947,7 +947,7 @@ static struct clk_rcg gsbi7_qup_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi7_qup_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -1099,7 +1099,7 @@ static struct clk_rcg gp0_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gp0_src",
 			.parent_data = gcc_pxo_pll8_cxo,
-			.num_parents = 3,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_cxo),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -1150,7 +1150,7 @@ static struct clk_rcg gp1_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gp1_src",
 			.parent_data = gcc_pxo_pll8_cxo,
-			.num_parents = 3,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_cxo),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -1201,7 +1201,7 @@ static struct clk_rcg gp2_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gp2_src",
 			.parent_data = gcc_pxo_pll8_cxo,
-			.num_parents = 3,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_cxo),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -1257,7 +1257,7 @@ static struct clk_rcg prng_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "prng_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 		},
 	},
@@ -1321,7 +1321,7 @@ static struct clk_rcg sdc1_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "sdc1_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 		},
 	}
@@ -1371,7 +1371,7 @@ static struct clk_rcg sdc3_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "sdc3_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 		},
 	}
@@ -1456,7 +1456,7 @@ static struct clk_rcg tsif_ref_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "tsif_ref_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 		},
 	}
@@ -1620,7 +1620,7 @@ static struct clk_rcg pcie_ref_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "pcie_ref_src",
 			.parent_data = gcc_pxo_pll3,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll3),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -1714,7 +1714,7 @@ static struct clk_rcg pcie1_ref_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "pcie1_ref_src",
 			.parent_data = gcc_pxo_pll3,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll3),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -1808,7 +1808,7 @@ static struct clk_rcg pcie2_ref_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "pcie2_ref_src",
 			.parent_data = gcc_pxo_pll3,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll3),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -1907,7 +1907,7 @@ static struct clk_rcg sata_ref_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "sata_ref_src",
 			.parent_data = gcc_pxo_pll3,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll3),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -2048,7 +2048,7 @@ static struct clk_rcg usb30_master_clk_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "usb30_master_ref_src",
 			.parent_data = gcc_pxo_pll8_pll0,
-			.num_parents = 3,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll0),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -2122,7 +2122,7 @@ static struct clk_rcg usb30_utmi_clk = {
 		.hw.init = &(struct clk_init_data){
 			.name = "usb30_utmi_clk",
 			.parent_data = gcc_pxo_pll8_pll0,
-			.num_parents = 3,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll0),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -2196,7 +2196,7 @@ static struct clk_rcg usb_hs1_xcvr_clk_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "usb_hs1_xcvr_src",
 			.parent_data = gcc_pxo_pll8_pll0,
-			.num_parents = 3,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll0),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -2262,7 +2262,7 @@ static struct clk_rcg usb_fs1_xcvr_clk_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "usb_fs1_xcvr_src",
 			.parent_data = gcc_pxo_pll8_pll0,
-			.num_parents = 3,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll0),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -2398,7 +2398,7 @@ static struct clk_dyn_rcg gmac_core1_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core1_src",
 			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
-			.num_parents = 5,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll14_pll18_pll0),
 			.ops = &clk_dyn_rcg_ops,
 		},
 	},
@@ -2470,7 +2470,7 @@ static struct clk_dyn_rcg gmac_core2_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core2_src",
 			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
-			.num_parents = 5,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll14_pll18_pll0),
 			.ops = &clk_dyn_rcg_ops,
 		},
 	},
@@ -2542,7 +2542,7 @@ static struct clk_dyn_rcg gmac_core3_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core3_src",
 			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
-			.num_parents = 5,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll14_pll18_pll0),
 			.ops = &clk_dyn_rcg_ops,
 		},
 	},
@@ -2614,7 +2614,7 @@ static struct clk_dyn_rcg gmac_core4_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core4_src",
 			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
-			.num_parents = 5,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll14_pll18_pll0),
 			.ops = &clk_dyn_rcg_ops,
 		},
 	},
@@ -2674,7 +2674,7 @@ static struct clk_dyn_rcg nss_tcm_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "nss_tcm_src",
 			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
-			.num_parents = 5,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll14_pll18_pll0),
 			.ops = &clk_dyn_rcg_ops,
 		},
 	},
@@ -2752,7 +2752,7 @@ static struct clk_dyn_rcg ubi32_core1_src_clk = {
 		.hw.init = &(struct clk_init_data){
 			.name = "ubi32_core1_src_clk",
 			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
-			.num_parents = 5,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll14_pll18_pll0),
 			.ops = &clk_dyn_rcg_ops,
 			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
 		},
@@ -2805,7 +2805,7 @@ static struct clk_dyn_rcg ubi32_core2_src_clk = {
 		.hw.init = &(struct clk_init_data){
 			.name = "ubi32_core2_src_clk",
 			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
-			.num_parents = 5,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll14_pll18_pll0),
 			.ops = &clk_dyn_rcg_ops,
 			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
 		},
-- 
2.33.1

