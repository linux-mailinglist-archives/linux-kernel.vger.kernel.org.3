Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C716E47F69B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 12:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbhLZLZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 06:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbhLZLZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 06:25:20 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9597DC06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 03:25:19 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id s1so26524900wra.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 03:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=udzgSr2XOO8m43wZrlgxQCrOrIrYf8SlPUnoZjFzTYk=;
        b=aCJzevHTBUPOKcQPw7hm+UB6JT/t1Fj3BW8O/jb392wnD0zkTkz+ZRTgelV2Yqg4MX
         W56GKzMk7Dzv9jaWuj28ZGU0lVkjYx9uNQh/0FadJ8JoyS4D8EWW4CIAYW1tl0U9P7Lu
         lOPPBpLonGHs296MrSx6PHecvp6ye/GIP5RQ4mgs54meCrWhzDzzmfoqLTwl5T4r5ib9
         Pu/3qMSp+gxIEeM+eE+BXjRwq2tGWwY7trJ/lA3Gq2QHZqATUNoI4JMtTWT95wDJflmL
         miGdPBFBHeeWcNJEd7MBupYAO07XGQ5e+OUbtSazNCYnC5IefApuP8gZt5MQQnVdZSo+
         V4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=udzgSr2XOO8m43wZrlgxQCrOrIrYf8SlPUnoZjFzTYk=;
        b=2Rp88VF22kPW8iiZ9ZXM5VZV/SbX8sWQ1u2mFL+hCJkoPyozi8HAUruBL39O7EpiZx
         R62KRrfLl/7IEoNfDSf8Z/SBenAhuj8fWORNmWiJxQbe+41m80HZ2NlAbl40j0NjADEU
         zXP+ClDn9Fkoe0Fa1t90amraMcOaDrLKTjz0TekBCrHaWYe0unPZySPi018bwXg/N9ty
         CX0EoHjQqVRr+tfxps+qz5PVjzye8oYhKlRHRYPCT6d1k+q5dkw3CuQep7vkUXblNEDH
         KXjfNTPUk6uaD6u8w58Ywr3sW0rqGQelIBUOxWLXqPvnDY8u7eysqi09QTITuE//6dE9
         T1+g==
X-Gm-Message-State: AOAM532bN9C58B0rQ8uC10y2jG66MXWrF5gYhlCzDSPyHspzjJIJQc4v
        MB+cTv3g0DgjZ/a6mJxfLWk=
X-Google-Smtp-Source: ABdhPJxUGkExUZ7jGhhIux0K+s4/ECaFhn9zxSixHZY9ABIuQhk4H3r2v0oZ1KM30IAWTvYNQ1yqjg==
X-Received: by 2002:a05:6000:1845:: with SMTP id c5mr9492151wri.499.1640517918125;
        Sun, 26 Dec 2021 03:25:18 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id g12sm13654743wrd.71.2021.12.26.03.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 03:25:17 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     contact@emersion.fr
Cc:     ville.syrjala@linux.intel.com, dmitry.baryshkov@linaro.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, marex@denx.de, stefan@agner.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, yannick.fertre@foss.st.com,
        philippe.cornu@foss.st.com, benjamin.gaignard@linaro.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 3/6] drm/simple-kms: Drop format_mod_supported function
Date:   Sun, 26 Dec 2021 12:25:00 +0100
Message-Id: <20211226112503.31771-4-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211226112503.31771-1-jose.exposito89@gmail.com>
References: <20211226112503.31771-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "drm_plane_funcs.format_mod_supported" can be removed in favor of
the default implementation.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/drm_simple_kms_helper.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
index 72989ed1baba..2c6aa67c6956 100644
--- a/drivers/gpu/drm/drm_simple_kms_helper.c
+++ b/drivers/gpu/drm/drm_simple_kms_helper.c
@@ -284,13 +284,6 @@ static void drm_simple_kms_plane_cleanup_fb(struct drm_plane *plane,
 	pipe->funcs->cleanup_fb(pipe, state);
 }
 
-static bool drm_simple_kms_format_mod_supported(struct drm_plane *plane,
-						uint32_t format,
-						uint64_t modifier)
-{
-	return modifier == DRM_FORMAT_MOD_LINEAR;
-}
-
 static const struct drm_plane_helper_funcs drm_simple_kms_plane_helper_funcs = {
 	.prepare_fb = drm_simple_kms_plane_prepare_fb,
 	.cleanup_fb = drm_simple_kms_plane_cleanup_fb,
@@ -339,7 +332,6 @@ static const struct drm_plane_funcs drm_simple_kms_plane_funcs = {
 	.reset			= drm_simple_kms_plane_reset,
 	.atomic_duplicate_state	= drm_simple_kms_plane_duplicate_state,
 	.atomic_destroy_state	= drm_simple_kms_plane_destroy_state,
-	.format_mod_supported   = drm_simple_kms_format_mod_supported,
 };
 
 /**
-- 
2.25.1

