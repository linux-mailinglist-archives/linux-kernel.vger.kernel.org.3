Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FB0553764
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353713AbiFUQHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353686AbiFUQHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:07:42 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA66F1E;
        Tue, 21 Jun 2022 09:07:40 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id cf14so10262881edb.8;
        Tue, 21 Jun 2022 09:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n1RNO5f7pssWPG4fLr9gdAw4eJ32N3P99Wlmi11446o=;
        b=JO89EeNFZ40UdDOlEKa1vkBnKCof/favGwBF1HBd7qmSmaKWqFGdcCgR4Epcgx+/Q2
         RgIg/21jb/qDXqDt4LfYapKAkxH5N3ndT7tpQF6n/QjqeuMn//MVLofYechx5pdKJz/W
         S0ph4ZMug+P19CbQ5vvtXePHRDCzLvyB0Y8rh/a8FVxJ6LsV1dIqgPQWdDacegSvx+iV
         TD0+aFw7LyDXVQhg0iyzcxKWaff3U9SqmqlTYWZqfmIbAij0N8azccoDn54KYIMk7oYe
         /gtG86/Xb9Rw5kVsQb9jAme5YQAKR+an5xHLqTwq/XSJv4irR+LIWne/lxOeDqiQ2RWs
         RBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n1RNO5f7pssWPG4fLr9gdAw4eJ32N3P99Wlmi11446o=;
        b=rh2lVC9boZkP3xpdtJrdmy3CFiPegnPRAAkBDOqrOWeNZol3e+D9IrN+yVtjzD4hog
         Y1YC1YheAjXGVX3T7KTfVJ+/nH5+qeETDOVYwZUSHkiaEU/XQJS6F2XKzMLBr89INor2
         lAuYvHZVn/Thms9y0JrqZOgILXPBlifXmWP9Bu58yYljQEGkg3nJOE4I4Zbb+tP4x0tm
         7lWKYCdnuUgFYeTrUXO618FLdHBDHREjxlawqbmABuClv9Wor74TYvW6rHmLRPPAfKOU
         qBLvhFOfPRle7MsJITgQqI4Ico0XkG/3A+E2iPsjj/3uLGFf+VMlvfO/RaUltScSLaPB
         u3jA==
X-Gm-Message-State: AJIora+b+8rwNYReHOxk69K0TCtDJ4H+rCtSbdf6f2f7F0Z5rYLYADOB
        u+HvunqkwyWr4JDfdnsLfm0=
X-Google-Smtp-Source: AGRyM1uVyDy8Qc2zsSxZEhbGY0aVHaxjcptrDReKKrpX0HRiXCQZ1C0r/FIdLr0CaHZza7EbcR4J3Q==
X-Received: by 2002:a05:6402:3708:b0:433:2d3b:ed5 with SMTP id ek8-20020a056402370800b004332d3b0ed5mr36305919edb.246.1655827659371;
        Tue, 21 Jun 2022 09:07:39 -0700 (PDT)
Received: from localhost.localdomain ([185.107.57.61])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090653c600b00722e0b1fa8esm1772943ejo.164.2022.06.21.09.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 09:07:39 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] clk: qcom: msm8996-cpu: Use parent_data for all clocks
Date:   Tue, 21 Jun 2022 20:06:21 +0400
Message-Id: <20220621160621.24415-7-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621160621.24415-1-y.oudjana@protonmail.com>
References: <20220621160621.24415-1-y.oudjana@protonmail.com>
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

Replace parent_names in PLLs, secondary muxes and primary muxes with
parent_data. For primary muxes there were never any *cl_pll_acd clocks,
so instead of adding them, put the primary PLLs in both PLL_INDEX and
ACD_INDEX, then make sure ACD_INDEX is always picked over PLL_INDEX when
setting parent since we always want ACD when using the primary PLLs.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/clk/qcom/clk-cpu-8996.c | 79 ++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
index b3ad9245874d..cdb7b2ef3367 100644
--- a/drivers/clk/qcom/clk-cpu-8996.c
+++ b/drivers/clk/qcom/clk-cpu-8996.c
@@ -112,14 +112,18 @@ static const struct alpha_pll_config hfpll_config = {
 	.early_output_mask = BIT(3),
 };
 
+static const struct clk_parent_data pll_parent[] = {
+	{ .fw_name = "xo" },
+};
+
 static struct clk_alpha_pll pwrcl_pll = {
 	.offset = PWRCL_REG_OFFSET,
 	.regs = prim_pll_regs,
 	.flags = SUPPORTS_DYNAMIC_UPDATE | SUPPORTS_FSM_MODE,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "pwrcl_pll",
-		.parent_names = (const char *[]){ "xo" },
-		.num_parents = 1,
+		.parent_data = pll_parent,
+		.num_parents = ARRAY_SIZE(pll_parent),
 		.ops = &clk_alpha_pll_huayra_ops,
 	},
 };
@@ -130,8 +134,8 @@ static struct clk_alpha_pll perfcl_pll = {
 	.flags = SUPPORTS_DYNAMIC_UPDATE | SUPPORTS_FSM_MODE,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "perfcl_pll",
-		.parent_names = (const char *[]){ "xo" },
-		.num_parents = 1,
+		.parent_data = pll_parent,
+		.num_parents = ARRAY_SIZE(pll_parent),
 		.ops = &clk_alpha_pll_huayra_ops,
 	},
 };
@@ -190,8 +194,8 @@ static struct clk_alpha_pll pwrcl_alt_pll = {
 	.flags = SUPPORTS_OFFLINE_REQ | SUPPORTS_FSM_MODE,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "pwrcl_alt_pll",
-		.parent_names = (const char *[]){ "xo" },
-		.num_parents = 1,
+		.parent_data = pll_parent,
+		.num_parents = ARRAY_SIZE(pll_parent),
 		.ops = &clk_alpha_pll_hwfsm_ops,
 	},
 };
@@ -204,8 +208,8 @@ static struct clk_alpha_pll perfcl_alt_pll = {
 	.flags = SUPPORTS_OFFLINE_REQ | SUPPORTS_FSM_MODE,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "perfcl_alt_pll",
-		.parent_names = (const char *[]){ "xo" },
-		.num_parents = 1,
+		.parent_data = pll_parent,
+		.num_parents = ARRAY_SIZE(pll_parent),
 		.ops = &clk_alpha_pll_hwfsm_ops,
 	},
 };
@@ -252,6 +256,9 @@ static int clk_cpu_8996_pmux_set_parent(struct clk_hw *hw, u8 index)
 	u32 val;
 
 	val = index;
+	/* We always want ACD when using the primary PLL */
+	if (val == PLL_INDEX)
+		val = ACD_INDEX;
 	val <<= cpuclk->shift;
 
 	return regmap_update_bits(clkr->regmap, cpuclk->reg, mask, val);
@@ -282,17 +289,24 @@ static const struct clk_ops clk_cpu_8996_pmux_ops = {
 	.determine_rate = clk_cpu_8996_pmux_determine_rate,
 };
 
+static const struct clk_parent_data pwrcl_smux_parents[] = {
+	{ .fw_name = "xo" },
+	{ .hw = &pwrcl_pll_postdiv.hw },
+};
+
+static const struct clk_parent_data perfcl_smux_parents[] = {
+	{ .fw_name = "xo" },
+	{ .hw = &perfcl_pll_postdiv.hw },
+};
+
 static struct clk_regmap_mux pwrcl_smux = {
 	.reg = PWRCL_REG_OFFSET + MUX_OFFSET,
 	.shift = 2,
 	.width = 2,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "pwrcl_smux",
-		.parent_names = (const char *[]){
-			"xo",
-			"pwrcl_pll_postdiv",
-		},
-		.num_parents = 2,
+		.parent_data = pwrcl_smux_parents,
+		.num_parents = ARRAY_SIZE(pwrcl_smux_parents),
 		.ops = &clk_regmap_mux_closest_ops,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -304,16 +318,27 @@ static struct clk_regmap_mux perfcl_smux = {
 	.width = 2,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "perfcl_smux",
-		.parent_names = (const char *[]){
-			"xo",
-			"perfcl_pll_postdiv",
-		},
-		.num_parents = 2,
+		.parent_data = perfcl_smux_parents,
+		.num_parents = ARRAY_SIZE(perfcl_smux_parents),
 		.ops = &clk_regmap_mux_closest_ops,
 		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
+static const struct clk_parent_data pwrcl_pmux_parents[] = {
+	[SMUX_INDEX] = { .hw = &pwrcl_smux.clkr.hw },
+	[PLL_INDEX] = { .hw = &pwrcl_pll.clkr.hw },
+	[ACD_INDEX] = { .hw = &pwrcl_pll.clkr.hw },
+	[ALT_INDEX] = { .hw = &pwrcl_alt_pll.clkr.hw },
+};
+
+static const struct clk_parent_data perfcl_pmux_parents[] = {
+	[SMUX_INDEX] = { .hw = &perfcl_smux.clkr.hw },
+	[PLL_INDEX] = { .hw = &perfcl_pll.clkr.hw },
+	[ACD_INDEX] = { .hw = &perfcl_pll.clkr.hw },
+	[ALT_INDEX] = { .hw = &perfcl_alt_pll.clkr.hw },
+};
+
 static struct clk_cpu_8996_pmux pwrcl_pmux = {
 	.reg = PWRCL_REG_OFFSET + MUX_OFFSET,
 	.shift = 0,
@@ -323,13 +348,8 @@ static struct clk_cpu_8996_pmux pwrcl_pmux = {
 	.nb.notifier_call = cpu_clk_notifier_cb,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "pwrcl_pmux",
-		.parent_names = (const char *[]){
-			"pwrcl_smux",
-			"pwrcl_pll",
-			"pwrcl_pll_acd",
-			"pwrcl_alt_pll",
-		},
-		.num_parents = 4,
+		.parent_data = pwrcl_pmux_parents,
+		.num_parents = ARRAY_SIZE(pwrcl_pmux_parents),
 		.ops = &clk_cpu_8996_pmux_ops,
 		/* CPU clock is critical and should never be gated */
 		.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
@@ -345,13 +365,8 @@ static struct clk_cpu_8996_pmux perfcl_pmux = {
 	.nb.notifier_call = cpu_clk_notifier_cb,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "perfcl_pmux",
-		.parent_names = (const char *[]){
-			"perfcl_smux",
-			"perfcl_pll",
-			"perfcl_pll_acd",
-			"perfcl_alt_pll",
-		},
-		.num_parents = 4,
+		.parent_data = perfcl_pmux_parents,
+		.num_parents = ARRAY_SIZE(perfcl_pmux_parents),
 		.ops = &clk_cpu_8996_pmux_ops,
 		/* CPU clock is critical and should never be gated */
 		.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
-- 
2.36.1

