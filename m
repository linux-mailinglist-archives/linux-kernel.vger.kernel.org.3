Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E77B4FC743
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 00:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241939AbiDKWDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 18:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350373AbiDKWCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 18:02:40 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9697426C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 15:00:20 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 317931F43C7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649714419;
        bh=b2ST04zm/Wc2+g1oGHK3LnebsnkduuUXRdFzzBAvqNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g7Vr1Jabyms1/C+YkMzYjic/knwWRp5rQrjPhU5jgjsKz9oIu0/hHqi1yo/dKxXWU
         yv7z+M5b+R346aIkcH9+n04Ze/4g5NF3EpqcGyXto5Ee7q0K9sV2JH8wDKW0JBBIoD
         FIJpv3eBpRAK4zsLr4kaEKVVwQGPTn11rxAUYl+cUDoIbMoTQZItG0r5gM5IM2DIo7
         OUxZT8q7rm7CvZtW+psCVue6hHR93wQ7LXsKlpMTbv7uKSgf1JvLlaRyxS/Ie5K3sz
         orcjZPHqmsd9yjrpGKFiNJBUzXtYyRJDpc0eNbaRwV58OhUMfsOalXoFkUVEzzGdTO
         L75y98aim+A/A==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH v3 02/15] drm/virtio: Check whether transferred 2D BO is shmem
Date:   Tue, 12 Apr 2022 00:59:24 +0300
Message-Id: <20220411215937.281655-3-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411215937.281655-1-dmitry.osipenko@collabora.com>
References: <20220411215937.281655-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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

