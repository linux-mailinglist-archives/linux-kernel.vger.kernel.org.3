Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC12480CA7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhL1Svn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 13:51:43 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:47884 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237122AbhL1Svi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640717498; x=1672253498;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=5Joo2qg1o4pOEw6JsCdFnvpGchiUe4q9GhRjGQU+liw=;
  b=UHqwtfYc0bMAq55Ht6SB7j1we47kklyk8r6i4BE6KgRnaoM9YE7gizmf
   a8Wg98igebuPDzNYnEAWYm/Da+XZ9F3/1olD9cY2zy/0duS6qFaJc2ozw
   ysFj28BjO71cadjFtXVZ+mBVwiiD/3s73tW//ASsDGcXTMFFlfgOcnvT+
   I=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 28 Dec 2021 10:51:38 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 10:51:37 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 28 Dec 2021 10:51:37 -0800
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 28 Dec 2021 10:51:36 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <robdclark@gmail.com>, <sean@poorly.run>, <swboyd@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <bjorn.andersson@linaro.org>
CC:     <quic_abhinavk@quicinc.com>, <aravindh@codeaurora.org>,
        <quic_khsieh@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>
Subject: [PATCH] drm/msm/dp: add support of tps4 (training pattern 4) for HBR3
Date:   Tue, 28 Dec 2021 10:51:29 -0800
Message-ID: <1640717489-7366-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuogee Hsieh <khsieh@codeaurora.org>

Some DP sinkers prefer to use tps4 instead of tps3 during training #2.
This patch will use tps4 to perform link training #2 if sinker's DPCD
supports it.

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 39558a2..c7b0657 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1181,7 +1181,7 @@ static int dp_ctrl_link_train_2(struct dp_ctrl_private *ctrl,
 			int *training_step)
 {
 	int tries = 0, ret = 0;
-	char pattern;
+	char pattern, state_ctrl_bit;
 	int const maximum_retries = 5;
 	u8 link_status[DP_LINK_STATUS_SIZE];
 
@@ -1189,12 +1189,20 @@ static int dp_ctrl_link_train_2(struct dp_ctrl_private *ctrl,
 
 	*training_step = DP_TRAINING_2;
 
-	if (drm_dp_tps3_supported(ctrl->panel->dpcd))
+	if (drm_dp_tps4_supported(ctrl->panel->dpcd)) {
+		pattern = DP_TRAINING_PATTERN_4;
+		state_ctrl_bit = 4;
+	}
+	else if (drm_dp_tps3_supported(ctrl->panel->dpcd)) {
 		pattern = DP_TRAINING_PATTERN_3;
-	else
+		state_ctrl_bit = 3;
+	}
+	else {
 		pattern = DP_TRAINING_PATTERN_2;
+		state_ctrl_bit = 2;
+	}
 
-	ret = dp_catalog_ctrl_set_pattern(ctrl->catalog, pattern);
+	ret = dp_catalog_ctrl_set_pattern(ctrl->catalog, state_ctrl_bit);
 	if (ret)
 		return ret;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

