Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74A85A8C58
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 06:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiIAETh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 00:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbiIAETB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 00:19:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6111F161DDD;
        Wed, 31 Aug 2022 21:18:16 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2812p16T018795;
        Thu, 1 Sep 2022 04:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=l5sh6dCCCaxLLDrYIUfTAqSUWYh7jzgEf6hxbmIfF50=;
 b=eHkB3SGDNE0YPkbahuTOmeO7WyPtLsfWEmvQS7vwPR+pWLjqY749jUTkEpmSuXEsPJ7k
 X4ksdCQZeH+mzIb9E4q3pQ+STPFCOu/W4Na/onbglzTUSS8onQfuZC3gtxj4kwQuQ6jW
 IOGxnOdo4+0Mc9Ywh4f/rv8Ag/G3xObT6ByQOjrsV3CzWZowHifdxwGV5pw4yVI5ZTuC
 CLYUbt65qbYAGNlwZEzkNGSqfXvIGrHGfnlUl6EhLMKd17IvJL3PlIjuvfPZkY79oAQ9
 QKD6DVdEz2YntxZzJoPtioQELG9CTtcGDNFPNmPUeW/8q50slc/kj1LyaASFWYAh5bNe Xg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jadtcs705-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 04:18:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2814I5WV032122
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Sep 2022 04:18:05 GMT
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 31 Aug 2022 21:18:02 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tdas@quicinc.com>, <quic_c_skakit@quicinc.com>,
        <linux-clk@vger.kernel.org>
Subject: [PATCH V9 5/5] clk: qcom: lpass: Add support for resets & external mclk for SC7280
Date:   Thu, 1 Sep 2022 09:47:26 +0530
Message-ID: <1662005846-4838-6-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1662005846-4838-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1662005846-4838-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9tQatwmq3a67TPjvYkJRMn8RemNqBdL8
X-Proofpoint-GUID: 9tQatwmq3a67TPjvYkJRMn8RemNqBdL8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_02,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=974 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010019
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taniya Das <quic_tdas@quicinc.com>

The clock gating control for TX/RX/WSA core bus clocks would be required
to be reset(moved from hardware control) from audio core driver. Thus
add the support for the reset clocks.

Update the lpass_aon_cc_main_rcg_clk_src ops to park the RCG at XO after
disable as this clock signal is used by hardware to turn ON memories in
LPASS. Also add the external mclk to interface external MI2S.

Fixes: a9dd26639d05 ("clk: qcom: lpass: Add support for LPASS clock controller for SC7280")
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/clk/qcom/lpassaudiocc-sc7280.c | 24 ++++++++++++++++++++++--
 drivers/clk/qcom/lpasscorecc-sc7280.c  | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/lpassaudiocc-sc7280.c b/drivers/clk/qcom/lpassaudiocc-sc7280.c
index 6067328..5d4bc56 100644
--- a/drivers/clk/qcom/lpassaudiocc-sc7280.c
+++ b/drivers/clk/qcom/lpassaudiocc-sc7280.c
@@ -23,6 +23,7 @@
 #include "clk-regmap-mux.h"
 #include "common.h"
 #include "gdsc.h"
+#include "reset.h"
 
 enum {
 	P_BI_TCXO,
@@ -248,7 +249,7 @@ static struct clk_rcg2 lpass_aon_cc_main_rcg_clk_src = {
 		.parent_data = lpass_aon_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(lpass_aon_cc_parent_data_0),
 		.flags = CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -703,6 +704,18 @@ static const struct qcom_cc_desc lpass_audio_cc_sc7280_desc = {
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
@@ -772,13 +785,20 @@ static int lpass_audio_cc_sc7280_probe(struct platform_device *pdev)
 	regmap_write(regmap, 0x4, 0x3b);
 	regmap_write(regmap, 0x8, 0xff05);
 
-	ret = qcom_cc_really_probe(pdev, &lpass_audio_cc_sc7280_desc, regmap);
+	ret = qcom_cc_probe_by_index(pdev, 0, &lpass_audio_cc_sc7280_desc);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register LPASS AUDIO CC clocks\n");
 		pm_runtime_disable(&pdev->dev);
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
index 1f1f1bd..6ad19b0 100644
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
2.7.4

