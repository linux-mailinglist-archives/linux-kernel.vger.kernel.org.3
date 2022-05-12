Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDA0524150
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 02:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349518AbiELAEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 20:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiELAD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 20:03:56 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D221578FEA;
        Wed, 11 May 2022 17:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652313834; x=1683849834;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=AytqhtlrQXo/glli1ZywoTulrCobzK4bJtoTLSRZIXs=;
  b=p8wmqk/icmgmP4W3qfZMslidhxYhAsH3GURt6eL2hEfN1aDkm+HUUbL5
   LR47jh3H/8Lfy3K9aJgYqulTf8BvrZR7QSf8xKiqni60OgLefAFDe0+oT
   G7tQ4CEIS+ig2msx7FghzeMS0MbcfGfL4uttMrvqsqrQdrIwBAye1DcGJ
   0=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 May 2022 17:03:54 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 17:03:53 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 17:03:53 -0700
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 17:03:52 -0700
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
Subject: [PATCH v5] drm/msm/dp: Always clear mask bits to disable interrupts at dp_ctrl_reset_irq_ctrl()
Date:   Wed, 11 May 2022 17:02:48 -0700
Message-ID: <1652313768-16286-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

dp_catalog_ctrl_reset() will software reset DP controller. But it will
not reset programmable registers to default value. DP driver still have
to clear mask bits to interrupt status registers to disable interrupts
after software reset of controller.

At current implementation, dp_ctrl_reset_irq_ctrl() will software reset dp
controller but did not call dp_catalog_ctrl_enable_irq(false) to clear hpd
related interrupt mask bits to disable hpd related interrupts due to it
mistakenly think hpd related interrupt mask bits will be cleared by software
reset of dp controller automatically. This mistake may cause system to crash
during suspending procedure due to unexpected irq fired and trigger event
thread to access dp controller registers with controller clocks are disabled.

This patch fixes system crash during suspending problem by removing "enable"
flag condition checking at dp_ctrl_reset_irq_ctrl() so that hpd related
interrupt mask bits are cleared to prevent unexpected from happening.
In addition, this patch also add suspended flag to prevent new events be
added into event Q to wake up event thread after system suspended.

Changes in v2:
-- add more details commit text

Changes in v3:
-- add synchrons_irq()
-- add atomic_t suspended

Changes in v4:
-- correct Fixes's commit ID
-- remove synchrons_irq()

Changes in v5:
-- revise commit text

Fixes: 989ebe7bc446 ("drm/msm/dp: do not initialize phy until plugin interrupt received")
Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    |  9 +++++++--
 drivers/gpu/drm/msm/dp/dp_display.c | 11 +++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index af7a80c..f3e333e 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1389,8 +1389,13 @@ void dp_ctrl_reset_irq_ctrl(struct dp_ctrl *dp_ctrl, bool enable)
 
 	dp_catalog_ctrl_reset(ctrl->catalog);
 
-	if (enable)
-		dp_catalog_ctrl_enable_irq(ctrl->catalog, enable);
+	/*
+	 * all dp controller programmable registers will not
+	 * be reset to default value after DP_SW_RESET
+	 * therefore interrupt mask bits have to be updated
+	 * to enable/disable interrupts
+	 */
+	dp_catalog_ctrl_enable_irq(ctrl->catalog, enable);
 }
 
 void dp_ctrl_phy_init(struct dp_ctrl *dp_ctrl)
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index c388323..79439b8 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -98,6 +98,8 @@ struct dp_display_private {
 	struct dp_ctrl    *ctrl;
 	struct dp_debug   *debug;
 
+	atomic_t suspended;
+
 	struct dp_usbpd_cb usbpd_cb;
 	struct dp_display_mode dp_mode;
 	struct msm_dp dp_display;
@@ -187,6 +189,11 @@ static int dp_add_event(struct dp_display_private *dp_priv, u32 event,
 	int pndx;
 
 	spin_lock_irqsave(&dp_priv->event_lock, flag);
+	if (atomic_read(&dp_priv->suspended)) {
+		spin_unlock_irqrestore(&dp_priv->event_lock, flag);
+		return -EPERM;
+	}
+
 	pndx = dp_priv->event_pndx + 1;
 	pndx %= DP_EVENT_Q_MAX;
 	if (pndx == dp_priv->event_gndx) {
@@ -1362,6 +1369,8 @@ static int dp_pm_resume(struct device *dev)
 		dp->dp_display.connector_type, dp->core_initialized,
 		dp->phy_initialized, dp_display->power_on);
 
+	atomic_set(&dp->suspended, 0);
+
 	/* start from disconnected state */
 	dp->hpd_state = ST_DISCONNECTED;
 
@@ -1431,6 +1440,8 @@ static int dp_pm_suspend(struct device *dev)
 		dp->dp_display.connector_type, dp->core_initialized,
 		dp->phy_initialized, dp_display->power_on);
 
+	atomic_inc(&dp->suspended);
+
 	/* mainlink enabled */
 	if (dp_power_clk_status(dp->power, DP_CTRL_PM))
 		dp_ctrl_off_link_stream(dp->ctrl);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

