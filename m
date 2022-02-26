Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3124C5647
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 14:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiBZNx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 08:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbiBZNxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 08:53:19 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103585047F;
        Sat, 26 Feb 2022 05:52:44 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qk11so16179852ejb.2;
        Sat, 26 Feb 2022 05:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GGpCIJ6lk/vBaIH8esT2eK15+7D6NPSQQfExYoG7H7A=;
        b=XaYjIyfrmxE1HAx9Hjztd+09dv/fYmsg1LDZ3+vUhS0oquv8ulDjHs6aKnIJaNXfK0
         Kj8KnPEbmG0C0EiTY32ZpeQj6ViWi25y6EAOYB/jPrugRS2Ll1J6Dx7xkXvO3Z8oJ24g
         4QvrqzPSPu0lODjXRrqAdLSlbsHtX/HvoeiD+N8KOtcaaEfqUPpWHGavXaLXiqVa05K/
         QhHOl/31t/j0DRLMod+PtFdAw6zMuoIQZ6BtjBUmSeVdSPWjjfmKTjQ2BrB/Z931+eck
         dUmGahOXNiwSyXQmr6ORIEWiolk0fFPDjjtHfs+i5kT7oi/HvwaDcNxON+tnVJGlnmmG
         G//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GGpCIJ6lk/vBaIH8esT2eK15+7D6NPSQQfExYoG7H7A=;
        b=rYTRGxvW/jFl/JfdnVx3CFw6X2bVZjXphDbbX4qr1m7KOpScBasgSOTOr8nrpWDtsh
         TL1G46fjKXYeQPvwQw2UP1jdBqjbOGjutmk1EpmpFMRFcFl9817d0bhyesqd5QQa3FQ5
         SE5vx+T+xly1o+D3Jooz7praM34/SwDQwGDXhXekn4dGrlNvW5aY99L1tmuu4usxmjDK
         5w4CiPTnctzPlXez4VI4Yhp42U0U2ZjzelDPtq5Uc0T0dZNgTPMqPVMLQ8J/EnWx/mNh
         Jq7SGj5OPdpiqNZMkl73ZZ6SUqqDzhD6je/xWDw42CEFYzgG8GXzr4GKd8Au1AaEReAU
         IdSA==
X-Gm-Message-State: AOAM533uPkSzQ5/Ti/As49kZmfHCRX2iz8pTML0GaIlo6NFCO9Iij+oo
        MoC4fjB0qzk7+tAYPCVNSfI=
X-Google-Smtp-Source: ABdhPJwsSz/FzwpAyh4qTBbO9nGspOFXYEYDUGpjn4Nl9jQIncBXSVv2CgUq4phCoaDCF32qsrUk/w==
X-Received: by 2002:a17:906:3b4b:b0:6d3:4b9f:1764 with SMTP id h11-20020a1709063b4b00b006d34b9f1764mr9420323ejf.345.1645883562504;
        Sat, 26 Feb 2022 05:52:42 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-95-251-226-220.retail.telecomitalia.it. [95.251.226.220])
        by smtp.googlemail.com with ESMTPSA id j21-20020aa7c415000000b004127ac9ddc3sm2836369edq.50.2022.02.26.05.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 05:52:42 -0800 (PST)
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
Subject: [PATCH v6 04/15] clk: qcom: gcc-ipq806x: fix wrong naming for gcc_pxo_pll8_pll0
Date:   Sat, 26 Feb 2022 14:52:24 +0100
Message-Id: <20220226135235.10051-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220226135235.10051-1-ansuelsmth@gmail.com>
References: <20220226135235.10051-1-ansuelsmth@gmail.com>
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
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
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

