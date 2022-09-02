Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584CB5AA70D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 06:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbiIBEgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 00:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbiIBEgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 00:36:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FA49D104;
        Thu,  1 Sep 2022 21:36:12 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2824NKQs017646;
        Fri, 2 Sep 2022 04:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=OUIZrqLhtsbCDhd3AxPcQjJxvqtiLVep8gMvSoCLRMw=;
 b=LXt+biEv87ccUbFTy2nI94mJnMQYcV/ogJsgVnl5DHDNAUxy2TfUEabIYy6g4WEGuaGZ
 /e05GV0E2qb5+MJak1mOnM7nkbtDcOpAe2Eajj7OwR46YSuamtmdBL3veu0Pqy69Ckkv
 xVafytlxwynpUqo5R/RYhyWSyQnzKRY0iaRIFoK8DFHCXqJz/mAZuoJaoXeGoU8hX2Ak
 BMXefDV2JgLIfVZLwifUtYkQCtbXCABx+N/wLuMFY5bM3AhD7nqzclMvoPH40UL1EwZ/
 MJbXhmSixBVFyna5/BPD7d1ldur+m8WN0ciKgESJaBf3xMHepZpq26iLfXy6KQXlLicj +A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jafkx4uqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 04:36:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2824a5ZN016577
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Sep 2022 04:36:05 GMT
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 1 Sep 2022 21:36:02 -0700
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@somainline.org>,
        <robh+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v2 2/4] soc: qcom: icc-bwmon: add support for sc7280 LLCC BWMON
Date:   Fri, 2 Sep 2022 10:05:09 +0530
Message-ID: <20220902043511.17130-3-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220902043511.17130-1-quic_rjendra@quicinc.com>
References: <20220902043511.17130-1-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: o_XlQXZnvyaKLQME4ujXsLq86UK8YuLP
X-Proofpoint-GUID: o_XlQXZnvyaKLQME4ujXsLq86UK8YuLP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209020020
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for sc7280 BWMON instance measuring traffic between LLCC and
memory with the v5 register layout.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v2: no change

 drivers/soc/qcom/icc-bwmon.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index 47c2c3e7bb3f..44a10009b45e 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -656,6 +656,18 @@ static const struct icc_bwmon_data sdm845_llcc_bwmon_data = {
 	.regmap_cfg = &sdm845_llcc_bwmon_regmap_cfg,
 };
 
+static const struct icc_bwmon_data sc7280_llcc_bwmon_data = {
+	.sample_ms = 4,
+	.count_unit_kb = 64,
+	.default_highbw_kbps = 800 * 1024, /* 800 MBps */
+	.default_medbw_kbps = 256 * 1024, /* 256 MBps */
+	.default_lowbw_kbps = 0,
+	.zone1_thres_count = 16,
+	.zone3_thres_count = 1,
+	.regmap_fields = sdm845_llcc_bwmon_reg_fields,
+	.regmap_cfg = &sdm845_llcc_bwmon_regmap_cfg,
+};
+
 static const struct of_device_id bwmon_of_match[] = {
 	{
 		.compatible = "qcom,msm8998-bwmon",
@@ -663,6 +675,9 @@ static const struct of_device_id bwmon_of_match[] = {
 	}, {
 		.compatible = "qcom,sdm845-llcc-bwmon",
 		.data = &sdm845_llcc_bwmon_data
+	}, {
+		.compatible = "qcom,sc7280-llcc-bwmon",
+		.data = &sc7280_llcc_bwmon_data
 	},
 	{}
 };
-- 
2.17.1

