Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41FA5A8311
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 18:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiHaQWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiHaQWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:22:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FF0D11CB
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661962915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q2PvSFMAKRyqD5xr77ZhmTUPg6TNvkEaRcAm+SBJKKY=;
        b=aAjNc2M8jJuICdMoAJqKaracbQRVZRTKsTNzMbBIx2+RI91gOSpfR9IdZ83D+hE1JDhYLE
        abMtbh9J+B2evXwGhVwOt/pUX6qL6ICs6xUKPy3JxRTCJQWXLUcB07qmEUmr5WD2JoMwZ0
        ZtcGflTQ5qOY4MS1zV37bZOeLzJLMXk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-427-lWOBV58fNFuYYjzuHz5DYQ-1; Wed, 31 Aug 2022 12:21:52 -0400
X-MC-Unique: lWOBV58fNFuYYjzuHz5DYQ-1
Received: by mail-qk1-f199.google.com with SMTP id ay10-20020a05620a178a00b006bbcab9d554so12154344qkb.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Q2PvSFMAKRyqD5xr77ZhmTUPg6TNvkEaRcAm+SBJKKY=;
        b=TD0seYTVHnYWSbUPULzRSOf5D4xH1WWfeWoKUUk5guNBxxH/hYXSXQ3qTYSQcOEi67
         B76TwjYMcRAX4AJ5KnDhL5oB8WL1DlnESp4JdZSqu4vpQHXjUU/HfZs1hPj+hx2bw/jM
         wqek6iLTq21urQ7nKBjhJkQFLkkt0YbbXkd0mnNq1YUUoNBoKubLhU8/e6oXLVq9Et63
         rkRSEDnfQFYS7Ip4VQZThIeJ3eCGzsH1T0evrhj5J6/aOetu5XMAXwzzIGNb27kQ5Yng
         qhPAnVZXJ7kZzDqYLz3xUxjpVgsWqa9m3YzTZsjDmT9bCC5I46Kz81zC3LOhepncX0Is
         QH6Q==
X-Gm-Message-State: ACgBeo2wWvgd/DE9SVHiRDYA5jOLwitrmXMwuh198eitJOvOjttRH2u6
        C4nCoEjmDdrodxM0/4tnx7D0sZt3nBkobzkC35wxnugp6vf0V90jzMfJtB8w4b9r7c4mbdIZ8ze
        XycdJWVvwXtSKrzqlHZL1lyE5
X-Received: by 2002:a05:620a:458c:b0:6bb:848a:b86b with SMTP id bp12-20020a05620a458c00b006bb848ab86bmr16344625qkb.267.1661962911646;
        Wed, 31 Aug 2022 09:21:51 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4zauEVAvhqWjWRcH8+X2pgMEDv1pLZPt12WstEl7PghzJqkOwM/i9MOxWB0Q6Kud8vRb/ZKA==
X-Received: by 2002:a05:620a:458c:b0:6bb:848a:b86b with SMTP id bp12-20020a05620a458c00b006bb848ab86bmr16344604qkb.267.1661962911350;
        Wed, 31 Aug 2022 09:21:51 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id bp8-20020a05620a458800b006b93ff541dasm10341458qkb.8.2022.08.31.09.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:21:50 -0700 (PDT)
Date:   Wed, 31 Aug 2022 12:21:49 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v1 2/3] mm/gup: use gup_can_follow_protnone() also in
 GUP-fast
Message-ID: <Yw+KnRTrZ74qFUAA@xz-m1.local>
References: <20220825164659.89824-1-david@redhat.com>
 <20220825164659.89824-3-david@redhat.com>
 <1892f6de-fd22-0e8b-3ff6-4c8641e1c68e@redhat.com>
 <2e20c90d-4d1f-dd83-aa63-9d8d17021263@redhat.com>
 <Yw5a1paQJ9MNdgmW@nvidia.com>
 <9ce3aaaa-71a6-5a81-16a3-36e6763feb91@redhat.com>
 <9a4fe603-950e-785b-6281-2e309256463f@nvidia.com>
 <68b38ac4-c680-b694-21a9-1971396d63b9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68b38ac4-c680-b694-21a9-1971396d63b9@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 09:23:44PM +0200, David Hildenbrand wrote:
> On 30.08.22 21:18, John Hubbard wrote:
> > On 8/30/22 11:53, David Hildenbrand wrote:
> >> Good, I managed to attract the attention of someone who understands that machinery :)
> >>
> >> While validating whether GUP-fast and PageAnonExclusive code work correctly,
> >> I started looking at the whole RCU GUP-fast machinery. I do have a patch to
> >> improve PageAnonExclusive clearing (I think we're missing memory barriers to
> >> make it work as expected in any possible case), but I also stumbled eventually
> >> over a more generic issue that might need memory barriers.
> >>
> >> Any thoughts whether I am missing something or this is actually missing
> >> memory barriers?
> >>
> > 
> > It's actually missing memory barriers.
> > 
> > In fact, others have had that same thought! [1] :) In that 2019 thread,
> > I recall that this got dismissed because of a focus on the IPI-based
> > aspect of gup fast synchronization (there was some hand waving, perhaps
> > accurate waving, about memory barriers vs. CPU interrupts). But now the
> > RCU (non-IPI) implementation is more widely used than it used to be, the
> > issue is clearer.
> > 
> >>
> >> From ce8c941c11d1f60cea87a3e4d941041dc6b79900 Mon Sep 17 00:00:00 2001
> >> From: David Hildenbrand <david@redhat.com>
> >> Date: Mon, 29 Aug 2022 16:57:07 +0200
> >> Subject: [PATCH] mm/gup: update refcount+pincount before testing if the PTE
> >>  changed
> >>
> >> mm/ksm.c:write_protect_page() has to make sure that no unknown
> >> references to a mapped page exist and that no additional ones with write
> >> permissions are possible -- unknown references could have write permissions
> >> and modify the page afterwards.
> >>
> >> Conceptually, mm/ksm.c:write_protect_page() consists of:
> >>   (1) Clear/invalidate PTE
> >>   (2) Check if there are unknown references; back off if so.
> >>   (3) Update PTE (e.g., map it R/O)
> >>
> >> Conceptually, GUP-fast code consists of:
> >>   (1) Read the PTE
> >>   (2) Increment refcount/pincount of the mapped page
> >>   (3) Check if the PTE changed by re-reading it; back off if so.
> >>
> >> To make sure GUP-fast won't be able to grab additional references after
> >> clearing the PTE, but will properly detect the change and back off, we
> >> need a memory barrier between updating the recount/pincount and checking
> >> if it changed.
> >>
> >> try_grab_folio() doesn't necessarily imply a memory barrier, so add an
> >> explicit smp_mb__after_atomic() after the atomic RMW operation to
> >> increment the refcount and pincount.
> >>
> >> ptep_clear_flush() used to clear the PTE and flush the TLB should imply
> >> a memory barrier for flushing the TLB, so don't add another one for now.
> >>
> >> PageAnonExclusive handling requires further care and will be handled
> >> separately.
> >>
> >> Fixes: 2667f50e8b81 ("mm: introduce a general RCU get_user_pages_fast()")
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  mm/gup.c | 17 +++++++++++++++++
> >>  1 file changed, 17 insertions(+)
> >>
> >> diff --git a/mm/gup.c b/mm/gup.c
> >> index 5abdaf487460..0008b808f484 100644
> >> --- a/mm/gup.c
> >> +++ b/mm/gup.c
> >> @@ -2392,6 +2392,14 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
> >>  			goto pte_unmap;
> >>  		}
> >>  
> >> +		/*
> >> +		 * Update refcount/pincount before testing for changed PTE. This
> >> +		 * is required for code like mm/ksm.c:write_protect_page() that
> >> +		 * wants to make sure that a page has no unknown references
> >> +		 * after clearing the PTE.
> >> +		 */
> >> +		smp_mb__after_atomic();
> >> +
> >>  		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> >>  			gup_put_folio(folio, 1, flags);
> >>  			goto pte_unmap;
> >> @@ -2577,6 +2585,9 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
> >>  	if (!folio)
> >>  		return 0;
> >>  
> >> +	/* See gup_pte_range(). */
> > 
> > Don't we usually also identify what each mb pairs with, in the comments? That would help.
> 
> Yeah, if only I could locate them reliably (as documented ptep_clear_flush() 
> should imply one I guess) ... but it will depend on the context.
> 
> 
> As I now have the attention of two people that understand that machinery,
> here goes the PageAnonExclusive thing I *think* should be correct.
> 
> The IPI-based mechanism really did make such synchronization with
> GUP-fast easier ...
> 
> 
> 
> From 8f91ef3555178149ad560b5424a9854b2ceee2d6 Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Sat, 27 Aug 2022 10:44:13 +0200
> Subject: [PATCH] mm: rework PageAnonExclusive() interaction with GUP-fast
> 
> commit 6c287605fd56 (mm: remember exclusively mapped anonymous pages with
> PG_anon_exclusive) made sure that when PageAnonExclusive() has to be
> cleared during temporary unmapping of a page, that the PTE is
> cleared/invalidated and that the TLB is flushed.
> 
> That handling was inspired by an outdated comment in
> mm/ksm.c:write_protect_page(), which similarly required the TLB flush in
> the past to synchronize with GUP-fast. However, ever since general RCU GUP
> fast was introduced in commit 2667f50e8b81 ("mm: introduce a general RCU
> get_user_pages_fast()"), a TLB flush is no longer sufficient and
> required to synchronize with concurrent GUP-fast
> 
> Peter pointed out, that TLB flush is not required, and looking into
> details it turns out that he's right. To synchronize with GUP-fast, it's
> sufficient to clear the PTE only: GUP-fast will either detect that the PTE
> changed or that PageAnonExclusive is not set and back off. However, we
> rely on a given memory order and should make sure that that order is
> always respected.
> 
> Conceptually, GUP-fast pinning code of anon pages consists of:
>   (1) Read the PTE
>   (2) Pin the mapped page
>   (3) Check if the PTE changed by re-reading it; back off if so.
>   (4) Check if PageAnonExclusive is not set; back off if so.
> 
> Conceptually, PageAnonExclusive clearing code consists of:
>   (1) Clear PTE
>   (2) Check if the page is pinned; back off if so.
>   (3) Clear PageAnonExclusive
>   (4) Restore PTE (optional)
> 
> As GUP-fast temporarily pins the page before validating whether the PTE
> changed, and PageAnonExclusive clearing code clears the PTE before
> checking if the page is pinned, GUP-fast cannot end up pinning an anon
> page that is not exclusive.
> 
> One corner case to consider is when we restore the PTE to the same value
> after PageAnonExclusive was cleared, as it can happen in
> mm/ksm.c:write_protect_page(). In that case, GUP-fast might not detect
> a PTE change (because there was none). However, as restoring the PTE
> happens after clearing PageAnonExclusive, GUP-fast would detect that
> PageAnonExclusive was cleared in that case and would properly back off.
> 
> Let's document that, avoid the TLB flush where possible and use proper
> explicit memory barriers where required. We shouldn't really care about the
> additional memory barriers here, as we're not on extremely hot paths.
> 
> The possible issues due to reordering are of theoretical nature so far,
> but it better be addressed.
> 
> Note that we don't need a memory barrier between checking if the page is
> pinned and clearing PageAnonExclusive, because stores are not
> speculated.
> 
> Fixes: 6c287605fd56 ("mm: remember exclusively mapped anonymous pages with PG_anon_exclusive")
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/mm.h   |  9 +++++--
>  include/linux/rmap.h | 58 ++++++++++++++++++++++++++++++++++++++++----
>  mm/huge_memory.c     |  3 +++
>  mm/ksm.c             |  1 +
>  mm/migrate_device.c  | 22 +++++++----------
>  mm/rmap.c            | 11 +++++----
>  6 files changed, 79 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 21f8b27bd9fd..f7e8f4b34fb5 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2975,8 +2975,8 @@ static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
>   * PageAnonExclusive() has to protect against concurrent GUP:
>   * * Ordinary GUP: Using the PT lock
>   * * GUP-fast and fork(): mm->write_protect_seq
> - * * GUP-fast and KSM or temporary unmapping (swap, migration):
> - *   clear/invalidate+flush of the page table entry
> + * * GUP-fast and KSM or temporary unmapping (swap, migration): see
> + *    page_try_share_anon_rmap()
>   *
>   * Must be called with the (sub)page that's actually referenced via the
>   * page table entry, which might not necessarily be the head page for a
> @@ -2997,6 +2997,11 @@ static inline bool gup_must_unshare(unsigned int flags, struct page *page)
>  	 */
>  	if (!PageAnon(page))
>  		return false;
> +
> +	/* See page_try_share_anon_rmap() for GUP-fast details. */
> +	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) && irqs_disabled())
> +		smp_rmb();
> +
>  	/*
>  	 * Note that PageKsm() pages cannot be exclusive, and consequently,
>  	 * cannot get pinned.
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index bf80adca980b..454c159f2aae 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -267,7 +267,7 @@ static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
>   * @page: the exclusive anonymous page to try marking possibly shared
>   *
>   * The caller needs to hold the PT lock and has to have the page table entry
> - * cleared/invalidated+flushed, to properly sync against GUP-fast.
> + * cleared/invalidated.
>   *
>   * This is similar to page_try_dup_anon_rmap(), however, not used during fork()
>   * to duplicate a mapping, but instead to prepare for KSM or temporarily
> @@ -283,12 +283,60 @@ static inline int page_try_share_anon_rmap(struct page *page)
>  {
>  	VM_BUG_ON_PAGE(!PageAnon(page) || !PageAnonExclusive(page), page);
>  
> -	/* See page_try_dup_anon_rmap(). */
> -	if (likely(!is_device_private_page(page) &&
> -	    unlikely(page_maybe_dma_pinned(page))))
> -		return -EBUSY;
> +	/* device private pages cannot get pinned via GUP. */
> +	if (unlikely(is_device_private_page(page))) {
> +		ClearPageAnonExclusive(page);
> +		return 0;
> +	}
>  
> +	/*
> +	 * We have to make sure that while we clear PageAnonExclusive, that
> +	 * the page is not pinned and that concurrent GUP-fast won't succeed in
> +	 * concurrently pinning the page.
> +	 *
> +	 * Conceptually, GUP-fast pinning code of anon pages consists of:
> +	 * (1) Read the PTE
> +	 * (2) Pin the mapped page
> +	 * (3) Check if the PTE changed by re-reading it; back off if so.
> +	 * (4) Check if PageAnonExclusive is not set; back off if so.
> +	 *
> +	 * Conceptually, PageAnonExclusive clearing code consists of:
> +	 * (1) Clear PTE
> +	 * (2) Check if the page is pinned; back off if so.
> +	 * (3) Clear PageAnonExclusive
> +	 * (4) Restore PTE (optional)
> +	 *
> +	 * In GUP-fast, we have to make sure that (2),(3) and (4) happen in
> +	 * the right order. Memory order between (2) and (3) is handled by
> +	 * GUP-fast, independent of PageAnonExclusive.
> +	 *
> +	 * When clearing PageAnonExclusive(), we have to make sure that (1),
> +	 * (2), (3) and (4) happen in the right order.
> +	 *
> +	 * Note that (4) has to happen after (3) in both cases to handle the
> +	 * corner case whereby the PTE is restored to the original value after
> +	 * clearing PageAnonExclusive and while GUP-fast might not detect the
> +	 * PTE change, it will detect the PageAnonExclusive change.
> +	 *
> +	 * We assume that there might not be a memory barrier after
> +	 * clearing/invalidating the PTE (1) and before restoring the PTE (4),
> +	 * so we use explicit ones here.
> +	 *
> +	 * These memory barriers are paired with memory barriers in GUP-fast
> +	 * code, including gup_must_unshare().
> +	 */
> +
> +	/* Clear/invalidate the PTE before checking for PINs. */
> +	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
> +		smp_mb();

Wondering whether this could be smp_mb__before_atomic().

> +
> +	if (unlikely(page_maybe_dma_pinned(page)))
> +		return -EBUSY;
>  	ClearPageAnonExclusive(page);
> +
> +	/* Clear PageAnonExclusive() before eventually restoring the PTE. */
> +	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
> +		smp_mb__after_atomic();
>  	return 0;
>  }
>  
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index e9414ee57c5b..2aef8d76fcf2 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2140,6 +2140,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  		 *
>  		 * In case we cannot clear PageAnonExclusive(), split the PMD
>  		 * only and let try_to_migrate_one() fail later.
> +		 *
> +		 * See page_try_share_anon_rmap(): invalidate PMD first.
>  		 */
>  		anon_exclusive = PageAnon(page) && PageAnonExclusive(page);
>  		if (freeze && anon_exclusive && page_try_share_anon_rmap(page))
> @@ -3177,6 +3179,7 @@ int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
>  	flush_cache_range(vma, address, address + HPAGE_PMD_SIZE);
>  	pmdval = pmdp_invalidate(vma, address, pvmw->pmd);
>  
> +	/* See page_try_share_anon_rmap(): invalidate PMD first. */
>  	anon_exclusive = PageAnon(page) && PageAnonExclusive(page);
>  	if (anon_exclusive && page_try_share_anon_rmap(page)) {
>  		set_pmd_at(mm, address, pvmw->pmd, pmdval);
> diff --git a/mm/ksm.c b/mm/ksm.c
> index d7526c705081..971cf923c0eb 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -1091,6 +1091,7 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
>  			goto out_unlock;
>  		}
>  
> +		/* See page_try_share_anon_rmap(): clear PTE first. */
>  		if (anon_exclusive && page_try_share_anon_rmap(page)) {
>  			set_pte_at(mm, pvmw.address, pvmw.pte, entry);
>  			goto out_unlock;
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index 27fb37d65476..47e955212f15 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -193,20 +193,16 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  			bool anon_exclusive;
>  			pte_t swp_pte;
>  

flush_cache_page() missing here?

Better copy Alistair too when post formally since this will have a slight
conflict with the other thread.

> +			ptep_get_and_clear(mm, addr, ptep);
> +
> +			/* See page_try_share_anon_rmap(): clear PTE first. */
>  			anon_exclusive = PageAnon(page) && PageAnonExclusive(page);
> -			if (anon_exclusive) {
> -				flush_cache_page(vma, addr, pte_pfn(*ptep));
> -				ptep_clear_flush(vma, addr, ptep);
> -
> -				if (page_try_share_anon_rmap(page)) {
> -					set_pte_at(mm, addr, ptep, pte);
> -					unlock_page(page);
> -					put_page(page);
> -					mpfn = 0;
> -					goto next;
> -				}
> -			} else {
> -				ptep_get_and_clear(mm, addr, ptep);
> +			if (anon_exclusive && page_try_share_anon_rmap(page)) {
> +				set_pte_at(mm, addr, ptep, pte);
> +				unlock_page(page);
> +				put_page(page);
> +				mpfn = 0;
> +				goto next;
>  			}
>  
>  			migrate->cpages++;

Thanks,

-- 
Peter Xu

