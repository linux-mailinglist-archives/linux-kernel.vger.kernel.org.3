Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD23574E82
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239303AbiGNNAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239702AbiGNNAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:00:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4750A53D25
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657803638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X16iBV7KhZ9Ln6lEGuQir3iZX0VSxdQjWbZR3Ippd7s=;
        b=XHtT40T40AMPpc6Zv4uwcdO1xKOV3McKGnSLJ1HbigEN23PDWzrrmlLIjg7Z0R1No3HY/V
        WuBiUGMVAL5KjosQpnQ0XsvXJmdP/siBRC4kLI/o1mwNKkoMfawsQxR+y+8jXqIOkoQjjm
        ++P8aUTQ79T8uKOCVYejTuRzrFkc6jM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-NAUAsaEUNMyovaBSsEIKZQ-1; Thu, 14 Jul 2022 09:00:36 -0400
X-MC-Unique: NAUAsaEUNMyovaBSsEIKZQ-1
Received: by mail-ej1-f70.google.com with SMTP id hq20-20020a1709073f1400b0072b9824f0a2so748351ejc.23
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X16iBV7KhZ9Ln6lEGuQir3iZX0VSxdQjWbZR3Ippd7s=;
        b=ifQKleDOpGsOGcoRBXorMSMINouNJuE8Rrvm0BgofBXhTwUh8vqSAaR8x+sokuX7zc
         c2rLkZ5k4nU+gmRen6uYmvcco8SqgIy3XS57S2nsEmUKNpEQE163FUMPRi2N3tI8m5Xy
         +L6CEtPM5Z4p3fV846EZAqby8/6Y395r8L9vDfqMMFUMNoUq/G1MoV068/QDyYUogU6g
         0/2aDftGWkGvS+nu300G3ATQLLxeKV2fP/5HbgG+yU9rIoEZMx5DvK3uNvf8SJQ2afj9
         tyG7J5bFtyhRVeCMwDVnGBsSBnR6UfxVCU8M2kU3vlYY2t+zp2LG73AHWmXzplXjA7bH
         DoIw==
X-Gm-Message-State: AJIora/UB09Jhoo6Y3zi/r/2tIu1FipO3M1JiuEwBMRJrzjfpw2WkoZm
        Ije3D/Sn8Mj/YElHzVxJG9zWyypZ63nsr+xlX0eYRr6daYbWqJOoIEj54Sy79rY7P6yOipUZ6fJ
        Zg98sF85qzgNVx/pR+qMpISh3
X-Received: by 2002:a17:906:6a26:b0:72e:cee5:d1b0 with SMTP id qw38-20020a1709066a2600b0072ecee5d1b0mr5451187ejc.404.1657803635400;
        Thu, 14 Jul 2022 06:00:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v85WghBi+OK8f1leK61CfSKKhJ1e/q/FFkhJ0V6008dxPsF5cUEPomwzP1oAuhcv+e0UGMJg==
X-Received: by 2002:a17:906:6a26:b0:72e:cee5:d1b0 with SMTP id qw38-20020a1709066a2600b0072ecee5d1b0mr5451176ejc.404.1657803635237;
        Thu, 14 Jul 2022 06:00:35 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id zk9-20020a17090733c900b0072ecef772acsm694237ejb.2.2022.07.14.06.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:00:34 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@linux.ie, daniel@ffwll.ch, kraxel@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 2/2] drm/virtio: kms: use drm managed resources
Date:   Thu, 14 Jul 2022 15:00:28 +0200
Message-Id: <20220714130028.2127858-3-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220714130028.2127858-1-dakr@redhat.com>
References: <20220714130028.2127858-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate driver structures with drm managed resource allocators in order
to cleanup/simplify the drm driver .release callback.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_kms.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 3313b92db531..63ebe63ef409 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -28,6 +28,7 @@
 #include <linux/virtio_ring.h>
 
 #include <drm/drm_file.h>
+#include <drm/drm_managed.h>
 
 #include "virtgpu_drv.h"
 
@@ -66,10 +67,11 @@ static void virtio_gpu_get_capsets(struct virtio_gpu_device *vgdev,
 {
 	int i, ret;
 	bool invalid_capset_id = false;
+	struct drm_device *drm = vgdev->ddev;
 
-	vgdev->capsets = kcalloc(num_capsets,
-				 sizeof(struct virtio_gpu_drv_capset),
-				 GFP_KERNEL);
+	vgdev->capsets = drmm_kcalloc(drm, num_capsets,
+				      sizeof(struct virtio_gpu_drv_capset),
+				      GFP_KERNEL);
 	if (!vgdev->capsets) {
 		DRM_ERROR("failed to allocate cap sets\n");
 		return;
@@ -94,7 +96,7 @@ static void virtio_gpu_get_capsets(struct virtio_gpu_device *vgdev,
 
 		if (ret == 0 || invalid_capset_id) {
 			spin_lock(&vgdev->display_info_lock);
-			kfree(vgdev->capsets);
+			drmm_kfree(drm, vgdev->capsets);
 			vgdev->capsets = NULL;
 			spin_unlock(&vgdev->display_info_lock);
 			return;
@@ -126,7 +128,7 @@ int virtio_gpu_init(struct drm_device *dev)
 	if (!virtio_has_feature(dev_to_virtio(dev->dev), VIRTIO_F_VERSION_1))
 		return -ENODEV;
 
-	vgdev = kzalloc(sizeof(struct virtio_gpu_device), GFP_KERNEL);
+	vgdev = drmm_kzalloc(dev, sizeof(struct virtio_gpu_device), GFP_KERNEL);
 	if (!vgdev)
 		return -ENOMEM;
 
@@ -257,7 +259,6 @@ int virtio_gpu_init(struct drm_device *dev)
 	vgdev->vdev->config->del_vqs(vgdev->vdev);
 err_vqs:
 	dev->dev_private = NULL;
-	kfree(vgdev);
 	return ret;
 }
 
@@ -296,9 +297,6 @@ void virtio_gpu_release(struct drm_device *dev)
 
 	if (vgdev->has_host_visible)
 		drm_mm_takedown(&vgdev->host_visible_mm);
-
-	kfree(vgdev->capsets);
-	kfree(vgdev);
 }
 
 int virtio_gpu_driver_open(struct drm_device *dev, struct drm_file *file)
-- 
2.36.1

