Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09C458E80C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 09:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiHJHrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 03:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiHJHqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 03:46:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDAC6E880;
        Wed, 10 Aug 2022 00:46:47 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A77pFg023911;
        Wed, 10 Aug 2022 07:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=EVrrA2igkIFkqdzYyhExZvBddokYK1TV+gNlMRojUY0=;
 b=RYYImUb9lQlYEhaa2xSIu5Ck8tLbZ62P7wbC0n0mIX7MkJtp3jVBis93Ya0Exzgf9/Fa
 qrGiA24K5D73pa93A5At9A3CYUB/rWmmEaipOnkms4LNjg4qHvRrtCDAVeZec1NZOyPs
 BbcdP5mlXayDeE71mXrRCD76qn0EUxjsXJeNy45lJzlhr/HTSgO/9YOvj5vbGNQAuZHT
 qcjP81yuiThBihBuzWhM22S3Wx6so5qlcDwFgIk9m6Z9/7hIoHn+l/gWKxoqv8B7j2cv
 bmQvNX5ATH9Sb9RLgnCjNbW3xiGGkpbaK15mRU2HF1QBy0f8iCYWj9Qti28lJRu69dfk SA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3huwqm9jsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 07:46:31 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27A7kUa6009639
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 07:46:30 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 10 Aug 2022 00:46:30 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 10 Aug 2022 00:46:24 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v3 1/8] dt-bindings: remoteproc: qcom: adsp: Make ADSP pil loader as generic
Date:   Wed, 10 Aug 2022 13:15:51 +0530
Message-ID: <1660117558-21829-2-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1660117558-21829-1-git-send-email-quic_srivasam@quicinc.com>
References: <1660117558-21829-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vItlZ4c0hq1HNWyu2hQDqsyULdyt5iAC
X-Proofpoint-ORIG-GUID: vItlZ4c0hq1HNWyu2hQDqsyULdyt5iAC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_03,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 impostorscore=0 mlxlogscore=795 bulkscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100022
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename sdm845 adsp pil bindings to generic name, for using same binings
file for subsequent SoCs.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
---
Changes since V2:
	-- Generate patch with -M flag.

 .../{qcom,sdm845-adsp-pil.yaml => qcom,lpass-adsp-pil.yaml}           | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/remoteproc/{qcom,sdm845-adsp-pil.yaml => qcom,lpass-adsp-pil.yaml} (97%)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml
similarity index 97%
rename from Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml
rename to Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml
index 1535bbb..9f11332 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/remoteproc/qcom,sdm845-adsp-pil.yaml#
+$id: http://devicetree.org/schemas/remoteproc/qcom,lpass-adsp-pil.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm SDM845 ADSP Peripheral Image Loader
+title: Qualcomm LPASS ADSP Peripheral Image Loader
 
 maintainers:
   - Bjorn Andersson <bjorn.andersson@linaro.org>
-- 
2.7.4

