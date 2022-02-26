Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98B14C5862
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 22:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiBZVm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 16:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiBZVmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 16:42:24 -0500
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDE749C96
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 13:41:49 -0800 (PST)
Received: from localhost.localdomain (abxh33.neoplus.adsl.tpnet.pl [83.9.1.33])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 3E00B3F415;
        Sat, 26 Feb 2022 22:41:47 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] clk: qcom: smd: Add missing MSM8998 RPM clocks
Date:   Sat, 26 Feb 2022 22:41:26 +0100
Message-Id: <20220226214126.21209-3-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220226214126.21209-1-konrad.dybcio@somainline.org>
References: <20220226214126.21209-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing RPM-provided clocks on msm8998 and reorder the definitions
where needed.

JAMI: fixed for a0384ecfe2aa ("clk: qcom: smd-rpm: De-duplicate identical entries")
JAMI: fixed for 36354c32bd76 ("clk: qcom: smd-rpm: Add .recalc_rate hook for clk_smd_rpm_branch_ops")
Tested-by: Jami Kettunen <jami.kettunen@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 40 +++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 418f017e933f..afc6dc930011 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -816,15 +816,18 @@ static const struct rpm_smd_clk_desc rpm_clk_qcs404 = {
 	.num_clks = ARRAY_SIZE(qcs404_clks),
 };
 
-DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, ln_bb_clk3_pin, ln_bb_clk3_a_pin,
-				     3, 19200000);
+DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, ln_bb_clk3, ln_bb_clk3_a, 3, 19200000);
+DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, ln_bb_clk3_pin, ln_bb_clk3_a_pin, 3, 19200000);
 DEFINE_CLK_SMD_RPM(msm8998, aggre1_noc_clk, aggre1_noc_a_clk,
 		   QCOM_SMD_RPM_AGGR_CLK, 1);
 DEFINE_CLK_SMD_RPM(msm8998, aggre2_noc_clk, aggre2_noc_a_clk,
 		   QCOM_SMD_RPM_AGGR_CLK, 2);
 DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, rf_clk3, rf_clk3_a, 6, 19200000);
 DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, rf_clk3_pin, rf_clk3_a_pin, 6, 19200000);
+
 static struct clk_smd_rpm *msm8998_clks[] = {
+	[RPM_SMD_XO_CLK_SRC] = &sdm660_bi_tcxo,
+	[RPM_SMD_XO_A_CLK_SRC] = &sdm660_bi_tcxo_a,
 	[RPM_SMD_BIMC_CLK] = &msm8916_bimc_clk,
 	[RPM_SMD_BIMC_A_CLK] = &msm8916_bimc_a_clk,
 	[RPM_SMD_PCNOC_CLK] = &msm8916_pcnoc_clk,
@@ -837,12 +840,22 @@ static struct clk_smd_rpm *msm8998_clks[] = {
 	[RPM_SMD_CE1_A_CLK] = &msm8992_ce1_a_clk,
 	[RPM_SMD_DIV_CLK1] = &msm8974_div_clk1,
 	[RPM_SMD_DIV_A_CLK1] = &msm8974_div_a_clk1,
+	[RPM_SMD_DIV_CLK2] = &msm8974_div_clk2,
+	[RPM_SMD_DIV_A_CLK2] = &msm8974_div_a_clk2,
+	[RPM_SMD_DIV_CLK3] = &msm8992_div_clk3,
+	[RPM_SMD_DIV_A_CLK3] = &msm8992_div_clk3_a,
 	[RPM_SMD_IPA_CLK] = &msm8976_ipa_clk,
 	[RPM_SMD_IPA_A_CLK] = &msm8976_ipa_a_clk,
 	[RPM_SMD_LN_BB_CLK1] = &msm8916_bb_clk1,
 	[RPM_SMD_LN_BB_CLK1_A] = &msm8916_bb_clk1_a,
 	[RPM_SMD_LN_BB_CLK2] = &msm8916_bb_clk2,
 	[RPM_SMD_LN_BB_CLK2_A] = &msm8916_bb_clk2_a,
+	[RPM_SMD_LN_BB_CLK3] = &msm8998_ln_bb_clk3,
+	[RPM_SMD_LN_BB_CLK3_A] = &msm8998_ln_bb_clk3_a,
+	[RPM_SMD_LN_BB_CLK1_PIN] = &msm8916_bb_clk1_pin,
+	[RPM_SMD_LN_BB_CLK1_A_PIN] = &msm8916_bb_clk1_a_pin,
+	[RPM_SMD_LN_BB_CLK2_PIN] = &msm8916_bb_clk2_pin,
+	[RPM_SMD_LN_BB_CLK2_A_PIN] = &msm8916_bb_clk2_a_pin,
 	[RPM_SMD_LN_BB_CLK3_PIN] = &msm8998_ln_bb_clk3_pin,
 	[RPM_SMD_LN_BB_CLK3_A_PIN] = &msm8998_ln_bb_clk3_a_pin,
 	[RPM_SMD_MMAXI_CLK] = &msm8996_mmssnoc_axi_rpm_clk,
@@ -855,10 +868,14 @@ static struct clk_smd_rpm *msm8998_clks[] = {
 	[RPM_SMD_QDSS_A_CLK] = &msm8916_qdss_a_clk,
 	[RPM_SMD_RF_CLK1] = &msm8916_rf_clk1,
 	[RPM_SMD_RF_CLK1_A] = &msm8916_rf_clk1_a,
-	[RPM_SMD_RF_CLK2_PIN] = &msm8916_rf_clk2_pin,
-	[RPM_SMD_RF_CLK2_A_PIN] = &msm8916_rf_clk2_a_pin,
+	[RPM_SMD_RF_CLK2] = &msm8916_rf_clk2,
+	[RPM_SMD_RF_CLK2_A] = &msm8916_rf_clk2_a,
 	[RPM_SMD_RF_CLK3] = &msm8998_rf_clk3,
 	[RPM_SMD_RF_CLK3_A] = &msm8998_rf_clk3_a,
+	[RPM_SMD_RF_CLK1_PIN] = &msm8916_rf_clk1_pin,
+	[RPM_SMD_RF_CLK1_A_PIN] = &msm8916_rf_clk1_a_pin,
+	[RPM_SMD_RF_CLK2_PIN] = &msm8916_rf_clk2_pin,
+	[RPM_SMD_RF_CLK2_A_PIN] = &msm8916_rf_clk2_a_pin,
 	[RPM_SMD_RF_CLK3_PIN] = &msm8998_rf_clk3_pin,
 	[RPM_SMD_RF_CLK3_A_PIN] = &msm8998_rf_clk3_a_pin,
 };
@@ -868,9 +885,6 @@ static const struct rpm_smd_clk_desc rpm_clk_msm8998 = {
 	.num_clks = ARRAY_SIZE(msm8998_clks),
 };
 
-DEFINE_CLK_SMD_RPM_XO_BUFFER(sdm660, ln_bb_clk3, ln_bb_clk3_a, 3, 19200000);
-DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(sdm660, ln_bb_clk3_pin, ln_bb_clk3_pin_a, 3, 19200000);
-
 static struct clk_smd_rpm *sdm660_clks[] = {
 	[RPM_SMD_XO_CLK_SRC] = &sdm660_bi_tcxo,
 	[RPM_SMD_XO_A_CLK_SRC] = &sdm660_bi_tcxo_a,
@@ -900,16 +914,16 @@ static struct clk_smd_rpm *sdm660_clks[] = {
 	[RPM_SMD_LN_BB_A_CLK] = &msm8916_bb_clk1_a,
 	[RPM_SMD_LN_BB_CLK2] = &msm8916_bb_clk2,
 	[RPM_SMD_LN_BB_CLK2_A] = &msm8916_bb_clk2_a,
-	[RPM_SMD_LN_BB_CLK3] = &sdm660_ln_bb_clk3,
-	[RPM_SMD_LN_BB_CLK3_A] = &sdm660_ln_bb_clk3_a,
+	[RPM_SMD_LN_BB_CLK3] = &msm8998_ln_bb_clk3,
+	[RPM_SMD_LN_BB_CLK3_A] = &msm8998_ln_bb_clk3_a,
 	[RPM_SMD_RF_CLK1_PIN] = &msm8916_rf_clk1_pin,
 	[RPM_SMD_RF_CLK1_A_PIN] = &msm8916_rf_clk1_a_pin,
 	[RPM_SMD_LN_BB_CLK1_PIN] = &msm8916_bb_clk1_pin,
 	[RPM_SMD_LN_BB_CLK1_A_PIN] = &msm8916_bb_clk1_a_pin,
 	[RPM_SMD_LN_BB_CLK2_PIN] = &msm8916_bb_clk2_pin,
 	[RPM_SMD_LN_BB_CLK2_A_PIN] = &msm8916_bb_clk2_a_pin,
-	[RPM_SMD_LN_BB_CLK3_PIN] = &sdm660_ln_bb_clk3_pin,
-	[RPM_SMD_LN_BB_CLK3_A_PIN] = &sdm660_ln_bb_clk3_pin_a,
+	[RPM_SMD_LN_BB_CLK3_PIN] = &msm8998_ln_bb_clk3_pin,
+	[RPM_SMD_LN_BB_CLK3_A_PIN] = &msm8998_ln_bb_clk3_a_pin,
 };
 
 static const struct rpm_smd_clk_desc rpm_clk_sdm660 = {
@@ -1011,8 +1025,8 @@ static struct clk_smd_rpm *sm6125_clks[] = {
 	[RPM_SMD_LN_BB_CLK1_A] = &msm8916_bb_clk1_a,
 	[RPM_SMD_LN_BB_CLK2] = &msm8916_bb_clk2,
 	[RPM_SMD_LN_BB_CLK2_A] = &msm8916_bb_clk2_a,
-	[RPM_SMD_LN_BB_CLK3] = &sdm660_ln_bb_clk3,
-	[RPM_SMD_LN_BB_CLK3_A] = &sdm660_ln_bb_clk3_a,
+	[RPM_SMD_LN_BB_CLK3] = &msm8998_ln_bb_clk3,
+	[RPM_SMD_LN_BB_CLK3_A] = &msm8998_ln_bb_clk3_a,
 	[RPM_SMD_QUP_CLK] = &sm6125_qup_clk,
 	[RPM_SMD_QUP_A_CLK] = &sm6125_qup_a_clk,
 	[RPM_SMD_MMRT_CLK] = &sm6125_mmrt_clk,
-- 
2.35.1

