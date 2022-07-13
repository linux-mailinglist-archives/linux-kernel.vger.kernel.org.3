Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58DE5732B3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236111AbiGMJbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235705AbiGMJag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:30:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C2BF4223
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:30:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71804B81D6F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494E1C341DF;
        Wed, 13 Jul 2022 09:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657704622;
        bh=FzHmmGEGNNUQo1E9IcdaPTJZyRSYl5vZePFi9GRAEHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lIDUyc5sj0v2wkHK56P1equ4UXbgwyIAXhnE3oNV2uyRPpIj8R+5fPCLPA+GU1bZ5
         EFtt1JyvpN1R2WIVfgma2jTVSj8JlA6/0JattwdNRm32XFF9+Qu7kEe/faIq2mV4KK
         r8SxafBS3sF10yblxA6p/qvys6BaWG72hDVPmRorIFuKPUl1lo+Ta/X/dihpSsnrWU
         iruwCXI3+AaO0eiOFn2RilKWStlvCaeXwu2v/ljGgpB+LBB887/CdXlFliuKq7x2nO
         fF49RtdliWmCE+SFFcZXpOCCPEmbSrz4Z+bDDXw6q+TvEMOM9SVrII8Xe3AQNg90nD
         PuUjAF8ka2pPw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBYhH-0050M3-U5;
        Wed, 13 Jul 2022 10:30:19 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Chris Wilson <chris.p.wilson@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Matt Atwood <matthew.s.atwood@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Fei Yang <fei.yang@intel.com>
Subject: [PATCH 17/21] drm/i915: Add generic interface for tlb invalidation for XeHP
Date:   Wed, 13 Jul 2022 10:30:14 +0100
Message-Id: <dc83c6c139c999c5ca70da91927468f3333f85f8.1657703926.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657703926.git.mchehab@kernel.org>
References: <cover.1657703926.git.mchehab@kernel.org>
MIME-Version: 1.0
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

From: Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>

Add an interface for GuC TLB actions, supporting both selective and
full TLB invalidations. After this change, when GuC is enabled,
tlb invalidations use GuC ct. Otherwise, use mmio interface.

Signed-off-by: Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>
Cc: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
Cc: Fei Yang <fei.yang@intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH 00/21] at: https://lore.kernel.org/all/cover.1657703926.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/gt/intel_gt_regs.h |  8 +++
 drivers/gpu/drm/i915/gt/intel_tlb.c     | 78 ++++++++++++++++++++++++-
 drivers/gpu/drm/i915/gt/intel_tlb.h     |  1 +
 3 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_gt_regs.h b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
index 60d6eb5f245b..52508a9c23e5 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_regs.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
@@ -1054,6 +1054,14 @@
 
 #define GEN12_GAM_DONE				_MMIO(0xcf68)
 
+#define XEHP_TLB_INV_DESC0			_MMIO(0xcf7c)
+#define   XEHP_TLB_INV_DESC0_ADDR_LO		REG_GENMASK(31, 12)
+#define   XEHP_TLB_INV_DESC0_ADDR_MASK		REG_GENMASK(8, 3)
+#define   XEHP_TLB_INV_DESC0_G			REG_GENMASK(2, 1)
+#define   XEHP_TLB_INV_DESC0_VALID		REG_BIT(0)
+#define XEHP_TLB_INV_DESC1			_MMIO(0xcf80)
+#define   XEHP_TLB_INV_DESC0_ADDR_HI		REG_GENMASK(31, 0)
+
 #define GEN7_HALF_SLICE_CHICKEN1		_MMIO(0xe100) /* IVB GT1 + VLV */
 #define   GEN7_MAX_PS_THREAD_DEP		(8 << 12)
 #define   GEN7_SINGLE_SUBSCAN_DISPATCH_ENABLE	(1 << 10)
diff --git a/drivers/gpu/drm/i915/gt/intel_tlb.c b/drivers/gpu/drm/i915/gt/intel_tlb.c
index af8cae979489..15ed83226676 100644
--- a/drivers/gpu/drm/i915/gt/intel_tlb.c
+++ b/drivers/gpu/drm/i915/gt/intel_tlb.c
@@ -10,6 +10,7 @@
 #include "intel_gt_pm.h"
 #include "intel_gt_regs.h"
 #include "intel_tlb.h"
+#include "uc/intel_guc.h"
 
 struct reg_and_bit {
 	i915_reg_t reg;
@@ -159,11 +160,16 @@ void intel_gt_invalidate_tlb_full(struct intel_gt *gt, u32 seqno)
 		return;
 
 	with_intel_gt_pm_if_awake(gt, wakeref) {
+		struct intel_guc *guc = &gt->uc.guc;
+
 		mutex_lock(&gt->tlb.invalidate_lock);
 		if (tlb_seqno_passed(gt, seqno))
 			goto unlock;
 
-		mmio_invalidate_full(gt);
+		if (INTEL_GUC_SUPPORTS_TLB_INVALIDATION(guc))
+			intel_guc_invalidate_tlb_full(guc, INTEL_GUC_TLB_INVAL_MODE_HEAVY);
+		else
+			mmio_invalidate_full(gt);
 
 		write_seqcount_invalidate(&gt->tlb.seqno);
 unlock:
@@ -171,6 +177,76 @@ void intel_gt_invalidate_tlb_full(struct intel_gt *gt, u32 seqno)
 	}
 }
 
+static bool mmio_invalidate_range(struct intel_gt *gt, u64 start, u64 length)
+{
+	u32 address_mask = (ilog2(length) - ilog2(I915_GTT_PAGE_SIZE_4K));
+	u64 vm_total = BIT_ULL(INTEL_INFO(gt->i915)->ppgtt_size);
+	intel_wakeref_t wakeref;
+	u32 dw0, dw1;
+	int err;
+
+	GEM_BUG_ON(!IS_ALIGNED(start, I915_GTT_PAGE_SIZE_4K));
+	GEM_BUG_ON(!IS_ALIGNED(length, I915_GTT_PAGE_SIZE_4K));
+	GEM_BUG_ON(range_overflows(start, length, vm_total));
+
+	dw0 = FIELD_PREP(XEHP_TLB_INV_DESC0_ADDR_LO, (lower_32_bits(start) >> 12)) |
+		FIELD_PREP(XEHP_TLB_INV_DESC0_ADDR_MASK, address_mask) |
+		FIELD_PREP(XEHP_TLB_INV_DESC0_G, 0x3) |
+		FIELD_PREP(XEHP_TLB_INV_DESC0_VALID, 0x1);
+	dw1 = upper_32_bits(start);
+
+	err = 0;
+	with_intel_gt_pm_if_awake(gt, wakeref) {
+		struct intel_uncore *uncore = gt->uncore;
+
+		intel_uncore_forcewake_get(uncore, FORCEWAKE_ALL);
+
+		mutex_lock(&gt->tlb.invalidate_lock);
+		intel_uncore_write_fw(uncore, XEHP_TLB_INV_DESC1, dw1);
+		intel_uncore_write_fw(uncore, XEHP_TLB_INV_DESC0, dw0);
+		err = __intel_wait_for_register_fw(uncore,
+						   XEHP_TLB_INV_DESC0,
+						   XEHP_TLB_INV_DESC0_VALID,
+						   0, 100, 10, NULL);
+		mutex_unlock(&gt->tlb.invalidate_lock);
+
+		intel_uncore_forcewake_put_delayed(uncore, FORCEWAKE_ALL);
+	}
+
+	if (err)
+		drm_err_ratelimited(&gt->i915->drm,
+				    "TLB invalidation response timed out\n");
+
+	return err == 0;
+}
+
+bool intel_gt_invalidate_tlb_range(struct intel_gt *gt,
+				   u64 start, u64 length)
+{
+	struct intel_guc *guc = &gt->uc.guc;
+	intel_wakeref_t wakeref;
+
+	if (intel_gt_is_wedged(gt))
+		return true;
+
+	if (!INTEL_GUC_SUPPORTS_TLB_INVALIDATION_SELECTIVE(guc))
+		return false;
+
+	/*XXX: We are seeing timeouts on guc based tlb invalidations on XEHPSDV.
+	 * Until we have a fix, use mmio
+	 */
+	if (IS_XEHPSDV(gt->i915))
+		return mmio_invalidate_range(gt, start, length);
+
+	with_intel_gt_pm_if_awake(gt, wakeref) {
+		intel_guc_invalidate_tlb_page_selective(guc,
+							INTEL_GUC_TLB_INVAL_MODE_HEAVY,
+							start, length);
+	}
+
+	return true;
+}
+
 void intel_gt_init_tlb(struct intel_gt *gt)
 {
 	mutex_init(&gt->tlb.invalidate_lock);
diff --git a/drivers/gpu/drm/i915/gt/intel_tlb.h b/drivers/gpu/drm/i915/gt/intel_tlb.h
index 46ce25bf5afe..32cc79b1d8a4 100644
--- a/drivers/gpu/drm/i915/gt/intel_tlb.h
+++ b/drivers/gpu/drm/i915/gt/intel_tlb.h
@@ -12,6 +12,7 @@
 #include "intel_gt_types.h"
 
 void intel_gt_invalidate_tlb_full(struct intel_gt *gt, u32 seqno);
+bool intel_gt_invalidate_tlb_range(struct intel_gt *gt, u64 start, u64 length);
 
 void intel_gt_init_tlb(struct intel_gt *gt);
 void intel_gt_fini_tlb(struct intel_gt *gt);
-- 
2.36.1

