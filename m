Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340504FE492
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356965AbiDLPVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356914AbiDLPVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:21:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BAA1A2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:19:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id AA09F1F4496E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649776740;
        bh=yZDfYMtfaZRY0QUffB9LSGM0LIHt1Kf7UYxXwd7bE5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JN5Ron1nZTWRkENle/xnzDNFAkQumqDrhbZzC+JStRCdk1Dns6W2A/A+yMyNsG7qa
         g3mQvydkfD0VB40uMulAq17Po6IYbD+HKlwoxvM5z2IZACg8gjjp4fNWRcJw/CxUln
         hM3HPcm8/NCmAQouX2hSLVNdxXLboIKCvRqnGnm4UNNVo0vuzQ+DPZ7w7lSatir8PP
         WzSt7yDtVvUx49vvJZsuWDnzBNlbS6D5Yw+ONrxfbi+RyST0pMze58md0gcE19X26f
         WUooBM0CFGj8os9MZq59dY2GxWx9tPvgZ7KVGUZq0qNBamTteuKQKKraTVApC08onJ
         NSOwlXETuoxhA==
From:   Robert Beckett <bob.beckett@collabora.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Robert Beckett <bob.beckett@collabora.com>,
        Matthew Auld <matthew.auld@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] drm/i915: ttm backend dont provide mmap_offset for kernel buffers
Date:   Tue, 12 Apr 2022 15:18:37 +0000
Message-Id: <20220412151838.1298956-5-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220412151838.1298956-1-bob.beckett@collabora.com>
References: <20220412151838.1298956-1-bob.beckett@collabora.com>
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

stolen/kernel buffers should not be mmapable by userland.
do not provide callbacks to facilitate this for these buffers.

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c | 32 +++++++++++++++++++++----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
index a878910a563c..b20f81836c54 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
@@ -1092,8 +1092,8 @@ static void i915_ttm_unmap_virtual(struct drm_i915_gem_object *obj)
 	ttm_bo_unmap_virtual(i915_gem_to_ttm(obj));
 }
 
-static const struct drm_i915_gem_object_ops i915_gem_ttm_obj_ops = {
-	.name = "i915_gem_object_ttm",
+static const struct drm_i915_gem_object_ops i915_gem_ttm_user_obj_ops = {
+	.name = "i915_gem_object_ttm_user",
 	.flags = I915_GEM_OBJECT_IS_SHRINKABLE |
 		 I915_GEM_OBJECT_SELF_MANAGED_SHRINK_LIST,
 
@@ -1111,6 +1111,21 @@ static const struct drm_i915_gem_object_ops i915_gem_ttm_obj_ops = {
 	.mmap_ops = &vm_ops_ttm,
 };
 
+static const struct drm_i915_gem_object_ops i915_gem_ttm_kern_obj_ops = {
+	.name = "i915_gem_object_ttm_kern",
+	.flags = I915_GEM_OBJECT_IS_SHRINKABLE |
+		 I915_GEM_OBJECT_SELF_MANAGED_SHRINK_LIST,
+
+	.get_pages = i915_ttm_get_pages,
+	.put_pages = i915_ttm_put_pages,
+	.truncate = i915_ttm_truncate,
+	.shrink = i915_ttm_shrink,
+
+	.adjust_lru = i915_ttm_adjust_lru,
+	.delayed_free = i915_ttm_delayed_free,
+	.migrate = i915_ttm_migrate,
+};
+
 void i915_ttm_bo_destroy(struct ttm_buffer_object *bo)
 {
 	struct drm_i915_gem_object *obj = i915_ttm_to_gem(bo);
@@ -1165,10 +1180,19 @@ int __i915_gem_ttm_object_init(struct intel_memory_region *mem,
 		.no_wait_gpu = false,
 	};
 	enum ttm_bo_type bo_type;
+	const struct drm_i915_gem_object_ops *ops;
 	int ret;
 
 	drm_gem_private_object_init(&i915->drm, &obj->base, size);
-	i915_gem_object_init(obj, &i915_gem_ttm_obj_ops, &lock_class, flags);
+
+	if (flags & I915_BO_ALLOC_USER && intel_region_to_ttm_type(mem) != I915_PL_STOLEN) {
+		bo_type = ttm_bo_type_device;
+		ops = &i915_gem_ttm_user_obj_ops;
+	} else {
+		bo_type = ttm_bo_type_kernel;
+		ops = &i915_gem_ttm_kern_obj_ops;
+	}
+	i915_gem_object_init(obj, ops, &lock_class, flags);
 
 	obj->bo_offset = offset;
 
@@ -1178,8 +1202,6 @@ int __i915_gem_ttm_object_init(struct intel_memory_region *mem,
 
 	INIT_RADIX_TREE(&obj->ttm.get_io_page.radix, GFP_KERNEL | __GFP_NOWARN);
 	mutex_init(&obj->ttm.get_io_page.lock);
-	bo_type = (obj->flags & I915_BO_ALLOC_USER) ? ttm_bo_type_device :
-		ttm_bo_type_kernel;
 
 	obj->base.vma_node.driver_private = i915_gem_to_ttm(obj);
 
-- 
2.25.1

