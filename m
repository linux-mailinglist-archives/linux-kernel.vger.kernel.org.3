Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9C35356CB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 01:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349678AbiEZXyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 19:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349642AbiEZXye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 19:54:34 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A03EAD1C;
        Thu, 26 May 2022 16:54:28 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 8F3AE1F40887
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653609267;
        bh=xPahHFXhmzFRvwHWi9um3lr6dS/zSQQnyahtz13WrNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E2dOSzH2bYscAM2yw+OsJQF6ASXzoHeHyCW2JAYd9BoRUHhbsYdmJ8LiEFfuw4PKg
         9+sypQggxGc7h/M7vxZP9YcFWj+u2FkT5drukiTUXFiPtzBrkBwqGJLQAYK8ZZQPqC
         3kIkbt0/wh1LzZa6jReVPQMdIoyAGL+sOirNZZxosMKbaVhSAEbSsQCPio5EaWc6g2
         7WBVF1do7xnITJPp47lKbqvEd1BHUmph+ejBV/8nPwS+v5ywMOtUccLe0UFQInaddj
         TOuGZOeaBJhIkpw56yt4VLRZXcb/qMhwx6cBABDqhHh0pnxPh/p6ttBjiKP2QVO80L
         jV8dOkXnd5L5A==
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
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-tegra@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, kernel@collabora.com
Subject: [PATCH v6 06/22] drm/virtio: Check whether transferred 2D BO is shmem
Date:   Fri, 27 May 2022 02:50:24 +0300
Message-Id: <20220526235040.678984-7-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220526235040.678984-1-dmitry.osipenko@collabora.com>
References: <20220526235040.678984-1-dmitry.osipenko@collabora.com>
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
2.35.3

