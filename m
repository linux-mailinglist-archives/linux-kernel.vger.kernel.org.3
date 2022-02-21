Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9371A4BDD9A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378472AbiBUOwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:52:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378442AbiBUOw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:52:28 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EF413D73;
        Mon, 21 Feb 2022 06:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645455125; x=1676991125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=H3+DEJkpDEMljnyOr4RtnL4RrB1E5lIn4hbGJmNSw+U=;
  b=qmLfhCD8oFAZu2l7JstaI0iTuuK0XenV5XYvOSzxWtxVcjzFSvzd/+I6
   T3/a6HPbDNtmtC3LnQIEkqMvsNoH1pqmIU8CAF4WWQysrIRh5WFOHJKJe
   eX/r4kXrDCcSFtz6NTFkzcstyMDLF1/TbmPZ+6zQn8/SeubEOUAw7lD7I
   Y=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 21 Feb 2022 06:52:05 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Feb 2022 06:52:03 -0800
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg02-blr.qualcomm.com with ESMTP; 21 Feb 2022 20:21:43 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id F14D05392; Mon, 21 Feb 2022 20:21:41 +0530 (IST)
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
Subject: [PATCH v2 4/4] drm/msm/disp/dpu1: add PSR support for eDP interface in dpu driver
Date:   Mon, 21 Feb 2022 20:21:26 +0530
Message-Id: <1645455086-9359-5-git-send-email-quic_vpolimer@quicinc.com>
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

Enable PSR on eDP interface using drm self-refresh librabry.
This patch uses a trigger from self-refresh library to enter/exit
into PSR, when there are no updates from framework.

Changes in V2:
- Move dp functions to bridge code.
- As per Dmitry review suggestions.

Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    | 31 +++++++++++++++++++++++++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 30 +++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |  2 +-
 3 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index e7c9fe1..ba3240c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -18,6 +18,7 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_rect.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_self_refresh_helper.h>
 
 #include "dpu_kms.h"
 #include "dpu_hw_lm.h"
@@ -951,6 +952,14 @@ static void dpu_crtc_disable(struct drm_crtc *crtc,
 
 	DRM_DEBUG_KMS("crtc%d\n", crtc->base.id);
 
+	if (old_crtc_state->self_refresh_active) {
+		drm_for_each_encoder_mask(encoder, crtc->dev,
+				 old_crtc_state->encoder_mask) {
+			dpu_encoder_assign_crtc(encoder, NULL);
+		}
+		return;
+	}
+
 	/* Disable/save vblank irq handling */
 	drm_crtc_vblank_off(crtc);
 
@@ -962,7 +971,12 @@ static void dpu_crtc_disable(struct drm_crtc *crtc,
 		 */
 		if (dpu_encoder_get_intf_mode(encoder) == INTF_MODE_VIDEO)
 			release_bandwidth = true;
-		dpu_encoder_assign_crtc(encoder, NULL);
+		/* If disable is triggered during psr active(e.g: screen dim in PSR),
+		 * we will need encoder->crtc connection to process the device sleep &
+		 * preserve it during psr sequence.
+		 */
+		if (!crtc->state->self_refresh_active)
+			dpu_encoder_assign_crtc(encoder, NULL);
 	}
 
 	/* wait for frame_event_done completion */
@@ -1010,6 +1024,8 @@ static void dpu_crtc_enable(struct drm_crtc *crtc,
 	struct dpu_crtc *dpu_crtc = to_dpu_crtc(crtc);
 	struct drm_encoder *encoder;
 	bool request_bandwidth = false;
+	struct drm_crtc_state *old_crtc_state =
+		drm_atomic_get_old_crtc_state(state, crtc);
 
 	pm_runtime_get_sync(crtc->dev->dev);
 
@@ -1032,8 +1048,10 @@ static void dpu_crtc_enable(struct drm_crtc *crtc,
 	trace_dpu_crtc_enable(DRMID(crtc), true, dpu_crtc);
 	dpu_crtc->enabled = true;
 
-	drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask)
-		dpu_encoder_assign_crtc(encoder, crtc);
+	if (!old_crtc_state->self_refresh_active) {
+		drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask)
+			dpu_encoder_assign_crtc(encoder, crtc);
+	}
 
 	/* Enable/restore vblank irq handling */
 	drm_crtc_vblank_on(crtc);
@@ -1497,7 +1515,7 @@ struct drm_crtc *dpu_crtc_init(struct drm_device *dev, struct drm_plane *plane,
 {
 	struct drm_crtc *crtc = NULL;
 	struct dpu_crtc *dpu_crtc = NULL;
-	int i;
+	int i, ret;
 
 	dpu_crtc = kzalloc(sizeof(*dpu_crtc), GFP_KERNEL);
 	if (!dpu_crtc)
@@ -1534,6 +1552,11 @@ struct drm_crtc *dpu_crtc_init(struct drm_device *dev, struct drm_plane *plane,
 	/* initialize event handling */
 	spin_lock_init(&dpu_crtc->event_lock);
 
+	ret = drm_self_refresh_helper_init(crtc);
+	if (ret)
+		DPU_ERROR("Failed to initialize %s with SR helpers %d\n",
+			crtc->name, ret);
+
 	DRM_DEBUG_KMS("%s: successfully initialized crtc\n", dpu_crtc->name);
 	return crtc;
 }
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 6eac417..ba9d8ea 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -217,6 +217,14 @@ static u32 dither_matrix[DITHER_MATRIX_SZ] = {
 	15, 7, 13, 5, 3, 11, 1, 9, 12, 4, 14, 6, 0, 8, 2, 10
 };
 
+static inline bool is_self_refresh_active(struct drm_crtc_state *state)
+{
+	if (state && state->self_refresh_active)
+		return true;
+
+	return false;
+}
+
 static void _dpu_encoder_setup_dither(struct dpu_hw_pingpong *hw_pp, unsigned bpc)
 {
 	struct dpu_hw_dither_cfg dither_cfg = { 0 };
@@ -629,7 +637,8 @@ static int dpu_encoder_virt_atomic_check(
 		if (drm_atomic_crtc_needs_modeset(crtc_state)) {
 			dpu_rm_release(global_state, drm_enc);
 
-			if (!crtc_state->active_changed || crtc_state->active)
+			if (!crtc_state->active_changed || crtc_state->active ||
+					crtc_state->self_refresh_active)
 				ret = dpu_rm_reserve(&dpu_kms->rm, global_state,
 						drm_enc, crtc_state, topology);
 		}
@@ -1182,11 +1191,30 @@ static void dpu_encoder_virt_disable(struct drm_encoder *drm_enc,
 {
 	struct dpu_encoder_virt *dpu_enc = NULL;
 	struct msm_drm_private *priv;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *old_state;
 	int i = 0;
 
 	dpu_enc = to_dpu_encoder_virt(drm_enc);
 	DPU_DEBUG_ENC(dpu_enc, "\n");
 
+	if (!drm_enc) {
+		DPU_ERROR("invalid encoder\n");
+		return;
+	}
+	dpu_enc = to_dpu_encoder_virt(drm_enc);
+
+	crtc = dpu_enc->crtc;
+
+	old_state = drm_atomic_get_old_crtc_state(state, crtc);
+
+	/*
+	 * The encoder turn off already occurred when self refresh mode
+	 * was set earlier, in the old_state for the corresponding crtc.
+	 */
+	if (drm_enc->encoder_type == DRM_MODE_ENCODER_TMDS && is_self_refresh_active(old_state))
+		return;
+
 	mutex_lock(&dpu_enc->enc_lock);
 	dpu_enc->enabled = false;
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 47fe11a..d550f90 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -495,7 +495,7 @@ static void dpu_kms_wait_for_commit_done(struct msm_kms *kms,
 		return;
 	}
 
-	if (!crtc->state->active) {
+	if (!drm_atomic_crtc_effectively_active(crtc->state)) {
 		DPU_DEBUG("[crtc:%d] not active\n", crtc->base.id);
 		return;
 	}
-- 
2.7.4

