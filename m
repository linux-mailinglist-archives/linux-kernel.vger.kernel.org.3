Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1445257B809
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 16:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbiGTOCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 10:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbiGTOC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 10:02:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A09F031935
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658325744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X16iBV7KhZ9Ln6lEGuQir3iZX0VSxdQjWbZR3Ippd7s=;
        b=aIpOOcIMT3Xjwi2wVApd+Nim4qZpwZYry/Ae3oWLSz/g+18cjUa6M3+h7tjFEkUKFr8exd
        Dy/xHve33FC0joUVBKVpF/BpYIRvj/5bespxwKP6OOSgr6xfAWgnSg6ORu6W7a+1CjTGm/
        kgtbwpI6Srb0rZQCuuDFX+7mGwlHCCk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-Zd3Kx4FOOxScBeHRvOdiHg-1; Wed, 20 Jul 2022 10:02:23 -0400
X-MC-Unique: Zd3Kx4FOOxScBeHRvOdiHg-1
Received: by mail-ej1-f69.google.com with SMTP id s4-20020a170906500400b006feaccb3a0eso4118943ejj.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X16iBV7KhZ9Ln6lEGuQir3iZX0VSxdQjWbZR3Ippd7s=;
        b=AHS9QK586eWYlJkahmbnXL9LeQzIHQxG6mroviAzByGhs9NOUaM4Q7o6LkBsDWLPfA
         uKM3f4T7zUS4ZaNaHsgyi15IHfugtkTniuJM47waRjSVDf6ydmxjyUVz7A1OTdptP/Gf
         Jb9RYLZAFel33MwM2bqWDQebmQ+fK1uIZk0qjFL5rUZT+dW3WbzmqtKatMVPD95avSzK
         zmhsm+Ds8xxWCSnWhYf53NUavjihkk8o05pKFs8XKcuBH6iJgFIc1PC1Z/fyCpedlNMm
         Bz4+TGBX8jk/sqGQiPIvxVI7AWZZ85ZKUqvYSB2D1SdGEHHci7gUv7Y8a9iw5GtJRH09
         aKuA==
X-Gm-Message-State: AJIora9c9BoFl514ZrggLr0vqF91QD4rniF2BBGqFDHQ3YBkiXiXLzxz
        931lySpR4G7jeE8rJiPTu+zlb0FmQ4qimFJnI7NzrqSM2IJbh/KiWMF7lenWY8SYCzSZb+3CLxn
        mTrzUd0vN/0Lf2mAQfXM8V1iC
X-Received: by 2002:a17:906:1315:b0:72c:5348:a153 with SMTP id w21-20020a170906131500b0072c5348a153mr34052687ejb.446.1658325742151;
        Wed, 20 Jul 2022 07:02:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sTF7B8ym8e4HRk24BL/G1Q9N7qi8twp5++akqwci39QfFH+fylqNPAfnonNrtNAQKhrRQdUQ==
X-Received: by 2002:a17:906:1315:b0:72c:5348:a153 with SMTP id w21-20020a170906131500b0072c5348a153mr34052675ejb.446.1658325741955;
        Wed, 20 Jul 2022 07:02:21 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906560d00b006fee98045cdsm8053040ejq.10.2022.07.20.07.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 07:02:21 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@linux.ie, daniel@ffwll.ch, kraxel@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND 2/2] drm/virtio: kms: use drm managed resources
Date:   Wed, 20 Jul 2022 16:02:14 +0200
Message-Id: <20220720140214.199492-3-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220720140214.199492-1-dakr@redhat.com>
References: <20220720140214.199492-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

