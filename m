Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B8F5991C1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 02:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240896AbiHSA30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 20:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiHSA3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 20:29:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2039772EE5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 17:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660868957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nZkz/OabS5gsWkkQKjM89j1/6sZadLuGX+5mWMwAoOc=;
        b=Ozy6dr5GgILkZIv2s6jb4Fbw4InbqoleQT3/1uHs8H44jTKeYmw7YWEfC3neNj5lJtGJQJ
        09HLvhyLjlYqeTOZwGxX7j5DdftGGNejwKYq9NxAuDMmE7JFNcRhkFtRmCFIxxGR8OS2Xo
        899IzOev64Sp9NpT1U8vfTIK8zzp47s=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-21-CpF31JujOwiOZR8wZITIig-1; Thu, 18 Aug 2022 20:29:15 -0400
X-MC-Unique: CpF31JujOwiOZR8wZITIig-1
Received: by mail-ed1-f72.google.com with SMTP id q32-20020a05640224a000b004462f105fa9so738934eda.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 17:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=nZkz/OabS5gsWkkQKjM89j1/6sZadLuGX+5mWMwAoOc=;
        b=4z458NPtovL/rxP7J3UP5MGK2qerwaF79Me/C18Qvr6Mwz3yeVWK7uCGLxtg1/qBXg
         D+dEpqdnd/mNPTs2wmeEWKGIEUS1D5lEaa2KQdD04HQjcBeMBWczpMQHWye5CyIWnZKB
         Oppqry8Ag3Lg9W4vJ1xzmKFa088FA04OC/UktHS4gO3yFEuEHomki696jKAASg+MFNVk
         Z6sGMEHntfTgg/o8IrHvqr3b6hcAIxILRwoB774kFsWEryKNyHHodzhkDad4Hf6aJF0l
         gMTOR7Favnez+uEZV/rfJFrvK0qsRUFboHq973fr8ERgRKXei2kMy76YnbaaIDLq6kN0
         hyyg==
X-Gm-Message-State: ACgBeo2RQ591r3lVPrL0K9N6c28fanMF6PrnBurCjxZ+sc+fcRhWLCgt
        I8xHTN2Dkh+1cMly+OA4y/zFv4lKG57JfJDUb9hi47FuqqXFVmk1Zwclh3KzdFZAXYbtxLMwK6w
        zMIJmcV8gOR+ito6PdZmqllG7
X-Received: by 2002:a17:907:69b0:b0:730:a1f0:63e7 with SMTP id ra48-20020a17090769b000b00730a1f063e7mr3230741ejc.364.1660868954669;
        Thu, 18 Aug 2022 17:29:14 -0700 (PDT)
X-Google-Smtp-Source: AA6agR69VOlMq30KnwZaAQTSrGpxNLSfPxSOQvLe3+fq+Fwv51y4m04N1qfRfTUdN5d2gTKsUNEPdQ==
X-Received: by 2002:a17:907:69b0:b0:730:a1f0:63e7 with SMTP id ra48-20020a17090769b000b00730a1f063e7mr3230736ejc.364.1660868954509;
        Thu, 18 Aug 2022 17:29:14 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id b26-20020aa7cd1a000000b004460b020ffdsm2027913edw.83.2022.08.18.17.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 17:29:14 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 3/3] drm/vc4: crtc: protect device resources after removal
Date:   Fri, 19 Aug 2022 02:29:05 +0200
Message-Id: <20220819002905.82095-4-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819002905.82095-1-dakr@redhat.com>
References: <20220819002905.82095-1-dakr@redhat.com>
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
index 2def6e2ad6f0..51daf190196e 100644
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
@@ -430,13 +444,18 @@ static int vc4_crtc_disable(struct drm_crtc *crtc,
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
 	ret = wait_for(!(CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_VIDEN), 1);
 	WARN_ONCE(ret, "Timeout waiting for !PV_VCONTROL_VIDEN\n");
 
+	drm_dev_exit(idx);
+
 	/*
 	 * This delay is needed to avoid to get a pixel stuck in an
 	 * unflushable FIFO between the pixelvalve and the HDMI
@@ -588,6 +607,7 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
 	struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc, new_state);
 	struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
+	int idx;
 
 	drm_dbg(dev, "Enabling CRTC %s (%u) connected to Encoder %s (%u)",
 		crtc->name, crtc->base.id, encoder->name, encoder->base.id);
@@ -606,6 +626,9 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	vc4_crtc_config_pv(crtc, encoder, state);
 
+	if (!drm_dev_enter(dev, &idx))
+		return;
+
 	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) | PV_CONTROL_EN);
 
 	if (vc4_encoder->pre_crtc_enable)
@@ -617,6 +640,8 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 	CRTC_WRITE(PV_V_CONTROL,
 		   CRTC_READ(PV_V_CONTROL) | PV_VCONTROL_VIDEN);
 
+	drm_dev_exit(idx);
+
 	if (vc4_encoder->post_crtc_enable)
 		vc4_encoder->post_crtc_enable(encoder, state);
 }
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

