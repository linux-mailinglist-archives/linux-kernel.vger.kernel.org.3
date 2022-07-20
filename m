Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB9757B511
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240707AbiGTLEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240724AbiGTLEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:04:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AD16EE8E;
        Wed, 20 Jul 2022 04:04:38 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KApG3B029103;
        Wed, 20 Jul 2022 11:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=+yiE28S9GiMB31UZiLDpjme+Oy8oLHGUb3KhTYXEAi8=;
 b=K7koWS9pQRG1Vt5LIQjMqVgcfAg1DyNbAusSH0byaMFmpWkqsRqvVG+iAEUYOWZ7kwb+
 FvuuiRrD/nHYdtvexw8gdJRb4LLS2RayCqsCw0bVlrfIPnSRDsn/RH0a95IK9VGJ78Fn
 KR8Hjac9OOqnrXYlMABNgIvikbcz2YsKG65E8kOgz8NkPFlz3i6L+MLqRURVn/dEeJZA
 7yN5giH91LpBjJJjukjwnfLQrlqKtOhgpSlzFXzVtl2jPEY+n+wHuCCQ6QV8CvPouERR
 ijXNFdwUN+EZf/KZgbN9xvNJUr6bY6D6gZ0ceaV2lWW+MBmoxs1OZ8GPLQBGKxkLPHlb Mw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3he3ua9pm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 11:04:29 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26KB4SHa003277
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 11:04:28 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 04:04:27 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 04:04:23 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-soc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>,
        <robh+dt@kernel.org>, <quic_tdas@quicinc.com>,
        <quic_c_skakit@quicinc.com>
Subject: [PATCH V6 4/5] dt-bindings: clock: Add support for external MCLKs for LPASS on SC7280
Date:   Wed, 20 Jul 2022 16:33:42 +0530
Message-ID: <1658315023-3336-5-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1658315023-3336-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1658315023-3336-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LXT85g_qT8VnjlAeF3vrKPRiGwTyOYJI
X-Proofpoint-ORIG-GUID: LXT85g_qT8VnjlAeF3vrKPRiGwTyOYJI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_05,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taniya Das <quic_tdas@quicinc.com>

Support external mclk to interface external MI2S clocks for SC7280.

Fixes: 4185b27b3bef ("dt-bindings: clock: Add YAML schemas for LPASS clocks on SC7280").
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 include/dt-bindings/clock/qcom,lpasscorecc-sc7280.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,lpasscorecc-sc7280.h b/include/dt-bindings/clock/qcom,lpasscorecc-sc7280.h
index 28ed2a0..0324c69 100644
--- a/include/dt-bindings/clock/qcom,lpasscorecc-sc7280.h
+++ b/include/dt-bindings/clock/qcom,lpasscorecc-sc7280.h
@@ -19,6 +19,8 @@
 #define LPASS_CORE_CC_LPM_CORE_CLK			9
 #define LPASS_CORE_CC_LPM_MEM0_CORE_CLK			10
 #define LPASS_CORE_CC_SYSNOC_MPORT_CORE_CLK		11
+#define LPASS_CORE_CC_EXT_MCLK0_CLK			12
+#define LPASS_CORE_CC_EXT_MCLK0_CLK_SRC			13
 
 /* LPASS_CORE_CC power domains */
 #define LPASS_CORE_CC_LPASS_CORE_HM_GDSC		0
-- 
2.7.4

