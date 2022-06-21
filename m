Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E222E553038
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349225AbiFUKyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348619AbiFUKxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:53:52 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9947528E3C;
        Tue, 21 Jun 2022 03:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655808831; x=1687344831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=85bRi9M0zCqYsHa+d8DJ7LJM62rkaOocvsbZYBiUyZA=;
  b=cmjEj4mpV17+vijcIWQGhFh1wMsBIjOtadIeJgRNFbCFLk0sujL1kLjQ
   M9ivQ3vop+r9I1O+it468p5PhPoq57XRXUnrtJf/XP1lfDsHqQ4bkYorH
   4lUFuQCrPC6Cp8ptYOuBSGX3EJ2iCEsmSVFLuAEEK0J/fdNXpLCC2h4s8
   4=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 21 Jun 2022 03:53:51 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Jun 2022 03:53:49 -0700
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg01-blr.qualcomm.com with ESMTP; 21 Jun 2022 16:23:31 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id 88B9E3D55; Tue, 21 Jun 2022 16:23:30 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     y@qualcomm.com, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_sbillaka@quicinc.com
Subject: [v3 3/5] drm/bridge: add psr support during panel bridge enable & disable sequence
Date:   Tue, 21 Jun 2022 16:23:18 +0530
Message-Id: <1655808800-3996-4-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655808800-3996-1-git-send-email-quic_vpolimer@quicinc.com>
References: <y>
 <1655808800-3996-1-git-send-email-quic_vpolimer@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change avoids panel prepare/unprepare based on self-refresh
state.

Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
---
 drivers/gpu/drm/bridge/panel.c | 102 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 98 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 59a3496..6b09ae0 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -41,6 +41,40 @@ static int panel_bridge_connector_get_modes(struct drm_connector *connector)
 	return drm_panel_get_modes(panel_bridge->panel, connector);
 }
 
+static struct drm_crtc *bridge_drm_get_old_connector_crtc(struct drm_encoder *encoder,
+							struct drm_atomic_state *state)
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
+							struct drm_atomic_state *state)
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
@@ -108,30 +142,90 @@ static void panel_bridge_detach(struct drm_bridge *bridge)
 		drm_connector_cleanup(connector);
 }
 
-static void panel_bridge_atomic_pre_enable(struct drm_bridge *bridge)
+static void panel_bridge_atomic_pre_enable(struct drm_bridge *bridge,
+					struct drm_bridge_state *old_bridge_state)
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
+
+	/* Don't touch the panel if we're coming back from self refresh state */
+	if (old_crtc_state && old_crtc_state->self_refresh_active)
+		return;
 
 	drm_panel_prepare(panel_bridge->panel);
 }
 
-static void panel_bridge_atomic_enable(struct drm_bridge *bridge)
+static void panel_bridge_atomic_enable(struct drm_bridge *bridge,
+					struct drm_bridge_state *old_bridge_state)
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
+
+	/* Don't touch the panel if we're coming back from self refresh state */
+	if (old_crtc_state && old_crtc_state->self_refresh_active)
+		return;
 
 	drm_panel_enable(panel_bridge->panel);
 }
 
-static void panel_bridge_atomic_disable(struct drm_bridge *bridge)
+static void panel_bridge_atomic_disable(struct drm_bridge *bridge,
+					struct drm_bridge_state *old_bridge_state)
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
+
+	/* Don't do a full disable on PSR transitions if new state is self refresh state */
+	if (new_crtc_state && new_crtc_state->self_refresh_active)
+		return;
 
 	drm_panel_disable(panel_bridge->panel);
 }
 
-static void panel_bridge_atomic_post_disable(struct drm_bridge *bridge)
+static void panel_bridge_atomic_post_disable(struct drm_bridge *bridge,
+					struct drm_bridge_state *old_bridge_state)
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
+
+	/* Don't do unprepare on PSR transitions if new state is self refresh state */
+	if (new_crtc_state && new_crtc_state->self_refresh_active)
+		return;
 
 	drm_panel_unprepare(panel_bridge->panel);
 }
-- 
2.7.4

