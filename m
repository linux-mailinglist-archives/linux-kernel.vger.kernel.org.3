Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054FD4B2183
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348460AbiBKJTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:19:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348444AbiBKJTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:19:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71A4E337
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644571179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WfmTkAo8MbPeTvx/t6/qV64gOBcJ/r5gHdJT18TRKbc=;
        b=J2ijK2ZoaFlDPHBR6+6xlY759dBKPyWAwSU+3m+slcJvkV6QaZWOwzxMbpF0RzynVQNbjk
        m9scz3jRq+94C4S5zoKKS3/q1mlSRTT+1PWSc02DBHoUAv9cx5ee5g7sX6ga3iBEc6odwB
        cynqo1jpL9dpLB617qSwSDZM2Vca3Zs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-xS8PV7yMOqKbB3AQ24MPlQ-1; Fri, 11 Feb 2022 04:19:38 -0500
X-MC-Unique: xS8PV7yMOqKbB3AQ24MPlQ-1
Received: by mail-wr1-f69.google.com with SMTP id g17-20020adfa591000000b001da86c91c22so3642236wrc.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:19:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WfmTkAo8MbPeTvx/t6/qV64gOBcJ/r5gHdJT18TRKbc=;
        b=oRfuWLt9wkNegRBZNRmA1FhYD8KU19kzm125uIQIHgC04GXcK0n6MG91GuLJ/KFilP
         saoTeQDzkONCLmKcY8mopVeP0WYYLPB1+Wl5aXTTC3XZSzU8mjR3OMYygNNwqKwuUoKr
         we7QywYCbW48NnbZw3k0Qr1EtvdnPsUVjuzWsd22HbezEIPIIK3ZLStkZNoc3Hn8vzaf
         nHanLL59+iwKEOfqx4b0qbMhLbJwfSLrO/iE52TTMEA5adkd+wNaX0anO15NPPFOGv8e
         O2V2UFWFSEyne65ccuhG2rowNe3xK3RUko1KmQm1TbFtIjakat140bJhPUddIUyoqObO
         WJ7w==
X-Gm-Message-State: AOAM531gLwSy+bjRYCK85f9TyJn2YPy6zlKZyPFyWLzOGl0zt2+Gvli0
        2cXcr8E68ZzL08Hodx2ir4dZCmCN0drtiTGBS+Ja5Op1TKhc3SZqLGpbr/P32zO50EieUwFl6cE
        iploT1PF491G02Ue3OGxfLocvAQhAXdz1lzCW0lRrM7+gFr7O1kRHpluGjyHUdbPWw7dDkzPxt3
        o=
X-Received: by 2002:a05:600c:3514:: with SMTP id h20mr1321472wmq.164.1644571177393;
        Fri, 11 Feb 2022 01:19:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpzAJ0rd4SzIQHbw8fvUDCZMIVgg7JkfatOvaBwjk1xAO33C05HSaBy6MnqF2Asz4c1X6vpw==
X-Received: by 2002:a05:600c:3514:: with SMTP id h20mr1321436wmq.164.1644571177101;
        Fri, 11 Feb 2022 01:19:37 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r17sm3805578wmq.33.2022.02.11.01.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 01:19:36 -0800 (PST)
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
Subject: [PATCH v4 1/6] drm/format-helper: Add drm_fb_xrgb8888_to_gray8_line()
Date:   Fri, 11 Feb 2022 10:19:22 +0100
Message-Id: <20220211091927.2988283-2-javierm@redhat.com>
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

Pull the per-line conversion logic into a separate helper function.

This will allow to do line-by-line conversion in other helpers that
convert to a gray8 format.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v3)

Changes in v3:
- Add a drm_fb_xrgb8888_to_gray8_line() helper function (Thomas Zimmermann)

 drivers/gpu/drm/drm_format_helper.c | 31 ++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 0f28dd2bdd72..b981712623d3 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -464,6 +464,21 @@ void drm_fb_xrgb8888_to_xrgb2101010_toio(void __iomem *dst,
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_xrgb2101010_toio);
 
+static void drm_fb_xrgb8888_to_gray8_line(u8 *dst, const u32 *src, unsigned int pixels)
+{
+	unsigned int x;
+
+	for (x = 0; x < pixels; x++) {
+		u8 r = (*src & 0x00ff0000) >> 16;
+		u8 g = (*src & 0x0000ff00) >> 8;
+		u8 b =  *src & 0x000000ff;
+
+		/* ITU BT.601: Y = 0.299 R + 0.587 G + 0.114 B */
+		*dst++ = (3 * r + 6 * g + b) / 10;
+		src++;
+	}
+}
+
 /**
  * drm_fb_xrgb8888_to_gray8 - Convert XRGB8888 to grayscale
  * @dst: 8-bit grayscale destination buffer
@@ -484,8 +499,9 @@ EXPORT_SYMBOL(drm_fb_xrgb8888_to_xrgb2101010_toio);
 void drm_fb_xrgb8888_to_gray8(void *dst, unsigned int dst_pitch, const void *vaddr,
 			      const struct drm_framebuffer *fb, const struct drm_rect *clip)
 {
-	unsigned int len = (clip->x2 - clip->x1) * sizeof(u32);
-	unsigned int x, y;
+	unsigned int linepixels = clip->x2 - clip->x1;
+	unsigned int len = linepixels * sizeof(u32);
+	unsigned int y;
 	void *buf;
 	u8 *dst8;
 	u32 *src32;
@@ -508,16 +524,7 @@ void drm_fb_xrgb8888_to_gray8(void *dst, unsigned int dst_pitch, const void *vad
 	for (y = clip->y1; y < clip->y2; y++) {
 		dst8 = dst;
 		src32 = memcpy(buf, vaddr, len);
-		for (x = clip->x1; x < clip->x2; x++) {
-			u8 r = (*src32 & 0x00ff0000) >> 16;
-			u8 g = (*src32 & 0x0000ff00) >> 8;
-			u8 b =  *src32 & 0x000000ff;
-
-			/* ITU BT.601: Y = 0.299 R + 0.587 G + 0.114 B */
-			*dst8++ = (3 * r + 6 * g + b) / 10;
-			src32++;
-		}
-
+		drm_fb_xrgb8888_to_gray8_line(dst8, src32, linepixels);
 		vaddr += fb->pitches[0];
 		dst += dst_pitch;
 	}
-- 
2.34.1

