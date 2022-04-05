Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161C24F4C82
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578587AbiDEXYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573209AbiDESTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:19:19 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC7CEF087;
        Tue,  5 Apr 2022 11:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649182639; x=1680718639;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=bwqwyzqwG2MNZKE8hl5seyqxC+Y62bblO4gxfvbXvAY=;
  b=c0yBI+SGBSPZ+KLRNvlpTjPT3mRAO2yJuOtYt9AYWbkBANAcBnw3b7ZF
   jSuX9aTIEB51bizB41sh1Rykjyq5EUYdaBFqbGZJnfdjtNRnZP5zgmuEx
   tjFkqEo4wyFzw6qKjQ4syDMeTh63b6bb/1GvdgO2FYyQAuU3wuiV6wEft
   w=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 05 Apr 2022 11:17:19 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 11:17:19 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Apr 2022 11:17:18 -0700
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Apr 2022 11:17:17 -0700
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
Subject: [PATCH] drm/msm/dp: enhance both connect and disconnect pending_timeout handle
Date:   Tue, 5 Apr 2022 11:17:07 -0700
Message-ID: <1649182627-8068-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HPD plugin handle is responsible for setting up main link and depend on
user space frame work to start video stream. Similarly, HPD unplugged
handle is responsible for tearing down main link and depend on user space
frame work to stop video stream. Connect_pending_timeout and disconnect_
pending_timeout are fired after 5 seconds timer expired to tear down main
link and video stream and restore DP driver state into known default
DISCONNECTED state in the case of frame work does not response uevent
original from DP driver so that DP driver can recover gracefully.

The original connect_pending_timeout and disconnect_pending_timeout were
not implemented correctly. This patch enhance both timeout functions to
tear down main link and video stream correctly once timer is fired.

Fixes: 8ede2ecc3e5e ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 34 ++++++++++++++++++++++++--
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  1 +
 drivers/gpu/drm/msm/dp/dp_display.c | 48 +++++++++++++++++++++++++++----------
 3 files changed, 68 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index dcd0126..3f4cf6d 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1910,7 +1910,7 @@ int dp_ctrl_off_link_stream(struct dp_ctrl *dp_ctrl)
 	return ret;
 }
 
-int dp_ctrl_off(struct dp_ctrl *dp_ctrl)
+int dp_ctrl_off_link(struct dp_ctrl *dp_ctrl)
 {
 	struct dp_ctrl_private *ctrl;
 	struct dp_io *dp_io;
@@ -1926,7 +1926,37 @@ int dp_ctrl_off(struct dp_ctrl *dp_ctrl)
 
 	dp_catalog_ctrl_mainlink_ctrl(ctrl->catalog, false);
 
-	dp_catalog_ctrl_reset(ctrl->catalog);
+	ret = dp_power_clk_enable(ctrl->power, DP_CTRL_PM, false);
+	if (ret) {
+		DRM_ERROR("Failed to disable link clocks. ret=%d\n", ret);
+	}
+
+	DRM_DEBUG_DP("Before, phy=%x init_count=%d power_on=%d\n",
+		(u32)(uintptr_t)phy, phy->init_count, phy->power_count);
+
+	phy_power_off(phy);
+
+	DRM_DEBUG_DP("After, phy=%x init_count=%d power_on=%d\n",
+		(u32)(uintptr_t)phy, phy->init_count, phy->power_count);
+
+	return ret;
+}
+
+int dp_ctrl_off(struct dp_ctrl *dp_ctrl)
+{
+	struct dp_ctrl_private *ctrl;
+	struct dp_io *dp_io;
+	struct phy *phy;
+	int ret = 0;
+
+	if (!dp_ctrl)
+		return -EINVAL;
+
+	ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
+	dp_io = &ctrl->parser->io;
+	phy = dp_io->phy;
+
+	dp_catalog_ctrl_mainlink_ctrl(ctrl->catalog, false);
 
 	ret = dp_power_clk_enable(ctrl->power, DP_STREAM_PM, false);
 	if (ret)
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 2433edb..ffafe17 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -22,6 +22,7 @@ struct dp_ctrl {
 int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl);
 int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl);
 int dp_ctrl_off_link_stream(struct dp_ctrl *dp_ctrl);
+int dp_ctrl_off_link(struct dp_ctrl *dp_ctrl);
 int dp_ctrl_off(struct dp_ctrl *dp_ctrl);
 void dp_ctrl_push_idle(struct dp_ctrl *dp_ctrl);
 void dp_ctrl_isr(struct dp_ctrl *dp_ctrl);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 178b774..56bf7c5 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -593,10 +593,16 @@ static int dp_connect_pending_timeout(struct dp_display_private *dp, u32 data)
 
 	mutex_lock(&dp->event_mutex);
 
+	/*
+	 * main link had been setup but video is not ready yet
+	 * only tear down main link
+	 */
 	state = dp->hpd_state;
 	if (state == ST_CONNECT_PENDING) {
-		dp->hpd_state = ST_CONNECTED;
 		DRM_DEBUG_DP("type=%d\n", dp->dp_display.connector_type);
+		dp_ctrl_off_link(dp->ctrl);
+		dp_display_host_phy_exit(dp);
+		dp->hpd_state = ST_DISCONNECTED;
 	}
 
 	mutex_unlock(&dp->event_mutex);
@@ -645,6 +651,7 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
 		if (dp->link->sink_count == 0) {
 			dp_display_host_phy_exit(dp);
 		}
+		dp_display_usbpd_disconnect_cb(&dp->pdev->dev);
 		mutex_unlock(&dp->event_mutex);
 		return 0;
 	}
@@ -661,19 +668,19 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
 		return 0;
 	}
 
-	dp->hpd_state = ST_DISCONNECT_PENDING;
-
 	/* disable HPD plug interrupts */
 	dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_PLUG_INT_MASK, false);
 
-	/*
-	 * We don't need separate work for disconnect as
-	 * connect/attention interrupts are disabled
-	 */
 	dp_display_usbpd_disconnect_cb(&dp->pdev->dev);
 
-	/* start sentinel checking in case of missing uevent */
-	dp_add_event(dp, EV_DISCONNECT_PENDING_TIMEOUT, 0, DP_TIMEOUT_5_SECOND);
+	if (state == ST_DISPLAY_OFF) {
+		dp->hpd_state = ST_DISCONNECTED;
+
+	} else {
+		/* start sentinel checking in case of missing uevent */
+		dp_add_event(dp, EV_DISCONNECT_PENDING_TIMEOUT, 0, DP_TIMEOUT_5_SECOND);
+		dp->hpd_state = ST_DISCONNECT_PENDING;
+	}
 
 	/* signal the disconnect event early to ensure proper teardown */
 	dp_display_handle_plugged_change(&dp->dp_display, false);
@@ -695,10 +702,16 @@ static int dp_disconnect_pending_timeout(struct dp_display_private *dp, u32 data
 
 	mutex_lock(&dp->event_mutex);
 
+	/*
+	 * main link had been set up and video is ready
+	 * tear down main link, video stream and phy
+	 */
 	state =  dp->hpd_state;
 	if (state == ST_DISCONNECT_PENDING) {
-		dp->hpd_state = ST_DISCONNECTED;
 		DRM_DEBUG_DP("type=%d\n", dp->dp_display.connector_type);
+		dp_ctrl_off(dp->ctrl);
+		dp_display_host_phy_exit(dp);
+		dp->hpd_state = ST_DISCONNECTED;
 	}
 
 	mutex_unlock(&dp->event_mutex);
@@ -1571,6 +1584,12 @@ int msm_dp_display_enable(struct msm_dp *dp, struct drm_encoder *encoder)
 
 	mutex_lock(&dp_display->event_mutex);
 
+	state =  dp_display->hpd_state;
+	if (state == ST_DISCONNECTED) {
+		mutex_unlock(&dp_display->event_mutex);
+		return rc;
+	}
+
 	/* stop sentinel checking */
 	dp_del_event(dp_display, EV_CONNECT_PENDING_TIMEOUT);
 
@@ -1588,8 +1607,6 @@ int msm_dp_display_enable(struct msm_dp *dp, struct drm_encoder *encoder)
 		return rc;
 	}
 
-	state =  dp_display->hpd_state;
-
 	if (state == ST_DISPLAY_OFF)
 		dp_display_host_phy_init(dp_display);
 
@@ -1638,13 +1655,18 @@ int msm_dp_display_disable(struct msm_dp *dp, struct drm_encoder *encoder)
 	/* stop sentinel checking */
 	dp_del_event(dp_display, EV_DISCONNECT_PENDING_TIMEOUT);
 
+	state =  dp_display->hpd_state;
+	if (state == ST_DISCONNECTED || state == ST_DISPLAY_OFF) {
+		mutex_unlock(&dp_display->event_mutex);
+		return rc;
+	}
+
 	dp_display_disable(dp_display, 0);
 
 	rc = dp_display_unprepare(dp);
 	if (rc)
 		DRM_ERROR("DP display unprepare failed, rc=%d\n", rc);
 
-	state =  dp_display->hpd_state;
 	if (state == ST_DISCONNECT_PENDING) {
 		/* completed disconnection */
 		dp_display->hpd_state = ST_DISCONNECTED;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

