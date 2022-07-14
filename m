Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB423574CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239175AbiGNMGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238784AbiGNMGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:06:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEA25C9C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:06:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 154EC61E4C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 12:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9326C341E1;
        Thu, 14 Jul 2022 12:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657800390;
        bh=2nPh2QI3ZigEOFy12Hg7q1FTsviWqDN6vtCQov7Vlss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=itgE7dWjn8jQG3Utg4APjFEtp1xYe0bugHAToCAFYH66ABXD9fjwlN0Ed75og3U/R
         g8W5eW0Jm2CjnsCSz1E9uX4D9tMisnyzqj8Dt6iA3/1llebC1S2Ihi8BRgg5Zp9Ug0
         dT8Hu+i/HMlqXo25wDvtTw2q9iCmwTLG83dkUNFhAldQaw9BLcRnBhloTFznJtmyxj
         HGkIwg/jJpc4DTb/3kQfPVUFlPorQiC+IXytp4wExZxbs6fQzneXL3Q/SSsPEsQqku
         /LNOTd8Vm+kPFFpLx90dsYRR7LvGWgaIEwVk3C25LCRbPtIs12flEMyqnGmSlocUpc
         XryyEzwSotzuw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBxbw-0059tO-6B;
        Thu, 14 Jul 2022 13:06:28 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Chris Wilson <chris.p.wilson@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Cheng <michael.cheng@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Fei Yang <fei.yang@intel.com>
Subject: [PATCH v2 18/21] drm/i915: Use selective tlb invalidations where supported
Date:   Thu, 14 Jul 2022 13:06:23 +0100
Message-Id: <7d55e7971e3f4544d8edeabb9e9c645c3042e01d.1657800199.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657800199.git.mchehab@kernel.org>
References: <cover.1657800199.git.mchehab@kernel.org>
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

For platforms supporting selective tlb invalidations, we don't need to
do a full tlb invalidation. Rather do a range based tlb invalidation for
every unbind of purged vma belongs to an active vm.

[mchehab: change moved from intel_ppgtt.c to i915_vma.c]
Signed-off-by: Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>
Cc: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
Cc: Fei Yang <fei.yang@intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/21] at: https://lore.kernel.org/all/cover.1657800199.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/gt/intel_ppgtt.c |  2 +-
 drivers/gpu/drm/i915/i915_vma.c       | 14 +++++++++-----
 drivers/gpu/drm/i915/i915_vma.h       |  3 ++-
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_ppgtt.c b/drivers/gpu/drm/i915/gt/intel_ppgtt.c
index f764d250e929..74782fb2ccbd 100644
--- a/drivers/gpu/drm/i915/gt/intel_ppgtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_ppgtt.c
@@ -211,7 +211,7 @@ void ppgtt_unbind_vma(struct i915_address_space *vm,
 		return;
 
 	vm->clear_range(vm, vma_res->start, vma_res->vma_size);
-	vma_invalidate_tlb(vm, vma_res->tlb);
+	vma_invalidate_tlb(vm, vma_res->tlb, vma_res->start, vma_res->vma_size);
 }
 
 static unsigned long pd_count(u64 size, int shift)
diff --git a/drivers/gpu/drm/i915/i915_vma.c b/drivers/gpu/drm/i915/i915_vma.c
index 5edc745dcc51..6d881a6b403a 100644
--- a/drivers/gpu/drm/i915/i915_vma.c
+++ b/drivers/gpu/drm/i915/i915_vma.c
@@ -1309,7 +1309,8 @@ I915_SELFTEST_EXPORT int i915_vma_get_pages(struct i915_vma *vma)
 	return err;
 }
 
-void vma_invalidate_tlb(struct i915_address_space *vm, u32 *tlb)
+void vma_invalidate_tlb(struct i915_address_space *vm, u32 *tlb,
+			u64 start, u64 size)
 {
 	struct intel_gt *gt;
 	int id;
@@ -1325,9 +1326,11 @@ void vma_invalidate_tlb(struct i915_address_space *vm, u32 *tlb)
 	 * the most recent TLB invalidation seqno, and if we have not yet
 	 * flushed the TLBs upon release, perform a full invalidation.
 	 */
-	for_each_gt(gt, vm->i915, id)
-		WRITE_ONCE(tlb[id],
-			   intel_gt_next_invalidate_tlb_full(vm->gt));
+	for_each_gt(gt, vm->i915, id) {
+		if (!intel_gt_invalidate_tlb_range(gt, start, size))
+			WRITE_ONCE(tlb[id],
+				   intel_gt_next_invalidate_tlb_full(vm->gt));
+	}
 }
 
 static void __vma_put_pages(struct i915_vma *vma, unsigned int count)
@@ -1980,7 +1983,8 @@ struct dma_fence *__i915_vma_evict(struct i915_vma *vma, bool async)
 			dma_fence_put(unbind_fence);
 			unbind_fence = NULL;
 		}
-		vma_invalidate_tlb(vma->vm, vma->obj->mm.tlb);
+		vma_invalidate_tlb(vma->vm, vma->obj->mm.tlb,
+				   vma->node.start, vma->size);
 	}
 
 	/*
diff --git a/drivers/gpu/drm/i915/i915_vma.h b/drivers/gpu/drm/i915/i915_vma.h
index 33a58f605d75..3f0af9595e59 100644
--- a/drivers/gpu/drm/i915/i915_vma.h
+++ b/drivers/gpu/drm/i915/i915_vma.h
@@ -213,7 +213,8 @@ bool i915_vma_misplaced(const struct i915_vma *vma,
 			u64 size, u64 alignment, u64 flags);
 void __i915_vma_set_map_and_fenceable(struct i915_vma *vma);
 void i915_vma_revoke_mmap(struct i915_vma *vma);
-void vma_invalidate_tlb(struct i915_address_space *vm, u32 *tlb);
+void vma_invalidate_tlb(struct i915_address_space *vm, u32 *tlb,
+			u64 start, u64 size);
 struct dma_fence *__i915_vma_evict(struct i915_vma *vma, bool async);
 int __i915_vma_unbind(struct i915_vma *vma);
 int __must_check i915_vma_unbind(struct i915_vma *vma);
-- 
2.36.1

