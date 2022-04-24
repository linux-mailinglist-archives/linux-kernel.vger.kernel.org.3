Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491FE50D46F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbiDXTIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237675AbiDXTHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:07:42 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B731213977A
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 12:04:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id AEE281F44DAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650827079;
        bh=b2ST04zm/Wc2+g1oGHK3LnebsnkduuUXRdFzzBAvqNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RYqZIrqV2Et/qyugz9gIMrhJiZsmfGJNjT6FM6SWwMyYOQV8s8YN/GSTtA2dGwp5u
         p49w6MWQWN428gleVaqnJ1Oo82dX//FO8P1Zgq/YGDXK4dmKMYyWANGnBx6kP/Hxgi
         bSztUra9mR26Yclfgj5wBKXQdHA8Kvi+j1N8DlblfXcMBEt/B+MbQC9dRahFw0PCKW
         hSu44gaH+pxgo6/kOVHnXUwr50a4jN7WeEKYvCT4vJy4WuUYkxqaOZ/TCAC7V7nKsn
         wdFIJxwP1nxignskSiJ7LARwKSbD4lyoqDMxSg+2CJNDCb8/fuVm1VNvyMAJIXCdmd
         qC2QwCBYTwYHg==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Clark <robdclark@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Qiang Yu <yuq825@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH v5 03/17] drm/virtio: Check whether transferred 2D BO is shmem
Date:   Sun, 24 Apr 2022 22:04:10 +0300
Message-Id: <20220424190424.540501-4-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424190424.540501-1-dmitry.osipenko@collabora.com>
References: <20220424190424.540501-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Transferred 2D BO always must be a shmem BO. Add check for that to prevent
NULL dereference if userspace passes a VRAM BO.

Cc: stable@vger.kernel.org
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 7c052efe8836..2edf31806b74 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -595,7 +595,7 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
 	struct virtio_gpu_object_shmem *shmem = to_virtio_gpu_shmem(bo);
 
-	if (use_dma_api)
+	if (virtio_gpu_is_shmem(bo) && use_dma_api)
 		dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
 					    shmem->pages, DMA_TO_DEVICE);
 
-- 
2.35.1

