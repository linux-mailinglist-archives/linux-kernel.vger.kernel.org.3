Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A9A499779
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 22:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448401AbiAXVMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 16:12:35 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:6353 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390807AbiAXUqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643057186; x=1674593186;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=GRbUMXJdZdTwUnYKR/ryNDqpfjnJkqgWc+WnYEkkLro=;
  b=evgr4pyi8HwMiTnEnnSnaaPsR3vRS9aHceyf1hh7GnzAgViff9/4j1Pg
   thxPw7XuPrwTKBPDgYVHxJ1Vlk0Qcz6pRnOC8K2rDi93rwYDyvuGwxsp8
   K2qZNLZwXJqSMWUsFRFz8bzHNHh9SW4ZtwkiC3fr5BtmlPCV5uk7IWHk8
   I=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 24 Jan 2022 12:46:23 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 12:46:22 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 24 Jan 2022 12:46:20 -0800
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 24 Jan 2022 12:46:20 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <robdclark@gmail.com>, <sean@poorly.run>, <swboyd@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <bjorn.andersson@linaro.org>
CC:     <quic_abhinavk@quicinc.com>, <aravindh@codeaurora.org>,
        <quic_khsieh@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/msm/dp: always add fail-safe mode into connector mode list
Date:   Mon, 24 Jan 2022 12:46:10 -0800
Message-ID: <1643057170-10413-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of DP link compliant test expects to return fail-safe mode
if prefer detailed timing mode can not be supported by mainlink's
lane and rate after link training. Therefore add fail-safe mode
into connector mode list as backup mode. This patch fixes test
case 4.2.2.1.

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_panel.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index 3b02922..7743b45 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -221,6 +221,11 @@ int dp_panel_read_sink_caps(struct dp_panel *dp_panel,
 		if (drm_add_modes_noedid(connector, 640, 480))
 			drm_set_preferred_mode(connector, 640, 480);
 		mutex_unlock(&connector->dev->mode_config.mutex);
+	} else {
+		/* always add fail-safe mode as backup mode */
+		mutex_lock(&connector->dev->mode_config.mutex);
+		drm_add_modes_noedid(connector, 640, 480);
+		mutex_unlock(&connector->dev->mode_config.mutex);
 	}
 
 	if (panel->aux_cfg_update_done) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

