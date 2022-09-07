Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9726C5B0E1F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiIGU1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiIGU1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:27:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01889C12E0;
        Wed,  7 Sep 2022 13:27:05 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287EBsFe021581;
        Wed, 7 Sep 2022 20:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=V7Zp8bnNFKm8sk1OC/aidJFmR4sJxbalncMUK93Rm6A=;
 b=NTjWryRjPjRCQz2tuhsbn+gAq+Gr4OoWX+DybWJ7GQa8vxMrMLbfCqyAm7W/jgQ+/Qol
 7B0XXi7oLf3jUbl8R5862q6TZreXg0QJg4VYRLwHihH/PCdGxuhj06kpr5PcJS+1XjAE
 jNcmPl6NaYKU+CW1ZjKJGB7UIHcW/WfRY2bDKRnRth4Px8Azd2GFknle8ujo0hdEAlh4
 hWzg9K0sTIl8O7Zq1Mrl5jJKrvE+x4HkdYZx6Nu49XHpV/f4ojWth5TZJO1Q4mOpEgsh
 DonStUmHSJeatXFbFT5SoDa6izTEcAoPwhRFv0AafkcV5+576sltejq/C9YckKV8/Xat lg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jdys778s6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 20:26:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 287KGmCr026722
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Sep 2022 20:16:48 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 7 Sep 2022 13:16:47 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <konrad.dybcio@somainline.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH 0/4] Add Support for Qualcomm SPMI GPIOs
Date:   Wed, 7 Sep 2022 13:15:25 -0700
Message-ID: <20220907201528.9351-1-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -aqcnoGr80010ZSLzIUq95nxJuMfFjBU
X-Proofpoint-ORIG-GUID: -aqcnoGr80010ZSLzIUq95nxJuMfFjBU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_10,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=755 phishscore=0 spamscore=0 clxscore=1015 mlxscore=0
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

This series provides support and fixes for Qualcomm SPMI GPIOs.

Anirudh Ghayal (1):
  pinctrl: qcom: spmi-gpio: Fix the GPIO strength mapping

Anjelique Melendez (1):
  dt-bindings: qcom-pmic-gpio: Add PM7250B and PM8450 bindings

David Collins (1):
  pinctrl: qcom: spmi-gpio: add support for LV_VIN2 and MV_VIN3 subtypes

Jishnu Prakash (1):
  pinctrl: qcom: spmi-gpio: Add compatible for PM7250B

 .../bindings/pinctrl/qcom,pmic-gpio.yaml         |  3 +++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c         | 16 +++++++++++++++-
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c         |  4 ++--
 include/dt-bindings/pinctrl/qcom,pmic-gpio.h     |  9 +++++++--
 4 files changed, 27 insertions(+), 5 deletions(-)

-- 
2.35.1

