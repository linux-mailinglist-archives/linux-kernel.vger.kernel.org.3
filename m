Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5555A0294
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 22:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240410AbiHXUQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 16:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240358AbiHXUQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 16:16:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24811A057;
        Wed, 24 Aug 2022 13:16:09 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OJrl6W014974;
        Wed, 24 Aug 2022 20:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=NREg/Sv5sTCvtzp8T5q5YOmhz1/flsdDP2vCt31PiQU=;
 b=UOmrbz5hqN9qkK9fi0hr95ozx4cbIc9g3T5KwToh2hEYB8Tj95JD/CIeBJt5X/mnLyw+
 4S77XyEOr0D63mTGDq1Kepy/pD9QOnpO5le4TxRfvTNeaOJUY4xa+9awpBI0dNdjPeoi
 w7qI2RtfLr812quRDdW2tG1QiJbX4Fwc2ecZmIGvouVnD+BkE85ScVFTLnMNdEJgFRKa
 9kz5yss0QXApBR6/b8BJyAQrTkRawi6tDeMvI9tQskABRE+j8JWTQBK1st9qSYvCdjRN
 MWMP/Tb6tKGToTlfVs+qSwzVBS1oChy+THUQAnUdANVJ/oK8UhipzLg7uP2ZMi4Ert0Y vQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j52pqcmkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 20:16:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27OKFxhG001578
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 20:15:59 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 24 Aug 2022 13:15:59 -0700
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <robdclark@gmail.com>, <sean@poorly.run>, <swboyd@chromium.org>,
        <dianders@chromium.org>, <vkoul@kernel.org>, <daniel@ffwll.ch>,
        <airlied@linux.ie>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <bjorn.andersson@linaro.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_khsieh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] drm/msm/dp: correct 1.62G link rate at dp_catalog_ctrl_config_msa()
Date:   Wed, 24 Aug 2022 13:15:50 -0700
Message-ID: <1661372150-3764-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QAkP6ZLvjdAqupe2hmG4G8KPKs3X9rWl
X-Proofpoint-GUID: QAkP6ZLvjdAqupe2hmG4G8KPKs3X9rWl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_12,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 clxscore=1011 adultscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208240074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At current implementation there is an extra 0 at 1.62G link rate which cause
no correct pixel_div selected for 1.62G link rate to calculate mvid and nvid.
This patch delete the extra 0 to have mvid and nvid be calculated correctly.

Changes in v2:
-- fix Fixes tag's text

Changes in v3:
-- fix misspelling of "Reviewed-by"

Fixes: 937f941ca06f  ("drm/msm/dp: Use qmp phy for DP PLL and PHY")
Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_catalog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index 7257515..676279d 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -431,7 +431,7 @@ void dp_catalog_ctrl_config_msa(struct dp_catalog *dp_catalog,
 
 	if (rate == link_rate_hbr3)
 		pixel_div = 6;
-	else if (rate == 1620000 || rate == 270000)
+	else if (rate == 162000 || rate == 270000)
 		pixel_div = 2;
 	else if (rate == link_rate_hbr2)
 		pixel_div = 4;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

