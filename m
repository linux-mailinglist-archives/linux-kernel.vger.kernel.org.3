Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC704C5292
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 01:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240663AbiBZAS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 19:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241437AbiBZARz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 19:17:55 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8282325DF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 16:16:52 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b64-20020a256743000000b0061e169a5f19so4968428ybc.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 16:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=jDVD0FfZcUe5uWry8KBPjcFndvGRfOS1F52KZePQv64=;
        b=T9WXpGyEnZLrxkitFkBsPgYBLyCW7XwcE1VwCSGjV9s4WFQysreorHCGoMFsh8hrIM
         IzmblvucT4xzigG87YTxcYTRcNqbOFtd84wqGH3mYBWL8a73fTxpTd+W72Gk2DkVjLFg
         JTJBwaqj7alTS2R7hhU6fahZsJbsBIQDLo0mqHAJCulNVxA/aCYexv+WDODnzFHMSGa7
         pAHZE38TLzNkxPPyJa5T+aGqLLcmsCY+Cg4SNmMxQPznkQVu8MZ4gMTg2zrMmBu6hrvO
         lGcxqdBxGELdEzHXgOoVmjk10z8+WTpCQe/Q0MSpH3qsaKxNeja84KgfseJx+eFOzU/V
         0tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=jDVD0FfZcUe5uWry8KBPjcFndvGRfOS1F52KZePQv64=;
        b=nwLqDZmWa7kV2mH7mQIYv4VrQgNva38scQqHgI+fTbEit0OWuopGZg3XKwgtLuOKWA
         GNoEDF1VXCqkV0PkTyN/4HeyNsqPh5je33MS+2t0/MKh/JCOEITUvtpri7qCKhWYil7g
         fK5PpjffcBQMIgY3RouPrmPUWE5Xyx2/crtXGvWtf3X9oD8ymOR/f9uwAXdeWJMDLxt9
         xblUmWEhqpJQK+5Ql7+sjPMmQknwPxbtLGaq16TvvSW92+OQh4U2YehMFtGXbhMwcYCX
         5bgWlmO6QI1le4dNPchEFyHUQSxnLuUjyTvpVRHJdDdjHXMuMGBfmYzodsiulCO31Qer
         L5kA==
X-Gm-Message-State: AOAM531azqVou/ppRZq2i9AkY3q2wN/gOrm9dklWIjKlh/uLo6pU2dbb
        NMe5ZJ8oN8ohIejTD0oQbuOnu/dmY5g=
X-Google-Smtp-Source: ABdhPJxBK2MG0ah/gTntZ+O9t2UxhQVSELyR+UzzKfx3xqejvGSGlTsiwTsqCrtgJgDW8NhWeejikSqR4IM=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a25:c2c4:0:b0:615:ea99:43bc with SMTP id
 s187-20020a25c2c4000000b00615ea9943bcmr9759670ybf.283.1645834602019; Fri, 25
 Feb 2022 16:16:42 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 26 Feb 2022 00:15:42 +0000
In-Reply-To: <20220226001546.360188-1-seanjc@google.com>
Message-Id: <20220226001546.360188-25-seanjc@google.com>
Mime-Version: 1.0
References: <20220226001546.360188-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v3 24/28] KVM: x86/mmu: WARN on any attempt to atomically
 update REMOVED SPTE
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

Disallow calling tdp_mmu_set_spte_atomic() with a REMOVED "old" SPTE.
This solves a conundrum introduced by commit 3255530ab191 ("KVM: x86/mmu:
Automatically update iter->old_spte if cmpxchg fails"); if the helper
doesn't update old_spte in the REMOVED case, then theoretically the
caller could get stuck in an infinite loop as it will fail indefinitely
on the REMOVED SPTE.  E.g. until recently, clear_dirty_gfn_range() didn't
check for a present SPTE and would have spun until getting rescheduled.

In practice, only the page fault path should "create" a new SPTE, all
other paths should only operate on existing, a.k.a. shadow present,
SPTEs.  Now that the page fault path pre-checks for a REMOVED SPTE in all
cases, require all other paths to indirectly pre-check by verifying the
target SPTE is a shadow-present SPTE.

Note, this does not guarantee the actual SPTE isn't REMOVED, nor is that
scenario disallowed.  The invariant is only that the caller mustn't
invoke tdp_mmu_set_spte_atomic() if the SPTE was REMOVED when last
observed by the caller.

Cc: David Matlack <dmatlack@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 1acd12bf309f..d223870b3790 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -634,16 +634,15 @@ static inline int tdp_mmu_set_spte_atomic(struct kvm *kvm,
 	u64 *sptep = rcu_dereference(iter->sptep);
 	u64 old_spte;
 
-	WARN_ON_ONCE(iter->yielded);
-
-	lockdep_assert_held_read(&kvm->mmu_lock);
-
 	/*
-	 * Do not change removed SPTEs. Only the thread that froze the SPTE
-	 * may modify it.
+	 * The caller is responsible for ensuring the old SPTE is not a REMOVED
+	 * SPTE.  KVM should never attempt to zap or manipulate a REMOVED SPTE,
+	 * and pre-checking before inserting a new SPTE is advantageous as it
+	 * avoids unnecessary work.
 	 */
-	if (is_removed_spte(iter->old_spte))
-		return -EBUSY;
+	WARN_ON_ONCE(iter->yielded || is_removed_spte(iter->old_spte));
+
+	lockdep_assert_held_read(&kvm->mmu_lock);
 
 	/*
 	 * Note, fast_pf_fix_direct_spte() can also modify TDP MMU SPTEs and
-- 
2.35.1.574.g5d30c73bfb-goog

