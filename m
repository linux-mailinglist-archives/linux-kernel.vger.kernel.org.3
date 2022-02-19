Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEE64BC977
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 18:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242689AbiBSRCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 12:02:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242470AbiBSRCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 12:02:53 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6959CA195
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 09:02:34 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id t14-20020a17090a3e4e00b001b8f6032d96so11311243pjm.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 09:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JDxmYIM8I0UHDFtNzfKhVrh+LAL9uJ//iBVpmzyjpD8=;
        b=bfkvqTNbGC0DdhOwIPwSY1qRb5B76PXNb+SxqNRNze7cN4qBNLEeT8w6zuE3/mnqZ3
         kFid1tcwL7jpwjSkXTnqiwAZewoU205uGxuOTAXWKfEGjxcKHhlo4uGdsl0X9xYWSy7O
         pcR6hGH8Gj2w104R5RudiEEdh5FwOr2AawvwM2teKU/syLKY/mPHG0x01Nzt7Tli1XZ7
         ag4X2mFLvKpXVNkB34OEWmWl9EEQiVHgt3x6nVEF9S5NaSTUmKH2IMqjSCGyB6sUoORz
         S3zZqQAjGK13Uonrb8g6bKGEOZ6gP4zV+OwooUgHOWrrDwHfBIdyqzmEJJQSpvNXgclS
         xSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JDxmYIM8I0UHDFtNzfKhVrh+LAL9uJ//iBVpmzyjpD8=;
        b=SrENN3sEG2TwPwvUekCcbbxpHqUzSg8N59bfUFVV79dTm84Ip84PWq67MkaVGyyDyn
         I4Nu6xXF52JZ59uwb19OAcDQEklJLEzURVFJF6kdX/fDNXH+yO3dSZLj7gbzbxWa+L3w
         H6JSdXqyjMB9YVkhPR4ZG7rVfzedmJbv2Ipp4nTx7tvcE3V82YH67Qt7itfspK249i11
         lAu7Gt1L+lYILH6F3stS98YVcCN7GuYgRccBQnEmIn6e3MO7/MBZVnqv/Jk9QP+c4BGT
         3vbodvPLHthiwY9B75d4YC69kl+2K3YRn6UBnrsu/hP0xqQZI1YVI2FFE+mOWtWwRa+h
         AyUA==
X-Gm-Message-State: AOAM531FAp1rU7OMGkaLZySiIvEW5M6KjdbTQ6Ho1SttpdBA2RtxhNQ1
        1cKwBMzrbWvr9SGbQc32dDM=
X-Google-Smtp-Source: ABdhPJwNFTzgFD5Dxvg2t7x24UnqKLQIqCny6cm/SHjHpm8VoDCpT63w7lHReOZLzg/mrOjXulYbaA==
X-Received: by 2002:a17:90b:117:b0:1b8:e632:c589 with SMTP id p23-20020a17090b011700b001b8e632c589mr13581026pjz.26.1645290153686;
        Sat, 19 Feb 2022 09:02:33 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id z16sm6244371pfw.159.2022.02.19.09.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 09:02:32 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Chia-I Wu <olvaffe@gmail.com>, Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/virtio: Remove restriction of non-zero blob_flags
Date:   Sat, 19 Feb 2022 09:03:01 -0800
Message-Id: <20220219170301.545432-1-robdclark@gmail.com>
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

This supersedes https://patchwork.freedesktop.org/patch/475127/

 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 69f1952f3144..3a8078f2ee27 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -617,8 +617,7 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 	if (!vgdev->has_resource_blob)
 		return -EINVAL;
 
-	if ((rc_blob->blob_flags & ~VIRTGPU_BLOB_FLAG_USE_MASK) ||
-	    !rc_blob->blob_flags)
+	if (rc_blob->blob_flags & ~VIRTGPU_BLOB_FLAG_USE_MASK)
 		return -EINVAL;
 
 	if (rc_blob->blob_flags & VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE) {
-- 
2.34.1

