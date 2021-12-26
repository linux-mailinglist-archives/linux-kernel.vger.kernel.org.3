Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC5347F699
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 12:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbhLZLZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 06:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbhLZLZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 06:25:16 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829AAC06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 03:25:16 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so6940964wme.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 03:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9LTDPcsLit3ZltGpmydxyhDaBvNBfOjBIIApsVidYlU=;
        b=ejlSnBRYPWQDz4Nz+pf/Ob69zbAjcqMfijxXsTWcXhySEQRzUT3JCExyZ5Q1SIvA3c
         kQEyhuRzvpXKwr0S+/rKlCIT/w8ncJ+aQzdm7jpMBRPCQQr/da5ZGlqL/VYyn43hxxCv
         CHtfylV68MCTsg4AhrkoS7zKdwb4IMm7OEpKDU3FaIoEA3fCSGm4fcRNK4c54Tcqvr6/
         zq9E1bBZJSI6Mp+0nnb2zUxeSOTTcaPXWRQkOYUc5TBf57vUoysacqIO7xX3ytpTmfP5
         OepQvrBjQUOgumuDejvOFTQ3kmvegmDblhp3SxIv7Bir6Vv/VhSt9Mkh5t4Y/gKXUW3F
         iQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9LTDPcsLit3ZltGpmydxyhDaBvNBfOjBIIApsVidYlU=;
        b=xNGwcIIeoA7vGxiDSRpWJ98AMASWO2XIP7csTziKwCW8yFCQFr9oHLf0i4hjGnua7M
         XBBhv0aXH9im0NjdkyuRaLDy0X8rvnC4j1HYlMjSyud+zMX/nQyNqyqv09lfRhHE9hPc
         AJTLypLShEvqwldwoFnRhaKvxrUPcuKwbFp2gXAeIaA/1eDP3wx4SwzO0rObQtr5hkjX
         2UWY8V81XtR3Omhyg7zF/M5MTY3nLJjucXbXeXIaoyYHpsj7LlwvOtvLah8y4cZljj9P
         zNvgTQ4ULZ9GgB85mXvRHnYi2CxoLEU0ifviORG+O8rzQadGVUsUgFZYfU+fPNlP6PS8
         X2bQ==
X-Gm-Message-State: AOAM5308zpu29uPrWe2ZORZX3CRjezW1OvgBwRllrxkWwGfaP56xjKX9
        0pWOW4yhe9uDZcLVsBNj3Y4=
X-Google-Smtp-Source: ABdhPJxzOeTdg3Sm90f1frrXzLRCNKL4Q9YDL0ikNej0GhBsklk2qdNprmmmNirl5P7CW0Jv6ObHPQ==
X-Received: by 2002:a05:600c:209:: with SMTP id 9mr10183053wmi.145.1640517915050;
        Sun, 26 Dec 2021 03:25:15 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id g12sm13654743wrd.71.2021.12.26.03.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 03:25:14 -0800 (PST)
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
Subject: [PATCH v3 1/6] =?UTF-8?q?drm/plane:=20Make=20format=5Fmod=5Fsuppo?= =?UTF-8?q?rted=20truly=C2=A0optional?=
Date:   Sun, 26 Dec 2021 12:24:58 +0100
Message-Id: <20211226112503.31771-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211226112503.31771-1-jose.exposito89@gmail.com>
References: <20211226112503.31771-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation for "drm_plane_funcs.format_mod_supported" reads:

  This *optional* hook is used for the DRM to determine if the given
  format/modifier combination is valid for the plane. This allows the
  DRM to generate the correct format bitmask (which formats apply to
  which modifier), and to validate modifiers at atomic_check time.

  *If not present*, then any modifier in the plane's modifier
  list is allowed with any of the plane's formats.

However, where the function is not present, an invalid IN_FORMATS blob
property with modifiers but no formats is exposed to user-space.

This breaks the latest Weston [1]. For testing purposes, I extracted the
affected code to a standalone program [2].

Make "create_in_format_blob" behave as documented.

[1] https://gitlab.freedesktop.org/wayland/weston/-/blob/9.0/libweston/backend-drm/kms.c#L431
[2] https://github.com/JoseExposito/drm-sandbox/blob/main/in_formats.c

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
Reviewed-by: Simon Ser <contact@emersion.fr>

---

v2:

 - Remove unused "done:" label to fix compile warning
   Reported-by: kernel test robot <lkp@intel.com>

 - Add Reviewed-by (thanks to Simon Ser)
---
 drivers/gpu/drm/drm_plane.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 82afb854141b..deeec60a3315 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -202,17 +202,13 @@ static int create_in_format_blob(struct drm_device *dev, struct drm_plane *plane
 
 	memcpy(formats_ptr(blob_data), plane->format_types, formats_size);
 
-	/* If we can't determine support, just bail */
-	if (!plane->funcs->format_mod_supported)
-		goto done;
-
 	mod = modifiers_ptr(blob_data);
 	for (i = 0; i < plane->modifier_count; i++) {
 		for (j = 0; j < plane->format_count; j++) {
-			if (plane->funcs->format_mod_supported(plane,
+			if (!plane->funcs->format_mod_supported ||
+			    plane->funcs->format_mod_supported(plane,
 							       plane->format_types[j],
 							       plane->modifiers[i])) {
-
 				mod->formats |= 1ULL << j;
 			}
 		}
@@ -223,7 +219,6 @@ static int create_in_format_blob(struct drm_device *dev, struct drm_plane *plane
 		mod++;
 	}
 
-done:
 	drm_object_attach_property(&plane->base, config->modifiers_property,
 				   blob->base.id);
 
-- 
2.25.1

