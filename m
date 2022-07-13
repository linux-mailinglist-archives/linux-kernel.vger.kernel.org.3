Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEB55732B8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbiGMJbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbiGMJag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:30:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF09F421B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:30:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF9B9B81D79
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144D5C341CF;
        Wed, 13 Jul 2022 09:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657704622;
        bh=4SyRnJAg34ibNLvFHYlDtmr/HWuPBiGZKsyFILogPEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PVlDy0yocMPcpGSKVou4jQyLUEbqYN3P5mded5lyz/DNnqVUuUs49EBDlfrSK1/27
         bempnHCev0vlGgXlieSxuVtQUGCwQc4TY+ap31ESK6Ug64U0okxvj9uiDYrQgWQH2H
         u01ysvV+RBEncFemMZ1tshxtxFr1//9G1MTRvofxhpbrvAVYjZmV7NQivLJxbTJpB7
         W3oAHkkOB2kxDM09K48SO+TuhzHSuKOmo2FyVgT3Hdkcym05EjQe+KgWv9RPQxho5I
         F9gGrzKwCRot3gsIiB4GqYEKpp0K8Lfp99prbKEVPoO7PrJf42J/JPYdU3QhAwxTYE
         L/XdsnL48niSA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBYhH-0050LX-Me;
        Wed, 13 Jul 2022 10:30:19 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Chris Wilson <chris.p.wilson@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Casey Bowman <casey.g.bowman@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Fei Yang <fei.yang@intel.com>
Subject: [PATCH 08/21] drm/i915/gt: Move TLB invalidation to its own file
Date:   Wed, 13 Jul 2022 10:30:05 +0100
Message-Id: <77b408e130cf8a0461a7d929ce5b5380305cad9c.1657703926.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657703926.git.mchehab@kernel.org>
References: <cover.1657703926.git.mchehab@kernel.org>
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

Prepare for supporting more TLB invalidation scenarios by moving
the current MMIO invalidation to its own file.

Signed-off-by: Chris Wilson <chris.p.wilson@intel.com>
Cc: Fei Yang <fei.yang@intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH 00/21] at: https://lore.kernel.org/all/cover.1657703926.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/Makefile             |   1 +
 drivers/gpu/drm/i915/gem/i915_gem_pages.c |   4 +-
 drivers/gpu/drm/i915/gt/intel_gt.c        | 168 +-------------------
 drivers/gpu/drm/i915/gt/intel_gt.h        |  12 --
 drivers/gpu/drm/i915/gt/intel_tlb.c       | 183 ++++++++++++++++++++++
 drivers/gpu/drm/i915/gt/intel_tlb.h       |  29 ++++
 drivers/gpu/drm/i915/i915_vma.c           |   1 +
 7 files changed, 219 insertions(+), 179 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/gt/intel_tlb.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_tlb.h

diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 522ef9b4aff3..d3df9832d1f7 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -126,6 +126,7 @@ gt-y += \
 	gt/intel_sseu.o \
 	gt/intel_sseu_debugfs.o \
 	gt/intel_timeline.o \
+	gt/intel_tlb.o \
 	gt/intel_workarounds.o \
 	gt/shmem_utils.o \
 	gt/sysfs_engines.o
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_pages.c b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
index 8357dbdcab5c..1cd76cc5d9f3 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_pages.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
@@ -7,7 +7,7 @@
 #include <drm/drm_cache.h>
 
 #include "gt/intel_gt.h"
-#include "gt/intel_gt_pm.h"
+#include "gt/intel_tlb.h"
 
 #include "i915_drv.h"
 #include "i915_gem_object.h"
@@ -199,7 +199,7 @@ static void flush_tlb_invalidate(struct drm_i915_gem_object *obj)
 	if (!obj->mm.tlb)
 		return;
 
-	intel_gt_invalidate_tlb(gt, obj->mm.tlb);
+	intel_gt_invalidate_tlb_full(gt, obj->mm.tlb);
 	obj->mm.tlb = 0;
 }
 
diff --git a/drivers/gpu/drm/i915/gt/intel_gt.c b/drivers/gpu/drm/i915/gt/intel_gt.c
index f435e06125aa..18d82cd620bd 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt.c
@@ -11,9 +11,7 @@
 #include "pxp/intel_pxp.h"
 
 #include "i915_drv.h"
-#include "i915_perf_oa_regs.h"
 #include "intel_context.h"
-#include "intel_engine_pm.h"
 #include "intel_engine_regs.h"
 #include "intel_ggtt_gmch.h"
 #include "intel_gt.h"
@@ -31,6 +29,7 @@
 #include "intel_renderstate.h"
 #include "intel_rps.h"
 #include "intel_gt_sysfs.h"
+#include "intel_tlb.h"
 #include "intel_uncore.h"
 #include "shmem_utils.h"
 
@@ -48,8 +47,7 @@ static void __intel_gt_init_early(struct intel_gt *gt)
 	intel_gt_init_reset(gt);
 	intel_gt_init_requests(gt);
 	intel_gt_init_timelines(gt);
-	mutex_init(&gt->tlb.invalidate_lock);
-	seqcount_mutex_init(&gt->tlb.seqno, &gt->tlb.invalidate_lock);
+	intel_gt_init_tlb(gt);
 	intel_gt_pm_init_early(gt);
 
 	intel_uc_init_early(&gt->uc);
@@ -770,7 +768,7 @@ void intel_gt_driver_late_release_all(struct drm_i915_private *i915)
 		intel_gt_fini_requests(gt);
 		intel_gt_fini_reset(gt);
 		intel_gt_fini_timelines(gt);
-		mutex_destroy(&gt->tlb.invalidate_lock);
+		intel_gt_fini_tlb(gt);
 		intel_engines_free(gt);
 	}
 }
@@ -881,163 +879,3 @@ void intel_gt_info_print(const struct intel_gt_info *info,
 
 	intel_sseu_dump(&info->sseu, p);
 }
-
-struct reg_and_bit {
-	i915_reg_t reg;
-	u32 bit;
-};
-
-static struct reg_and_bit
-get_reg_and_bit(const struct intel_engine_cs *engine, const bool gen8,
-		const i915_reg_t *regs, const unsigned int num)
-{
-	const unsigned int class = engine->class;
-	struct reg_and_bit rb = { };
-
-	if (drm_WARN_ON_ONCE(&engine->i915->drm,
-			     class >= num || !regs[class].reg))
-		return rb;
-
-	rb.reg = regs[class];
-	if (gen8 && class == VIDEO_DECODE_CLASS)
-		rb.reg.reg += 4 * engine->instance; /* GEN8_M2TCR */
-	else
-		rb.bit = engine->instance;
-
-	rb.bit = BIT(rb.bit);
-
-	return rb;
-}
-
-static void mmio_invalidate_full(struct intel_gt *gt)
-{
-	static const i915_reg_t gen8_regs[] = {
-		[RENDER_CLASS]			= GEN8_RTCR,
-		[VIDEO_DECODE_CLASS]		= GEN8_M1TCR, /* , GEN8_M2TCR */
-		[VIDEO_ENHANCEMENT_CLASS]	= GEN8_VTCR,
-		[COPY_ENGINE_CLASS]		= GEN8_BTCR,
-	};
-	static const i915_reg_t gen12_regs[] = {
-		[RENDER_CLASS]			= GEN12_GFX_TLB_INV_CR,
-		[VIDEO_DECODE_CLASS]		= GEN12_VD_TLB_INV_CR,
-		[VIDEO_ENHANCEMENT_CLASS]	= GEN12_VE_TLB_INV_CR,
-		[COPY_ENGINE_CLASS]		= GEN12_BLT_TLB_INV_CR,
-		[COMPUTE_CLASS]			= GEN12_COMPCTX_TLB_INV_CR,
-	};
-	struct drm_i915_private *i915 = gt->i915;
-	struct intel_uncore *uncore = gt->uncore;
-	struct intel_engine_cs *engine;
-	intel_engine_mask_t awake, tmp;
-	enum intel_engine_id id;
-	const i915_reg_t *regs;
-	unsigned int num = 0;
-
-	if (GRAPHICS_VER(i915) == 12) {
-		regs = gen12_regs;
-		num = ARRAY_SIZE(gen12_regs);
-	} else if (GRAPHICS_VER(i915) >= 8 && GRAPHICS_VER(i915) <= 11) {
-		regs = gen8_regs;
-		num = ARRAY_SIZE(gen8_regs);
-	} else if (GRAPHICS_VER(i915) < 8) {
-		return;
-	}
-
-	if (drm_WARN_ONCE(&i915->drm, !num,
-			  "Platform does not implement TLB invalidation!"))
-		return;
-
-	intel_uncore_forcewake_get(uncore, FORCEWAKE_ALL);
-
-	spin_lock_irq(&uncore->lock); /* serialise invalidate with GT reset */
-
-	awake = 0;
-	for_each_engine(engine, gt, id) {
-		struct reg_and_bit rb;
-
-		if (!intel_engine_pm_is_awake(engine))
-			continue;
-
-		rb = get_reg_and_bit(engine, regs == gen8_regs, regs, num);
-		if (!i915_mmio_reg_offset(rb.reg))
-			continue;
-
-		intel_uncore_write_fw(uncore, rb.reg, rb.bit);
-		awake |= engine->mask;
-	}
-
-	GT_TRACE(gt, "invalidated engines %08x\n", awake);
-
-	/* Wa_2207587034:tgl,dg1,rkl,adl-s,adl-p */
-	if (awake &&
-	    (IS_TIGERLAKE(i915) ||
-	     IS_DG1(i915) ||
-	     IS_ROCKETLAKE(i915) ||
-	     IS_ALDERLAKE_S(i915) ||
-	     IS_ALDERLAKE_P(i915)))
-		intel_uncore_write_fw(uncore, GEN12_OA_TLB_INV_CR, 1);
-
-	spin_unlock_irq(&uncore->lock);
-
-	for_each_engine_masked(engine, gt, awake, tmp) {
-		struct reg_and_bit rb;
-
-		/*
-		 * HW architecture suggest typical invalidation time at 40us,
-		 * with pessimistic cases up to 100us and a recommendation to
-		 * cap at 1ms. We go a bit higher just in case.
-		 */
-		const unsigned int timeout_us = 100;
-		const unsigned int timeout_ms = 4;
-
-		rb = get_reg_and_bit(engine, regs == gen8_regs, regs, num);
-		if (__intel_wait_for_register_fw(uncore,
-						 rb.reg, rb.bit, 0,
-						 timeout_us, timeout_ms,
-						 NULL))
-			drm_err_ratelimited(&gt->i915->drm,
-					    "%s TLB invalidation did not complete in %ums!\n",
-					    engine->name, timeout_ms);
-	}
-
-	/*
-	 * Use delayed put since a) we mostly expect a flurry of TLB
-	 * invalidations so it is good to avoid paying the forcewake cost and
-	 * b) it works around a bug in Icelake which cannot cope with too rapid
-	 * transitions.
-	 */
-	intel_uncore_forcewake_put_delayed(uncore, FORCEWAKE_ALL);
-}
-
-static bool tlb_seqno_passed(const struct intel_gt *gt, u32 seqno)
-{
-	u32 cur = intel_gt_tlb_seqno(gt);
-
-	/* Only skip if a *full* TLB invalidate barrier has passed */
-	return (s32)(cur - ALIGN(seqno, 2)) > 0;
-}
-
-void intel_gt_invalidate_tlb(struct intel_gt *gt, u32 seqno)
-{
-	intel_wakeref_t wakeref;
-
-	if (I915_SELFTEST_ONLY(gt->awake == -ENODEV))
-		return;
-
-	if (intel_gt_is_wedged(gt))
-		return;
-
-	if (tlb_seqno_passed(gt, seqno))
-		return;
-
-	with_intel_gt_pm_if_awake(gt, wakeref) {
-		mutex_lock(&gt->tlb.invalidate_lock);
-		if (tlb_seqno_passed(gt, seqno))
-			goto unlock;
-
-		mmio_invalidate_full(gt);
-
-		write_seqcount_invalidate(&gt->tlb.seqno);
-unlock:
-		mutex_unlock(&gt->tlb.invalidate_lock);
-	}
-}
diff --git a/drivers/gpu/drm/i915/gt/intel_gt.h b/drivers/gpu/drm/i915/gt/intel_gt.h
index 40b06adf509a..b4bba16cdb53 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt.h
@@ -101,16 +101,4 @@ void intel_gt_info_print(const struct intel_gt_info *info,
 
 void intel_gt_watchdog_work(struct work_struct *work);
 
-static inline u32 intel_gt_tlb_seqno(const struct intel_gt *gt)
-{
-	return seqprop_sequence(&gt->tlb.seqno);
-}
-
-static inline u32 intel_gt_next_invalidate_tlb_full(const struct intel_gt *gt)
-{
-	return intel_gt_tlb_seqno(gt) | 1;
-}
-
-void intel_gt_invalidate_tlb(struct intel_gt *gt, u32 seqno);
-
 #endif /* __INTEL_GT_H__ */
diff --git a/drivers/gpu/drm/i915/gt/intel_tlb.c b/drivers/gpu/drm/i915/gt/intel_tlb.c
new file mode 100644
index 000000000000..af8cae979489
--- /dev/null
+++ b/drivers/gpu/drm/i915/gt/intel_tlb.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2022 Intel Corporation
+ */
+
+#include "i915_drv.h"
+#include "i915_perf_oa_regs.h"
+#include "intel_engine_pm.h"
+#include "intel_gt.h"
+#include "intel_gt_pm.h"
+#include "intel_gt_regs.h"
+#include "intel_tlb.h"
+
+struct reg_and_bit {
+	i915_reg_t reg;
+	u32 bit;
+};
+
+static struct reg_and_bit
+get_reg_and_bit(const struct intel_engine_cs *engine, const bool gen8,
+		const i915_reg_t *regs, const unsigned int num)
+{
+	const unsigned int class = engine->class;
+	struct reg_and_bit rb = { };
+
+	if (drm_WARN_ON_ONCE(&engine->i915->drm,
+			     class >= num || !regs[class].reg))
+		return rb;
+
+	rb.reg = regs[class];
+	if (gen8 && class == VIDEO_DECODE_CLASS)
+		rb.reg.reg += 4 * engine->instance; /* GEN8_M2TCR */
+	else
+		rb.bit = engine->instance;
+
+	rb.bit = BIT(rb.bit);
+
+	return rb;
+}
+
+static bool tlb_seqno_passed(const struct intel_gt *gt, u32 seqno)
+{
+	u32 cur = intel_gt_tlb_seqno(gt);
+
+	/* Only skip if a *full* TLB invalidate barrier has passed */
+	return (s32)(cur - ALIGN(seqno, 2)) > 0;
+}
+
+static void mmio_invalidate_full(struct intel_gt *gt)
+{
+	static const i915_reg_t gen8_regs[] = {
+		[RENDER_CLASS]			= GEN8_RTCR,
+		[VIDEO_DECODE_CLASS]		= GEN8_M1TCR, /* , GEN8_M2TCR */
+		[VIDEO_ENHANCEMENT_CLASS]	= GEN8_VTCR,
+		[COPY_ENGINE_CLASS]		= GEN8_BTCR,
+	};
+	static const i915_reg_t gen12_regs[] = {
+		[RENDER_CLASS]			= GEN12_GFX_TLB_INV_CR,
+		[VIDEO_DECODE_CLASS]		= GEN12_VD_TLB_INV_CR,
+		[VIDEO_ENHANCEMENT_CLASS]	= GEN12_VE_TLB_INV_CR,
+		[COPY_ENGINE_CLASS]		= GEN12_BLT_TLB_INV_CR,
+		[COMPUTE_CLASS]			= GEN12_COMPCTX_TLB_INV_CR,
+	};
+	struct drm_i915_private *i915 = gt->i915;
+	struct intel_uncore *uncore = gt->uncore;
+	struct intel_engine_cs *engine;
+	intel_engine_mask_t awake, tmp;
+	enum intel_engine_id id;
+	const i915_reg_t *regs;
+	unsigned int num = 0;
+
+	if (GRAPHICS_VER(i915) == 12) {
+		regs = gen12_regs;
+		num = ARRAY_SIZE(gen12_regs);
+	} else if (GRAPHICS_VER(i915) >= 8 && GRAPHICS_VER(i915) <= 11) {
+		regs = gen8_regs;
+		num = ARRAY_SIZE(gen8_regs);
+	} else if (GRAPHICS_VER(i915) < 8) {
+		return;
+	}
+
+	if (drm_WARN_ONCE(&i915->drm, !num,
+			  "Platform does not implement TLB invalidation!"))
+		return;
+
+	intel_uncore_forcewake_get(uncore, FORCEWAKE_ALL);
+
+	spin_lock_irq(&uncore->lock); /* serialise invalidate with GT reset */
+
+	awake = 0;
+	for_each_engine(engine, gt, id) {
+		struct reg_and_bit rb;
+
+		if (!intel_engine_pm_is_awake(engine))
+			continue;
+
+		rb = get_reg_and_bit(engine, regs == gen8_regs, regs, num);
+		if (!i915_mmio_reg_offset(rb.reg))
+			continue;
+
+		intel_uncore_write_fw(uncore, rb.reg, rb.bit);
+		awake |= engine->mask;
+	}
+
+	GT_TRACE(gt, "invalidated engines %08x\n", awake);
+
+	/* Wa_2207587034:tgl,dg1,rkl,adl-s,adl-p */
+	if (awake &&
+	    (IS_TIGERLAKE(i915) ||
+	     IS_DG1(i915) ||
+	     IS_ROCKETLAKE(i915) ||
+	     IS_ALDERLAKE_S(i915) ||
+	     IS_ALDERLAKE_P(i915)))
+		intel_uncore_write_fw(uncore, GEN12_OA_TLB_INV_CR, 1);
+
+	spin_unlock_irq(&uncore->lock);
+
+	for_each_engine_masked(engine, gt, awake, tmp) {
+		struct reg_and_bit rb;
+
+		/*
+		 * HW architecture suggest typical invalidation time at 40us,
+		 * with pessimistic cases up to 100us and a recommendation to
+		 * cap at 1ms. We go a bit higher just in case.
+		 */
+		const unsigned int timeout_us = 100;
+		const unsigned int timeout_ms = 4;
+
+		rb = get_reg_and_bit(engine, regs == gen8_regs, regs, num);
+		if (__intel_wait_for_register_fw(uncore,
+						 rb.reg, rb.bit, 0,
+						 timeout_us, timeout_ms,
+						 NULL))
+			drm_err_ratelimited(&gt->i915->drm,
+					    "%s TLB invalidation did not complete in %ums!\n",
+					    engine->name, timeout_ms);
+	}
+
+	/*
+	 * Use delayed put since a) we mostly expect a flurry of TLB
+	 * invalidations so it is good to avoid paying the forcewake cost and
+	 * b) it works around a bug in Icelake which cannot cope with too rapid
+	 * transitions.
+	 */
+	intel_uncore_forcewake_put_delayed(uncore, FORCEWAKE_ALL);
+}
+
+void intel_gt_invalidate_tlb_full(struct intel_gt *gt, u32 seqno)
+{
+	intel_wakeref_t wakeref;
+
+	if (I915_SELFTEST_ONLY(gt->awake == -ENODEV))
+		return;
+
+	if (intel_gt_is_wedged(gt))
+		return;
+
+	if (tlb_seqno_passed(gt, seqno))
+		return;
+
+	with_intel_gt_pm_if_awake(gt, wakeref) {
+		mutex_lock(&gt->tlb.invalidate_lock);
+		if (tlb_seqno_passed(gt, seqno))
+			goto unlock;
+
+		mmio_invalidate_full(gt);
+
+		write_seqcount_invalidate(&gt->tlb.seqno);
+unlock:
+		mutex_unlock(&gt->tlb.invalidate_lock);
+	}
+}
+
+void intel_gt_init_tlb(struct intel_gt *gt)
+{
+	mutex_init(&gt->tlb.invalidate_lock);
+	seqcount_mutex_init(&gt->tlb.seqno, &gt->tlb.invalidate_lock);
+}
+
+void intel_gt_fini_tlb(struct intel_gt *gt)
+{
+	mutex_destroy(&gt->tlb.invalidate_lock);
+}
diff --git a/drivers/gpu/drm/i915/gt/intel_tlb.h b/drivers/gpu/drm/i915/gt/intel_tlb.h
new file mode 100644
index 000000000000..46ce25bf5afe
--- /dev/null
+++ b/drivers/gpu/drm/i915/gt/intel_tlb.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2022 Intel Corporation
+ */
+
+#ifndef INTEL_TLB_H
+#define INTEL_TLB_H
+
+#include <linux/seqlock.h>
+#include <linux/types.h>
+
+#include "intel_gt_types.h"
+
+void intel_gt_invalidate_tlb_full(struct intel_gt *gt, u32 seqno);
+
+void intel_gt_init_tlb(struct intel_gt *gt);
+void intel_gt_fini_tlb(struct intel_gt *gt);
+
+static inline u32 intel_gt_tlb_seqno(const struct intel_gt *gt)
+{
+	return seqprop_sequence(&gt->tlb.seqno);
+}
+
+static inline u32 intel_gt_next_invalidate_tlb_full(const struct intel_gt *gt)
+{
+	return intel_gt_tlb_seqno(gt) | 1;
+}
+
+#endif /* INTEL_TLB_H */
diff --git a/drivers/gpu/drm/i915/i915_vma.c b/drivers/gpu/drm/i915/i915_vma.c
index 84a9ccbc5fc5..fe947d1456d5 100644
--- a/drivers/gpu/drm/i915/i915_vma.c
+++ b/drivers/gpu/drm/i915/i915_vma.c
@@ -33,6 +33,7 @@
 #include "gt/intel_engine_heartbeat.h"
 #include "gt/intel_gt.h"
 #include "gt/intel_gt_requests.h"
+#include "gt/intel_tlb.h"
 
 #include "i915_drv.h"
 #include "i915_gem_evict.h"
-- 
2.36.1

