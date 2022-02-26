Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FDD4C528D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 01:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbiBZARk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 19:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240323AbiBZAQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 19:16:55 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024542261E4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 16:16:18 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id t68-20020a635f47000000b003732348b971so3493527pgb.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 16:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Lu5Zb5K5z9Ao4faecJWogQLcUl62itC1pDHyKWB4Szo=;
        b=rAH+CawAA7QAlMyJN3NdqP1kqf3643HSBwkEoDU38fZX3HhmSZHXCjwkA6eTZF9zeM
         h8uoj6K3E+4qSYaXDmhoZPe3RDLUrIVTd6CuVu4fLZgkqYqHd6GXX9i6aaRrZ4hkmOhX
         X6xr9MHYI9covtPmNWnB5Acxyd6uc03ZbiMN3JIduDeI9A0To20OtTKKlgERreCy45Hv
         6+f9s6fhKfE7Ds/+l8W8wMtjwKTZEqLSTNU6Phr9jtqjAi2jTIJV4bEymOSZyhh1HixD
         X5dPTEYpbbpdSN9TH+JMi227hrXI6mQpe2OPvmLz4NEv3v/nwi8wX3DUqKhh7fQi89FD
         JYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Lu5Zb5K5z9Ao4faecJWogQLcUl62itC1pDHyKWB4Szo=;
        b=HtTij8xNpQo+yeJU++tLoXNjrBGhf8XCVPG6FxRTh4lpLfPCgtmLkZlgsOhXNdaT/+
         7VKQqXF/vxvcnj4mlexrMHkDDOrTGUqrdbTcRRDwbbn+bTrOdXT5OfTIuO2rpkiRyqE6
         4VKR63fBrJvNqF6I2jyRZcBowa+kNetZkxaa/J3yZQy1H6BDXemeaomZQWu5Tgq7U8Wz
         vg8nRAD5FlXWPLfc4BsEqeVUEyb1uO1FShCgsvmhhW0kiBU1bJLC0cOAPIGtt0IeGSfn
         EMxddLuiueWEg18ulrLhHqorermPtbIx/KHvZrtkkfeSul2OTpqoXcjkJs+OnW0vEEDN
         ji+A==
X-Gm-Message-State: AOAM530xR0VchJVN4vI5OucS0vG8z+qNfQTTduFBEAMiY71lNDahvhLJ
        9OBPmVkQR9fj24VLMGFe8oz5QG3JO/k=
X-Google-Smtp-Source: ABdhPJz14fr8CmwWpHoBUZQ5h7RoKy3te0//NmcR2dmx3Olc8psLMchJrSZrtQlTY0WAg1eKXW9jY43YI/8=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a62:7554:0:b0:4e1:5898:4fbb with SMTP id
 q81-20020a627554000000b004e158984fbbmr10185233pfc.2.1645834578388; Fri, 25
 Feb 2022 16:16:18 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 26 Feb 2022 00:15:28 +0000
In-Reply-To: <20220226001546.360188-1-seanjc@google.com>
Message-Id: <20220226001546.360188-11-seanjc@google.com>
Mime-Version: 1.0
References: <20220226001546.360188-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v3 10/28] KVM: x86/mmu: Add helpers to read/write TDP MMU
 SPTEs and document RCU
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Mingwei Zhang <mizhang@google.com>
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

Add helpers to read and write TDP MMU SPTEs instead of open coding
rcu_dereference() all over the place, and to provide a convenient
location to document why KVM doesn't exempt holding mmu_lock for write
from having to hold RCU (and any future changes to the rules).

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_iter.c |  6 +++---
 arch/x86/kvm/mmu/tdp_iter.h | 16 ++++++++++++++++
 arch/x86/kvm/mmu/tdp_mmu.c  |  6 +++---
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_iter.c b/arch/x86/kvm/mmu/tdp_iter.c
index be3f096db2eb..6d3b3e5a5533 100644
--- a/arch/x86/kvm/mmu/tdp_iter.c
+++ b/arch/x86/kvm/mmu/tdp_iter.c
@@ -12,7 +12,7 @@ static void tdp_iter_refresh_sptep(struct tdp_iter *iter)
 {
 	iter->sptep = iter->pt_path[iter->level - 1] +
 		SHADOW_PT_INDEX(iter->gfn << PAGE_SHIFT, iter->level);
-	iter->old_spte = READ_ONCE(*rcu_dereference(iter->sptep));
+	iter->old_spte = kvm_tdp_mmu_read_spte(iter->sptep);
 }
 
 static gfn_t round_gfn_for_level(gfn_t gfn, int level)
@@ -89,7 +89,7 @@ static bool try_step_down(struct tdp_iter *iter)
 	 * Reread the SPTE before stepping down to avoid traversing into page
 	 * tables that are no longer linked from this entry.
 	 */
-	iter->old_spte = READ_ONCE(*rcu_dereference(iter->sptep));
+	iter->old_spte = kvm_tdp_mmu_read_spte(iter->sptep);
 
 	child_pt = spte_to_child_pt(iter->old_spte, iter->level);
 	if (!child_pt)
@@ -123,7 +123,7 @@ static bool try_step_side(struct tdp_iter *iter)
 	iter->gfn += KVM_PAGES_PER_HPAGE(iter->level);
 	iter->next_last_level_gfn = iter->gfn;
 	iter->sptep++;
-	iter->old_spte = READ_ONCE(*rcu_dereference(iter->sptep));
+	iter->old_spte = kvm_tdp_mmu_read_spte(iter->sptep);
 
 	return true;
 }
diff --git a/arch/x86/kvm/mmu/tdp_iter.h b/arch/x86/kvm/mmu/tdp_iter.h
index 216ebbe76ddd..bb9b581f1ee4 100644
--- a/arch/x86/kvm/mmu/tdp_iter.h
+++ b/arch/x86/kvm/mmu/tdp_iter.h
@@ -9,6 +9,22 @@
 
 typedef u64 __rcu *tdp_ptep_t;
 
+/*
+ * TDP MMU SPTEs are RCU protected to allow paging structures (non-leaf SPTEs)
+ * to be zapped while holding mmu_lock for read.  Holding RCU isn't required for
+ * correctness if mmu_lock is held for write, but plumbing "struct kvm" down to
+ * the lower depths of the TDP MMU just to make lockdep happy is a nightmare, so
+ * all accesses to SPTEs are done under RCU protection.
+ */
+static inline u64 kvm_tdp_mmu_read_spte(tdp_ptep_t sptep)
+{
+	return READ_ONCE(*rcu_dereference(sptep));
+}
+static inline void kvm_tdp_mmu_write_spte(tdp_ptep_t sptep, u64 val)
+{
+	WRITE_ONCE(*rcu_dereference(sptep), val);
+}
+
 /*
  * A TDP iterator performs a pre-order walk over a TDP paging structure.
  */
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 4f460782a848..8fbf3364f116 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -609,7 +609,7 @@ static inline int tdp_mmu_zap_spte_atomic(struct kvm *kvm,
 	 * here since the SPTE is going from non-present
 	 * to non-present.
 	 */
-	WRITE_ONCE(*rcu_dereference(iter->sptep), 0);
+	kvm_tdp_mmu_write_spte(iter->sptep, 0);
 
 	return 0;
 }
@@ -648,7 +648,7 @@ static inline void __tdp_mmu_set_spte(struct kvm *kvm, struct tdp_iter *iter,
 	 */
 	WARN_ON(is_removed_spte(iter->old_spte));
 
-	WRITE_ONCE(*rcu_dereference(iter->sptep), new_spte);
+	kvm_tdp_mmu_write_spte(iter->sptep, new_spte);
 
 	__handle_changed_spte(kvm, iter->as_id, iter->gfn, iter->old_spte,
 			      new_spte, iter->level, false);
@@ -1046,7 +1046,7 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 			 * because the new value informs the !present
 			 * path below.
 			 */
-			iter.old_spte = READ_ONCE(*rcu_dereference(iter.sptep));
+			iter.old_spte = kvm_tdp_mmu_read_spte(iter.sptep);
 		}
 
 		if (!is_shadow_present_pte(iter.old_spte)) {
-- 
2.35.1.574.g5d30c73bfb-goog

