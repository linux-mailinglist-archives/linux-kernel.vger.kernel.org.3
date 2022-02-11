Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641154B217D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348472AbiBKJTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:19:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348447AbiBKJTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:19:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7186A102D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644571182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x1udgbXGjlzK5bJeoxJIvncbREHU61CgMBl3Cu8KdUg=;
        b=ISL0udd1xVsUzJN8VfYUgcd4Kxx3nsYKlWNPRZ4AcPg248KQDHvn7sGba9ZnQElEbm5wXP
        A52iAaOdVtSWP15cg29j6poaAkKnhOisM+jwMw6N0HD51929mgzhgj5hg1D+3ZqPoj++aB
        P+WCpfxQAJtDF1xTKSw3N2+uUD3J5BQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-KaH7k1UNOgq7Au2jroXiLA-1; Fri, 11 Feb 2022 04:19:41 -0500
X-MC-Unique: KaH7k1UNOgq7Au2jroXiLA-1
Received: by mail-wm1-f70.google.com with SMTP id 125-20020a1c0283000000b0037bf720e6a8so3258517wmc.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:19:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x1udgbXGjlzK5bJeoxJIvncbREHU61CgMBl3Cu8KdUg=;
        b=3ZmA0WqStzM0F27vL7+E6GZTL1F0Rwxls0Y7gmPAISndsIlxUPLMJ768oDPvrrbC0/
         ueRkn0Dmh56mGUgg3nkbf4GtbpHLhhkihLOFVL76BCwAgiUCYWuL0g1o3KI9AZwV/Jp5
         uxKGbpCti7xCh5887dqqMbd3Jgb6p86D9qmBGya+6XmXfE8Q+/XqRJqcprF0Fi7k/WGq
         ODSK0AUNGNOC75K3YeTa1Zgn8UDjJBFikO1n2d+R3L0PvGJn0ZmMzQfIOEDACGiGYGFj
         fxfZTqHQiPXUklVkWbzJWRPTa2mRtKJJm/OCPF/ksjFl7pfN+3ad5y1rqPUUNtn54eic
         837g==
X-Gm-Message-State: AOAM531jKzQPwaRmi4IrLqHH3TgdxNxH0a/dyQaXSksn5MZXxpePe6xF
        p1VYMlCSt/xB0jHY6YRXAFhdFBbdAkkaN8YWxetnSacNREWqpI7PlbyfmaA4dWHlAZnwGkB0ACb
        Xed9jEaRcefiA4qJumaKQULUAvq9UaoZvGfEAxjxkBi5ZlpzvLntS9BqwkttzlgWvLd3cTw/aZo
        c=
X-Received: by 2002:a05:6000:1c16:: with SMTP id ba22mr482670wrb.470.1644571180259;
        Fri, 11 Feb 2022 01:19:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9uib9P8LoPw1Bn/AO7SmVcttDX0uIDFWIelsN6+GhZGFYX4rt6mkX1967jjm3xIdkICD8Cw==
X-Received: by 2002:a05:6000:1c16:: with SMTP id ba22mr482637wrb.470.1644571179939;
        Fri, 11 Feb 2022 01:19:39 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r17sm3805578wmq.33.2022.02.11.01.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 01:19:39 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v4 2/6] drm/format-helper: Add drm_fb_xrgb8888_to_mono_reversed()
Date:   Fri, 11 Feb 2022 10:19:23 +0100
Message-Id: <20220211091927.2988283-3-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211091927.2988283-1-javierm@redhat.com>
References: <20220211091927.2988283-1-javierm@redhat.com>
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

Add support to convert from XR24 to reversed monochrome for drivers that
control monochromatic display panels, that only have 1 bit per pixel.

The function does a line-by-line conversion doing an intermediate step
first from XR24 to 8-bit grayscale and then to reversed monochrome.

The drm_fb_gray8_to_mono_reversed_line() helper was based on code from
drivers/gpu/drm/tiny/repaper.c driver.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---

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

 drivers/gpu/drm/drm_format_helper.c | 107 ++++++++++++++++++++++++++++
 include/drm/drm_format_helper.h     |   4 ++
 2 files changed, 111 insertions(+)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index b981712623d3..ec4e3724ee79 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -591,3 +591,110 @@ int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_for
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
+	unsigned int start_offset, end_len;
+	unsigned int y;
+	u8 *mono = dst, *gray8;
+	u32 *src32;
+
+	if (WARN_ON(fb->format->format != DRM_FORMAT_XRGB8888))
+		return;
+
+	/*
+	 * The reversed mono destination buffer contains 1 bit per pixel
+	 * and destination scanlines have to be in multiple of 8 pixels.
+	 */
+	if (!dst_pitch)
+		dst_pitch = DIV_ROUND_UP(linepixels, 8);
+
+	WARN_ONCE(dst_pitch % 8 != 0, "dst_pitch is not a multiple of 8\n");
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

