Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDA65141EF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 07:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354254AbiD2Fwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 01:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354219AbiD2Fwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 01:52:35 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145A4B18A7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 22:49:18 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id e15so5048906qtp.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 22:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zlsCs+x0DoSzsNw/NRm1xCc/AUcSv2O7P/MFQ0HV3jM=;
        b=WPvzeyMCxQq+nyaYg6JoXj2g141ThYO8ykqXrGAh6WJbIeGAdJlGjxTttbNhJ5Ci/5
         hUMIkDwQ6IVgwgwt48IoAIvKUoEHt/hPKZim6SnYZdJSaEN9/7WhgeGdrHTcHYrMU3pN
         oXj18MJ95T3QHg3PHaO/tm8rBt6eqKEkmSwhq/F+inkgqVLD3KM/4gU/eBvjjbJbP4pV
         /HftgeXlypiOi2XPOEZm76QbRwJQH+H4f901hN83cHteRfoGGv8XE33nh6AwPXv9Y4J+
         0NTzEsV6Nd8KFi0FDJeGsuZbRL1tfOOi54+dBYir5WbPYCPGlIzveUs2t9djyHwfYbj0
         8SJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zlsCs+x0DoSzsNw/NRm1xCc/AUcSv2O7P/MFQ0HV3jM=;
        b=zbGpD0k1a5l7zCk1gLBTf7tyVZXZCxX1it5Uz841YpZu3a0GWkEd7rD9dRQjjx5nBI
         gm+/eCHM6vNCRyWG4TT+RW3OdTnhJWNCP/+k7XcHRVkp3iFJQQQK1RpGZ0XXbKJ9PgLJ
         /zj9mCp2T3eplOiAkn2HszSsDlh9q80rDwWEVzB0NbogwZ5+KFMLmpvWaCBwuM2BLE8h
         CM6xV8J1NriqDypRxcNLGnCO+ZBthnIfcrwRgJrEm40jhEeLhg2SV1CK6+yDBx63zXVe
         8j9Ya9fnghs6jfwoePALnOxYg1bj+NDcjxPhmgd1rasXIGoZY6z3lpDSM7qdfZ2GrCAN
         yECQ==
X-Gm-Message-State: AOAM532yxUlV2rCBi31hS4BemiFjYVKH2B0HHtZHd1dCGqvttTc0NkTx
        aLQbf+YldUOTZDto55oGS44=
X-Google-Smtp-Source: ABdhPJzmlNPH5wsdYHzUvy/XFcXzD0gwvs8dgEJ4del5pjnf1RgkLakypwFzuwMeEGO7YaBUniCMng==
X-Received: by 2002:ac8:5551:0:b0:2f1:ea20:40a with SMTP id o17-20020ac85551000000b002f1ea20040amr25493636qtr.139.1651211357222;
        Thu, 28 Apr 2022 22:49:17 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h5-20020a05622a170500b002f3818c7b92sm1136547qtk.49.2022.04.28.22.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 22:49:16 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     airlied@linux.ie
Cc:     kraxel@redhat.com, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/virtio: simplify the return expression
Date:   Fri, 29 Apr 2022 05:49:11 +0000
Message-Id: <20220429054911.3851977-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Simplify the return expression.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/gpu/drm/virtio/virtgpu_prime.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
index 55d80b77d9b0..44425f20d91a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -90,7 +90,6 @@ static const struct virtio_dma_buf_ops virtgpu_dmabuf_ops =  {
 int virtio_gpu_resource_assign_uuid(struct virtio_gpu_device *vgdev,
 				    struct virtio_gpu_object *bo)
 {
-	int ret;
 	struct virtio_gpu_object_array *objs;
 
 	objs = virtio_gpu_array_alloc(1);
@@ -98,11 +97,8 @@ int virtio_gpu_resource_assign_uuid(struct virtio_gpu_device *vgdev,
 		return -ENOMEM;
 
 	virtio_gpu_array_add_obj(objs, &bo->base.base);
-	ret = virtio_gpu_cmd_resource_assign_uuid(vgdev, objs);
-	if (ret)
-		return ret;
 
-	return 0;
+	return virtio_gpu_cmd_resource_assign_uuid(vgdev, objs);
 }
 
 struct dma_buf *virtgpu_gem_prime_export(struct drm_gem_object *obj,
-- 
2.25.1


