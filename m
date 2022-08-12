Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5CF591764
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 00:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbiHLWja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 18:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiHLWj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 18:39:28 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A2D5071D
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 15:39:27 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id k14so2128386pfh.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 15:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=WoqjtI8/PDq4XLeCuA4BUU9vOzNcEPwvP6PaF9+jchw=;
        b=kCH5GDRZUrtkc7wWNsc5nuqbMku7NBjt44npkV7Va47a7utj6FA4TomD1TL+NsJMVK
         iSP2uNzTV+S5agOwMfCzu8BIwfzHY21+IKiEpcfPq3bCaxllz5hpz5y4prNqvAa8Uzk8
         HVihG7IleZ+dcCwz9GI1Pfep9EMwK0bI04WDrv8pz/3TULKedlTuuMzsdyVqhhJr1foG
         254E7QnrI2TAiX+gXbn6O8c51AYcyFN4ubCJ6EQFRt9moTLwQjlhkjWEGOcbf9Bl68fR
         lv0St731bY5X959cZgFEwn0Y9tORv+mtnoIHxaWYOB0mAjVWst+yaVCw5BGZVVZ9W0IL
         PllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=WoqjtI8/PDq4XLeCuA4BUU9vOzNcEPwvP6PaF9+jchw=;
        b=0zeoWSUTFtW/L5aekIAs9I4fsrwpK8NjObqHlvWYWS0qC9Prc6P6ZJHkkAo2pp1GsM
         mY9ycolI+r+3lwzO7QtaRQi2tGXYMqcONqKsZS4q3Q4c8w53aVuyc+pVWn5Mco6cj4BG
         FDpWZI3cowHn4LUDTS0EfzBq4jYi3qoOROftveg5woKntAgJcDHoeRsIOBikzh5VLw93
         4jA/RkOrNnO4yKkl8WKt+mBLSIwvmbE0aOIUVvTJYHJFSvzsZEIkVQjAEgDyPXDU91fR
         UIm7kkJLSzWIZ/9KS5Ehuv27cnMiVh+n8q7C+b1zDgn1MOXVN8+8UkcQ98ZL1yzHqL7U
         rKLg==
X-Gm-Message-State: ACgBeo2wjGXVRWXU1DFK2n2P7DpDzmMXDq3s74Bwc28hhkQf6CUmvKxf
        x+8kByR+LrSVEy4PVtKcisQ=
X-Google-Smtp-Source: AA6agR5c193Q2KiScRnuf+nXAXJspANTuNt8azcyAEmzHXLvouKJGN9t8xNlwdLZp0TstxxFt+2jUQ==
X-Received: by 2002:a63:6b87:0:b0:41c:2fb4:24f1 with SMTP id g129-20020a636b87000000b0041c2fb424f1mr4913613pgc.452.1660343967087;
        Fri, 12 Aug 2022 15:39:27 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id fh3-20020a17090b034300b001ef87123615sm315731pjb.37.2022.08.12.15.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 15:39:25 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Lingfeng Yang <lfy@google.com>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/virtio: Fix same-context optimization
Date:   Fri, 12 Aug 2022 15:40:00 -0700
Message-Id: <20220812224001.2806463-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
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

When VIRTGPU_EXECBUF_RING_IDX is used, we should be considering the
timeline that the EB if running on rather than the global driver fence
context.

Fixes: 85c83ea915ed ("drm/virtio: implement context init: allocate an array of fence contexts")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index fa2f757583f7..9e6cb3c2666e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -168,7 +168,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 		 * array contains any fence from a foreign context.
 		 */
 		ret = 0;
-		if (!dma_fence_match_context(in_fence, vgdev->fence_drv.context))
+		if (!dma_fence_match_context(in_fence, fence_ctx + ring_idx))
 			ret = dma_fence_wait(in_fence, true);
 
 		dma_fence_put(in_fence);
-- 
2.36.1

