Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD405732C9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbiGMJbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiGMJa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:30:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0DCF32C3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:30:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0458861CC2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E005C341E2;
        Wed, 13 Jul 2022 09:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657704622;
        bh=No42/RgEW6DsepQiPc1/0fJqZ/T5P5PUlBvfd2kfCqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pbD9lHpKoIDbugthGJ+HYyhMHuBtLIO3OVFhVRsWIvnwfTn65Nda3/T0bmcI6GwLd
         pQp7JJVzz6dnN+s3wa3Ci6mYBSoUvEaYQYLJD2U9hZlbbEa82Os3iUD4LhFswTg0is
         93xhBa6TQOCRWWsbIyU+vA+QOfQjSb7td6PX1T+1XbJSxhNKjdA2pIP1BPgF8R0Xp5
         6D2Zxof3B6myg64sRQ+Z9v9j8qCDO6WfTLSMnj7P6pJYmrnOkNwOge/ToXQcO8+KIl
         4llo3nS9jJy3qkd2kGMThP6RLTurUB//aJ30IOk/fEoXEcsPjWeXhMOZlYxMSp7iKQ
         Og/AbDjfrkNRw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBYhH-0050M7-Ur;
        Wed, 13 Jul 2022 10:30:19 +0100
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
        Matthew Auld <matthew.auld@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ramalingam C <ramalingam.c@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Fei Yang <fei.yang@intel.com>
Subject: [PATCH 18/21] drm/i915: Use selective tlb invalidations where supported
Date:   Wed, 13 Jul 2022 10:30:15 +0100
Message-Id: <1eddd79483814571bdd6a6d9781b1637ef05ed6e.1657703926.git.mchehab@kernel.org>
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

For platforms supporting selective tlb invalidations, we don't need to
do a full tlb invalidation. Rather do a range based tlb invalidation for
every unbind of purged vma belongs to an active vm.

[mchehab: change moved from intel_ppgtt.c to i915_vma.c]
Signed-off-by: Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>
Cc: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
Cc: Fei Yang <fei.yang@intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH 00/21] at: https://lore.kernel.org/all/cover.1657703926.git.mchehab@kernel.org/

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

