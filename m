Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F64B463EBE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 20:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343550AbhK3To3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 14:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240147AbhK3ToK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 14:44:10 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80458C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 11:40:50 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id f125so7709282pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 11:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6J28hHyAsorL/rAvGFk46ctVABOLxhsZLPZlu6p1Pm0=;
        b=hH04HoExcD5kmQqA2QubeZ7zLPmL9jnCIcYvFKDAJPCm+t7FFUf5XetmC4MIrdN1lI
         C48r6ibi3EJyaMGi4VkiNZADzGW+YmL0O3vYNMu1IEg8PpaL8hToa9NrUd2XIgXhsjVh
         QT2qUMzot1QNRmaE7tkHLsVvoQY431TCSRWYjNrtrU2ToWuwSXBckmB8zKgWfwtsUH/J
         GFhgCZEVqxD7ccWsc+zFvt9KgJ4xjUh7f/Ea6wCeksRzxSyIZll62TNCgoGYE2BysxwG
         SFXbolfIdJmxRTcC+HXDT8uQrF65YTpBu4zUXSWkaKUVGxGq/krjhADlOgzmiIptrjA2
         gF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6J28hHyAsorL/rAvGFk46ctVABOLxhsZLPZlu6p1Pm0=;
        b=ybnvl+h3+RaJOWXReydbr22THQe95fERAWgHNHpXB2ecQ1Dqhiy1Ig0JrSfUnFsa0G
         OjEhrBhlkvmBokygZX+FMQIKCA8w+/vET2vIB/AAIsnah7kruHamUFJPGPsy/I9JwElC
         UIPDGKo2yDr6nDBPE6Mz+sbSCCZbU7zL7oqb2isJfYFwydcX3KYXaHg1tohljv9vF/6e
         3lGH1NlL+tAGIO0oZtdnHUcOEtE0rwsX26XU5EURf5akpWQk+mpcl8YN+EGBgkhUhgrD
         8pc0SPKWNFxO9gsdc+PFRsHVmk5/908oahAMUsN8QEDlVvPowGmwlwv9lJmFLBWJbB/2
         Wu2Q==
X-Gm-Message-State: AOAM532n3g6j0dA3UVS5XRs8v9bLWmD/Kn2PdcM0BBImu86jskItBT9t
        OI8AP1cJvImtbL6J+2iJGqe5IQ==
X-Google-Smtp-Source: ABdhPJwVyoJ8SmDSfTfWZHq+rN+X8y4F5ZqChSzdvW17188yvJdItwJ0anbDx6r6qy0eVftvBi0wOA==
X-Received: by 2002:a62:e406:0:b0:49f:dc1c:f3e1 with SMTP id r6-20020a62e406000000b0049fdc1cf3e1mr970488pfh.21.1638301249830;
        Tue, 30 Nov 2021 11:40:49 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id d17sm21695474pfj.215.2021.11.30.11.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 11:40:49 -0800 (PST)
Date:   Tue, 30 Nov 2021 19:40:45 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Matlack <dmatlack@google.com>
Cc:     Mingwei Zhang <mizhang@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH 2/2] KVM: mmu/x86: optimize zapping by retaining non-leaf
 SPTEs and avoid rcu stall
Message-ID: <YaZ+PSA9kOBYtpIz@google.com>
References: <20211124214421.458549-1-mizhang@google.com>
 <20211124214421.458549-3-mizhang@google.com>
 <YaV02MdGYlfGs35T@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaV02MdGYlfGs35T@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021, David Matlack wrote:
> > +		/*
> > +		 * In zap_all case, ignore the checking of present since we have
> > +		 * to zap everything.
> > +		 */
> > +		if (!zap_all && !is_shadow_present_pte(iter.old_spte))
> >  			continue;
> 
> I don't believe there's any reason to attempt to zap a non-present spte,
> even in the zap_all case. In any case, this change deserves its own
> patch and a commit message that describes why the old logic is incorrect
> and how this fixes it.

Yep, at best it's wasted cycles, at worst it will trigger WARN/BUG due to using
accessors that require the caller to check for a shadow present SPTE.

> >  		 * If this is a non-last-level SPTE that covers a larger range
> >  		 * than should be zapped, continue, and zap the mappings at a
> > -		 * lower level, except when zapping all SPTEs.
> > +		 * lower level. Actual zapping started at proper granularity
> > +		 * that is not so large as to cause a soft lockup when handling
> > +		 * the changed pte (which does not yield).
> >  		 */
> >  		if (!zap_all &&
> >  		    (iter.gfn < start ||
> > -		     iter.gfn + KVM_PAGES_PER_HPAGE(iter.level) > end) &&
> > +		     iter.gfn + KVM_PAGES_PER_HPAGE(iter.level) > end ||
> > +		     iter.level > PG_LEVEL_1G) &&
> >  		    !is_last_spte(iter.old_spte, iter.level))
> >  			continue;
> 
> This if statement is getting a bit long. I'd suggest breaking out the
> level check and also using KVM_MAX_HUGEPAGE_LEVEL.
> 
> e.g.
> 
>         /*
>          * If not doing zap_all, only zap up to the huge page level to
>          * avoid doing too much work in the recursive tdp_mmu_set_spte*
>          * call below, since it does not yield.
>          *
>          * This will potentially leave behind some childless page tables
>          * but that's ok because ...
>          */
>          if (!zap_all && iter.level > KVM_MAX_HUGEPAGE_LEVEL)
>                 continue;
> 
> And on that note, what is the reasoning for why it's ok to leave behind
> childless page tables? I assume it's because most of the time we'll use
> that page table again in the future, and at worst we leave the page
> table allocated until the VM is cleaned up?

Yes.  If zap_all=false, KVM is zapping a gfn range but not dropping or invalidating
the root.  The non-leaf paging structures are perfectly valid and can be reused.
There's certainly no guarantees that a structure will be reused, but keeping the
pages is ok because the memory consumed scales with the size of the VM, and the
number of shadow pages used for TDP is quite small, e.g. an order of magnitude less
than what's needed for shadow paging.

If we're ok waiting until my zap n' flush rework[*] lands, this is much easier to
handle, e.g. I think this will do it.

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 62cb357b1dff..8d3df03024b7 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -765,7 +765,7 @@ static void tdp_mmu_zap_root(struct kvm *kvm, struct kvm_mmu_page *root,
                             bool shared, bool root_is_unreachable)
 {
        struct tdp_iter iter;
-
+       bool leafs_only;
        gfn_t end = tdp_mmu_max_gfn_host();
        gfn_t start = 0;

@@ -773,12 +773,11 @@ static void tdp_mmu_zap_root(struct kvm *kvm, struct kvm_mmu_page *root,

        rcu_read_lock();

-       /*
-        * No need to try to step down in the iterator when zapping an entire
-        * root, zapping an upper-level SPTE will recurse on its children.
-        */
+again:
+       /* Add comment here. */
        for_each_tdp_pte_min_level(iter, root->spt, root->role.level,
-                                  root->role.level, start, end) {
+                                  leafs_only ? PG_LEVEL_4K : root->role.level,
+                                  start, end) {
 retry:
                if (tdp_mmu_iter_cond_resched(kvm, &iter, false, shared))
                        continue;
@@ -786,6 +785,9 @@ static void tdp_mmu_zap_root(struct kvm *kvm, struct kvm_mmu_page *root,
                if (!is_shadow_present_pte(iter.old_spte))
                        continue;

+               if (leafs_only && !is_last_spte(iter.old_spte, iter.level))
+                       continue;
+
                if (!shared) {
                        tdp_mmu_set_spte(kvm, &iter, 0);
                } else if (!tdp_mmu_set_spte_atomic(kvm, &iter, 0)) {
@@ -807,6 +809,11 @@ static void tdp_mmu_zap_root(struct kvm *kvm, struct kvm_mmu_page *root,
                WARN_ON_ONCE(root_is_unreachable && root->role.invalid);
        }

+       if (leafs_only) {
+               leafs_only = false;
+               goto again;
+       }
+
        rcu_read_unlock();
 }

[*] https://lore.kernel.org/all/20211120045046.3940942-1-seanjc@google.com/
