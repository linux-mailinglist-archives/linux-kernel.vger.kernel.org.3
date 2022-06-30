Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06015623EC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 22:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbiF3UIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 16:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237029AbiF3UH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:07:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F414477D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 13:07:56 -0700 (PDT)
Received: from dimapc.. (109-252-118-164.nat.spd-mgts.ru [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0FB426601986;
        Thu, 30 Jun 2022 21:07:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656619675;
        bh=RJ86DMSaOO7AVg96MzDPxQsREOUycec8sRHQCChEvxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DxkqE4B1wkW0KN/8C6iubGusFgKuQg6nt0yw+1sP/4LfL9+If7TdEx1jHNpz6dIld
         7lp2YVfr5UQNjnwKVm5crMPCQcI+vMs1ooTGDJXbkLGn5IqBSaPfsMS4KI5as0hEmh
         dFL017OMV22Rw5Sp0bB7jZA2PtAqZbzcYH0ui0kkFvUzz9M7cp1DOW+rGTrrBGJO3j
         40HUsSBFM/vSRwyW6vadAJuAWrjUE7WslONQsdy8RDViIyA5uVNKP0su5TmKGj0dAQ
         8npP7ZqrJiw/HslxN6djBBsyho98pFt7JxzL0hG0b8IvgNAEYoZh7YFIeJ3yAn3a1p
         2v8CwD4b9XaRw==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas_os@shipmail.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com
Subject: [PATCH v7 2/9] drm/virtio: Check whether transferred 2D BO is shmem
Date:   Thu, 30 Jun 2022 23:07:19 +0300
Message-Id: <20220630200726.1884320-3-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220630200726.1884320-1-dmitry.osipenko@collabora.com>
References: <20220630200726.1884320-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index b7529b2b9883..1262fd0b3bef 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -597,7 +597,7 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
 	struct virtio_gpu_object_shmem *shmem = to_virtio_gpu_shmem(bo);
 
-	if (use_dma_api)
+	if (virtio_gpu_is_shmem(bo) && use_dma_api)
 		dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
 					    shmem->pages, DMA_TO_DEVICE);
 
-- 
2.36.1

