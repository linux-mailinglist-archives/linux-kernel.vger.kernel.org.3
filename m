Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FF3502D4F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355640AbiDOPuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355626AbiDOPuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:50:25 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F12986F1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:47:56 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x18so3247620wrc.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z3NAus3DBQ3rA5abnaly1KYO3d+31BXc2jT1/06zaWU=;
        b=gMVKNG8Sn7N8Cr8qoxwKxQEKVfdJZOjuX2zRtTioOhvs0ImnH98R2BnSStp58MnElU
         xU/rsr8ge2E733Mmqp7rU5uPl09/PmmY1PGllmUdILYJIIEUhsBFePA1jE4pUxwMen1U
         nXZWPrXahH1TwZ7LhU1BmHrDGHPMtYCt0p/Ndft70fMuyrKWJhR6O25NqXObJKrM52Dq
         AYzHhOfe4aLMZgD9D7aR2DY4KAC2rQFYjlhuhj5PG8PbfkNdtLDGCX1z2vWI1S2NTZ2N
         cUtpopQ1gU/hSKPaf7f8viiwkxxaX74ED9fon5Y5alcWwdJZUMEdh93XkuxiWiUmxTRk
         qWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z3NAus3DBQ3rA5abnaly1KYO3d+31BXc2jT1/06zaWU=;
        b=1mHiXiU3yt3j9o9SxeTdxvMPkqo3ERT08HTDG/D7vlxyQM88WyPbzZvpS0j+DVl0WB
         NR4fWdKMFngsnBLkIY/gD1Vw2Xc2V+1DU/FaBF+BIQPgxXSNX99RyGnGnsvhyHjbvmBu
         nBDMQYO5aJLRBr7LDfvbGNUk1+PlxpkPDSu9yp1vtm63H8Z3q08tJKfFMTtm5KpYtQ0y
         OqKg14atkO74U0eM/yBN9nKwqbJdapLzYgZC6nFT8KaT1bir3tSpPbLye3+tz1WGNlsW
         P8EQZ7Y6bc4t8bOgq9nhWnMxHAEcO5IXLLwTN7QOSwXd4cTdn1PhrLLh3Hh5diWLVTcw
         QY2w==
X-Gm-Message-State: AOAM533Lk8rrT+Xw4MRGya6BzfAKbGaKcx2XeU0vZp2++N9F85KOaw0m
        kk2WL/8e4oQsel1+7kO96NHky1YhdXE=
X-Google-Smtp-Source: ABdhPJyW2x2EFgqpv5A2q/Gy87tMC0ikN/Nmxu3gJ86Y5Z1liA26skS+/lodxtTsH/reQnsjkBwVFw==
X-Received: by 2002:adf:cc88:0:b0:207:a46c:ad8d with SMTP id p8-20020adfcc88000000b00207a46cad8dmr5699598wrj.95.1650037674611;
        Fri, 15 Apr 2022 08:47:54 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id a7-20020adffb87000000b00207982c7f4dsm4349655wrr.67.2022.04.15.08.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 08:47:54 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     emma@anholt.net
Cc:     mripard@kernel.org, laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, daniel@ffwll.ch, p.zabel@pengutronix.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 2/2] drm/vc4: hdmi: Remove vc4_hdmi_encoder.hdmi_monitor
Date:   Fri, 15 Apr 2022 17:47:45 +0200
Message-Id: <20220415154745.170597-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415154745.170597-1-jose.exposito89@gmail.com>
References: <20220415154745.170597-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vc4_hdmi_encoder.hdmi_monitor field was used to cache the value
returned by drm_detect_hdmi_monitor() in order to avoid calling it
multiple times.

Now that drm_detect_hdmi_monitor() has been replaced with
drm_display_info.is_hdmi, there is no need to cache it in the driver
encoder struct.

Remove vc4_hdmi_encoder.hdmi_monitor and use drm_display_info.is_hdmi
instead.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 17 ++++++-----------
 drivers/gpu/drm/vc4/vc4_hdmi.h |  1 -
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index ecdb1ffc2023..9c73a211ae80 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -107,9 +107,9 @@ static bool vc4_hdmi_mode_needs_scrambling(const struct drm_display_mode *mode)
 static bool vc4_hdmi_is_full_range_rgb(struct vc4_hdmi *vc4_hdmi,
 				       const struct drm_display_mode *mode)
 {
-	struct vc4_hdmi_encoder *vc4_encoder = &vc4_hdmi->encoder;
+	struct drm_display_info *display = &vc4_hdmi->connector.display_info;
 
-	return !vc4_encoder->hdmi_monitor ||
+	return !display->is_hdmi ||
 		drm_default_rgb_quant_range(mode) == HDMI_QUANTIZATION_RANGE_FULL;
 }
 
@@ -216,7 +216,6 @@ vc4_hdmi_connector_detect(struct drm_connector *connector, bool force)
 
 			if (edid) {
 				cec_s_phys_addr_from_edid(vc4_hdmi->cec_adap, edid);
-				vc4_hdmi->encoder.hdmi_monitor = connector->display_info.is_hdmi;
 				kfree(edid);
 			}
 		}
@@ -242,7 +241,6 @@ static void vc4_hdmi_connector_destroy(struct drm_connector *connector)
 static int vc4_hdmi_connector_get_modes(struct drm_connector *connector)
 {
 	struct vc4_hdmi *vc4_hdmi = connector_to_vc4_hdmi(connector);
-	struct vc4_hdmi_encoder *vc4_encoder = &vc4_hdmi->encoder;
 	int ret = 0;
 	struct edid *edid;
 
@@ -255,8 +253,6 @@ static int vc4_hdmi_connector_get_modes(struct drm_connector *connector)
 		goto out;
 	}
 
-	vc4_encoder->hdmi_monitor = connector->display_info.is_hdmi;
-
 	drm_connector_update_edid_property(connector, edid);
 	ret = drm_add_edid_modes(connector, edid);
 	kfree(edid);
@@ -578,13 +574,12 @@ static void vc4_hdmi_set_infoframes(struct drm_encoder *encoder)
 static bool vc4_hdmi_supports_scrambling(struct drm_encoder *encoder,
 					 struct drm_display_mode *mode)
 {
-	struct vc4_hdmi_encoder *vc4_encoder = to_vc4_hdmi_encoder(encoder);
 	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
 	struct drm_display_info *display = &vc4_hdmi->connector.display_info;
 
 	lockdep_assert_held(&vc4_hdmi->mutex);
 
-	if (!vc4_encoder->hdmi_monitor)
+	if (!display->is_hdmi)
 		return false;
 
 	if (!display->hdmi.scdc.supported ||
@@ -1147,7 +1142,7 @@ static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder,
 {
 	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
 	struct drm_display_mode *mode = &vc4_hdmi->saved_adjusted_mode;
-	struct vc4_hdmi_encoder *vc4_encoder = to_vc4_hdmi_encoder(encoder);
+	struct drm_display_info *display = &vc4_hdmi->connector.display_info;
 	bool hsync_pos = mode->flags & DRM_MODE_FLAG_PHSYNC;
 	bool vsync_pos = mode->flags & DRM_MODE_FLAG_PVSYNC;
 	unsigned long flags;
@@ -1168,7 +1163,7 @@ static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder,
 	HDMI_WRITE(HDMI_VID_CTL,
 		   HDMI_READ(HDMI_VID_CTL) & ~VC4_HD_VID_CTL_BLANKPIX);
 
-	if (vc4_encoder->hdmi_monitor) {
+	if (display->is_hdmi) {
 		HDMI_WRITE(HDMI_SCHEDULER_CONTROL,
 			   HDMI_READ(HDMI_SCHEDULER_CONTROL) |
 			   VC4_HDMI_SCHEDULER_CONTROL_MODE_HDMI);
@@ -1195,7 +1190,7 @@ static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder,
 			  "!VC4_HDMI_SCHEDULER_CONTROL_HDMI_ACTIVE\n");
 	}
 
-	if (vc4_encoder->hdmi_monitor) {
+	if (display->is_hdmi) {
 		spin_lock_irqsave(&vc4_hdmi->hw_lock, flags);
 
 		WARN_ON(!(HDMI_READ(HDMI_SCHEDULER_CONTROL) &
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index 1076faeab616..44977002445f 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -11,7 +11,6 @@
 /* VC4 HDMI encoder KMS struct */
 struct vc4_hdmi_encoder {
 	struct vc4_encoder base;
-	bool hdmi_monitor;
 };
 
 static inline struct vc4_hdmi_encoder *
-- 
2.25.1

