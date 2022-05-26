Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD725356CE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 01:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349737AbiEZX4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 19:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349663AbiEZXzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 19:55:50 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12038EBE95;
        Thu, 26 May 2022 16:55:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 52C691F459FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653609310;
        bh=nPEuKswQlR9Y3lB1Q2WuSBCu+q4IQv1b2R4ojzwKwKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m8aIO9spexkXB7Y8oBGI0YPYaWs/o9KynNSMnYM+QCOBYGce+N6mI0toHIP/pevv4
         PlxmoM6raMVUbKMbZU4yqFIrwNzX1L2fR6z8pjpPqjpWVyI1qQHkbwl826zk1RkvCd
         B5p8s8la4i7uXnsYcU3b5rqVkgspWV12oarc04KFQ/srmesKgwe5Sq7hNvA1SrrU4w
         laM5D27QHrw8jeXLouHaAsmKIwEEmHZ5fbqrcQBamm8jCQT3HtFNnC2ZoX358vRF+o
         3PW+ug5rE3stsfRINXRuPTcGQtOQs2d7EniYZPtWRp8voclYkmCeOajhS9ARnK6w+9
         3tk/7Z0yybMwg==
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
Subject: [PATCH v6 18/22] drm/gem: Add drm_gem_pin_unlocked()
Date:   Fri, 27 May 2022 02:50:36 +0300
Message-Id: <20220526235040.678984-19-dmitry.osipenko@collabora.com>
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

Add unlocked variants of drm_gem_un/pin() functions and make them public.
These new helpers will take care of GEM dma-reservation locking for DRM
drivers.

We are going to add memory shrinking support to the VirtIO-GPU driver
that will need to pin framebuffers explicitly to prevent eviction of the
actively used buffers by the shrinker. VirtIO-GPU driver will use these
new generic helpers to pin shmem framebuffers.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem.c | 29 +++++++++++++++++++++++++++++
 include/drm/drm_gem.h     |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index c61674887582..c909c935cfda 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1179,6 +1179,35 @@ void drm_gem_unpin(struct drm_gem_object *obj)
 		obj->funcs->unpin(obj);
 }
 
+int drm_gem_pin_unlocked(struct drm_gem_object *obj)
+{
+	int ret;
+
+	if (!obj->funcs->pin)
+		return 0;
+
+	ret = dma_resv_lock_interruptible(obj->resv, NULL);
+	if (ret)
+		return ret;
+
+	ret = obj->funcs->pin(obj);
+	dma_resv_unlock(obj->resv);
+
+	return ret;
+}
+EXPORT_SYMBOL(drm_gem_pin_unlocked);
+
+void drm_gem_unpin_unlocked(struct drm_gem_object *obj)
+{
+	if (!obj->funcs->unpin)
+		return;
+
+	dma_resv_lock(obj->resv, NULL);
+	obj->funcs->unpin(obj);
+	dma_resv_unlock(obj->resv);
+}
+EXPORT_SYMBOL(drm_gem_unpin_unlocked);
+
 int drm_gem_vmap(struct drm_gem_object *obj, struct iosys_map *map)
 {
 	int ret;
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 0b427939f466..870d81e7a104 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -413,4 +413,7 @@ int drm_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
 int drm_gem_vmap_unlocked(struct drm_gem_object *obj, struct iosys_map *map);
 void drm_gem_vunmap_unlocked(struct drm_gem_object *obj, struct iosys_map *map);
 
+int drm_gem_pin_unlocked(struct drm_gem_object *obj);
+void drm_gem_unpin_unlocked(struct drm_gem_object *obj);
+
 #endif /* __DRM_GEM_H__ */
-- 
2.35.3

