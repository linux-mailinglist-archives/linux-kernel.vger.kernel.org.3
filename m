Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8414C570FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 04:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiGLCHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 22:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiGLCH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 22:07:29 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9A152E69
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:07:28 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id i17-20020a170902c95100b0016c449584a9so2939503pla.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Kj1p4tUlo2Gi2KL3OVMzfDp7eVajTf8Yir/EAlTxtKI=;
        b=qpBNyQJS4f5EcknaPqi2wL+B44z9oq+wpCOZ8gsQm0DUxz7O42JYG2ISghedjvR5EN
         bOagk8+ttb/9b6gbfatBYrqinzIgssF2hfoAJ1ID8bswCq+3CQPpyvBKqCgWBDiQnrfQ
         926ut+cksqHA+jaYfNvHC9q9fbO1nZK9zON3i+ftKFl7d1d9yNwgcauMxhmGN+0vXD5c
         N+RNbmmxkCLtxOjseuxGCUgsxZQ16CXmE0JFV3pC1zVu5cxeJ/DwTijXyZK+vrzcxXMu
         yTpDcItMjLtZm0tDLggXXxvbphP3lIC3W4IO4F4Wt4H8yTK02MkIkdjTmVFmwwr0IysW
         Um3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Kj1p4tUlo2Gi2KL3OVMzfDp7eVajTf8Yir/EAlTxtKI=;
        b=tqz/c+hVynHE4oEExe4bdDagf62iup+lNDNFsWrgNKLg7FM9Tb4tcCog//usEBM3B4
         SqtLtvs1rdycQ1fS4D04XyXt6XFjfI3LV2qct+uz+p2/j0xj7RIj3g3Q26qJQy8MJaUn
         YEZRvR7aSxQLl3GiZHeOAHpBrCNmrqdMx9eWXu9DctRMt8tNEBSNIpEiH99vJGlMF4XU
         W82/OdxhWcbI0PK5cHEKpD/BR+Ydfmn3LUczMwouex9ylGW7MGmBrmSptjS3Bgj8MrcL
         GgWmua3k4j4RJCkk0mlnpmfXRcTrCoug4OkCsmyQcnAFqt2dfeAl0ueuohuAv++glNdb
         Xn9w==
X-Gm-Message-State: AJIora+/rOEt/zAs8s88cQ5/2MohLUATqFAVgCK5golEA8AK2taQrw2T
        SPRcTtcmwgTTAo6KGImlODlqlmwYqU8=
X-Google-Smtp-Source: AGRyM1uy4B/Y1d/ttEgwCwfdgh29QaSmiQ+HpwxHSxaAszeXSQy/JtcCYhe34uNZq6yJHLhz1DOiXU8MrGc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:185:b0:16c:3af7:dbc8 with SMTP id
 z5-20020a170903018500b0016c3af7dbc8mr13006281plg.147.1657591648244; Mon, 11
 Jul 2022 19:07:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 12 Jul 2022 02:07:22 +0000
In-Reply-To: <20220712020724.1262121-1-seanjc@google.com>
Message-Id: <20220712020724.1262121-2-seanjc@google.com>
Mime-Version: 1.0
References: <20220712020724.1262121-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
Subject: [PATCH v3 1/3] KVM: x86/mmu: Add optimized helper to retrieve an
 SPTE's index
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spte_index() to dedup all the code that calculates a SPTE's index
into its parent's page table and/or spt array.  Opportunistically tweak
the calculation to avoid pointer arithmetic, which is subtle (subtract in
8-byte chunks) and less performant (requires the compiler to generate the
subtraction).

Suggested-by: David Matlack <dmatlack@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c         | 22 ++++++++++------------
 arch/x86/kvm/mmu/paging_tmpl.h |  4 ++--
 arch/x86/kvm/mmu/spte.h        |  6 ++++++
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f7fa4c31b7c5..864a32f96082 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1038,7 +1038,7 @@ static void rmap_remove(struct kvm *kvm, u64 *spte)
 	struct kvm_rmap_head *rmap_head;
 
 	sp = sptep_to_sp(spte);
-	gfn = kvm_mmu_page_get_gfn(sp, spte - sp->spt);
+	gfn = kvm_mmu_page_get_gfn(sp, spte_index(spte));
 
 	/*
 	 * Unlike rmap_add, rmap_remove does not run in the context of a vCPU
@@ -1589,7 +1589,7 @@ static void __rmap_add(struct kvm *kvm,
 	int rmap_count;
 
 	sp = sptep_to_sp(spte);
-	kvm_mmu_page_set_translation(sp, spte - sp->spt, gfn, access);
+	kvm_mmu_page_set_translation(sp, spte_index(spte), gfn, access);
 	kvm_update_page_stats(kvm, sp->role.level, 1);
 
 	rmap_head = gfn_to_rmap(gfn, sp->role.level, slot);
@@ -1716,11 +1716,9 @@ static void kvm_mmu_mark_parents_unsync(struct kvm_mmu_page *sp)
 static void mark_unsync(u64 *spte)
 {
 	struct kvm_mmu_page *sp;
-	unsigned int index;
 
 	sp = sptep_to_sp(spte);
-	index = spte - sp->spt;
-	if (__test_and_set_bit(index, sp->unsync_child_bitmap))
+	if (__test_and_set_bit(spte_index(spte), sp->unsync_child_bitmap))
 		return;
 	if (sp->unsync_children++)
 		return;
@@ -2203,7 +2201,7 @@ static union kvm_mmu_page_role kvm_mmu_child_role(u64 *sptep, bool direct, unsig
 	 */
 	if (role.has_4_byte_gpte) {
 		WARN_ON_ONCE(role.level != PG_LEVEL_4K);
-		role.quadrant = (sptep - parent_sp->spt) % 2;
+		role.quadrant = spte_index(sptep) & 1;
 	}
 
 	return role;
@@ -2828,7 +2826,7 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 		rmap_add(vcpu, slot, sptep, gfn, pte_access);
 	} else {
 		/* Already rmapped but the pte_access bits may have changed. */
-		kvm_mmu_page_set_access(sp, sptep - sp->spt, pte_access);
+		kvm_mmu_page_set_access(sp, spte_index(sptep), pte_access);
 	}
 
 	return ret;
@@ -2844,7 +2842,7 @@ static int direct_pte_prefetch_many(struct kvm_vcpu *vcpu,
 	int i, ret;
 	gfn_t gfn;
 
-	gfn = kvm_mmu_page_get_gfn(sp, start - sp->spt);
+	gfn = kvm_mmu_page_get_gfn(sp, spte_index(start));
 	slot = gfn_to_memslot_dirty_bitmap(vcpu, gfn, access & ACC_WRITE_MASK);
 	if (!slot)
 		return -1;
@@ -2870,7 +2868,7 @@ static void __direct_pte_prefetch(struct kvm_vcpu *vcpu,
 
 	WARN_ON(!sp->role.direct);
 
-	i = (sptep - sp->spt) & ~(PTE_PREFETCH_NUM - 1);
+	i = spte_index(sptep) & ~(PTE_PREFETCH_NUM - 1);
 	spte = sp->spt + i;
 
 	for (i = 0; i < PTE_PREFETCH_NUM; i++, spte++) {
@@ -6156,8 +6154,8 @@ static struct kvm_mmu_page *shadow_mmu_get_sp_for_split(struct kvm *kvm, u64 *hu
 	unsigned int access;
 	gfn_t gfn;
 
-	gfn = kvm_mmu_page_get_gfn(huge_sp, huge_sptep - huge_sp->spt);
-	access = kvm_mmu_page_get_access(huge_sp, huge_sptep - huge_sp->spt);
+	gfn = kvm_mmu_page_get_gfn(huge_sp, spte_index(huge_sptep));
+	access = kvm_mmu_page_get_access(huge_sp, spte_index(huge_sptep));
 
 	/*
 	 * Note, huge page splitting always uses direct shadow pages, regardless
@@ -6231,7 +6229,7 @@ static int shadow_mmu_try_split_huge_page(struct kvm *kvm,
 	u64 spte;
 
 	/* Grab information for the tracepoint before dropping the MMU lock. */
-	gfn = kvm_mmu_page_get_gfn(huge_sp, huge_sptep - huge_sp->spt);
+	gfn = kvm_mmu_page_get_gfn(huge_sp, spte_index(huge_sptep));
 	level = huge_sp->role.level;
 	spte = *huge_sptep;
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 2448fa8d8438..d06dee7d38a8 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -595,7 +595,7 @@ static void FNAME(pte_prefetch)(struct kvm_vcpu *vcpu, struct guest_walker *gw,
 	if (sp->role.direct)
 		return __direct_pte_prefetch(vcpu, sp, sptep);
 
-	i = (sptep - sp->spt) & ~(PTE_PREFETCH_NUM - 1);
+	i = spte_index(sptep) & ~(PTE_PREFETCH_NUM - 1);
 	spte = sp->spt + i;
 
 	for (i = 0; i < PTE_PREFETCH_NUM; i++, spte++) {
@@ -933,7 +933,7 @@ static void FNAME(invlpg)(struct kvm_vcpu *vcpu, gva_t gva, hpa_t root_hpa)
 				break;
 
 			pte_gpa = FNAME(get_level1_sp_gpa)(sp);
-			pte_gpa += (sptep - sp->spt) * sizeof(pt_element_t);
+			pte_gpa += spte_index(sptep) * sizeof(pt_element_t);
 
 			mmu_page_zap_pte(vcpu->kvm, sp, sptep, NULL);
 			if (is_shadow_present_pte(old_spte))
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index b5c855f5514f..ba3dccb202bc 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -190,6 +190,12 @@ static inline bool is_removed_spte(u64 spte)
 	return spte == REMOVED_SPTE;
 }
 
+/* Get an SPTE's index into its parent's page table (and the spt array). */
+static inline int spte_index(u64 *sptep)
+{
+	return ((unsigned long)sptep / sizeof(*sptep)) & (SPTE_ENT_PER_PAGE - 1);
+}
+
 /*
  * In some cases, we need to preserve the GFN of a non-present or reserved
  * SPTE when we usurp the upper five bits of the physical address space to
-- 
2.37.0.144.g8ac04bfd2-goog

