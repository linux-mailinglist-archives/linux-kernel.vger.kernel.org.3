Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB9F4B7C86
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245357AbiBPBQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:16:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245429AbiBPBQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:16:00 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0D5F5411
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:15:50 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id x11so754423pll.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0hwZ2F3aREhpJrlJ2d2Ygxmwwu5LB/WMxQx3SAucGcc=;
        b=Kn1kq8Z6LR/PsKUAKmu2TgN0q8KMHpYWQ0TA59BvJ8YXgNv9+VQ6HyX8RCNhpl0HKF
         tzKXer0c/VfAgtIdWOuaqJ9PDLt7uNxv183fEXL7piAF+9HILKHrpQGzcrUpaXnhG/0B
         b9WG14crvUmfqNnOWjcOkmRxjzAo55kSsS9JdXzianc87UOkXPI8gUoLh+11HpAuGrYz
         7IX5mR6/cHus1ppqJYk+nXObKvxE2Q1SAmcsvAcHl8XzTLlOcPAykr0lvclKdumwAFgJ
         leMOJyYUdIRBTySDndNDULI/vhF64kb+pDSvx9NbwomaMxjHu5FmJt3FP2Vg2fbh7XMy
         Jkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0hwZ2F3aREhpJrlJ2d2Ygxmwwu5LB/WMxQx3SAucGcc=;
        b=J0JBj6kieCBWpEfzC/LeCRBFVPLWoyxZidoaRElt8k1vp/gA195ROIp2zr1q6Q1+Og
         MmfcjyVJcpGuvTGKLsfxzPrLfjaQBVG12MSQ7UmPDj/JHguEabk+p215CKRlo2hsR1pU
         NsyC3qGIpqpZTw5u/TQ3ByFfn0v108hkQGr8EQLTnwbCfPNYXS2n68uMiFgmANv3AQ+H
         P3yH5dez5cPFtPXYaA+A/bZYzLV6OPtfp7XbEwKREhN7zVDiyvkCNh6wsnireC+moM57
         VjwOQznXNR6QNsU9cEjtaqWOcVRVQpgQjOEjCZifQZUyr/SqZmq8zTy0K4fPQ9E4uB3P
         UFwA==
X-Gm-Message-State: AOAM530DTp5zP/WEg+EotvnhSgjnNcxxExoRsPRsM0CKZbxyLijS57T9
        jOZwIkcM1zepD4QR9xh4TNY=
X-Google-Smtp-Source: ABdhPJzObOPULx4E0kcZ0vLa3iyJhoz+Xq3kxebJsb1C6cXwwaNrpNsO/2CfAyEGSfvbGjclvdffIQ==
X-Received: by 2002:a17:90a:734c:b0:1b9:b1fa:db6a with SMTP id j12-20020a17090a734c00b001b9b1fadb6amr191487pjs.158.1644974149433;
        Tue, 15 Feb 2022 17:15:49 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id ls14sm15760824pjb.0.2022.02.15.17.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 17:15:48 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gurchetan Singh <gurchetansingh@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Lingfeng Yang <lfy@google.com>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/virtio: Fix capset-id query size
Date:   Tue, 15 Feb 2022 17:16:14 -0800
Message-Id: <20220216011614.360451-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

The UABI was already defined for pointer to 64b value, and all the
userspace users of this ioctl that I could find are already using a
uint64_t (but zeroing it out to work around kernel only copying 32b).
Unfortunately this ioctl doesn't have a length field, so out of paranoia
I restricted the change to copy 64b to the single 64b param that can be
queried.

Fixes: 78aa20fa4381 ("drm/virtio: implement context init: advertise feature to userspace")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 0f2f3f54dbf9..0158d27d5645 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -269,7 +269,8 @@ static int virtio_gpu_getparam_ioctl(struct drm_device *dev, void *data,
 {
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct drm_virtgpu_getparam *param = data;
-	int value;
+	int value, ret, sz = sizeof(int);
+	uint64_t value64;
 
 	switch (param->param) {
 	case VIRTGPU_PARAM_3D_FEATURES:
@@ -291,13 +292,20 @@ static int virtio_gpu_getparam_ioctl(struct drm_device *dev, void *data,
 		value = vgdev->has_context_init ? 1 : 0;
 		break;
 	case VIRTGPU_PARAM_SUPPORTED_CAPSET_IDs:
-		value = vgdev->capset_id_mask;
+		value64 = vgdev->capset_id_mask;
+		sz = sizeof(value64);
 		break;
 	default:
 		return -EINVAL;
 	}
-	if (copy_to_user(u64_to_user_ptr(param->value), &value, sizeof(int)))
-		return -EFAULT;
+
+	if (sz == sizeof(int)) {
+		if (copy_to_user(u64_to_user_ptr(param->value), &value, sz))
+			return -EFAULT;
+	} else {
+		if (copy_to_user(u64_to_user_ptr(param->value), &value64, sz))
+			return -EFAULT;
+	}
 
 	return 0;
 }
-- 
2.34.1

