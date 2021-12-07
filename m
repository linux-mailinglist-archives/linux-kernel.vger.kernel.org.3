Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AAF46B3ED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhLGHed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:34:33 -0500
Received: from marcansoft.com ([212.63.210.85]:35622 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230181AbhLGHeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:34:31 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 479C6423BD;
        Tue,  7 Dec 2021 07:30:57 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH v2 2/3] drm/format-helper: Add drm_fb_xrgb8888_to_xrgb2101010_toio()
Date:   Tue,  7 Dec 2021 16:29:42 +0900
Message-Id: <20211207072943.121961-3-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211207072943.121961-1-marcan@marcan.st>
References: <20211207072943.121961-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add XRGB8888 emulation support for devices that can only do XRGB2101010.

This is chiefly useful for simpledrm on Apple devices where the
bootloader-provided framebuffer is 10-bit.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/gpu/drm/drm_format_helper.c | 62 +++++++++++++++++++++++++++++
 include/drm/drm_format_helper.h     |  3 ++
 2 files changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index dbe3e830096e..edd611d3ab6a 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -409,6 +409,59 @@ void drm_fb_xrgb8888_to_rgb888_toio(void __iomem *dst, unsigned int dst_pitch,
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb888_toio);
 
+static void drm_fb_xrgb8888_to_xrgb2101010_line(u32 *dbuf, const u32 *sbuf,
+						unsigned int pixels)
+{
+	unsigned int x;
+
+	for (x = 0; x < pixels; x++) {
+		*dbuf++ = ((sbuf[x] & 0x000000FF) << 2) |
+			  ((sbuf[x] & 0x0000FF00) << 4) |
+			  ((sbuf[x] & 0x00FF0000) << 6);
+	}
+}
+
+/**
+ * drm_fb_xrgb8888_to_xrgb2101010_toio - Convert XRGB8888 to XRGB2101010 clip
+ * buffer
+ * @dst: XRGB2101010 destination buffer (iomem)
+ * @dst_pitch: Number of bytes between two consecutive scanlines within dst
+ * @vaddr: XRGB8888 source buffer
+ * @fb: DRM framebuffer
+ * @clip: Clip rectangle area to copy
+ *
+ * Drivers can use this function for XRGB2101010 devices that don't natively
+ * support XRGB8888.
+ */
+void drm_fb_xrgb8888_to_xrgb2101010_toio(void __iomem *dst,
+					 unsigned int dst_pitch, const void *vaddr,
+					 const struct drm_framebuffer *fb,
+					 const struct drm_rect *clip)
+{
+	size_t linepixels = clip->x2 - clip->x1;
+	size_t dst_len = linepixels * sizeof(u32);
+	unsigned y, lines = clip->y2 - clip->y1;
+	void *dbuf;
+
+	if (!dst_pitch)
+		dst_pitch = dst_len;
+
+	dbuf = kmalloc(dst_len, GFP_KERNEL);
+	if (!dbuf)
+		return;
+
+	vaddr += clip_offset(clip, fb->pitches[0], sizeof(u32));
+	for (y = 0; y < lines; y++) {
+		drm_fb_xrgb8888_to_xrgb2101010_line(dbuf, vaddr, linepixels);
+		memcpy_toio(dst, dbuf, dst_len);
+		vaddr += fb->pitches[0];
+		dst += dst_pitch;
+	}
+
+	kfree(dbuf);
+}
+EXPORT_SYMBOL(drm_fb_xrgb8888_to_xrgb2101010_toio);
+
 /**
  * drm_fb_xrgb8888_to_gray8 - Convert XRGB8888 to grayscale
  * @dst: 8-bit grayscale destination buffer
@@ -500,6 +553,10 @@ int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_for
 		fb_format = DRM_FORMAT_XRGB8888;
 	if (dst_format == DRM_FORMAT_ARGB8888)
 		dst_format = DRM_FORMAT_XRGB8888;
+	if (fb_format == DRM_FORMAT_ARGB2101010)
+		fb_format = DRM_FORMAT_XRGB2101010;
+	if (dst_format == DRM_FORMAT_ARGB2101010)
+		dst_format = DRM_FORMAT_XRGB2101010;
 
 	if (dst_format == fb_format) {
 		drm_fb_memcpy_toio(dst, dst_pitch, vmap, fb, clip);
@@ -515,6 +572,11 @@ int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_for
 			drm_fb_xrgb8888_to_rgb888_toio(dst, dst_pitch, vmap, fb, clip);
 			return 0;
 		}
+	} else if (dst_format == DRM_FORMAT_XRGB2101010) {
+		if (fb_format == DRM_FORMAT_XRGB8888) {
+			drm_fb_xrgb8888_to_xrgb2101010_toio(dst, dst_pitch, vmap, fb, clip);
+			return 0;
+		}
 	}
 
 	return -EINVAL;
diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index 97e4c3223af3..b30ed5de0a33 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -33,6 +33,9 @@ void drm_fb_xrgb8888_to_rgb888(void *dst, unsigned int dst_pitch, const void *sr
 void drm_fb_xrgb8888_to_rgb888_toio(void __iomem *dst, unsigned int dst_pitch,
 				    const void *vaddr, const struct drm_framebuffer *fb,
 				    const struct drm_rect *clip);
+void drm_fb_xrgb8888_to_xrgb2101010_toio(void __iomem *dst, unsigned int dst_pitch,
+					 const void *vaddr, const struct drm_framebuffer *fb,
+					 const struct drm_rect *clip);
 void drm_fb_xrgb8888_to_gray8(void *dst, unsigned int dst_pitch, const void *vaddr,
 			      const struct drm_framebuffer *fb, const struct drm_rect *clip);
 
-- 
2.33.0

