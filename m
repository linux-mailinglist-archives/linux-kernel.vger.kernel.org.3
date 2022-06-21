Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8A2553035
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348531AbiFUKxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348999AbiFUKxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:53:46 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7FE1A067;
        Tue, 21 Jun 2022 03:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655808826; x=1687344826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=m6EajMgBB+kQe2Y6cp8McOQ/aNlgO0ZhP50u9W1BvIA=;
  b=Tfuicp+Vs3D6fmTmU7ngdzIR+M9RwSvIAibaInIPmmHzKWgYz9r6Qnxp
   2l3Yidl2VnfplaU38Lud7nk716ZJfAEmS72KLNX+6x8VgAOmix+GjD8Jf
   ueJtkfZnrY5NmR0EutaWaVUn1dVinsNUabFrIggK4MTCKEhmH72HZH+w5
   A=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 21 Jun 2022 03:53:45 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Jun 2022 03:53:43 -0700
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg01-blr.qualcomm.com with ESMTP; 21 Jun 2022 16:23:31 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id BDAB03D5E; Tue, 21 Jun 2022 16:23:30 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     y@qualcomm.com, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_sbillaka@quicinc.com
Subject: [v3 5/5] drm/msm/disp/dpu1: add PSR support for eDP interface in dpu driver
Date:   Tue, 21 Jun 2022 16:23:20 +0530
Message-Id: <1655808800-3996-6-git-send-email-quic_vpolimer@quicinc.com>
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

Enable PSR on eDP interface using drm self-refresh librabry.
This patch uses a trigger from self-refresh library to enter/exit
into PSR, when there are no updates from framework.

Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    | 36 ++++++++++++++++++++++++-----
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 20 +++++++++++++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |  2 +-
 3 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index b56f777..c6e4f03 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -18,6 +18,7 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_rect.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_self_refresh_helper.h>
 
 #include "dpu_kms.h"
 #include "dpu_hw_lm.h"
@@ -955,24 +956,39 @@ static void dpu_crtc_disable(struct drm_crtc *crtc,
 									      crtc);
 	struct dpu_crtc *dpu_crtc = to_dpu_crtc(crtc);
 	struct dpu_crtc_state *cstate = to_dpu_crtc_state(crtc->state);
-	struct drm_encoder *encoder;
+	struct drm_encoder *encoder = NULL;
 	unsigned long flags;
 	bool release_bandwidth = false;
 
 	DRM_DEBUG_KMS("crtc%d\n", crtc->base.id);
 
+	if (old_crtc_state->self_refresh_active) {
+		drm_for_each_encoder_mask(encoder, crtc->dev,
+					old_crtc_state->encoder_mask) {
+			dpu_encoder_assign_crtc(encoder, NULL);
+		}
+		return;
+	}
+
 	/* Disable/save vblank irq handling */
 	drm_crtc_vblank_off(crtc);
 
 	drm_for_each_encoder_mask(encoder, crtc->dev,
 				  old_crtc_state->encoder_mask) {
-		/* in video mode, we hold an extra bandwidth reference
+		/*
+		 * in video mode, we hold an extra bandwidth reference
 		 * as we cannot drop bandwidth at frame-done if any
 		 * crtc is being used in video mode.
 		 */
 		if (dpu_encoder_get_intf_mode(encoder) == INTF_MODE_VIDEO)
 			release_bandwidth = true;
-		dpu_encoder_assign_crtc(encoder, NULL);
+		/*
+		 * If disable is triggered during psr active(e.g: screen dim in PSR),
+		 * we will need encoder->crtc connection to process the device sleep &
+		 * preserve it during psr sequence.
+		 */
+		if (!crtc->state->self_refresh_active)
+			dpu_encoder_assign_crtc(encoder, NULL);
 	}
 
 	/* wait for frame_event_done completion */
@@ -1020,7 +1036,9 @@ static void dpu_crtc_enable(struct drm_crtc *crtc,
 	struct dpu_crtc *dpu_crtc = to_dpu_crtc(crtc);
 	struct drm_encoder *encoder;
 	bool request_bandwidth = false;
+	struct drm_crtc_state *old_crtc_state;
 
+	old_crtc_state = drm_atomic_get_old_crtc_state(state, crtc);
 	pm_runtime_get_sync(crtc->dev->dev);
 
 	DRM_DEBUG_KMS("crtc%d\n", crtc->base.id);
@@ -1042,8 +1060,9 @@ static void dpu_crtc_enable(struct drm_crtc *crtc,
 	trace_dpu_crtc_enable(DRMID(crtc), true, dpu_crtc);
 	dpu_crtc->enabled = true;
 
-	drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask)
-		dpu_encoder_assign_crtc(encoder, crtc);
+	if (!old_crtc_state->self_refresh_active)
+		drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask)
+			dpu_encoder_assign_crtc(encoder, crtc);
 
 	/* Enable/restore vblank irq handling */
 	drm_crtc_vblank_on(crtc);
@@ -1525,7 +1544,7 @@ struct drm_crtc *dpu_crtc_init(struct drm_device *dev, struct drm_plane *plane,
 {
 	struct drm_crtc *crtc = NULL;
 	struct dpu_crtc *dpu_crtc = NULL;
-	int i;
+	int i, ret;
 
 	dpu_crtc = kzalloc(sizeof(*dpu_crtc), GFP_KERNEL);
 	if (!dpu_crtc)
@@ -1562,6 +1581,11 @@ struct drm_crtc *dpu_crtc_init(struct drm_device *dev, struct drm_plane *plane,
 	/* initialize event handling */
 	spin_lock_init(&dpu_crtc->event_lock);
 
+	ret = drm_self_refresh_helper_init(crtc);
+	if (ret)
+		DPU_ERROR("Failed to initialize %s with self-refresh helpers %d\n",
+			crtc->name, ret);
+
 	DRM_DEBUG_KMS("%s: successfully initialized crtc\n", dpu_crtc->name);
 	return crtc;
 }
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index cc2809b..234e95d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -225,6 +225,11 @@ bool dpu_encoder_is_widebus_enabled(const struct drm_encoder *drm_enc)
 	return dpu_enc->wide_bus_en;
 }
 
+static inline bool is_self_refresh_active(const struct drm_crtc_state *state)
+{
+	return (state && state->self_refresh_active);
+}
+
 static void _dpu_encoder_setup_dither(struct dpu_hw_pingpong *hw_pp, unsigned bpc)
 {
 	struct dpu_hw_dither_cfg dither_cfg = { 0 };
@@ -592,7 +597,8 @@ static int dpu_encoder_virt_atomic_check(
 		if (drm_atomic_crtc_needs_modeset(crtc_state)) {
 			dpu_rm_release(global_state, drm_enc);
 
-			if (!crtc_state->active_changed || crtc_state->active)
+			if (!crtc_state->active_changed || crtc_state->active ||
+					crtc_state->self_refresh_active)
 				ret = dpu_rm_reserve(&dpu_kms->rm, global_state,
 						drm_enc, crtc_state, topology);
 		}
@@ -1171,11 +1177,23 @@ static void dpu_encoder_virt_atomic_disable(struct drm_encoder *drm_enc,
 					struct drm_atomic_state *state)
 {
 	struct dpu_encoder_virt *dpu_enc = NULL;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *old_state;
 	int i = 0;
 
 	dpu_enc = to_dpu_encoder_virt(drm_enc);
 	DPU_DEBUG_ENC(dpu_enc, "\n");
 
+	crtc = dpu_enc->crtc;
+	old_state = drm_atomic_get_old_crtc_state(state, crtc);
+
+	/*
+	 * The encoder disabled already occurred when self refresh mode
+	 * was set earlier, in the old_state for the corresponding crtc.
+	 */
+	if (drm_enc->encoder_type == DRM_MODE_ENCODER_TMDS && is_self_refresh_active(old_state))
+		return;
+
 	mutex_lock(&dpu_enc->enc_lock);
 	dpu_enc->enabled = false;
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index bce4764..cc0a674 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -507,7 +507,7 @@ static void dpu_kms_wait_for_commit_done(struct msm_kms *kms,
 		return;
 	}
 
-	if (!crtc->state->active) {
+	if (!drm_atomic_crtc_effectively_active(crtc->state)) {
 		DPU_DEBUG("[crtc:%d] not active\n", crtc->base.id);
 		return;
 	}
-- 
2.7.4

