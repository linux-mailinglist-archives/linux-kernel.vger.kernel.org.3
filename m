Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A9B5737FF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbiGMNvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbiGMNuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:50:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C541101D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:50:45 -0700 (PDT)
Received: from hermes-devbox.fritz.box (82-71-8-225.dsl.in-addr.zen.co.uk [82.71.8.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbeckett)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3BA826601A42;
        Wed, 13 Jul 2022 14:50:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657720244;
        bh=H6QlfEuriJtw1/NA7lWyiANIdXYFtf4ysx03rel14ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bJH4d8VDeA/I/FMZiMxkI/hIuOa5Ke4e/9JqpO71A7fZXvoUYMkFPf43NVpvFboQw
         JYFGXqq0Uzlcb05Qiw1ncJS6IIqtB/DlZZ8FIxYFBYpeAjnrC4davzq+ISQkSuTUS7
         SnN9KkrfjbtYxhxFDDdR8PuX1MB1wOiha+/of1UJKBXXtO0vffQmEh6JwjXF6S95eo
         tEC8z4GUnaA+/Keduw8cGfX/vhbSHofbdokpX6Vtgi2c9CicQo0tqaeRnwr/k7jkWJ
         RRRgPL8zkE1MR63zr0LV66/1Lw5XkqiWSEq5HbeyeRSFG96oum/lHaJeV0jaTxXtKQ
         rjKGHfr+efxSA==
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
Subject: [PATCH v11 07/10] drm/i915/ttm: add buffer pin on alloc flag
Date:   Wed, 13 Jul 2022 14:50:19 +0100
Message-Id: <20220713135022.3710682-8-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713135022.3710682-1-bob.beckett@collabora.com>
References: <20220713135022.3710682-1-bob.beckett@collabora.com>
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
index 14937cf1daaa..283a4b84971a 100644
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
index b6c3fc25d9d1..d34ebe9fcff8 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
@@ -1011,6 +1011,13 @@ static void i915_ttm_delayed_free(struct drm_i915_gem_object *obj)
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
 
@@ -1206,6 +1213,9 @@ int __i915_gem_ttm_object_init(struct intel_memory_region *mem,
 		.no_wait_gpu = false,
 	};
 	enum ttm_bo_type bo_type;
+	struct ttm_place _place;
+	struct ttm_placement _placement;
+	struct ttm_placement *placement;
 	int ret;
 
 	drm_gem_private_object_init(&i915->drm, &obj->base, size);
@@ -1235,6 +1245,17 @@ int __i915_gem_ttm_object_init(struct intel_memory_region *mem,
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
@@ -1243,7 +1264,7 @@ int __i915_gem_ttm_object_init(struct intel_memory_region *mem,
 	 * until successful initialization.
 	 */
 	ret = ttm_bo_init_reserved(&i915->bdev, i915_gem_to_ttm(obj), bo_type,
-				   &i915_sys_placement, page_size >> PAGE_SHIFT,
+				   placement, page_size >> PAGE_SHIFT,
 				   &ctx, NULL, NULL, i915_ttm_bo_destroy);
 	if (ret)
 		return i915_ttm_err_to_gem(ret);
@@ -1254,6 +1275,8 @@ int __i915_gem_ttm_object_init(struct intel_memory_region *mem,
 	i915_ttm_adjust_domains_after_move(obj);
 	i915_ttm_adjust_gem_after_move(obj);
 	obj->ttm.cache_level_override = false;
+	if (obj->flags & I915_BO_ALLOC_PINNED)
+		ttm_bo_pin(i915_gem_to_ttm(obj));
 	i915_gem_object_unlock(obj);
 
 	return 0;
-- 
2.25.1

