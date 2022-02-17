Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E025E4BADC4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiBQX5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:57:54 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiBQX5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:57:38 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE46443C1;
        Thu, 17 Feb 2022 15:57:10 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id p9so11627063wra.12;
        Thu, 17 Feb 2022 15:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=W8BNOZucFkBPvvAv1ueXGZQvgPgns0Vj1TM2XOG+J8o=;
        b=A1fE7aqqtAzASZhYL4bgoiFEf56d0YoZXOgwvq9UnGCtVuscneWzpyXTiuGykKm84s
         cWrgJsKdwbk7Dk6aJwcpLM81gh8fSajQrY2QA6UBGqQsesAjRbCARri8OPBvhs+abs89
         WRaUZjMII7bMww4w7LUlES4aExKtExA8LU9VEcSAl6k4BJMSdfxysVz6UPs30NTDJVWk
         21xAEaGDxE4s4vyr/Zf3QkjQB8bjVXt6L/B3cMrp/cOAC/gE16d1+zUNcb+cBYzHRTL+
         n4K4gDlyBzIrDKWTNhSOq+UPkKIL60wOivCJ842XWN9IyvnH5IuEHnUmKPZJkqnkVpW/
         GAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W8BNOZucFkBPvvAv1ueXGZQvgPgns0Vj1TM2XOG+J8o=;
        b=yfKLl2TN7gUYMc74kggKPl39EX6rrIkO5g9gGeviU5dIqoC/PpQDdXsF+hyzIAE4UV
         8zdv7CMcuMVsiJLWWwPZmRLTVtrqWaxABuIrZhPROLa60nLJZrYSCna+QgelnUtPkW7p
         9YdF++Kq+uC7PMCsPr0QhAPpIVJtcWSyVbq84nEKbg4i+joFIYTWxb9us3qEV7pvvAuh
         aLZ5Knn3KRQ07cLlqqplMnk80oNyMV0TL3Jv2pu6Mqc3FxzYJilv1m3bAEKYgKbQjlYl
         pI5caALCWvuYHVABfwt6jKlTi+Fk42J1xNde34yCPdfIh3TIfihQJ6Xo0RlJBq1zGT+P
         NsJQ==
X-Gm-Message-State: AOAM532YBruH5ts/FkHmWsfqxasz+pJLT4MMcqEf6Z9Y813JDDxqfCa7
        y3uLVS/cIiazrgdw14Wx43Y=
X-Google-Smtp-Source: ABdhPJyawQ8K+Jt2T3afGOf+yPUfLkji9MqjyAPaCmOYmTYE/BNXi0nIhu8/tA0kIgOD/PAeN4pvDQ==
X-Received: by 2002:adf:f6c3:0:b0:1e4:9b8f:8f72 with SMTP id y3-20020adff6c3000000b001e49b8f8f72mr4014887wrp.287.1645142229321;
        Thu, 17 Feb 2022 15:57:09 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id r2sm3691694wmq.24.2022.02.17.15.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:57:08 -0800 (PST)
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
Subject: [PATCH v4 06/16] clk: qcom: gcc-ipq806x: use ARRAY_SIZE for num_parents
Date:   Fri, 18 Feb 2022 00:56:53 +0100
Message-Id: <20220217235703.26641-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217235703.26641-1-ansuelsmth@gmail.com>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
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
2.34.1

