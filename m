Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1AC47F69C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 12:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbhLZLZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 06:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbhLZLZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 06:25:21 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E2AC061401
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 03:25:21 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id e5so7505435wmq.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 03:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2sH9LpoHKM1nYuCNdjrxssHqCL8Z5G+nLzADIXmtmn8=;
        b=mAetoydiC9DFErqK91+G/B0kP4LJaIEX6wTtFjgxIx2puQBkWT35g7OEs0I6Wxm4eT
         DIS4O5D0u43xloptLbFpnamIbkbZp4QW1A5pN+Ad2pADFD6SEdOMQyLza03nFZ8lW8/3
         Eesto4lZJ3IicDl5rRiAAttyieCY8P8S5nM1MM/+1js3SzqevyK2awp22JsgoAOcP7eZ
         OptHCawHlqbW35aAG3+Wq4go/qCvwqqXt16SSXCJoYAnFMvUPqjB4E0JWPAhZRvtpJr8
         /sV2Bn9XrAl+tgezM0TeuEPuu3A4TNULvoMGSlh58yjiIkGU3uZ6N06sfsiT5q/eDeSa
         /v2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2sH9LpoHKM1nYuCNdjrxssHqCL8Z5G+nLzADIXmtmn8=;
        b=R+3KSWPd4AZX5DKKu9Ptbd4FvUBRM7A7e5jvyqyhVGEP815SC8TXc7ZuEe00Bx68Sy
         lDIBVq55rbTgUqbbnZhZb6tooW9Zth/m/39EuegqdpI8P+MkKxrwb8yQgBgA8cRm+og0
         52QsVUXGKlEFjUXsKkL1wRex6M35DmD7FPzNmSkn7pfS+c+J9IMbQeXjsPv1EqFt6Anq
         FiMc99O/uBRPf6Imrf4QKwJIOvaRU1xokqdZhDP6oQpaiVYumoSrvCTTKnEW8/VxSIuZ
         PW7KDWaHvxkTHmUp039v3bkL/4psvGDV/cHY7J/lrwKK3LpxXRGwIRWRDpFDfokIecjB
         5H8w==
X-Gm-Message-State: AOAM533CfSjF+Db+v5/XefjUVkZuJly0+9Rdls8o/fgRA4XmMMjFQAiw
        jJFPEssM53B4y5ybQkZltf4=
X-Google-Smtp-Source: ABdhPJz4lUyJV89AeASjgwh8PQuZGePew9x5IF62xdHwLSvNvHxbwPsKoabWCJpDvO3twBCqWu015Q==
X-Received: by 2002:a05:600c:3787:: with SMTP id o7mr10046954wmr.110.1640517919698;
        Sun, 26 Dec 2021 03:25:19 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id g12sm13654743wrd.71.2021.12.26.03.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 03:25:19 -0800 (PST)
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
Subject: [PATCH v3 4/6] drm/i915/display: Drop format_mod_supported function
Date:   Sun, 26 Dec 2021 12:25:01 +0100
Message-Id: <20211226112503.31771-5-jose.exposito89@gmail.com>
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
 drivers/gpu/drm/i915/display/intel_cursor.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_cursor.c b/drivers/gpu/drm/i915/display/intel_cursor.c
index 11842f212613..6a5e022f5e21 100644
--- a/drivers/gpu/drm/i915/display/intel_cursor.c
+++ b/drivers/gpu/drm/i915/display/intel_cursor.c
@@ -602,13 +602,6 @@ static bool i9xx_cursor_get_hw_state(struct intel_plane *plane,
 	return ret;
 }
 
-static bool intel_cursor_format_mod_supported(struct drm_plane *_plane,
-					      u32 format, u64 modifier)
-{
-	return modifier == DRM_FORMAT_MOD_LINEAR &&
-		format == DRM_FORMAT_ARGB8888;
-}
-
 static int
 intel_legacy_cursor_update(struct drm_plane *_plane,
 			   struct drm_crtc *_crtc,
@@ -745,7 +738,6 @@ static const struct drm_plane_funcs intel_cursor_plane_funcs = {
 	.destroy = intel_plane_destroy,
 	.atomic_duplicate_state = intel_plane_duplicate_state,
 	.atomic_destroy_state = intel_plane_destroy_state,
-	.format_mod_supported = intel_cursor_format_mod_supported,
 };
 
 struct intel_plane *
-- 
2.25.1

