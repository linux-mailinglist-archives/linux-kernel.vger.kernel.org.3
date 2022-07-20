Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E35E57B805
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 16:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiGTOC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 10:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbiGTOCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 10:02:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33EED31935
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658325743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f5+OHAHK2VLcrnL1KSJdq9/Govt0hy/raOewuyTrtrI=;
        b=ET0knCLbK+yffzio3n8pQscO9fJMGskue73iVOKPAKdk6+Iglc6wde8Hk0EKpCmwaeQJ89
        SFHNDCLGWu7aSOIiBD/f2ektz39nosl9Z7vUjvuN5n5q5RU4jf3+NqBGmX9aloDMiT/M1F
        n4SWYgTvYdx4PTZHi8CNRh2EGzwckHE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-rUYPWwNxPyy9rw-c7mujpQ-1; Wed, 20 Jul 2022 10:02:22 -0400
X-MC-Unique: rUYPWwNxPyy9rw-c7mujpQ-1
Received: by mail-ed1-f70.google.com with SMTP id m13-20020a056402430d00b0043ac2f27d83so12352064edc.20
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f5+OHAHK2VLcrnL1KSJdq9/Govt0hy/raOewuyTrtrI=;
        b=P9hKpYKYCUMBHNDtZeHCPCeBXiV8YKkLVhpqv2SSQBihPfzd1IJaQZ4KjGM6xz4POI
         U/yNSN8KM8zqO9SaIHAJPBg1EkBEAX0QtJLLiJrRABznlPKIC7tKEjMz1CimNmYFo18o
         H4d8RX+6Uztvl14TFlJPDPCxSQHTZolC9RZNjR54YMxeA0cfBHWqeQ5gu/Q/n5pif+6c
         +CZ9FYsOB+MtMHST0493ooSniylaGTEOQ6t4d+bOpLVAm//ZN0W7Lk846i9zyvCkKHJx
         JaSnIOSfQ7x4mk8K2dL5RaXoHFxNNAsjTwURCXF9uO/bs2L7ikWy0ruzriOx3dP2+4l7
         FbhQ==
X-Gm-Message-State: AJIora9VcBJOvyP01s0JozwNQ0QySxQshM72HXlTVt3t/4BbdgkHFSKK
        cHxgkmU50fUP4cFj5hIgwKDimJOuKkaUhtOrDkw5qLKQEeLoikZD/Nr7GQbO8oeuOVYRUN4n1n5
        BmaLHvYvJNFJiPK1zrLvkseRo
X-Received: by 2002:a17:907:2e02:b0:72b:7f58:34a7 with SMTP id ig2-20020a1709072e0200b0072b7f5834a7mr35386128ejc.525.1658325740929;
        Wed, 20 Jul 2022 07:02:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vq2IV3yyjMp7raLEq7mPapfKG0of5mKXfvebNU8xf13qtjH+eOAFM2FVlEqO4W2e6ym12V8w==
X-Received: by 2002:a17:907:2e02:b0:72b:7f58:34a7 with SMTP id ig2-20020a1709072e0200b0072b7f5834a7mr35386116ejc.525.1658325740745;
        Wed, 20 Jul 2022 07:02:20 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906560d00b006fee98045cdsm8053040ejq.10.2022.07.20.07.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 07:02:20 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@linux.ie, daniel@ffwll.ch, kraxel@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND 1/2] drm/virtio: plane: use drm managed resources
Date:   Wed, 20 Jul 2022 16:02:13 +0200
Message-Id: <20220720140214.199492-2-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220720140214.199492-1-dakr@redhat.com>
References: <20220720140214.199492-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use drm managed resource allocation (drmm_universal_plane_alloc()) in
order to cleanup/simplify drm plane .destroy callback.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 30 +++++++-------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 6d3cc9e238a4..3008551d6a05 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -67,16 +67,10 @@ uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc)
 	return format;
 }
 
-static void virtio_gpu_plane_destroy(struct drm_plane *plane)
-{
-	drm_plane_cleanup(plane);
-	kfree(plane);
-}
-
 static const struct drm_plane_funcs virtio_gpu_plane_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
-	.destroy		= virtio_gpu_plane_destroy,
+	.destroy		= drm_plane_cleanup,
 	.reset			= drm_atomic_helper_plane_reset,
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
@@ -379,11 +373,7 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
 	const struct drm_plane_helper_funcs *funcs;
 	struct drm_plane *plane;
 	const uint32_t *formats;
-	int ret, nformats;
-
-	plane = kzalloc(sizeof(*plane), GFP_KERNEL);
-	if (!plane)
-		return ERR_PTR(-ENOMEM);
+	int nformats;
 
 	if (type == DRM_PLANE_TYPE_CURSOR) {
 		formats = virtio_gpu_cursor_formats;
@@ -394,17 +384,13 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
 		nformats = ARRAY_SIZE(virtio_gpu_formats);
 		funcs = &virtio_gpu_primary_helper_funcs;
 	}
-	ret = drm_universal_plane_init(dev, plane, 1 << index,
-				       &virtio_gpu_plane_funcs,
-				       formats, nformats,
-				       NULL, type, NULL);
-	if (ret)
-		goto err_plane_init;
+
+	plane = drmm_universal_plane_alloc(dev, struct drm_plane, dev,
+					   1 << index, &virtio_gpu_plane_funcs,
+					   formats, nformats, NULL, type, NULL);
+	if (IS_ERR(plane))
+		return plane;
 
 	drm_plane_helper_add(plane, funcs);
 	return plane;
-
-err_plane_init:
-	kfree(plane);
-	return ERR_PTR(ret);
 }
-- 
2.36.1

