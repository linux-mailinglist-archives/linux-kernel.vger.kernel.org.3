Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E365A9756
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbiIAMsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbiIAMso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:48:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C415C3D586;
        Thu,  1 Sep 2022 05:48:42 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281AOP3w024018;
        Thu, 1 Sep 2022 12:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=cb2UUEal4Q2lIJeKprA8EDvDm9Vv5VTWr3uDcKGpV3M=;
 b=VbkVKtPgZSJnFM+hmPRoaT2cW+1N6MMg6aQSgPUvjuA0QOSwIJ5WZHu8ePxayd1yiWjJ
 e8+M5FjLlzNg+fm9XG+NExCbocAl6ZUKbn5yglfJfr78UAVjpVoDrtvBiBaD0ymqIy2Q
 7uj1cjU7IvsNSFoJ6e44NLbeUJHrVShmUT58J2x+87hXsPXVSQ/1sSXc11kfesY7/Ade
 krcy4MQEYrC8/febxiMksV9stlM0Ps2zjC8CgVzqDXW0h0p+4II1nbVXcRXEZ0MxdVzC
 9xWISzpk1Wd25ah4k+rKRZO7W3OojCHDT3vrqdllgWpzoMMcYBzVjfxPrrPRU695hg+1 KA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jab5gkfn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 12:48:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 281Cma9Y011324
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Sep 2022 12:48:36 GMT
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 1 Sep 2022 05:48:33 -0700
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@somainline.org>,
        <robh+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH 2/4] soc: qcom: icc-bwmon: add support for sc7280 LLCC BWMON
Date:   Thu, 1 Sep 2022 18:17:28 +0530
Message-ID: <20220901124730.19460-3-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220901124730.19460-1-quic_rjendra@quicinc.com>
References: <20220901124730.19460-1-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lof7OEXscHswmzwTTtmjVdVYupQrmHXS
X-Proofpoint-GUID: lof7OEXscHswmzwTTtmjVdVYupQrmHXS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_08,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010058
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
---
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

