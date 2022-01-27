Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283DE49D936
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 04:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbiA0D0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 22:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbiA0D0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 22:26:16 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECE5C06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 19:26:16 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id v3so1121191pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 19:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UXgGm9s9WWnJocR1csEpEoFP0RYkPEhnyAgndhDwtjc=;
        b=O4KjoPSuQDZNGBWdQmitA/kZxO0YlbnND4cNyWdlyu4NQbK+BjberWp7inGyjYEFJK
         V6JfMoxtuIZkIBnyKTfo0YDRqThLerNVvqa+K1pSkgZZvEcRMTgu3/Fla5GeW5IktNNn
         Bijtm9oz/pYUb5wZ8jBAPSSs4k9N9koKFTfDDcGFPBvT1f6aT69SbDPqjCIOCXPuxmTu
         3zWG6DCftxpuLhT0mrnB7Ni8jRvM2RLA+4slw5oHeDn0lLA7Qm21MGiq0iFX+UpbBapn
         fzZcajgCC/wg3/Mw4zbuNAa0nNAWO80t/e4VHG2oUY2aJnDbWbkuoV/5ZDfxq5gVqZdt
         hdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UXgGm9s9WWnJocR1csEpEoFP0RYkPEhnyAgndhDwtjc=;
        b=yJMyuIQZXWQX+6N+SqRwP6mvp96GBP9nWlBiNFbo3w5mj9Ek9lLLGv6MXGHOixUkJA
         YdRCcaYnliYZOqlbi1OswZWzMpABpVdwcBLWkWdaDDMwZDnJO/uz2Kihr7xBngYRPM4t
         pKUb43SkbEJvJYyGgta47Mk8Q+YjcFh0zasJREYeivySyHxHtsg+50bSwJ4dzX3mHWLp
         5/htD5N/4Mrq0EJLshucfKN6nU55ZHWTzcR9xsPcd32bUzV2t81cUAZ0/Tk58STO5Fe5
         QzinZweYhBLMZ0KZH/BVSVwd1kT/T2RR9w3HZDer4rfr9v2hUOrHFlzGFuNB6QlLSVP7
         t4Hg==
X-Gm-Message-State: AOAM532wr2UkfqxvHejYa9eeJ2Lk7fnAN2JOZLvVHvXml78RAWtfTGk+
        tpVAMqfZZqTAK/vptH2LRlE7wg==
X-Google-Smtp-Source: ABdhPJysmgOujAl45WjONf68QQ5jRzvfCobqxGtGJ8Z511kMtGA4DmksGOLMeNbJRLJFDxAUzyr1Nw==
X-Received: by 2002:a63:2c07:: with SMTP id s7mr1356397pgs.181.1643253975979;
        Wed, 26 Jan 2022 19:26:15 -0800 (PST)
Received: from aqua.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id t15sm4203111pjy.17.2022.01.26.19.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 19:26:15 -0800 (PST)
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
Subject: [RFC PATCH v5 3/3] drm: remove allow_fb_modifiers
Date:   Thu, 27 Jan 2022 12:25:39 +0900
Message-Id: <20220127032539.9929-4-etom@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127032539.9929-1-etom@igel.co.jp>
References: <20220127032539.9929-1-etom@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allow_fb_modifiers flag is unnecessary since it has been replaced
with fb_modifiers_not_supported flag.

Signed-off-by: Tomohito Esaki <etom@igel.co.jp>
---
 drivers/gpu/drm/selftests/test-drm_framebuffer.c |  1 -
 include/drm/drm_mode_config.h                    | 16 ----------------
 2 files changed, 17 deletions(-)

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
index 4a93dac91cf9..6b5e01295348 100644
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

