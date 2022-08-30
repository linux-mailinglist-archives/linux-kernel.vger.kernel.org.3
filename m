Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2D55A7215
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiH3X4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiH3Xz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:55:57 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2796CF7B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:55:50 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id m15-20020a170902db0f00b001753b1c5adeso882690plx.18
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc;
        bh=OEXYXOPsjQnvNo18Y8S1WOEsrNik2WeeLM8VKO0HexY=;
        b=kFN6altA4K9S6B0wKomy0TqJTB21e/0j6Xgj5NlTOaR+uX8wEXshLknKJI7JO3JtVi
         US0gQduwpxMw82FObW2HfDrmM+eOVPERM6cHyXd2+bKEIEhQxJBbnpiFYTL6vD9h6KvQ
         +mDdUMa31lF4FdAU4uRWKnTp2ug7HXmGRUc48qqlxgJRXQVy0MJFNmc+LNI768Rfw/J/
         ZS++x29sYph08bjTc7E8P37E0frBdH0JTzUPAEWKD6r5Ru+hpE5Oh9cDKuvot9lC4ZpH
         /b7nHBJ9By84kNXsTYcFmiMqG6vHvPtoaYr+DG6axOpVX70hcR3ujjLl2epGWLyB3tas
         Dmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc;
        bh=OEXYXOPsjQnvNo18Y8S1WOEsrNik2WeeLM8VKO0HexY=;
        b=v49oR3yXqi3ceHfENUj4DIUvqLMzj01LUFhZVVgpkcHjibsSK6df0Mi7Ow0UyAzoIF
         laGng2ZV7fcePMEluEjbWYur6eke3e/2ZkrqKHkZbe6rfFndYuQQTuYNlzIfRFfwdEq8
         oFqO0nu0tYIAi6tMHt2lk9u+wtU5AlEFbc9v10S/gSXRrsw+2wz+ZjA1Okt6ncw2aoEF
         ttVwQBO+H3zcW2eXX7Wi+fj4UADSDAVn9qfb7gOK5QbNl9KaX/8jwsOjB/Lh9ROUDrjJ
         vdRUcAPr6Ld82wfp4armKLjsp8ann6MMcV2AkWH7WFMIP7dOFAtv8Pz2lMLsuhjfD/Qn
         YQww==
X-Gm-Message-State: ACgBeo2mt8r+m/aKrIf924bBNd1wMaCHZEoXd+D2UgiE3uMJnM9bpWdA
        Asyaec/aVv8VDn/HAtI1dFzvIyV9EHM=
X-Google-Smtp-Source: AA6agR6VJzTsPSk8HW+30rJ7QUwgbVeJU6Eo+R4UIW/wTF1ueU/+7jHW7lYRsaJpC/7SGIwsPRCBQp3HFrs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ce88:b0:174:9e8e:ee39 with SMTP id
 f8-20020a170902ce8800b001749e8eee39mr14420990plg.71.1661903749736; Tue, 30
 Aug 2022 16:55:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 30 Aug 2022 23:55:34 +0000
In-Reply-To: <20220830235537.4004585-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220830235537.4004585-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830235537.4004585-7-seanjc@google.com>
Subject: [PATCH v4 6/9] KVM: x86/mmu: Set disallowed_nx_huge_page in TDP MMU
 before setting SPTE
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Ben Gardon <bgardon@google.com>
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

Set nx_huge_page_disallowed in TDP MMU shadow pages before making the SP
visible to other readers, i.e. before setting its SPTE.  This will allow
KVM to query the flag when determining if a shadow page can be replaced
by a NX huge page without violating the rules of the mitigation.

Note, the shadow/legacy MMU holds mmu_lock for write, so it's impossible
for another CPU to see a shadow page without an up-to-date
nx_huge_page_disallowed, i.e. only the TDP MMU needs the complicated
dance.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>
---
 arch/x86/kvm/mmu/mmu.c          | 28 ++++++++++++++++++----------
 arch/x86/kvm/mmu/mmu_internal.h |  5 ++---
 arch/x86/kvm/mmu/tdp_mmu.c      | 31 ++++++++++++++++++-------------
 3 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 04eb87f5a39d..de06c1f87635 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -802,22 +802,25 @@ static void account_shadowed(struct kvm *kvm, struct kvm_mmu_page *sp)
 		kvm_flush_remote_tlbs_with_address(kvm, gfn, 1);
 }
 
-void account_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp,
-			  bool nx_huge_page_possible)
+void track_possible_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
 	if (KVM_BUG_ON(!list_empty(&sp->possible_nx_huge_page_link), kvm))
 		return;
 
-	sp->nx_huge_page_disallowed = true;
-
-	if (!nx_huge_page_possible)
-		return;
-
 	++kvm->stat.nx_lpage_splits;
 	list_add_tail(&sp->possible_nx_huge_page_link,
 		      &kvm->arch.possible_nx_huge_pages);
 }
 
+static void account_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp,
+				 bool nx_huge_page_possible)
+{
+	sp->nx_huge_page_disallowed = true;
+
+	if (nx_huge_page_possible)
+		track_possible_nx_huge_page(kvm, sp);
+}
+
 static void unaccount_shadowed(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
 	struct kvm_memslots *slots;
@@ -835,10 +838,8 @@ static void unaccount_shadowed(struct kvm *kvm, struct kvm_mmu_page *sp)
 	kvm_mmu_gfn_allow_lpage(slot, gfn);
 }
 
-void unaccount_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp)
+void untrack_possible_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
-	sp->nx_huge_page_disallowed = false;
-
 	if (list_empty(&sp->possible_nx_huge_page_link))
 		return;
 
@@ -846,6 +847,13 @@ void unaccount_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 	list_del_init(&sp->possible_nx_huge_page_link);
 }
 
+static void unaccount_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp)
+{
+	sp->nx_huge_page_disallowed = false;
+
+	untrack_possible_nx_huge_page(kvm, sp);
+}
+
 static struct kvm_memory_slot *
 gfn_to_memslot_dirty_bitmap(struct kvm_vcpu *vcpu, gfn_t gfn,
 			    bool no_dirty_log)
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 67879459a25c..22152241bd29 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -328,8 +328,7 @@ void disallowed_hugepage_adjust(struct kvm_page_fault *fault, u64 spte, int cur_
 
 void *mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
 
-void account_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp,
-			  bool nx_huge_page_possible);
-void unaccount_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp);
+void track_possible_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp);
+void untrack_possible_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp);
 
 #endif /* __KVM_X86_MMU_INTERNAL_H */
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index d1079fabe14c..fd38465aee9e 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -403,8 +403,11 @@ static void tdp_mmu_unlink_sp(struct kvm *kvm, struct kvm_mmu_page *sp,
 		lockdep_assert_held_write(&kvm->mmu_lock);
 
 	list_del(&sp->link);
-	if (sp->nx_huge_page_disallowed)
-		unaccount_nx_huge_page(kvm, sp);
+
+	if (sp->nx_huge_page_disallowed) {
+		sp->nx_huge_page_disallowed = false;
+		untrack_possible_nx_huge_page(kvm, sp);
+	}
 
 	if (shared)
 		spin_unlock(&kvm->arch.tdp_mmu_pages_lock);
@@ -1123,16 +1126,13 @@ static int tdp_mmu_map_handle_target_level(struct kvm_vcpu *vcpu,
  * @kvm: kvm instance
  * @iter: a tdp_iter instance currently on the SPTE that should be set
  * @sp: The new TDP page table to install.
- * @account_nx: True if this page table is being installed to split a
- *              non-executable huge page.
  * @shared: This operation is running under the MMU lock in read mode.
  *
  * Returns: 0 if the new page table was installed. Non-0 if the page table
  *          could not be installed (e.g. the atomic compare-exchange failed).
  */
 static int tdp_mmu_link_sp(struct kvm *kvm, struct tdp_iter *iter,
-			   struct kvm_mmu_page *sp, bool account_nx,
-			   bool shared)
+			   struct kvm_mmu_page *sp, bool shared)
 {
 	u64 spte = make_nonleaf_spte(sp->spt, !kvm_ad_enabled());
 	int ret = 0;
@@ -1147,8 +1147,6 @@ static int tdp_mmu_link_sp(struct kvm *kvm, struct tdp_iter *iter,
 
 	spin_lock(&kvm->arch.tdp_mmu_pages_lock);
 	list_add(&sp->link, &kvm->arch.tdp_mmu_pages);
-	if (account_nx)
-		account_nx_huge_page(kvm, sp, true);
 	spin_unlock(&kvm->arch.tdp_mmu_pages_lock);
 	tdp_account_mmu_page(kvm, sp);
 
@@ -1162,6 +1160,7 @@ static int tdp_mmu_link_sp(struct kvm *kvm, struct tdp_iter *iter,
 int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	struct kvm *kvm = vcpu->kvm;
 	struct tdp_iter iter;
 	struct kvm_mmu_page *sp;
 	int ret;
@@ -1198,9 +1197,6 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		}
 
 		if (!is_shadow_present_pte(iter.old_spte)) {
-			bool account_nx = fault->huge_page_disallowed &&
-					  fault->req_level >= iter.level;
-
 			/*
 			 * If SPTE has been frozen by another thread, just
 			 * give up and retry, avoiding unnecessary page table
@@ -1212,10 +1208,19 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 			sp = tdp_mmu_alloc_sp(vcpu);
 			tdp_mmu_init_child_sp(sp, &iter);
 
-			if (tdp_mmu_link_sp(vcpu->kvm, &iter, sp, account_nx, true)) {
+			sp->nx_huge_page_disallowed = fault->huge_page_disallowed;
+
+			if (tdp_mmu_link_sp(kvm, &iter, sp, true)) {
 				tdp_mmu_free_sp(sp);
 				break;
 			}
+
+			if (fault->huge_page_disallowed &&
+			    fault->req_level >= iter.level) {
+				spin_lock(&kvm->arch.tdp_mmu_pages_lock);
+				track_possible_nx_huge_page(kvm, sp);
+				spin_unlock(&kvm->arch.tdp_mmu_pages_lock);
+			}
 		}
 	}
 
@@ -1503,7 +1508,7 @@ static int tdp_mmu_split_huge_page(struct kvm *kvm, struct tdp_iter *iter,
 	 * correctness standpoint since the translation will be the same either
 	 * way.
 	 */
-	ret = tdp_mmu_link_sp(kvm, iter, sp, false, shared);
+	ret = tdp_mmu_link_sp(kvm, iter, sp, shared);
 	if (ret)
 		goto out;
 
-- 
2.37.2.672.g94769d06f0-goog

