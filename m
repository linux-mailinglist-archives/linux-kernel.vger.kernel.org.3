Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB624AEE25
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbiBIJjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:39:04 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiBIJgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:36:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 867E2E015277
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 01:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644399301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X6Mi9ajTPAaH4GRgHowugsZMJXzFkvUakKFgNQa4uWk=;
        b=UzYHMU5DNyQRp6CriqcGL3xuPiPxHELVczzlIxkoQLLLMqIOO3ZPoH5oNZARa546kR4Q/O
        5bbTNZP84rDXEIZKHdw6833wqBo2mpek+BNTpwb0J2CX17GxA7jvzeI3Z/suAp9u9QdzbZ
        80IcQ+5wKOd6o4JvxW0o+s4YYAp8Xeg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-4xWy6QLdP1K6uCtLj9N9zA-1; Wed, 09 Feb 2022 04:03:27 -0500
X-MC-Unique: 4xWy6QLdP1K6uCtLj9N9zA-1
Received: by mail-wr1-f69.google.com with SMTP id w7-20020adfbac7000000b001d6f75e4faeso846741wrg.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 01:03:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X6Mi9ajTPAaH4GRgHowugsZMJXzFkvUakKFgNQa4uWk=;
        b=Gex56tEs9QddmEoQEFNZHF2qxvTgiIB1ZzclmQSb8TOfg6jMwBb2HNCSA7PO7Mie57
         mjM4T5levTzvsETie9OyTvFiTYgHwfZOTvrQvHpMmFGh/9iR70nJrFySJZTLnsfM7gxI
         XB8lmNvzecjE/0IqvqOS9was0tPcfLkJdqOpvrA+0Kx1Ub+nvNOTppDuLlJzarB+LSy8
         VpFMG7g11/mX18SVGraRSH304O2MGS/o2x15aHA+erGvN9qohsu/mJWVztZCysMncmA+
         VdT0ETBlqR1msfYRsnGqvVW5FvpkVo8nrClrqj32ETEa6zuR7hfZ2aswnPuHuqPeh0pJ
         4gFg==
X-Gm-Message-State: AOAM532PmPf8IOg/XeYjYmR78uxKpJTyetxIoHJ/24E2QgsXBfOBRLzD
        gsyaNYQl/ZxkDGS5sl2gJTHditf84MIMlSNQUwOdptgKXOWYy5y+sKP3+iVoL18Cqf95FOlZULK
        1rtcBtym2s4ufpEJALT39j/ujZvIxR+XHHsjM+LkT4kAUGdi5nbOUfcExsxqe7eKZp4ImPX5iax
        Y=
X-Received: by 2002:a5d:6549:: with SMTP id z9mr1223155wrv.420.1644397406207;
        Wed, 09 Feb 2022 01:03:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxyAoxcw7jgi7SZI0lZuE3Ts1yz6KYfW12uWxaTagcv05Vtrjuw9CQlAfWSnk+ZHtktaUn1mg==
X-Received: by 2002:a5d:6549:: with SMTP id z9mr1223114wrv.420.1644397405788;
        Wed, 09 Feb 2022 01:03:25 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z1sm4058866wmk.32.2022.02.09.01.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 01:03:25 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v3 1/7] drm/format-helper: Add drm_fb_xrgb8888_to_gray8_line()
Date:   Wed,  9 Feb 2022 10:03:08 +0100
Message-Id: <20220209090314.2511959-2-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209090314.2511959-1-javierm@redhat.com>
References: <20220209090314.2511959-1-javierm@redhat.com>
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

