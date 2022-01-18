Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED063491339
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244055AbiARBCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243872AbiARBB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:01:58 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC86C061574;
        Mon, 17 Jan 2022 17:01:57 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z22so72642880edd.12;
        Mon, 17 Jan 2022 17:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TmJxjyQbdETgs4yns2i+f8c1louW3ocpGtGrolnd4As=;
        b=UUKoYPEp0/3gidXvwZTyUsow4ZYvhJpsHNle8L21BPIW2LapS9al/QD6FBlJnUecYc
         hjlVI0A5XjIsk/iCrQbxYrva1YUbjGgWrVYS8ZZN7KbrcHYnUrNvLLQIN3JXjjcA3Dp6
         PSF8+2nL59Dsy050DAiG8kypCZq/p+EfblA3Zyy7lj1/IIqP72bKAaeHa3OAsCBTUVPG
         XJmmRGADw7O4SzhWqyoEb/VObvOOeN3DRVBM8aKqdDpuWdR6d1x9Imo0ZPKC0InD1CvE
         ZU2YnixZd/0b5LpiEbtZiKdQZ58ROApQ6lqwU3wW3YU88BesDOYkAmy8iY7kG0wJ4uy6
         WFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TmJxjyQbdETgs4yns2i+f8c1louW3ocpGtGrolnd4As=;
        b=ox0QkNTdHnUKIRnhGvHKauUVUaEkN30lDz75Id8SZuLf+R3YoB6uqjrkMR6qbOvlXr
         RsfByp0aZYwxqaCXAHP1ZiCj1+k8oHw4/qT3iGY+OvSfnuDHj8TDjhkdQOkckKURlfas
         XW8es4/xtfsIYZI1Wx0Fk8P0os8lueYyWWpjGnXG3PP3AOkdZfeBrYxPI4m2qCyLen0w
         M4IiEmYMHcjboPLarq+OO2HSHRU4l4vTcqJHTqSssovX13EVxAVaYzlnb6FhoHNkHYNg
         sx03UJYbscOpuBns5HZvj7SIqUg32ILuCYrOERqgfNKxcqHWT+WUZLFPXxRkRbhZ8hfj
         YRxQ==
X-Gm-Message-State: AOAM533EgXvluqtYQ4s/daoo+KzxvRG+Zl8wnb/A/6zPaKV07btNGksH
        cqd0HMcBG0vWg9RuH8MF0nSxMUl6uAI=
X-Google-Smtp-Source: ABdhPJy5f5rLvfUTaUbsS3+CtIMri47cAtZl+y8SWGZVfVXVq4BZZJ854XmQCwiOy8pV02UmgRHzug==
X-Received: by 2002:a17:906:1e4f:: with SMTP id i15mr19605736ejj.522.1642467716046;
        Mon, 17 Jan 2022 17:01:56 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id 24sm4892127ejg.47.2022.01.17.17.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:01:55 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/14] drivers: clk: qcom: gcc-ipq806x: use ARRAY_SIZE for num_parents
Date:   Tue, 18 Jan 2022 01:44:24 +0100
Message-Id: <20220118004434.17095-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118004434.17095-1-ansuelsmth@gmail.com>
References: <20220118004434.17095-1-ansuelsmth@gmail.com>
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
index cbacd56f52d4..17ce61f36b08 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -385,7 +385,7 @@ static struct clk_rcg gsbi1_uart_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi1_uart_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -436,7 +436,7 @@ static struct clk_rcg gsbi2_uart_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi2_uart_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -487,7 +487,7 @@ static struct clk_rcg gsbi4_uart_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi4_uart_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -538,7 +538,7 @@ static struct clk_rcg gsbi5_uart_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi5_uart_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -589,7 +589,7 @@ static struct clk_rcg gsbi6_uart_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi6_uart_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -640,7 +640,7 @@ static struct clk_rcg gsbi7_uart_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi7_uart_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -704,7 +704,7 @@ static struct clk_rcg gsbi1_qup_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi1_qup_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -755,7 +755,7 @@ static struct clk_rcg gsbi2_qup_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi2_qup_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -806,7 +806,7 @@ static struct clk_rcg gsbi4_qup_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi4_qup_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -857,7 +857,7 @@ static struct clk_rcg gsbi5_qup_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi5_qup_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -908,7 +908,7 @@ static struct clk_rcg gsbi6_qup_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi6_qup_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -959,7 +959,7 @@ static struct clk_rcg gsbi7_qup_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi7_qup_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -1111,7 +1111,7 @@ static struct clk_rcg gp0_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gp0_src",
 			.parent_data = gcc_pxo_pll8_cxo,
-			.num_parents = 3,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_cxo),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
 		},
@@ -1162,7 +1162,7 @@ static struct clk_rcg gp1_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gp1_src",
 			.parent_data = gcc_pxo_pll8_cxo,
-			.num_parents = 3,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_cxo),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -1213,7 +1213,7 @@ static struct clk_rcg gp2_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gp2_src",
 			.parent_data = gcc_pxo_pll8_cxo,
-			.num_parents = 3,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_cxo),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -1269,7 +1269,7 @@ static struct clk_rcg prng_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "prng_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 		},
 	},
@@ -1333,7 +1333,7 @@ static struct clk_rcg sdc1_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "sdc1_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 		},
 	}
@@ -1383,7 +1383,7 @@ static struct clk_rcg sdc3_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "sdc3_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 		},
 	}
@@ -1468,7 +1468,7 @@ static struct clk_rcg tsif_ref_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "tsif_ref_src",
 			.parent_data = gcc_pxo_pll8,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
 		},
 	}
@@ -1632,7 +1632,7 @@ static struct clk_rcg pcie_ref_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "pcie_ref_src",
 			.parent_data = gcc_pxo_pll3,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll3),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -1726,7 +1726,7 @@ static struct clk_rcg pcie1_ref_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "pcie1_ref_src",
 			.parent_data = gcc_pxo_pll3,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll3),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -1820,7 +1820,7 @@ static struct clk_rcg pcie2_ref_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "pcie2_ref_src",
 			.parent_data = gcc_pxo_pll3,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll3),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -1919,7 +1919,7 @@ static struct clk_rcg sata_ref_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "sata_ref_src",
 			.parent_data = gcc_pxo_pll3,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll3),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -2062,7 +2062,7 @@ static struct clk_rcg usb30_master_clk_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "usb30_master_ref_src",
 			.parent_data = gcc_pxo_pll8_pll0,
-			.num_parents = 3,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll0),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -2136,7 +2136,7 @@ static struct clk_rcg usb30_utmi_clk = {
 		.hw.init = &(struct clk_init_data){
 			.name = "usb30_utmi_clk",
 			.parent_data = gcc_pxo_pll8_pll0,
-			.num_parents = 3,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll0),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -2210,7 +2210,7 @@ static struct clk_rcg usb_hs1_xcvr_clk_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "usb_hs1_xcvr_src",
 			.parent_data = gcc_pxo_pll8_pll0,
-			.num_parents = 3,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll0),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -2276,7 +2276,7 @@ static struct clk_rcg usb_fs1_xcvr_clk_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "usb_fs1_xcvr_src",
 			.parent_data = gcc_pxo_pll8_pll0,
-			.num_parents = 3,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll0),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -2412,7 +2412,7 @@ static struct clk_dyn_rcg gmac_core1_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core1_src",
 			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
-			.num_parents = 5,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll14_pll18_pll0),
 			.ops = &clk_dyn_rcg_ops,
 		},
 	},
@@ -2484,7 +2484,7 @@ static struct clk_dyn_rcg gmac_core2_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core2_src",
 			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
-			.num_parents = 5,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll14_pll18_pll0),
 			.ops = &clk_dyn_rcg_ops,
 		},
 	},
@@ -2556,7 +2556,7 @@ static struct clk_dyn_rcg gmac_core3_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core3_src",
 			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
-			.num_parents = 5,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll14_pll18_pll0),
 			.ops = &clk_dyn_rcg_ops,
 		},
 	},
@@ -2628,7 +2628,7 @@ static struct clk_dyn_rcg gmac_core4_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core4_src",
 			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
-			.num_parents = 5,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll14_pll18_pll0),
 			.ops = &clk_dyn_rcg_ops,
 		},
 	},
@@ -2688,7 +2688,7 @@ static struct clk_dyn_rcg nss_tcm_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "nss_tcm_src",
 			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
-			.num_parents = 5,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll14_pll18_pll0),
 			.ops = &clk_dyn_rcg_ops,
 		},
 	},
@@ -2766,7 +2766,7 @@ static struct clk_dyn_rcg ubi32_core1_src_clk = {
 		.hw.init = &(struct clk_init_data){
 			.name = "ubi32_core1_src_clk",
 			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
-			.num_parents = 5,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll14_pll18_pll0),
 			.ops = &clk_dyn_rcg_ops,
 			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
 		},
@@ -2819,7 +2819,7 @@ static struct clk_dyn_rcg ubi32_core2_src_clk = {
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

