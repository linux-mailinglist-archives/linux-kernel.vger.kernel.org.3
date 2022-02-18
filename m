Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EDF4BBCA2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiBRP5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:57:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiBRP5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:57:21 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F415C20F6F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:57:04 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id a11-20020a17090a740b00b001b8b506c42fso12776357pjg.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=76Ch6++ik3Xa10+F3GaCo4BUItW2eOp7s3nI1jmAaLM=;
        b=A40JfGTULXeEUbGb9OgxcyRI82LxcgRaLTkMait0arWn+xroPYbZgjIcpuB5u2l1L+
         sTwFaGQpf0koggIBdKnYnVx02wX+TVu+8ngmXD4e7mMp6hfp/9APvsdldJHD2S112YZX
         v0zRiA6pIR7tBEyD0HnWuzTAZbL4cUJkdVFUXqZchlUVOW67Um90cP1XMFHJOwBDyZ9f
         /ttNhcRWdNNqaCHpuwvI4UYXlp7znCgoVpx2tUjH2FYfuR5RJd51GVi6XJfzidG6PMUn
         f8Rh0O6P6+uxpaOehdQTpSOIWRP6HJ8ORQ1r5wu6YA15UfW+KBar4KEnTWeMoX67eHY0
         5UHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=76Ch6++ik3Xa10+F3GaCo4BUItW2eOp7s3nI1jmAaLM=;
        b=Y3PmXfQI6pQ4kqlJOQYbn/RxufbLW+86ZOmRPFR//RyNUuti98rxfiHiV4c8ckoyEw
         Xfb5mDz3iRwzc2lb+tCfa8jD8Vqm+VeQbJn77Nvdl2HiPRMFQ83pBU01JxYtr6wCfTF3
         +HDHm4fH2fv+CcvzQuPNyeuwGAxoJdMfimNn3s/XEI5+PFSbxgbOHYX0X4fejkPeYfT0
         SACZWw70IrEKJnB7BRlSfORj7N0Fxv7yDP5BvC03mX02aJPGaarLyh7MPXw60/imwLsW
         HwhdxGkz1YRBmJOqZGf+YB+auy6s2Y/uOcxbrGLMZbdGHON4udxmhan8z0wQIUOHcmrA
         Oyjg==
X-Gm-Message-State: AOAM532G0MiWMPnGgyujFMskRtSBfQbm7wE4nMwpN9mT0XlvnPN8TN9J
        FLkjr0on0pfZ6r/rNiKBmts=
X-Google-Smtp-Source: ABdhPJzowmB7x8JMRpgtI/TJsdA2/uiiijdaIc3IM5FfQuUSf/aRW56OUqxSDoCAKPwWMBnLsaESQg==
X-Received: by 2002:a17:902:c10d:b0:14e:d3ca:8a20 with SMTP id 13-20020a170902c10d00b0014ed3ca8a20mr8021755pli.92.1645199824398;
        Fri, 18 Feb 2022 07:57:04 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id x1sm3485752pfh.54.2022.02.18.07.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 07:57:02 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/virtio: Add USE_INTERNAL blob flag
Date:   Fri, 18 Feb 2022 07:57:25 -0800
Message-Id: <20220218155725.487785-1-robdclark@gmail.com>
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

With native userspace drivers in guest, a lot of GEM objects need to be
neither shared nor mappable.  And in fact making everything mappable
and/or sharable results in unreasonably high fd usage in host VMM.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
This is for a thing I'm working on, a new virtgpu context type that
allows for running native userspace driver in the guest, with a
thin shim in the host VMM.  In this case, the guest has a lot of
GEM buffer objects which need to be neither shared nor mappable.

Alternative idea is to just drop the restriction that blob_flags
be non-zero.  I'm ok with either approach.

 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 7 ++++++-
 include/uapi/drm/virtgpu_drm.h         | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 69f1952f3144..92e1ba6b8078 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -36,7 +36,8 @@
 
 #define VIRTGPU_BLOB_FLAG_USE_MASK (VIRTGPU_BLOB_FLAG_USE_MAPPABLE | \
 				    VIRTGPU_BLOB_FLAG_USE_SHAREABLE | \
-				    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE)
+				    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE | \
+				    VIRTGPU_BLOB_FLAG_USE_INTERNAL)
 
 static int virtio_gpu_fence_event_create(struct drm_device *dev,
 					 struct drm_file *file,
@@ -662,6 +663,10 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 	params->size = rc_blob->size;
 	params->blob = true;
 	params->blob_flags = rc_blob->blob_flags;
+
+	/* USE_INTERNAL is local to guest kernel, don't past to host: */
+	params->blob_flags &= ~VIRTGPU_BLOB_FLAG_USE_INTERNAL;
+
 	return 0;
 }
 
diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index 0512fde5e697..62b7483e5c60 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -163,6 +163,7 @@ struct drm_virtgpu_resource_create_blob {
 #define VIRTGPU_BLOB_FLAG_USE_MAPPABLE     0x0001
 #define VIRTGPU_BLOB_FLAG_USE_SHAREABLE    0x0002
 #define VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
+#define VIRTGPU_BLOB_FLAG_USE_INTERNAL     0x0008   /* not-mappable, not-shareable */
 	/* zero is invalid blob_mem */
 	__u32 blob_mem;
 	__u32 blob_flags;
-- 
2.34.1

