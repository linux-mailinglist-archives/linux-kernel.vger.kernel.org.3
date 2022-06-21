Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA04553B06
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354178AbiFUUBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351072AbiFUUBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:01:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35CA2A703
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:01:16 -0700 (PDT)
Received: from hermes-devbox.fritz.box (82-71-8-225.dsl.in-addr.zen.co.uk [82.71.8.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbeckett)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 50DB6660183C;
        Tue, 21 Jun 2022 21:01:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655841675;
        bh=4aLhOjNbnMWEd5TE2kdvFPY0DN2hydFT2IvNHlkBa+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YvCD0K/XPoYH0tx3Gogj5YpyR7uG1VVqDV+tGkv0NoWS93A40MLTfB9cBsWNZrOEa
         7Epty8sVdQIXc+ro6EBiY0xSj6d/aVMVI7Y5vvO+kcllROzS6ZxAj5P6KY1TqT5rWo
         Kgx+xKtEmyoeI0kXvDqxfCOyKgHRTpkNpoHVchV268FWRvh25rKKGQdPlAys4pN3j9
         6fraV1r3dYdv73sIMBIXBUan7bson7nV0lex9SxdTILgMx2llAu+Md4j2lZ2eSyiq3
         FbOcQvMDLRZWV1tqg8MYOBckbh6CNiJFCWENFISNmVpy9vF/unhB0W7R/gjK4Z2+1Q
         KiOmQPYulYwIA==
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
Subject: [PATCH v8 05/10] drm/i915: instantiate ttm ranger manager for stolen memory
Date:   Tue, 21 Jun 2022 20:00:53 +0000
Message-Id: <20220621200058.3536182-6-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220621200058.3536182-1-bob.beckett@collabora.com>
References: <20220621200058.3536182-1-bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prepare for ttm based stolen region by using ttm range manager
as the resource manager for stolen region.

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c |  6 ++--
 drivers/gpu/drm/i915/intel_region_ttm.c      | 31 +++++++++++++++-----
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
index 40249fa28a7a..675e9ab30396 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
@@ -60,11 +60,13 @@ i915_ttm_region(struct ttm_device *bdev, int ttm_mem_type)
 	struct drm_i915_private *i915 = container_of(bdev, typeof(*i915), bdev);
 
 	/* There's some room for optimization here... */
-	GEM_BUG_ON(ttm_mem_type != I915_PL_SYSTEM &&
-		   ttm_mem_type < I915_PL_LMEM0);
+	GEM_BUG_ON(ttm_mem_type == I915_PL_GGTT);
+
 	if (ttm_mem_type == I915_PL_SYSTEM)
 		return intel_memory_region_lookup(i915, INTEL_MEMORY_SYSTEM,
 						  0);
+	if (ttm_mem_type == I915_PL_STOLEN)
+		return i915->mm.stolen_region;
 
 	return intel_memory_region_lookup(i915, INTEL_MEMORY_LOCAL,
 					  ttm_mem_type - I915_PL_LMEM0);
diff --git a/drivers/gpu/drm/i915/intel_region_ttm.c b/drivers/gpu/drm/i915/intel_region_ttm.c
index fd2ecfdd8fa1..694e9acb69e2 100644
--- a/drivers/gpu/drm/i915/intel_region_ttm.c
+++ b/drivers/gpu/drm/i915/intel_region_ttm.c
@@ -54,7 +54,7 @@ void intel_region_ttm_device_fini(struct drm_i915_private *dev_priv)
 
 /*
  * Map the i915 memory regions to TTM memory types. We use the
- * driver-private types for now, reserving TTM_PL_VRAM for stolen
+ * driver-private types for now, reserving I915_PL_STOLEN for stolen
  * memory and TTM_PL_TT for GGTT use if decided to implement this.
  */
 int intel_region_to_ttm_type(const struct intel_memory_region *mem)
@@ -63,11 +63,17 @@ int intel_region_to_ttm_type(const struct intel_memory_region *mem)
 
 	GEM_BUG_ON(mem->type != INTEL_MEMORY_LOCAL &&
 		   mem->type != INTEL_MEMORY_MOCK &&
-		   mem->type != INTEL_MEMORY_SYSTEM);
+		   mem->type != INTEL_MEMORY_SYSTEM &&
+		   mem->type != INTEL_MEMORY_STOLEN_SYSTEM &&
+		   mem->type != INTEL_MEMORY_STOLEN_LOCAL);
 
 	if (mem->type == INTEL_MEMORY_SYSTEM)
 		return TTM_PL_SYSTEM;
 
+	if (mem->type == INTEL_MEMORY_STOLEN_SYSTEM ||
+	    mem->type == INTEL_MEMORY_STOLEN_LOCAL)
+		return I915_PL_STOLEN;
+
 	type = mem->instance + TTM_PL_PRIV;
 	GEM_BUG_ON(type >= TTM_NUM_MEM_TYPES);
 
@@ -91,10 +97,16 @@ int intel_region_ttm_init(struct intel_memory_region *mem)
 	int mem_type = intel_region_to_ttm_type(mem);
 	int ret;
 
-	ret = i915_ttm_buddy_man_init(bdev, mem_type, false,
-				      resource_size(&mem->region),
-				      mem->io_size,
-				      mem->min_page_size, PAGE_SIZE);
+	if (mem_type == I915_PL_STOLEN) {
+		ret = ttm_range_man_init(bdev, mem_type, false,
+					 resource_size(&mem->region) >> PAGE_SHIFT);
+		mem->is_range_manager = true;
+	} else {
+		ret = i915_ttm_buddy_man_init(bdev, mem_type, false,
+					      resource_size(&mem->region),
+					      mem->io_size,
+					      mem->min_page_size, PAGE_SIZE);
+	}
 	if (ret)
 		return ret;
 
@@ -114,6 +126,7 @@ int intel_region_ttm_init(struct intel_memory_region *mem)
 int intel_region_ttm_fini(struct intel_memory_region *mem)
 {
 	struct ttm_resource_manager *man = mem->region_private;
+	int mem_type = intel_region_to_ttm_type(mem);
 	int ret = -EBUSY;
 	int count;
 
@@ -144,8 +157,10 @@ int intel_region_ttm_fini(struct intel_memory_region *mem)
 	if (ret || !man)
 		return ret;
 
-	ret = i915_ttm_buddy_man_fini(&mem->i915->bdev,
-				      intel_region_to_ttm_type(mem));
+	if (mem_type == I915_PL_STOLEN)
+		ret = ttm_range_man_fini(&mem->i915->bdev, mem_type);
+	else
+		ret = i915_ttm_buddy_man_fini(&mem->i915->bdev, mem_type);
 	GEM_WARN_ON(ret);
 	mem->region_private = NULL;
 
-- 
2.25.1

