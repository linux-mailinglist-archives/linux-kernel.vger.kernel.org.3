Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3D3552691
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 23:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343894AbiFTVex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 17:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238346AbiFTVeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 17:34:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B155514D39
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 14:34:17 -0700 (PDT)
Received: from hermes-devbox.fritz.box (82-71-8-225.dsl.in-addr.zen.co.uk [82.71.8.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbeckett)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4D73F66018A7;
        Mon, 20 Jun 2022 22:34:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655760856;
        bh=BJ87eisXj9Ppx4nwiDdWpEsHsZ0BoBn8nQEON2j1/N8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SS+IlwWyPXSGr+X0KsGYlBRuiRe822keDXX44ookPygSZPzDuWL0Cl9ndloyIA2Ip
         eIYA2iZHjjPMHiqujaXonUEIpSJMe0DAm/8rOTdS50b+8g6snDwCVvJR3q3tEzL8dp
         wqbMIvNol8LXEVKzxapozszj87KY9eie0pXrghF21DWSLXbFE7umVP3xgXdJI0cORt
         rfEhysvGC+xusbeUR7sUr2etbSrk6MTfNan0NTn3lKQBuHaZK+VCixLhBgz6c5mD95
         if4kAGd0UT9mCW3ke4c5NNiKWObUIkSh7QcuP+5QYeP+di5upPNz6G2h/at94DYNij
         c7nzjqSmpfJgg==
From:   Robert Beckett <bob.beckett@collabora.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     kernel@collabora.com, Robert Beckett <bob.beckett@collabora.com>,
        Matthew Auld <matthew.auld@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v7 09/10] drm/i915/ttm: add buffer pin on alloc flag
Date:   Mon, 20 Jun 2022 21:33:39 +0000
Message-Id: <20220620213340.3199605-10-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620213340.3199605-1-bob.beckett@collabora.com>
References: <20220620213340.3199605-1-bob.beckett@collabora.com>
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

For situations where allocations need to fail on alloc instead of
delayed get_pages, add a new alloc flag to pin the ttm bo.
This makes sure that the resource has been allocated during buffer
creation, allowing it to fail with an error if the placement is
exhausted.
This allows existing fallback options for stolen backend allocation like
create_ring_vma to work as expected.

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
---
 .../gpu/drm/i915/gem/i915_gem_object_types.h  | 13 ++++++----
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c       | 25 ++++++++++++++++++-
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
index 6632ed52e919..07bc11247a3e 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
@@ -325,17 +325,20 @@ struct drm_i915_gem_object {
  * dealing with userspace objects the CPU fault handler is free to ignore this.
  */
 #define I915_BO_ALLOC_GPU_ONLY	  BIT(6)
+/* object should be pinned in destination region from allocation */
+#define I915_BO_ALLOC_PINNED	  BIT(7)
 #define I915_BO_ALLOC_FLAGS (I915_BO_ALLOC_CONTIGUOUS | \
 			     I915_BO_ALLOC_VOLATILE | \
 			     I915_BO_ALLOC_CPU_CLEAR | \
 			     I915_BO_ALLOC_USER | \
 			     I915_BO_ALLOC_PM_VOLATILE | \
 			     I915_BO_ALLOC_PM_EARLY | \
-			     I915_BO_ALLOC_GPU_ONLY)
-#define I915_BO_READONLY          BIT(7)
-#define I915_TILING_QUIRK_BIT     8 /* unknown swizzling; do not release! */
-#define I915_BO_PROTECTED         BIT(9)
-#define I915_BO_WAS_BOUND_BIT     10
+			     I915_BO_ALLOC_GPU_ONLY | \
+			     I915_BO_ALLOC_PINNED)
+#define I915_BO_READONLY          BIT(8)
+#define I915_TILING_QUIRK_BIT     9 /* unknown swizzling; do not release! */
+#define I915_BO_PROTECTED         BIT(10)
+#define I915_BO_WAS_BOUND_BIT     11
 	/**
 	 * @mem_flags - Mutable placement-related flags
 	 *
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
index 27d59639177f..bb988608296d 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
@@ -998,6 +998,13 @@ static void i915_ttm_delayed_free(struct drm_i915_gem_object *obj)
 {
 	GEM_BUG_ON(!obj->ttm.created);
 
+	/* stolen objects are pinned for lifetime. Unpin before putting */
+	if (obj->flags & I915_BO_ALLOC_PINNED) {
+		ttm_bo_reserve(i915_gem_to_ttm(obj), true, false, NULL);
+		ttm_bo_unpin(i915_gem_to_ttm(obj));
+		ttm_bo_unreserve(i915_gem_to_ttm(obj));
+	}
+
 	ttm_bo_put(i915_gem_to_ttm(obj));
 }
 
@@ -1193,6 +1200,9 @@ int __i915_gem_ttm_object_init(struct intel_memory_region *mem,
 		.no_wait_gpu = false,
 	};
 	enum ttm_bo_type bo_type;
+	struct ttm_place _place;
+	struct ttm_placement _placement;
+	struct ttm_placement *placement;
 	int ret;
 
 	drm_gem_private_object_init(&i915->drm, &obj->base, size);
@@ -1222,6 +1232,17 @@ int __i915_gem_ttm_object_init(struct intel_memory_region *mem,
 	 */
 	i915_gem_object_make_unshrinkable(obj);
 
+	if (obj->flags & I915_BO_ALLOC_PINNED) {
+		i915_ttm_place_from_region(mem, &_place, obj->bo_offset,
+					   obj->base.size, obj->flags);
+		_placement.num_placement = 1;
+		_placement.placement = &_place;
+		_placement.num_busy_placement = 0;
+		_placement.busy_placement = NULL;
+		placement = &_placement;
+	} else {
+		placement = &i915_sys_placement;
+	}
 	/*
 	 * If this function fails, it will call the destructor, but
 	 * our caller still owns the object. So no freeing in the
@@ -1230,7 +1251,7 @@ int __i915_gem_ttm_object_init(struct intel_memory_region *mem,
 	 * until successful initialization.
 	 */
 	ret = ttm_bo_init_reserved(&i915->bdev, i915_gem_to_ttm(obj), size,
-				   bo_type, &i915_sys_placement,
+				   bo_type, placement,
 				   page_size >> PAGE_SHIFT,
 				   &ctx, NULL, NULL, i915_ttm_bo_destroy);
 	if (ret)
@@ -1242,6 +1263,8 @@ int __i915_gem_ttm_object_init(struct intel_memory_region *mem,
 	i915_ttm_adjust_domains_after_move(obj);
 	i915_ttm_adjust_gem_after_move(obj);
 	obj->ttm.cache_level_override = false;
+	if (obj->flags & I915_BO_ALLOC_PINNED)
+		ttm_bo_pin(i915_gem_to_ttm(obj));
 	i915_gem_object_unlock(obj);
 
 	return 0;
-- 
2.25.1

