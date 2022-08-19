Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED8A59A7AA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 23:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352458AbiHSVY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 17:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352445AbiHSVYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 17:24:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD86BD2B3B
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660944292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eULzbfmfnyT2d1MeKBaP6Ap3rVDOs/VsOBler4qqAmU=;
        b=SrosXC7gQuq3jQccXZYmw5CGQqeeKr7DDjj3jU9e7lzO8vL7IinQ3Sb+t4r3wVss+AK1F4
        hU7ZMJfSvrjdn7hcHtBfd1AibroQphGaQHlVqOx0MhsfWQl3aUsJrRphFhnOQr5BzQs+PO
        oByqL77dKAVLwAt6jO2JopXAPQymC0A=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-61-w0MmXmGlMECu_gZHGRHUiw-1; Fri, 19 Aug 2022 17:24:50 -0400
X-MC-Unique: w0MmXmGlMECu_gZHGRHUiw-1
Received: by mail-ej1-f70.google.com with SMTP id hs4-20020a1709073e8400b0073d66965277so9618ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=eULzbfmfnyT2d1MeKBaP6Ap3rVDOs/VsOBler4qqAmU=;
        b=ZBDDhc1mVZBEtL9ZO7GDAxkfG5nOQL0NerPas6kizeica6DBQ/DKV2YDmoAq7yrRgA
         NFfQtVCBhheVV0VIiB6sEsrsNrVMWxuENC3MWl20gm1lduJ33FMXhDA8gORtbloJdsGi
         KEPRz/2jFUpKkSCRN+uVYfAoWQ9RrFxIkaKqjz3JUezrT5CkuI1J5sehrKTiZd523Uzn
         7+dv3TmQO9UPqWE1JeJH1+iwgwTm9bqYhf5QiU4Ml4R/drvLkHdpSoQ0yM8O5/+dwwAO
         CHbvpM7l+5ww6YKJ+xXdIYL8GZgY1z719hNzkePWicWSsC0fkPtNKIDQoFnEWDqmOvmO
         U3IA==
X-Gm-Message-State: ACgBeo30I5yV4bVoknWeCKgxaiXzbrIeDb+xYg9/uNgFDCGRnM5xM7/J
        FEJTs+5fIOSBMMi7gVFUk0e3UgkSPpV/RZTmS0wfr53S+hQQP7/jdITiJwXbrlT/4LB6r11eD9V
        nM8ueYvYNZgT8WndJGcwyvBb6
X-Received: by 2002:a17:907:2724:b0:730:da23:5b60 with SMTP id d4-20020a170907272400b00730da235b60mr5944566ejl.43.1660944289773;
        Fri, 19 Aug 2022 14:24:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5B90eHkyeTMFNC1i1+2xlqmaYUYa8XOKjU4q8gW3qKpLANgXl3OH3z13tEU4BMI6rGHaZNcQ==
X-Received: by 2002:a17:907:2724:b0:730:da23:5b60 with SMTP id d4-20020a170907272400b00730da235b60mr5944561ejl.43.1660944289613;
        Fri, 19 Aug 2022 14:24:49 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id k21-20020a170906579500b0072fa24c2ecbsm2842999ejq.94.2022.08.19.14.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 14:24:49 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 4/8] drm/arm/malidp: plane: use drm managed resources
Date:   Fri, 19 Aug 2022 23:24:41 +0200
Message-Id: <20220819212445.559790-2-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819212015.556220-1-dakr@redhat.com>
References: <20220819212015.556220-1-dakr@redhat.com>
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

Use drm managed resource allocation (drmm_universal_plane_alloc()) in
order to get rid of the explicit destroy hook in struct drm_plane_funcs.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/malidp_planes.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
index 815d9199752f..34547edf1ee3 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -68,14 +68,6 @@
 /* readahead for partial-frame prefetch */
 #define MALIDP_MMU_PREFETCH_READAHEAD		8
 
-static void malidp_de_plane_destroy(struct drm_plane *plane)
-{
-	struct malidp_plane *mp = to_malidp_plane(plane);
-
-	drm_plane_cleanup(plane);
-	kfree(mp);
-}
-
 /*
  * Replicate what the default ->reset hook does: free the state pointer and
  * allocate a new empty object. We just need enough space to store
@@ -260,7 +252,6 @@ static bool malidp_format_mod_supported_per_plane(struct drm_plane *plane,
 static const struct drm_plane_funcs malidp_de_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
-	.destroy = malidp_de_plane_destroy,
 	.reset = malidp_plane_reset,
 	.atomic_duplicate_state = malidp_duplicate_plane_state,
 	.atomic_destroy_state = malidp_destroy_plane_state,
@@ -972,12 +963,6 @@ int malidp_de_planes_init(struct drm_device *drm)
 	for (i = 0; i < map->n_layers; i++) {
 		u8 id = map->layers[i].id;
 
-		plane = kzalloc(sizeof(*plane), GFP_KERNEL);
-		if (!plane) {
-			ret = -ENOMEM;
-			goto cleanup;
-		}
-
 		/* build the list of DRM supported formats based on the map */
 		for (n = 0, j = 0;  j < map->n_pixel_formats; j++) {
 			if ((map->pixel_formats[j].layer & id) == id)
@@ -990,13 +975,14 @@ int malidp_de_planes_init(struct drm_device *drm)
 		/*
 		 * All the layers except smart layer supports AFBC modifiers.
 		 */
-		ret = drm_universal_plane_init(drm, &plane->base, crtcs,
-				&malidp_de_plane_funcs, formats, n,
-				(id == DE_SMART) ? linear_only_modifiers : modifiers,
-				plane_type, NULL);
-
-		if (ret < 0)
+		plane = drmm_universal_plane_alloc(drm, struct malidp_plane, base,
+						   crtcs, &malidp_de_plane_funcs, formats, n,
+						   (id == DE_SMART) ? linear_only_modifiers :
+						   modifiers, plane_type, NULL);
+		if (IS_ERR(plane)) {
+			ret = PTR_ERR(plane);
 			goto cleanup;
+		}
 
 		drm_plane_helper_add(&plane->base,
 				     &malidp_de_plane_helper_funcs);
-- 
2.37.2

