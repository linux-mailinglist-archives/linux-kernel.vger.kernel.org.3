Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2614956D2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 00:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378279AbiATXVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 18:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378164AbiATXUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 18:20:38 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F37C061574;
        Thu, 20 Jan 2022 15:20:38 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso25364609wmj.0;
        Thu, 20 Jan 2022 15:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wlPGztyCglYvRuLUlqRz5tHJBkS2fLA0AOcHKOEzeZA=;
        b=qylYzNHkxPlUCZCh/UUba7zSFTg0tlnPOJO65g/dz0P9jajbHoWX6w43gJsE281asm
         SHlhca2p6DJHrWk5By8jkDun3xAtZitvSzkjwBjzF8Fg5IDKmdTPsYb/Ed1j5uYweeIT
         0dEKGaYUIEYxM4aYVMtFev9HGLNlKFNMoRZWMV7Xjj8CrsC9zATVqBUeSjhb3/g9oGT1
         CXeSK6kBVxuZPbKn0Q7WPViSN0HcehWNihpbqOW5BNW+JRTOgEkzMq2nnSRTIpyZMK+M
         DWuKC51RuWaKApdLvhCtNeqcCBWjrm0gc7jwXDRzEPCzC2oweLv3dv5DGGdlmpS3eGvX
         kWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wlPGztyCglYvRuLUlqRz5tHJBkS2fLA0AOcHKOEzeZA=;
        b=eMPZnc5erEsIPT8uzfI3VdN8vra/EAD5C/8lu1GmlnR7waOqL00KQJRMoPhKwM/7XA
         KJtXeQULgnM15yE3z461nc+F+H4tHlvpGWxPVBZG3plp5P5JCw6TIw6ys4lQj5W/3U1e
         SqTmvJLpCLmEX38Qplsyyjuu4r6FctpNRe0b8ydy9dTtm8Cc8Rz6RK+OB5pnwDPMYtQD
         M1opLfgkSUm8R1R+s+AUmjwZfLThuaj8mFdQOfv/CgOLl9dgHY6PdJXeAqhoZX1cFw5W
         /n67v4OY9lFhnY8C9ppU1aZDh88EGf75H0faAmA3TVQZr4S/b01jzOc4DdDz3iiu8vHQ
         njuQ==
X-Gm-Message-State: AOAM531Hpd5UhO6yKzhQzNCgl9RA54rCPvUx8HvePjBPmEsQwcFcZ9E6
        9Y23ZXy7SF/rupNWfMd0bYQ=
X-Google-Smtp-Source: ABdhPJzRuoORYNNlpShJIX2//ljGG71KRPAB1iT6P6gM0Zw8uH63ph/DkBXUN6hwrO7tBtqokSx00A==
X-Received: by 2002:a05:600c:1e19:: with SMTP id ay25mr11141981wmb.131.1642720836631;
        Thu, 20 Jan 2022 15:20:36 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id a9sm3939283wmm.32.2022.01.20.15.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 15:20:36 -0800 (PST)
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
Subject: [PATCH v2 04/15] drivers: clk: qcom: gcc-ipq806x: fix wrong naming for gcc_pxo_pll8_pll0
Date:   Fri, 21 Jan 2022 00:20:17 +0100
Message-Id: <20220120232028.6738-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220120232028.6738-1-ansuelsmth@gmail.com>
References: <20220120232028.6738-1-ansuelsmth@gmail.com>
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

