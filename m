Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8410246844B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 11:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384788AbhLDK7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 05:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384733AbhLDK7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 05:59:08 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68771C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 02:55:43 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id f18so12831613lfv.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 02:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C0d0CUW1B7x3fzQqz6q8k32dtwb0GdQ9fNSXToABtcU=;
        b=qpphbWrfpXnlbiEVlqmUTcigeUTFRQk5OfwQa4Ljt0drpgNZXGtP/7wYUQvB+P5wWo
         5OCIs84DZfeAm+D2tn+ER42zog8GCcuiMVv8vsHlaJor7SWsKcirDBGxW+7Nq8+0+nMc
         FHKRnvdXJpAk8bow2fW7Q3o8xUX/TLvfBzPKI7p6rDn4F89plBLoYXZa3PpFpfr6Pq/f
         IzfVIghLys9BlstnmC8Ku4Gy4QIXDDioPkKXtxzKMuMFS/VJ02U+ddaw0FBmKRY85TTQ
         2n7v9qziFq3ltljQQdm6S5HqmMT3rMoVOAz66h1rZDsrS9jEOUhY7cEjTOtJSjxanfrL
         bCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C0d0CUW1B7x3fzQqz6q8k32dtwb0GdQ9fNSXToABtcU=;
        b=CwS3qqVfZTVDTCd2zjXP8nsuTXyPvMDYd3VRTM4S6xAbSIOnWqNZok3fJX7ajqa3Lp
         xD9PQEwenxPn2Y/TqQNrM47sk25WG5aYJnwALWlUr4FTQ+RFKXRUGctaZdQV/zgdtEiK
         rdL0Lgb3UGgCP4cCEp2gPwL5eoGA4gafkWukMz4zyvYTq/Q+pMtW6cuAAjGA3yjZOXgV
         OwxswCqQJo2H/ZorHxme3tGvpxJD/l4Ucs8dOebp7WBiKkLYkLd168t7R0GS2Mb2v3JW
         ztDIAX94gxZinJo5zBZu4eK+EbIaN2IoQeuLhtjK+cUXv5NC0o7pabIi0mN+MbXbv9cU
         EWDg==
X-Gm-Message-State: AOAM530Py6Hvn8oq2fSTaMgGZl99EDACxV/gbiK6O+xTouH+9Wu6mM+m
        LwJoT9A5QWVCSXZ/lPa3LCM=
X-Google-Smtp-Source: ABdhPJwpksWaueUjfxQN8EXKZ8uyMOdB4TxPhlVFPayupsVJ63romup+0geZhDZmninOVvoeqbkCTw==
X-Received: by 2002:a19:5e59:: with SMTP id z25mr23826496lfi.686.1638615341727;
        Sat, 04 Dec 2021 02:55:41 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id d23sm723918lfm.107.2021.12.04.02.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 02:55:41 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 7/9] drm/i915/gvt: Constify formats
Date:   Sat,  4 Dec 2021 11:55:25 +0100
Message-Id: <20211204105527.15741-8-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211204105527.15741-1-rikard.falkeborn@gmail.com>
References: <20211204105527.15741-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are never modified, so make them const to allow the compiler to
put them in read-only memory. WHile at it, make the description const
char* since it is never modified.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/gpu/drm/i915/gvt/fb_decoder.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/fb_decoder.c b/drivers/gpu/drm/i915/gvt/fb_decoder.c
index 11a8baba6822..3c8736ae8fed 100644
--- a/drivers/gpu/drm/i915/gvt/fb_decoder.c
+++ b/drivers/gpu/drm/i915/gvt/fb_decoder.c
@@ -40,12 +40,12 @@
 
 #define PRIMARY_FORMAT_NUM	16
 struct pixel_format {
-	int	drm_format;	/* Pixel format in DRM definition */
-	int	bpp;		/* Bits per pixel, 0 indicates invalid */
-	char	*desc;		/* The description */
+	int		drm_format;	/* Pixel format in DRM definition */
+	int		bpp;		/* Bits per pixel, 0 indicates invalid */
+	const char	*desc;		/* The description */
 };
 
-static struct pixel_format bdw_pixel_formats[] = {
+static const struct pixel_format bdw_pixel_formats[] = {
 	{DRM_FORMAT_C8, 8, "8-bit Indexed"},
 	{DRM_FORMAT_RGB565, 16, "16-bit BGRX (5:6:5 MSB-R:G:B)"},
 	{DRM_FORMAT_XRGB8888, 32, "32-bit BGRX (8:8:8:8 MSB-X:R:G:B)"},
@@ -58,7 +58,7 @@ static struct pixel_format bdw_pixel_formats[] = {
 	{0, 0, NULL},
 };
 
-static struct pixel_format skl_pixel_formats[] = {
+static const struct pixel_format skl_pixel_formats[] = {
 	{DRM_FORMAT_YUYV, 16, "16-bit packed YUYV (8:8:8:8 MSB-V:Y2:U:Y1)"},
 	{DRM_FORMAT_UYVY, 16, "16-bit packed UYVY (8:8:8:8 MSB-Y2:V:Y1:U)"},
 	{DRM_FORMAT_YVYU, 16, "16-bit packed YVYU (8:8:8:8 MSB-U:Y2:V:Y1)"},
@@ -278,14 +278,14 @@ int intel_vgpu_decode_primary_plane(struct intel_vgpu *vgpu,
 
 #define CURSOR_FORMAT_NUM	(1 << 6)
 struct cursor_mode_format {
-	int	drm_format;	/* Pixel format in DRM definition */
-	u8	bpp;		/* Bits per pixel; 0 indicates invalid */
-	u32	width;		/* In pixel */
-	u32	height;		/* In lines */
-	char	*desc;		/* The description */
+	int		drm_format;	/* Pixel format in DRM definition */
+	u8		bpp;		/* Bits per pixel; 0 indicates invalid */
+	u32		width;		/* In pixel */
+	u32		height;		/* In lines */
+	const char	*desc;		/* The description */
 };
 
-static struct cursor_mode_format cursor_pixel_formats[] = {
+static const struct cursor_mode_format cursor_pixel_formats[] = {
 	{DRM_FORMAT_ARGB8888, 32, 128, 128, "128x128 32bpp ARGB"},
 	{DRM_FORMAT_ARGB8888, 32, 256, 256, "256x256 32bpp ARGB"},
 	{DRM_FORMAT_ARGB8888, 32, 64, 64, "64x64 32bpp ARGB"},
@@ -391,7 +391,7 @@ int intel_vgpu_decode_cursor_plane(struct intel_vgpu *vgpu,
 
 #define SPRITE_FORMAT_NUM	(1 << 3)
 
-static struct pixel_format sprite_pixel_formats[SPRITE_FORMAT_NUM] = {
+static const struct pixel_format sprite_pixel_formats[SPRITE_FORMAT_NUM] = {
 	[0x0] = {DRM_FORMAT_YUV422, 16, "YUV 16-bit 4:2:2 packed"},
 	[0x1] = {DRM_FORMAT_XRGB2101010, 32, "RGB 32-bit 2:10:10:10"},
 	[0x2] = {DRM_FORMAT_XRGB8888, 32, "RGB 32-bit 8:8:8:8"},
-- 
2.34.1

