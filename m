Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7550D4647FB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347275AbhLAH1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:27:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55324 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347246AbhLAH1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:27:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40DCAB81DDD;
        Wed,  1 Dec 2021 07:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2B8C53FD1;
        Wed,  1 Dec 2021 07:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343420;
        bh=qVauhh1anLoj6pqIlcU3j9p7CS+3Tbz/xceMIV+qKWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vBydN3mSQJgQhdT7WCkqlTEjVJsSxRXEDzjD2gGzsdvXtsvimr5sHRmoFriNmFmKR
         SiyCyROG4CaRUK7J04Vhn1wBr0cJFcw4Xrox//dtqPueXiNAREYi5Z062ycUVm5RQ+
         79KjfZRXH+J0FXIn332i4MqGvi9l8Vnimb2s0Y47/t3Nc9ib0cyVEU7TH35sIQcj4K
         1VZuFXEF+G3jT58aWKAOoNf2T3SWVvUaX5CL7TmCGuzyaNcKDWF0b6eYscYRoNDnQ3
         yWphNF+qQSF4Nb0QhlX/7OFtwFuebszUdGr2AbdLfz+GtSxvp8gk7qD+xR2x1ESJti
         iqY4MOU0Omr+A==
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] clk: qcom: rpmh: add support for SM8450 rpmh clocks
Date:   Wed,  1 Dec 2021 12:53:10 +0530
Message-Id: <20211201072310.3968679-5-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201072310.3968679-1-vkoul@kernel.org>
References: <20211201072310.3968679-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the RPMH clocks present in SM8450 SoC

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/clk/qcom/clk-rpmh.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 441d7a20e6f3..0403cff6c230 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -515,6 +515,32 @@ static const struct clk_rpmh_desc clk_rpmh_sm8350 = {
 /* Resource name must match resource id present in cmd-db */
 DEFINE_CLK_RPMH_ARC(sc7280, bi_tcxo, bi_tcxo_ao, "xo.lvl", 0x3, 4);
 
+DEFINE_CLK_RPMH_VRM(sm8450, ln_bb_clk1, ln_bb_clk1_ao, "lnbclka1", 4);
+DEFINE_CLK_RPMH_VRM(sm8450, ln_bb_clk2, ln_bb_clk2_ao, "lnbclka2", 4);
+
+static struct clk_hw *sm8450_rpmh_clocks[] = {
+	[RPMH_CXO_CLK]		= &sc7280_bi_tcxo.hw,
+	[RPMH_CXO_CLK_A]	= &sc7280_bi_tcxo_ao.hw,
+	[RPMH_LN_BB_CLK1]	= &sm8450_ln_bb_clk1.hw,
+	[RPMH_LN_BB_CLK1_A]	= &sm8450_ln_bb_clk1_ao.hw,
+	[RPMH_LN_BB_CLK2]	= &sm8450_ln_bb_clk2.hw,
+	[RPMH_LN_BB_CLK2_A]	= &sm8450_ln_bb_clk2_ao.hw,
+	[RPMH_RF_CLK1]		= &sdm845_rf_clk1.hw,
+	[RPMH_RF_CLK1_A]	= &sdm845_rf_clk1_ao.hw,
+	[RPMH_RF_CLK2]		= &sdm845_rf_clk2.hw,
+	[RPMH_RF_CLK2_A]	= &sdm845_rf_clk2_ao.hw,
+	[RPMH_RF_CLK3]		= &sdm845_rf_clk3.hw,
+	[RPMH_RF_CLK3_A]	= &sdm845_rf_clk3_ao.hw,
+	[RPMH_RF_CLK4]		= &sm8350_rf_clk4.hw,
+	[RPMH_RF_CLK4_A]	= &sm8350_rf_clk4_ao.hw,
+	[RPMH_IPA_CLK]		= &sdm845_ipa.hw,
+};
+
+static const struct clk_rpmh_desc clk_rpmh_sm8450 = {
+	.clks = sm8450_rpmh_clocks,
+	.num_clks = ARRAY_SIZE(sm8450_rpmh_clocks),
+};
+
 static struct clk_hw *sc7280_rpmh_clocks[] = {
 	[RPMH_CXO_CLK]      = &sc7280_bi_tcxo.hw,
 	[RPMH_CXO_CLK_A]    = &sc7280_bi_tcxo_ao.hw,
@@ -647,6 +673,7 @@ static const struct of_device_id clk_rpmh_match_table[] = {
 	{ .compatible = "qcom,sm8150-rpmh-clk", .data = &clk_rpmh_sm8150},
 	{ .compatible = "qcom,sm8250-rpmh-clk", .data = &clk_rpmh_sm8250},
 	{ .compatible = "qcom,sm8350-rpmh-clk", .data = &clk_rpmh_sm8350},
+	{ .compatible = "qcom,sm8450-rpmh-clk", .data = &clk_rpmh_sm8450},
 	{ .compatible = "qcom,sc7280-rpmh-clk", .data = &clk_rpmh_sc7280},
 	{ }
 };
-- 
2.31.1

