Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B694F535693
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 01:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349554AbiEZXy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 19:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349545AbiEZXyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 19:54:17 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6787E7B9E0;
        Thu, 26 May 2022 16:54:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 62C221F40887
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653609255;
        bh=5LIdhJtan+LZ6LnQ64jsbMrAvP7fINcUYf3MaY5BoNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f3hb0zk7VJGPn7ap02Rwgz7TrZ/O5CjxmjebLky7DXFjxwh1bGhEp5KdhmP9PuAlW
         ZVs/oT2mQG2LHjkG94AHUpI5j+6jkKfSTeC666f+Vnzg0MCBoFk/HB3KqNV3aFCeci
         mpb/yMpgDiuKC91hpp/ErpjhLFcDMsOCGcnUis/tlNxRRYM9dL5Uuyh0AVkOuuqyZO
         XjbeTgTToclrmOeI+ZEO+N7ioYFvs6q7MdaRDWNUK8Q/TVFV5+m5BBeUhPTERr1jrH
         ZVjKt8stdo9RGE876EpODo2XGhnQLHZHg8h4JGFnvYopRH/EBRHZs+lbAB8TtOY3Jk
         oFSx0RPGOuLSw==
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
Subject: [PATCH v6 02/22] drm/gem: Move mapping of imported dma-bufs to drm_gem_mmap_obj()
Date:   Fri, 27 May 2022 02:50:20 +0300
Message-Id: <20220526235040.678984-3-dmitry.osipenko@collabora.com>
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

Drivers that use drm_gem_mmap() and drm_gem_mmap_obj() helpers don't
handle imported dma-bufs properly, which results in mapping of something
else than the imported dma-buf. For example, on NVIDIA Tegra we get a hard
lockup when userspace writes to the memory mapping of a dma-buf that was
imported into Tegra's DRM GEM.

To fix this bug, move mapping of imported dma-bufs to drm_gem_mmap_obj().
Now mmaping of imported dma-bufs works properly for all DRM drivers.

Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem.c              | 3 +++
 drivers/gpu/drm/drm_gem_shmem_helper.c | 9 ---------
 drivers/gpu/drm/tegra/gem.c            | 4 ++++
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 86d670c71286..7c0b025508e4 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1038,6 +1038,9 @@ int drm_gem_mmap_obj(struct drm_gem_object *obj, unsigned long obj_size,
 	if (obj_size < vma->vm_end - vma->vm_start)
 		return -EINVAL;
 
+	if (obj->import_attach)
+		return dma_buf_mmap(obj->dma_buf, vma, 0);
+
 	/* Take a ref for this mapping of the object, so that the fault
 	 * handler can dereference the mmap offset's pointer to the object.
 	 * This reference is cleaned up by the corresponding vm_close
diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 8ad0e02991ca..6190f5018986 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -609,17 +609,8 @@ EXPORT_SYMBOL_GPL(drm_gem_shmem_vm_ops);
  */
 int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct *vma)
 {
-	struct drm_gem_object *obj = &shmem->base;
 	int ret;
 
-	if (obj->import_attach) {
-		/* Drop the reference drm_gem_mmap_obj() acquired.*/
-		drm_gem_object_put(obj);
-		vma->vm_private_data = NULL;
-
-		return dma_buf_mmap(obj->dma_buf, vma, 0);
-	}
-
 	ret = drm_gem_shmem_get_pages(shmem);
 	if (ret) {
 		drm_gem_vm_close(vma);
diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
index 7c7dd84e6db8..f92aa20d63bb 100644
--- a/drivers/gpu/drm/tegra/gem.c
+++ b/drivers/gpu/drm/tegra/gem.c
@@ -564,6 +564,10 @@ int __tegra_gem_mmap(struct drm_gem_object *gem, struct vm_area_struct *vma)
 {
 	struct tegra_bo *bo = to_tegra_bo(gem);
 
+	/* imported dmu-buf is mapped by drm_gem_mmap_obj()  */
+	if (gem->import_attach)
+		return 0;
+
 	if (!bo->pages) {
 		unsigned long vm_pgoff = vma->vm_pgoff;
 		int err;
-- 
2.35.3

