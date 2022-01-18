Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC2049131C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243930AbiARBCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238683AbiARBBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:01:55 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E36C061574;
        Mon, 17 Jan 2022 17:01:55 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id q25so72652355edb.2;
        Mon, 17 Jan 2022 17:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wlPGztyCglYvRuLUlqRz5tHJBkS2fLA0AOcHKOEzeZA=;
        b=Tg5/HL6RuF0u+pFSo8jDHr92zFaEckK5slFfbo/rjYssifQc4WCkWQAI74QeC3kyCJ
         tz7d2QiqQUYgJvP59Xn8s1+xp5N/iLyXZqLpqa5F//IwwElr5g3zunEK7VJio9kFc+aE
         q2s6HVdx0U8ouT7L/m8gWS36vQGMMPgIK7W7hVLCzJdZiFYoG3xHkI/sEajqtGUmxBUC
         4USoyH6455GDleXLcnDRUyX+wBU/usE2sXynmAXmdBL3H2s/dXE4c77/QuBW7jdVeqCw
         OEwOIzvGgul71yQj7YH6JhM/DWnSLgzijr9kRBIYTCP/KRtmt14rRmCmCcPJVZHnfp71
         Q+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wlPGztyCglYvRuLUlqRz5tHJBkS2fLA0AOcHKOEzeZA=;
        b=GpbAaKOQdkw4sAQ0TF6RGZczeneIYbFgPGBaG9JBk99Ws/Wox3OeMFcJwYvYveXy61
         yrr0EtdrAlYj5zuU7fuyHuNBgzAdQMtyuR3X2MhpEYZh2ym1Z84Ie2v+m0BFSgZS01tg
         WQ+riAVNA3XO34U+VdTx+TZYen4cx1LocbCc5JuU1e6NfSgHV/6dJ4sR6tCbVfzYwVu5
         dhFuE4Pbk0HadluUTEZKDj/+hGY7YyYhEvT3UCT1LzQA9SkNICZ5VN4tC+M9nYhKPc0n
         OE9XMn7P+X2kLX4Klq2Qb4T0e1fard2NemDvgrn0huZR2hxf9RBMrPWIL2hCz0MgCe3U
         CxKg==
X-Gm-Message-State: AOAM533F9BVLsZ9qMMCF8rzTfmpd5zxi0p0GLEsgGzZ2WisH84cutL0m
        B9dNvsYMmDYAG9ZsuOgAOVNM/EKVG0w=
X-Google-Smtp-Source: ABdhPJwhHv1mJNexDLPa1Tz9S1m32K+gy7UG3OJlmciHbMZcUHiclw9c49rRU7mHOqe42QUcFJgrgg==
X-Received: by 2002:a17:907:2da3:: with SMTP id gt35mr18833052ejc.493.1642467713880;
        Mon, 17 Jan 2022 17:01:53 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id 24sm4892127ejg.47.2022.01.17.17.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:01:53 -0800 (PST)
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
Subject: [PATCH 02/14] drivers: clk: qcom: gcc-ipq806x: fix wrong naming for gcc_pxo_pll8_pll0
Date:   Tue, 18 Jan 2022 01:44:22 +0100
Message-Id: <20220118004434.17095-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118004434.17095-1-ansuelsmth@gmail.com>
References: <20220118004434.17095-1-ansuelsmth@gmail.com>
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

