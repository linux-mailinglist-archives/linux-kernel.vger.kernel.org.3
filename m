Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFF0502B91
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 16:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354326AbiDOOQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 10:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236542AbiDOOQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 10:16:34 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B43CEE1B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 07:14:03 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id z8so8510524oix.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 07:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ne77m8cZZW0R7+jQl5DIOLbM38uI8W7ZFAvs8zlnbN8=;
        b=h1AEH94ksvbHDBFe3x+a7vmDgmwHtOTnxwprQwUj4X1Nmdvg1vWefYUVfwtkHjfOhv
         HDBUNoMaooGxk+7pisSLbT50fMO43493JfXXGe1JkBL4xDXrK1H5O0Xq3Z0rI1Np2Gum
         tGFZ+dFeiSq6PxqPTbRbrbbUyryHeeNaxHgPuJCF+jV80j6YnZG9lidImPuqYc4Fk1CU
         b8X7OOSzA5dXiqW6pqu7vLlfMTGvQ3i/W/m7avQlpXvChMg8bwMZR+5/+kybThxsGnTj
         HXopgsjM58efO1m+fJxy9vuEj+l0L6fRrn0ExSVCs/8UWenBQaE1wJhhUlcfW/LB9FL1
         QD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ne77m8cZZW0R7+jQl5DIOLbM38uI8W7ZFAvs8zlnbN8=;
        b=aH4B4qBfG6YWxfbC0cDun944mg7EHdmCHXqD8RjeGzlRHFT617Cuz2Po92GFVAppUl
         0H0EdWH3AETn9P1/rlH8Htrrx0HuQwv7TPOfTTQXenwswHqDLfSJHvVzhYK5egAdJIZn
         49m4VD6gunmMtUQM3qgbS2FpvQ94Xqjv08bRZLaQdE8ymMyykyC1sy0V72bVuw16VBA9
         u4pxR9knLZBWBI0HyZb5Z5nDn9Qc6jc4g6yGG3ebQfr/Y4CILz7NBM/tXSyv2zR9YpN9
         z1iDuVwfrte1f19bSwFrkvpk15lZg+2OpqC+frobLKx9ukIyVPDZUDXriXIbbuhAze1d
         rm9g==
X-Gm-Message-State: AOAM5328FpGCmM1h3BN8YUlhUmBBVm1+SzNMzilAGnWuzD+1cAbqyoNy
        zR5BlcGQp1vakzTISQ2Q2Qo=
X-Google-Smtp-Source: ABdhPJzmIliimBoMo5RTzw1NZHdZ598Yqfbe2K4rgL5RQgz1CujBydm9kLuTJhT4SOwwYRnQKEfqmA==
X-Received: by 2002:a05:6808:d4c:b0:2f8:d0d2:d06c with SMTP id w12-20020a0568080d4c00b002f8d0d2d06cmr1672959oik.285.1650032043019;
        Fri, 15 Apr 2022 07:14:03 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8a9b:dcc3:45ee:2581:b4cb])
        by smtp.gmail.com with ESMTPSA id x1-20020a4ae781000000b00320d5d238efsm1156189oov.3.2022.04.15.07.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 07:14:02 -0700 (PDT)
From:   Tales Lelo da Aparecida <tales.aparecida@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        andrealmeid@riseup.net
Cc:     Tales Lelo da Aparecida <tales.aparecida@gmail.com>
Subject: [PATCH v2 2/2] drm/vkms: return early if compose_plane fails
Date:   Fri, 15 Apr 2022 08:13:00 -0300
Message-Id: <20220415111300.61013-3-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415111300.61013-1-tales.aparecida@gmail.com>
References: <20220415111300.61013-1-tales.aparecida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not exit quietly from compose_plane. If any plane has an invalid
map, propagate the error value upwards. While here, add log messages
for the invalid index.

Signed-off-by: Tales Lelo da Aparecida <tales.aparecida@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 30 ++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index b47ac170108c..c0a3b53cd155 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -149,16 +149,16 @@ static void blend(void *vaddr_dst, void *vaddr_src,
 	}
 }
 
-static void compose_plane(struct vkms_composer *primary_composer,
-			  struct vkms_composer *plane_composer,
-			  void *vaddr_out)
+static int compose_plane(struct vkms_composer *primary_composer,
+			 struct vkms_composer *plane_composer,
+			 void *vaddr_out)
 {
 	struct drm_framebuffer *fb = &plane_composer->fb;
 	void *vaddr;
 	void (*pixel_blend)(const u8 *p_src, u8 *p_dst);
 
 	if (WARN_ON(iosys_map_is_null(&plane_composer->map[0])))
-		return;
+		return -EINVAL;
 
 	vaddr = plane_composer->map[0].vaddr;
 
@@ -168,6 +168,8 @@ static void compose_plane(struct vkms_composer *primary_composer,
 		pixel_blend = &x_blend;
 
 	blend(vaddr_out, vaddr, primary_composer, plane_composer, pixel_blend);
+
+	return 0;
 }
 
 static int compose_active_planes(void **vaddr_out,
@@ -177,7 +179,7 @@ static int compose_active_planes(void **vaddr_out,
 	struct drm_framebuffer *fb = &primary_composer->fb;
 	struct drm_gem_object *gem_obj = drm_gem_fb_get_obj(fb, 0);
 	const void *vaddr;
-	int i;
+	int i, ret;
 
 	if (!*vaddr_out) {
 		*vaddr_out = kzalloc(gem_obj->size, GFP_KERNEL);
@@ -187,8 +189,10 @@ static int compose_active_planes(void **vaddr_out,
 		}
 	}
 
-	if (WARN_ON(iosys_map_is_null(&primary_composer->map[0])))
+	if (WARN_ON(iosys_map_is_null(&primary_composer->map[0]))) {
+		DRM_DEBUG_DRIVER("Failed to compose. Invalid map in the primary plane.");
 		return -EINVAL;
+	}
 
 	vaddr = primary_composer->map[0].vaddr;
 
@@ -198,10 +202,16 @@ static int compose_active_planes(void **vaddr_out,
 	 * planes should be in z-order and compose them associatively:
 	 * ((primary <- overlay) <- cursor)
 	 */
-	for (i = 1; i < crtc_state->num_active_planes; i++)
-		compose_plane(primary_composer,
-			      crtc_state->active_planes[i]->composer,
-			      *vaddr_out);
+	for (i = 1; i < crtc_state->num_active_planes; i++) {
+		ret = compose_plane(primary_composer,
+				    crtc_state->active_planes[i]->composer,
+				    *vaddr_out);
+		if (ret) {
+			DRM_DEBUG_DRIVER("Failed to compose. Invalid map in the active_planes[%d].",
+					 i);
+			return ret;
+		}
+	}
 
 	return 0;
 }
-- 
2.35.1

