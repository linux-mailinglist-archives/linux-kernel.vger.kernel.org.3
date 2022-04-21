Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE18050A2C0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389456AbiDUOk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389475AbiDUOkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:40:19 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FBF40930;
        Thu, 21 Apr 2022 07:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650551845; x=1682087845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=+qF2GX2hZEj//xn0Ym9Mabjo1aTxa2x08295shLMgqA=;
  b=Emq+lGMxJ4fpa0EkTNXyeMEb43RMi7CQFM0fkhXRRsazTGY3d1J5O/nx
   H0harAWsbijfwJCM2WoHMseDpFiEjUgCB6SZX6TIjvn1vocyTq0penLA6
   cuitli0+uFi1U5t18pnzVLpZym7gtLUmSTjoSWyyYKXQ+Tfg8hJnkE0OK
   Y=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Apr 2022 07:37:25 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 07:37:24 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 21 Apr 2022 07:37:24 -0700
Received: from sbillaka-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 21 Apr 2022 07:37:17 -0700
From:   Sankeerth Billakanti <quic_sbillaka@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        <robdclark@gmail.com>, <seanpaul@chromium.org>,
        <swboyd@chromium.org>, <quic_kalyant@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <dianders@chromium.org>,
        <quic_khsieh@quicinc.com>, <bjorn.andersson@linaro.org>,
        <sean@poorly.run>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dmitry.baryshkov@linaro.org>, <quic_vproddut@quicinc.com>,
        <quic_aravindh@quicinc.com>, <steev@kali.org>
Subject: [PATCH v8 2/4] drm/msm/dp: Support only IRQ_HPD and REPLUG interrupts for eDP
Date:   Thu, 21 Apr 2022 20:06:49 +0530
Message-ID: <1650551811-24319-3-git-send-email-quic_sbillaka@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650551811-24319-1-git-send-email-quic_sbillaka@quicinc.com>
References: <1650551811-24319-1-git-send-email-quic_sbillaka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panel-edp enables the eDP panel power during probe, get_modes
and pre-enable. The eDP connect and disconnect interrupts for the eDP/DP
controller are directly dependent on panel power. As eDP display can be
assumed as always connected, the controller driver can skip the eDP
connect and disconnect interrupts. Any disruption in the link status
will be indicated via the IRQ_HPD interrupts.

So, the eDP controller driver can just enable the IRQ_HPD and replug
interrupts. The DP controller driver still needs to enable all the
interrupts.

Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
---
Changes in v8:
  - add comment explaining the interrupt status return

Changes in v7:
  - reordered the patch in the series
  - modified the return statement for isr
  - connector check modified to just check for eDP

 drivers/gpu/drm/msm/dp/dp_catalog.c | 18 ++++++++++++------
 drivers/gpu/drm/msm/dp/dp_display.c | 22 +++++++++++++++++++++-
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index fac815f..3a298e9 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -569,10 +569,6 @@ void dp_catalog_ctrl_hpd_config(struct dp_catalog *dp_catalog)
 
 	u32 reftimer = dp_read_aux(catalog, REG_DP_DP_HPD_REFTIMER);
 
-	/* enable HPD plug and unplug interrupts */
-	dp_catalog_hpd_config_intr(dp_catalog,
-		DP_DP_HPD_PLUG_INT_MASK | DP_DP_HPD_UNPLUG_INT_MASK, true);
-
 	/* Configure REFTIMER and enable it */
 	reftimer |= DP_DP_HPD_REFTIMER_ENABLE;
 	dp_write_aux(catalog, REG_DP_DP_HPD_REFTIMER, reftimer);
@@ -599,13 +595,23 @@ u32 dp_catalog_hpd_get_intr_status(struct dp_catalog *dp_catalog)
 {
 	struct dp_catalog_private *catalog = container_of(dp_catalog,
 				struct dp_catalog_private, dp_catalog);
-	int isr = 0;
+	int isr, mask;
 
 	isr = dp_read_aux(catalog, REG_DP_DP_HPD_INT_STATUS);
 	dp_write_aux(catalog, REG_DP_DP_HPD_INT_ACK,
 				 (isr & DP_DP_HPD_INT_MASK));
+	mask = dp_read_aux(catalog, REG_DP_DP_HPD_INT_MASK);
 
-	return isr;
+	/*
+	 * REG_DP_DP_HPD_INT_STATUS reports the status of all interrupts
+	 * irrespective of their masked status. The HW interrupt will not be
+	 * generated if an interrupt is masked. However, the interrupt status
+	 * bit in the register will still be set. The eDP controller driver
+	 * masks the plug and unplug interrupts unlike DP controller which
+	 * unmasks all the interrupts. So, do not report the status of the
+	 * masked interrupts.
+	 */
+	return isr & (mask | ~DP_DP_HPD_INT_MASK);
 }
 
 int dp_catalog_ctrl_get_interrupt(struct dp_catalog *dp_catalog)
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 3d03c77..874258d 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -683,7 +683,8 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
 	dp_display_handle_plugged_change(&dp->dp_display, false);
 
 	/* enable HDP plug interrupt to prepare for next plugin */
-	dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_PLUG_INT_MASK, true);
+	if (!dp->dp_display.is_edp)
+		dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_PLUG_INT_MASK, true);
 
 	DRM_DEBUG_DP("After, type=%d hpd_state=%d\n",
 			dp->dp_display.connector_type, state);
@@ -1096,6 +1097,13 @@ static void dp_display_config_hpd(struct dp_display_private *dp)
 	dp_display_host_init(dp);
 	dp_catalog_ctrl_hpd_config(dp->catalog);
 
+	/* Enable plug and unplug interrupts only for external DisplayPort */
+	if (!dp->dp_display.is_edp)
+		dp_catalog_hpd_config_intr(dp->catalog,
+				DP_DP_HPD_PLUG_INT_MASK |
+				DP_DP_HPD_UNPLUG_INT_MASK,
+				true);
+
 	/* Enable interrupt first time
 	 * we are leaving dp clocks on during disconnect
 	 * and never disable interrupt
@@ -1381,6 +1389,12 @@ static int dp_pm_resume(struct device *dev)
 	dp_catalog_ctrl_hpd_config(dp->catalog);
 
 
+	if (!dp->dp_display.is_edp)
+		dp_catalog_hpd_config_intr(dp->catalog,
+				DP_DP_HPD_PLUG_INT_MASK |
+				DP_DP_HPD_UNPLUG_INT_MASK,
+				true);
+
 	if (dp_catalog_link_is_connected(dp->catalog)) {
 		/*
 		 * set sink to normal operation mode -- D0
@@ -1655,6 +1669,9 @@ void dp_bridge_enable(struct drm_bridge *drm_bridge)
 		return;
 	}
 
+	if (dp->is_edp)
+		dp_hpd_plug_handle(dp_display, 0);
+
 	mutex_lock(&dp_display->event_mutex);
 
 	/* stop sentinel checking */
@@ -1719,6 +1736,9 @@ void dp_bridge_post_disable(struct drm_bridge *drm_bridge)
 
 	dp_display = container_of(dp, struct dp_display_private, dp_display);
 
+	if (dp->is_edp)
+		dp_hpd_unplug_handle(dp_display, 0);
+
 	mutex_lock(&dp_display->event_mutex);
 
 	/* stop sentinel checking */
-- 
2.7.4

