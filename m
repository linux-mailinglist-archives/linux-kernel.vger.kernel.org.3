Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001A8567516
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiGERBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiGERBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:01:24 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CB11C915;
        Tue,  5 Jul 2022 10:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657040484; x=1688576484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=qxfVrDaCDuskuhnHaD48bAjAcwUP0f9Vqaw/vpqssR8=;
  b=NUt2KkZl4usSBGHINGSErUcKDOK/QzpGjOz3vSwRHGA/rwgqAdseLO1T
   K2/L5VkxK6ITYEVs16QXjOP6m2lbCFo3tkfSuCDNiEijJld1CI/P/vMj3
   CQeUqtY6FE/mBMAfTqXuuSOX+0Q7Xz4H9gyi757G2aG6lJ1AniWogBNu6
   A=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 05 Jul 2022 10:01:23 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 05 Jul 2022 10:01:21 -0700
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg01-blr.qualcomm.com with ESMTP; 05 Jul 2022 22:30:57 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id 0429F3CC2; Tue,  5 Jul 2022 22:30:55 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_khsieh@quicinc.com, quic_vproddut@quicinc.com,
        bjorn.andersson@linaro.org, quic_aravindh@quicinc.com,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com
Subject: [PATCH v4 1/7] drm/msm/disp/dpu1: clear dpu_assign_crtc and get crtc from drm_enc instead of dpu_enc
Date:   Tue,  5 Jul 2022 22:30:39 +0530
Message-Id: <1657040445-13067-2-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657040445-13067-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1657040445-13067-1-git-send-email-quic_vpolimer@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update crtc retrieval from dpu_enc to drm_enc, since new links get set
as part of the update legacy mode set. The dpu_enc->crtc cache is no
more needed, hence cleaning it as part of this change.

Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  4 ----
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 18 +++---------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  8 --------
 3 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index b56f777..f91e3d1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -972,7 +972,6 @@ static void dpu_crtc_disable(struct drm_crtc *crtc,
 		 */
 		if (dpu_encoder_get_intf_mode(encoder) == INTF_MODE_VIDEO)
 			release_bandwidth = true;
-		dpu_encoder_assign_crtc(encoder, NULL);
 	}
 
 	/* wait for frame_event_done completion */
@@ -1042,9 +1041,6 @@ static void dpu_crtc_enable(struct drm_crtc *crtc,
 	trace_dpu_crtc_enable(DRMID(crtc), true, dpu_crtc);
 	dpu_crtc->enabled = true;
 
-	drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask)
-		dpu_encoder_assign_crtc(encoder, crtc);
-
 	/* Enable/restore vblank irq handling */
 	drm_crtc_vblank_on(crtc);
 }
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 52516eb..5629c0b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1254,8 +1254,8 @@ static void dpu_encoder_vblank_callback(struct drm_encoder *drm_enc,
 	dpu_enc = to_dpu_encoder_virt(drm_enc);
 
 	spin_lock_irqsave(&dpu_enc->enc_spinlock, lock_flags);
-	if (dpu_enc->crtc)
-		dpu_crtc_vblank_callback(dpu_enc->crtc);
+	if (drm_enc->crtc)
+		dpu_crtc_vblank_callback(drm_enc->crtc);
 	spin_unlock_irqrestore(&dpu_enc->enc_spinlock, lock_flags);
 
 	atomic_inc(&phy_enc->vsync_cnt);
@@ -1280,18 +1280,6 @@ static void dpu_encoder_underrun_callback(struct drm_encoder *drm_enc,
 	DPU_ATRACE_END("encoder_underrun_callback");
 }
 
-void dpu_encoder_assign_crtc(struct drm_encoder *drm_enc, struct drm_crtc *crtc)
-{
-	struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(drm_enc);
-	unsigned long lock_flags;
-
-	spin_lock_irqsave(&dpu_enc->enc_spinlock, lock_flags);
-	/* crtc should always be cleared before re-assigning */
-	WARN_ON(crtc && dpu_enc->crtc);
-	dpu_enc->crtc = crtc;
-	spin_unlock_irqrestore(&dpu_enc->enc_spinlock, lock_flags);
-}
-
 void dpu_encoder_toggle_vblank_for_crtc(struct drm_encoder *drm_enc,
 					struct drm_crtc *crtc, bool enable)
 {
@@ -1302,7 +1290,7 @@ void dpu_encoder_toggle_vblank_for_crtc(struct drm_encoder *drm_enc,
 	trace_dpu_enc_vblank_cb(DRMID(drm_enc), enable);
 
 	spin_lock_irqsave(&dpu_enc->enc_spinlock, lock_flags);
-	if (dpu_enc->crtc != crtc) {
+	if (drm_enc->crtc != crtc) {
 		spin_unlock_irqrestore(&dpu_enc->enc_spinlock, lock_flags);
 		return;
 	}
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
index 781d41c..edba815 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
@@ -39,14 +39,6 @@ struct msm_display_info {
 };
 
 /**
- * dpu_encoder_assign_crtc - Link the encoder to the crtc it's assigned to
- * @encoder:	encoder pointer
- * @crtc:	crtc pointer
- */
-void dpu_encoder_assign_crtc(struct drm_encoder *encoder,
-			     struct drm_crtc *crtc);
-
-/**
  * dpu_encoder_toggle_vblank_for_crtc - Toggles vblank interrupts on or off if
  *	the encoder is assigned to the given crtc
  * @encoder:	encoder pointer
-- 
2.7.4

