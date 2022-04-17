Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B315049CE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 00:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbiDQWk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 18:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiDQWkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 18:40:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9635E1705E
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 15:37:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id DA9861F40EAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650235058;
        bh=isR8z997diym4El61jLlrCRI0NqP4AALskkuO0PNVVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MY7v01DDCQfiFFhfXUE06lajiffILDjy/CwUYMbZBqIKEUU5L1ybaTT4YlrkTTuwx
         euE9TnCoVNdUYkPPRyVWtE846rLeNIE85tBF/wxjY+ejHCfdAiArN+/durBz6/r+Pi
         t07SPZnfop10ChARzzhdS5ITYW9utqMmrnvd/fItPCtyMF5/vdnUTiuMAE1payXOYr
         T2UG0LpY8PZnZUjNqpaKp/ObrUciJpz5nCBSSD1WwVj4bS2pddLiEDR90YL8w62WPV
         HXod1YnjGChikdWEuptnTZgJKvkvMLREYg0tJTVlHJeHXC9UxO8CwtO58mvTz0Zyio
         wQU3YbV3mPFZQ==
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
        Robin Murphy <robin.murphy@arm.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH v4 06/15] drm/virtio: Simplify error handling of virtio_gpu_object_create()
Date:   Mon, 18 Apr 2022 01:36:58 +0300
Message-Id: <20220417223707.157113-7-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220417223707.157113-1-dmitry.osipenko@collabora.com>
References: <20220417223707.157113-1-dmitry.osipenko@collabora.com>
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

Change the order of SHMEM initialization and reservation locking to
make code cleaner a tad and to prepare to transitioning of the common
GEM SHMEM code to use the GEM's reservation lock instead of the
shmem.page_lock.

There is no need to lock reservation during allocation of the SHMEM pages
because the lock is needed only to avoid racing with the async host-side
allocation. Hence we can safely move the SHMEM initialization out of the
reservation lock.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 21c19cdedce0..18f70ef6b4d0 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -236,6 +236,10 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 
 	bo->dumb = params->dumb;
 
+	ret = virtio_gpu_object_shmem_init(vgdev, bo, &ents, &nents);
+	if (ret != 0)
+		goto err_put_id;
+
 	if (fence) {
 		ret = -ENOMEM;
 		objs = virtio_gpu_array_alloc(1);
@@ -248,15 +252,6 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 			goto err_put_objs;
 	}
 
-	ret = virtio_gpu_object_shmem_init(vgdev, bo, &ents, &nents);
-	if (ret != 0) {
-		if (fence)
-			virtio_gpu_array_unlock_resv(objs);
-		virtio_gpu_array_put_free(objs);
-		virtio_gpu_free_object(&shmem_obj->base);
-		return ret;
-	}
-
 	if (params->blob) {
 		if (params->blob_mem == VIRTGPU_BLOB_MEM_GUEST)
 			bo->guest_blob = true;
-- 
2.35.1

