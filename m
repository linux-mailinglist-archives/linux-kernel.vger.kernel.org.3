Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4695874A2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 02:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbiHBAEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 20:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbiHBAER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 20:04:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEC1D42AEA
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 17:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659398654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ptkcvOjmMlKZ5YEdNEgcEAb79T7LLbJD6CViXt9Cghk=;
        b=Ws6E/aeHj6xtQvqDucVga0Q/tTmV5wCEorStJ2DnrfroivHcUNWQhqTlwAecxBYWv7VM+S
        kXr1/llwEo2vxLmfwVgfJJtPpcMQ88qbFwHXwDNKKCQ8yw530WTqE59xYQOJcWdedt5cyD
        bIhrAYA7v/mWejNpmJNfHJVEoyuRZOY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-JKUft4kqMIuT1cAcml9hNw-1; Mon, 01 Aug 2022 20:04:13 -0400
X-MC-Unique: JKUft4kqMIuT1cAcml9hNw-1
Received: by mail-ej1-f69.google.com with SMTP id nb10-20020a1709071c8a00b006e8f89863ceso3515925ejc.18
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 17:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ptkcvOjmMlKZ5YEdNEgcEAb79T7LLbJD6CViXt9Cghk=;
        b=H/BODAouibU/1mQoLQ/GFLxUz0OM/qgm2EaAKTYAy/eSjrbOaNoRewvfpNPgwsRdsS
         9jwFa39qHcq8gXz7wCc85pp7FYYYeMI3x+I6YqN6a9fjg61/+ZpkeReRLAnIu98mUbR5
         +RR6nwEO2jbzJAjeeFhyf5atcfOShLiu5wMmCooPwDyWy8qBTJdQ/3FdqUqD6/UXT0ll
         /yfnndQ5kSjbiBOnWvqUcrxldncMLLzU2VNCw9RcdOgvsZFzxTEPyw2QO0+taoNFWVAo
         hpYEVOKEcnTKnt3iyttAy7pFBVbyi19N3QwUOyuN0490wwidPQ0Mnc3lJAJsKEw8fz+o
         uu+Q==
X-Gm-Message-State: AJIora+PXQBqrRfcsc6e/1qV1dXNKNm5feJBmNlpMAoQZ+cJTx+x1L95
        7O3XmpypYmPQx3NjMf8ymi0ubZba8+OwNLARb3l1DOuSf66ubLExUDqQi58BJYrfhFb/+omlrA5
        Jybz8n3e0qpRKZ5aRrhHcUHWk
X-Received: by 2002:a17:907:2808:b0:72b:57c2:5e1e with SMTP id eb8-20020a170907280800b0072b57c25e1emr14002629ejc.577.1659398652187;
        Mon, 01 Aug 2022 17:04:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1un3FNpFPIPULSji27VST6h4U4Sq56PhjNrqDqR1dujheeDOKwf7vNmSinXhcSb+DQHFeMC/Q==
X-Received: by 2002:a17:907:2808:b0:72b:57c2:5e1e with SMTP id eb8-20020a170907280800b0072b57c25e1emr14002616ejc.577.1659398652018;
        Mon, 01 Aug 2022 17:04:12 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id s4-20020a056402036400b0043cbdb16fbbsm7461686edw.24.2022.08.01.17.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 17:04:11 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, tzimmermann@suse.de, mripard@kernel.org,
        sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v7 1/5] drm/fb: remove unused includes of drm_fb_cma_helper.h
Date:   Tue,  2 Aug 2022 02:04:01 +0200
Message-Id: <20220802000405.949236-2-dakr@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220802000405.949236-1-dakr@redhat.com>
References: <20220802000405.949236-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quite a lot of drivers include the drm_fb_cma_helper.h header file
without actually making use of it's provided API, hence remove those
includes.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/hdlcd_drv.c                 | 1 -
 drivers/gpu/drm/arm/malidp_drv.c                | 1 -
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c         | 1 -
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c       | 1 -
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c       | 1 -
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 1 -
 drivers/gpu/drm/imx/imx-drm-core.c              | 1 -
 drivers/gpu/drm/imx/ipuv3-crtc.c                | 1 -
 drivers/gpu/drm/logicvc/logicvc_mode.c          | 1 -
 drivers/gpu/drm/pl111/pl111_drv.c               | 1 -
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c          | 1 -
 drivers/gpu/drm/rcar-du/rcar_du_drv.c           | 1 -
 drivers/gpu/drm/rcar-du/rcar_du_kms.c           | 1 -
 drivers/gpu/drm/shmobile/shmob_drm_kms.c        | 1 -
 drivers/gpu/drm/solomon/ssd130x.c               | 1 -
 drivers/gpu/drm/sti/sti_drv.c                   | 1 -
 drivers/gpu/drm/sti/sti_plane.c                 | 1 -
 drivers/gpu/drm/stm/drv.c                       | 1 -
 drivers/gpu/drm/sun4i/sun4i_drv.c               | 1 -
 drivers/gpu/drm/sun4i/sun8i_mixer.c             | 1 -
 drivers/gpu/drm/tidss/tidss_crtc.c              | 1 -
 drivers/gpu/drm/tidss/tidss_kms.c               | 1 -
 drivers/gpu/drm/tidss/tidss_plane.c             | 1 -
 drivers/gpu/drm/tve200/tve200_drv.c             | 1 -
 drivers/gpu/drm/v3d/v3d_drv.c                   | 1 -
 drivers/gpu/drm/vc4/vc4_drv.c                   | 1 -
 26 files changed, 26 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 350ca4e4eaa6..b32168e3f9ae 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -26,7 +26,6 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_debugfs.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index d5aef21426cf..fa6c1a4254dc 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -19,7 +19,6 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_gem_cma_helper.h>
diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index 7780b72de9e8..54aa8af45829 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -16,7 +16,6 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_device.h>
-#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index 7a503bf08d0f..4baa4977e473 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -20,7 +20,6 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_modeset_helper.h>
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c
index d763f53f480c..5b47000738e4 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c
@@ -6,7 +6,6 @@
  */
 
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_probe_helper.h>
 
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 2af51df6dca7..e8b0fe970969 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -19,7 +19,6 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
index 50fd7aac5198..e43345bd1346 100644
--- a/drivers/gpu/drm/imx/imx-drm-core.c
+++ b/drivers/gpu/drm/imx/imx-drm-core.c
@@ -16,7 +16,6 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
diff --git a/drivers/gpu/drm/imx/ipuv3-crtc.c b/drivers/gpu/drm/imx/ipuv3-crtc.c
index f7863d6dea80..d9f832f952c2 100644
--- a/drivers/gpu/drm/imx/ipuv3-crtc.c
+++ b/drivers/gpu/drm/imx/ipuv3-crtc.c
@@ -18,7 +18,6 @@
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_probe_helper.h>
diff --git a/drivers/gpu/drm/logicvc/logicvc_mode.c b/drivers/gpu/drm/logicvc/logicvc_mode.c
index 11940704f644..c59da7039dc1 100644
--- a/drivers/gpu/drm/logicvc/logicvc_mode.c
+++ b/drivers/gpu/drm/logicvc/logicvc_mode.c
@@ -10,7 +10,6 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index 19a4324bd356..5b5f3573b619 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -48,7 +48,6 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_gem_cma_helper.h>
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 169ca0c8912f..ed887ebd2f6b 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -17,7 +17,6 @@
 #include <drm/drm_bridge.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_device.h>
-#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_vblank.h>
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 70d85610d720..110ec9538b44 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -20,7 +20,6 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_managed.h>
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 761451ee5263..7fed5b0c65ce 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -11,7 +11,6 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_device.h>
-#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
diff --git a/drivers/gpu/drm/shmobile/shmob_drm_kms.c b/drivers/gpu/drm/shmobile/shmob_drm_kms.c
index 68d21be784aa..edb003537530 100644
--- a/drivers/gpu/drm/shmobile/shmob_drm_kms.c
+++ b/drivers/gpu/drm/shmobile/shmob_drm_kms.c
@@ -9,7 +9,6 @@
 
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
-#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 77f80b0d3a5e..973ae2dfb2f8 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -21,7 +21,6 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_edid.h>
-#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_format_helper.h>
 #include <drm/drm_framebuffer.h>
diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.c
index d858209cf8de..c0fbdb8cf6eb 100644
--- a/drivers/gpu/drm/sti/sti_drv.c
+++ b/drivers/gpu/drm/sti/sti_drv.c
@@ -14,7 +14,6 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_debugfs.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
diff --git a/drivers/gpu/drm/sti/sti_plane.c b/drivers/gpu/drm/sti/sti_plane.c
index c74b524663ab..0a55180be22b 100644
--- a/drivers/gpu/drm/sti/sti_plane.c
+++ b/drivers/gpu/drm/sti/sti_plane.c
@@ -9,7 +9,6 @@
 #include <linux/types.h>
 
 #include <drm/drm_blend.h>
-#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_cma_helper.h>
diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index c63945dc2260..bb269dad30f9 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -18,7 +18,6 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 6eb1aabdb161..382074ef1394 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -17,7 +17,6 @@
 #include <drm/drm_aperture.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_module.h>
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 4e9bd9cb6b36..b3d1c0940406 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -16,7 +16,6 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_probe_helper.h>
diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
index ad4ce9d06622..92d2c25bb0ff 100644
--- a/drivers/gpu/drm/tidss/tidss_crtc.c
+++ b/drivers/gpu/drm/tidss/tidss_crtc.c
@@ -8,7 +8,6 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
-#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_vblank.h>
 
diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/tidss_kms.c
index 666e527a0acf..b61db8f279e9 100644
--- a/drivers/gpu/drm/tidss/tidss_kms.c
+++ b/drivers/gpu/drm/tidss/tidss_kms.c
@@ -10,7 +10,6 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_crtc_helper.h>
-#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_of.h>
diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tidss/tidss_plane.c
index 68a85a94ffcb..42d50ec5526d 100644
--- a/drivers/gpu/drm/tidss/tidss_plane.c
+++ b/drivers/gpu/drm/tidss/tidss_plane.c
@@ -11,7 +11,6 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
-#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_atomic_helper.h>
 
 #include "tidss_crtc.h"
diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200/tve200_drv.c
index 6d9d2921abf4..86ebfe626cd0 100644
--- a/drivers/gpu/drm/tve200/tve200_drv.c
+++ b/drivers/gpu/drm/tve200/tve200_drv.c
@@ -39,7 +39,6 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index 8c7f910daa28..e8c975b81585 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -22,7 +22,6 @@
 #include <linux/reset.h>
 
 #include <drm/drm_drv.h>
-#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_managed.h>
 #include <uapi/drm/v3d_drm.h>
diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index 89975bdd607e..d33baf2667dd 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -33,7 +33,6 @@
 #include <drm/drm_aperture.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_vblank.h>
 
-- 
2.37.1

