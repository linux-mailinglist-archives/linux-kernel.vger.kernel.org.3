Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F6247E953
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 23:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350504AbhLWWYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 17:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350446AbhLWWXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 17:23:52 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE780C06175D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 14:23:48 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id n18-20020a056a00213200b004baa74aca72so3987918pfj.19
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 14:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ZUWnlx6tDuEZy0/vV2sw5dzru8Z2gIDouCHSlfxHcxQ=;
        b=k4V9QdP6pgnjQiAyDIGFQ3IbXAdMAIGLwhbBQGB76N29OcRiybSsC1Xq3IbzDQW0JV
         ud5aflcB07n6mMIEAbFEJGTVUZkS6hL2EiQCLoFu+bJQ41J+kn4rOvQjYbn+SBZJVmRl
         2KFAfBfJepWrqN3BuApd2XekxXIGmWVoeb2R9HqgyoFaoKHh8EH5/W+RzAfCcPhHk7X9
         lN4HmlUbpX505CK5tZMLIVLJrFlCsC1ZTF2dbvxKlrJUG74Di/h/0MROuY+Gg8Y8pSGi
         Da+PtK5QGf+tuqWBw/NE5N6AUCFE6VmRAhX62gd3R9Ljd/fgY1wMZsHIv2UPUWcJ8Rdh
         Aqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ZUWnlx6tDuEZy0/vV2sw5dzru8Z2gIDouCHSlfxHcxQ=;
        b=SlnX6DtGZArDnl+4gvRjGHULEAm7bwDZowqL3YpzfZcjo+3A+fcWEclyxWIF4Cv/pT
         3TEO05DfOvIphkfrB16wZAePGkleqWgLRKCmQQCG11YU2Cn8qH+DDOpW0/0AGKWqLq0Z
         phlpGQaeQ1+Y4AaPeA7m06ZRHcdfqMfXEJ2c8NqdTFb438OlMJUfaEaCuhgoFxjOpn0r
         c9TmGC0q5+n07crdcDkm0f+FVz95x9QJTHab8nxd7BuwuABebNh6zGfNkcdn/NrJzpOJ
         9uYBSSAuEBxPpsm2ZkBVqUhoZEkLNBqCYpX4Rzl7lawFAbIyWdez80wSn2xsEBYxZ3yH
         8R0A==
X-Gm-Message-State: AOAM53241piiQ5zl5yRtDHh0voMBMrIZa6yZE1oTyFeAQ5JJU7ejHUgi
        EL4REDIO9zYMW4A+bld83yDX+AF7NWo=
X-Google-Smtp-Source: ABdhPJyn5LW9UyEMjasLetWykpvTmR07wO2hYJdg6iT6muq92I13GNnJNVEpjCDGp6kCVhZ+fkbOYRoBGQE=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a62:6488:0:b0:4ba:95ec:a333 with SMTP id
 y130-20020a626488000000b004ba95eca333mr4093463pfb.23.1640298228413; Thu, 23
 Dec 2021 14:23:48 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 23 Dec 2021 22:22:52 +0000
In-Reply-To: <20211223222318.1039223-1-seanjc@google.com>
Message-Id: <20211223222318.1039223-5-seanjc@google.com>
Mime-Version: 1.0
References: <20211223222318.1039223-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v2 04/30] KVM: x86/mmu: Use common iterator for walking
 invalid TDP MMU roots
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that tdp_mmu_next_root() can process both valid and invalid roots,
extend it to be able to process _only_ invalid roots, add yet another
iterator macro for walking invalid roots, and use the new macro in
kvm_tdp_mmu_zap_invalidated_roots().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 74 ++++++++++++++------------------------
 1 file changed, 26 insertions(+), 48 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 577985fa001d..41e975841ea6 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -98,6 +98,12 @@ void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root,
 	call_rcu(&root->rcu_head, tdp_mmu_free_sp_rcu_callback);
 }
 
+enum tdp_mmu_roots_iter_type {
+	ALL_ROOTS = -1,
+	VALID_ROOTS = 0,
+	INVALID_ROOTS = 1,
+};
+
 /*
  * Returns the next root after @prev_root (or the first root if @prev_root is
  * NULL).  A reference to the returned root is acquired, and the reference to
@@ -110,10 +116,16 @@ void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root,
  */
 static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
 					      struct kvm_mmu_page *prev_root,
-					      bool shared, bool only_valid)
+					      bool shared,
+					      enum tdp_mmu_roots_iter_type type)
 {
 	struct kvm_mmu_page *next_root;
 
+	kvm_lockdep_assert_mmu_lock_held(kvm, shared);
+
+	/* Ensure correctness for the below comparison against role.invalid. */
+	BUILD_BUG_ON(!!VALID_ROOTS || !INVALID_ROOTS);
+
 	rcu_read_lock();
 
 	if (prev_root)
@@ -125,7 +137,7 @@ static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
 						   typeof(*next_root), link);
 
 	while (next_root) {
-		if ((!only_valid || !next_root->role.invalid) &&
+		if ((type == ALL_ROOTS || (type == !!next_root->role.invalid)) &&
 		    kvm_tdp_mmu_get_root(kvm, next_root))
 			break;
 
@@ -151,18 +163,21 @@ static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
  * mode. In the unlikely event that this thread must free a root, the lock
  * will be temporarily dropped and reacquired in write mode.
  */
-#define __for_each_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, _shared, _only_valid)\
-	for (_root = tdp_mmu_next_root(_kvm, NULL, _shared, _only_valid);	\
+#define __for_each_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, _shared, _type) \
+	for (_root = tdp_mmu_next_root(_kvm, NULL, _shared, _type);		\
 	     _root;								\
-	     _root = tdp_mmu_next_root(_kvm, _root, _shared, _only_valid))	\
-		if (kvm_mmu_page_as_id(_root) != _as_id) {			\
+	     _root = tdp_mmu_next_root(_kvm, _root, _shared, _type))		\
+		if (_as_id > 0 && kvm_mmu_page_as_id(_root) != _as_id) {	\
 		} else
 
+#define for_each_invalid_tdp_mmu_root_yield_safe(_kvm, _root)			\
+	__for_each_tdp_mmu_root_yield_safe(_kvm, _root, -1, true, INVALID_ROOTS)
+
 #define for_each_valid_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, _shared)	\
-	__for_each_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, _shared, true)
+	__for_each_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, _shared, VALID_ROOTS)
 
 #define for_each_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, _shared)		\
-	__for_each_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, _shared, false)
+	__for_each_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, _shared, ALL_ROOTS)
 
 #define for_each_tdp_mmu_root(_kvm, _root, _as_id)				\
 	list_for_each_entry_rcu(_root, &_kvm->arch.tdp_mmu_roots, link,		\
@@ -811,28 +826,6 @@ void kvm_tdp_mmu_zap_all(struct kvm *kvm)
 		kvm_flush_remote_tlbs(kvm);
 }
 
-static struct kvm_mmu_page *next_invalidated_root(struct kvm *kvm,
-						  struct kvm_mmu_page *prev_root)
-{
-	struct kvm_mmu_page *next_root;
-
-	if (prev_root)
-		next_root = list_next_or_null_rcu(&kvm->arch.tdp_mmu_roots,
-						  &prev_root->link,
-						  typeof(*prev_root), link);
-	else
-		next_root = list_first_or_null_rcu(&kvm->arch.tdp_mmu_roots,
-						   typeof(*next_root), link);
-
-	while (next_root && !(next_root->role.invalid &&
-			      refcount_read(&next_root->tdp_mmu_root_count)))
-		next_root = list_next_or_null_rcu(&kvm->arch.tdp_mmu_roots,
-						  &next_root->link,
-						  typeof(*next_root), link);
-
-	return next_root;
-}
-
 /*
  * Since kvm_tdp_mmu_zap_all_fast has acquired a reference to each
  * invalidated root, they will not be freed until this function drops the
@@ -843,36 +836,21 @@ static struct kvm_mmu_page *next_invalidated_root(struct kvm *kvm,
  */
 void kvm_tdp_mmu_zap_invalidated_roots(struct kvm *kvm)
 {
-	struct kvm_mmu_page *next_root;
 	struct kvm_mmu_page *root;
 	bool flush = false;
 
 	lockdep_assert_held_read(&kvm->mmu_lock);
 
-	rcu_read_lock();
-
-	root = next_invalidated_root(kvm, NULL);
-
-	while (root) {
-		next_root = next_invalidated_root(kvm, root);
-
-		rcu_read_unlock();
-
+	for_each_invalid_tdp_mmu_root_yield_safe(kvm, root) {
 		flush = zap_gfn_range(kvm, root, 0, -1ull, true, flush, true);
 
 		/*
-		 * Put the reference acquired in
-		 * kvm_tdp_mmu_invalidate_roots
+		 * Put the reference acquired in kvm_tdp_mmu_invalidate_roots().
+		 * Note, the iterator holds its own reference.
 		 */
 		kvm_tdp_mmu_put_root(kvm, root, true);
-
-		root = next_root;
-
-		rcu_read_lock();
 	}
 
-	rcu_read_unlock();
-
 	if (flush)
 		kvm_flush_remote_tlbs(kvm);
 }
-- 
2.34.1.448.ga2b2bfdf31-goog

