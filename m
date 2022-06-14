Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D60254B4BE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347321AbiFNPeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344390AbiFNPd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:33:56 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD832A427;
        Tue, 14 Jun 2022 08:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655220835; x=1686756835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=BjbQKVg6lB501/rTvvJ6HNGtWrfGVCJD1IYIXBWP0c8=;
  b=JE7eUWeWSisfnPt2HWkvQB43zZAU+ZcJfSYykNQmuvH0rwG9978l7fxC
   49siwdnTO1HeumARNkFNpL0vym/UjC74B5O7W1QaLS9DbN3+aAIqrB2rr
   e79Mf23ODjC6VmNgSn8PDzE5oO8LjDdcFFMKXCtYUgqmoM1zM4IoqGgLF
   w=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Jun 2022 08:33:55 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 08:33:56 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 14 Jun 2022 08:33:54 -0700
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 14 Jun 2022 08:33:50 -0700
From:   Taniya Das <quic_tdas@quicinc.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-soc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>,
        <robh+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>
Subject: [PATCH v5 3/3] clk: qcom: lpass: Add support for resets & external mclk for SC7280
Date:   Tue, 14 Jun 2022 21:03:06 +0530
Message-ID: <20220614153306.29339-4-quic_tdas@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220614153306.29339-1-quic_tdas@quicinc.com>
References: <20220614153306.29339-1-quic_tdas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock gating control for TX/RX/WSA core bus clocks would be required
to be reset(moved from hardware control) from audio core driver. Thus
add the support for the reset clocks.

Also add the external mclk to interface external MI2S.

Fixes: a9dd26639d05 ("clk: qcom: lpass: Add support for LPASS clock controller for SC7280").
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
 drivers/clk/qcom/lpassaudiocc-sc7280.c | 22 ++++++++++++++++-
 drivers/clk/qcom/lpasscorecc-sc7280.c  | 33 ++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/lpassaudiocc-sc7280.c b/drivers/clk/qcom/lpassaudiocc-sc7280.c
index 6ab6e5a34c72..4a71f261eb6e 100644
--- a/drivers/clk/qcom/lpassaudiocc-sc7280.c
+++ b/drivers/clk/qcom/lpassaudiocc-sc7280.c
@@ -22,6 +22,7 @@
 #include "clk-regmap-mux.h"
 #include "common.h"
 #include "gdsc.h"
+#include "reset.h"

 enum {
 	P_BI_TCXO,
@@ -221,7 +222,7 @@ static struct clk_rcg2 lpass_aon_cc_main_rcg_clk_src = {
 		.parent_data = lpass_aon_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(lpass_aon_cc_parent_data_0),
 		.flags = CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };

@@ -665,6 +666,18 @@ static const struct qcom_cc_desc lpass_audio_cc_sc7280_desc = {
 	.num_clks = ARRAY_SIZE(lpass_audio_cc_sc7280_clocks),
 };

+static const struct qcom_reset_map lpass_audio_cc_sc7280_resets[] = {
+	[LPASS_AUDIO_SWR_RX_CGCR] =  { 0xa0, 1 },
+	[LPASS_AUDIO_SWR_TX_CGCR] =  { 0xa8, 1 },
+	[LPASS_AUDIO_SWR_WSA_CGCR] = { 0xb0, 1 },
+};
+
+static const struct qcom_cc_desc lpass_audio_cc_reset_sc7280_desc = {
+	.config = &lpass_audio_cc_sc7280_regmap_config,
+	.resets = lpass_audio_cc_sc7280_resets,
+	.num_resets = ARRAY_SIZE(lpass_audio_cc_sc7280_resets),
+};
+
 static const struct of_device_id lpass_audio_cc_sc7280_match_table[] = {
 	{ .compatible = "qcom,sc7280-lpassaudiocc" },
 	{ }
@@ -741,6 +754,13 @@ static int lpass_audio_cc_sc7280_probe(struct platform_device *pdev)
 		return ret;
 	}

+	ret = qcom_cc_probe_by_index(pdev, 1, &lpass_audio_cc_reset_sc7280_desc);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register LPASS AUDIO CC Resets\n");
+		pm_runtime_disable(&pdev->dev);
+		return ret;
+	}
+
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
diff --git a/drivers/clk/qcom/lpasscorecc-sc7280.c b/drivers/clk/qcom/lpasscorecc-sc7280.c
index 1f1f1bd1b68e..6ad19b06b1ce 100644
--- a/drivers/clk/qcom/lpasscorecc-sc7280.c
+++ b/drivers/clk/qcom/lpasscorecc-sc7280.c
@@ -190,6 +190,19 @@ static struct clk_rcg2 lpass_core_cc_ext_if1_clk_src = {
 	},
 };

+static struct clk_rcg2 lpass_core_cc_ext_mclk0_clk_src = {
+	.cmd_rcgr = 0x20000,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = lpass_core_cc_parent_map_0,
+	.freq_tbl = ftbl_lpass_core_cc_ext_if0_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "lpass_core_cc_ext_mclk0_clk_src",
+		.parent_data = lpass_core_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(lpass_core_cc_parent_data_0),
+		.ops = &clk_rcg2_ops,
+	},
+};

 static struct clk_branch lpass_core_cc_core_clk = {
 	.halt_reg = 0x1f000,
@@ -283,6 +296,24 @@ static struct clk_branch lpass_core_cc_lpm_mem0_core_clk = {
 	},
 };

+static struct clk_branch lpass_core_cc_ext_mclk0_clk = {
+	.halt_reg = 0x20014,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x20014,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "lpass_core_cc_ext_mclk0_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&lpass_core_cc_ext_mclk0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch lpass_core_cc_sysnoc_mport_core_clk = {
 	.halt_reg = 0x23000,
 	.halt_check = BRANCH_HALT_VOTED,
@@ -326,6 +357,8 @@ static struct clk_regmap *lpass_core_cc_sc7280_clocks[] = {
 	[LPASS_CORE_CC_LPM_CORE_CLK] = &lpass_core_cc_lpm_core_clk.clkr,
 	[LPASS_CORE_CC_LPM_MEM0_CORE_CLK] = &lpass_core_cc_lpm_mem0_core_clk.clkr,
 	[LPASS_CORE_CC_SYSNOC_MPORT_CORE_CLK] = &lpass_core_cc_sysnoc_mport_core_clk.clkr,
+	[LPASS_CORE_CC_EXT_MCLK0_CLK] = &lpass_core_cc_ext_mclk0_clk.clkr,
+	[LPASS_CORE_CC_EXT_MCLK0_CLK_SRC] = &lpass_core_cc_ext_mclk0_clk_src.clkr,
 };

 static struct regmap_config lpass_core_cc_sc7280_regmap_config = {
--
2.17.1

