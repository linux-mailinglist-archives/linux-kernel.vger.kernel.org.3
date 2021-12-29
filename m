Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780BF481633
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 20:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhL2TSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 14:18:33 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:6510 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhL2TSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 14:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640805512; x=1672341512;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=rckRyV7E3Zzp91LYpuq3D5h9Jof+Wh1ct66CwTrgwCc=;
  b=y9pDyqzk0RZvR/BImqLy3DrVcaafNkZ9zdxJY20gfw9e51RRK/YtWtBH
   8LReEPl4xRGlXUY1ztPolPc7RRQlKIv6YOhlMbaXLjAKQS2Q8lpuNmQV6
   IqfZGYWiNX9liE93lm9zyhzQkY0JRJJ6YtTgbv/TpGXPh47WXNlPL08Lq
   c=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 29 Dec 2021 11:18:31 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 11:18:31 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 29 Dec 2021 11:17:10 -0800
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 29 Dec 2021 11:17:09 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <robdclark@gmail.com>, <sean@poorly.run>, <swboyd@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <bjorn.andersson@linaro.org>
CC:     <quic_abhinavk@quicinc.com>, <aravindh@codeaurora.org>,
        <quic_khsieh@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drm/msm/dp:  populate connector of struct  dp_panel
Date:   Wed, 29 Dec 2021 11:17:02 -0800
Message-ID: <1640805422-21904-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is kernel crashed due to unable to handle kernel NULL
pointer dereference of dp_panel->connector while running DP link
layer compliance test case 4.2.2.6 (EDID Corruption Detection).
This patch fixes this problem by populating connector of dp_panel.

[drm:dp_panel_read_sink_caps] *ERROR* panel edid read failed
Unable to handle kernel NULL pointer dereference at virtual address 00000000000006e1
Mem abort info:
  ESR = 0x96000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 39-bit VAs, pgdp=0000000115f25000
[00000000000006e1] pgd=00000001174fe003, p4d=00000001174fe003, pud=00000001174fe003, pmd=0000000000000000
Internal error: Oops: 96000006 [#1] PREEMPT SMP
{...]

Changes in V2:
-- populate panel connector at msm_dp_modeset_init() instead of at dp_panel_read_sink_caps()

Fixes: 7948fe12d47 ("drm/msm/dp: return correct edid checksum after corrupted edid checksum read")
Signee-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 3449d3f..c282bbf 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1495,36 +1495,41 @@ void msm_dp_debugfs_init(struct msm_dp *dp_display, struct drm_minor *minor)
 	}
 }
 
-int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
+int msm_dp_modeset_init(struct msm_dp *dp, struct drm_device *dev,
 			struct drm_encoder *encoder)
 {
 	struct msm_drm_private *priv;
+	struct dp_display_private *dp_display;
 	int ret;
 
-	if (WARN_ON(!encoder) || WARN_ON(!dp_display) || WARN_ON(!dev))
+	if (WARN_ON(!encoder) || WARN_ON(!dp) || WARN_ON(!dev))
 		return -EINVAL;
 
 	priv = dev->dev_private;
-	dp_display->drm_dev = dev;
+	dp->drm_dev = dev;
+
+	dp_display = container_of(dp, struct dp_display_private, dp_display);
 
-	ret = dp_display_request_irq(dp_display);
+	ret = dp_display_request_irq(dp);
 	if (ret) {
 		DRM_ERROR("request_irq failed, ret=%d\n", ret);
 		return ret;
 	}
 
-	dp_display->encoder = encoder;
+	dp->encoder = encoder;
 
-	dp_display->connector = dp_drm_connector_init(dp_display);
-	if (IS_ERR(dp_display->connector)) {
-		ret = PTR_ERR(dp_display->connector);
+	dp->connector = dp_drm_connector_init(dp);
+	if (IS_ERR(dp->connector)) {
+		ret = PTR_ERR(dp->connector);
 		DRM_DEV_ERROR(dev->dev,
 			"failed to create dp connector: %d\n", ret);
-		dp_display->connector = NULL;
+		dp->connector = NULL;
 		return ret;
 	}
 
-	priv->connectors[priv->num_connectors++] = dp_display->connector;
+	dp_display->panel->connector = dp->connector;
+
+	priv->connectors[priv->num_connectors++] = dp->connector;
 	return 0;
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

