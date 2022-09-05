Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC955AD63A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238870AbiIEPWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238800AbiIEPVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:21:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4925FF79
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662391246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9kBxkoMSoocenFWS5QnFTVJk53upsFpOoCTaLoDSzmI=;
        b=co0OmERvSBXK/QdeHrIfdZMHfXIWPppSTmen7s+3xxtynhvN0hI6lqYP7HA5o7IdERLalC
        bxLr/udTUb+003PnTIVZOr4atE9rvZ8CILyGoj11VkYTPQCVV7mhyQw1wSfK0qd47I7ugc
        yrvsMxXC3hv8iVnaYZGXb8Ddo1CMWPk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-101-mDr9In5yMaONSAndgqZQMA-1; Mon, 05 Sep 2022 11:20:45 -0400
X-MC-Unique: mDr9In5yMaONSAndgqZQMA-1
Received: by mail-wm1-f70.google.com with SMTP id ay27-20020a05600c1e1b00b003a5bff0df8dso6324133wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 08:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9kBxkoMSoocenFWS5QnFTVJk53upsFpOoCTaLoDSzmI=;
        b=qullWOyHx9HbMHWt0EvNnCseYRad/N7bXNSsGAtbkIONKvfnCFL0ccybsudTh1r+Zs
         L2gK3T2B/7NXWnBXROHjphwbRAAWp3Zf1xdxDunDEu+Ablazw87gZMnY2EHTM4PyPjxy
         bvhk6SY/S9iqlw+G6FuQqlZhHT4jotI9MIl5R7xt+tYMX4xdvWp8TDd5s8c6/WQOJZRD
         dqN3Fc0Ib3FMYjuUM6POI6xrztyjwYZ8/Bwob53Wck70xTX6P7qN7BqimPpFRNLAIcgi
         xCUkIS0xypg+rOfTnUmr/zc6KTnLtHAMVEQJkx3mWKla7a7KDOPKsANZtn1LU2Ng+E6o
         poAg==
X-Gm-Message-State: ACgBeo0RoBZHQggjmOrH3T9rdGc/fd5xwFd/B/bZZqYVlkSpmdkzOCjP
        mCqd/K3amIhEzD2mDU4LqqaimxzVDlRIArnanchwrcI2QJnES8DKlYGsSLCRcIh04KEhWBguAHq
        UwCzdch+k9oJ5dEMKf9mVgPGc
X-Received: by 2002:a05:6000:118e:b0:228:9373:70ae with SMTP id g14-20020a056000118e00b00228937370aemr2737617wrx.467.1662391243882;
        Mon, 05 Sep 2022 08:20:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR57AZWTw36W89LbLt9c7lRycXE7G5TIWvzY7JI3W+d7SJ+dvNHGroLtZktX1idf6HX851gcKw==
X-Received: by 2002:a05:6000:118e:b0:228:9373:70ae with SMTP id g14-20020a056000118e00b00228937370aemr2737601wrx.467.1662391243671;
        Mon, 05 Sep 2022 08:20:43 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id m5-20020adff385000000b00228c792aaaasm1383446wro.100.2022.09.05.08.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 08:20:43 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND drm-misc-next 7/8] drm/arm/malidp: crtc: protect device resources after removal
Date:   Mon,  5 Sep 2022 17:20:40 +0200
Message-Id: <20220905152041.98451-1-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220905151910.98279-1-dakr@redhat.com>
References: <20220905151910.98279-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

