Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8309E599A82
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 13:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348596AbiHSLJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 07:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348631AbiHSLJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:09:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205BBE0965
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 04:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660907338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bnEk9MrA+hzYjtEm67vAGY8w0ZNE3V5OyctQYUJSNY0=;
        b=hLkMJEmOD9zC3F1sQyn/BesfqUgsykoLzpZPrh11J+3BzJSpBwNZr7QOYvQeLybEsD71/7
        FfSyBf+Mc6bY5+ejPpukWXwpzpwOcDNKlNcxNWyvUUnDSCejPUezJOdyMNrqNcPQ73a5fF
        a9xTXFTyemtpkU6husctaALk+CRUs7I=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-591-3bfQ_EyZMZqkO9HOfZVrMQ-1; Fri, 19 Aug 2022 07:08:57 -0400
X-MC-Unique: 3bfQ_EyZMZqkO9HOfZVrMQ-1
Received: by mail-ed1-f70.google.com with SMTP id t13-20020a056402524d00b0043db1fbefdeso2638782edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 04:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bnEk9MrA+hzYjtEm67vAGY8w0ZNE3V5OyctQYUJSNY0=;
        b=lYz9iPwehGZFG3Z5dBc6+BkuXs9owyQuhiUag/RgkPYp39rEPnV4GOK2SOcbER2DWH
         rQXk1el0GW/jjHygIrLE6Xq8uiqUJcZJkLWQ7YZ0PuV3/+LlVpCm37vPnqS2THks00aI
         CyjbPl295NMDLYdzqQEt+rRP3XJjcoStA2rkNaBY7QNzQS1jgbPnyF2iYJ4eCmuDgoqj
         9okpOig+ZLxknIFlDTAV6zbYhBBxc+cdomuxy+9GSvZNqnIRJqOcGwMpqB8CUjOWZvh6
         eyulY18KMNHh8uMt3udyAd/QMV8krxCxEUeeJlYK0KgaP74u1C60QgY2gywphGZ1UmFp
         s11g==
X-Gm-Message-State: ACgBeo03e8jOrXedtMuqf4ZIE6e/ow0JQ4ebK6tOsXSLtKsdAkaGLvg+
        LxdwZzoEoaZirA1Zt7bpfO6keNf9OmV2GMeuo0ptnE+vaauMJBp1meyHIkb+NTSLecYpsm67O32
        Ex7zaztoI4qE8RmRo4esCHpxm
X-Received: by 2002:a17:907:9694:b0:73c:4e5c:fd33 with SMTP id hd20-20020a170907969400b0073c4e5cfd33mr3189984ejc.331.1660907336024;
        Fri, 19 Aug 2022 04:08:56 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7IFFav8FqlP0liaFDWjQPBAHizE1g8lUigMsowQvbddBjddRYveYE9uBswm+NtsueITuzvIQ==
X-Received: by 2002:a17:907:9694:b0:73c:4e5c:fd33 with SMTP id hd20-20020a170907969400b0073c4e5cfd33mr3189971ejc.331.1660907335876;
        Fri, 19 Aug 2022 04:08:55 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id l17-20020a1709060cd100b007308fab3eb7sm2167827ejh.195.2022.08.19.04.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 04:08:55 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 2/4] drm/vc4: plane: protect device resources after removal
Date:   Fri, 19 Aug 2022 13:08:47 +0200
Message-Id: <20220819110849.192037-3-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819110849.192037-1-dakr@redhat.com>
References: <20220819110849.192037-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
index eff9c63adfa7..c46acb770036 100644
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
 
@@ -1245,6 +1253,7 @@ void vc4_plane_async_set_fb(struct drm_plane *plane, struct drm_framebuffer *fb)
 	struct vc4_plane_state *vc4_state = to_vc4_plane_state(plane->state);
 	struct drm_gem_dma_object *bo = drm_fb_dma_get_gem_obj(fb, 0);
 	uint32_t addr;
+	int idx;
 
 	/* We're skipping the address adjustment for negative origin,
 	 * because this is only called on the primary plane.
@@ -1252,12 +1261,17 @@ void vc4_plane_async_set_fb(struct drm_plane *plane, struct drm_framebuffer *fb)
 	WARN_ON_ONCE(plane->state->crtc_x < 0 || plane->state->crtc_y < 0);
 	addr = bo->dma_addr + fb->offsets[0];
 
+	if (!drm_dev_enter(plane->dev, &idx))
+		return;
+
 	/* Write the new address into the hardware immediately.  The
 	 * scanout will start from this address as soon as the FIFO
 	 * needs to refill with pixels.
 	 */
 	writel(addr, &vc4_state->hw_dlist[vc4_state->ptr0_offset]);
 
+	drm_dev_exit(idx);
+
 	/* Also update the CPU-side dlist copy, so that any later
 	 * atomic updates that don't do a new modeset on our plane
 	 * also use our updated address.
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

