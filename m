Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419E748E838
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbiANKSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240387AbiANKSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:18:32 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4582C06161C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 02:18:31 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id ie23-20020a17090b401700b001b38a5318easo13706383pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 02:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PBKQ4CufOeLqIoTmEy7ZkjqAF1a5b4cdB+1/usiOdF4=;
        b=nhuNT672TAKKaxjafFtomSOLi7rPNQ05WXsrh2uZBnqtC6HSA2tIyIAoTB48UaD4hW
         Xk0s8xM3Yi2J30dre8rzL2SOhLxPiT5WH6by3XU0VNCrrp11TATEpsHyBWai0GlXIq8Y
         ymBDV76aSXJeHn/eN51cW1gbu9OR7JfoMXo2XcQpCinYOx6UlyvHuU1tiFGV+lYOuvyS
         ZnL8kvFACfkqxZbKnbpzemSdR1SuIPgezL84EOFCgMOmoUYzzGHWZaA/VpMIue04MFj/
         n4cm42R48991eaclKg1A0OuW173xxarBGFm48NJeU8TdH1DY0GxKVMgRxidKS5oyCxvc
         /JNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PBKQ4CufOeLqIoTmEy7ZkjqAF1a5b4cdB+1/usiOdF4=;
        b=bD24KxFE5A4jy2zkDwc8jfs4f4ACzy/AfJPu/ifZXC4BSMR9isHKorjky7HuC5P/Mb
         kzTC7cwBWFyQHAdKMWAQepPLmg8Vg2W0qJQ5Xkf4YRFu6KYSdGrH9RDwXN/Xs9XOgQ+3
         nSEW+G+pfRx/kpAptte4NngA6rEIEufxpYXOhLSSz93gk7QpNb5SQhM4dvI/joayNIJy
         KKFHW3H7h9CbzLIm3rs2ZJybIoz7f/vjrN+3pMqFxnF9fodISPdCg/8HCDK2xbZXBEN8
         qLX+oDpECLVPB4MJ2vBSquUHBU8X2/HglPArdipuPz40tfp/VzTN1D6UNlHkQd6Zolfw
         ttNw==
X-Gm-Message-State: AOAM533ct39bQQF0RYQzdtuK76rdQDbeGgt48j+3rlAA/Z3rv6EztwKq
        TKONxpiDexx4fgifCTLNvTOwtg==
X-Google-Smtp-Source: ABdhPJwCXCok9Tnnj36jd/hBgwqx96J9Uuhal8x4cOAflq2B6/Quel6WNHnMh7YjhlAAQhJePR4ZRQ==
X-Received: by 2002:a17:902:c94c:b0:14a:7ad9:8067 with SMTP id i12-20020a170902c94c00b0014a7ad98067mr7949307pla.104.1642155511426;
        Fri, 14 Jan 2022 02:18:31 -0800 (PST)
Received: from aqua.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id 13sm5555970pfm.161.2022.01.14.02.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 02:18:30 -0800 (PST)
From:   Tomohito Esaki <etom@igel.co.jp>
To:     dri-devel@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Simon Ser <contact@emersion.fr>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Mark Yacoub <markyacoub@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Evan Quan <evan.quan@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org, Daniel Stone <daniel@fooishbar.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomohito Esaki <etom@igel.co.jp>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>
Subject: [RFC PATCH v3 3/3] drm: remove allow_fb_modifiers
Date:   Fri, 14 Jan 2022 19:17:53 +0900
Message-Id: <20220114101753.24996-4-etom@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114101753.24996-1-etom@igel.co.jp>
References: <20220114101753.24996-1-etom@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allow_fb_modifiers flag is unnecessary since it has been replaced
with cannot_support_modifiers flag.

Signed-off-by: Tomohito Esaki <etom@igel.co.jp>
---
 drivers/gpu/drm/drm_plane.c                      |  9 ---------
 drivers/gpu/drm/selftests/test-drm_framebuffer.c |  1 -
 include/drm/drm_mode_config.h                    | 16 ----------------
 3 files changed, 26 deletions(-)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 5aa7e241971e..89a3d044ab59 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -288,15 +288,6 @@ static int __drm_universal_plane_init(struct drm_device *dev,
 		}
 	}
 
-	/* autoset the cap and check for consistency across all planes */
-	if (format_modifier_count) {
-		drm_WARN_ON(dev, !config->allow_fb_modifiers &&
-			    !list_empty(&config->plane_list));
-		config->allow_fb_modifiers = true;
-	} else {
-		drm_WARN_ON(dev, config->allow_fb_modifiers);
-	}
-
 	plane->modifier_count = format_modifier_count;
 	plane->modifiers = kmalloc_array(format_modifier_count,
 					 sizeof(format_modifiers[0]),
diff --git a/drivers/gpu/drm/selftests/test-drm_framebuffer.c b/drivers/gpu/drm/selftests/test-drm_framebuffer.c
index 61b44d3a6a61..f6d66285c5fc 100644
--- a/drivers/gpu/drm/selftests/test-drm_framebuffer.c
+++ b/drivers/gpu/drm/selftests/test-drm_framebuffer.c
@@ -323,7 +323,6 @@ static struct drm_device mock_drm_device = {
 		.max_width = MAX_WIDTH,
 		.min_height = MIN_HEIGHT,
 		.max_height = MAX_HEIGHT,
-		.allow_fb_modifiers = true,
 		.funcs = &mock_config_funcs,
 	},
 };
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index da82f45351c7..5001bda9f9af 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -917,22 +917,6 @@ struct drm_mode_config {
 	 */
 	bool async_page_flip;
 
-	/**
-	 * @allow_fb_modifiers:
-	 *
-	 * Whether the driver supports fb modifiers in the ADDFB2.1 ioctl call.
-	 * Note that drivers should not set this directly, it is automatically
-	 * set in drm_universal_plane_init().
-	 *
-	 * IMPORTANT:
-	 *
-	 * If this is set the driver must fill out the full implicit modifier
-	 * information in their &drm_mode_config_funcs.fb_create hook for legacy
-	 * userspace which does not set modifiers. Otherwise the GETFB2 ioctl is
-	 * broken for modifier aware userspace.
-	 */
-	bool allow_fb_modifiers;
-
 	/**
 	 * @fb_modifiers_not_supported:
 	 *
-- 
2.25.1

