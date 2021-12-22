Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DED47CECA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243680AbhLVJGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243690AbhLVJGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:06:03 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3FAC061401
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:06:02 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n10-20020a7bc5ca000000b00345c520d38eso616658wmk.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=udzgSr2XOO8m43wZrlgxQCrOrIrYf8SlPUnoZjFzTYk=;
        b=E3MxQbgD6jp8QTL0eeprZVCT29X4TsAZ9rSxABqoJKJws7UxtL3y3Rb2aRJp575Ctn
         hesvkKOolE8pblgflzdy9N9arwD4TLsVdHjcz4j1NzcMqlx9cge1sYvwMWt+PDGrEnZv
         Y5i0OTQsxOJNGvY9tnt72sq1D1nlChs/Dlk7DLlupN28xGHToNFRR3dsa0SwxLOuKQbY
         5utUtrQy+t8z0vA8wy2xlzgyZq7k4kWhzakGbvKVtthnxoUy3g+/ce/GXp3eUfCWGNTv
         3YHSQ7vjPxoH+APQRxDnNB3K64KnRQzbtCWTUulgJeyw5GEOzsGQN3ujO/QZQbujfoWg
         PFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=udzgSr2XOO8m43wZrlgxQCrOrIrYf8SlPUnoZjFzTYk=;
        b=E7mS70aNxxnR0owxGt696R+8memP3VaAqcEOtIdDtcse03t+/SuU48t+1Aq6DfWCwQ
         hJVSdMbVisD7SOmOeonScS2611UCWDZWwfSBYgDme6YxiJBOoBDB5TR1fcyL/PWuMylE
         6+2E/zjHnhRiZCiS3heAZvf1s5+YoWFtSnWLBSy5+WWhiO8K/SBBF9JqFPkY0n4Z2PLW
         p1w7m+JPFTprjeYjy/1j2V8GEKQgK/D9uugoOdyMciaSdt4yPZj0Mp0jgW1fd5IE4yQq
         RID6LO7+mA5C4LM3OfyuigLz/83+imx34pTjZTT79fo+pKh6Y9Tuz5Jv4TxqhRWzy/pK
         iWNw==
X-Gm-Message-State: AOAM531FUwxwS7v5QVeQZueuLcy2AHDx/CCV/o4YtQRijMJPYi/2MIRc
        f4T8jbXGNugNxriIabNS4pY=
X-Google-Smtp-Source: ABdhPJyucSE6tLj1nZatpMDhi96s0rRJ4voGBbwV+cnaaT+IgfOg7RVHe2BjZm9f/hkIq7HlprLhNQ==
X-Received: by 2002:a1c:440a:: with SMTP id r10mr226427wma.4.1640163961031;
        Wed, 22 Dec 2021 01:06:01 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id a22sm1139775wme.19.2021.12.22.01.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 01:06:00 -0800 (PST)
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
Subject: [PATCH v2 3/6] drm/simple-kms: Drop format_mod_supported function
Date:   Wed, 22 Dec 2021 10:05:49 +0100
Message-Id: <20211222090552.25972-4-jose.exposito89@gmail.com>
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

