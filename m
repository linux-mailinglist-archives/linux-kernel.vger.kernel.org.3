Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B5647CD83
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 08:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242984AbhLVH05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 02:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhLVH05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 02:26:57 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E828AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 23:26:56 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id k64so1567996pfd.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 23:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=YfoMqAE8tP1PVqVojIPRAkfs6QhYxWvNRbwDdCnoJaE=;
        b=bk1AcE8D6fHgrh2xY/U8jJNak+zHpXEpWoas09GyMYrFfw+XUnlPhnbUcrkOs5HDo/
         VA8YI8vRoBvlXeWl2euYPl/9BfANeHecDBIdstogljKz1jCApdQ8M929xjckdI1BvJ81
         ShI1dxmrflyrOyEStgmLNOOPgHZF1gyrtDavPyX7vUH0Y4NChIoHc+yPvcja+BQa8zm5
         16nStKO65JWu0TQ0OElai0FymdxcfFQ9T8ciNd8ppAjBr57gWy6Bt0PFg5NKEyH/ev3K
         uSP0BGVyhjlhbpFlO/4MdnFHHPh24tQO+0TYvY+yYneOSxn+yGexLShE5wl5E0Ib1h6l
         Zn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YfoMqAE8tP1PVqVojIPRAkfs6QhYxWvNRbwDdCnoJaE=;
        b=qF66kpLF9gDQXfU65jpxW+mnl976EYrpfu/RxgASPEX7f7uBsAZMPmowNxuWt22/Q+
         VDTf7biwECWxVpTq/618H6h2sfvv81STgnktbXQSwJHcf1TuBvqgraoZXXbycL9cKK1I
         BUcXTqr+dtEmuWWE8mx39RsIbe1DA5YggVbmTwtMdmal8rOeCWAxONggV2QrWmYy86+3
         iqJzCTv8BUK6Loe6ntNQ+5aDjfmZXuGtLSdBuDeLQ7KdMuYPG2jw9n1OHJ/enLOh/Kld
         X0JUJ+2otL8BPOFTVzPUUekbCNkGvTDJIlKsGsnCfR2Xf84t+tYjHbBXNGHWNU4XQ2qt
         /uiw==
X-Gm-Message-State: AOAM530PmQtwgHJSE5uzI4di2b6DTu1QDmIhwwJjQ3HE2DVi9qtYfJ+L
        KhFMdW9euqMx9Gw6CxEUbDQ=
X-Google-Smtp-Source: ABdhPJzgxQitXRab/a18M4bP9QRCqfcG0/B+iALRX+rSqC0szzStk4z7s29LgNoaWILlDlz6pngOeQ==
X-Received: by 2002:a62:c103:0:b0:4ba:75b8:cf69 with SMTP id i3-20020a62c103000000b004ba75b8cf69mr2026651pfg.64.1640158016496;
        Tue, 21 Dec 2021 23:26:56 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id q19sm1463187pfk.83.2021.12.21.23.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 23:26:56 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/virtio: Fix NULL vs IS_ERR checking in virtio_gpu_object_shmem_init
Date:   Wed, 22 Dec 2021 07:26:49 +0000
Message-Id: <20211222072649.18169-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since drm_prime_pages_to_sg() function return error pointers.
The drm_gem_shmem_get_sg_table() function returns error pointers too.
Using IS_ERR() to check the return value to fix this.

Fixes: f651c8b05542("drm/virtio: factor out the sg_table from virtio_gpu_object")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index f648b0e24447..8bb80289672c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -168,9 +168,9 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
 	 * since virtio_gpu doesn't support dma-buf import from other devices.
 	 */
 	shmem->pages = drm_gem_shmem_get_sg_table(&bo->base.base);
-	if (!shmem->pages) {
+	if (IS_ERR(shmem->pages)) {
 		drm_gem_shmem_unpin(&bo->base.base);
-		return -EINVAL;
+		return PTR_ERR(shmem->pages);
 	}
 
 	if (use_dma_api) {
-- 
2.17.1

