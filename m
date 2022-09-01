Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7745A8C51
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 06:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiIAESj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 00:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiIAESM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 00:18:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D95161DCB;
        Wed, 31 Aug 2022 21:18:06 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2813DYLx023424;
        Thu, 1 Sep 2022 04:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=hDK80vDpkuXPJNz0zWKF4J/lc/t8yhaBiwQSS2Kg5Do=;
 b=CvtB1Ae/G3M+jVN476uTmkHtTHHB5FnW330Yp7aJwGCx3sHqoqljW0Q7FBTbmbPvmcVl
 Ibc2lCoW2YXKIn91Efdy656hT0/2Q8Yr2TUqisPJ1K6l1vwo6H47Ev07VwFCd3Ntv5SJ
 6LIAq8M8XEx9iZQ0GVrDcyxmCOx3BGJivUL51mNbe1IzDX81n0REZUA1ceokcz9oqbe1
 HINqjdP6TpMGSyUUf3zT9Rq8n9EYF8eZN0Pnjcv15E1lBvdfAsmb0NnMfU6IkdQ3xMLY
 czbgKZ/7SGi8VnCmNL48g/go4BmhVwbDooDfGs1dhqtVG01z0QfTP9JJ6QKEMkPUTbBG 1A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jaaasa81m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 04:18:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2814I1ul013725
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Sep 2022 04:18:01 GMT
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 31 Aug 2022 21:17:58 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tdas@quicinc.com>, <quic_c_skakit@quicinc.com>,
        <linux-clk@vger.kernel.org>
Subject: [PATCH V9 4/5] dt-bindings: clock: Add support for external MCLKs for LPASS on SC7280
Date:   Thu, 1 Sep 2022 09:47:25 +0530
Message-ID: <1662005846-4838-5-git-send-email-quic_c_skakit@quicinc.com>
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
X-Proofpoint-GUID: 7lFzsDccLHQsoB-fjhj7mG3io_RfqdZN
X-Proofpoint-ORIG-GUID: 7lFzsDccLHQsoB-fjhj7mG3io_RfqdZN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_02,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=977 spamscore=0 adultscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Support external mclk to interface external MI2S clocks for SC7280.

Fixes: 4185b27b3bef ("dt-bindings: clock: Add YAML schemas for LPASS clocks on SC7280")
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

