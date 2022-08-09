Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AF258E14D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343597AbiHIUpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245722AbiHIUpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:45:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430802127B;
        Tue,  9 Aug 2022 13:45:09 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279JdZkR008907;
        Tue, 9 Aug 2022 20:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=IEE0YHiaWW61YmH/j85ir0CvCiEo9J0vpFpZfNkOFUM=;
 b=F5BfVaDcYMMED9p/4k+UaxY/T3HlYYvEx5WTevmN6qdTsu+i78hq/mjxLN1z5cU9kTtw
 rciyrHQp4niPYGSdpY5dGweDEiqGFek8tEfhJXhufnuwUk+V7bXR66SK+24cJbeIfPEa
 mI7lV8cYCNYj15jiACrApngqpAPRlCdvbCQy7EzvVTZfChG05aqQZ/Yzk0M61+0ADCOI
 6cQ/4C2YQPWnuSrXgZMj34NVDywxJRjofZ4Z3gJIvGTms/dKK7JItuGQ03aGvM2WKBUU
 F0Mk8Kz55rhcxS/4Bor7Cs2Ze7JSvNqvGisv17XjvQsj69sfA8TyrWAHQ0p2D+4FQ3QZ hg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3huwr5g4s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 20:45:01 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 279Kj0rF004101
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 Aug 2022 20:45:00 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 9 Aug 2022 13:45:00 -0700
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 9 Aug 2022 13:44:59 -0700
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <robdclark@gmail.com>, <sean@poorly.run>, <swboyd@chromium.org>,
        <dianders@chromium.org>, <vkoul@kernel.org>, <daniel@ffwll.ch>,
        <airlied@linux.ie>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <bjorn.andersson@linaro.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_khsieh@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/msm/dp: check hpd_state before push idle pattern at dp_bridge_disable()
Date:   Tue, 9 Aug 2022 13:44:50 -0700
Message-ID: <1660077890-31622-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AetsPD28bEHPnV7Wmy05NjwCeOGwWvSL
X-Proofpoint-ORIG-GUID: AetsPD28bEHPnV7Wmy05NjwCeOGwWvSL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208090076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dp_bridge_disable() is the first step toward tearing down main link.
Its major function is to start transmitting idle pattern to replace
video stream. This patch will check hpd_state to make sure main link
is enabled before commit changes of main link's configuration to
push idle pattern out to avoid system crashing due to main link clock
is disabled while access main link registers.

Fixes: 13ea4799a81b ("drm/msm/dp: remove extra wrappers and public functions");
Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>

Reported-by: Leonard Lausen @leezu
---
 drivers/gpu/drm/msm/dp/dp_display.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index b36f8b6..678289a 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1729,10 +1729,20 @@ void dp_bridge_disable(struct drm_bridge *drm_bridge)
 	struct msm_dp_bridge *dp_bridge = to_dp_bridge(drm_bridge);
 	struct msm_dp *dp = dp_bridge->dp_display;
 	struct dp_display_private *dp_display;
+	u32 state;
 
 	dp_display = container_of(dp, struct dp_display_private, dp_display);
 
+	mutex_lock(&dp_display->event_mutex);
+
+	state = dp_display->hpd_state;
+	if (state != ST_DISCONNECT_PENDING && state != ST_CONNECTED) {
+		mutex_unlock(&dp_display->event_mutex);
+		return;
+	}
+
 	dp_ctrl_push_idle(dp_display->ctrl);
+	mutex_unlock(&dp_display->event_mutex);
 }
 
 void dp_bridge_post_disable(struct drm_bridge *drm_bridge)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

