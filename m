Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2E05B0D8B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 21:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiIGTz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 15:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiIGTz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 15:55:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19B2A3442;
        Wed,  7 Sep 2022 12:55:52 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287FKJrJ004370;
        Wed, 7 Sep 2022 19:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=sV9sflD8m2T6c3D6xglb1bReqO/oOHIt1LPwbs2kbDc=;
 b=V4VGiJyD3WfuvJ9sCbALy2GIOjfpQz4yyFkgZ4BWfDey6C6tNn8SKJ4y1G6TcwvpMQN7
 zIeJHRDqxu0qqdiy3kYZy/ntTBKXf4bfRfdDF5hmbciZyQ/7J6GDl+uYVZODNHFGjEI2
 st2cdq0TfazqFmgYdXs65If3VVlts3TtQaJmbKdT3AVNPvlIZ2v8zXwV0yiglcUbSHVH
 KotcdS5eD3ZH7lXrBdfeiusPrFjpj9undiRiOTwb0bQFAwwSFddrOl4Re9i74AwpdDsk
 +U6D3PHh/EOMkV8arKVNHMyTtUFwYAe3GIkY7zaJFh4xacCbjdZpd9tA9lhTRc4F1wUq yg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jef0gksuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 19:55:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 287JojeF008981
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Sep 2022 19:50:45 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 7 Sep 2022 12:50:44 -0700
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <robdclark@gmail.com>, <sean@poorly.run>, <swboyd@chromium.org>,
        <dianders@chromium.org>, <vkoul@kernel.org>, <daniel@ffwll.ch>,
        <airlied@linux.ie>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <bjorn.andersson@linaro.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_khsieh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drm/msm/dp: cleared DP_DOWNSPREAD_CTRL register before start link training
Date:   Wed, 7 Sep 2022 12:50:37 -0700
Message-ID: <1662580237-5684-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: G7q1ciqBt8lnRYAZsETQYFenFkChCK6E
X-Proofpoint-ORIG-GUID: G7q1ciqBt8lnRYAZsETQYFenFkChCK6E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_10,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209070074
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DOWNSPREAD_CTRL (0x107) shall be cleared to 0 upon power-on reset or an
upstream device disconnect. This patch will enforce this rule by always
cleared DOWNPREAD_CTRL register to 0 before start link training. At rare
case that DP MSA timing parameters may be mis-interpreted by the sink
which causes audio sampling rate be calculated wrongly and cause audio
did not work at sink if DOWNSPREAD_CTRL register is not cleared to 0.
This patch also make sure bring sink out of D3 power-down mode into D0
(normal operation mode) successfully by retrying 3 times.

Changes in v2:
1) fix spelling at commit text
2) merge ssc variable into encoding[0]

Fixes: 154b5a7da0fd ("drm/msm/dp: add displayPort driver support")
Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 13 +++++--------
 drivers/gpu/drm/msm/dp/dp_link.c | 17 +++++++++++------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index ab6aa13..1b63220 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1245,8 +1245,7 @@ static int dp_ctrl_link_train(struct dp_ctrl_private *ctrl,
 {
 	int ret = 0;
 	const u8 *dpcd = ctrl->panel->dpcd;
-	u8 encoding = DP_SET_ANSI_8B10B;
-	u8 ssc;
+	u8 encoding[2] = {0, DP_SET_ANSI_8B10B};
 	u8 assr;
 	struct dp_link_info link_info = {0};
 
@@ -1258,13 +1257,11 @@ static int dp_ctrl_link_train(struct dp_ctrl_private *ctrl,
 
 	dp_aux_link_configure(ctrl->aux, &link_info);
 
-	if (drm_dp_max_downspread(dpcd)) {
-		ssc = DP_SPREAD_AMP_0_5;
-		drm_dp_dpcd_write(ctrl->aux, DP_DOWNSPREAD_CTRL, &ssc, 1);
-	}
+	if (drm_dp_max_downspread(dpcd))
+		encoding[0] |= DP_SPREAD_AMP_0_5;
 
-	drm_dp_dpcd_write(ctrl->aux, DP_MAIN_LINK_CHANNEL_CODING_SET,
-				&encoding, 1);
+	/* config DOWNSPREAD_CTRL and MAIN_LINK_CHANNEL_CODING_SET */
+	drm_dp_dpcd_write(ctrl->aux, DP_DOWNSPREAD_CTRL, encoding, 2);
 
 	if (drm_dp_alternate_scrambler_reset_cap(dpcd)) {
 		assr = DP_ALTERNATE_SCRAMBLER_RESET_ENABLE;
diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
index 36f0af0..3ad3826 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.c
+++ b/drivers/gpu/drm/msm/dp/dp_link.c
@@ -49,7 +49,7 @@ static int dp_aux_link_power_up(struct drm_dp_aux *aux,
 					struct dp_link_info *link)
 {
 	u8 value;
-	int err;
+	int i, err;
 
 	if (link->revision < 0x11)
 		return 0;
@@ -61,11 +61,16 @@ static int dp_aux_link_power_up(struct drm_dp_aux *aux,
 	value &= ~DP_SET_POWER_MASK;
 	value |= DP_SET_POWER_D0;
 
-	err = drm_dp_dpcd_writeb(aux, DP_SET_POWER, value);
-	if (err < 0)
-		return err;
-
-	usleep_range(1000, 2000);
+	/*
+	 * When turning on, we need to retry for 1ms to give the sink
+	 * time to wake up.
+	 */
+	for (i = 0; i < 3; i++) {
+	        err = drm_dp_dpcd_writeb(aux, DP_SET_POWER, value);
+		usleep_range(1000, 2000);
+		if (err == 1)
+			break;
+	}
 
 	return 0;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

