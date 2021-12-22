Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0DC47CECB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243696AbhLVJGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243726AbhLVJGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:06:04 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE53C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:06:03 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id e5so3477765wrc.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2sH9LpoHKM1nYuCNdjrxssHqCL8Z5G+nLzADIXmtmn8=;
        b=UipR0N0vfloKnycnLvsHhkmUXID+a0gQSazt/YOOR2lytH2a1gIPVbSVGExE0igs+r
         jekZBCIM4ERZoOESF8YT+xqxsPxjJX6ao8gc3DLIgEz6u4VxUZKP/QWvVLh2/k1tTFVF
         RqZI7l0W9CaC7Is+KWojXzkwg6U0Zk4C0Swdg3QHsoP9hxcvBAG6FSDnmL+KljKT0Vhu
         utXR9E+GV0l9WHj+A+wj+gZz8oUo7US1imEVJt0zSOfEv8XdF9HYFeplt3JgJSXAOc13
         MQmKMU48hY+PocHZHlpYKnPWsE8PE0yiIUICdSV12SyCW2C+NB/bdWoMn+k6XUlky22m
         uEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2sH9LpoHKM1nYuCNdjrxssHqCL8Z5G+nLzADIXmtmn8=;
        b=tftip5PFjfMwHK6PSU557tqVv3y+8R6O7pDLA97YIQBcKMGXDXcsuRwe8ezVvAKxvV
         92OOuUyG0rSfPibHPXEow05vVVpOWEiQCKYv+NPmT3OEy6pKM37M/I1Zt2WK3pgjh8JC
         QD9diFgv9LbiAPtd8BLEFaxyUGAgomHWla8C49g1ConqL9zt4FtmRXjKXVMZwjAHGyuG
         F2lKJZeIZlIXrApW/jmMHA4leOBItekv6Qe26SGlu9f67gjorU9U/X8mK0wWcqXGTJH/
         ExCJvsS8mVY1mb5xSYuqwpbhBTqBC8fj45cn7rTkO/w14N1eJmo313+L8aae2KSE7yUM
         MLjg==
X-Gm-Message-State: AOAM531WuSqAaFFUAwAgEykyDtv+KSw/jpPDRFUWNMr5dDyW2PlzDSaC
        xQ39UKLaEmpSokML8BeQFYA=
X-Google-Smtp-Source: ABdhPJw8+ku6Bbt0pa4KdLw4youWpS/O8Jg1GVf6A0XhbJGF74Z2ipnLZF9sGtjl6ocwS7qMUyGAzA==
X-Received: by 2002:adf:e0c8:: with SMTP id m8mr1505861wri.113.1640163962523;
        Wed, 22 Dec 2021 01:06:02 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id a22sm1139775wme.19.2021.12.22.01.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 01:06:02 -0800 (PST)
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
Subject: [PATCH v2 4/6] drm/i915/display: Drop format_mod_supported function
Date:   Wed, 22 Dec 2021 10:05:50 +0100
Message-Id: <20211222090552.25972-5-jose.exposito89@gmail.com>
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

