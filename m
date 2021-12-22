Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EBF47CF4C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243935AbhLVJcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243965AbhLVJcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:32:13 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73245C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:32:13 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n14-20020a7bcbce000000b00332f4abf43fso2033776wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NvzzcJBBRe/pXCF+v6jb3YyzpE8towMbOfGTpdBZYQ4=;
        b=BnJrEYeQ9lRholCvNdZWMI8IPEl4yNEEZY2A/PVkCw5OMabI0C155EKBZQeI175HHe
         JeBMsTC69yUVwaV8u0jBcZ6smXmT+Gq6vzeTLfqfCda11RI+1N2B9clIqOUusDdE9Z0M
         5/8kxne+Igj43u/I7DHNKXRMK4mJnzAGWErsqtvKsOOoets9aHa/wHbBxnBE61QIXFrf
         r4hN5nZud57HCFtIq2I7oxeCzYQMrB+dR5XAhGCr/2TCQiirARYqDbHYsztgceuMSA7r
         VmCNeiQq4xrilp1r3YmsRAtVQhT6us7BF9NTA2Egcw4oDKVubpeJfOCnfatEMjQwA5ri
         Daow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NvzzcJBBRe/pXCF+v6jb3YyzpE8towMbOfGTpdBZYQ4=;
        b=AsfUZ5PgvplxfG5CfJLhWbazAFDOKbADMkxmhqo1BoilyNaAExPfxHxfy1JkANe/J0
         uD8NosUB7Vb2/cRp4+SUN/P9vbaxTIkXxDThO5jpUSYPA/82+Qr0Ek9m60JqsdN0E8cH
         /JcDfDjL85XgvA1FyrpwsbsISzTFQz52HQkZ5tRULO9OByZAmJfFJWK/SpvljWL2WA3z
         4AbdpsI42iHgeIdrR/8gDxaUulRfgYaNWAtk5LXHCU2CbuC5vIcVKu3Cx7uFBV7Cwsyu
         qYcslNUBDs4BLcupbFpLgBfbjZ933sKApVdw4OKk+m2yfmNdHagPFA/+GWj4wx8FDXtX
         lItw==
X-Gm-Message-State: AOAM530rj2VFuQ52LLoYoWXhdrnDDJaIKXDulM0H/Qy8CLxm3VqR5/hd
        rOVgGT+1mXd8YTXElBGD8Zg=
X-Google-Smtp-Source: ABdhPJwuweZgDrINU/dFrD8OKnXvbWpbMi/js5Tbd9cPQC331MDu3TsrNa36aLhoGKKijYM4EcE/Zg==
X-Received: by 2002:a1c:7418:: with SMTP id p24mr301245wmc.82.1640165531995;
        Wed, 22 Dec 2021 01:32:11 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id k7sm1376187wrg.105.2021.12.22.01.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 01:32:11 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     contact@emersion.fr
Cc:     rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        cphealy@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 1/1] drm/vkms: set plane modifiers
Date:   Wed, 22 Dec 2021 10:32:07 +0100
Message-Id: <20211222093207.29342-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211222093207.29342-1-jose.exposito89@gmail.com>
References: <20211222093207.29342-1-jose.exposito89@gmail.com>
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
 drivers/gpu/drm/vkms/vkms_plane.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 32409e15244b..1666fa59189b 100644
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
@@ -189,7 +194,7 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 1 << index,
 					   &vkms_plane_funcs,
 					   formats, nformats,
-					   NULL, type, NULL);
+					   vkms_plane_modifiers, type, NULL);
 	if (IS_ERR(plane))
 		return plane;
 
-- 
2.25.1

