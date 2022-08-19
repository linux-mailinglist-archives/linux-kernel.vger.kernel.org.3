Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C1F59A446
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354543AbiHSRXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350916AbiHSRWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:22:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D49A1272D3;
        Fri, 19 Aug 2022 09:41:47 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JDY17p022605;
        Fri, 19 Aug 2022 16:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=6dMLuIKHL/dzhaa5CMjIHhnIyGZ/AVnRQUHEVeRf6zk=;
 b=bAEG6/a4+qXK3+sKg+bDz3DKMgH2GF2MMrE2SZi5zSSX9ZWYUcquYesLDI9oaXjEa7KJ
 LwOHeMcZuiPlfnBm9IXu6h9kpPzPLr0G5oLmqxvBxUxx/b5YHul9adyP5YbStFf7dV0i
 N9TMhMQ7hL5mjhU/vpHx4AavvtRJWx6/vVw6Zy4qr3RQnFah633b691bjB2n2rHzruUV
 i+OGryzXZavZP6xqOQYO6AgPwyXF+0dcUSxaBhp5mUmuunF8Grn1oU3zv9IM+FrKMSSf
 OnjKhmI8D0JAv6i7bVs8K0PLaISF4n2gwuzqCUIFvzog2ShH1036tjp65q5NX7+WhO3x 9g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j1ttqb1jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 16:41:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27JGfVk4030132
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 16:41:31 GMT
Received: from hyd-lnxbld559.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 19 Aug 2022 09:41:19 -0700
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Stephen Boyd" <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        <krzysztof.kozlowski@linaro.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 4/6] clk: qcom: gpucc-sc7280: Add cx collapse reset support
Date:   Fri, 19 Aug 2022 22:10:43 +0530
Message-ID: <20220819221017.v4.4.I5e64ff4b77bb9079eb2edeea8a02585c9e76778f@changeid>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1660927246-11327-1-git-send-email-quic_akhilpo@quicinc.com>
References: <1660927246-11327-1-git-send-email-quic_akhilpo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FUInOSbWEywMozCVLE8TjOFktgdK9LdD
X-Proofpoint-ORIG-GUID: FUInOSbWEywMozCVLE8TjOFktgdK9LdD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190060
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow a consumer driver to poll for cx gdsc collapse through Reset
framework.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---

(no changes since v3)

Changes in v3:
- Convert 'struct qcom_reset_ops cx_gdsc_reset' to 'static const' (Krzysztof)

Changes in v2:
- Minor update to use the updated custom reset ops implementation

 drivers/clk/qcom/gpucc-sc7280.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/qcom/gpucc-sc7280.c b/drivers/clk/qcom/gpucc-sc7280.c
index 9a832f2..fece3f4 100644
--- a/drivers/clk/qcom/gpucc-sc7280.c
+++ b/drivers/clk/qcom/gpucc-sc7280.c
@@ -433,12 +433,22 @@ static const struct regmap_config gpu_cc_sc7280_regmap_config = {
 	.fast_io = true,
 };
 
+static const struct qcom_reset_ops cx_gdsc_reset = {
+	.reset = gdsc_wait_for_collapse,
+};
+
+static const struct qcom_reset_map gpucc_sc7280_resets[] = {
+	[GPU_CX_COLLAPSE] = { .ops = &cx_gdsc_reset, .priv = &cx_gdsc },
+};
+
 static const struct qcom_cc_desc gpu_cc_sc7280_desc = {
 	.config = &gpu_cc_sc7280_regmap_config,
 	.clks = gpu_cc_sc7280_clocks,
 	.num_clks = ARRAY_SIZE(gpu_cc_sc7280_clocks),
 	.gdscs = gpu_cc_sc7180_gdscs,
 	.num_gdscs = ARRAY_SIZE(gpu_cc_sc7180_gdscs),
+	.resets = gpucc_sc7280_resets,
+	.num_resets = ARRAY_SIZE(gpucc_sc7280_resets),
 };
 
 static const struct of_device_id gpu_cc_sc7280_match_table[] = {
-- 
2.7.4

