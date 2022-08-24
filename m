Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BBB59FF3B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239084AbiHXQOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238866AbiHXQNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:13:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE5C95693
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661357621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=shnv9nDHn9uoBkujzrrhLdUD67s9BTHB9Z1Ctk5SIAU=;
        b=EilJvXk5fEFZiZP0abYFOD0Xa7QTuFAiTeM3sLmYu3LKfnUURIcIGwOu7xDReveBLBNoYU
        JGtkys1emaP4d1BGYHGXMmBek/6QAW6AEE6oaIALiZtgwYPAzYIWqapsMVKy0TRKS+WjUC
        if51DBmOryRYrYRROon+Ph5SAL8RELo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-530-sxSjnjeoMcWXdV42mum21g-1; Wed, 24 Aug 2022 12:13:40 -0400
X-MC-Unique: sxSjnjeoMcWXdV42mum21g-1
Received: by mail-ej1-f69.google.com with SMTP id gs35-20020a1709072d2300b00730e14fd76eso5397993ejc.15
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=shnv9nDHn9uoBkujzrrhLdUD67s9BTHB9Z1Ctk5SIAU=;
        b=LR/Q4n7a2gBXDyH1JZ5HcwcHQVabMZKLABivURijTrtQcmZ5S5oC8j+2iR6n8PW4Z5
         M+KkhRss5EvYoJRYRIkIJSk/ArH12+ZKBw2KMbG5JLcezI3+gIrBRei4aFuTjF9m954X
         YVEwA7HtNUY9HkHsvRHOzspDMw5D80DHcfXoVN+5pxfC10papTGY2Yqn2TVz38JyFtEt
         Elqmlb0Bg19tfAznOK5MLFyGF4CWN7ooEekH5qNlYlgAprCrUlEjrzzez7Ww5V0JzVn8
         M6nDsjMpJC+GNr2U2gzZSrKr8mz/0LcLM2CREWWt+GtJA3hv+GxpZzXGn7aXWLU3ew7w
         xH0g==
X-Gm-Message-State: ACgBeo2INleFIOFCXIyLtyXDsnU7YBa7vpQpcRvPqEfrwYHfyoByskXk
        YiDRGcY628utXBOVKzs0x7yXH2ZADW1o+/fGnvOKGLw9LTFI4UTiFvgQ26SSiLxEPHJTW9zJQ5e
        wyXDZNZju8QhItCJKZe9rcVME
X-Received: by 2002:a17:907:b06:b0:73d:c534:1ac3 with SMTP id h6-20020a1709070b0600b0073dc5341ac3mr1007072ejl.194.1661357618758;
        Wed, 24 Aug 2022 09:13:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR51vE5rD3Cnr43VGXz6apFS+AbCm8Q7NybadVKzLFntNtPDrnwpSizgYigjC19GqW+ewQ6s0Q==
X-Received: by 2002:a17:907:b06:b0:73d:c534:1ac3 with SMTP id h6-20020a1709070b0600b0073dc5341ac3mr1007059ejl.194.1661357618587;
        Wed, 24 Aug 2022 09:13:38 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id j2-20020a170906410200b007308bdef04bsm1359102ejk.103.2022.08.24.09.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 09:13:38 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v3 2/4] drm/vc4: plane: protect device resources after removal
Date:   Wed, 24 Aug 2022 18:13:25 +0200
Message-Id: <20220824161327.330627-3-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220824161327.330627-1-dakr@redhat.com>
References: <20220824161327.330627-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Hardware) resources which are bound to the driver and device lifecycle
must not be accessed after the device and driver are unbound.

However, the DRM device isn't freed as long as the last user closed it,
hence userspace can still call into the driver.

Therefore protect the critical sections which are accessing those
resources with drm_dev_enter() and drm_dev_exit().

Fixes: 9872c7a31921 ("drm/vc4: plane: Switch to drmm_universal_plane_alloc()")
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/vc4/vc4_plane.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index eff9c63adfa7..8b92a45a3c89 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -19,6 +19,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_blend.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
@@ -1219,6 +1220,10 @@ u32 vc4_plane_write_dlist(struct drm_plane *plane, u32 __iomem *dlist)
 {
 	struct vc4_plane_state *vc4_state = to_vc4_plane_state(plane->state);
 	int i;
+	int idx;
+
+	if (!drm_dev_enter(plane->dev, &idx))
+		goto out;
 
 	vc4_state->hw_dlist = dlist;
 
@@ -1226,6 +1231,9 @@ u32 vc4_plane_write_dlist(struct drm_plane *plane, u32 __iomem *dlist)
 	for (i = 0; i < vc4_state->dlist_count; i++)
 		writel(vc4_state->dlist[i], &dlist[i]);
 
+	drm_dev_exit(idx);
+
+out:
 	return vc4_state->dlist_count;
 }
 
@@ -1245,6 +1253,10 @@ void vc4_plane_async_set_fb(struct drm_plane *plane, struct drm_framebuffer *fb)
 	struct vc4_plane_state *vc4_state = to_vc4_plane_state(plane->state);
 	struct drm_gem_dma_object *bo = drm_fb_dma_get_gem_obj(fb, 0);
 	uint32_t addr;
+	int idx;
+
+	if (!drm_dev_enter(plane->dev, &idx))
+		return;
 
 	/* We're skipping the address adjustment for negative origin,
 	 * because this is only called on the primary plane.
@@ -1263,6 +1275,8 @@ void vc4_plane_async_set_fb(struct drm_plane *plane, struct drm_framebuffer *fb)
 	 * also use our updated address.
 	 */
 	vc4_state->dlist[vc4_state->ptr0_offset] = addr;
+
+	drm_dev_exit(idx);
 }
 
 static void vc4_plane_atomic_async_update(struct drm_plane *plane,
@@ -1271,6 +1285,10 @@ static void vc4_plane_atomic_async_update(struct drm_plane *plane,
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
 										 plane);
 	struct vc4_plane_state *vc4_state, *new_vc4_state;
+	int idx;
+
+	if (!drm_dev_enter(plane->dev, &idx))
+		return;
 
 	swap(plane->state->fb, new_plane_state->fb);
 	plane->state->crtc_x = new_plane_state->crtc_x;
@@ -1333,6 +1351,8 @@ static void vc4_plane_atomic_async_update(struct drm_plane *plane,
 	       &vc4_state->hw_dlist[vc4_state->pos2_offset]);
 	writel(vc4_state->dlist[vc4_state->ptr0_offset],
 	       &vc4_state->hw_dlist[vc4_state->ptr0_offset]);
+
+	drm_dev_exit(idx);
 }
 
 static int vc4_plane_atomic_async_check(struct drm_plane *plane,
-- 
2.37.2

