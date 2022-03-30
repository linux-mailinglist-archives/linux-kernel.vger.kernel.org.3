Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA964EC91A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348527AbiC3QF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348538AbiC3QFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:05:24 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BBBEF082;
        Wed, 30 Mar 2022 09:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648656218; x=1680192218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=BRoLLmUJ2sv06HEf2+XRTygGI1oHSJ3f2Xrm+cdWU0w=;
  b=sZ4ltnZByAANuTWkSXDzKrbwqB1+M7Xsw8EDEB5ntDVWOM2Vxs/Q/6G8
   OerIQjwFKdnf6chgu2cBnlmbTRq9+jTKpdiJTeeXZf/lYVaxD3qsBGygg
   jdwPxRUE5x52oEhNaZWHVJ9WsV449CVJ63PYCmNGSLR33hmxhFYcZUzO2
   c=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 30 Mar 2022 09:03:38 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 09:03:37 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 30 Mar 2022 09:03:37 -0700
Received: from sbillaka-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 30 Mar 2022 09:03:31 -0700
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
        <quic_aravindh@quicinc.com>
Subject: [PATCH v6 2/8] drm/msm/dp: wait for hpd high before aux transaction
Date:   Wed, 30 Mar 2022 21:32:53 +0530
Message-ID: <1648656179-10347-3-git-send-email-quic_sbillaka@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
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

The source device should ensure the sink is ready before proceeding to
read the sink capability or performing any aux transactions. The sink
will indicate its readiness by asserting the HPD line. The controller
driver needs to wait for the hpd line to be asserted by the sink before
performing any aux transactions.

The eDP sink is assumed to be always connected. It needs power from the
source and its HPD line will be asserted only after the panel is powered
on. The panel power will be enabled from the panel-edp driver and only
after that, the hpd line will be asserted.

Whereas for DP, the sink can be hotplugged and unplugged anytime. The hpd
line gets asserted to indicate the sink is connected and ready. Hence
there is no need to wait for the hpd line to be asserted for a DP sink.

Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
---

Changes in v6:
  - Wait for hpd high only for eDP
  - Split into smaller patches

 drivers/gpu/drm/msm/dp/dp_aux.c     | 13 ++++++++++++-
 drivers/gpu/drm/msm/dp/dp_aux.h     |  3 ++-
 drivers/gpu/drm/msm/dp/dp_catalog.c | 13 +++++++++++++
 drivers/gpu/drm/msm/dp/dp_catalog.h |  1 +
 drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
 5 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
index 6d36f63..a217c80 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.c
+++ b/drivers/gpu/drm/msm/dp/dp_aux.c
@@ -36,6 +36,7 @@ struct dp_aux_private {
 	bool initted;
 	u32 offset;
 	u32 segment;
+	bool is_edp;
 
 	struct drm_dp_aux dp_aux;
 };
@@ -337,6 +338,14 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux *dp_aux,
 		goto exit;
 	}
 
+	if (aux->is_edp) {
+		ret = dp_catalog_aux_wait_for_hpd_connect_state(aux->catalog);
+		if (ret) {
+			DRM_DEBUG_DP("Panel not ready for aux transactions\n");
+			goto exit;
+		}
+	}
+
 	dp_aux_update_offset_and_segment(aux, msg);
 	dp_aux_transfer_helper(aux, msg, true);
 
@@ -491,7 +500,8 @@ void dp_aux_unregister(struct drm_dp_aux *dp_aux)
 	drm_dp_aux_unregister(dp_aux);
 }
 
-struct drm_dp_aux *dp_aux_get(struct device *dev, struct dp_catalog *catalog)
+struct drm_dp_aux *dp_aux_get(struct device *dev, struct dp_catalog *catalog,
+				bool is_edp)
 {
 	struct dp_aux_private *aux;
 
@@ -506,6 +516,7 @@ struct drm_dp_aux *dp_aux_get(struct device *dev, struct dp_catalog *catalog)
 
 	init_completion(&aux->comp);
 	aux->cmd_busy = false;
+	aux->is_edp = is_edp;
 	mutex_init(&aux->mutex);
 
 	aux->dev = dev;
diff --git a/drivers/gpu/drm/msm/dp/dp_aux.h b/drivers/gpu/drm/msm/dp/dp_aux.h
index 82afc8d..c99aeec 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.h
+++ b/drivers/gpu/drm/msm/dp/dp_aux.h
@@ -16,7 +16,8 @@ void dp_aux_init(struct drm_dp_aux *dp_aux);
 void dp_aux_deinit(struct drm_dp_aux *dp_aux);
 void dp_aux_reconfig(struct drm_dp_aux *dp_aux);
 
-struct drm_dp_aux *dp_aux_get(struct device *dev, struct dp_catalog *catalog);
+struct drm_dp_aux *dp_aux_get(struct device *dev, struct dp_catalog *catalog,
+				bool is_edp);
 void dp_aux_put(struct drm_dp_aux *aux);
 
 #endif /*__DP_AUX_H_*/
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index fac815f..b6add4e 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -242,6 +242,19 @@ void dp_catalog_aux_update_cfg(struct dp_catalog *dp_catalog)
 	phy_calibrate(phy);
 }
 
+int dp_catalog_aux_wait_for_hpd_connect_state(struct dp_catalog *dp_catalog)
+{
+	u32 state;
+	struct dp_catalog_private *catalog = container_of(dp_catalog,
+				struct dp_catalog_private, dp_catalog);
+
+	/* poll for hpd connected status every 2ms and timeout after 500ms */
+	return readl_poll_timeout(catalog->io->dp_controller.aux.base +
+				REG_DP_DP_HPD_INT_STATUS,
+				state, state & DP_DP_HPD_STATE_STATUS_CONNECTED,
+				2000, 500000);
+}
+
 static void dump_regs(void __iomem *base, int len)
 {
 	int i;
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp/dp_catalog.h
index 7dea101..45140a3 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.h
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
@@ -84,6 +84,7 @@ int dp_catalog_aux_clear_hw_interrupts(struct dp_catalog *dp_catalog);
 void dp_catalog_aux_reset(struct dp_catalog *dp_catalog);
 void dp_catalog_aux_enable(struct dp_catalog *dp_catalog, bool enable);
 void dp_catalog_aux_update_cfg(struct dp_catalog *dp_catalog);
+int dp_catalog_aux_wait_for_hpd_connect_state(struct dp_catalog *dp_catalog);
 u32 dp_catalog_aux_get_irq(struct dp_catalog *dp_catalog);
 
 /* DP Controller APIs */
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index e082d02..274bbcf 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -755,6 +755,7 @@ static void dp_display_deinit_sub_modules(struct dp_display_private *dp)
 static int dp_init_sub_modules(struct dp_display_private *dp)
 {
 	int rc = 0;
+	bool is_edp = (dp->dp_display.connector_type == DRM_MODE_CONNECTOR_eDP);
 	struct device *dev = &dp->pdev->dev;
 	struct dp_usbpd_cb *cb = &dp->usbpd_cb;
 	struct dp_panel_in panel_in = {
@@ -798,7 +799,7 @@ static int dp_init_sub_modules(struct dp_display_private *dp)
 		goto error;
 	}
 
-	dp->aux = dp_aux_get(dev, dp->catalog);
+	dp->aux = dp_aux_get(dev, dp->catalog, is_edp);
 	if (IS_ERR(dp->aux)) {
 		rc = PTR_ERR(dp->aux);
 		DRM_ERROR("failed to initialize aux, rc = %d\n", rc);
-- 
2.7.4

