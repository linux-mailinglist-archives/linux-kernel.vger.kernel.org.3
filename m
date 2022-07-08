Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F2F56C0C3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239392AbiGHSWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 14:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239217AbiGHSVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 14:21:35 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0AD814BF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 11:21:32 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id siMT2700L4C55Sk01iMTgc; Fri, 08 Jul 2022 20:21:30 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o9sbX-002fJh-63; Fri, 08 Jul 2022 20:21:27 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o9sbW-00BtNd-OO; Fri, 08 Jul 2022 20:21:26 +0200
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
Subject: [PATCH 2/3] drm/format-helper: Fix endianness in drm_fb_*_to_*() conversion helpers
Date:   Fri,  8 Jul 2022 20:21:08 +0200
Message-Id: <33f390d3bae2c5a45c0050097dc95f2e17644f2f.1657300532.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657300532.git.geert@linux-m68k.org>
References: <cover.1657300532.git.geert@linux-m68k.org>
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

DRM formats are defined to be little-endian, unless the
DRM_FORMAT_BIG_ENDIAN flag is set.  Hence when converting from one
format to another, multi-byte pixel values loaded from memory must be
converted from little-endian to host-endian.  Conversely, multi-byte
pixel values written to memory must be converted from host-endian to
little-endian.  Currently only drm_fb_xrgb8888_to_rgb332_line() includes
endianness handling.

Fix this by adding endianness handling to all conversion functions that
process multi-byte pixel values.

Note that the conversion to RGB565 is special, as there are two
versions: with and without byteswapping of the RGB565 pixel data.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Tested with WIP atari_drm, which supports native big-endian RGB565.

Notes:
  - Most of these are used only by GUD or simpledrm (the latter through
    drm_fb_blit_toio()).
    Interestingly, drm_fb_xrgb8888_to_rgb332() was introduced for GUD,
    and always had correct endiannes handling...
  - drm_fb_xrgb8888_to_gray8() is also used by st7586.c.
---
 drivers/gpu/drm/drm_format_helper.c | 80 +++++++++++++++++------------
 1 file changed, 46 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index a3ccd8bc966fd816..c6182b5de78b0bd8 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -279,14 +279,16 @@ EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb332);
 static void drm_fb_xrgb8888_to_rgb565_line(void *dbuf, const void *sbuf, unsigned int pixels)
 {
 	u16 *dbuf16 = dbuf;
-	const u32 *sbuf32 = sbuf;
+	const __le32 *sbuf32 = sbuf;
 	unsigned int x;
 	u16 val16;
+	u32 pix;
 
 	for (x = 0; x < pixels; x++) {
-		val16 = ((sbuf32[x] & 0x00F80000) >> 8) |
-			((sbuf32[x] & 0x0000FC00) >> 5) |
-			((sbuf32[x] & 0x000000F8) >> 3);
+		pix = le32_to_cpu(sbuf32[x]);
+		val16 = ((pix & 0x00F80000) >> 8) |
+			((pix & 0x0000FC00) >> 5) |
+			((pix & 0x000000F8) >> 3);
 		dbuf16[x] = val16;
 	}
 }
@@ -295,14 +297,16 @@ static void drm_fb_xrgb8888_to_rgb565_swab_line(void *dbuf, const void *sbuf,
 						unsigned int pixels)
 {
 	u16 *dbuf16 = dbuf;
-	const u32 *sbuf32 = sbuf;
+	const __le32 *sbuf32 = sbuf;
 	unsigned int x;
 	u16 val16;
+	u32 pix;
 
 	for (x = 0; x < pixels; x++) {
-		val16 = ((sbuf32[x] & 0x00F80000) >> 8) |
-			((sbuf32[x] & 0x0000FC00) >> 5) |
-			((sbuf32[x] & 0x000000F8) >> 3);
+		pix = le32_to_cpu(sbuf32[x]);
+		val16 = ((pix & 0x00F80000) >> 8) |
+			((pix & 0x0000FC00) >> 5) |
+			((pix & 0x000000F8) >> 3);
 		dbuf16[x] = swab16(val16);
 	}
 }
@@ -360,13 +364,15 @@ EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565_toio);
 static void drm_fb_xrgb8888_to_rgb888_line(void *dbuf, const void *sbuf, unsigned int pixels)
 {
 	u8 *dbuf8 = dbuf;
-	const u32 *sbuf32 = sbuf;
+	const __le32 *sbuf32 = sbuf;
 	unsigned int x;
+	u32 pix;
 
 	for (x = 0; x < pixels; x++) {
-		*dbuf8++ = (sbuf32[x] & 0x000000FF) >>  0;
-		*dbuf8++ = (sbuf32[x] & 0x0000FF00) >>  8;
-		*dbuf8++ = (sbuf32[x] & 0x00FF0000) >> 16;
+		pix = le32_to_cpu(sbuf32[x]);
+		*dbuf8++ = (pix & 0x000000FF) >>  0;
+		*dbuf8++ = (pix & 0x0000FF00) >>  8;
+		*dbuf8++ = (pix & 0x00FF0000) >> 16;
 	}
 }
 
@@ -410,17 +416,19 @@ EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb888_toio);
 
 static void drm_fb_rgb565_to_xrgb8888_line(void *dbuf, const void *sbuf, unsigned int pixels)
 {
-	u32 *dbuf32 = dbuf;
-	const u16 *sbuf16 = sbuf;
+	__le32 *dbuf32 = dbuf;
+	const __le16 *sbuf16 = sbuf;
 	unsigned int x;
 
-	for (x = 0; x < pixels; x++, ++sbuf16, ++dbuf32) {
-		u32 val32 = ((*sbuf16 & 0xf800) << 8) |
-			    ((*sbuf16 & 0x07e0) << 5) |
-			    ((*sbuf16 & 0x001f) << 3);
-		*dbuf32 = 0xff000000 | val32 |
-			  ((val32 >> 3) & 0x00070007) |
-			  ((val32 >> 2) & 0x00000300);
+	for (x = 0; x < pixels; x++) {
+		u16 val16 = le16_to_cpu(sbuf16[x]);
+		u32 val32 = ((val16 & 0xf800) << 8) |
+			    ((val16 & 0x07e0) << 5) |
+			    ((val16 & 0x001f) << 3);
+		val32 = 0xff000000 | val32 |
+			((val32 >> 3) & 0x00070007) |
+			((val32 >> 2) & 0x00000300);
+		dbuf32[x] = cpu_to_le32(val32);
 	}
 }
 
@@ -434,7 +442,7 @@ static void drm_fb_rgb565_to_xrgb8888_toio(void __iomem *dst, unsigned int dst_p
 
 static void drm_fb_rgb888_to_xrgb8888_line(void *dbuf, const void *sbuf, unsigned int pixels)
 {
-	u32 *dbuf32 = dbuf;
+	__le32 *dbuf32 = dbuf;
 	const u8 *sbuf8 = sbuf;
 	unsigned int x;
 
@@ -442,7 +450,8 @@ static void drm_fb_rgb888_to_xrgb8888_line(void *dbuf, const void *sbuf, unsigne
 		u8 r = *sbuf8++;
 		u8 g = *sbuf8++;
 		u8 b = *sbuf8++;
-		*dbuf32++ = 0xff000000 | (r << 16) | (g << 8) | b;
+		u32 pix = 0xff000000 | (r << 16) | (g << 8) | b;
+		dbuf32[x] = cpu_to_le32(pix);
 	}
 }
 
@@ -456,16 +465,19 @@ static void drm_fb_rgb888_to_xrgb8888_toio(void __iomem *dst, unsigned int dst_p
 
 static void drm_fb_xrgb8888_to_xrgb2101010_line(void *dbuf, const void *sbuf, unsigned int pixels)
 {
-	u32 *dbuf32 = dbuf;
-	const u32 *sbuf32 = sbuf;
+	__le32 *dbuf32 = dbuf;
+	const __le32 *sbuf32 = sbuf;
 	unsigned int x;
 	u32 val32;
+	u32 pix;
 
 	for (x = 0; x < pixels; x++) {
-		val32 = ((sbuf32[x] & 0x000000FF) << 2) |
-			((sbuf32[x] & 0x0000FF00) << 4) |
-			((sbuf32[x] & 0x00FF0000) << 6);
-		*dbuf32++ = val32 | ((val32 >> 8) & 0x00300C03);
+		pix = le32_to_cpu(sbuf32[x]);
+		val32 = ((pix & 0x000000FF) << 2) |
+			((pix & 0x0000FF00) << 4) |
+			((pix & 0x00FF0000) << 6);
+		pix = val32 | ((val32 >> 8) & 0x00300C03);
+		*dbuf32++ = cpu_to_le32(pix);
 	}
 }
 
@@ -494,17 +506,17 @@ EXPORT_SYMBOL(drm_fb_xrgb8888_to_xrgb2101010_toio);
 static void drm_fb_xrgb8888_to_gray8_line(void *dbuf, const void *sbuf, unsigned int pixels)
 {
 	u8 *dbuf8 = dbuf;
-	const u32 *sbuf32 = sbuf;
+	const __le32 *sbuf32 = sbuf;
 	unsigned int x;
 
 	for (x = 0; x < pixels; x++) {
-		u8 r = (*sbuf32 & 0x00ff0000) >> 16;
-		u8 g = (*sbuf32 & 0x0000ff00) >> 8;
-		u8 b =  *sbuf32 & 0x000000ff;
+		u32 pix = le32_to_cpu(sbuf32[x]);
+		u8 r = (pix & 0x00ff0000) >> 16;
+		u8 g = (pix & 0x0000ff00) >> 8;
+		u8 b =  pix & 0x000000ff;
 
 		/* ITU BT.601: Y = 0.299 R + 0.587 G + 0.114 B */
 		*dbuf8++ = (3 * r + 6 * g + b) / 10;
-		sbuf32++;
 	}
 }
 
-- 
2.25.1

