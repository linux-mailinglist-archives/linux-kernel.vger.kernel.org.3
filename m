Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC355537E1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbiFUQd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353036AbiFUQdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:33:52 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E449A140A1;
        Tue, 21 Jun 2022 09:33:50 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ej4so16177876edb.7;
        Tue, 21 Jun 2022 09:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6e6BRQh3YyDffgzUxuFfBfk4yDxOwjIQUZDD8w+p1fg=;
        b=c2hMbgy0NvH9isC6XH0a6iK4WVDRuA8aodpZV5vJcyBmbEjRTaY58YpVP/z6qYi8WJ
         PL2W0HuWj+CEG/4Ot2GHxgfZxaO1Hv0pAAZOG54VJyard5FQs1XtPE/78cWnzRRyVBU9
         wLyiaLC6d72aaH/DKhrtjhE6Qxqr1YgJLZBGyH3nTpSFZlYhx4TWfaU25QAPirsBKkQe
         BEbFFmW/sSez5cYPNjDtMdxcB0oVdOE/m8za6+jDNbGYztpAQYjh84oCuE7LAawcA2qQ
         WvDIBQ+x6DwswTB4dQu2+S0MrkIvfQeE9h8e0bLzJ+5qnvbGi7ePzb1ZDyZSrNwAl4hs
         pYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6e6BRQh3YyDffgzUxuFfBfk4yDxOwjIQUZDD8w+p1fg=;
        b=j0CLB0+YIlglT1GDU1yKlX73QBol07J8PxhZzEmatBNwr8ecXqMNzaf7daDl02D2ft
         4EFmj5EFeeXtyO934GaRkFMVqjj16Pc55f03BfVFAlW6sOuH2DLt5fIbIFx5HkfPqH7m
         P+AWLI+znioOd/mZj97hZURz+4XdXO7NAbZwXADVDT9sKR3FgK6cjtxNxcPZ0bFEBYB9
         zXMZpipLJFiUrRY4ayqv7J6+g8A81bvVPPf6ky96I+jU+/lgcEjeeOrW2O3M76HuKUum
         2cvZ+RC+hJm166A95mr6gGjEQGwWlzTw0ZeuNxMuEbO0v6SWWDIfPmG8jVdY4k1NPS/4
         o8PA==
X-Gm-Message-State: AJIora+peJsazrLflDeuM0EkqwQcCtlVYoFNPmLU9TGblOv+iCtGgcv4
        x7XFLGZzJloElwz9E5cM2Nb9ym/x4fw=
X-Google-Smtp-Source: AGRyM1tVogMNGQJ8hMLGtktujSSyK3CWte3nRvoVY+etuUzVvkZbnUkqSdbe+/nS3va9ANrk9JYAfQ==
X-Received: by 2002:a05:6402:43c7:b0:435:8a92:e8d0 with SMTP id p7-20020a05640243c700b004358a92e8d0mr9737582edc.174.1655829229352;
        Tue, 21 Jun 2022 09:33:49 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id g5-20020a50d5c5000000b004356c0d7436sm9557663edj.42.2022.06.21.09.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 09:33:49 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 3/3] clk: qcom: lcc-ipq806x: convert to parent data
Date:   Tue, 21 Jun 2022 18:33:26 +0200
Message-Id: <20220621163326.16858-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621163326.16858-1-ansuelsmth@gmail.com>
References: <20220621163326.16858-1-ansuelsmth@gmail.com>
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

Convert lcc-ipq806x driver to parent_data API.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
v2:
- Fix Sob tag

 drivers/clk/qcom/lcc-ipq806x.c | 79 +++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/qcom/lcc-ipq806x.c b/drivers/clk/qcom/lcc-ipq806x.c
index ba90bebba597..c07ca8dc6e3a 100644
--- a/drivers/clk/qcom/lcc-ipq806x.c
+++ b/drivers/clk/qcom/lcc-ipq806x.c
@@ -24,6 +24,10 @@
 #include "clk-regmap-mux.h"
 #include "reset.h"
 
+static const struct clk_parent_data gcc_pxo[] = {
+	{ .fw_name = "pxo", .name = "pxo" },
+};
+
 static struct clk_pll pll4 = {
 	.l_reg = 0x4,
 	.m_reg = 0x8,
@@ -34,7 +38,7 @@ static struct clk_pll pll4 = {
 	.status_bit = 16,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "pll4",
-		.parent_names = (const char *[]){ "pxo" },
+		.parent_data = gcc_pxo,
 		.num_parents = 1,
 		.ops = &clk_pll_ops,
 	},
@@ -64,9 +68,9 @@ static const struct parent_map lcc_pxo_pll4_map[] = {
 	{ P_PLL4, 2 }
 };
 
-static const char * const lcc_pxo_pll4[] = {
-	"pxo",
-	"pll4_vote",
+static const struct clk_parent_data lcc_pxo_pll4[] = {
+	{ .fw_name = "pxo", .name = "pxo" },
+	{ .fw_name = "pll4_vote", .name = "pll4_vote" },
 };
 
 static struct freq_tbl clk_tbl_aif_mi2s[] = {
@@ -131,18 +135,14 @@ static struct clk_rcg mi2s_osr_src = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "mi2s_osr_src",
-			.parent_names = lcc_pxo_pll4,
-			.num_parents = 2,
+			.parent_data = lcc_pxo_pll4,
+			.num_parents = ARRAY_SIZE(lcc_pxo_pll4),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
 	},
 };
 
-static const char * const lcc_mi2s_parents[] = {
-	"mi2s_osr_src",
-};
-
 static struct clk_branch mi2s_osr_clk = {
 	.halt_reg = 0x50,
 	.halt_bit = 1,
@@ -152,7 +152,9 @@ static struct clk_branch mi2s_osr_clk = {
 		.enable_mask = BIT(17),
 		.hw.init = &(struct clk_init_data){
 			.name = "mi2s_osr_clk",
-			.parent_names = lcc_mi2s_parents,
+			.parent_hws = (const struct clk_hw*[]){
+				&mi2s_osr_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -167,7 +169,9 @@ static struct clk_regmap_div mi2s_div_clk = {
 	.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "mi2s_div_clk",
-			.parent_names = lcc_mi2s_parents,
+			.parent_hws = (const struct clk_hw*[]){
+				&mi2s_osr_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_regmap_div_ops,
 		},
@@ -183,7 +187,9 @@ static struct clk_branch mi2s_bit_div_clk = {
 		.enable_mask = BIT(15),
 		.hw.init = &(struct clk_init_data){
 			.name = "mi2s_bit_div_clk",
-			.parent_names = (const char *[]){ "mi2s_div_clk" },
+			.parent_hws = (const struct clk_hw*[]){
+				&mi2s_div_clk.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -191,6 +197,10 @@ static struct clk_branch mi2s_bit_div_clk = {
 	},
 };
 
+static const struct clk_parent_data lcc_mi2s_bit_div_codec_clk[] = {
+	{ .hw = &mi2s_bit_div_clk.clkr.hw, },
+	{ .fw_name = "mi2s_codec_clk", .name = "mi2s_codec_clk" },
+};
 
 static struct clk_regmap_mux mi2s_bit_clk = {
 	.reg = 0x48,
@@ -199,11 +209,8 @@ static struct clk_regmap_mux mi2s_bit_clk = {
 	.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "mi2s_bit_clk",
-			.parent_names = (const char *[]){
-				"mi2s_bit_div_clk",
-				"mi2s_codec_clk",
-			},
-			.num_parents = 2,
+			.parent_data = lcc_mi2s_bit_div_codec_clk,
+			.num_parents = ARRAY_SIZE(lcc_mi2s_bit_div_codec_clk),
 			.ops = &clk_regmap_mux_closest_ops,
 			.flags = CLK_SET_RATE_PARENT,
 		},
@@ -245,8 +252,8 @@ static struct clk_rcg pcm_src = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "pcm_src",
-			.parent_names = lcc_pxo_pll4,
-			.num_parents = 2,
+			.parent_data = lcc_pxo_pll4,
+			.num_parents = ARRAY_SIZE(lcc_pxo_pll4),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -262,7 +269,9 @@ static struct clk_branch pcm_clk_out = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "pcm_clk_out",
-			.parent_names = (const char *[]){ "pcm_src" },
+			.parent_hws = (const struct clk_hw*[]){
+				&pcm_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -270,6 +279,11 @@ static struct clk_branch pcm_clk_out = {
 	},
 };
 
+static const struct clk_parent_data lcc_pcm_clk_out_codec_clk[] = {
+	{ .hw = &pcm_clk_out.clkr.hw, },
+	{ .fw_name = "pcm_codec_clk", .name = "pcm_codec_clk" },
+};
+
 static struct clk_regmap_mux pcm_clk = {
 	.reg = 0x54,
 	.shift = 10,
@@ -277,11 +291,8 @@ static struct clk_regmap_mux pcm_clk = {
 	.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "pcm_clk",
-			.parent_names = (const char *[]){
-				"pcm_clk_out",
-				"pcm_codec_clk",
-			},
-			.num_parents = 2,
+			.parent_data = lcc_pcm_clk_out_codec_clk,
+			.num_parents = ARRAY_SIZE(lcc_pcm_clk_out_codec_clk),
 			.ops = &clk_regmap_mux_closest_ops,
 			.flags = CLK_SET_RATE_PARENT,
 		},
@@ -325,18 +336,14 @@ static struct clk_rcg spdif_src = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "spdif_src",
-			.parent_names = lcc_pxo_pll4,
-			.num_parents = 2,
+			.parent_data = lcc_pxo_pll4,
+			.num_parents = ARRAY_SIZE(lcc_pxo_pll4),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
 	},
 };
 
-static const char * const lcc_spdif_parents[] = {
-	"spdif_src",
-};
-
 static struct clk_branch spdif_clk = {
 	.halt_reg = 0xd4,
 	.halt_bit = 1,
@@ -346,7 +353,9 @@ static struct clk_branch spdif_clk = {
 		.enable_mask = BIT(12),
 		.hw.init = &(struct clk_init_data){
 			.name = "spdif_clk",
-			.parent_names = lcc_spdif_parents,
+			.parent_hws = (const struct clk_hw*[]){
+				&spdif_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -384,8 +393,8 @@ static struct clk_rcg ahbix_clk = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "ahbix",
-			.parent_names = lcc_pxo_pll4,
-			.num_parents = 2,
+			.parent_data = lcc_pxo_pll4,
+			.num_parents = ARRAY_SIZE(lcc_pxo_pll4),
 			.ops = &clk_rcg_lcc_ops,
 		},
 	},
-- 
2.36.1

