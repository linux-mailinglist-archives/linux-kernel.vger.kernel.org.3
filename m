Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B14F5A9758
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbiIAMs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiIAMst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:48:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDD0647F9;
        Thu,  1 Sep 2022 05:48:46 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2819cOPP020780;
        Thu, 1 Sep 2022 12:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=YDANJShkBITQ4xndGorA1hHkZ/z2G5Wg8fXMHi8dXtM=;
 b=jW9ave1WPgNXdbTsEvFOyqyM/UYv1eHP66PCwJdXmAWtfecslrubJ92gjuBA+xylIb40
 gGQnUtWVt8Q0sSNsSVAy5UX6p1jts/khj5ZWQw5bgLfwBnpevQJxVX49/OC+ceTb9gpR
 C0lnW0N8tQZTZdDkEPShoXp1UNm3l3AvjeKc09tKDFj2om/rNGcOyMCADC3pGtyKlIf6
 jQTLDY02cocqpuIifdm6ItzbTRSs4z6cmH87FzbnTNekODx64ULHYYEz64TrAJwqKq+y
 a/cqp5v2uuLkKBXe8GaUwCelIdBaEPUCHBe6tgjpHk9PNU8Dmj+RkHVqDbVyWaSWJjD4 MQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jabgcua8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 12:48:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 281CmdXD024772
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Sep 2022 12:48:39 GMT
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 1 Sep 2022 05:48:37 -0700
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@somainline.org>,
        <robh+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH 3/4] soc: qcom: icc-bwmon: force clear counter/irq registers
Date:   Thu, 1 Sep 2022 18:17:29 +0530
Message-ID: <20220901124730.19460-4-quic_rjendra@quicinc.com>
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
X-Proofpoint-ORIG-GUID: NwWToRiqSgdaJRZT3f1IMCjTR5qii7ij
X-Proofpoint-GUID: NwWToRiqSgdaJRZT3f1IMCjTR5qii7ij
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_08,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=857 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

In some SoCs we have to force clear the counter/irq clear registers as
they are not self clearing after they are written into.
sc7280 seems to be one such SoC, handle this with a quirk flag.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
---
 drivers/soc/qcom/icc-bwmon.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index 44a10009b45e..17cba2648ae7 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -115,6 +115,7 @@
 
 /* Quirks for specific BWMON types */
 #define BWMON_HAS_GLOBAL_IRQ			BIT(0)
+#define BWMON_NEEDS_FORCE_CLEAR			BIT(1)
 
 enum bwmon_fields {
 	F_GLOBAL_IRQ_CLEAR,
@@ -343,6 +344,8 @@ static void bwmon_clear_counters(struct icc_bwmon *bwmon, bool clear_all)
 	 * before we try to clear the IRQ or do any other counter operations.
 	 */
 	regmap_field_force_write(bwmon->regs[F_CLEAR], val);
+	if (bwmon->data->quirks & BWMON_NEEDS_FORCE_CLEAR)
+		regmap_field_force_write(bwmon->regs[F_CLEAR], 0);
 }
 
 static void bwmon_clear_irq(struct icc_bwmon *bwmon)
@@ -364,6 +367,8 @@ static void bwmon_clear_irq(struct icc_bwmon *bwmon)
 	 * interrupt is cleared.
 	 */
 	regmap_field_force_write(bwmon->regs[F_IRQ_CLEAR], BWMON_IRQ_ENABLE_MASK);
+	if (bwmon->data->quirks & BWMON_NEEDS_FORCE_CLEAR)
+		regmap_field_force_write(bwmon->regs[F_IRQ_CLEAR], 0);
 	if (bwmon->data->quirks & BWMON_HAS_GLOBAL_IRQ)
 		regmap_field_force_write(bwmon->regs[F_GLOBAL_IRQ_CLEAR],
 					 BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
@@ -664,6 +669,7 @@ static const struct icc_bwmon_data sc7280_llcc_bwmon_data = {
 	.default_lowbw_kbps = 0,
 	.zone1_thres_count = 16,
 	.zone3_thres_count = 1,
+	.quirks = BWMON_NEEDS_FORCE_CLEAR,
 	.regmap_fields = sdm845_llcc_bwmon_reg_fields,
 	.regmap_cfg = &sdm845_llcc_bwmon_regmap_cfg,
 };
-- 
2.17.1

