Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C504BA86B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244400AbiBQSgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:36:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244526AbiBQSgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:36:04 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F22525D6;
        Thu, 17 Feb 2022 10:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645122944; x=1676658944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=CVGWO2cq6af7jlW7ULfEWFxp07HokJNmQlycwE5MLL4=;
  b=ydwGg09QjrVlVh7yC2R+yuUwiLKmhcMP9ZjFy/y0crPq9+d8+ocA2E4s
   WjtzMop8DvQDQXIGZ7GnBRDMbfpthRp/QWrePL20IbBRnJz6AoRKhaC5g
   VKTBHds23fLbFRt15AtLwGyzzt8j9dhAEDWAfKItMNk0j7ljIpt2s8YXn
   I=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 17 Feb 2022 10:35:44 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 10:35:43 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 17 Feb 2022 10:35:43 -0800
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 17 Feb 2022 10:35:42 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <vkoul@kernel.org>,
        <daniel@ffwll.ch>, <airlied@linux.ie>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <bjorn.andersson@linaro.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/3] drm/msm/dp: add connector type to enhance debug messages
Date:   Thu, 17 Feb 2022 10:35:28 -0800
Message-ID: <1645122930-23863-2-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645122930-23863-1-git-send-email-quic_khsieh@quicinc.com>
References: <1645122930-23863-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DP driver is a generic driver which supports both eDP and DP.
For debugging purpose it is required to have capabilities to
differentiate message are generated from eDP or DP. This patch
add connector type into debug messages for this purpose.

Changes in v3:
-- replace original patch into 3 patches

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 71 ++++++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 1d7f82e..01371dd 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -375,8 +375,9 @@ static int dp_display_process_hpd_high(struct dp_display_private *dp)
 
 static void dp_display_host_phy_init(struct dp_display_private *dp)
 {
-	DRM_DEBUG_DP("core_init=%d phy_init=%d\n",
-			dp->core_initialized, dp->phy_initialized);
+	DRM_DEBUG_DP("type=%d core_init=%d phy_init=%d\n",
+		dp->dp_display.connector_type, dp->core_initialized,
+		dp->phy_initialized);
 
 	if (!dp->phy_initialized) {
 		dp_ctrl_phy_init(dp->ctrl);
@@ -386,8 +387,9 @@ static void dp_display_host_phy_init(struct dp_display_private *dp)
 
 static void dp_display_host_phy_exit(struct dp_display_private *dp)
 {
-	DRM_DEBUG_DP("core_init=%d phy_init=%d\n",
-			dp->core_initialized, dp->phy_initialized);
+	DRM_DEBUG_DP("type=%d core_init=%d phy_init=%d\n",
+		dp->dp_display.connector_type, dp->core_initialized,
+		dp->phy_initialized);
 
 	if (dp->phy_initialized) {
 		dp_ctrl_phy_exit(dp->ctrl);
@@ -397,7 +399,9 @@ static void dp_display_host_phy_exit(struct dp_display_private *dp)
 
 static void dp_display_host_init(struct dp_display_private *dp)
 {
-	DRM_DEBUG_DP("core_initialized=%d\n", dp->core_initialized);
+	DRM_DEBUG_DP("type=%d core_init=%d phy_init=%d\n",
+		dp->dp_display.connector_type, dp->core_initialized,
+		dp->phy_initialized);
 
 	dp_power_init(dp->power, false);
 	dp_ctrl_reset_irq_ctrl(dp->ctrl, true);
@@ -407,7 +411,9 @@ static void dp_display_host_init(struct dp_display_private *dp)
 
 static void dp_display_host_deinit(struct dp_display_private *dp)
 {
-	DRM_DEBUG_DP("core_initialized=%d\n", dp->core_initialized);
+	DRM_DEBUG_DP("type=%d core_init=%d phy_init=%d\n",
+		dp->dp_display.connector_type, dp->core_initialized,
+		dp->phy_initialized);
 
 	dp_ctrl_reset_irq_ctrl(dp->ctrl, false);
 	dp_aux_deinit(dp->aux);
@@ -517,7 +523,9 @@ static int dp_hpd_plug_handle(struct dp_display_private *dp, u32 data)
 	mutex_lock(&dp->event_mutex);
 
 	state =  dp->hpd_state;
-	DRM_DEBUG_DP("hpd_state=%d\n", state);
+	DRM_DEBUG_DP("Before, type=%d hpd_state=%d\n",
+			dp->dp_display.connector_type, state);
+
 	if (state == ST_DISPLAY_OFF || state == ST_SUSPENDED) {
 		mutex_unlock(&dp->event_mutex);
 		return 0;
@@ -549,6 +557,8 @@ static int dp_hpd_plug_handle(struct dp_display_private *dp, u32 data)
 	dp_catalog_hpd_config_intr(dp->catalog,
 		DP_DP_IRQ_HPD_INT_MASK | DP_DP_HPD_REPLUG_INT_MASK, true);
 
+	DRM_DEBUG_DP("After, type=%d hpd_state=%d\n",
+			dp->dp_display.connector_type, state);
 	mutex_unlock(&dp->event_mutex);
 
 	/* uevent will complete connection part */
@@ -565,8 +575,10 @@ static int dp_connect_pending_timeout(struct dp_display_private *dp, u32 data)
 	mutex_lock(&dp->event_mutex);
 
 	state = dp->hpd_state;
-	if (state == ST_CONNECT_PENDING)
+	if (state == ST_CONNECT_PENDING) {
 		dp->hpd_state = ST_CONNECTED;
+		DRM_DEBUG_DP("type=%d\n", dp->dp_display.connector_type);
+	}
 
 	mutex_unlock(&dp->event_mutex);
 
@@ -599,6 +611,9 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
 
 	state = dp->hpd_state;
 
+	DRM_DEBUG_DP("Before, type=%d hpd_state=%d\n",
+			dp->dp_display.connector_type, state);
+
 	/* disable irq_hpd/replug interrupts */
 	dp_catalog_hpd_config_intr(dp->catalog,
 		DP_DP_IRQ_HPD_INT_MASK | DP_DP_HPD_REPLUG_INT_MASK, false);
@@ -641,13 +656,15 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
 	/* start sentinel checking in case of missing uevent */
 	dp_add_event(dp, EV_DISCONNECT_PENDING_TIMEOUT, 0, DP_TIMEOUT_5_SECOND);
 
-	DRM_DEBUG_DP("hpd_state=%d\n", state);
 	/* signal the disconnect event early to ensure proper teardown */
 	dp_display_handle_plugged_change(&dp->dp_display, false);
 
 	/* enable HDP plug interrupt to prepare for next plugin */
 	dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_PLUG_INT_MASK, true);
 
+	DRM_DEBUG_DP("After, type=%d hpd_state=%d\n",
+			dp->dp_display.connector_type, state);
+
 	/* uevent will complete disconnection part */
 	mutex_unlock(&dp->event_mutex);
 	return 0;
@@ -660,8 +677,10 @@ static int dp_disconnect_pending_timeout(struct dp_display_private *dp, u32 data
 	mutex_lock(&dp->event_mutex);
 
 	state =  dp->hpd_state;
-	if (state == ST_DISCONNECT_PENDING)
+	if (state == ST_DISCONNECT_PENDING) {
 		dp->hpd_state = ST_DISCONNECTED;
+		DRM_DEBUG_DP("type=%d\n", dp->dp_display.connector_type);
+	}
 
 	mutex_unlock(&dp->event_mutex);
 
@@ -676,6 +695,9 @@ static int dp_irq_hpd_handle(struct dp_display_private *dp, u32 data)
 
 	/* irq_hpd can happen at either connected or disconnected state */
 	state =  dp->hpd_state;
+	DRM_DEBUG_DP("Before, type=%d hpd_state=%d\n",
+			dp->dp_display.connector_type, state);
+
 	if (state == ST_DISPLAY_OFF || state == ST_SUSPENDED) {
 		mutex_unlock(&dp->event_mutex);
 		return 0;
@@ -697,7 +719,8 @@ static int dp_irq_hpd_handle(struct dp_display_private *dp, u32 data)
 
 	dp_display_usbpd_attention_cb(&dp->pdev->dev);
 
-	DRM_DEBUG_DP("hpd_state=%d\n", state);
+	DRM_DEBUG_DP("After, type=%d hpd_state=%d\n",
+			dp->dp_display.connector_type, state);
 
 	mutex_unlock(&dp->event_mutex);
 
@@ -1147,8 +1170,9 @@ static irqreturn_t dp_display_irq_handler(int irq, void *dev_id)
 
 	hpd_isr_status = dp_catalog_hpd_get_intr_status(dp->catalog);
 
-	DRM_DEBUG_DP("hpd isr status=%#x\n", hpd_isr_status);
 	if (hpd_isr_status & 0x0F) {
+		DRM_DEBUG_DP("type=%d isr=0x%x\n",
+			dp->dp_display.connector_type, hpd_isr_status);
 		/* hpd related interrupts */
 		if (hpd_isr_status & DP_DP_HPD_PLUG_INT_MASK)
 			dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
@@ -1301,8 +1325,9 @@ static int dp_pm_resume(struct device *dev)
 
 	mutex_lock(&dp->event_mutex);
 
-	DRM_DEBUG_DP("Before, core_inited=%d power_on=%d\n",
-			dp->core_initialized, dp_display->power_on);
+	DRM_DEBUG_DP("Before, type=%d core_inited=%d phy_inited=%d power_on=%d\n",
+		dp->dp_display.connector_type, dp->core_initialized,
+		dp->phy_initialized, dp_display->power_on);
 
 	/* start from disconnected state */
 	dp->hpd_state = ST_DISCONNECTED;
@@ -1341,9 +1366,11 @@ static int dp_pm_resume(struct device *dev)
 		dp_display_handle_plugged_change(dp_display, false);
 	}
 
-	DRM_DEBUG_DP("After, sink_count=%d is_connected=%d core_inited=%d power_on=%d\n",
-			dp->link->sink_count, dp->dp_display.is_connected,
-			dp->core_initialized, dp_display->power_on);
+	DRM_DEBUG_DP("After, type=%d sink_count=%d is_connected=%d \
+			core_inited=%d phy_inited=%d power_on=%d\n",
+		dp->dp_display.connector_type, dp->link->sink_count,
+		dp->dp_display.is_connected, dp->core_initialized,
+		dp->phy_initialized, dp_display->power_on);
 
 	mutex_unlock(&dp->event_mutex);
 
@@ -1360,8 +1387,9 @@ static int dp_pm_suspend(struct device *dev)
 
 	mutex_lock(&dp->event_mutex);
 
-	DRM_DEBUG_DP("Before, core_inited=%d power_on=%d\n",
-			dp->core_initialized, dp_display->power_on);
+	DRM_DEBUG_DP("Before, type=%d core_inited=%d phy_inited=%d power_on=%d\n",
+		dp->dp_display.connector_type, dp->core_initialized,
+		dp->phy_initialized, dp_display->power_on);
 
 	/* mainlink enabled */
 	if (dp_power_clk_status(dp->power, DP_CTRL_PM))
@@ -1374,8 +1402,9 @@ static int dp_pm_suspend(struct device *dev)
 
 	dp->hpd_state = ST_SUSPENDED;
 
-	DRM_DEBUG_DP("After, core_inited=%d power_on=%d\n",
-			dp->core_initialized, dp_display->power_on);
+	DRM_DEBUG_DP("After, type=%d core_inited=%d phy_inited=%d power_on=%d\n",
+		dp->dp_display.connector_type, dp->core_initialized,
+		dp->phy_initialized, dp_display->power_on);
 
 	mutex_unlock(&dp->event_mutex);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

