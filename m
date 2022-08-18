Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75605981E1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 13:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244008AbiHRLFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 07:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbiHRLFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 07:05:07 -0400
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74EB9D67D;
        Thu, 18 Aug 2022 04:05:00 -0700 (PDT)
X-UUID: 8f7625e34bd946ab971afd30d2c71a9e-20220818
X-Spam-Fingerprint: 0
X-GW-Reason: 11109
X-Policy-Incident: 5pS25Lu25Lq66LaF6L+HMTDkurrpnIDopoHlrqHmoLg=
X-Content-Feature: ica/max.line-size 103
        audit/email.address 1
        dict/adv 1
        dict/notice 1
        meta/cnt.alert 1
X-UUID: 8f7625e34bd946ab971afd30d2c71a9e-20220818
X-User: oushixiong@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <oushixiong@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1436180143; Thu, 18 Aug 2022 17:45:31 +0800
From:   oushixiong <oushixiong@kylinos.cn>
To:     Dave Airlie <airlied@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        oushixiong <oushixiong@kylinos.cn>
Subject: [PATCH v2] drm/ast: add dmabuf/prime buffer sharing support
Date:   Thu, 18 Aug 2022 17:45:17 +0800
Message-Id: <20220818094517.214421-1-oushixiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RDNS_DYNAMIC,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds ast specific codes for DRM prime feature, this is to
allow for offloading of rending in one direction and outputs in other.

v1->v2:
  - Fix the comment.

Signed-off-by: oushixiong <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/ast/ast_drv.c  |  22 ++++++
 drivers/gpu/drm/ast/ast_mode.c | 125 ++++++++++++++++++++++++++++++++-
 2 files changed, 146 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
index 7465c4f0156a..6c1f75174368 100644
--- a/drivers/gpu/drm/ast/ast_drv.c
+++ b/drivers/gpu/drm/ast/ast_drv.c
@@ -28,6 +28,7 @@
 
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/dma-buf.h>
 
 #include <drm/drm_aperture.h>
 #include <drm/drm_atomic_helper.h>
@@ -50,6 +51,23 @@ module_param_named(modeset, ast_modeset, int, 0400);
 
 DEFINE_DRM_GEM_FOPS(ast_fops);
 
+static struct drm_gem_object *ast_gem_prime_import_sg_table(struct drm_device *dev,
+					struct dma_buf_attachment *attach,
+					struct sg_table *sg)
+{
+	struct drm_gem_vram_object *gbo;
+	struct dma_resv *resv = attach->dmabuf->resv;
+
+	ww_mutex_lock(&resv->lock, NULL);
+	gbo = drm_gem_vram_create(dev, attach->dmabuf->size, 0);
+	ww_mutex_unlock(&resv->lock);
+
+	if (IS_ERR(gbo))
+		return NULL;
+
+	return &gbo->bo.base;
+}
+
 static const struct drm_driver ast_driver = {
 	.driver_features = DRIVER_ATOMIC |
 			   DRIVER_GEM |
@@ -63,6 +81,10 @@ static const struct drm_driver ast_driver = {
 	.minor = DRIVER_MINOR,
 	.patchlevel = DRIVER_PATCHLEVEL,
 
+	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
+	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
+	.gem_prime_import_sg_table = ast_gem_prime_import_sg_table,
+
 	DRM_GEM_VRAM_DRIVER
 };
 
diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 45b56b39ad47..ebe732705e34 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -48,6 +48,8 @@
 #include "ast_drv.h"
 #include "ast_tables.h"
 
+MODULE_IMPORT_NS(DMA_BUF);
+
 static inline void ast_load_palette_index(struct ast_private *ast,
 				     u8 index, u8 red, u8 green,
 				     u8 blue)
@@ -1535,8 +1537,129 @@ static const struct drm_mode_config_helper_funcs ast_mode_config_helper_funcs =
 	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
 };
 
+static int ast_handle_damage(struct drm_framebuffer *fb, int x, int y,
+					int width, int height)
+{
+	struct drm_gem_vram_object *dst_bo = NULL;
+	void *dst = NULL;
+	int ret = 0, i;
+	unsigned long offset = 0;
+	bool unmap = false;
+	unsigned int bytesPerPixel;
+	struct iosys_map map;
+	struct iosys_map dmabuf_map;
+
+	bytesPerPixel = fb->format->cpp[0];
+
+	if (!fb->obj[0]->import_attach)
+		return -EINVAL;
+
+	if (!fb->obj[0]->import_attach->dmabuf->vmap_ptr.vaddr) {
+		ret = dma_buf_vmap(fb->obj[0]->import_attach->dmabuf, &dmabuf_map);
+		if (ret)
+			return 0;
+	} else
+		dmabuf_map.vaddr = fb->obj[0]->import_attach->dmabuf->vmap_ptr.vaddr;
+
+	dst_bo = drm_gem_vram_of_gem(fb->obj[0]);
+
+	ret = drm_gem_vram_pin(dst_bo, 0);
+	if (ret) {
+		DRM_ERROR("ast_bo_pin failed\n");
+		goto error;
+	}
+
+	if (!dst_bo->map.vaddr) {
+		ret = drm_gem_vram_vmap(dst_bo, &map);
+		if (ret) {
+			DRM_ERROR("failed to vmap fbcon\n");
+			drm_gem_vram_unpin(dst_bo);
+			goto error;
+		}
+		unmap = true;
+	}
+	dst = dst_bo->map.vaddr;
+
+	for (i = y; i < y + height; i++) {
+		offset = i * fb->pitches[0] + (x * bytesPerPixel);
+		memcpy_toio(dst + offset, dmabuf_map.vaddr + offset,
+			width * bytesPerPixel);
+	}
+
+	if (unmap)
+		drm_gem_vram_vunmap(dst_bo, &map);
+
+	drm_gem_vram_unpin(dst_bo);
+error:
+	return 0;
+}
+
+
+static int ast_user_framebuffer_dirty(struct drm_framebuffer *fb,
+				struct drm_file *file,
+				unsigned int flags,
+				unsigned int color,
+				struct drm_clip_rect *clips,
+				unsigned int num_clips)
+{
+	int i, ret = 0;
+
+	drm_modeset_lock_all(fb->dev);
+	if (fb->obj[0]->import_attach) {
+		ret = dma_buf_begin_cpu_access(fb->obj[0]->import_attach->dmabuf,
+				DMA_FROM_DEVICE);
+		if (ret)
+			goto unlock;
+	}
+
+	for (i = 0; i < num_clips; i++) {
+		ret = ast_handle_damage(fb, clips[i].x1, clips[i].y1,
+				clips[i].x2 - clips[i].x1, clips[i].y2 - clips[i].y1);
+		if (ret)
+			break;
+	}
+
+	if (fb->obj[0]->import_attach) {
+		dma_buf_end_cpu_access(fb->obj[0]->import_attach->dmabuf,
+				DMA_FROM_DEVICE);
+	}
+
+unlock:
+	drm_modeset_unlock_all(fb->dev);
+
+	return ret;
+}
+
+static void ast_user_framebuffer_destroy(struct drm_framebuffer *fb)
+{
+	struct iosys_map dmabuf_map;
+
+	if (fb->obj[0]->import_attach) {
+		dmabuf_map.vaddr = fb->obj[0]->import_attach->dmabuf->vmap_ptr.vaddr;
+		if (dmabuf_map.vaddr)
+			dma_buf_vunmap(fb->obj[0]->import_attach->dmabuf,
+					&dmabuf_map);
+	}
+
+	drm_gem_fb_destroy(fb);
+}
+
+static const struct drm_framebuffer_funcs ast_gem_fb_funcs_dirtyfb = {
+	.destroy	= ast_user_framebuffer_destroy,
+	.create_handle	= drm_gem_fb_create_handle,
+	.dirty		= ast_user_framebuffer_dirty,
+};
+
+static struct drm_framebuffer *
+ast_gem_fb_create_with_dirty(struct drm_device *dev, struct drm_file *file,
+				const struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	return drm_gem_fb_create_with_funcs(dev, file, mode_cmd,
+					&ast_gem_fb_funcs_dirtyfb);
+}
+
 static const struct drm_mode_config_funcs ast_mode_config_funcs = {
-	.fb_create = drm_gem_fb_create,
+	.fb_create = ast_gem_fb_create_with_dirty,
 	.mode_valid = drm_vram_helper_mode_valid,
 	.atomic_check = drm_atomic_helper_check,
 	.atomic_commit = drm_atomic_helper_commit,
-- 
2.17.1

