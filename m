Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970BD47CECC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243777AbhLVJGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243744AbhLVJGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:06:05 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766FDC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:06:05 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id e5so688605wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3uC+zpueN0jaqztWM7eUqBfpEMbmsR8tb66iIJAnvGU=;
        b=DN/hezu8BpvlioFiGvPzdpBnLgh7II07BN9W7INVCzSlG/W+L+9oRlBVBOiyDVwRzN
         BxgyMTO/wmtmvNY2yXs/gCKyTnr8BxUmdvjzLD3hV1ZGJ2BdB+8MLPEPziAae6wboQaN
         ct81mDMbeL8K1H6rjhaTxYKOMQmxKDQyYUYXFmLa6yleKnfY7pur/hrESfd4/7lXHtR0
         67vFJ1qpR18/R1lSFtZJYGFK26vg4J3pntLCw3ctkAYE+u2xLA95KJ0zfx6oMhr99A2L
         qFh4JurVj8/5urKMAIyJ7sljhjX2t06BNLt5+W0Mw36NQiXYgzUd/f17GYlA+Edw5nP8
         5XPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3uC+zpueN0jaqztWM7eUqBfpEMbmsR8tb66iIJAnvGU=;
        b=5mVl4zfTPODBxw4+jxcdtWLMr7quo9Zx1vBoLMl5yYX68gDhrvJ8Lwkokd9Hw+rK4E
         9YtibA8cl5icoHkLFoSv9xoPWPd4jvOdgyzJ4dzMzDNIoB2CKvu2E7HP1l9LBF7M1str
         zrs9TgpmYb3qyQ0Cg5kX4wsMZ4brk5qIVk1D6aUvDb+7KmMILoYtURQJZL1Icd+teT5z
         LqBwdsscfiEOGsTjj4FpdgUBk2/oSIFhhWUsyQ8t2sRPEEXQh50mp57BSbOxtE98IRuJ
         nG30Nkea0ZejELiQveZdYCauxyMrjk/JJY15OUxzKcdXIW9MV3v1ineATAu6jw0R33cD
         BqWQ==
X-Gm-Message-State: AOAM533P8h4l/RaCkDv8zDi2xjscX7UKavo+i3CXa8hGyC5W3CVxgiAU
        8DjfYX7dU1CVP3xW8JgN6mQ=
X-Google-Smtp-Source: ABdhPJwjkqCU2eOiLPDiEpUgnr87YSHM9DTy3lNdv7hPr78L5Q1Nuo13SkbxfvjjlDc4nJ6/guabtA==
X-Received: by 2002:a05:600c:296:: with SMTP id 22mr208645wmk.11.1640163964078;
        Wed, 22 Dec 2021 01:06:04 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id a22sm1139775wme.19.2021.12.22.01.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 01:06:03 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     contact@emersion.fr
Cc:     dmitry.baryshkov@linaro.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@linux.ie,
        daniel@ffwll.ch, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        marex@denx.de, stefan@agner.ch, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, yannick.fertre@foss.st.com,
        philippe.cornu@foss.st.com, benjamin.gaignard@linaro.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 5/6] drm: mxsfb: Drop format_mod_supported function
Date:   Wed, 22 Dec 2021 10:05:51 +0100
Message-Id: <20211222090552.25972-6-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211222090552.25972-1-jose.exposito89@gmail.com>
References: <20211222090552.25972-1-jose.exposito89@gmail.com>
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
 drivers/gpu/drm/mxsfb/mxsfb_kms.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
index 0655582ae8ed..df32e1c3cc5d 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
@@ -554,13 +554,6 @@ static void mxsfb_plane_overlay_atomic_update(struct drm_plane *plane,
 	writel(ctrl, mxsfb->base + LCDC_AS_CTRL);
 }
 
-static bool mxsfb_format_mod_supported(struct drm_plane *plane,
-				       uint32_t format,
-				       uint64_t modifier)
-{
-	return modifier == DRM_FORMAT_MOD_LINEAR;
-}
-
 static const struct drm_plane_helper_funcs mxsfb_plane_primary_helper_funcs = {
 	.atomic_check = mxsfb_plane_atomic_check,
 	.atomic_update = mxsfb_plane_primary_atomic_update,
@@ -572,7 +565,6 @@ static const struct drm_plane_helper_funcs mxsfb_plane_overlay_helper_funcs = {
 };
 
 static const struct drm_plane_funcs mxsfb_plane_funcs = {
-	.format_mod_supported	= mxsfb_format_mod_supported,
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
 	.destroy		= drm_plane_cleanup,
-- 
2.25.1

