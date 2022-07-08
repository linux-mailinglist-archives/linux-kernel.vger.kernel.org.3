Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE7B56BF6D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239384AbiGHSWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 14:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239204AbiGHSVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 14:21:33 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21FB82384
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 11:21:31 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id siMU270034C55Sk01iMU6D; Fri, 08 Jul 2022 20:21:30 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o9sbX-002fJi-GN; Fri, 08 Jul 2022 20:21:27 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o9sbW-00BtNk-QD; Fri, 08 Jul 2022 20:21:26 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/3] drm/gud: Fix endianness in gud_xrgb8888_to_color() helper
Date:   Fri,  8 Jul 2022 20:21:09 +0200
Message-Id: <b47589ed5d8ca44e0956684412e3f16f3227f887.1657300532.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657300532.git.geert@linux-m68k.org>
References: <cover.1657300532.git.geert@linux-m68k.org>
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

DRM formats are defined to be little-endian, unless the
DRM_FORMAT_BIG_ENDIAN flag is set.  Hence when converting from one
format to another, multi-byte pixel values loaded from memory must be
converted from little-endian to host-endian.  Conversely, multi-byte
pixel values written to memory must be converted from host-endian to
little-endian.  Currently only drm_fb_xrgb8888_to_rgb332_line() includes
endianness handling.

Fix gud_xrgb8888_to_color() on big-endian platforms by adding the
missing endianness handling.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Compile-tested only.

Interestingly, drm_fb_xrgb8888_to_rgb332() was introduced for GUD,
and always had correct endiannes handling...
---
 drivers/gpu/drm/gud/gud_pipe.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index 4873f9799f412e04..d42592f6daab8b2a 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -105,7 +105,8 @@ static size_t gud_xrgb8888_to_color(u8 *dst, const struct drm_format_info *forma
 	unsigned int bits_per_pixel = 8 / block_width;
 	u8 r, g, b, pix, *block = dst; /* Assign to silence compiler warning */
 	unsigned int x, y, width;
-	u32 *pix32;
+	__le32 *sbuf32;
+	u32 pix32;
 	size_t len;
 
 	/* Start on a byte boundary */
@@ -114,8 +115,8 @@ static size_t gud_xrgb8888_to_color(u8 *dst, const struct drm_format_info *forma
 	len = drm_format_info_min_pitch(format, 0, width) * drm_rect_height(rect);
 
 	for (y = rect->y1; y < rect->y2; y++) {
-		pix32 = src + (y * fb->pitches[0]);
-		pix32 += rect->x1;
+		sbuf32 = src + (y * fb->pitches[0]);
+		sbuf32 += rect->x1;
 
 		for (x = 0; x < width; x++) {
 			unsigned int pixpos = x % block_width; /* within byte from the left */
@@ -126,9 +127,10 @@ static size_t gud_xrgb8888_to_color(u8 *dst, const struct drm_format_info *forma
 				*block = 0;
 			}
 
-			r = *pix32 >> 16;
-			g = *pix32 >> 8;
-			b = *pix32++;
+			pix32 = le32_to_cpu(*sbuf32++);
+			r = pix32 >> 16;
+			g = pix32 >> 8;
+			b = pix32;
 
 			switch (format->format) {
 			case GUD_DRM_FORMAT_XRGB1111:
-- 
2.25.1

