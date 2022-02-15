Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3781E4B78DE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241926AbiBOQwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:52:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241879AbiBOQwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:52:45 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A36D9D4DB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:52:33 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:7534:e0be:5adf:2691])
        by laurent.telenet-ops.be with bizsmtp
        id vUsV2600U18GbK101UsV5Z; Tue, 15 Feb 2022 17:52:31 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nK141-000tUp-3Z; Tue, 15 Feb 2022 17:52:29 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nK140-00BUS0-2E; Tue, 15 Feb 2022 17:52:28 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 6/8] drm/gem-fb-helper: Use actual bpp for size calculations
Date:   Tue, 15 Feb 2022 17:52:24 +0100
Message-Id: <20220215165226.2738568-7-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220215165226.2738568-1-geert@linux-m68k.org>
References: <20220215165226.2738568-1-geert@linux-m68k.org>
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
---
Untested.

After adding the missing block info, probably the whole function can
just be dropped, in favor of drm_format_info_bpp()?
---
 drivers/gpu/drm/drm_gem_framebuffer_helper.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_framebuffer_helper.c b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
index 746fd8c738451247..7eca09fce095abbe 100644
--- a/drivers/gpu/drm/drm_gem_framebuffer_helper.c
+++ b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
@@ -499,11 +499,8 @@ static __u32 drm_gem_afbc_get_bpp(struct drm_device *dev,
 
 	info = drm_get_format_info(dev, mode_cmd);
 
-	/* use whatever a driver has set */
-	if (info->cpp[0])
-		return info->cpp[0] * 8;
-
-	/* guess otherwise */
+	// FIXME DRM_FORMAT_* should provide proper block info in
+	// FIXME drivers/gpu/drm/drm_fourcc.c
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

