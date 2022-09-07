Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DDE5B0DF9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiIGURp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiIGURZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:17:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8DB883CD;
        Wed,  7 Sep 2022 13:17:24 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287CMUxY020249;
        Wed, 7 Sep 2022 20:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=6ivw4az/n8FKIUOTuNY2B8izX/XhumD5cE5d4xOTi6M=;
 b=KiP/Cl/nbRkOGJwaM79L6Upb86BQVtl1vLgpnH/5B6cm0gkqcIcPDV21w1a7u6GNBvZr
 w8CPfK98Lj6Tj/A+12YjWhlmiW0OsXZAg8nP9HI1AuvC62bVqrn3aqphkWPuEthP99Hz
 FXmsGrcoNkkU/uRyLx9D+8kiTC+CsJ05uJIgvTZpOJRcQPx5byCMjQowEM8/Y9ZVBET0
 79qqGIRWcNEEvxBnpf5VxMVZQvI+X2iLxINinNisxL7IFFxr88512a1GeEZH9sOXo6ZF
 0oPoS7TL9AxLoT56+kTFbyLogSd65fQDFT21jgqpyziWeqesYiWIUNN1rA/V6MoVXO3A eQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jenmjtyc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 20:17:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 287KHHk2026893
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Sep 2022 20:17:17 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 7 Sep 2022 13:17:16 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <konrad.dybcio@somainline.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anirudh Ghayal <quic_aghayal@quicinc.com>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH 2/4] pinctrl: qcom: spmi-gpio: Fix the GPIO strength mapping
Date:   Wed, 7 Sep 2022 13:15:29 -0700
Message-ID: <20220907201528.9351-3-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220907201528.9351-1-quic_amelende@quicinc.com>
References: <20220907201528.9351-1-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: f5bfxhcW8K3nxEsdaMq7qDtCbbjJUfmK
X-Proofpoint-ORIG-GUID: f5bfxhcW8K3nxEsdaMq7qDtCbbjJUfmK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_10,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2209070076
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anirudh Ghayal <quic_aghayal@quicinc.com>

The SPMI based PMICs have the HIGH and LOW GPIO output
strength mappings interchanged, fix them.

Keep the mapping same for older SSBI based PMICs.

CRs-Fixed: 2246473
Signed-off-by: Anirudh Ghayal <quic_aghayal@quicinc.com>
Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c     | 2 +-
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c     | 4 ++--
 include/dt-bindings/pinctrl/qcom,pmic-gpio.h | 9 +++++++--
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index cf6b6047de8d..fceccf1ec099 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -525,7 +525,7 @@ static int pmic_gpio_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			pad->pullup = arg;
 			break;
 		case PMIC_GPIO_CONF_STRENGTH:
-			if (arg > PMIC_GPIO_STRENGTH_LOW)
+			if (arg > PMIC_GPIO_STRENGTH_HIGH)
 				return -EINVAL;
 			pad->strength = arg;
 			break;
diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
index 1b41adda8129..0f96d130813b 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2015, Sony Mobile Communications AB.
- * Copyright (c) 2013, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2013, 2018 The Linux Foundation. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -371,7 +371,7 @@ static int pm8xxx_pin_config_set(struct pinctrl_dev *pctldev,
 			banks |= BIT(0);
 			break;
 		case PM8XXX_QCOM_DRIVE_STRENGH:
-			if (arg > PMIC_GPIO_STRENGTH_LOW) {
+			if (arg > PM8921_GPIO_STRENGTH_LOW) {
 				dev_err(pctrl->dev, "invalid drive strength\n");
 				return -EINVAL;
 			}
diff --git a/include/dt-bindings/pinctrl/qcom,pmic-gpio.h b/include/dt-bindings/pinctrl/qcom,pmic-gpio.h
index e5df5ce45a0f..950be952ad3e 100644
--- a/include/dt-bindings/pinctrl/qcom,pmic-gpio.h
+++ b/include/dt-bindings/pinctrl/qcom,pmic-gpio.h
@@ -12,9 +12,14 @@
 #define PMIC_GPIO_PULL_UP_1P5_30	3
 
 #define PMIC_GPIO_STRENGTH_NO		0
-#define PMIC_GPIO_STRENGTH_HIGH		1
+#define PMIC_GPIO_STRENGTH_LOW		1
 #define PMIC_GPIO_STRENGTH_MED		2
-#define PMIC_GPIO_STRENGTH_LOW		3
+#define PMIC_GPIO_STRENGTH_HIGH		3
+
+#define PM8921_GPIO_STRENGTH_NO		0
+#define PM8921_GPIO_STRENGTH_HIGH	1
+#define PM8921_GPIO_STRENGTH_MED	2
+#define PM8921_GPIO_STRENGTH_LOW	3
 
 /*
  * Note: PM8018 GPIO3 and GPIO4 are supporting
-- 
2.35.1

