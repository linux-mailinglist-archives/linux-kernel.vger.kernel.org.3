Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12A3574E81
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239683AbiGNNAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239680AbiGNNAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:00:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E97DA45078
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657803636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f5+OHAHK2VLcrnL1KSJdq9/Govt0hy/raOewuyTrtrI=;
        b=FZFyV6SbiBFhBfHlTf2uboJeNzTgDzNIDcuLz9ChinjXYu5jlXxUWF5sjQrYWvv0x1p8f9
        FaQ9NG7c+lGtnB3lA90sIOckWLJopLiyJtWEkPnw+Y3tUVKocoI1Ef3w+LMPgp0hDc7Tj/
        1MH7zGg3dhWuNBd5i3usPqxUfdELan4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-ZljoYkOwNeiPRmzga4LjMQ-1; Thu, 14 Jul 2022 09:00:34 -0400
X-MC-Unique: ZljoYkOwNeiPRmzga4LjMQ-1
Received: by mail-ej1-f71.google.com with SMTP id nb10-20020a1709071c8a00b006e8f89863ceso741369ejc.18
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f5+OHAHK2VLcrnL1KSJdq9/Govt0hy/raOewuyTrtrI=;
        b=6ZD5QFrFRzqnKId400I6hed5F3FFXuizYAFOVDiMj02DofbGcgFxvmuKldhlG5UqtH
         74KuOKdUMEL6N5J+vczZVj2S+WC8bk8CFNj9rXHckInGray0ubdAibOLY1TlTdNY8e7C
         j+/4kjxNgLSg8TNpq9qMHFyPZxExbvatYJz0z1kjXp+nBIPJ/W+yKzWENTWYHKdK1T3c
         NhglRhNrYvryDLEGcd3xVdGTSQdRfQ+r+K/RG+Ng8GkvNSKpFpHqQWoqppb67YfGk81a
         hRhrrrBu+kzZgu1OT2o9R3/AfLSaIcAwzCJuIrP1mxuCrF3a8T8Em7mSfBFkCP+linmo
         kuJA==
X-Gm-Message-State: AJIora945xgk5sUFYap1oFwnKW3l/tR1LulCGtF6EDXW9ZtUsTACekpE
        XHP4dMZwP18yvYozOS5swz21GVtNGyWhB7X/RJx41+0INYsEIkyXYZ3lRMU3zb3BhNMMAn1d4KO
        9kZsZtSwstanjxc0FEXL56aRV
X-Received: by 2002:a17:907:1b25:b0:6da:8206:fc56 with SMTP id mp37-20020a1709071b2500b006da8206fc56mr8627155ejc.81.1657803633107;
        Thu, 14 Jul 2022 06:00:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vkP+Ryg2/TaLqA61ZrbhfntjLs/5u4V31Ija64DGclgSFfjLRVcA3qAMSo+XslbGnUdCIcjA==
X-Received: by 2002:a17:907:1b25:b0:6da:8206:fc56 with SMTP id mp37-20020a1709071b2500b006da8206fc56mr8627134ejc.81.1657803632961;
        Thu, 14 Jul 2022 06:00:32 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id zk9-20020a17090733c900b0072ecef772acsm694237ejb.2.2022.07.14.06.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:00:31 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@linux.ie, daniel@ffwll.ch, kraxel@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 1/2] drm/virtio: plane: use drm managed resources
Date:   Thu, 14 Jul 2022 15:00:27 +0200
Message-Id: <20220714130028.2127858-2-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220714130028.2127858-1-dakr@redhat.com>
References: <20220714130028.2127858-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

