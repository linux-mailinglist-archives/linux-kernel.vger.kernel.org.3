Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70E14A4FF0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378365AbiAaUMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:12:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51165 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378218AbiAaUMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643659964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vM3bdlw6HomnmKXTkmUtit4bHCKLqTmZACNhurI9HbE=;
        b=Z7m3ToCS9OBeKNPTv3gFXAYf0Qsq6g7kTscJVhwR0Y0DRM4LgxzozkJHso2L5nDoii6Mmc
        LFYhTVXLxgBtb8Tf7ZE3LcQCbc22AfM+EjyZ84ChSIMCQFTfXMI8R29bUNooT0ufQ12+5d
        dFLgl106QL8cFqSMkfedcyz4z7i8eGY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-ar79gQwTNs-wkEWQsXSIoA-1; Mon, 31 Jan 2022 15:12:42 -0500
X-MC-Unique: ar79gQwTNs-wkEWQsXSIoA-1
Received: by mail-wm1-f70.google.com with SMTP id l16-20020a7bcf10000000b0034ffdd81e7aso83563wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:12:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vM3bdlw6HomnmKXTkmUtit4bHCKLqTmZACNhurI9HbE=;
        b=zn4fYaDmiio1XmiDGUHgAOFlWMW93B9DjFzGLh5WDZbNYanrgNJ8Zw9iBrkfpAVaix
         bX8XXv0fX4Oi//JLsETU8U3BhIJ2AZiEQ3sLpkIBpEa2pVZby1DlZfwoy0vKXMWdx1sb
         u7zHjDtkA4lOX7ff3ASAuoeJQR3ZyCkiSjpF0dS60pAqtufWfb59PAgImsy2RCHT4vjy
         bGUeZm/AdyEsQGFoX7zGeC+EL5bpOO3H2vw0C6afIOQefgnrcN3LH7dbYM34/Lx6Nldo
         y5YHGOTdMTPDgT0J8nV3fBzRhP17pnl6Li9UNnKfcJrhEWZExkyxCT9WPn0/1nf/Vuvc
         lghw==
X-Gm-Message-State: AOAM531B5mNBDwv7Rf5WfvhIR/tTAfkocJMZRdXilwGni+FPyXtGB2qK
        tXrA+fEuXYlZksUFCSlRERg3iz9Sb09smjTr7HFetbIr0uY6bqxQ368oAyc13vByYrGoK40mGg/
        GBePdcIzxHQnPjRdrOSB5ybYBUWBSZUgiyKbvpqhQ53VQJXSbvpAYqeyvKrEvuJjf0woFZMUH4t
        w=
X-Received: by 2002:adf:f784:: with SMTP id q4mr19229438wrp.59.1643659960727;
        Mon, 31 Jan 2022 12:12:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx3Q9aJyDDEzKcgl6ZRCOab6CbkULBPR+XNfldCqUZBAmgsUN/1rCzA6CjueKUxmVTW7C4q8w==
X-Received: by 2002:adf:f784:: with SMTP id q4mr19229412wrp.59.1643659960459;
        Mon, 31 Jan 2022 12:12:40 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i9sm15124660wry.32.2022.01.31.12.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 12:12:40 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/4] drm/format-helper: Add drm_fb_gray8_to_mono_reversed()
Date:   Mon, 31 Jan 2022 21:12:22 +0100
Message-Id: <20220131201225.2324984-3-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220131201225.2324984-1-javierm@redhat.com>
References: <20220131201225.2324984-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to convert 8-bit grayscale to reversed monochrome for drivers
that control monochromatic displays, that only have 1 bit per pixel depth.

This helper function was based on repaper_gray8_to_mono_reversed() from
the drivers/gpu/drm/tiny/repaper.c driver.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/drm_format_helper.c | 35 +++++++++++++++++++++++++++++
 include/drm/drm_format_helper.h     |  2 ++
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 0f28dd2bdd72..bf477c136082 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -584,3 +584,38 @@ int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_for
 	return -EINVAL;
 }
 EXPORT_SYMBOL(drm_fb_blit_toio);
+
+/**
+ * drm_fb_gray8_to_mono_reversed - Convert grayscale to reversed monochrome
+ * @dst: reversed monochrome destination buffer
+ * @src: 8-bit grayscale source buffer
+ * @clip: Clip rectangle area to copy
+ *
+ * DRM doesn't have native monochrome or grayscale support.
+ * Such drivers can announce the commonly supported XR24 format to userspace
+ * and use drm_fb_xrgb8888_to_gray8() to convert to grayscale and then this
+ * helper function to convert to the native format.
+ */
+void drm_fb_gray8_to_mono_reversed(void *dst, void *src, const struct drm_rect *clip)
+{
+	size_t width = drm_rect_width(clip);
+	size_t height = drm_rect_width(clip);
+
+	u8 *mono = dst, *gray8 = src;
+	unsigned int y, xb, i;
+
+	for (y = 0; y < height; y++)
+		for (xb = 0; xb < width / 8; xb++) {
+			u8 byte = 0x00;
+
+			for (i = 0; i < 8; i++) {
+				int x = xb * 8 + i;
+
+				byte >>= 1;
+				if (gray8[y * width + x] >> 7)
+					byte |= BIT(7);
+			}
+			*mono++ = byte;
+		}
+}
+EXPORT_SYMBOL(drm_fb_gray8_to_mono_reversed);
diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index b30ed5de0a33..cd4c8b7c78de 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -43,4 +43,6 @@ int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_for
 		     const void *vmap, const struct drm_framebuffer *fb,
 		     const struct drm_rect *rect);
 
+void drm_fb_gray8_to_mono_reversed(void *dst, void *vaddr, const struct drm_rect *clip);
+
 #endif /* __LINUX_DRM_FORMAT_HELPER_H */
-- 
2.34.1

