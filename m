Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C7254A16D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352355AbiFMVa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352837AbiFMV26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:28:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42C9218D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655155367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WoV34cLLDoYjPAUbIqILI+x6vFxD/nkRPtK+w2oUoZY=;
        b=ewEhN6Jk6uIOmsQ30D3YaGC02/NhIy52jN0xV3XLXbCsa7qhsf2QjEbgwJXu2epNtdpgf5
        BboUDTOsslVcYpfp0J3DI2QkZ7x76gCWNXaaAjZqSlbRz5ed21P8OLMmIIjHaYCdu5KGmS
        by177mQGw/Lymou6Vt2bTOSOr69LnC8=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-39-ZCdPt9BPPyaznv6ckrI_7Q-1; Mon, 13 Jun 2022 17:22:46 -0400
X-MC-Unique: ZCdPt9BPPyaznv6ckrI_7Q-1
Received: by mail-io1-f71.google.com with SMTP id w21-20020a5d9cd5000000b00669e6796a8aso1983404iow.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WoV34cLLDoYjPAUbIqILI+x6vFxD/nkRPtK+w2oUoZY=;
        b=mkq0GNNrpgjfW4NnfdeKIQ8m22QyJdabn+SiQnwNBgxw3T+Dlm+DIDG1wv1rgbz1DN
         7wcjrc4Rrz0Lr+jTqriBHnKS9mV9opEjkmTh/mMuQ3qntXriuCa4fjMmSrQzIgxGRGJq
         mAq0jvxlN8McDJH25SSyTKrRUTslNwkYLLE//bQtLGSQrVzddFfsjnDZui/0q6p4G2rP
         aJwL/tFCrJmGJzgHasBSK+RsG+s75cw0i6je+wuOKKHzadg7FOM7AohP86NPtqv5IHgs
         f3mEwoMzkhgxDBrlT2RK/89Vq2mxxna0dGe9xPj2wBg7CX5hneRxpfrXgyGNTUJQxVA7
         CPMg==
X-Gm-Message-State: AOAM5336dMgdBkhBILYrlgKSGIp1TA2su1/kfo+GjUDUQglI0ijQj9Ar
        p9byeS1O3ByJbtTfvaQ7jzfZs29flkYW+Wv34qAmuP6Qn6hZ4RnfrxsZX6JzekKlADNb6Dc3o+M
        08nNvg4wJkELOOoc3uKHZosRv
X-Received: by 2002:a6b:2b42:0:b0:669:ba8d:faa4 with SMTP id r63-20020a6b2b42000000b00669ba8dfaa4mr844839ior.190.1655155365269;
        Mon, 13 Jun 2022 14:22:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAiuUukB6suaMPqu2/EfWNPgO7Jei7NOVANncvQ8h2ykYATz9opIrXqt4LNNeD+SSu9JFTzg==
X-Received: by 2002:a6b:2b42:0:b0:669:ba8d:faa4 with SMTP id r63-20020a6b2b42000000b00669ba8dfaa4mr844826ior.190.1655155364935;
        Mon, 13 Jun 2022 14:22:44 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id w20-20020a029694000000b00331d98c9a7fsm3988207jai.40.2022.06.13.14.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 14:22:44 -0700 (PDT)
Date:   Mon, 13 Jun 2022 17:22:42 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH v2] mm/mprotect: try avoiding write faults for exclusive
 anonymous pages when changing protection
Message-ID: <YqeqoitbPzww9gWg@xz-m1.local>
References: <20220610181436.84713-1-david@redhat.com>
 <5DFB7262-6E32-4984-A346-B7DE5040B12F@gmail.com>
 <YqeTSj98t/KfOAJ9@xz-m1.local>
 <9b38302c-ed93-8825-f543-6ce8878748f9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b38302c-ed93-8825-f543-6ce8878748f9@redhat.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 10:10:16PM +0200, David Hildenbrand wrote:
> On 13.06.22 21:43, Peter Xu wrote:
> > Hi, David,
> > 
> > On Fri, Jun 10, 2022 at 11:42:06AM -0700, Nadav Amit wrote:
> >> On Jun 10, 2022, at 11:14 AM, David Hildenbrand <david@redhat.com> wrote:
> >>
> >>> Similar to our MM_CP_DIRTY_ACCT handling for shared, writable mappings, we
> >>> can try mapping anonymous pages writable if they are exclusive,
> >>> the PTE is already dirty, and no special handling applies. Mapping the
> >>> PTE writable is essentially the same thing the write fault handler would do
> >>> in this case.
> >>>
> >>> Special handling is required for uffd-wp and softdirty tracking, so take
> >>> care of that properly. Also, leave PROT_NONE handling alone for now;
> >>> in the future, we could similarly extend the logic in do_numa_page() or
> >>> use pte_mk_savedwrite() here. Note that we'll now also check for uffd-wp in
> >>> case of VM_SHARED -- which is harmless and prepares for uffd-wp support for
> >>> shmem.
> >>>
> >>> While this improves mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE)
> >>> performance, it should also be a valuable optimization for uffd-wp, when
> >>> un-protecting.
> >>>
> >>> Applying the same logic to PMDs (anonymous THP, anonymous hugetlb) is
> >>> probably not worth the trouble, but could similarly be added if there is
> >>> demand.
> > 
> > My memory was that Andrea had a version that used to have thp optimized
> > too.  It'll be a slight pity to lose it if still possible, then we treat
> > thp and small pages the same logic and be all fair.  Or is there any other
> > challenge that we're facing?
> 
> Not really, but I assume performance gain will be minimal and might not
> be worth the trouble.
> 
> I'm fairly busy (and not aware of Andreas version), so I can look at
> this, but it will be part of a separate patch because it will go on my
> TODO list. Not mad if someone beats me to it ;)

Just for the reference:

https://github.com/aagit/aa/commit/34cd0d78db407af06d35a06b24be8e92593964be

> 
> > 
> >>>
> >>> Results of a simple microbenchmark on my Ryzen 9 3900X, comparing the new
> >>> optimization (avoiding write faults) during mprotect() with softdirty
> >>> tracking, where we require a write fault.
> > 
> > Are we comparing the mprotect() sequence operations against softdirty
> > clearing operation?  Would it make more sense if we compare the same
> > mprotect() sequence to kernels that are before/after this patch applied?
> 
> For simplicity I compared on the same kernel, one time exploting the
> optimization and one time disabling the optimization via softdirty.
> 
> I can also simply measure without+with. Extra work for me to combine
> outputs :P

Well, still that's normally how we work on these, don't we? :)

Still note that the SOFTDIRTY check (I think) was still reverted..  I meant
I kept thinking below check "vma->vm_flags & VM_SOFTDIRTY" should be
"!(vma->vm_flags & VM_SOFTDIRTY)", but again that's separate change so feel
free to ignore as we've discussed, but please make sure even if you want to
compare with softdirty that's taking into account.

> 
> > 
> >>>
> >>>  Running 1000 iterations each
> >>>
> >>>  ==========================================================
> >>>  Measuring memset() of 4096 bytes
> >>>   First write access:
> >>>    Min: 169 ns, Max: 8997 ns, Avg: 830 ns
> >>>   Second write access:
> >>>    Min: 80 ns, Max: 251 ns, Avg: 168 ns
> >>>   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
> >>>    Min: 180 ns, Max: 290 ns, Avg: 190 ns
> >>>   Write access after clearing softdirty:
> >>>    Min: 451 ns, Max: 1774 ns, Avg: 470 ns
> >>>  -> mprotect = 1.131 * second [avg]
> >>>  -> mprotect = 0.404 * softdirty [avg]
> > 
> > (I don't understand these two lines.. but maybe I'm the only one?)
> 
> Most probably not.
> 
> "mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE)" needs 113,1% the
> runtime compared with the "second write" access.
> 
> "mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE)" needs 40% of the
> runtime compared with disabling the optimization via softdirty tracking.
> 
> I may find time to clean that up a bit more to make it easier to consume
> for humans.

I see, thanks.  Appending the explanation after the test result will also
work for me.

I'm curious is that 113.1% came from tlb miss?  If that's the case, I'd
suggest drop those comparisons if there's a new version, since they're
probably not helping to explain what this patch is changing (avoid page
faluts), and IMHO it can slightly confuse reviewers, if you agree.

> 
> > 
> >>>  ----------------------------------------------------------
> >>>  Measuring single byte access per page of 4096 bytes
> >>>   First write access:
> >>>    Min: 761 ns, Max: 1152 ns, Avg: 784 ns
> >>>   Second write access:
> >>>    Min: 130 ns, Max: 181 ns, Avg: 137 ns
> >>>   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
> >>>    Min: 150 ns, Max: 1553 ns, Avg: 155 ns
> >>>   Write access after clearing softdirty:
> >>>    Min: 169 ns, Max: 1783 ns, Avg: 432 ns
> >>>  -> mprotect = 1.131 * second [avg]
> >>>  -> mprotect = 0.359 * softdirty [avg]
> >>>  ==========================================================
> >>>  Measuring memset() of 16384 bytes
> >>>   First write access:
> >>>    Min: 1594 ns, Max: 3497 ns, Avg: 2143 ns
> >>>   Second write access:
> >>>    Min: 250 ns, Max: 381 ns, Avg: 260 ns
> >>>   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
> >>>    Min: 290 ns, Max: 1643 ns, Avg: 300 ns
> >>>   Write access after clearing softdirty:
> >>>    Min: 1242 ns, Max: 8987 ns, Avg: 1297 ns
> >>>  -> mprotect = 1.154 * second [avg]
> >>>  -> mprotect = 0.231 * softdirty [avg]
> >>>  ----------------------------------------------------------
> >>>  Measuring single byte access per page of 16384 bytes
> >>>   First write access:
> >>>    Min: 1953 ns, Max: 2945 ns, Avg: 2008 ns
> >>>   Second write access:
> >>>    Min: 130 ns, Max: 912 ns, Avg: 142 ns
> >>>   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
> >>>    Min: 160 ns, Max: 240 ns, Avg: 166 ns
> >>>   Write access after clearing softdirty:
> >>>    Min: 1112 ns, Max: 1513 ns, Avg: 1126 ns
> >>>  -> mprotect = 1.169 * second [avg]
> >>>  -> mprotect = 0.147 * softdirty [avg]
> >>>  ==========================================================
> >>>  Measuring memset() of 65536 bytes
> >>>   First write access:
> >>>    Min: 7524 ns, Max: 15650 ns, Avg: 7680 ns
> >>>   Second write access:
> >>>    Min: 251 ns, Max: 1323 ns, Avg: 648 ns
> >>>   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
> >>>    Min: 270 ns, Max: 1282 ns, Avg: 736 ns
> >>>   Write access after clearing softdirty:
> >>>    Min: 4558 ns, Max: 12524 ns, Avg: 4623 ns
> >>>  -> mprotect = 1.136 * second [avg]
> >>>  -> mprotect = 0.159 * softdirty [avg]
> >>>  ----------------------------------------------------------
> >>>  Measuring single byte access per page of 65536 bytes
> >>>   First write access:
> >>>    Min: 7083 ns, Max: 9027 ns, Avg: 7241 ns
> >>>   Second write access:
> >>>    Min: 140 ns, Max: 201 ns, Avg: 156 ns
> >>>   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
> >>>    Min: 190 ns, Max: 451 ns, Avg: 197 ns
> >>>   Write access after clearing softdirty:
> >>>    Min: 3707 ns, Max: 5119 ns, Avg: 3958 ns
> >>>  -> mprotect = 1.263 * second [avg]
> >>>  -> mprotect = 0.050 * softdirty [avg]
> >>>  ==========================================================
> >>>  Measuring memset() of 524288 bytes
> >>>   First write access:
> >>>    Min: 58470 ns, Max: 87754 ns, Avg: 59353 ns
> >>>   Second write access:
> >>>    Min: 5180 ns, Max: 6863 ns, Avg: 5318 ns
> >>>   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
> >>>    Min: 5871 ns, Max: 9358 ns, Avg: 6028 ns
> >>>   Write access after clearing softdirty:
> >>>    Min: 35797 ns, Max: 41338 ns, Avg: 36710 ns
> >>>  -> mprotect = 1.134 * second [avg]
> >>>  -> mprotect = 0.164 * softdirty [avg]
> >>>  ----------------------------------------------------------
> >>>  Measuring single byte access per page of 524288 bytes
> >>>   First write access:
> >>>    Min: 53751 ns, Max: 59431 ns, Avg: 54506 ns
> >>>   Second write access:
> >>>    Min: 781 ns, Max: 2194 ns, Avg: 1123 ns
> >>>   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
> >>>    Min: 161 ns, Max: 1282 ns, Avg: 622 ns
> >>>   Write access after clearing softdirty:
> >>>    Min: 30888 ns, Max: 34565 ns, Avg: 31229 ns
> >>>  -> mprotect = 0.554 * second [avg]
> >>>  -> mprotect = 0.020 * softdirty [avg]
> >>>
> >>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> >>> Cc: Andrew Morton <akpm@linux-foundation.org>
> >>> Cc: Nadav Amit <nadav.amit@gmail.com>
> >>> Cc: Dave Hansen <dave.hansen@intel.com>
> >>> Cc: Andrea Arcangeli <aarcange@redhat.com>
> >>> Cc: Peter Xu <peterx@redhat.com>
> >>> Cc: Yang Shi <shy828301@gmail.com>
> >>> Cc: Hugh Dickins <hughd@google.com>
> >>> Cc: Mel Gorman <mgorman@techsingularity.net>
> >>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>> ---
> >>>
> >>> v1 -> v2:
> >>> * Rebased on v5.19-rc1
> >>> * Rerun benchmark
> >>> * Fix minor spelling issues in subject+description
> >>> * Drop IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) check
> >>> * Move pte_write() check into caller
> >>>
> >>> ---
> >>> mm/mprotect.c | 67 ++++++++++++++++++++++++++++++++++++++++++---------
> >>> 1 file changed, 55 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/mm/mprotect.c b/mm/mprotect.c
> >>> index ba5592655ee3..728772bf41c7 100644
> >>> --- a/mm/mprotect.c
> >>> +++ b/mm/mprotect.c
> >>> @@ -38,6 +38,45 @@
> >>>
> >>> #include "internal.h"
> >>>
> >>> +static inline bool can_change_pte_writable(struct vm_area_struct *vma,
> >>> +					   unsigned long addr, pte_t pte,
> >>> +					   unsigned long cp_flags)
> >>> +{
> >>> +	struct page *page;
> >>> +
> >>> +	if ((vma->vm_flags & VM_SHARED) && !(cp_flags & MM_CP_DIRTY_ACCT))
> >>> +		/*
> >>> +		 * MM_CP_DIRTY_ACCT is only expressive for shared mappings;
> >>> +		 * without MM_CP_DIRTY_ACCT, there is nothing to do.
> >>> +		 */
> >>> +		return false;
> >>> +
> >>> +	if (pte_protnone(pte) || !pte_dirty(pte))
> >>> +		return false;
> >>> +
> >>> +	/* Do we need write faults for softdirty tracking? */
> >>> +	if ((vma->vm_flags & VM_SOFTDIRTY) && !pte_soft_dirty(pte))
> >>> +		return false;
> >>> +
> >>> +	/* Do we need write faults for uffd-wp tracking? */
> >>> +	if (userfaultfd_pte_wp(vma, pte))
> >>> +		return false;
> >>> +
> >>> +	if (!(vma->vm_flags & VM_SHARED)) {
> >>> +		/*
> >>> +		 * We can only special-case on exclusive anonymous pages,
> >>> +		 * because we know that our write-fault handler similarly would
> >>> +		 * map them writable without any additional checks while holding
> >>> +		 * the PT lock.
> >>> +		 */
> >>> +		page = vm_normal_page(vma, addr, pte);
> >>> +		if (!page || !PageAnon(page) || !PageAnonExclusive(page))
> >>> +			return false;
> >>> +	}
> >>> +
> >>> +	return true;
> >>> +}
> >>> +
> >>
> >> Looks good in general. Just wondering (out loud) whether it makes more sense
> >> to do all the vm_flags and cp_flags related checks in one of the callers
> >> (mprotect_fixup()?) and propagate whether to try to write-unprotect in
> >> cp_flags (e.g., by introducing new MM_CP_TRY_WRITE_UNPROTECT).
> > 
> > I can see why David put it like that, because most of the checks are on
> > ptes not vm_flags.
> > 
> > But I also agree on this point, especially if to put it in another way:
> > IMHO it'll be confusing if we keey MM_CP_DIRTY_ACCT==false for all private
> > pages even if we're going to take them into account and do smart unprotect
> > operations.
> > 
> > So I'm wondering whether we could still at least move vm_flags check into
> > the mprotect_fixup() as suggested by Nadav, perhaps something like:
> > 
> > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > index ba5592655ee3..aefd5fe982af 100644
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -583,7 +583,11 @@ mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *vma,
> >          * held in write mode.
> >          */
> >         vma->vm_flags = newflags;
> > -       dirty_accountable = vma_wants_writenotify(vma, vma->vm_page_prot);
> > +       if (vma->vm_flags & VM_SHARED)
> > +               dirty_accountable = vma_wants_writenotify(vma, vma->vm_page_prot);
> > +       else
> > +               /* For private mappings, only if it's writable */
> > +               dirty_accountable = vma->vm_flags & VM_WRITE;
> >         vma_set_page_prot(vma);
> >  
> >         change_protection(tlb, vma, start, end, vma->vm_page_prot,
> > 
> > Then IIUC we could drop both the VM_WRITE check in change_pte_range(), and
> > also the VM_SHARED check above in can_change_pte_writable().  Not sure
> > whether that'll look slightly cleaner.
> 
> I'll give it a shot and most probably rename dirty_accountable to
> something more expressive -- like Nadav proposed, for example.

Sure.

> 
> > 
> > I'm also copying Peter Collingbourne <pcc@google.com> because afaict he
> > proposed the initial idea (maybe worth some credit in the commit message?),
> 
> Do you have a link to that conversation? Either my memory is messing
> with me or I did this without reading that mail (which I think, because
> it simply made sense with PageAnonExclusive at hand). Still, I can add a
> reference to that mail and mention that this was suggested earlier by
> Peter C..

I see, no worry then I thought it was coming from that.  In this case I'm
not sure whether it's still needed.

PeterC's v1 was here:

https://lore.kernel.org/linux-mm/20201212053152.3783250-1-pcc@google.com/

But there're a bunch of versions:

https://lore.kernel.org/linux-mm/?q=mm%3A+improve+mprotect%28R%7CW%29+efficiency+on+pages+referenced+once

Thanks,

-- 
Peter Xu

