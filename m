Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C8247CEC3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243685AbhLVJGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbhLVJF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:05:59 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5990BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:05:59 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso862323wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4JUlyn+OB9q/nAkx157+4tz8tby5UzCmjnk2cgpU7/E=;
        b=bu3nJO8MFxa2c3oQBbJ83GmuDcUoW/SXO45yCpT+W+biCuOoDSCSUHLDaLok8S5hJO
         AGIc638dQmhbYpVFO3fcT9cyc67PGfn2OhQTD/r1mPw1TTpNMQjoh0TYQr+U02yOW+tu
         X442JQhjJcoe+krNyki1Sg1bJOTF9j3gNtXaGIIPkZZp3cmiigPYVLCFUFLhsYanQnie
         TuzmHfDaVWrRYXrnE27kVoBZrfZiA2Sk8z72o7/mpw+6dFQl8nVHTQNcderx02plvF5i
         nSPpg9Ra28b5DwLGb8L/YCKoscQfG/MHB4XsUEBcGl83DyyOnlwlpLq4zhH15So0AFvo
         r8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4JUlyn+OB9q/nAkx157+4tz8tby5UzCmjnk2cgpU7/E=;
        b=zFzj8gMESz7CpXbNtMwK1rL4+lOQVB/+GhCn+wTWAEOOxQx9ylUOEQ8+HOKUoMi17/
         Ny/M62MZrM6J8B6YL9E9rGIu7gCEQ+pfVNEY5iGSzrtRgWvaztUvOgGNseMPGEC/ioSR
         KbUHgYjj0IkDtan9ujokHnMKw+LvJDKN15BqRT6XMQsRZKHqygXzKDE0HObuXBZda5E5
         qDEU9AJzMNCRqGZfPNPgEGjUtcSA4cfMfme1rQt2/bga5WlBhIMRXafFkSfVZPTVYSll
         MPiUBWGCRAnl4kDNzYTEj6lFF9WAtZQV+OEfFl0GVe/lZvkg0xnUdQyhCMR9x19X2F2g
         bn6Q==
X-Gm-Message-State: AOAM531paLq9PjLq/21zqHIhPqMRcvZp4sJ7SigTQltXDBOTmIMKW9bS
        aLgH5APuAoSeQWye6rRkjTA=
X-Google-Smtp-Source: ABdhPJytwBVNsRsjyCUwyNbd1c89P3F94MwHR3ncwRrz/bBC3+610uzB064VOeAclTRMoqfrorHsTQ==
X-Received: by 2002:a05:600c:c6:: with SMTP id u6mr219660wmm.8.1640163957972;
        Wed, 22 Dec 2021 01:05:57 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id a22sm1139775wme.19.2021.12.22.01.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 01:05:57 -0800 (PST)
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
Subject: [PATCH v2 1/6] =?UTF-8?q?drm/plane:=20Make=20format=5Fmod=5Fsuppo?= =?UTF-8?q?rted=20truly=C2=A0optional?=
Date:   Wed, 22 Dec 2021 10:05:47 +0100
Message-Id: <20211222090552.25972-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211222090552.25972-1-jose.exposito89@gmail.com>
References: <20211222090552.25972-1-jose.exposito89@gmail.com>
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
---
 drivers/gpu/drm/drm_plane.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 82afb854141b..c1186b7215ee 100644
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
-- 
2.25.1

