Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56C05B0DF2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiIGURN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiIGURK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:17:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BA1816B5;
        Wed,  7 Sep 2022 13:17:09 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287JnlRV020295;
        Wed, 7 Sep 2022 20:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=AEomfu5q9BkFL7Ui8nDyjuCkqZfZnLic+5HhcVW4ZoA=;
 b=jvFnJ5FuCmFc5dLitwD8+v4o1KTy4+AkzyeaE8igUmn93GN8ju0LQ//JFYPD70guzLqG
 zyMD9jtL8uSVy4/eWRVW6Khs/s8GbiPEnmR8DYrvJ2dbZn2YJXIUDv3ZrjiXdnl1OHMQ
 l0NftsRuuycH/GuD+PYVOcaWjwaBCgQpDIhILGYQ8nGgytYn8IvKaG74uTqOg5aVnpUP
 ZCmrzZgtIiPvpM60e2gu5H1Pw7MmdmBelCgDc3G23KC/CxeonWXAveHN5gx4Ex7SD6VT
 VQoouH83mZ6MLGq0aRQ3QyGf2VjnoTUJ2BhlFUhEAuQHU7YeWd8olqj2AuvF9SECoRVQ Lg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jf1swr1pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 20:17:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 287KH2Ye004226
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Sep 2022 20:17:02 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 7 Sep 2022 13:17:01 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <konrad.dybcio@somainline.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        David Collins <quic_collinsd@quicinc.com>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH 1/4] pinctrl: qcom: spmi-gpio: add support for LV_VIN2 and MV_VIN3 subtypes
Date:   Wed, 7 Sep 2022 13:15:27 -0700
Message-ID: <20220907201528.9351-2-quic_amelende@quicinc.com>
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
X-Proofpoint-GUID: nHd9QG11baA7ShCQ0MY_LufuI3kI7bNZ
X-Proofpoint-ORIG-GUID: nHd9QG11baA7ShCQ0MY_LufuI3kI7bNZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_10,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 malwarescore=0 clxscore=1011 mlxlogscore=983
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209070076
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Collins <quic_collinsd@quicinc.com>

Add support for SPMI PMIC GPIO subtypes GPIO_LV_VIN2 and
GPIO_MV_VIN3.

GPIO_LV_VIN2 GPIOs support two input reference voltages: VIN0 and
VIN1.  These are typically connected to 1.8 V and 1.2 V supplies
respectively.

GPIO_MV_VIN3 GPIOs support three input reference voltages: VIN0,
VIN1, and VIN2.  These are typically connected to Vph, 1.8 V, and
1.2 V supplies respectively.

Signed-off-by: David Collins <quic_collinsd@quicinc.com>
Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index ccaf40a9c0e6..cf6b6047de8d 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2012-2014, 2016-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/gpio/driver.h>
@@ -36,6 +37,8 @@
 #define PMIC_GPIO_SUBTYPE_GPIOC_8CH		0xd
 #define PMIC_GPIO_SUBTYPE_GPIO_LV		0x10
 #define PMIC_GPIO_SUBTYPE_GPIO_MV		0x11
+#define PMIC_GPIO_SUBTYPE_GPIO_LV_VIN2		0x12
+#define PMIC_GPIO_SUBTYPE_GPIO_MV_VIN3		0x13
 
 #define PMIC_MPP_REG_RT_STS			0x10
 #define PMIC_MPP_REG_RT_STS_VAL_MASK		0x1
@@ -823,6 +826,16 @@ static int pmic_gpio_populate(struct pmic_gpio_state *state,
 		pad->have_buffer = true;
 		pad->lv_mv_type = true;
 		break;
+	case PMIC_GPIO_SUBTYPE_GPIO_LV_VIN2:
+		pad->num_sources = 2;
+		pad->have_buffer = true;
+		pad->lv_mv_type = true;
+		break;
+	case PMIC_GPIO_SUBTYPE_GPIO_MV_VIN3:
+		pad->num_sources = 3;
+		pad->have_buffer = true;
+		pad->lv_mv_type = true;
+		break;
 	default:
 		dev_err(state->dev, "unknown GPIO type 0x%x\n", subtype);
 		return -ENODEV;
-- 
2.35.1

