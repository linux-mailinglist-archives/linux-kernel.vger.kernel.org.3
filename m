Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACB14779DC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239870AbhLPRCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239862AbhLPRCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:02:05 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C92C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:02:05 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id i12so19349658wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RHIbexvgyxYJ1k2n4EF0wOhYX1hcCGRht3QxBaZ21nc=;
        b=Mny18kM8HNgLVeESO+lTUDXQlg6tWo66tNrwSssq4emBapLqAgY6GbjofxwTEWF/0T
         drkxtwQxoY/QQA42ZSI1HoqU1WjjZDk10dUOLwh0awplFkCP8nHeFkGAQiRNqnWOtxOH
         LiB77mhaLbJl9V4R2kvPDVnQ+VR1sm8vUuJQEqXAFNwJH5wl81LyXWlmvxb42kjT1hdT
         IYWTEEf17o3L/Yhc6849lQ+Cq+LV80YOyzA60QJUuVm5vuNYfv5/tyVJhzYza39HuXYf
         NGCqLScJYQKE2fL/7kevudbUli3VFoNjdjumVZAp1C3bfitQO8ZeRdpinhAz5ONMcjhR
         jotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RHIbexvgyxYJ1k2n4EF0wOhYX1hcCGRht3QxBaZ21nc=;
        b=EGd0wb/D4zZlWDvb4oTuPuQbiyUUnEKcIZZpTSIoQEN7egKhf+Yk4KMq80eEYimgTS
         POWdSCl2GFED88tkwyPs52EH70llHqECrRFyCSOnGFbw8v7U8mPKn5moZeu4QDZPyXJP
         DWEZYFWqMutessEDMyKZyUkNWeFr8MEFPwkmL4Z/x11yEKrgfAxCz/6eeI2enptNpqQ6
         CDS1KRKCmcY3+Ls2KkleHrLbqBQeUk5nblSieKtM6MyEHK4aM9AVAFeLMTePtAE+vF7z
         ZITQap5tUjz3jDe89nnLwUlUcxV+LR2E9ubIzC8u/S16qJToxWs8+/DddWFbfcBo3VIU
         iEow==
X-Gm-Message-State: AOAM533ULUiDg9EQ3+Hn0wkW7IJDlSw6mVbuw5r81v76DZbM8MJMmg4K
        RURSgIrXJKEr+qAHPyJDI/4=
X-Google-Smtp-Source: ABdhPJytLEeaQza+C4ISdN62zhwLhTua7exk5e1Pc1JpDVRvTsi2wpmFBiglcvYzGnBhS1qFlcckEQ==
X-Received: by 2002:a05:600c:4e56:: with SMTP id e22mr5615636wmq.39.1639674123673;
        Thu, 16 Dec 2021 09:02:03 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id n10sm5452472wri.67.2021.12.16.09.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 09:02:03 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     rodrigosiqueiramelo@gmail.com
Cc:     melissa.srw@gmail.com, hamohammed.sa@gmail.com, daniel@ffwll.ch,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, cphealy@gmail.com,
        contact@emersion.fr,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 2/2] drm/vkms: set plane modifiers
Date:   Thu, 16 Dec 2021 18:01:40 +0100
Message-Id: <20211216170140.15803-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211216170140.15803-1-jose.exposito89@gmail.com>
References: <20211216170140.15803-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Where no modifiers are exposed, usually linear modifier is assumed.
However, userspace code is starting to expect IN_FORMATS even when the
only supported modifiers are linear [1].

To avoid possible issues, explicitly set the DRM_FORMAT_MOD_LINEAR
modifier.

[1] https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/599/diffs?commit_id=5aea1bc522f0874e6cc07f5120fbcf1736706536

Suggested-by: Chris Healy <cphealy@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>

---

v2: Implement format_mod_supported (Simon Ser)
---
 drivers/gpu/drm/vkms/vkms_plane.c | 34 ++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 76a06dd92ac1..7e0d021494c3 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -20,6 +20,11 @@ static const u32 vkms_plane_formats[] = {
 	DRM_FORMAT_XRGB8888
 };
 
+static const u64 vkms_plane_modifiers[] = {
+	DRM_FORMAT_MOD_LINEAR,
+	DRM_FORMAT_MOD_INVALID
+};
+
 static struct drm_plane_state *
 vkms_plane_duplicate_state(struct drm_plane *plane)
 {
@@ -100,12 +105,39 @@ static void vkms_formats_for_plane_type(enum drm_plane_type type,
 	}
 }
 
+static bool vkms_format_mod_supported(struct drm_plane *plane, u32 format,
+				      u64 modifier)
+{
+	bool modifier_found = false;
+	unsigned int i;
+	const u32 *formats;
+	int nformats;
+
+	for (i = 0; i < ARRAY_SIZE(vkms_plane_modifiers) - 1; i++) {
+		if (vkms_plane_modifiers[i] == modifier)
+			modifier_found = true;
+	}
+
+	if (!modifier_found)
+		return false;
+
+	vkms_formats_for_plane_type(plane->type, &formats, &nformats);
+
+	for (i = 0; i < nformats; i++) {
+		if (formats[i] == format)
+			return true;
+	}
+
+	return false;
+}
+
 static const struct drm_plane_funcs vkms_plane_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
 	.reset			= vkms_plane_reset,
 	.atomic_duplicate_state = vkms_plane_duplicate_state,
 	.atomic_destroy_state	= vkms_plane_destroy_state,
+	.format_mod_supported	= vkms_format_mod_supported,
 };
 
 static void vkms_plane_atomic_update(struct drm_plane *plane,
@@ -190,7 +222,7 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 1 << index,
 					   &vkms_plane_funcs,
 					   formats, nformats,
-					   NULL, type, NULL);
+					   vkms_plane_modifiers, type, NULL);
 	if (IS_ERR(plane))
 		return plane;
 
-- 
2.25.1

