Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789F84966E3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbiAUVEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbiAUVD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:03:57 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84134C06173B;
        Fri, 21 Jan 2022 13:03:56 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id h7so3334999ejf.1;
        Fri, 21 Jan 2022 13:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wlPGztyCglYvRuLUlqRz5tHJBkS2fLA0AOcHKOEzeZA=;
        b=kO9L+2eC1I0oghDo9M+AI4Ty+zRvDDB45BEGxFURP4cJzb4rX/sCPZMipC1ieQyzqx
         Nam6YIbiFqszfRv5HmQECY02+nqcM127crMuyMgNPry9EbD+lFcw+jCHNSDX4T0RVc7d
         i3fkYt6whAEkCj0TbBewOd37hGk8jsCPyJRa2nzSrKZC16Or23sgPbnkdqZGzO7DJY78
         +mAKGQqHf4oCrTho82N+bG3CFLQOxQuWbm/1QnLPzFEUs6gRwHaFdQYFtjVRO2tfDTbj
         o4s2cdQsuUBe6beeNoFUQBWqJPvmxVPRLDdt4EhNYci8Es6O5svEzzpvCPkHEAcVBpI9
         gadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wlPGztyCglYvRuLUlqRz5tHJBkS2fLA0AOcHKOEzeZA=;
        b=QQ7IHdkpZ/GN240aNDkRYA1ozoTasIE7fIk+nm2Xa04oo/T3JRPp1Go69rIlS4qNwe
         Dc/redxflQcMlxHNIYfTkGykSkR74TmfLEy6p8T+/dfKuUwWWrSQ9w3vVdW1nYxukNr8
         45/9mWX3NTb6FwrYCYwuyTB4kCo7VvZKeRmLzeHZJZur9upM9y5WnlyNoq6gCFXn4RCY
         v2Sw3awuWDrL74+A/SneKXgQAxCR7hfYWfsX4vVyrf4ayg1KTmfQ+ecsToesnSaFurTl
         b1LFxcAvb2PreGnDiy9yNgXQwlKxQgzB86/dSRh4qZZzXapXUBrxisRA0LWca0wl4u0C
         0eeg==
X-Gm-Message-State: AOAM530mGhptbynYbMXdKQido6SAI282R1I/NpnYDAb3lcm31GMA0g5v
        X1KbWdAj/+s5+KYofy8iDLs=
X-Google-Smtp-Source: ABdhPJwxLKEpRePK5ZrTzKAWqKvE1fRd4p6zb3Ne1cA740IzoDU4soui/JLBX90a2JY9wOkJPBCS9Q==
X-Received: by 2002:a17:906:49c4:: with SMTP id w4mr4574484ejv.745.1642799034933;
        Fri, 21 Jan 2022 13:03:54 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id p23sm2898595edx.86.2022.01.21.13.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 13:03:54 -0800 (PST)
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
Subject: [PATCH v3 04/15] drivers: clk: qcom: gcc-ipq806x: fix wrong naming for gcc_pxo_pll8_pll0
Date:   Fri, 21 Jan 2022 22:03:29 +0100
Message-Id: <20220121210340.32362-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220121210340.32362-1-ansuelsmth@gmail.com>
References: <20220121210340.32362-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.33.1

