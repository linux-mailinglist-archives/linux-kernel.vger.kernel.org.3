Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2B749F553
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347429AbiA1IgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:36:22 -0500
Received: from mga17.intel.com ([192.55.52.151]:52647 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242324AbiA1IgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643358973; x=1674894973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o38fiYC8FerIOAs/7S6eqleb0f9nU/+uoEXioa9TFec=;
  b=ApbuKSnGs3VpaUDJPH4i5nov5P6sdJFlCNelUXfqb3OWa6dC8AW5WSmR
   dBVXv/2RgPR8R6ov5tDf8TFdzuqvyKifHctW+vkWxYvMcCbdgzvy6EdZx
   TPx9hjSo5U+HfbSEUPVFgJa4YPn/YatOJLwyKlqk6wmLoEXqNfvoFG9Wh
   V8h8iUvFE0ohoZGNqwd9h70h11+0qvlcWl0GQ98O8YEbJ6jHaMAPET0sQ
   xt2czq3obNQFVgjJBCQtsoYRU1E0gKls1EwnMCJekJOL5hKjesSrxt68r
   y2hL+4rrmavu2pciOKpbSY7KqVdGHPb+jxJYc9Pbz6biMODpa4+7aB8qO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="227749353"
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="227749353"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 00:36:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="581788729"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 00:36:11 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     srinivas.kandagatla@linaro.org, gregkh@linuxfoundation.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        daniel.vetter@ffwll.ch, airlied@linux.ie, lyude@redhat.com,
        tzimmermann@suse.de, linux-media@vger.kernel.org,
        nouveau@lists.freedesktop.org
Subject: [PATCH 03/14] dma-buf: Replace dma-buf-map with iosys-map
Date:   Fri, 28 Jan 2022 00:36:15 -0800
Message-Id: <20220128083626.3012259-4-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128083626.3012259-1-lucas.demarchi@intel.com>
References: <20220128083626.3012259-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iosys-map is the new name for dma-buf-map and will gain new
capabitilities. Replace with the new API.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/dma-buf/dma-buf.c           | 22 +++++++++++-----------
 drivers/dma-buf/heaps/cma_heap.c    | 10 +++++-----
 drivers/dma-buf/heaps/system_heap.c | 10 +++++-----
 include/linux/dma-buf.h             | 12 ++++++------
 4 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 602b12d7470d..df23239b04fc 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1047,8 +1047,8 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_move_notify, DMA_BUF);
  *
  *   Interfaces::
  *
- *      void \*dma_buf_vmap(struct dma_buf \*dmabuf, struct dma_buf_map \*map)
- *      void dma_buf_vunmap(struct dma_buf \*dmabuf, struct dma_buf_map \*map)
+ *      void \*dma_buf_vmap(struct dma_buf \*dmabuf, struct iosys_map \*map)
+ *      void dma_buf_vunmap(struct dma_buf \*dmabuf, struct iosys_map \*map)
  *
  *   The vmap call can fail if there is no vmap support in the exporter, or if
  *   it runs out of vmalloc space. Note that the dma-buf layer keeps a reference
@@ -1260,12 +1260,12 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_mmap, DMA_BUF);
  *
  * Returns 0 on success, or a negative errno code otherwise.
  */
-int dma_buf_vmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
+int dma_buf_vmap(struct dma_buf *dmabuf, struct iosys_map *map)
 {
-	struct dma_buf_map ptr;
+	struct iosys_map ptr;
 	int ret = 0;
 
-	dma_buf_map_clear(map);
+	iosys_map_clear(map);
 
 	if (WARN_ON(!dmabuf))
 		return -EINVAL;
@@ -1276,12 +1276,12 @@ int dma_buf_vmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
 	mutex_lock(&dmabuf->lock);
 	if (dmabuf->vmapping_counter) {
 		dmabuf->vmapping_counter++;
-		BUG_ON(dma_buf_map_is_null(&dmabuf->vmap_ptr));
+		BUG_ON(iosys_map_is_null(&dmabuf->vmap_ptr));
 		*map = dmabuf->vmap_ptr;
 		goto out_unlock;
 	}
 
-	BUG_ON(dma_buf_map_is_set(&dmabuf->vmap_ptr));
+	BUG_ON(iosys_map_is_set(&dmabuf->vmap_ptr));
 
 	ret = dmabuf->ops->vmap(dmabuf, &ptr);
 	if (WARN_ON_ONCE(ret))
@@ -1303,20 +1303,20 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_vmap, DMA_BUF);
  * @dmabuf:	[in]	buffer to vunmap
  * @map:	[in]	vmap pointer to vunmap
  */
-void dma_buf_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
+void dma_buf_vunmap(struct dma_buf *dmabuf, struct iosys_map *map)
 {
 	if (WARN_ON(!dmabuf))
 		return;
 
-	BUG_ON(dma_buf_map_is_null(&dmabuf->vmap_ptr));
+	BUG_ON(iosys_map_is_null(&dmabuf->vmap_ptr));
 	BUG_ON(dmabuf->vmapping_counter == 0);
-	BUG_ON(!dma_buf_map_is_equal(&dmabuf->vmap_ptr, map));
+	BUG_ON(!iosys_map_is_equal(&dmabuf->vmap_ptr, map));
 
 	mutex_lock(&dmabuf->lock);
 	if (--dmabuf->vmapping_counter == 0) {
 		if (dmabuf->ops->vunmap)
 			dmabuf->ops->vunmap(dmabuf, map);
-		dma_buf_map_clear(&dmabuf->vmap_ptr);
+		iosys_map_clear(&dmabuf->vmap_ptr);
 	}
 	mutex_unlock(&dmabuf->lock);
 }
diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
index 83f02bd51dda..28fb04eccdd0 100644
--- a/drivers/dma-buf/heaps/cma_heap.c
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -202,7 +202,7 @@ static void *cma_heap_do_vmap(struct cma_heap_buffer *buffer)
 	return vaddr;
 }
 
-static int cma_heap_vmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
+static int cma_heap_vmap(struct dma_buf *dmabuf, struct iosys_map *map)
 {
 	struct cma_heap_buffer *buffer = dmabuf->priv;
 	void *vaddr;
@@ -211,7 +211,7 @@ static int cma_heap_vmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
 	mutex_lock(&buffer->lock);
 	if (buffer->vmap_cnt) {
 		buffer->vmap_cnt++;
-		dma_buf_map_set_vaddr(map, buffer->vaddr);
+		iosys_map_set_vaddr(map, buffer->vaddr);
 		goto out;
 	}
 
@@ -222,14 +222,14 @@ static int cma_heap_vmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
 	}
 	buffer->vaddr = vaddr;
 	buffer->vmap_cnt++;
-	dma_buf_map_set_vaddr(map, buffer->vaddr);
+	iosys_map_set_vaddr(map, buffer->vaddr);
 out:
 	mutex_unlock(&buffer->lock);
 
 	return ret;
 }
 
-static void cma_heap_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
+static void cma_heap_vunmap(struct dma_buf *dmabuf, struct iosys_map *map)
 {
 	struct cma_heap_buffer *buffer = dmabuf->priv;
 
@@ -239,7 +239,7 @@ static void cma_heap_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
 		buffer->vaddr = NULL;
 	}
 	mutex_unlock(&buffer->lock);
-	dma_buf_map_clear(map);
+	iosys_map_clear(map);
 }
 
 static void cma_heap_dma_buf_release(struct dma_buf *dmabuf)
diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index ab7fd896d2c4..fcf836ba9c1f 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -241,7 +241,7 @@ static void *system_heap_do_vmap(struct system_heap_buffer *buffer)
 	return vaddr;
 }
 
-static int system_heap_vmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
+static int system_heap_vmap(struct dma_buf *dmabuf, struct iosys_map *map)
 {
 	struct system_heap_buffer *buffer = dmabuf->priv;
 	void *vaddr;
@@ -250,7 +250,7 @@ static int system_heap_vmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
 	mutex_lock(&buffer->lock);
 	if (buffer->vmap_cnt) {
 		buffer->vmap_cnt++;
-		dma_buf_map_set_vaddr(map, buffer->vaddr);
+		iosys_map_set_vaddr(map, buffer->vaddr);
 		goto out;
 	}
 
@@ -262,14 +262,14 @@ static int system_heap_vmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
 
 	buffer->vaddr = vaddr;
 	buffer->vmap_cnt++;
-	dma_buf_map_set_vaddr(map, buffer->vaddr);
+	iosys_map_set_vaddr(map, buffer->vaddr);
 out:
 	mutex_unlock(&buffer->lock);
 
 	return ret;
 }
 
-static void system_heap_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
+static void system_heap_vunmap(struct dma_buf *dmabuf, struct iosys_map *map)
 {
 	struct system_heap_buffer *buffer = dmabuf->priv;
 
@@ -279,7 +279,7 @@ static void system_heap_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
 		buffer->vaddr = NULL;
 	}
 	mutex_unlock(&buffer->lock);
-	dma_buf_map_clear(map);
+	iosys_map_clear(map);
 }
 
 static void system_heap_dma_buf_release(struct dma_buf *dmabuf)
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 7ab50076e7a6..2097760e8e95 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -13,7 +13,7 @@
 #ifndef __DMA_BUF_H__
 #define __DMA_BUF_H__
 
-#include <linux/dma-buf-map.h>
+#include <linux/iosys-map.h>
 #include <linux/file.h>
 #include <linux/err.h>
 #include <linux/scatterlist.h>
@@ -283,8 +283,8 @@ struct dma_buf_ops {
 	 */
 	int (*mmap)(struct dma_buf *, struct vm_area_struct *vma);
 
-	int (*vmap)(struct dma_buf *dmabuf, struct dma_buf_map *map);
-	void (*vunmap)(struct dma_buf *dmabuf, struct dma_buf_map *map);
+	int (*vmap)(struct dma_buf *dmabuf, struct iosys_map *map);
+	void (*vunmap)(struct dma_buf *dmabuf, struct iosys_map *map);
 };
 
 /**
@@ -347,7 +347,7 @@ struct dma_buf {
 	 * @vmap_ptr:
 	 * The current vmap ptr if @vmapping_counter > 0. Protected by @lock.
 	 */
-	struct dma_buf_map vmap_ptr;
+	struct iosys_map vmap_ptr;
 
 	/**
 	 * @exp_name:
@@ -628,6 +628,6 @@ int dma_buf_end_cpu_access(struct dma_buf *dma_buf,
 
 int dma_buf_mmap(struct dma_buf *, struct vm_area_struct *,
 		 unsigned long);
-int dma_buf_vmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
-void dma_buf_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
+int dma_buf_vmap(struct dma_buf *dmabuf, struct iosys_map *map);
+void dma_buf_vunmap(struct dma_buf *dmabuf, struct iosys_map *map);
 #endif /* __DMA_BUF_H__ */
-- 
2.35.0

