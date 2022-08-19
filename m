Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A4859A7B9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 23:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352492AbiHSVZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 17:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352501AbiHSVZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 17:25:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BE310775A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660944345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9kBxkoMSoocenFWS5QnFTVJk53upsFpOoCTaLoDSzmI=;
        b=Lk0sXJRa8oaslcqH/PnAG3SfitapT6lDxp2BR7kVyT7J9tqmihQZmq9ArypAsD9NbF540r
        Pzpinsyl1XkR+w3aCUNzGCayrO9lkHHcWGej6pjI+fu8vDTS5tRuvLCY3e/+QrVDnuDi2R
        PY3kYl1SUI0SPi5yA6Huh6hVf8H7fw0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-306-vVR-UmmiP0yQiv5tJSuosQ-1; Fri, 19 Aug 2022 17:25:44 -0400
X-MC-Unique: vVR-UmmiP0yQiv5tJSuosQ-1
Received: by mail-ej1-f71.google.com with SMTP id js11-20020a17090797cb00b00730d73eac83so1910234ejc.19
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=9kBxkoMSoocenFWS5QnFTVJk53upsFpOoCTaLoDSzmI=;
        b=LhjfTqWg0L7t0OBr9ozdT3bgViiqGa1ukwd1ovv2vLeMky1tMV7aRHqW6yOAVjGn4H
         8J9wfq6RAxvh3PEgDKLC1tiZ2NdD5F0sS9gN2JvNAJsNnco6vfNnyRd81E0OGZ2HL60w
         GwCUxZJSylJP1nsGMfLGuHYjw0JMnEeOeyO9CsXQA6CViricLWxuLSaA/uLyNaj746pJ
         9OOMXfyjChnaJowGNLz6IkhvWZd/JSZ7ZQjGcUjxJWaLrR28Z1SZ0YCvYmtBhJ/zAs2e
         TDR5M94AJjq1cF6pQrndSTS3Qa4GfKqQu5XTwlNlY+ecNaUK92vAFwz122mNyOvynhH4
         OrSw==
X-Gm-Message-State: ACgBeo2TOmf5D42MYp+Z6DFasgljaq1gt3WTX2N9QntXoIMRCxmGvGrH
        CuLM/lTTAGyp3a1D6J6et+bxVpM6rz/2e0h7awmNcM9JRS/QpT9vxQ4S939/CzMM8q2GlL0B28z
        I1HxNFmwiwOlz8NH6PmPqEf6O
X-Received: by 2002:a05:6402:50cc:b0:43e:6860:58fc with SMTP id h12-20020a05640250cc00b0043e686058fcmr7476994edb.243.1660944342982;
        Fri, 19 Aug 2022 14:25:42 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4+1euniUCHg7ze4TUzUMROSIcVgRyqCPA59DKYxuvVfH4krbl50afSwL5v7W/5t2MI7qbKbQ==
X-Received: by 2002:a05:6402:50cc:b0:43e:6860:58fc with SMTP id h12-20020a05640250cc00b0043e686058fcmr7476979edb.243.1660944342824;
        Fri, 19 Aug 2022 14:25:42 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id ej19-20020a056402369300b00445f1fa531bsm3650681edb.25.2022.08.19.14.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 14:25:42 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 7/8] drm/arm/malidp: crtc: protect device resources after removal
Date:   Fri, 19 Aug 2022 23:25:37 +0200
Message-Id: <20220819212538.559902-1-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819212015.556220-1-dakr@redhat.com>
References: <20220819212015.556220-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Hardware) resources which are bound to the driver and device lifecycle
must not be accessed after the device and driver are unbound.

However, the DRM device isn't freed as long as the last user didn't
close it, hence userspace can still call into the driver.

Therefore protect the critical sections which are accessing those
resources with drm_dev_enter() and drm_dev_exit().

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/malidp_crtc.c | 41 +++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/malidp_crtc.c
index dc01c43f6193..fa95278abae6 100644
--- a/drivers/gpu/drm/arm/malidp_crtc.c
+++ b/drivers/gpu/drm/arm/malidp_crtc.c
@@ -14,6 +14,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
@@ -27,6 +28,7 @@ static enum drm_mode_status malidp_crtc_mode_valid(struct drm_crtc *crtc,
 {
 	struct malidp_drm *malidp = crtc_to_malidp_device(crtc);
 	struct malidp_hw_device *hwdev = malidp->dev;
+	int idx;
 
 	/*
 	 * check that the hardware can drive the required clock rate,
@@ -34,6 +36,9 @@ static enum drm_mode_status malidp_crtc_mode_valid(struct drm_crtc *crtc,
 	 */
 	long rate, req_rate = mode->crtc_clock * 1000;
 
+	if (!drm_dev_enter(&malidp->base, &idx))
+		return MODE_NOCLOCK;
+
 	if (req_rate) {
 		rate = clk_round_rate(hwdev->pxlclk, req_rate);
 		if (rate != req_rate) {
@@ -43,6 +48,8 @@ static enum drm_mode_status malidp_crtc_mode_valid(struct drm_crtc *crtc,
 		}
 	}
 
+	drm_dev_exit(idx);
+
 	return MODE_OK;
 }
 
@@ -53,6 +60,10 @@ static void malidp_crtc_atomic_enable(struct drm_crtc *crtc,
 	struct malidp_hw_device *hwdev = malidp->dev;
 	struct videomode vm;
 	int err = pm_runtime_get_sync(crtc->dev->dev);
+	int idx;
+
+	if (!drm_dev_enter(&malidp->base, &idx))
+		return;
 
 	if (err < 0) {
 		DRM_DEBUG_DRIVER("Failed to enable runtime power management: %d\n", err);
@@ -68,6 +79,8 @@ static void malidp_crtc_atomic_enable(struct drm_crtc *crtc,
 	hwdev->hw->modeset(hwdev, &vm);
 	hwdev->hw->leave_config_mode(hwdev);
 	drm_crtc_vblank_on(crtc);
+
+	drm_dev_exit(idx);
 }
 
 static void malidp_crtc_atomic_disable(struct drm_crtc *crtc,
@@ -77,7 +90,10 @@ static void malidp_crtc_atomic_disable(struct drm_crtc *crtc,
 									 crtc);
 	struct malidp_drm *malidp = crtc_to_malidp_device(crtc);
 	struct malidp_hw_device *hwdev = malidp->dev;
-	int err;
+	int err, idx;
+
+	if (!drm_dev_enter(&malidp->base, &idx))
+		return;
 
 	/* always disable planes on the CRTC that is being turned off */
 	drm_atomic_helper_disable_planes_on_crtc(old_state, false);
@@ -91,6 +107,8 @@ static void malidp_crtc_atomic_disable(struct drm_crtc *crtc,
 	if (err < 0) {
 		DRM_DEBUG_DRIVER("Failed to disable runtime power management: %d\n", err);
 	}
+
+	drm_dev_exit(idx);
 }
 
 static const struct gamma_curve_segment {
@@ -260,7 +278,10 @@ static int malidp_crtc_atomic_check_scaling(struct drm_crtc *crtc,
 	u32 h_upscale_factor = 0; /* U16.16 */
 	u32 v_upscale_factor = 0; /* U16.16 */
 	u8 scaling = cs->scaled_planes_mask;
-	int ret;
+	int idx, ret;
+
+	if (!drm_dev_enter(&malidp->base, &idx))
+		return -ENODEV;
 
 	if (!scaling) {
 		s->scale_enable = false;
@@ -334,6 +355,9 @@ static int malidp_crtc_atomic_check_scaling(struct drm_crtc *crtc,
 	ret = hwdev->hw->se_calc_mclk(hwdev, s, &vm);
 	if (ret < 0)
 		return -EINVAL;
+
+	drm_dev_exit(idx);
+
 	return 0;
 }
 
@@ -498,9 +522,16 @@ static int malidp_crtc_enable_vblank(struct drm_crtc *crtc)
 {
 	struct malidp_drm *malidp = crtc_to_malidp_device(crtc);
 	struct malidp_hw_device *hwdev = malidp->dev;
+	int idx;
+
+	if (!drm_dev_enter(&malidp->base, &idx))
+		return -ENODEV;
 
 	malidp_hw_enable_irq(hwdev, MALIDP_DE_BLOCK,
 			     hwdev->hw->map.de_irq_map.vsync_irq);
+
+	drm_dev_exit(idx);
+
 	return 0;
 }
 
@@ -508,9 +539,15 @@ static void malidp_crtc_disable_vblank(struct drm_crtc *crtc)
 {
 	struct malidp_drm *malidp = crtc_to_malidp_device(crtc);
 	struct malidp_hw_device *hwdev = malidp->dev;
+	int idx;
+
+	if (!drm_dev_enter(&malidp->base, &idx))
+		return;
 
 	malidp_hw_disable_irq(hwdev, MALIDP_DE_BLOCK,
 			      hwdev->hw->map.de_irq_map.vsync_irq);
+
+	drm_dev_exit(idx);
 }
 
 static const struct drm_crtc_funcs malidp_crtc_funcs = {
-- 
2.37.2

