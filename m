Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADB64B51CB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354346AbiBNNht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:37:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354315AbiBNNhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:37:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B40CA575CC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644845856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PMJPygyk+q6IKiko2o+GbGpYNTzAZFXYDjw6FkGxW+0=;
        b=XcUSKBRxIZc8J6dipz0W+R/Oe5/cU69hgAH3vBwrQYbaRnopUtY6iHfaHKKG0cF6UI6u4B
        75xz4rW7nDNytaZ6xzLIGwHNGk0+3zzRGCIbsJ9eRhp2zUb6QWpC5bm/KwqQABw08YYvoK
        mJ+Itc591TO7E+hoYFfRWCQT6K99BBM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-BMnADW60OheX75bAsxhNGg-1; Mon, 14 Feb 2022 08:37:35 -0500
X-MC-Unique: BMnADW60OheX75bAsxhNGg-1
Received: by mail-wm1-f72.google.com with SMTP id b17-20020a05600c4e1100b0037cc0d56524so1428514wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:37:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PMJPygyk+q6IKiko2o+GbGpYNTzAZFXYDjw6FkGxW+0=;
        b=H4GQHGO07xjoUpmrQyJGxCapuzDZcBg4Ox2b+kKXvuHabnjFaePL8FV5hDBtfKdtB/
         +MuP1+mRH/eYKvii1ABDU22tx5MBvMk6C/8vTZ7hslj4KTzuxhJryStlRJ0e2VfZxqLM
         S0B4UfFs39NK4b5wkbQh1jWq6kowTzR1XOx6c5MhcqjDZKPBTmAHNOXbaF5MsE6mwjlY
         +fTXKaEe+VJtT8GQYzrilldE9y7Uh9Qp+RsdashDjZRyIuyuh57xjOS+ADXTbuK0quiW
         25Zdol/aS4xn5t4aUXBKceMt1Tup5ye0B9CQCxzx1C3SZ5IEN6B/tJ/os7/ih/7u/ZBf
         /hKw==
X-Gm-Message-State: AOAM530BdE0sIxW/GY675DXrylnywB+dgC+Sqpdzv2zTggu7uSUtt5xR
        ob2Lxe904qy5R3aPmaHR6Kzx51578p5GnW8R+gej+M3P92xONTePGHhfCCN4ZYNHzi+9Li6LIP5
        q/0kyqw38MHN1yQPFe2th376kRqQHUBa1+zJgA1LxylZvFaH+ORaeGiHvzJMIuY960VF9/enmjz
        Q=
X-Received: by 2002:a05:600c:d0:: with SMTP id u16mr11405623wmm.102.1644845854482;
        Mon, 14 Feb 2022 05:37:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWrzaW0LQ9WRQkaVll0CUJhsj6kJUqQPxu24pAAdfApfjJNXNN9XDBh1yuBXccEzAh4eXAIw==
X-Received: by 2002:a05:600c:d0:: with SMTP id u16mr11405587wmm.102.1644845854167;
        Mon, 14 Feb 2022 05:37:34 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y6sm3568918wrd.30.2022.02.14.05.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 05:37:33 -0800 (PST)
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
Subject: [PATCH v6 1/6] drm/format-helper: Add drm_fb_xrgb8888_to_gray8_line()
Date:   Mon, 14 Feb 2022 14:37:05 +0100
Message-Id: <20220214133710.3278506-2-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214133710.3278506-1-javierm@redhat.com>
References: <20220214133710.3278506-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Changes in v6:
- Add Andy Shevchenko's Reviewed-by to patch #1.

Changes in v5:
- Add Thomas Zimmermann's Reviewed-by to patch #1.

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

