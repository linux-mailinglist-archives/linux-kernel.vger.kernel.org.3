Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892BC5A8C47
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 06:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbiIAESJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 00:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiIAER7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 00:17:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81449107C51;
        Wed, 31 Aug 2022 21:17:58 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2813OqEM008526;
        Thu, 1 Sep 2022 04:17:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=E02jgdZOa2kll4Z8bBdTKTo47Im2X1Epzk5ikzn18+4=;
 b=ohtuP91Xf4eF4vZrBwl/W6Yeilfoati/1j87WTX/Uz6GAQ70d7Ynh3dy3Qtqb1Gnd43K
 1dSOcRHqmkmzOGWSH7p9WXuOPEZm1e0ntGSkZ3BK+0+ZDXiyVAmeJ/e7c11muxd5+hAJ
 WeqEaXhi7sWa+qoTg50Ipy2/5cnYs3ZBkWzuJY9xtunHOIUDVjHEHTlpbXYnh2YmeVAp
 4BfoTRFSajFETRsSt8yzxKm3/0zuQ7hX0Fp7VPp/Au2/3wR2z3GUcE0O68ljHwd9EXRg
 MQ4tfUfzLEM2HHJexEAMVMDV7dl0WfT/qjWgxnmGuSXTb6negyG73m9/c6s+Xwo6soT6 OQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jabgcsyj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 04:17:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2814HssM003318
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Sep 2022 04:17:54 GMT
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 31 Aug 2022 21:17:50 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tdas@quicinc.com>, <quic_c_skakit@quicinc.com>,
        <linux-clk@vger.kernel.org>
Subject: [PATCH V9 2/5] clk: qcom: lpass: Handle the regmap overlap of lpasscc and lpass_aon
Date:   Thu, 1 Sep 2022 09:47:23 +0530
Message-ID: <1662005846-4838-3-git-send-email-quic_c_skakit@quicinc.com>
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
X-Proofpoint-ORIG-GUID: wYoPT2jtqqlh5p_PH4TXrxXK0uH5K9By
X-Proofpoint-GUID: wYoPT2jtqqlh5p_PH4TXrxXK0uH5K9By
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_02,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=754 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010019
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taniya Das <quic_tdas@quicinc.com>

Move registration of lpass_q6ss_ahbm_clk and lpass_q6ss_ahbs_clk to
lpass_aon_cc_sc7280_probe and register them only if "qcom,adsp-pil-mode"
is enabled in the lpass_aon DT node.

Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/qcom/lpassaudiocc-sc7280.c | 44 ++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/lpasscc-sc7280.c      | 44 ----------------------------------
 2 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/clk/qcom/lpassaudiocc-sc7280.c b/drivers/clk/qcom/lpassaudiocc-sc7280.c
index 6ab6e5a3..6067328 100644
--- a/drivers/clk/qcom/lpassaudiocc-sc7280.c
+++ b/drivers/clk/qcom/lpassaudiocc-sc7280.c
@@ -12,6 +12,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
+#include <dt-bindings/clock/qcom,lpass-sc7280.h>
 #include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
 
 #include "clk-alpha-pll.h"
@@ -38,6 +39,32 @@ static const struct pll_vco zonda_vco[] = {
 	{ 595200000UL, 3600000000UL, 0 },
 };
 
+static struct clk_branch lpass_q6ss_ahbm_clk = {
+	.halt_reg = 0x901c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x901c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+				.name = "lpass_q6ss_ahbm_clk",
+				.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch lpass_q6ss_ahbs_clk = {
+	.halt_reg = 0x9020,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x9020,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "lpass_q6ss_ahbs_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 /* 1128.96MHz configuration */
 static const struct alpha_pll_config lpass_audio_cc_pll_config = {
 	.l = 0x3a,
@@ -614,6 +641,11 @@ static struct gdsc lpass_aon_cc_lpass_audio_hm_gdsc = {
 	.flags = RETAIN_FF_ENABLE,
 };
 
+static struct clk_regmap *lpass_cc_sc7280_clocks[] = {
+	[LPASS_Q6SS_AHBM_CLK] = &lpass_q6ss_ahbm_clk.clkr,
+	[LPASS_Q6SS_AHBS_CLK] = &lpass_q6ss_ahbs_clk.clkr,
+};
+
 static struct clk_regmap *lpass_aon_cc_sc7280_clocks[] = {
 	[LPASS_AON_CC_AUDIO_HM_H_CLK] = &lpass_aon_cc_audio_hm_h_clk.clkr,
 	[LPASS_AON_CC_VA_MEM0_CLK] = &lpass_aon_cc_va_mem0_clk.clkr,
@@ -659,6 +691,12 @@ static struct regmap_config lpass_audio_cc_sc7280_regmap_config = {
 	.fast_io = true,
 };
 
+static const struct qcom_cc_desc lpass_cc_sc7280_desc = {
+	.config = &lpass_audio_cc_sc7280_regmap_config,
+	.clks = lpass_cc_sc7280_clocks,
+	.num_clks = ARRAY_SIZE(lpass_cc_sc7280_clocks),
+};
+
 static const struct qcom_cc_desc lpass_audio_cc_sc7280_desc = {
 	.config = &lpass_audio_cc_sc7280_regmap_config,
 	.clks = lpass_audio_cc_sc7280_clocks,
@@ -785,6 +823,12 @@ static int lpass_aon_cc_sc7280_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (of_property_read_bool(pdev->dev.of_node, "qcom,adsp-pil-mode")) {
+		lpass_audio_cc_sc7280_regmap_config.name = "cc";
+		desc = &lpass_cc_sc7280_desc;
+		return qcom_cc_probe(pdev, desc);
+	}
+
 	lpass_audio_cc_sc7280_regmap_config.name = "lpasscc_aon";
 	lpass_audio_cc_sc7280_regmap_config.max_register = 0xa0008;
 	desc = &lpass_aon_cc_sc7280_desc;
diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc-sc7280.c
index b39ee1c..5c1e17b 100644
--- a/drivers/clk/qcom/lpasscc-sc7280.c
+++ b/drivers/clk/qcom/lpasscc-sc7280.c
@@ -17,32 +17,6 @@
 #include "clk-branch.h"
 #include "common.h"
 
-static struct clk_branch lpass_q6ss_ahbm_clk = {
-	.halt_reg = 0x1c,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x1c,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "lpass_q6ss_ahbm_clk",
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch lpass_q6ss_ahbs_clk = {
-	.halt_reg = 0x20,
-	.halt_check = BRANCH_HALT_VOTED,
-	.clkr = {
-		.enable_reg = 0x20,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "lpass_q6ss_ahbs_clk",
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch lpass_top_cc_lpi_q6_axim_hs_clk = {
 	.halt_reg = 0x0,
 	.halt_check = BRANCH_HALT,
@@ -105,17 +79,6 @@ static struct regmap_config lpass_regmap_config = {
 	.fast_io	= true,
 };
 
-static struct clk_regmap *lpass_cc_sc7280_clocks[] = {
-	[LPASS_Q6SS_AHBM_CLK] = &lpass_q6ss_ahbm_clk.clkr,
-	[LPASS_Q6SS_AHBS_CLK] = &lpass_q6ss_ahbs_clk.clkr,
-};
-
-static const struct qcom_cc_desc lpass_cc_sc7280_desc = {
-	.config = &lpass_regmap_config,
-	.clks = lpass_cc_sc7280_clocks,
-	.num_clks = ARRAY_SIZE(lpass_cc_sc7280_clocks),
-};
-
 static struct clk_regmap *lpass_cc_top_sc7280_clocks[] = {
 	[LPASS_TOP_CC_LPI_Q6_AXIM_HS_CLK] =
 				&lpass_top_cc_lpi_q6_axim_hs_clk.clkr,
@@ -169,13 +132,6 @@ static int lpass_cc_sc7280_probe(struct platform_device *pdev)
 	if (ret)
 		goto destroy_pm_clk;
 
-	lpass_regmap_config.name = "cc";
-	desc = &lpass_cc_sc7280_desc;
-
-	ret = qcom_cc_probe_by_index(pdev, 2, desc);
-	if (ret)
-		goto destroy_pm_clk;
-
 	return 0;
 
 destroy_pm_clk:
-- 
2.7.4

