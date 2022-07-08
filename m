Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F54E56BFA3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239206AbiGHSVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 14:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239113AbiGHSVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 14:21:15 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3CA8238D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 11:21:10 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by michel.telenet-ops.be with bizsmtp
        id siM72700H4C55Sk06iM7fj; Fri, 08 Jul 2022 20:21:08 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o9sbC-002fGo-U2; Fri, 08 Jul 2022 20:21:06 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o9sbC-00BtJo-H9; Fri, 08 Jul 2022 20:21:06 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v3 07/10] drm/gem-fb-helper: Use actual bpp for size calculations
Date:   Fri,  8 Jul 2022 20:20:52 +0200
Message-Id: <b1d938d903157627c4ac101df92a1f3bf8ebe83d.1657294931.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657294931.git.geert@linux-m68k.org>
References: <cover.1657294931.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
Compile-tested only.

v3:
  - Add Reviewed-by,

v2:
  - Replace FIXME by TODO comment.
---
 drivers/gpu/drm/drm_gem_framebuffer_helper.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_framebuffer_helper.c b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
index f4619803acd01e96..6b680ca8c0cfd8d7 100644
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

