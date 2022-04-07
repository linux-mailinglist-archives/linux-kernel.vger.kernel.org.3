Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5DB4F8549
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbiDGQyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345874AbiDGQxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:53:37 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA665DE78;
        Thu,  7 Apr 2022 09:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649350297; x=1680886297;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=zWgHs9WoOcSa0eb+PT/FFhzIfcD017bTdrABzx78AoA=;
  b=FUpXUQZ8jDaKyE3dRbEKHSFUqRcJjj/r5XFUdd44utfo5Kd8tXn/qQXO
   nygI5t4BW8BgDf7XtMaEYoZipQAg7m4EcCgp0F1DZcH89nQNOh/iSBtVz
   b71wc56C4R2fkXSQub87TPR13VZ9snRWLklYJY/j0mRsz8zRXSfte1boi
   M=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 07 Apr 2022 09:51:35 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 09:51:35 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Apr 2022 09:51:34 -0700
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Apr 2022 09:51:34 -0700
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <robdclark@gmail.com>, <sean@poorly.run>, <swboyd@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <bjorn.andersson@linaro.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_khsieh@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/msm/dp: add fail safe mode outside of event_mutex context
Date:   Thu, 7 Apr 2022 09:51:26 -0700
Message-ID: <1649350286-11504-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is possible circular locking dependency detected on event_mutex.
To break this possible circular locking, this patch move setting fail
safe mode out of event_mutex scope.

Fixes: d4aca422539c ("drm/msm/dp:  always add fail-safe mode into connector mode list")
Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c |  6 ++++++
 drivers/gpu/drm/msm/dp/dp_panel.c   | 20 ++++++++++----------
 drivers/gpu/drm/msm/dp/dp_panel.h   |  1 +
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 178b774..a42732b 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -580,6 +580,12 @@ static int dp_hpd_plug_handle(struct dp_display_private *dp, u32 data)
 			dp->dp_display.connector_type, state);
 	mutex_unlock(&dp->event_mutex);
 
+	/*
+	 * add fail safe mode outside event_mutex scope
+	 * to avoid potiential circular lock with drm thread
+	 */
+	dp_panel_add_fail_safe_mode(dp->dp_display.connector);
+
 	/* uevent will complete connection part */
 	return 0;
 };
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index f141872..26c3653 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -151,6 +151,15 @@ static int dp_panel_update_modes(struct drm_connector *connector,
 	return rc;
 }
 
+void dp_panel_add_fail_safe_mode(struct drm_connector *connector)
+{
+	/* fail safe edid */
+	mutex_lock(&connector->dev->mode_config.mutex);
+	if (drm_add_modes_noedid(connector, 640, 480))
+		drm_set_preferred_mode(connector, 640, 480);
+	mutex_unlock(&connector->dev->mode_config.mutex);
+}
+
 int dp_panel_read_sink_caps(struct dp_panel *dp_panel,
 	struct drm_connector *connector)
 {
@@ -207,16 +216,7 @@ int dp_panel_read_sink_caps(struct dp_panel *dp_panel,
 			goto end;
 		}
 
-		/* fail safe edid */
-		mutex_lock(&connector->dev->mode_config.mutex);
-		if (drm_add_modes_noedid(connector, 640, 480))
-			drm_set_preferred_mode(connector, 640, 480);
-		mutex_unlock(&connector->dev->mode_config.mutex);
-	} else {
-		/* always add fail-safe mode as backup mode */
-		mutex_lock(&connector->dev->mode_config.mutex);
-		drm_add_modes_noedid(connector, 640, 480);
-		mutex_unlock(&connector->dev->mode_config.mutex);
+		dp_panel_add_fail_safe_mode(connector);
 	}
 
 	if (panel->aux_cfg_update_done) {
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 9023e5b..99739ea 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -59,6 +59,7 @@ int dp_panel_init_panel_info(struct dp_panel *dp_panel);
 int dp_panel_deinit(struct dp_panel *dp_panel);
 int dp_panel_timing_cfg(struct dp_panel *dp_panel);
 void dp_panel_dump_regs(struct dp_panel *dp_panel);
+void dp_panel_add_fail_safe_mode(struct drm_connector *connector);
 int dp_panel_read_sink_caps(struct dp_panel *dp_panel,
 		struct drm_connector *connector);
 u32 dp_panel_get_mode_bpp(struct dp_panel *dp_panel, u32 mode_max_bpp,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

