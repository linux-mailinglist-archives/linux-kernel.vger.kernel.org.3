Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D2550A871
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391569AbiDUSxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391525AbiDUSww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:52:52 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1C863F4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 11:50:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id 7D4CD1F45B9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650566998;
        bh=4lkEaK+tGV/Iygaw6i15VKgZAMgQnTCuG7b9sgm7nuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MY1I8sz/PL18obledX+o6Z8Imr7P6r6qzzzWsJTWC+S6g/nOt17Sj0X8kB2Amc8Ox
         gZEW+JEFj7hMvZb4fGqtIiqBsH3JPanmRP7OOCTYC3yXwMR4WErjZCdu7+ku/nLlL5
         S33vtN2ZS6Ll4TqRWXzJmlW38WwMxlNXS/lDDYmTVIQrf1vIfKpOKNTUgpAGPPD8i2
         jI4QuwiVSzEcFjkxJUu+7YoD5k6r6uLFV0cil7N1c7v0FY42JKT2Op7t3hdtO6WJR5
         cyVv7UIQcWiM7pAxBLbDsJYV8n8WAvfDtLDhWmkK+1aWmjoGvHKreJB8sU1TyGShIk
         OdTJAz4nHBe+g==
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
Subject: [PATCH v4 1/6] drm/i915: instantiate ttm ranger manager for stolen memory
Date:   Thu, 21 Apr 2022 18:49:36 +0000
Message-Id: <20220421184941.428639-2-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421184941.428639-1-bob.beckett@collabora.com>
References: <20220421184941.428639-1-bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prepare for ttm based stolen region by using ttm range manager
as the resource manager for stolen region.

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c |  6 ++--
 drivers/gpu/drm/i915/intel_region_ttm.c      | 31 +++++++++++++++-----
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
index a10716f4e717..358f8a1a30ce 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
@@ -58,11 +58,13 @@ i915_ttm_region(struct ttm_device *bdev, int ttm_mem_type)
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
index 62ff77445b01..7d49ea72e33f 100644
--- a/drivers/gpu/drm/i915/intel_region_ttm.c
+++ b/drivers/gpu/drm/i915/intel_region_ttm.c
@@ -49,7 +49,7 @@ void intel_region_ttm_device_fini(struct drm_i915_private *dev_priv)
 
 /*
  * Map the i915 memory regions to TTM memory types. We use the
- * driver-private types for now, reserving TTM_PL_VRAM for stolen
+ * driver-private types for now, reserving I915_PL_STOLEN for stolen
  * memory and TTM_PL_TT for GGTT use if decided to implement this.
  */
 int intel_region_to_ttm_type(const struct intel_memory_region *mem)
@@ -58,11 +58,17 @@ int intel_region_to_ttm_type(const struct intel_memory_region *mem)
 
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
 
@@ -86,10 +92,16 @@ int intel_region_ttm_init(struct intel_memory_region *mem)
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
 
@@ -109,6 +121,7 @@ int intel_region_ttm_init(struct intel_memory_region *mem)
 int intel_region_ttm_fini(struct intel_memory_region *mem)
 {
 	struct ttm_resource_manager *man = mem->region_private;
+	int mem_type = intel_region_to_ttm_type(mem);
 	int ret = -EBUSY;
 	int count;
 
@@ -139,8 +152,10 @@ int intel_region_ttm_fini(struct intel_memory_region *mem)
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

