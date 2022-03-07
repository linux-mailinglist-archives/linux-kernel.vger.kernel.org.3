Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BD84D08D6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245375AbiCGUyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245385AbiCGUyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:54:09 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408822459A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 12:53:13 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:6100:2d37:4115:c358])
        by andre.telenet-ops.be with bizsmtp
        id 3Yt92700L1Yj8bA01Yt9xl; Mon, 07 Mar 2022 21:53:12 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nRKLY-0036Qj-JD; Mon, 07 Mar 2022 21:52:48 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nRKLY-0034hv-1V; Mon, 07 Mar 2022 21:52:48 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 RFC 07/10] drm/gem-fb-helper: Use actual bpp for size calculations
Date:   Mon,  7 Mar 2022 21:52:42 +0100
Message-Id: <842ab0a286ff743b625277e655d9bef505b630c1.1646683502.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1646683502.git.geert@linux-m68k.org>
References: <cover.1646683502.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AFBC helpers derive the number of bits per pixel from the deprecated
drm_format_info.cpp[] field, which does not take into account block
sizes.

Fix this by using the actual number of bits per pixel instead.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
RFC, as this code path was untested.

v2:
  - Replace FIXME by TODO comment.
---
 drivers/gpu/drm/drm_gem_framebuffer_helper.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_framebuffer_helper.c b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
index 746fd8c738451247..e5b8443378d2294b 100644
--- a/drivers/gpu/drm/drm_gem_framebuffer_helper.c
+++ b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
@@ -492,6 +492,8 @@ void drm_gem_fb_end_cpu_access(struct drm_framebuffer *fb, enum dma_data_directi
 }
 EXPORT_SYMBOL(drm_gem_fb_end_cpu_access);
 
+// TODO Drop this function and replace by drm_format_info_bpp() once all
+// DRM_FORMAT_* provide proper block info in drivers/gpu/drm/drm_fourcc.c
 static __u32 drm_gem_afbc_get_bpp(struct drm_device *dev,
 				  const struct drm_mode_fb_cmd2 *mode_cmd)
 {
@@ -499,11 +501,6 @@ static __u32 drm_gem_afbc_get_bpp(struct drm_device *dev,
 
 	info = drm_get_format_info(dev, mode_cmd);
 
-	/* use whatever a driver has set */
-	if (info->cpp[0])
-		return info->cpp[0] * 8;
-
-	/* guess otherwise */
 	switch (info->format) {
 	case DRM_FORMAT_YUV420_8BIT:
 		return 12;
@@ -512,11 +509,8 @@ static __u32 drm_gem_afbc_get_bpp(struct drm_device *dev,
 	case DRM_FORMAT_VUY101010:
 		return 30;
 	default:
-		break;
+		return drm_format_info_bpp(info, 0);
 	}
-
-	/* all attempts failed */
-	return 0;
 }
 
 static int drm_gem_afbc_min_size(struct drm_device *dev,
-- 
2.25.1

