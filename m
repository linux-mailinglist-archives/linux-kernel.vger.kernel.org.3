Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EABF599A80
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 13:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348667AbiHSLJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 07:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348638AbiHSLJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:09:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EF2EF011
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 04:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660907339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jFR3xFdwN9i2Cd3/9jTqWPHspBtbjbbUfilDsWbGEig=;
        b=PM7j39a/jnMTptnA689DVQG9kuSzs2jxNc59T9g6IMEQQlJFzxL0vgIKhCO0Qz2B/jWr9G
        G/fgrBOpLHEKd/6Xo7/NfJh4TvSXoxgmKyDnccFd07eVDpZN4kQS4KuH9qcY7ZReObZDRo
        WqcA/tiH+o/YgCwlW4ofWDUkU5b2cWo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-TC5KqJcqMfuFvqAU0H-sCg-1; Fri, 19 Aug 2022 07:08:58 -0400
X-MC-Unique: TC5KqJcqMfuFvqAU0H-sCg-1
Received: by mail-ed1-f69.google.com with SMTP id m18-20020a056402511200b0043d601a8035so2699030edd.20
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 04:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=jFR3xFdwN9i2Cd3/9jTqWPHspBtbjbbUfilDsWbGEig=;
        b=avKyMQs5jTNuRoWwE+Q2ld6Mrxa23AVKcyuJD9F7Yb3PfQ0vK0ZUe3JOWiqglYQ6oo
         rtnpsgMEiV5Egt4FGmKakxJax6bfiN55ovjDG+wfNtnsrVWML1ZEXcWQS+erLGHeahHq
         ERSyuESyMB3x9OLa+kFk7dpDXDnfBti1+yoR6b9V2SIeepn/u7reV6SWWZ79XLo50mnG
         fUhCHPe0AZ0Tk3bxWXj9sud1TvgEeluLRQxWUIqzwruobEVeVHL53blUDUjqKEQfiE35
         F1mIgJYTK7bwjqhjqU5Oio7LERz/6n39nmaba5pNxg2x36aIRgIYd3f+TPvcJ7T5Wo4g
         12RA==
X-Gm-Message-State: ACgBeo2itiGhQXmrNYqtcnQ5XuW30XtmF2NoaH4Ze2Dsax62UW1UUfwu
        76cXNnGWi/CIr1i8m4/SUnxhCkBUldHpXdhV0xkaLc9d4Ady13oFWhrBrOL99jFITzx5IDLG/O5
        ktVk/ROvS6zZyvWXLxze30L7h
X-Received: by 2002:a05:6402:496:b0:443:a5f5:d3b with SMTP id k22-20020a056402049600b00443a5f50d3bmr5841563edv.331.1660907337411;
        Fri, 19 Aug 2022 04:08:57 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4S7vK3sAEYZ/N6o0dg6PHuk/70e8T70gYOtV0g+o5w19DGgJIB+Ww/rSrXeaZs3FvLKkdEBg==
X-Received: by 2002:a05:6402:496:b0:443:a5f5:d3b with SMTP id k22-20020a056402049600b00443a5f50d3bmr5841545edv.331.1660907337216;
        Fri, 19 Aug 2022 04:08:57 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id l17-20020a1709060cd100b007308fab3eb7sm2167827ejh.195.2022.08.19.04.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 04:08:56 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 3/4] drm/vc4: crtc: protect device resources after removal
Date:   Fri, 19 Aug 2022 13:08:48 +0200
Message-Id: <20220819110849.192037-4-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819110849.192037-1-dakr@redhat.com>
References: <20220819110849.192037-1-dakr@redhat.com>
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

However, the DRM device isn't freed as long as the last user closed it,
hence userspace can still call into the driver.

Therefore protect the critical sections which are accessing those
resources with drm_dev_enter() and drm_dev_exit().

Fixes: 7cc4214c27cf ("drm/vc4: crtc: Switch to drmm_kzalloc")
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 41 +++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 2def6e2ad6f0..0108613e79d5 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -39,6 +39,7 @@
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_framebuffer.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
@@ -295,10 +296,17 @@ struct drm_encoder *vc4_get_crtc_encoder(struct drm_crtc *crtc,
 static void vc4_crtc_pixelvalve_reset(struct drm_crtc *crtc)
 {
 	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
+	struct drm_device *dev = crtc->dev;
+	int idx;
+
+	if (!drm_dev_enter(dev, &idx))
+		return;
 
 	/* The PV needs to be disabled before it can be flushed */
 	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) & ~PV_CONTROL_EN);
 	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) | PV_CONTROL_FIFO_CLR);
+
+	drm_dev_exit(idx);
 }
 
 static void vc4_crtc_config_pv(struct drm_crtc *crtc, struct drm_encoder *encoder,
@@ -321,6 +329,10 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc, struct drm_encoder *encode
 	u32 format = is_dsi1 ? PV_CONTROL_FORMAT_DSIV_24 : PV_CONTROL_FORMAT_24;
 	u8 ppc = pv_data->pixels_per_clock;
 	bool debug_dump_regs = false;
+	int idx;
+
+	if (!drm_dev_enter(dev, &idx))
+		return;
 
 	if (debug_dump_regs) {
 		struct drm_printer p = drm_info_printer(&vc4_crtc->pdev->dev);
@@ -410,6 +422,8 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc, struct drm_encoder *encode
 			 drm_crtc_index(crtc));
 		drm_print_regset32(&p, &vc4_crtc->regset);
 	}
+
+	drm_dev_exit(idx);
 }
 
 static void require_hvs_enabled(struct drm_device *dev)
@@ -430,7 +444,10 @@ static int vc4_crtc_disable(struct drm_crtc *crtc,
 	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
-	int ret;
+	int idx, ret;
+
+	if (!drm_dev_enter(dev, &idx))
+		return -ENODEV;
 
 	CRTC_WRITE(PV_V_CONTROL,
 		   CRTC_READ(PV_V_CONTROL) & ~PV_VCONTROL_VIDEN);
@@ -464,6 +481,8 @@ static int vc4_crtc_disable(struct drm_crtc *crtc,
 	if (vc4_encoder && vc4_encoder->post_crtc_powerdown)
 		vc4_encoder->post_crtc_powerdown(encoder, state);
 
+	drm_dev_exit(idx);
+
 	return 0;
 }
 
@@ -588,10 +607,14 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
 	struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc, new_state);
 	struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
+	int idx;
 
 	drm_dbg(dev, "Enabling CRTC %s (%u) connected to Encoder %s (%u)",
 		crtc->name, crtc->base.id, encoder->name, encoder->base.id);
 
+	if (!drm_dev_enter(dev, &idx))
+		return;
+
 	require_hvs_enabled(dev);
 
 	/* Enable vblank irq handling before crtc is started otherwise
@@ -619,6 +642,8 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	if (vc4_encoder->post_crtc_enable)
 		vc4_encoder->post_crtc_enable(encoder, state);
+
+	drm_dev_exit(idx);
 }
 
 static enum drm_mode_status vc4_crtc_mode_valid(struct drm_crtc *crtc,
@@ -711,17 +736,31 @@ static int vc4_crtc_atomic_check(struct drm_crtc *crtc,
 static int vc4_enable_vblank(struct drm_crtc *crtc)
 {
 	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
+	struct drm_device *dev = crtc->dev;
+	int idx;
+
+	if (!drm_dev_enter(dev, &idx))
+		return -ENODEV;
 
 	CRTC_WRITE(PV_INTEN, PV_INT_VFP_START);
 
+	drm_dev_exit(idx);
+
 	return 0;
 }
 
 static void vc4_disable_vblank(struct drm_crtc *crtc)
 {
 	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
+	struct drm_device *dev = crtc->dev;
+	int idx;
+
+	if (!drm_dev_enter(dev, &idx))
+		return;
 
 	CRTC_WRITE(PV_INTEN, 0);
+
+	drm_dev_exit(idx);
 }
 
 static void vc4_crtc_handle_page_flip(struct vc4_crtc *vc4_crtc)
-- 
2.37.2

