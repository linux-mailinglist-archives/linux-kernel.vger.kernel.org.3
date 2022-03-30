Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB1F4EC911
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348525AbiC3QFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348520AbiC3QFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:05:16 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A14939E9;
        Wed, 30 Mar 2022 09:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648656209; x=1680192209;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Kkj8uAcKOeSduapYDdHTtLiuFh+RlwdgPHGirWi3/nY=;
  b=DyOFCdgnFloObi9gmxXdVDQnBqueWel1iBD81m6fJZTfGVoyrGjl6PtD
   SaP7M5kopidkKx94sFQ+VB4GTm5SenXvIXRkjz6fVMCUYjCRISAim8clI
   DxfgPT3f0N8E23tQHsva2jla6RCeDbfiY/Ec8y57T4vpiCI3yV4k1wQAs
   U=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 30 Mar 2022 09:03:29 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 09:03:29 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 30 Mar 2022 09:03:28 -0700
Received: from sbillaka-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 30 Mar 2022 09:03:22 -0700
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
Subject: [PATCH v6 1/8] drm/msm/dp: Add eDP support via aux_bus
Date:   Wed, 30 Mar 2022 21:32:52 +0530
Message-ID: <1648656179-10347-2-git-send-email-quic_sbillaka@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
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

This patch adds support for generic eDP sink through aux_bus. The eDP/DP
controller driver should support aux transactions originating from the
panel-edp driver and hence should be initialized and ready.

The panel bridge supporting the panel should be ready before the bridge
connector is initialized. The generic panel probe needs the controller
resources to be enabled to support the aux transactions originating from
the panel probe.

Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
---

Changes in v6:
  - Remove initialization
  - Fix aux_bus node leak
  - Split the patches

 drivers/gpu/drm/msm/dp/dp_display.c | 54 +++++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/msm/dp/dp_drm.c     | 10 ++++---
 drivers/gpu/drm/msm/dp/dp_parser.c  | 21 +--------------
 drivers/gpu/drm/msm/dp/dp_parser.h  |  1 +
 4 files changed, 60 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 382b3aa..e082d02 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -10,6 +10,7 @@
 #include <linux/component.h>
 #include <linux/of_irq.h>
 #include <linux/delay.h>
+#include <drm/dp/drm_dp_aux_bus.h>
 
 #include "msm_drv.h"
 #include "msm_kms.h"
@@ -265,8 +266,6 @@ static int dp_display_bind(struct device *dev, struct device *master,
 		goto end;
 	}
 
-	dp->dp_display.next_bridge = dp->parser->next_bridge;
-
 	dp->aux->drm_dev = drm;
 	rc = dp_aux_register(dp->aux);
 	if (rc) {
@@ -1524,6 +1523,53 @@ void msm_dp_debugfs_init(struct msm_dp *dp_display, struct drm_minor *minor)
 	}
 }
 
+static int dp_display_get_next_bridge(struct msm_dp *dp)
+{
+	int rc;
+	struct dp_display_private *dp_priv;
+	struct device_node *aux_bus;
+	struct device *dev;
+
+	dp_priv = container_of(dp, struct dp_display_private, dp_display);
+	dev = &dp_priv->pdev->dev;
+	aux_bus = of_get_child_by_name(dev->of_node, "aux-bus");
+
+	if (aux_bus) {
+		dp_display_host_init(dp_priv);
+		dp_catalog_ctrl_hpd_config(dp_priv->catalog);
+		enable_irq(dp_priv->irq);
+		dp_display_host_phy_init(dp_priv);
+
+		devm_of_dp_aux_populate_ep_devices(dp_priv->aux);
+
+		disable_irq(dp_priv->irq);
+		of_node_put(aux_bus);
+	}
+
+	/*
+	 * External bridges are mandatory for eDP interfaces: one has to
+	 * provide at least an eDP panel (which gets wrapped into panel-bridge).
+	 *
+	 * For DisplayPort interfaces external bridges are optional, so
+	 * silently ignore an error if one is not present (-ENODEV).
+	 */
+	rc = dp_parser_find_next_bridge(dp_priv->parser);
+	if (rc == -ENODEV) {
+		if (dp->connector_type == DRM_MODE_CONNECTOR_eDP) {
+			DRM_ERROR("eDP: next bridge is not present\n");
+			return rc;
+		}
+	} else if (rc) {
+		if (rc != -EPROBE_DEFER)
+			DRM_ERROR("DP: error parsing next bridge: %d\n", rc);
+		return rc;
+	}
+
+	dp->next_bridge = dp_priv->parser->next_bridge;
+
+	return 0;
+}
+
 int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
 			struct drm_encoder *encoder)
 {
@@ -1547,6 +1593,10 @@ int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
 
 	dp_display->encoder = encoder;
 
+	ret = dp_display_get_next_bridge(dp_display);
+	if (ret)
+		return ret;
+
 	dp_display->bridge = dp_bridge_init(dp_display, dev, encoder);
 	if (IS_ERR(dp_display->bridge)) {
 		ret = PTR_ERR(dp_display->bridge);
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index 7ce1aca..5254bd6 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -114,10 +114,12 @@ struct drm_bridge *dp_bridge_init(struct msm_dp *dp_display, struct drm_device *
 	bridge->funcs = &dp_bridge_ops;
 	bridge->type = dp_display->connector_type;
 
-	bridge->ops =
-		DRM_BRIDGE_OP_DETECT |
-		DRM_BRIDGE_OP_HPD |
-		DRM_BRIDGE_OP_MODES;
+	if (bridge->type == DRM_MODE_CONNECTOR_DisplayPort) {
+		bridge->ops =
+			DRM_BRIDGE_OP_DETECT |
+			DRM_BRIDGE_OP_HPD |
+			DRM_BRIDGE_OP_MODES;
+	}
 
 	rc = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 	if (rc) {
diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c b/drivers/gpu/drm/msm/dp/dp_parser.c
index 1056b8d..6317dce 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.c
+++ b/drivers/gpu/drm/msm/dp/dp_parser.c
@@ -265,7 +265,7 @@ static int dp_parser_clock(struct dp_parser *parser)
 	return 0;
 }
 
-static int dp_parser_find_next_bridge(struct dp_parser *parser)
+int dp_parser_find_next_bridge(struct dp_parser *parser)
 {
 	struct device *dev = &parser->pdev->dev;
 	struct drm_bridge *bridge;
@@ -300,25 +300,6 @@ static int dp_parser_parse(struct dp_parser *parser, int connector_type)
 	if (rc)
 		return rc;
 
-	/*
-	 * External bridges are mandatory for eDP interfaces: one has to
-	 * provide at least an eDP panel (which gets wrapped into panel-bridge).
-	 *
-	 * For DisplayPort interfaces external bridges are optional, so
-	 * silently ignore an error if one is not present (-ENODEV).
-	 */
-	rc = dp_parser_find_next_bridge(parser);
-	if (rc == -ENODEV) {
-		if (connector_type == DRM_MODE_CONNECTOR_eDP) {
-			DRM_ERROR("eDP: next bridge is not present\n");
-			return rc;
-		}
-	} else if (rc) {
-		if (rc != -EPROBE_DEFER)
-			DRM_ERROR("DP: error parsing next bridge: %d\n", rc);
-		return rc;
-	}
-
 	/* Map the corresponding regulator information according to
 	 * version. Currently, since we only have one supported platform,
 	 * mapping the regulator directly.
diff --git a/drivers/gpu/drm/msm/dp/dp_parser.h b/drivers/gpu/drm/msm/dp/dp_parser.h
index d371bae..091ff41 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.h
+++ b/drivers/gpu/drm/msm/dp/dp_parser.h
@@ -140,5 +140,6 @@ struct dp_parser {
  * can be parsed using this module.
  */
 struct dp_parser *dp_parser_get(struct platform_device *pdev);
+int dp_parser_find_next_bridge(struct dp_parser *parser);
 
 #endif
-- 
2.7.4

