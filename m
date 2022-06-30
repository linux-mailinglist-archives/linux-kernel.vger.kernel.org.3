Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D3C5623E4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 22:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbiF3UIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 16:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237033AbiF3UH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:07:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3756E44A30
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 13:07:57 -0700 (PDT)
Received: from dimapc.. (109-252-118-164.nat.spd-mgts.ru [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3197D66019A6;
        Thu, 30 Jun 2022 21:07:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656619676;
        bh=9JBASQ7AoArrW889/HXzg1w7zdoPTiilaMcXUfR3Ntc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N8IzMczZyXyiloAgtvKyLpyi8woy9b11yLiDn5ADAKtKLcoqiHxEkPZcAm+1n7NxJ
         C3qKY0W+UQMG2QYkoFj/Ol+tkukgvLp3xTtgpPFtW13+vv0MgNGIZLTJnmYTQbZDUO
         RqjpiYjJCz9jwNMKm6nkz2LgLTmoulQ6covQ7dVyRN7shIY4YQKeajJW+gVziBkcpW
         8TU9OiA1ieyK/7fhLL7ZluCpcxxxgS8xh7zGzgrEje38BpU1M5Akiro4y5PIcqCQJS
         F1jLEtgU13YFGcDlNlmNS3gG7LTC0FhHWh70ywifGlSuitisNSfHcsEb8kbx5byuD0
         /fVeHV7RPbNAg==
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
Subject: [PATCH v7 3/9] drm/virtio: Unlock reservations on virtio_gpu_object_shmem_init() error
Date:   Thu, 30 Jun 2022 23:07:20 +0300
Message-Id: <20220630200726.1884320-4-dmitry.osipenko@collabora.com>
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

Unlock reservations in the error code path of virtio_gpu_object_create()
to silence debug warning splat produced by ww_mutex_destroy(&obj->lock)
when GEM is released with the held lock.

Cc: stable@vger.kernel.org
Fixes: 30172efbfb84 ("drm/virtio: blob prep: refactor getting pages and attaching backing")
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 87b19b3b96e0..75a159df0af6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -249,6 +249,8 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 
 	ret = virtio_gpu_object_shmem_init(vgdev, bo, &ents, &nents);
 	if (ret != 0) {
+		if (fence)
+			virtio_gpu_array_unlock_resv(objs);
 		virtio_gpu_array_put_free(objs);
 		virtio_gpu_free_object(&shmem_obj->base);
 		return ret;
-- 
2.36.1

