Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9655B1778
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiIHIqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiIHIp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:45:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5370BCCD54;
        Thu,  8 Sep 2022 01:45:56 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28886TSc012827;
        Thu, 8 Sep 2022 08:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=sbzlMQxRLXSHn2oAaJG/NLrqWWwmqEr0AuAYOa3DXjE=;
 b=JRX9FDF38q4YRNNht/27fZ1Sef8fDx9/1l7d2J+57swb4PWgt4ATMaP532J+y/KixLAn
 fHAJ09uY2UnguVKPzIBqBQQ24Rqm7CZE7ZrrrNRsYPZ5L128C5OPNhBAF8YM2OMqRH/S
 Fms4HG+tdrqyYq3uqDExqqvwN/2N8EssalUz7hppnbeCo2y3WXItGVC9E/5n2eVyh7Jv
 9JzyCKHBaM+8SBDGowIogxJJwz8Y+OL2JSag5JnnWCkKzUWwLDfQgWMb0GkjKYiZpNVP
 Mpy9mjBwvBq/Uzp/8lrlw4vazGbEw3ZBx3NK5iebRBtBfQyeU83Pkvlcy82RgzNGatb8 Sw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jfbarr9wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 08:45:31 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2888jVQr026585
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Sep 2022 08:45:31 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 8 Sep 2022 01:45:26 -0700
From:   Tao Zhang <quic_taozha@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Tao Zhang <quic_taozha@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <bjorn.andersson@linaro.org>
Subject: [PATCH 1/9] dt-bindings: arm: Add support for DSB element
Date:   Thu, 8 Sep 2022 16:44:57 +0800
Message-ID: <1662626705-13097-2-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1662626705-13097-1-git-send-email-quic_taozha@quicinc.com>
References: <1662626705-13097-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xZBuRCDcWXS94oV7MPH29Ye2AkfOh1D2
X-Proofpoint-ORIG-GUID: xZBuRCDcWXS94oV7MPH29Ye2AkfOh1D2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_06,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 clxscore=1011
 malwarescore=0 mlxscore=0 suspectscore=0 mlxlogscore=976
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080031
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add property "qcom,dsb-elem-size" to support DSB element for TPDA.
Specifies the DSB element size supported by each monitor connected
to the aggregator on each port. Should be specified in pairs (port,
dsb element size).

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
index eb9bfc5..1bb3fdf 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
@@ -40,6 +40,13 @@ properties:
     minItems: 1
     maxItems: 2
 
+  qcom,dsb-elem-size:
+    description: |
+      Specifies the DSB element size supported by each monitor
+      connected to the aggregator on each port. Should be specified
+      in pairs (port, dsb element size).
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
   clocks:
     maxItems: 1
 
@@ -82,6 +89,8 @@ examples:
        compatible = "qcom,coresight-tpda", "arm,primecell";
        reg = <0x6004000 0x1000>;
 
+       qcom,dsb-elem-size = <0 32>;
+
        clocks = <&aoss_qmp>;
        clock-names = "apb_pclk";
 
-- 
2.7.4

