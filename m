Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B5B4779DA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239857AbhLPRCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhLPRCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:02:03 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37759C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:02:03 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id i12so19349596wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Axe4Q9VXvpGCP1w03oKYpmEgDNQia2jUa2INQifyMYg=;
        b=JnUskR6BQSx107PSNjQbFwC/egoZKWvzdtEKNpoEOvAysW1fM+UaksTnVw1zAJv45Q
         blVtyxzcM+gIQEv0XcennrIDlLGZ3x0h1D325REsRQCK2P+5UoLgMLuDHx7gxvnV2zt6
         YECEfteZqW+PXKPurXESEjbHSSjeA9ZS7CxlDARUK8T9F1dfcLAnib/Uh3WBhu6tgU+K
         na0ZZhrjI3TfsiFHOmm0HrWY9ZTMk+zncmkrr7Kc2TLs24yVUaMvEJa+X7cEkopuMbBN
         7f9tBr9qIELlIsKX7yR+QMwW8tIJ/mC1/cboxPH60la/L3MWL1WypHthAgDMe6I7GUIu
         sEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Axe4Q9VXvpGCP1w03oKYpmEgDNQia2jUa2INQifyMYg=;
        b=zBVeIE2lWfbKepB1coOUv1hpZTG0IjTPb3fm81MubGTKXai6IU09kZkBB6PQGcL4/Y
         LJrJ/f7gMj8hsYJ9GFhy/6ghXZqSFq1M74Qjf0Zqe2C7cJrK94IoqCV/XwZvyh2vKy09
         qRU01PvM9M8fBpx2KDR8B6ZhwzG0KeVChoiZ7CZcK7RxfjaxBMD1TNQT8Mwy5R/Eu4Hy
         trx7sFSMuvAXWo4z4SPkB4yHZXRtM1S6xOm8ujk1aOELToUHcbjTgvXMZyzw1C6zR+/Y
         3ElZAw+CghYkAe3XzwNTLdRoN6BDOLwq6bmoOJzM4T64TekZx9L+V0qtamQvVG3tMfdn
         y53w==
X-Gm-Message-State: AOAM532SBWFK4hZ+glTvRBw3lvNTQlkQ70u8bdPOJ+R+5M7P0ZPjllxe
        dkZtm4xRxt33exYGUOSBQfo=
X-Google-Smtp-Source: ABdhPJyZR9qKxhXWhLSPZaa52rhCTCx7Oj3ZEeDXV7onBiivQ4yQXVK574JzTm6Dy+Uqi8ND6aP6nA==
X-Received: by 2002:a05:600c:350a:: with SMTP id h10mr5786912wmq.62.1639674121776;
        Thu, 16 Dec 2021 09:02:01 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id n10sm5452472wri.67.2021.12.16.09.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 09:02:01 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     rodrigosiqueiramelo@gmail.com
Cc:     melissa.srw@gmail.com, hamohammed.sa@gmail.com, daniel@ffwll.ch,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, cphealy@gmail.com,
        contact@emersion.fr,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 1/2] drm/vkms: add function to get plane formats
Date:   Thu, 16 Dec 2021 18:01:39 +0100
Message-Id: <20211216170140.15803-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the logic to get the plane formats depending on the plane type to
its own function.
Refactor, no functional changes.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_plane.c | 37 ++++++++++++++++---------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 32409e15244b..76a06dd92ac1 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -83,6 +83,23 @@ static void vkms_plane_reset(struct drm_plane *plane)
 	__drm_gem_reset_shadow_plane(plane, &vkms_state->base);
 }
 
+static void vkms_formats_for_plane_type(enum drm_plane_type type,
+					const u32 **formats, int *nformats)
+{
+	switch (type) {
+	case DRM_PLANE_TYPE_CURSOR:
+	case DRM_PLANE_TYPE_OVERLAY:
+		*formats = vkms_plane_formats;
+		*nformats = ARRAY_SIZE(vkms_plane_formats);
+		break;
+	case DRM_PLANE_TYPE_PRIMARY:
+	default:
+		*formats = vkms_formats;
+		*nformats = ARRAY_SIZE(vkms_formats);
+		break;
+	}
+}
+
 static const struct drm_plane_funcs vkms_plane_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
@@ -167,24 +184,8 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 	const u32 *formats;
 	int nformats;
 
-	switch (type) {
-	case DRM_PLANE_TYPE_PRIMARY:
-		formats = vkms_formats;
-		nformats = ARRAY_SIZE(vkms_formats);
-		funcs = &vkms_primary_helper_funcs;
-		break;
-	case DRM_PLANE_TYPE_CURSOR:
-	case DRM_PLANE_TYPE_OVERLAY:
-		formats = vkms_plane_formats;
-		nformats = ARRAY_SIZE(vkms_plane_formats);
-		funcs = &vkms_primary_helper_funcs;
-		break;
-	default:
-		formats = vkms_formats;
-		nformats = ARRAY_SIZE(vkms_formats);
-		funcs = &vkms_primary_helper_funcs;
-		break;
-	}
+	funcs = &vkms_primary_helper_funcs;
+	vkms_formats_for_plane_type(type, &formats, &nformats);
 
 	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 1 << index,
 					   &vkms_plane_funcs,
-- 
2.25.1

