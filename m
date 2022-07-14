Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2F0574D01
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239206AbiGNMHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238763AbiGNMGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:06:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB13D5C9CA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:06:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A80B361E8E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 12:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D36C36AE3;
        Thu, 14 Jul 2022 12:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657800391;
        bh=yt90ppBxO/WNPx21IesnAkxXE1xMFUHh69ZWkMm8KMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=slRWeGHd9aN72f8GJZQMbd/Xm+p8HW3AHqRBx3GB7Imi1CPL/fYef3pioS+Fc7cXd
         v3bv3gfACGSc4rXIRc89jzdXyt4EM5BtOXfATgO936C5HvgXWJadpjBvoM8NKETmwO
         HPifawyR4foRJNr+FeyLQfEs1BYqOZW3wgJGLYibN+wmvN79x3ROwyF9B6Z5IIqilp
         Fyk9r5VzUcY3TeABBUOgWS/Eae6C1FChXSvn2q2o4gcGrPZJqU8qaH0jizqXHx6GxL
         bwdVaij1tratfSLT2pdFDkjs7Q9X4GRSz2kRVPD9LPbpe3gt1e8N0I5W4ibwG57nM+
         Kg/FME30aEoVQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBxbw-0059t6-2O;
        Thu, 14 Jul 2022 13:06:28 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Chris Wilson <chris.p.wilson@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Ayaz A Siddiqui <ayaz.siddiqui@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        John Harrison <John.C.Harrison@Intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Cheng <michael.cheng@intel.com>,
        Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>,
        Ramalingam C <ramalingam.c@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Fei Yang <fei.yang@intel.com>
Subject: [PATCH v2 13/21] drm/i915: Invalidate the TLBs on each GT
Date:   Thu, 14 Jul 2022 13:06:18 +0100
Message-Id: <eec639a0d38970d4ee621990eefed81e52fff309.1657800199.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657800199.git.mchehab@kernel.org>
References: <cover.1657800199.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wilson <chris.p.wilson@intel.com>

With multi-GT devices, the object may have been bound on each GT.
Invalidate the TLBs across all GT before releasing the pages
back to the system.

Signed-off-by: Chris Wilson <chris.p.wilson@intel.com>
Cc: Fei Yang <fei.yang@intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/21] at: https://lore.kernel.org/all/cover.1657800199.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/gem/i915_gem_object_types.h |  4 +++-
 drivers/gpu/drm/i915/gem/i915_gem_pages.c        | 13 ++++++++-----
 drivers/gpu/drm/i915/gt/intel_engine.h           |  1 +
 drivers/gpu/drm/i915/gt/intel_gt_buffer_pool.h   |  3 ++-
 drivers/gpu/drm/i915/gt/intel_gt_defines.h       | 11 +++++++++++
 drivers/gpu/drm/i915/gt/intel_gt_types.h         |  4 +++-
 drivers/gpu/drm/i915/gt/intel_ppgtt.c            |  4 ++--
 drivers/gpu/drm/i915/i915_drv.h                  |  1 -
 drivers/gpu/drm/i915/i915_vma.c                  | 14 +++++++++++---
 drivers/gpu/drm/i915/i915_vma.h                  |  2 +-
 10 files changed, 42 insertions(+), 15 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_defines.h

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
index 9f6b14ec189a..3c1d0b750a67 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
@@ -17,6 +17,8 @@
 #include "i915_selftest.h"
 #include "i915_vma_resource.h"
 
+#include "gt/intel_gt_defines.h"
+
 struct drm_i915_gem_object;
 struct intel_fronbuffer;
 struct intel_memory_region;
@@ -616,7 +618,7 @@ struct drm_i915_gem_object {
 		 */
 		bool dirty:1;
 
-		u32 tlb;
+		u32 tlb[I915_MAX_GT];
 	} mm;
 
 	struct {
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_pages.c b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
index 1cd76cc5d9f3..4a6a2f2e8148 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_pages.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
@@ -194,13 +194,16 @@ static void unmap_object(struct drm_i915_gem_object *obj, void *ptr)
 static void flush_tlb_invalidate(struct drm_i915_gem_object *obj)
 {
 	struct drm_i915_private *i915 = to_i915(obj->base.dev);
-	struct intel_gt *gt = to_gt(i915);
+	struct intel_gt *gt;
+	int id;
 
-	if (!obj->mm.tlb)
-		return;
+	for_each_gt(gt, i915, id) {
+		if (!obj->mm.tlb[id])
+			continue;
 
-	intel_gt_invalidate_tlb_full(gt, obj->mm.tlb);
-	obj->mm.tlb = 0;
+		intel_gt_invalidate_tlb_full(gt, obj->mm.tlb[id]);
+		obj->mm.tlb[id] = 0;
+	}
 }
 
 struct sg_table *
diff --git a/drivers/gpu/drm/i915/gt/intel_engine.h b/drivers/gpu/drm/i915/gt/intel_engine.h
index 04e435bce79b..fe1dc55bf8f7 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine.h
+++ b/drivers/gpu/drm/i915/gt/intel_engine.h
@@ -18,6 +18,7 @@
 #include "intel_gt_types.h"
 #include "intel_timeline.h"
 #include "intel_workarounds.h"
+#include "uc/intel_guc_submission.h"
 
 struct drm_printer;
 struct intel_context;
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_buffer_pool.h b/drivers/gpu/drm/i915/gt/intel_gt_buffer_pool.h
index 487b8a5520f1..8d41cf0c937a 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_buffer_pool.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_buffer_pool.h
@@ -11,8 +11,9 @@
 #include "i915_active.h"
 #include "intel_gt_buffer_pool_types.h"
 
-struct intel_gt;
+enum i915_map_type;
 struct i915_request;
+struct intel_gt;
 
 struct intel_gt_buffer_pool_node *
 intel_gt_get_buffer_pool(struct intel_gt *gt, size_t size,
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_defines.h b/drivers/gpu/drm/i915/gt/intel_gt_defines.h
new file mode 100644
index 000000000000..7c711726d663
--- /dev/null
+++ b/drivers/gpu/drm/i915/gt/intel_gt_defines.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2019 Intel Corporation
+ */
+
+#ifndef __INTEL_GT_DEFINES__
+#define __INTEL_GT_DEFINES__
+
+#define I915_MAX_GT 4
+
+#endif
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_types.h b/drivers/gpu/drm/i915/gt/intel_gt_types.h
index 3804a583382b..b857c3972251 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_types.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_types.h
@@ -19,7 +19,6 @@
 #include "uc/intel_uc.h"
 #include "intel_gsc.h"
 
-#include "i915_vma.h"
 #include "intel_engine_types.h"
 #include "intel_gt_buffer_pool_types.h"
 #include "intel_hwconfig.h"
@@ -31,8 +30,11 @@
 #include "intel_wakeref.h"
 #include "pxp/intel_pxp_types.h"
 
+#include "intel_gt_defines.h"
+
 struct drm_i915_private;
 struct i915_ggtt;
+struct i915_vma;
 struct intel_engine_cs;
 struct intel_uncore;
 
diff --git a/drivers/gpu/drm/i915/gt/intel_ppgtt.c b/drivers/gpu/drm/i915/gt/intel_ppgtt.c
index 2da6c82a8bd2..f764d250e929 100644
--- a/drivers/gpu/drm/i915/gt/intel_ppgtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_ppgtt.c
@@ -8,6 +8,7 @@
 #include "gem/i915_gem_lmem.h"
 
 #include "i915_trace.h"
+#include "intel_gt.h"
 #include "intel_gtt.h"
 #include "gen6_ppgtt.h"
 #include "gen8_ppgtt.h"
@@ -210,8 +211,7 @@ void ppgtt_unbind_vma(struct i915_address_space *vm,
 		return;
 
 	vm->clear_range(vm, vma_res->start, vma_res->vma_size);
-	if (vma_res->tlb)
-		vma_invalidate_tlb(vm, *vma_res->tlb);
+	vma_invalidate_tlb(vm, vma_res->tlb);
 }
 
 static unsigned long pd_count(u64 size, int shift)
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index d25647be25d1..f1f70257dbe0 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -711,7 +711,6 @@ struct drm_i915_private {
 	/*
 	 * i915->gt[0] == &i915->gt0
 	 */
-#define I915_MAX_GT 4
 	struct intel_gt *gt[I915_MAX_GT];
 
 	struct kobject *sysfs_gt;
diff --git a/drivers/gpu/drm/i915/i915_vma.c b/drivers/gpu/drm/i915/i915_vma.c
index fe947d1456d5..5edc745dcc51 100644
--- a/drivers/gpu/drm/i915/i915_vma.c
+++ b/drivers/gpu/drm/i915/i915_vma.c
@@ -1309,8 +1309,14 @@ I915_SELFTEST_EXPORT int i915_vma_get_pages(struct i915_vma *vma)
 	return err;
 }
 
-void vma_invalidate_tlb(struct i915_address_space *vm, u32 tlb)
+void vma_invalidate_tlb(struct i915_address_space *vm, u32 *tlb)
 {
+	struct intel_gt *gt;
+	int id;
+
+	if (!tlb)
+		return;
+
 	/*
 	 * Before we release the pages that were bound by this vma, we
 	 * must invalidate all the TLBs that may still have a reference
@@ -1319,7 +1325,9 @@ void vma_invalidate_tlb(struct i915_address_space *vm, u32 tlb)
 	 * the most recent TLB invalidation seqno, and if we have not yet
 	 * flushed the TLBs upon release, perform a full invalidation.
 	 */
-	WRITE_ONCE(tlb, intel_gt_next_invalidate_tlb_full(vm->gt));
+	for_each_gt(gt, vm->i915, id)
+		WRITE_ONCE(tlb[id],
+			   intel_gt_next_invalidate_tlb_full(vm->gt));
 }
 
 static void __vma_put_pages(struct i915_vma *vma, unsigned int count)
@@ -1955,7 +1963,7 @@ struct dma_fence *__i915_vma_evict(struct i915_vma *vma, bool async)
 
 	if (async)
 		unbind_fence = i915_vma_resource_unbind(vma_res,
-							&vma->obj->mm.tlb);
+							vma->obj->mm.tlb);
 	else
 		unbind_fence = i915_vma_resource_unbind(vma_res, NULL);
 
diff --git a/drivers/gpu/drm/i915/i915_vma.h b/drivers/gpu/drm/i915/i915_vma.h
index 5048eed536da..33a58f605d75 100644
--- a/drivers/gpu/drm/i915/i915_vma.h
+++ b/drivers/gpu/drm/i915/i915_vma.h
@@ -213,7 +213,7 @@ bool i915_vma_misplaced(const struct i915_vma *vma,
 			u64 size, u64 alignment, u64 flags);
 void __i915_vma_set_map_and_fenceable(struct i915_vma *vma);
 void i915_vma_revoke_mmap(struct i915_vma *vma);
-void vma_invalidate_tlb(struct i915_address_space *vm, u32 tlb);
+void vma_invalidate_tlb(struct i915_address_space *vm, u32 *tlb);
 struct dma_fence *__i915_vma_evict(struct i915_vma *vma, bool async);
 int __i915_vma_unbind(struct i915_vma *vma);
 int __must_check i915_vma_unbind(struct i915_vma *vma);
-- 
2.36.1

