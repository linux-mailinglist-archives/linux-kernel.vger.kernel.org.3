Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F564F47BA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242954AbiDEVSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572985AbiDERkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:40:17 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE86CB8202
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:38:18 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n9so6805009plc.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 10:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Io1IzG6hmJITuaZIDTYDYzvTfnNkY/lRuamDnYEiYog=;
        b=iz/lmMITgXQh0MqUOEQiFr6dsc0sTdIPypLCCvAym9JOaLdEYvr9t3x/gutfUpMmCz
         YB+c3zyDyI9Wl9NnnLHeqzzbgLg5x/vuuv3yvbSQZ617dXn+sAi8kVRb4YiSh8/NjB0Q
         cr2BhhDA/xuNawlnZ0rK+d9gHXVD67lZMQ6rlXU456ABQwE/ClXPwbq7/Cxz6bgfuspc
         OTehuW8IHfKzC8rrjyVr91xIYR4urF/R+UNHsxqcwR71gfvero52Uj+Em5/icX/Vza7x
         0sNNcdda6Nt3Wak7MkP7XRlddpBgHPjxen/fJAFVjChFfKpN3jJ4Wj4F5J1N6rdoJS14
         jQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Io1IzG6hmJITuaZIDTYDYzvTfnNkY/lRuamDnYEiYog=;
        b=JcZ1H9LEkmUgrO0i9tIgm1Ogv1DsAc/H60x7WMyvZNTO5JYBKpnAcc6z+3QnV18BHY
         XKi3Ltq4SCWvD/r/q0a/FBBJHqEWdk7Yy1/um3gnQ6e/Gh3YOP3CkHUO21Mv5c7n3Py9
         AP98L+EG1t9fQG+pwUQ2jNkexe0KeC9SyyL5B23l2WDVbZqD/rQYyqG7LMLhNxMr9mJd
         TP9cKdWi4ZvMww1I7PhvmY2E9O6nmUtX8t3RlcNgDt7baHO5XElBwMLHSVVSIHBsFGqt
         MIwzlTq2QBWgCpMmQACCoptp5vAfgN7Ef/uoxSBAMQ2FKVx1W9vGZqUyuc3VAAEjO7+0
         IxGA==
X-Gm-Message-State: AOAM533rnHMOxfGoUc5jXdDmLPk+HgcakjZCNgC2o6/5QTOIygQQAJNK
        1EWcpo028IXs1fK2ppPn9bA=
X-Google-Smtp-Source: ABdhPJz8bWFNWl/yMS3gIRE+9LtjVYBYlTCCD9NPyLbTvdXKCpqIJrQ8mAH5ylinjXsk21ZNuzNM7Q==
X-Received: by 2002:a17:902:a9c5:b0:156:32bf:b526 with SMTP id b5-20020a170902a9c500b0015632bfb526mr4687173plr.46.1649180298344;
        Tue, 05 Apr 2022 10:38:18 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id t15-20020a63b70f000000b00381510608e9sm13966302pgf.14.2022.04.05.10.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 10:38:17 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/virtio: Add execbuf flag to request no fence-event
Date:   Tue,  5 Apr 2022 10:39:18 -0700
Message-Id: <20220405173918.1000846-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
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

It would have been cleaner to have a flag to *request* the fence event.
But that ship has sailed.  So add a flag so that userspace which doesn't
care about the events can opt-out.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 8 +++++---
 include/uapi/drm/virtgpu_drm.h         | 2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 3a8078f2ee27..09f1aa263f91 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -225,9 +225,11 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 		goto out_unresv;
 	}
 
-	ret = virtio_gpu_fence_event_create(dev, file, out_fence, ring_idx);
-	if (ret)
-		goto out_unresv;
+	if (!(exbuf->flags & VIRTGPU_EXECBUF_NO_EVENT)) {
+		ret = virtio_gpu_fence_event_create(dev, file, out_fence, ring_idx);
+		if (ret)
+			goto out_unresv;
+	}
 
 	if (out_fence_fd >= 0) {
 		sync_file = sync_file_create(&out_fence->f);
diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index 0512fde5e697..d06cac3407cc 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -52,10 +52,12 @@ extern "C" {
 #define VIRTGPU_EXECBUF_FENCE_FD_IN	0x01
 #define VIRTGPU_EXECBUF_FENCE_FD_OUT	0x02
 #define VIRTGPU_EXECBUF_RING_IDX	0x04
+#define VIRTGPU_EXECBUF_NO_EVENT	0x08
 #define VIRTGPU_EXECBUF_FLAGS  (\
 		VIRTGPU_EXECBUF_FENCE_FD_IN |\
 		VIRTGPU_EXECBUF_FENCE_FD_OUT |\
 		VIRTGPU_EXECBUF_RING_IDX |\
+		VIRTGPU_EXECBUF_NO_EVENT |\
 		0)
 
 struct drm_virtgpu_map {
-- 
2.35.1

