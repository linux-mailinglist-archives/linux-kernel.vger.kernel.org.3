Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2795049CF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 00:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiDQWkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 18:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbiDQWkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 18:40:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2712A17053
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 15:37:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 6D5E21F40EAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650235053;
        bh=isO7PTUeJcDVmAZaS1b0iVVGgXGziCi18eZsBem42Os=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RCU0g4/e8IIBgm39Cna0t75waPeHxN5xPVxsFDXz8lk8cqLB1fOgTM9j+MVuyXbVG
         +XZzwYUUP9XGxUqodAUBMzmfKeVk3FRhTJtnnHRGDXxDeI23i+ogWSu6fo8R1UH3Iq
         OpAPJ5+h8PXjtHCsOIvnC6Dj6RZcaCwPWFR0ElLf0InNmGChOA8245jPAgvBIonUt7
         U5GM3VlDpXHtqr+vRwjU7cgwI1upzmPOjFtwsBxVb0P0xPQtXysbuU0KfWWDitRvfB
         XcOaH7M/rCOOzPxbnx9KIjpuwmrHT9iciWkgUzIUPZ+yRcYkoQaNS9PA4B64bdZ4QP
         v9RtjeOacepmA==
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
Subject: [PATCH v4 03/15] drm/virtio: Unlock GEM reservations on virtio_gpu_object_shmem_init() error
Date:   Mon, 18 Apr 2022 01:36:55 +0300
Message-Id: <20220417223707.157113-4-dmitry.osipenko@collabora.com>
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

Unlock reservations in the error code path of virtio_gpu_object_create()
to silence debug warning splat produced by ww_mutex_destroy(&obj->lock)
when GEM is released with the held lock.

Cc: stable@vger.kernel.org
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 3d0c8d4d1c20..21c19cdedce0 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -250,6 +250,8 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 
 	ret = virtio_gpu_object_shmem_init(vgdev, bo, &ents, &nents);
 	if (ret != 0) {
+		if (fence)
+			virtio_gpu_array_unlock_resv(objs);
 		virtio_gpu_array_put_free(objs);
 		virtio_gpu_free_object(&shmem_obj->base);
 		return ret;
-- 
2.35.1

