Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289C64B2800
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350901AbiBKOeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:34:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350890AbiBKOeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:34:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74E2AB09
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 06:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644590048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wFaIKzYZq5mwoMCRxFCEVoEkMIRZsF+ixkyzhcwnXVQ=;
        b=jD103IZFSCCoX4Cm8PPE/jSLT1L4T7zyxIsJ+xYBEsxeai8vF4io/uM5MlYZGT73AIus31
        hZ6Uslt/QTR+AYM1HXTYmUoMV9v7pBfUby+t3E9rP3Ygipt8Bir+nEO1V1CPoFPCTmX7Va
        UJBwO3P8O3nmInjz2EgfproCImaSRTw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-yT7Ud3zkNemGAov8PParlg-1; Fri, 11 Feb 2022 09:34:07 -0500
X-MC-Unique: yT7Ud3zkNemGAov8PParlg-1
Received: by mail-wm1-f70.google.com with SMTP id a8-20020a7bc1c8000000b0037bc4c62e97so2611449wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 06:34:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wFaIKzYZq5mwoMCRxFCEVoEkMIRZsF+ixkyzhcwnXVQ=;
        b=LJlPeGvMj+4EEbp6Op8Wl8vQ51ZVIp8VwCQYXPt3gfsbMI65xnNx0WU5TrqiNFWC30
         uc2JV/6jjc+9GFpcWoAS+yYjh9U3eQnrxy46zYmTqNxlIgau45r4R3ks+O8eaVUOT0eH
         roiWJg+FuMn6PF896V/GZOYNUOIAursSNIX5e5yntoJAbtVYnJXvREZK4WqWZ2qmHPXG
         M35J2tP/PUjt3ZMYQQ9y8lvwCi0y90KGn8Bd5UCYZPOZnkBPldVwRsZL6ldQ64MaZOwH
         YjTXKJg54S3IO7HNIhYRPIAUk7gWfzPC+m+3i+akEHweKPhWhDm940+NEdMv6vEilzx3
         jYJQ==
X-Gm-Message-State: AOAM530kaYP4+c48A7+wcg5RwObg5Vz7vHFgpzPMQ+BDMefjzh/+cRSv
        CeMVxX9kEFcXNGZOYm/CRCO53qEfXCROBJr93lAaD0fRUqyZ18jzX4BnpMfG86RcyB5AtKdj7KI
        puffSxnwcEcYPMteRAJqZPWEfx35SZy1/aofEXPcM89tMtyP63yocHFQfOp0FLno0Kom6AouQHG
        Q=
X-Received: by 2002:a05:600c:154f:: with SMTP id f15mr498451wmg.111.1644590046259;
        Fri, 11 Feb 2022 06:34:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhPexpHfSetxE0S3/Tn4IvNqI07iQUkmyj562tzbxdGmYsFTdsPjtNvRQ7u4RPguUGeK9nwg==
X-Received: by 2002:a05:600c:154f:: with SMTP id f15mr498413wmg.111.1644590045932;
        Fri, 11 Feb 2022 06:34:05 -0800 (PST)
Received: from minerva.redhat.com ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o14sm24616012wry.104.2022.02.11.06.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 06:34:05 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-fbdev@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v5 1/6] drm/format-helper: Add drm_fb_xrgb8888_to_gray8_line()
Date:   Fri, 11 Feb 2022 15:33:53 +0100
Message-Id: <20220211143358.3112958-2-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211143358.3112958-1-javierm@redhat.com>
References: <20220211143358.3112958-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
---

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

