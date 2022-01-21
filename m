Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECC94966E4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbiAUVEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiAUVD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:03:59 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19ADC06173B;
        Fri, 21 Jan 2022 13:03:58 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id o12so3328617eju.13;
        Fri, 21 Jan 2022 13:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uhs8yO3Tw+6wvqO+3KXCFZjOTAYX1wXl4HfqPcifPzU=;
        b=UgK2QxT8FAJo5/T3BnBuehFUGi7syDgsm7KABs7+SBvr/3UBDE/s2V59RtGvvH2F5G
         ZsQUftBD+h+bPchPTsj81fa9QGy96Y7kC2YdH2n7TbknX3eqUwkf6vr0kgrNNF9WQlgk
         HLqiHbddQt0ve9BxgxWVvBlxs2UKzeMNbv54OICOMdP/WWfjMODf288xlvEXwNqaUH3Q
         NfsZkWlVVUvlOWHASnWlsSNXxDjzz788B742PUCCSrFZMvpTL5FYJjFiusQ/LKLjYDlH
         KZoPov+AWMAvn2Q6QE5zETjrfvbBAIAHGFmSx6Qu0+/hw7xpeuXM0tyh1yyR3+szFTdk
         4DKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uhs8yO3Tw+6wvqO+3KXCFZjOTAYX1wXl4HfqPcifPzU=;
        b=sjGTYprIscfFh79CVKULpDTf4xafHz28SkhmPh2KrhKGjsuoncmjrF8dw7kC6juvVd
         Ldk9icRPpjHZa4ICyxPThJm3GbT23LApgw7C9dUMgl0YXmw4uQLpoT3qhkLH7WStJZ0Y
         eYypJyHIXB2b5wCcQqsFqZ4kb1XVfLk37EJLp6igS9roq9bJmg36AtLRavrdLlLz40Br
         nfvzSdJB1npOaE3rXknPQOZqlXbVPtDElKnXU3vwC6sX6b7oWIh8C/ctDKLORBcDAdKJ
         scODLXhUTvdNAcL6VmHlcR29VV+vqYQJYLrkxSF02LBqgDvY0Za4BXt/5ntI4O5QvVgY
         YuVQ==
X-Gm-Message-State: AOAM531QS9iOHFjDZEzVXCFELjwSoYovPmLBvkkKaUuGENlHY0yySGVK
        V4UKo7POxfCxzpAw19GSY1c=
X-Google-Smtp-Source: ABdhPJxJ+QayySQmraYxX7ss2mQNVNQLcLfOCWAAP1bx7/XJlgGFpMM2aT1OG+GaNq7+4UA65Vb/5Q==
X-Received: by 2002:a17:907:7e85:: with SMTP id qb5mr476450ejc.557.1642799037255;
        Fri, 21 Jan 2022 13:03:57 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id p23sm2898595edx.86.2022.01.21.13.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 13:03:56 -0800 (PST)
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
Subject: [PATCH v3 06/15] drivers: clk: qcom: gcc-ipq806x: use ARRAY_SIZE for num_parents
Date:   Fri, 21 Jan 2022 22:03:31 +0100
Message-Id: <20220121210340.32362-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220121210340.32362-1-ansuelsmth@gmail.com>
References: <20220121210340.32362-1-ansuelsmth@gmail.com>
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

