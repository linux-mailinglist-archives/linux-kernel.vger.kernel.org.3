Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1014347CECD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243801AbhLVJGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243736AbhLVJGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:06:07 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF670C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:06:06 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id e5so3478049wrc.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3w0cyRxbnflG1Lzaa+D9LFgBBXj2WLi8B2+0IaB0cco=;
        b=NEDNLzUZDalAufNqiXzyuBQjnHZxUNBoilJQwQfvSmQgK0oXmC8vKCNkZDGX7QCj8f
         xtZzyOs2a4ZO48mM3oad8CfwltMMFIcPiw9yaL8xg/9DpqRIV3FNDYB0GPJABPvceZxx
         kb+Svls2Iyso/lECdtqN+cvpmhawKQYVVZBpiMmFxjnQmU2NcVbyHJ7NupEKBwKFI3ho
         D613SYOBjc53L3M2O+EvZ0JjMLv4xGMQSBGRP/udeR4ro3C7u0wcSuBmhIeGYE9Ll4AG
         aluM0K2Z0cWEqEmiUFyd6NsKVRlaxKgjp7izy4Q/4SvDFUhBRVosqYT/SgjFJ8S7hF33
         7VHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3w0cyRxbnflG1Lzaa+D9LFgBBXj2WLi8B2+0IaB0cco=;
        b=ds5lGPC5CpyCibyJBl/ewhoUieuWC4xQ/FjtUy5by8b7YwsMkuihQRFtWESL8GgwuR
         SFcblVeiQqkj6PO6qLtpgrqVmqlCKU3xnaywcnOaUg702iN9CGEc5Sjvg0TvjTQ5X/pm
         1VEbN5jFgWMNEFEQBnZ+Aqig4avnN+7YJlpVdBVIeMrgXDoMhul5qgnZhIPgzOgpwwAL
         rAfohps1gr/puHnWarnI39QJfI/mZBYeAUjKg6NXuMIV5v/A2XV771pfZHaUVIPoHO/k
         CQOgwxl6I9a1ZwbL446sIVXYFKFqsFc23TCcxsgFEFuAjas/PivCFamVTsjBkJJ6KDGa
         D17g==
X-Gm-Message-State: AOAM53183q5i4ZjUX50vUA2FXvQgN7/9m6Ji4p1pS1Scq4WPVEggvPUe
        txet0NDLO0/pVKsQayGxDaM=
X-Google-Smtp-Source: ABdhPJwXgYqNw9Ycsv3CDZ5xTjRbry7kIK14E/x21CpPObe+VU0LvZpNi+zwa4CuFTHChyhAaxTF8Q==
X-Received: by 2002:a5d:51c9:: with SMTP id n9mr1419745wrv.694.1640163965465;
        Wed, 22 Dec 2021 01:06:05 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id a22sm1139775wme.19.2021.12.22.01.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 01:06:05 -0800 (PST)
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
Subject: [PATCH v2 6/6] drm/stm: ltdc: Drop format_mod_supported function
Date:   Wed, 22 Dec 2021 10:05:52 +0100
Message-Id: <20211222090552.25972-7-jose.exposito89@gmail.com>
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
 drivers/gpu/drm/stm/ltdc.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index dbdee954692a..ef909e50f0e4 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -925,16 +925,6 @@ static void ltdc_plane_atomic_print_state(struct drm_printer *p,
 	fpsi->counter = 0;
 }
 
-static bool ltdc_plane_format_mod_supported(struct drm_plane *plane,
-					    u32 format,
-					    u64 modifier)
-{
-	if (modifier == DRM_FORMAT_MOD_LINEAR)
-		return true;
-
-	return false;
-}
-
 static const struct drm_plane_funcs ltdc_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
@@ -943,7 +933,6 @@ static const struct drm_plane_funcs ltdc_plane_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
 	.atomic_print_state = ltdc_plane_atomic_print_state,
-	.format_mod_supported = ltdc_plane_format_mod_supported,
 };
 
 static const struct drm_plane_helper_funcs ltdc_plane_helper_funcs = {
-- 
2.25.1

