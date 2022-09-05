Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9608C5AD626
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238835AbiIEPUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238847AbiIEPTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:19:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E19E11165
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662391169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eULzbfmfnyT2d1MeKBaP6Ap3rVDOs/VsOBler4qqAmU=;
        b=cuhucCBUjoWYaBcx5qWRl67QLv8W0b/g5xMUcjxkGrkvrVn4G1I6XVKoHQI+g9k9hjfseY
        hPbcD/2gTaIbFWmPc+lDyGaOEJ9TZKE/wwdkJaT3IWCWZuo351NZpNXO93HfJsp0Gk7BwP
        gJU+lQidamycG3ae50rsP7FQitVRK9I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-604-rGbAXr9CMq-POhIFwFtzbQ-1; Mon, 05 Sep 2022 11:19:28 -0400
X-MC-Unique: rGbAXr9CMq-POhIFwFtzbQ-1
Received: by mail-wm1-f72.google.com with SMTP id j19-20020a05600c1c1300b003ab73e4c45dso5197363wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 08:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=eULzbfmfnyT2d1MeKBaP6Ap3rVDOs/VsOBler4qqAmU=;
        b=JbPFuIfA7/VlAfgeIPx+R07cepoMUgmkdpgtMLUF9GlkZ7Vi8nOrDvOBshuMj0AfOL
         ysfXI2Cegn/7cEs4ZoVNYmcKDykV1eyL+rPP38Ht4o2wxvjEBd/3ZvyJ/VXgcNYCplX4
         Dij0jN3biOfq3ohNCTWBOVsZA/GPalj0lnegWrgto8SV59pe6EuwpOU4xlXP13UKJNA8
         jdL7yBtIUrNHnxU6Kw5FfqSt332JdY+HZSi/a7h9JNg1N+/t6OUvFtmup4dmsFyYT9aO
         VA+AGBRrfydwPqTR9j8CNnVwYrpG8vPnztmXVJ+J4lnR6vQf2KeBdjuxJzaM/kJGB4he
         LnjA==
X-Gm-Message-State: ACgBeo3Pl4hAU5wIBDE7c4AeEuQoVlyrQ0pP+O5SxJ/jZG+K1Q8/8uBc
        jP5fcXsuxUbA0h8nZbNuqyN78fqInqYIV6iL/VPBJ0oLPxgIB6f2Mt4vyUYTsqaGWLuvMXi92It
        ZuVWWUFGYjo8yCDKfIYlzzf1i
X-Received: by 2002:a05:600c:290a:b0:3a5:515d:4f69 with SMTP id i10-20020a05600c290a00b003a5515d4f69mr10953081wmd.127.1662391167195;
        Mon, 05 Sep 2022 08:19:27 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7xYW3E2/dKGrGQybWNRmjEQXRIlyGBB+beFjcq1u15evJ3hzay5dMZBpfGjmcYbVGnUOV1Pw==
X-Received: by 2002:a05:600c:290a:b0:3a5:515d:4f69 with SMTP id i10-20020a05600c290a00b003a5515d4f69mr10953071wmd.127.1662391166968;
        Mon, 05 Sep 2022 08:19:26 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id t4-20020a05600001c400b00228aea99efcsm2209641wrx.14.2022.09.05.08.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 08:19:26 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND drm-misc-next 4/8] drm/arm/malidp: plane: use drm managed resources
Date:   Mon,  5 Sep 2022 17:19:06 +0200
Message-Id: <20220905151910.98279-5-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220905151910.98279-1-dakr@redhat.com>
References: <20220905151910.98279-1-dakr@redhat.com>
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

