Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4F5583EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbiG1MaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236301AbiG1MaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:30:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD55B319
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:30:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A4D861C5E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 12:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DE0C433D7;
        Thu, 28 Jul 2022 12:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659011406;
        bh=lAAONVrnfPLFQfTjiURwY9vl1P8lEZl8i30JEcp0dys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tNSpxrRyQA0I2aCw84FcIY6T4kdjBDyGS+StTCphgE86guGdZSE90GZl7Jejk2jaL
         dPp7hUAOD8nS345Bi9qHA8640W8UxEdxprKYwldWGaoTbcaNlwvlkcWQLgWovP5rMg
         1AkOb/KqUsuC38vpoBoqOIHcdYujQD1LhpjjwYAdEp30id86v+s2t6cTwWzfoNOLdg
         ES4VVrrkJi3Tg8qPejlbRTU6eJwqGKEuXwqIbC9iCC4R7sxdkcrsHhyz02tEjfkKer
         M8i2n0A8aN0RSrLwuE5TMw9d66WsOjhIrt42HfyadDD+zCkPdQ3kRJV3xJjimRnhqT
         pBlTOpUyO0IHQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oH2eS-005W6a-Cq;
        Thu, 28 Jul 2022 14:30:04 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chris Wilson <chris.p.wilson@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/i915/gt: document TLB cache invalidation functions
Date:   Thu, 28 Jul 2022 14:30:03 +0200
Message-Id: <44fd40009e1cc67232d7453cbe09088e78226594.1659011328.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1659011328.git.mchehab@kernel.org>
References: <cover.1659011328.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a description for the TLB cache invalidation algorithm and for
the related kAPI functions.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 0/2] at: https://lore.kernel.org/all/cover.1659011328.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/gt/intel_tlb.c | 25 +++++++++
 drivers/gpu/drm/i915/gt/intel_tlb.h | 83 +++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/intel_tlb.c b/drivers/gpu/drm/i915/gt/intel_tlb.c
index af8cae979489..d5df2e0f77fb 100644
--- a/drivers/gpu/drm/i915/gt/intel_tlb.c
+++ b/drivers/gpu/drm/i915/gt/intel_tlb.c
@@ -145,6 +145,18 @@ static void mmio_invalidate_full(struct intel_gt *gt)
 	intel_uncore_forcewake_put_delayed(uncore, FORCEWAKE_ALL);
 }
 
+/**
+ * intel_gt_invalidate_tlb_full - do full TLB cache invalidation
+ * @gt: GT structure
+ * @seqno: sequence number
+ *
+ * Do a full TLB cache invalidation if the @seqno is bigger than the last
+ * full TLB cache invalidation.
+ *
+ * Note:
+ * The TLB cache invalidation logic depends on GEN-specific registers.
+ * It currently supports GEN8 to GEN12 and GuC-based TLB cache invalidation.
+ */
 void intel_gt_invalidate_tlb_full(struct intel_gt *gt, u32 seqno)
 {
 	intel_wakeref_t wakeref;
@@ -171,12 +183,25 @@ void intel_gt_invalidate_tlb_full(struct intel_gt *gt, u32 seqno)
 	}
 }
 
+/**
+ * intel_gt_init_tlb - initialize TLB-specific vars
+ * @gt: GT structure
+ *
+ * TLB cache invalidation logic internally uses some resources that require
+ * initialization. Should be called before doing any TLB cache invalidation.
+ */
 void intel_gt_init_tlb(struct intel_gt *gt)
 {
 	mutex_init(&gt->tlb.invalidate_lock);
 	seqcount_mutex_init(&gt->tlb.seqno, &gt->tlb.invalidate_lock);
 }
 
+/**
+ * intel_gt_fini_tlb - initialize TLB-specific vars
+ * @gt: GT structure
+ *
+ * Frees any resources needed by TLB cache invalidation logic.
+ */
 void intel_gt_fini_tlb(struct intel_gt *gt)
 {
 	mutex_destroy(&gt->tlb.invalidate_lock);
diff --git a/drivers/gpu/drm/i915/gt/intel_tlb.h b/drivers/gpu/drm/i915/gt/intel_tlb.h
index 46ce25bf5afe..d186f5d5901f 100644
--- a/drivers/gpu/drm/i915/gt/intel_tlb.h
+++ b/drivers/gpu/drm/i915/gt/intel_tlb.h
@@ -11,16 +11,99 @@
 
 #include "intel_gt_types.h"
 
+/**
+ * DOC: TLB cache invalidation logic
+ *
+ * The way the current algorithm works is that drm_i915_gem_object can be
+ * created on any order. At unbind/evict time, the object is warranted that
+ * it won't be used anymore. So, they store a sequence number provided by
+ * intel_gt_next_invalidate_tlb_full().This can happen either at
+ * __vma_put_pages(), for VMA sync unbind, or at ppgtt_unbind_vma(), for
+ * VMA async VMA bind.
+ *
+ * At __i915_gem_object_unset_pages(), intel_gt_invalidate_tlb() is called,
+ * where it checks if the sequence number of the object was already invalidated
+ * or not. If not, it increments it::
+ *
+ *   void intel_gt_invalidate_tlb(struct intel_gt *gt, u32 seqno)
+ *   {
+ *   ...
+ * 	with_intel_gt_pm_if_awake(gt, wakeref) {
+ * 		mutex_lock(&gt->tlb.invalidate_lock);
+ * 		if (tlb_seqno_passed(gt, seqno))
+ * 				goto unlock;
+ *
+ * 		mmio_invalidate_full(gt);
+ *
+ * 		write_seqcount_invalidate(&gt->tlb.seqno); // increment seqno
+ *    ...
+ *
+ * So, let's say the current seqno is 2 and 3 new objects were created,
+ * on this order:
+ *
+ * 	obj1
+ * 	obj2
+ * 	obj3
+ *
+ * They can be unbind/evict on a different order. At unbind/evict time,
+ * the mm.tlb will be stamped with the sequence number, using the number
+ * from the last TLB flush, plus 1.
+ *
+ * Different threads may be used on unbind/evict and/or unset pages.
+ *
+ * As the logic at void intel_gt_invalidate_tlb() is protected by a mutex,
+ * for simplicity, let's consider just two threads::
+ *
+ *   sequence number	Thread 0		Thread 1
+ *
+ *   seqno=2
+ *			unbind/evict event
+ * 			obj3.mm.tlb = seqno | 1
+ *
+ *			unbind/evict event
+ * 			obj1.mm.tlb = seqno | 1
+ * 						__i915_gem_object_unset_pages()
+ * 						called for obj3 => TLB flush
+ * 						invalidating both obj1 and obj2.
+ * 						seqno += 2
+ *   seqno=4
+ *			unbind/evict event
+ * 			obj2.mm.tlb = seqno | 1
+ * 						__i915_gem_object_unset_pages()
+ * 						called for obj1, don't flush,
+ *						as past flush invalidated obj1
+ *
+ * 						__i915_gem_object_unset_pages()
+ *						called for obj2 => TLB flush
+ * 						seqno += 2
+ *   seqno=6
+ */
+
 void intel_gt_invalidate_tlb_full(struct intel_gt *gt, u32 seqno);
 
 void intel_gt_init_tlb(struct intel_gt *gt);
 void intel_gt_fini_tlb(struct intel_gt *gt);
 
+/**
+ * intel_gt_tlb_seqno - Returns the current TLB invlidation sequence number
+ *
+ * @gt: GT structure
+ *
+ * There's no need to lock while calling it, as seqprop_sequence is thread-safe
+ */
 static inline u32 intel_gt_tlb_seqno(const struct intel_gt *gt)
 {
 	return seqprop_sequence(&gt->tlb.seqno);
 }
 
+/**
+ * intel_gt_next_invalidate_tlb_full - Returns the next TLB full invalidation
+ *	sequence number
+ *
+ * @gt: GT structure
+ *
+ * There's no need to lock while calling it, as seqprop_sequence is thread-safe
+ */
 static inline u32 intel_gt_next_invalidate_tlb_full(const struct intel_gt *gt)
 {
 	return intel_gt_tlb_seqno(gt) | 1;
-- 
2.36.1

