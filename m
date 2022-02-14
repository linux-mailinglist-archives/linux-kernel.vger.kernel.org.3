Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2544B51D1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354358AbiBNNh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:37:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354314AbiBNNhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:37:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67A604EA20
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644845858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=antMq+QI2lYY33VgrrVvP1GCy1SqAtBXkL1zJR3K1Rc=;
        b=fxZhsxs5RFidQI17rl3Iy9C7KHNkTdKzrQLTUm1ecq+jpU4ThklB6oomyvQqKnUcQltCie
        sGsWojmmFMoJ3MqdOeHyqdhylug/xTEFaWwUy68PXjvHB1yy5Zqk694TUABxGqDR1EeoK3
        PsWmY0hPIiaujc6FW4bT9BYxvUFk9dI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-BOeLGgpEODGQeO0J6flHug-1; Mon, 14 Feb 2022 08:37:37 -0500
X-MC-Unique: BOeLGgpEODGQeO0J6flHug-1
Received: by mail-wm1-f69.google.com with SMTP id f7-20020a1cc907000000b0034b63f314ccso5011835wmb.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:37:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=antMq+QI2lYY33VgrrVvP1GCy1SqAtBXkL1zJR3K1Rc=;
        b=eKaJSvksqnc1vceVNAR8Tz15OvmT+mOeAzhqHnH6xDzHp3uwBC+tQfcLFIpJp1W777
         UjT/cetCMd+nsr1AoW5FL7/F9hSVNM/KmzUgAk6P+PE6jnFyUQvdAKKsbqJpFhGCSZbO
         TUHQUF5x/Vwqj9BIuBTLkrVepG6g9R59TBAPVF3SpMBQ4TDbFQ2uHdOHBMBEzXszn2Q4
         e+l6wcKFsfvkxdh4fL6ODl6frP+jc7I6+17WONU4E5mrjVCNPcU0hQpZxeQNzHevK8B/
         bJNsna7tbVfnl43j13qnFlXnhMD9S0Ybigxj0CTmz4LqwgERB/AZZf5+8epDrVlfO0Io
         UieA==
X-Gm-Message-State: AOAM531U+YHDZUFdgldRTu/65ZARSbODB9CXs5vMO9xZrv+SsYCwVEGF
        9A7euQ9Fsdoh0P6QVGZmfdB8wrSzdTW1d2datUzf9vP7etxRXHLID8XkISxIpPjnvsJzhRiJ4N4
        L5E++//iMfhwZnuLy7Iw/I3KhJLl48RXbEC7o7bmCl5su0nmICh3UzDPOugsqmndiSEx6K3poSS
        s=
X-Received: by 2002:a05:600c:1990:: with SMTP id t16mr3040420wmq.66.1644845855761;
        Mon, 14 Feb 2022 05:37:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwquD1QmlltNMuQ3Y9bdmIMSpLDEUSrCUnMUaYlENoLOViQWZy53+PifJ2LVGmTJ3Aay+RwzA==
X-Received: by 2002:a05:600c:1990:: with SMTP id t16mr3040384wmq.66.1644845855416;
        Mon, 14 Feb 2022 05:37:35 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y6sm3568918wrd.30.2022.02.14.05.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 05:37:35 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v6 2/6] drm/format-helper: Add drm_fb_xrgb8888_to_mono_reversed()
Date:   Mon, 14 Feb 2022 14:37:06 +0100
Message-Id: <20220214133710.3278506-3-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214133710.3278506-1-javierm@redhat.com>
References: <20220214133710.3278506-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to convert from XR24 to reversed monochrome for drivers that
control monochromatic display panels, that only have 1 bit per pixel.

The function does a line-by-line conversion doing an intermediate step
first from XR24 to 8-bit grayscale and then to reversed monochrome.

The drm_fb_gray8_to_mono_reversed_line() helper was based on code from
drivers/gpu/drm/tiny/repaper.c driver.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Changes in v6:
- Add Andy Shevchenko's Reviewed-by to patch #2.

Changes in v5:
- Use drm_WARN_ON* macros instead of deprecated ones (Thomas Zimmermann)

Changes in v4:
- Rename end_offset to end_len (Thomas Zimmermann)
- Warn once if dst_pitch is not a multiple of 8 (Thomas Zimmermann)
- Drop drm_fb_gray8_to_mono_reversed() that's not used (Thomas Zimmermann)
- Allocate single buffer for both copy cma memory and gray8 (Thomas Zimmermann)
- Add Thomas Zimmermann Reviewed-by tag to patch adding XR24 -> mono helper.

Changes in v3:
- Also add a drm_fb_xrgb8888_to_mono_reversed() helper (Thomas Zimmermann)
- Split lines copy to drm_fb_gray8_to_mono_reversed_line() (Thomas Zimmermann)
- Handle case where the source buffer is not aligned to 8 (Thomas Zimmermann)

 drivers/gpu/drm/drm_format_helper.c | 110 ++++++++++++++++++++++++++++
 include/drm/drm_format_helper.h     |   4 +
 2 files changed, 114 insertions(+)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index b981712623d3..bc0f49773868 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -12,9 +12,11 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 
+#include <drm/drm_device.h>
 #include <drm/drm_format_helper.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_fourcc.h>
+#include <drm/drm_print.h>
 #include <drm/drm_rect.h>
 
 static unsigned int clip_offset(const struct drm_rect *clip, unsigned int pitch, unsigned int cpp)
@@ -591,3 +593,111 @@ int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_for
 	return -EINVAL;
 }
 EXPORT_SYMBOL(drm_fb_blit_toio);
+
+static void drm_fb_gray8_to_mono_reversed_line(u8 *dst, const u8 *src, unsigned int pixels,
+					       unsigned int start_offset, unsigned int end_len)
+{
+	unsigned int xb, i;
+
+	for (xb = 0; xb < pixels; xb++) {
+		unsigned int start = 0, end = 8;
+		u8 byte = 0x00;
+
+		if (xb == 0 && start_offset)
+			start = start_offset;
+
+		if (xb == pixels - 1 && end_len)
+			end = end_len;
+
+		for (i = start; i < end; i++) {
+			unsigned int x = xb * 8 + i;
+
+			byte >>= 1;
+			if (src[x] >> 7)
+				byte |= BIT(7);
+		}
+		*dst++ = byte;
+	}
+}
+
+/**
+ * drm_fb_xrgb8888_to_mono_reversed - Convert XRGB8888 to reversed monochrome
+ * @dst: reversed monochrome destination buffer
+ * @dst_pitch: Number of bytes between two consecutive scanlines within dst
+ * @src: XRGB8888 source buffer
+ * @fb: DRM framebuffer
+ * @clip: Clip rectangle area to copy
+ *
+ * DRM doesn't have native monochrome support.
+ * Such drivers can announce the commonly supported XR24 format to userspace
+ * and use this function to convert to the native format.
+ *
+ * This function uses drm_fb_xrgb8888_to_gray8() to convert to grayscale and
+ * then the result is converted from grayscale to reversed monohrome.
+ */
+void drm_fb_xrgb8888_to_mono_reversed(void *dst, unsigned int dst_pitch, const void *vaddr,
+				      const struct drm_framebuffer *fb, const struct drm_rect *clip)
+{
+	unsigned int linepixels = drm_rect_width(clip);
+	unsigned int lines = clip->y2 - clip->y1;
+	unsigned int cpp = fb->format->cpp[0];
+	unsigned int len_src32 = linepixels * cpp;
+	struct drm_device *dev = fb->dev;
+	unsigned int start_offset, end_len;
+	unsigned int y;
+	u8 *mono = dst, *gray8;
+	u32 *src32;
+
+	if (drm_WARN_ON(dev, fb->format->format != DRM_FORMAT_XRGB8888))
+		return;
+
+	/*
+	 * The reversed mono destination buffer contains 1 bit per pixel
+	 * and destination scanlines have to be in multiple of 8 pixels.
+	 */
+	if (!dst_pitch)
+		dst_pitch = DIV_ROUND_UP(linepixels, 8);
+
+	drm_WARN_ONCE(dev, dst_pitch % 8 != 0, "dst_pitch is not a multiple of 8\n");
+
+	/*
+	 * The cma memory is write-combined so reads are uncached.
+	 * Speed up by fetching one line at a time.
+	 *
+	 * Also, format conversion from XR24 to reversed monochrome
+	 * are done line-by-line but are converted to 8-bit grayscale
+	 * as an intermediate step.
+	 *
+	 * Allocate a buffer to be used for both copying from the cma
+	 * memory and to store the intermediate grayscale line pixels.
+	 */
+	src32 = kmalloc(len_src32 + linepixels, GFP_KERNEL);
+	if (!src32)
+		return;
+
+	gray8 = (u8 *)src32 + len_src32;
+
+	/*
+	 * For damage handling, it is possible that only parts of the source
+	 * buffer is copied and this could lead to start and end pixels that
+	 * are not aligned to multiple of 8.
+	 *
+	 * Calculate if the start and end pixels are not aligned and set the
+	 * offsets for the reversed mono line conversion function to adjust.
+	 */
+	start_offset = clip->x1 % 8;
+	end_len = clip->x2 % 8;
+
+	vaddr += clip_offset(clip, fb->pitches[0], cpp);
+	for (y = 0; y < lines; y++) {
+		src32 = memcpy(src32, vaddr, len_src32);
+		drm_fb_xrgb8888_to_gray8_line(gray8, src32, linepixels);
+		drm_fb_gray8_to_mono_reversed_line(mono, gray8, dst_pitch,
+						   start_offset, end_len);
+		vaddr += fb->pitches[0];
+		mono += dst_pitch;
+	}
+
+	kfree(src32);
+}
+EXPORT_SYMBOL(drm_fb_xrgb8888_to_mono_reversed);
diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index b30ed5de0a33..0b0937c0b2f6 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -43,4 +43,8 @@ int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_for
 		     const void *vmap, const struct drm_framebuffer *fb,
 		     const struct drm_rect *rect);
 
+void drm_fb_xrgb8888_to_mono_reversed(void *dst, unsigned int dst_pitch, const void *src,
+				      const struct drm_framebuffer *fb,
+				      const struct drm_rect *clip);
+
 #endif /* __LINUX_DRM_FORMAT_HELPER_H */
-- 
2.34.1

