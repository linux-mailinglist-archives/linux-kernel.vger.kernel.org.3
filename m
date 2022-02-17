Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623614BADFC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiBQX5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:57:39 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiBQX50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:57:26 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2626419BE;
        Thu, 17 Feb 2022 15:57:08 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id x5so6814085wrg.13;
        Thu, 17 Feb 2022 15:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=u469mMf11FmBaVlEEJAE/kqasFIogYLGPGt/lzpdIA8=;
        b=lPHwNX27fK0/ySI3rIP5nQfAaPbHlv+g461yKHUe+HA+mMp3xXqJnvr+h4B6xCXHx/
         gxCe/RdAo+t7eeqW/KC/XgmJsUz2GuSlygfO7EHMJbA0LX4jTn0q+ZFkMv4JWLHaqiXr
         Z7KPsVD7X3uxq/2fKqUB93KFPvAi7jRh7tBZov2TWM/z6A9gRC7yp3KLVy8JaaHneQi+
         V7PgDkkB24nUPecdWbOPkjMVb585ZhSRnKuWBJrkZ1oZXGWD2p56XySlDRNV+fxYPdDt
         kqY64hDYPmxXd7l1vF8Lqoc3/vWZSVgXt6GWoyToLNSDyr6+ut7Dlrdoe1dhQY2ygfog
         MANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u469mMf11FmBaVlEEJAE/kqasFIogYLGPGt/lzpdIA8=;
        b=4lTS9WZ8zhKAdm2ppNSTr2Xf/NiZhVMKdgrZtw6LpuwwRDdH9hrlPfrHhpfmSKd3fS
         uhQdJBvR0qxDN3jHwGUv9pDKyKvK+WYi2Kn/Nu8T3sGjxGdAk91TWf3m+YzkOb8EniZX
         oyCyoL8LX/C8AW4x7DVQujY7OlwX39SvXe8B/YvP/K8AajGjruNLp4yf96lF2MmKDkj6
         g1NssvbD0y8JkdWoQTd0pt30rWHy4YKG6yMPccMODYDYDecfDcU07MxKZe0WYs8dwEST
         Lccikg6ChVW8n06s3DLjJoMbzczYegx/xRLZVsRM9i/I6APzUY4X4rpx3dL0jfk2lkw9
         iT+g==
X-Gm-Message-State: AOAM5327ce6d/iQncF1ILRaQcCI3N01ZBjRRLSqhz5OUgq16TFiD26on
        cDBMY69Zef0dzclL/uSje18=
X-Google-Smtp-Source: ABdhPJyNcfglwasHkAu3TJQYc4r3TaWDjYyuIhyW/xOuFnBdIFtb0sEMFPRiYltiX0dbdQidnTm3Iw==
X-Received: by 2002:a5d:4534:0:b0:1e4:9d38:2d4f with SMTP id j20-20020a5d4534000000b001e49d382d4fmr4147985wra.2.1645142227291;
        Thu, 17 Feb 2022 15:57:07 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id r2sm3691694wmq.24.2022.02.17.15.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:57:06 -0800 (PST)
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
Subject: [PATCH v4 04/16] clk: qcom: gcc-ipq806x: fix wrong naming for gcc_pxo_pll8_pll0
Date:   Fri, 18 Feb 2022 00:56:51 +0100
Message-Id: <20220217235703.26641-5-ansuelsmth@gmail.com>
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

Parent gcc_pxo_pll8_pll0 had the parent definition and parent map
swapped. Fix this naming error.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index d6b7adb4be38..34cddf461dba 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -291,13 +291,13 @@ static const char * const gcc_pxo_pll3[] = {
 	"pll3",
 };
 
-static const struct parent_map gcc_pxo_pll8_pll0[] = {
+static const struct parent_map gcc_pxo_pll8_pll0_map[] = {
 	{ P_PXO, 0 },
 	{ P_PLL8, 3 },
 	{ P_PLL0, 2 }
 };
 
-static const char * const gcc_pxo_pll8_pll0_map[] = {
+static const char * const gcc_pxo_pll8_pll0[] = {
 	"pxo",
 	"pll8_vote",
 	"pll0_vote",
@@ -1993,7 +1993,7 @@ static struct clk_rcg usb30_master_clk_src = {
 	},
 	.s = {
 		.src_sel_shift = 0,
-		.parent_map = gcc_pxo_pll8_pll0,
+		.parent_map = gcc_pxo_pll8_pll0_map,
 	},
 	.freq_tbl = clk_tbl_usb30_master,
 	.clkr = {
@@ -2001,7 +2001,7 @@ static struct clk_rcg usb30_master_clk_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "usb30_master_ref_src",
-			.parent_names = gcc_pxo_pll8_pll0_map,
+			.parent_names = gcc_pxo_pll8_pll0,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
@@ -2063,7 +2063,7 @@ static struct clk_rcg usb30_utmi_clk = {
 	},
 	.s = {
 		.src_sel_shift = 0,
-		.parent_map = gcc_pxo_pll8_pll0,
+		.parent_map = gcc_pxo_pll8_pll0_map,
 	},
 	.freq_tbl = clk_tbl_usb30_utmi,
 	.clkr = {
@@ -2071,7 +2071,7 @@ static struct clk_rcg usb30_utmi_clk = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "usb30_utmi_clk",
-			.parent_names = gcc_pxo_pll8_pll0_map,
+			.parent_names = gcc_pxo_pll8_pll0,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
@@ -2133,7 +2133,7 @@ static struct clk_rcg usb_hs1_xcvr_clk_src = {
 	},
 	.s = {
 		.src_sel_shift = 0,
-		.parent_map = gcc_pxo_pll8_pll0,
+		.parent_map = gcc_pxo_pll8_pll0_map,
 	},
 	.freq_tbl = clk_tbl_usb,
 	.clkr = {
@@ -2141,7 +2141,7 @@ static struct clk_rcg usb_hs1_xcvr_clk_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "usb_hs1_xcvr_src",
-			.parent_names = gcc_pxo_pll8_pll0_map,
+			.parent_names = gcc_pxo_pll8_pll0,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
@@ -2197,7 +2197,7 @@ static struct clk_rcg usb_fs1_xcvr_clk_src = {
 	},
 	.s = {
 		.src_sel_shift = 0,
-		.parent_map = gcc_pxo_pll8_pll0,
+		.parent_map = gcc_pxo_pll8_pll0_map,
 	},
 	.freq_tbl = clk_tbl_usb,
 	.clkr = {
@@ -2205,7 +2205,7 @@ static struct clk_rcg usb_fs1_xcvr_clk_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "usb_fs1_xcvr_src",
-			.parent_names = gcc_pxo_pll8_pll0_map,
+			.parent_names = gcc_pxo_pll8_pll0,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
-- 
2.34.1

