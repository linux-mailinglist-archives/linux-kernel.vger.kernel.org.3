Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129E94BDBBA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378427AbiBUOw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:52:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbiBUOwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:52:24 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70D713CFB;
        Mon, 21 Feb 2022 06:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645455121; x=1676991121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Pxh0j8i5HRx/ZnoC5AY1Xirjq4XIKV1wOb846dWaw70=;
  b=uxzWuypdytAinBptnId4lQUxlLxPrxBXXsX0EAzSB9Z94hLHh5Hi4mkr
   Ee1zn6C9/sKcn54eEHpTFH/zreXPU5KxfVvINw3og9oy54oFA/qdiDZ++
   HdxfWIK0DhMKm9VJV6lhDV7CpeLRX3Fnoqa3pdzXU7ZdYm/b9G7FA2LQM
   8=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 21 Feb 2022 06:52:00 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Feb 2022 06:51:57 -0800
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg02-blr.qualcomm.com with ESMTP; 21 Feb 2022 20:21:37 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id 9B3D753A4; Mon, 21 Feb 2022 20:21:36 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        robdclark@gmail.com, seanpaul@chromium.org, swboyd@chromium.org,
        dianders@chromium.org, krzysztof.kozlowski@canonical.com,
        thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        quic_kalyant@quicinc.com, quic_sbillaka@quicinc.com,
        quic_vproddut@quicinc.com
Subject: [PATCH v2 2/4] drm/bridge: use atomic enable/disable for bridge callbacks
Date:   Mon, 21 Feb 2022 20:21:24 +0530
Message-Id: <1645455086-9359-3-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645455086-9359-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1645455086-9359-1-git-send-email-quic_vpolimer@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use atomic enable/disable for bridge callbacks to access certain
states like self-refresh.

This change avoids panel prepare/unprepare based on self-refresh
state.

Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>

Changes in V2:
- As per review suggestion by Dmitry.
---
 drivers/gpu/drm/bridge/panel.c | 102 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 94 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index b32295a..5c7dc82 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -41,6 +41,40 @@ static int panel_bridge_connector_get_modes(struct drm_connector *connector)
 	return drm_panel_get_modes(panel_bridge->panel, connector);
 }
 
+static struct drm_crtc *bridge_drm_get_old_connector_crtc(struct drm_encoder *encoder,
+						struct drm_atomic_state *state)
+{
+	struct drm_connector *connector;
+	struct drm_connector_state *conn_state;
+
+	connector = drm_atomic_get_old_connector_for_encoder(state, encoder);
+	if (!connector)
+		return NULL;
+
+	conn_state = drm_atomic_get_old_connector_state(state, connector);
+	if (!conn_state)
+		return NULL;
+
+	return conn_state->crtc;
+}
+
+static struct drm_crtc *bridge_drm_get_new_connector_crtc(struct drm_encoder *encoder,
+						struct drm_atomic_state *state)
+{
+	struct drm_connector *connector;
+	struct drm_connector_state *conn_state;
+
+	connector = drm_atomic_get_new_connector_for_encoder(state, encoder);
+	if (!connector)
+		return NULL;
+
+	conn_state = drm_atomic_get_new_connector_state(state, connector);
+	if (!conn_state)
+		return NULL;
+
+	return conn_state->crtc;
+}
+
 static const struct drm_connector_helper_funcs
 panel_bridge_connector_helper_funcs = {
 	.get_modes = panel_bridge_connector_get_modes,
@@ -102,30 +136,82 @@ static void panel_bridge_detach(struct drm_bridge *bridge)
 		drm_connector_cleanup(connector);
 }
 
-static void panel_bridge_pre_enable(struct drm_bridge *bridge)
+static void panel_bridge_pre_enable(struct drm_bridge *bridge,
+		struct drm_bridge_state *old_bridge_state)
 {
 	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
+	struct drm_atomic_state *old_state = old_bridge_state->base.state;
+	struct drm_encoder *encoder = bridge->encoder;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *old_crtc_state;
+
+	crtc = bridge_drm_get_new_connector_crtc(encoder, old_state);
+	if (!crtc)
+		return;
+
+	old_crtc_state = drm_atomic_get_old_crtc_state(old_state, crtc);
+	if (old_crtc_state && old_crtc_state->self_refresh_active)
+		return;
 
 	drm_panel_prepare(panel_bridge->panel);
 }
 
-static void panel_bridge_enable(struct drm_bridge *bridge)
+static void panel_bridge_enable(struct drm_bridge *bridge,
+		struct drm_bridge_state *old_bridge_state)
 {
 	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
+	struct drm_atomic_state *old_state = old_bridge_state->base.state;
+	struct drm_encoder *encoder = bridge->encoder;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *old_crtc_state;
+
+	crtc = bridge_drm_get_new_connector_crtc(encoder, old_state);
+	if (!crtc)
+		return;
+
+	old_crtc_state = drm_atomic_get_old_crtc_state(old_state, crtc);
+	if (old_crtc_state && old_crtc_state->self_refresh_active)
+		return;
 
 	drm_panel_enable(panel_bridge->panel);
 }
 
-static void panel_bridge_disable(struct drm_bridge *bridge)
+static void panel_bridge_disable(struct drm_bridge *bridge,
+		struct drm_bridge_state *old_bridge_state)
 {
 	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
+	struct drm_atomic_state *old_state = old_bridge_state->base.state;
+	struct drm_encoder *encoder = bridge->encoder;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *new_crtc_state;
+
+	crtc = bridge_drm_get_old_connector_crtc(encoder, old_state);
+	if (!crtc)
+		return;
+
+	new_crtc_state = drm_atomic_get_new_crtc_state(old_state, crtc);
+	if (new_crtc_state && new_crtc_state->self_refresh_active)
+		return;
 
 	drm_panel_disable(panel_bridge->panel);
 }
 
-static void panel_bridge_post_disable(struct drm_bridge *bridge)
+static void panel_bridge_post_disable(struct drm_bridge *bridge,
+		struct drm_bridge_state *old_bridge_state)
 {
 	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
+	struct drm_atomic_state *old_state = old_bridge_state->base.state;
+	struct drm_encoder *encoder = bridge->encoder;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *new_crtc_state;
+
+	crtc = bridge_drm_get_old_connector_crtc(encoder, old_state);
+	if (!crtc)
+		return;
+
+	new_crtc_state = drm_atomic_get_new_crtc_state(old_state, crtc);
+	if (new_crtc_state && new_crtc_state->self_refresh_active)
+		return;
 
 	drm_panel_unprepare(panel_bridge->panel);
 }
@@ -141,10 +227,10 @@ static int panel_bridge_get_modes(struct drm_bridge *bridge,
 static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
 	.attach = panel_bridge_attach,
 	.detach = panel_bridge_detach,
-	.pre_enable = panel_bridge_pre_enable,
-	.enable = panel_bridge_enable,
-	.disable = panel_bridge_disable,
-	.post_disable = panel_bridge_post_disable,
+	.atomic_pre_enable = panel_bridge_pre_enable,
+	.atomic_enable = panel_bridge_enable,
+	.atomic_disable = panel_bridge_disable,
+	.atomic_post_disable = panel_bridge_post_disable,
 	.get_modes = panel_bridge_get_modes,
 	.atomic_reset = drm_atomic_helper_bridge_reset,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
-- 
2.7.4

