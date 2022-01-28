Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7A549F55E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347483AbiA1Igb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:36:31 -0500
Received: from mga17.intel.com ([192.55.52.151]:52647 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347383AbiA1IgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643358975; x=1674894975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b15acj+uHWWCYpHpGA5nBcqe/eFWW77eP9hdQINtzKY=;
  b=Q8NKBlvK0P2BJkaC8WI5GnQRwjZr7I9gFBBCwirFH03+PXKhq+oKiHle
   CwKNN5FdIXm8qT01Oop1WyUTLz0qMJBa+xT5JvhPnVBhgAZM69+KLsEew
   10XWWL8HQg2vJM59vG8lOVWxVOakFMfO3Z9jtYMLA/DkFi/OHomdSHQBg
   E7+Tjd0ltiqe1Oy6BiZAcJXiyNvg6fpMaREWvufH4Lu7HQPido1zE1z4G
   +ESX3aO0Pa79U7Ykb2YO3WKUsQWETjtzKDlYOnrWeFUwCP7CEuRdL/AkN
   dtvF1cSwaajqcWnTPPRHU5bL6K9bw0HG9nGM7RMQpGIGpAdfgpQqA923i
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="227749365"
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="227749365"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 00:36:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="581788745"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 00:36:14 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     srinivas.kandagatla@linaro.org, gregkh@linuxfoundation.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        daniel.vetter@ffwll.ch, airlied@linux.ie, lyude@redhat.com,
        tzimmermann@suse.de, linux-media@vger.kernel.org,
        nouveau@lists.freedesktop.org
Subject: [PATCH 07/14] drm/i915: Replace dma-buf-map with iosys-map
Date:   Fri, 28 Jan 2022 00:36:19 -0800
Message-Id: <20220128083626.3012259-8-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128083626.3012259-1-lucas.demarchi@intel.com>
References: <20220128083626.3012259-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iosys-map is the new name for dma-buf-map and will gain new
capabitilities. Replace with the new API in i915.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c           | 8 +++++---
 drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c | 6 +++---
 drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c     | 6 +++---
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
index 1b526039a60d..14fdb0796c52 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
@@ -74,7 +74,8 @@ static void i915_gem_unmap_dma_buf(struct dma_buf_attachment *attachment,
 	kfree(sg);
 }
 
-static int i915_gem_dmabuf_vmap(struct dma_buf *dma_buf, struct dma_buf_map *map)
+static int i915_gem_dmabuf_vmap(struct dma_buf *dma_buf,
+				struct iosys_map *map)
 {
 	struct drm_i915_gem_object *obj = dma_buf_to_obj(dma_buf);
 	void *vaddr;
@@ -83,12 +84,13 @@ static int i915_gem_dmabuf_vmap(struct dma_buf *dma_buf, struct dma_buf_map *map
 	if (IS_ERR(vaddr))
 		return PTR_ERR(vaddr);
 
-	dma_buf_map_set_vaddr(map, vaddr);
+	iosys_map_set_vaddr(map, vaddr);
 
 	return 0;
 }
 
-static void i915_gem_dmabuf_vunmap(struct dma_buf *dma_buf, struct dma_buf_map *map)
+static void i915_gem_dmabuf_vunmap(struct dma_buf *dma_buf,
+				   struct iosys_map *map)
 {
 	struct drm_i915_gem_object *obj = dma_buf_to_obj(dma_buf);
 
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
index 3cc74b0fed06..b071a58dd6da 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
@@ -266,7 +266,7 @@ static int igt_dmabuf_import(void *arg)
 	struct drm_i915_gem_object *obj;
 	struct dma_buf *dmabuf;
 	void *obj_map, *dma_map;
-	struct dma_buf_map map;
+	struct iosys_map map;
 	u32 pattern[] = { 0, 0xaa, 0xcc, 0x55, 0xff };
 	int err, i;
 
@@ -349,7 +349,7 @@ static int igt_dmabuf_import_ownership(void *arg)
 	struct drm_i915_private *i915 = arg;
 	struct drm_i915_gem_object *obj;
 	struct dma_buf *dmabuf;
-	struct dma_buf_map map;
+	struct iosys_map map;
 	void *ptr;
 	int err;
 
@@ -400,7 +400,7 @@ static int igt_dmabuf_export_vmap(void *arg)
 	struct drm_i915_private *i915 = arg;
 	struct drm_i915_gem_object *obj;
 	struct dma_buf *dmabuf;
-	struct dma_buf_map map;
+	struct iosys_map map;
 	void *ptr;
 	int err;
 
diff --git a/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c b/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c
index 2855d11c7a51..b2a5882b8f81 100644
--- a/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c
@@ -61,7 +61,7 @@ static void mock_dmabuf_release(struct dma_buf *dma_buf)
 	kfree(mock);
 }
 
-static int mock_dmabuf_vmap(struct dma_buf *dma_buf, struct dma_buf_map *map)
+static int mock_dmabuf_vmap(struct dma_buf *dma_buf, struct iosys_map *map)
 {
 	struct mock_dmabuf *mock = to_mock(dma_buf);
 	void *vaddr;
@@ -69,12 +69,12 @@ static int mock_dmabuf_vmap(struct dma_buf *dma_buf, struct dma_buf_map *map)
 	vaddr = vm_map_ram(mock->pages, mock->npages, 0);
 	if (!vaddr)
 		return -ENOMEM;
-	dma_buf_map_set_vaddr(map, vaddr);
+	iosys_map_set_vaddr(map, vaddr);
 
 	return 0;
 }
 
-static void mock_dmabuf_vunmap(struct dma_buf *dma_buf, struct dma_buf_map *map)
+static void mock_dmabuf_vunmap(struct dma_buf *dma_buf, struct iosys_map *map)
 {
 	struct mock_dmabuf *mock = to_mock(dma_buf);
 
-- 
2.35.0

