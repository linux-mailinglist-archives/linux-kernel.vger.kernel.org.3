Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BF556C060
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239235AbiGHSVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 14:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239134AbiGHSVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 14:21:16 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210F88239C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 11:21:10 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by laurent.telenet-ops.be with bizsmtp
        id siM72700B4C55Sk01iM7mp; Fri, 08 Jul 2022 20:21:08 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o9sbC-002fGf-QL; Fri, 08 Jul 2022 20:21:06 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o9sbC-00BtJU-Ca; Fri, 08 Jul 2022 20:21:06 +0200
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
Subject: [PATCH v3 04/10] drm/framebuffer: Use actual bpp for DRM_IOCTL_MODE_GETFB
Date:   Fri,  8 Jul 2022 20:20:49 +0200
Message-Id: <b612780feef200b7f914a674db28ed227e7cdc64.1657294931.git.geert@linux-m68k.org>
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

When userspace queries the properties of a frame buffer, the number of
bits per pixel is derived from the deprecated drm_format_info.cpp[]
field, which does not take into account block sizes.

Fix this by using the actual number of bits per pixel instead.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
v3:
  - Add Reviewed-by,

v2:
  - No changes.
---
 drivers/gpu/drm/drm_framebuffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index 4562a8b865792456..9899bf1485b299ad 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -530,7 +530,7 @@ int drm_mode_getfb(struct drm_device *dev,
 	r->height = fb->height;
 	r->width = fb->width;
 	r->depth = fb->format->depth;
-	r->bpp = fb->format->cpp[0] * 8;
+	r->bpp = drm_format_info_bpp(fb->format, 0);
 	r->pitch = fb->pitches[0];
 
 	/* GET_FB() is an unprivileged ioctl so we must not return a
-- 
2.25.1

