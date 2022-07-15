Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4BF576A9B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 01:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiGOXVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 19:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbiGOXVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 19:21:16 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BBB93699
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 16:21:15 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id u11-20020a654c0b000000b00415ed4acf16so3382296pgq.22
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 16:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=xZJd80Zg/K5Tv3nyLPJvzVj/Ikxh3CwBykpRFC2Ta1c=;
        b=iOrlGEDESIs1HmS4KXox6mMFSZKfN5WplYjqqDMGK/Z3xogIV7OLYbJm9dq8uQCQKw
         pRIF8JcxDS7XxAIacADg5dG6TdekjMkGBFhY9snjJIORn51p1DFGHr3QFxAnNCNFRXy7
         vZYz2VjNWfB2NYo9owsgdI5Hh6e1Wqeg26xHKQBMb/7jSEfdNFAGf46075yDGDt47UX7
         LGiVOsRpO5Dfkq1Z/GTfrVZzIT6pnXZXOYChF5TbyzYTXms6HH26y39V6BMzzqzTmYp8
         rkF2KWZPXidhbQonuXXwoEmefTChiH34XKqVoLaFw1bQ7I50GsCYCkj6iqBXo6RBvgti
         2K4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=xZJd80Zg/K5Tv3nyLPJvzVj/Ikxh3CwBykpRFC2Ta1c=;
        b=DrQ/ONQrhiELaioLrf4gdjsyqF56OsNi+dU0udkPNQOZMFXX3A9M7py7Nt9pnTJLm0
         i2XnohRRDLBw5YUFDGc0HIIAHUBoZ8qI7/pFfy5NHBPz22Bljr0CFl3MKGyIeAVecVwz
         uw8vCjZwQF66EHIoFch1o+RE1pqA8E9xdS3wXGMLW5l6T4FqrhUJuIElO2IJfCCw/Vva
         kx20dkivYdokcqhYBZ3uYw6HT5omwMRU23TG2r8iF6YnRTB7HvikoshTpksNOaijkl9D
         70B8sqv/j4J/nadNjMHEbSy9JqiG6rLXYV5fIFXjhGS6jlH/cIbK1CKLW9dVdRreWkoz
         iRqg==
X-Gm-Message-State: AJIora+qnfeVJ53y5+ENoTMxCU1KJ66Xjn3TAZemiU+NBkhYWILn17nT
        BltE7KzFWbCqHRzg3M0DjB4ehyApcEE=
X-Google-Smtp-Source: AGRyM1tWXiTY+OVIpPgp623nVufEZCoz5Us8S7voWsHWxo3fLw+eQW46ZzhXfHuzbwbxM8lsyjixNrHFCaY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1941:b0:50d:807d:530b with SMTP id
 s1-20020a056a00194100b0050d807d530bmr16078951pfk.17.1657927275088; Fri, 15
 Jul 2022 16:21:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 15 Jul 2022 23:21:06 +0000
In-Reply-To: <20220715232107.3775620-1-seanjc@google.com>
Message-Id: <20220715232107.3775620-4-seanjc@google.com>
Mime-Version: 1.0
References: <20220715232107.3775620-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH 3/4] KVM: x86/mmu: Don't bottom out on leafs when zapping
 collapsible SPTEs
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When zapping collapsible SPTEs in the TDP MMU, don't bottom out on a leaf
SPTE now that KVM doesn't require a PFN to compute the host mapping level,
i.e. now that there's no need to first find a leaf SPTE and then step
back up.

Drop the now unused tdp_iter_step_up(), as it is not the safest of
helpers (using any of the low level iterators requires some understanding
of the various side effects).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_iter.c |  9 ------
 arch/x86/kvm/mmu/tdp_iter.h |  1 -
 arch/x86/kvm/mmu/tdp_mmu.c  | 57 ++++++++++++++++++-------------------
 3 files changed, 27 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_iter.c b/arch/x86/kvm/mmu/tdp_iter.c
index 9c65a64a56d9..39b48e7d7d1a 100644
--- a/arch/x86/kvm/mmu/tdp_iter.c
+++ b/arch/x86/kvm/mmu/tdp_iter.c
@@ -145,15 +145,6 @@ static bool try_step_up(struct tdp_iter *iter)
 	return true;
 }
 
-/*
- * Step the iterator back up a level in the paging structure. Should only be
- * used when the iterator is below the root level.
- */
-void tdp_iter_step_up(struct tdp_iter *iter)
-{
-	WARN_ON(!try_step_up(iter));
-}
-
 /*
  * Step to the next SPTE in a pre-order traversal of the paging structure.
  * To get to the next SPTE, the iterator either steps down towards the goal
diff --git a/arch/x86/kvm/mmu/tdp_iter.h b/arch/x86/kvm/mmu/tdp_iter.h
index adfca0cf94d3..f0af385c56e0 100644
--- a/arch/x86/kvm/mmu/tdp_iter.h
+++ b/arch/x86/kvm/mmu/tdp_iter.h
@@ -114,6 +114,5 @@ void tdp_iter_start(struct tdp_iter *iter, struct kvm_mmu_page *root,
 		    int min_level, gfn_t next_last_level_gfn);
 void tdp_iter_next(struct tdp_iter *iter);
 void tdp_iter_restart(struct tdp_iter *iter);
-void tdp_iter_step_up(struct tdp_iter *iter);
 
 #endif /* __KVM_X86_MMU_TDP_ITER_H */
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index d75d93edc40a..40ccb5fba870 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1721,10 +1721,6 @@ void kvm_tdp_mmu_clear_dirty_pt_masked(struct kvm *kvm,
 		clear_dirty_pt_masked(kvm, root, gfn, mask, wrprot);
 }
 
-/*
- * Clear leaf entries which could be replaced by large mappings, for
- * GFNs within the slot.
- */
 static void zap_collapsible_spte_range(struct kvm *kvm,
 				       struct kvm_mmu_page *root,
 				       const struct kvm_memory_slot *slot)
@@ -1736,48 +1732,49 @@ static void zap_collapsible_spte_range(struct kvm *kvm,
 
 	rcu_read_lock();
 
-	tdp_root_for_each_pte(iter, root, start, end) {
+	for_each_tdp_pte_min_level(iter, root, PG_LEVEL_2M, start, end) {
+retry:
 		if (tdp_mmu_iter_cond_resched(kvm, &iter, false, true))
 			continue;
 
-		if (!is_shadow_present_pte(iter.old_spte) ||
-		    !is_last_spte(iter.old_spte, iter.level))
+		if (iter.level > KVM_MAX_HUGEPAGE_LEVEL ||
+		    !is_shadow_present_pte(iter.old_spte))
+			continue;
+
+		/*
+		 * Don't zap leaf SPTEs, if a leaf SPTE could be replaced with
+		 * a large page size, then its parent would have been zapped
+		 * instead of stepping down.
+		 */
+		if (is_last_spte(iter.old_spte, iter.level))
+			continue;
+
+		/*
+		 * If iter.gfn resides outside of the slot, i.e. the page for
+		 * the current level overlaps but is not contained by the slot,
+		 * then the SPTE can't be made huge.  More importantly, trying
+		 * to query that info from slot->arch.lpage_info will cause an
+		 * out-of-bounds access.
+		 */
+		if (iter.gfn < start || iter.gfn >= end)
 			continue;
 
 		max_mapping_level = kvm_mmu_max_mapping_level(kvm, slot,
 							      iter.gfn, PG_LEVEL_NUM);
-
-		WARN_ON(max_mapping_level < iter.level);
-
-		/*
-		 * If this page is already mapped at the highest
-		 * viable level, there's nothing more to do.
-		 */
-		if (max_mapping_level == iter.level)
+		if (max_mapping_level < iter.level)
 			continue;
 
-		/*
-		 * The page can be remapped at a higher level, so step
-		 * up to zap the parent SPTE.
-		 */
-		while (max_mapping_level > iter.level)
-			tdp_iter_step_up(&iter);
-
 		/* Note, a successful atomic zap also does a remote TLB flush. */
-		tdp_mmu_zap_spte_atomic(kvm, &iter);
-
-		/*
-		 * If the atomic zap fails, the iter will recurse back into
-		 * the same subtree to retry.
-		 */
+		if (tdp_mmu_zap_spte_atomic(kvm, &iter))
+			goto retry;
 	}
 
 	rcu_read_unlock();
 }
 
 /*
- * Clear non-leaf entries (and free associated page tables) which could
- * be replaced by large mappings, for GFNs within the slot.
+ * Zap non-leaf SPTEs (and free their associated page tables) which could
+ * be replaced by huge pages, for GFNs within the slot.
  */
 void kvm_tdp_mmu_zap_collapsible_sptes(struct kvm *kvm,
 				       const struct kvm_memory_slot *slot)
-- 
2.37.0.170.g444d1eabd0-goog

