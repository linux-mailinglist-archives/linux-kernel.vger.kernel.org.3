Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7BB58D581
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240898AbiHIIkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiHIIk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:40:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440D4B487
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 01:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660034427; x=1691570427;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=hm70T0fTQioNjk7mQ73livnLgJjiVA7EKal1rRxAi3E=;
  b=iNxIOPG3fGVC1ZLSm0y5wYG20sXOMxjlKGVbFR3qZRkgp/zcEXPJrKg8
   HHbnOwEQV+5/9GNr/LLxJu582DVCALYCb+0WvO8p70qOU0H0NdFC1AGxA
   z1qtIvqBJYiC9IrIc6ZQqIVUlUCpeyCXHMDEHxgQXAbH370Iv0lNDkj9x
   H3dTAHxZ3XCXXVqaD7dhBHAtVMNLjNuqYuMmbMm6PHcV6uRh0joKRr2R1
   sFBg1O1GH/7Ma71N7WxOvS4FXByMqDNXkNkw9BvnllYksBJLzzaCOJjMQ
   2SLe8wO95BTjNBNI8tdHW1rEfDBfPUMfDRv+x4G+WZts+lq2n3CszUwZt
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="277721324"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="277721324"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 01:40:26 -0700
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="932401520"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 01:40:23 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v2 2/2] mm: Remember young/dirty bit for page migrations
References: <20220804203952.53665-1-peterx@redhat.com>
        <20220804203952.53665-3-peterx@redhat.com>
Date:   Tue, 09 Aug 2022 16:40:12 +0800
In-Reply-To: <20220804203952.53665-3-peterx@redhat.com> (Peter Xu's message of
        "Thu, 4 Aug 2022 16:39:52 -0400")
Message-ID: <877d3hhksz.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> When page migration happens, we always ignore the young/dirty bit settings
> in the old pgtable, and marking the page as old in the new page table using
> either pte_mkold() or pmd_mkold(), and keeping the pte clean.
>
> That's fine from functional-wise, but that's not friendly to page reclaim
> because the moving page can be actively accessed within the procedure.  Not
> to mention hardware setting the young bit can bring quite some overhead on
> some systems, e.g. x86_64 needs a few hundreds nanoseconds to set the bit.
> The same slowdown problem to dirty bits when the memory is first written
> after page migration happened.
>
> Actually we can easily remember the A/D bit configuration and recover the
> information after the page is migrated.  To achieve it, define a new set of
> bits in the migration swap offset field to cache the A/D bits for old pte.
> Then when removing/recovering the migration entry, we can recover the A/D
> bits even if the page changed.
>
> One thing to mention is that here we used max_swapfile_size() to detect how
> many swp offset bits we have, and we'll only enable this feature if we know
> the swp offset can be big enough to store both the PFN value and the young
> bit.  Otherwise the A/D bits are dropped like before.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/swapops.h | 91 +++++++++++++++++++++++++++++++++++++++++
>  mm/huge_memory.c        | 26 +++++++++++-
>  mm/migrate.c            |  6 ++-
>  mm/migrate_device.c     |  4 ++
>  mm/rmap.c               |  5 ++-
>  5 files changed, 128 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index 1d17e4bb3d2f..34aa448ac6ee 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -8,6 +8,8 @@
>  
>  #ifdef CONFIG_MMU
>  
> +#include <linux/swapfile.h>
> +
>  /*
>   * swapcache pages are stored in the swapper_space radix tree.  We want to
>   * get good packing density in that tree, so the index should be dense in
> @@ -35,6 +37,24 @@
>  #endif
>  #define SWP_PFN_MASK			((1UL << SWP_PFN_BITS) - 1)
>  
> +/**
> + * Migration swap entry specific bitfield definitions.
> + *
> + * @SWP_MIG_YOUNG_BIT: Whether the page used to have young bit set
> + * @SWP_MIG_DIRTY_BIT: Whether the page used to have dirty bit set
> + *
> + * Note: these bits will be stored in migration entries iff there're enough
> + * free bits in arch specific swp offset.  By default we'll ignore A/D bits
> + * when migrating a page.  Please refer to migration_entry_supports_ad()
> + * for more information.
> + */
> +#define SWP_MIG_YOUNG_BIT		(SWP_PFN_BITS)
> +#define SWP_MIG_DIRTY_BIT		(SWP_PFN_BITS + 1)
> +#define SWP_MIG_TOTAL_BITS		(SWP_PFN_BITS + 2)
> +
> +#define SWP_MIG_YOUNG			(1UL << SWP_MIG_YOUNG_BIT)
> +#define SWP_MIG_DIRTY			(1UL << SWP_MIG_DIRTY_BIT)
> +
>  static inline bool is_pfn_swap_entry(swp_entry_t entry);
>  
>  /* Clear all flags but only keep swp_entry_t related information */
> @@ -265,6 +285,57 @@ static inline swp_entry_t make_writable_migration_entry(pgoff_t offset)
>  	return swp_entry(SWP_MIGRATION_WRITE, offset);
>  }
>  
> +/*
> + * Returns whether the host has large enough swap offset field to support
> + * carrying over pgtable A/D bits for page migrations.  The result is
> + * pretty much arch specific.
> + */
> +static inline bool migration_entry_supports_ad(void)
> +{
> +	/*
> +	 * max_swapfile_size() returns the max supported swp-offset plus 1.
> +	 * We can support the migration A/D bits iff the pfn swap entry has
> +	 * the offset large enough to cover all of them (PFN, A & D bits).
> +	 */
> +#ifdef CONFIG_SWAP
> +	return max_swapfile_size() >= (1UL << SWP_MIG_TOTAL_BITS);
> +#else
> +	return false;
> +#endif
> +}
> +
> +static inline swp_entry_t make_migration_entry_young(swp_entry_t entry)
> +{
> +	if (migration_entry_supports_ad())
> +		return swp_entry(swp_type(entry),
> +				 swp_offset(entry) | SWP_MIG_YOUNG);
> +	return entry;
> +}
> +
> +static inline bool is_migration_entry_young(swp_entry_t entry)
> +{
> +	if (migration_entry_supports_ad())
> +		return swp_offset(entry) & SWP_MIG_YOUNG;
> +	/* Keep the old behavior of aging page after migration */
> +	return false;
> +}
> +
> +static inline swp_entry_t make_migration_entry_dirty(swp_entry_t entry)
> +{
> +	if (migration_entry_supports_ad())
> +		return swp_entry(swp_type(entry),
> +				 swp_offset(entry) | SWP_MIG_DIRTY);
> +	return entry;
> +}
> +
> +static inline bool is_migration_entry_dirty(swp_entry_t entry)
> +{
> +	if (migration_entry_supports_ad())
> +		return swp_offset(entry) & SWP_MIG_YOUNG_BIT;
> +	/* Keep the old behavior of clean page after migration */
> +	return false;
> +}
> +
>  extern void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
>  					spinlock_t *ptl);
>  extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
> @@ -311,6 +382,26 @@ static inline int is_readable_migration_entry(swp_entry_t entry)
>  	return 0;
>  }
>  
> +static inline swp_entry_t make_migration_entry_young(swp_entry_t entry)
> +{
> +	return entry;
> +}
> +
> +static inline bool is_migration_entry_young(swp_entry_t entry)
> +{
> +	return false;
> +}
> +
> +static inline swp_entry_t make_migration_entry_dirty(swp_entry_t entry)
> +{
> +	return entry;
> +}
> +
> +static inline bool is_migration_entry_dirty(swp_entry_t entry)
> +{
> +	return false;
> +}
> +
>  #endif
>  
>  typedef unsigned long pte_marker;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 29e3628687a6..7d79db4bd76a 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2005,6 +2005,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  	pmd_t old_pmd, _pmd;
>  	bool young, write, soft_dirty, pmd_migration = false, uffd_wp = false;
>  	bool anon_exclusive = false;
> +	bool dirty = false;
>  	unsigned long addr;
>  	int i;
>  
> @@ -2088,7 +2089,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  		write = is_writable_migration_entry(entry);
>  		if (PageAnon(page))
>  			anon_exclusive = is_readable_exclusive_migration_entry(entry);
> -		young = false;
> +		young = is_migration_entry_young(entry);
> +		dirty = is_migration_entry_dirty(entry);
>  		soft_dirty = pmd_swp_soft_dirty(old_pmd);
>  		uffd_wp = pmd_swp_uffd_wp(old_pmd);
>  	} else {
> @@ -2097,6 +2099,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  			SetPageDirty(page);
>  		write = pmd_write(old_pmd);
>  		young = pmd_young(old_pmd);
> +		dirty = pmd_dirty(old_pmd);
>  		soft_dirty = pmd_soft_dirty(old_pmd);
>  		uffd_wp = pmd_uffd_wp(old_pmd);
>  
> @@ -2146,6 +2149,10 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  			else
>  				swp_entry = make_readable_migration_entry(
>  							page_to_pfn(page + i));
> +			if (young)
> +				swp_entry = make_migration_entry_young(swp_entry);
> +			if (dirty)
> +				swp_entry = make_migration_entry_dirty(swp_entry);
>  			entry = swp_entry_to_pte(swp_entry);
>  			if (soft_dirty)
>  				entry = pte_swp_mksoft_dirty(entry);
> @@ -2160,6 +2167,12 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  				entry = pte_wrprotect(entry);
>  			if (!young)
>  				entry = pte_mkold(entry);
> +			if (dirty)
> +				/*
> +				 * NOTE: this may contains setting soft
> +				 * dirty too on some archs like x86.
> +				 */

Personally, I prefer to put comments above "if (dirty)".  But you can
choose your favorite way unless it violates coding style.

> +				entry = pte_mkdirty(entry);

We don't track dirty flag even for normal PTE before.  So I think we
should separate the dirty flag tracking for normal PTE in a separate
patch.

>  			if (soft_dirty)
>  				entry = pte_mksoft_dirty(entry);
>  			if (uffd_wp)
> @@ -3148,6 +3161,10 @@ int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
>  		entry = make_readable_exclusive_migration_entry(page_to_pfn(page));
>  	else
>  		entry = make_readable_migration_entry(page_to_pfn(page));
> +	if (pmd_young(pmdval))
> +		entry = make_migration_entry_young(entry);
> +	if (pmd_dirty(pmdval))
> +		entry = make_migration_entry_dirty(entry);
>  	pmdswp = swp_entry_to_pmd(entry);
>  	if (pmd_soft_dirty(pmdval))
>  		pmdswp = pmd_swp_mksoft_dirty(pmdswp);
> @@ -3173,13 +3190,18 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
>  
>  	entry = pmd_to_swp_entry(*pvmw->pmd);
>  	get_page(new);
> -	pmde = pmd_mkold(mk_huge_pmd(new, READ_ONCE(vma->vm_page_prot)));
> +	pmde = mk_huge_pmd(new, READ_ONCE(vma->vm_page_prot));
>  	if (pmd_swp_soft_dirty(*pvmw->pmd))
>  		pmde = pmd_mksoft_dirty(pmde);
>  	if (is_writable_migration_entry(entry))
>  		pmde = maybe_pmd_mkwrite(pmde, vma);
>  	if (pmd_swp_uffd_wp(*pvmw->pmd))
>  		pmde = pmd_wrprotect(pmd_mkuffd_wp(pmde));
> +	if (!is_migration_entry_young(entry))
> +		pmde = pmd_mkold(pmde);
> +	if (PageDirty(new) && is_migration_entry_dirty(entry))
> +		/* NOTE: this may contain setting soft-dirty on some archs */
> +		pmde = pmd_mkdirty(pmde);
>  
>  	if (PageAnon(new)) {
>  		rmap_t rmap_flags = RMAP_COMPOUND;
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 1649270bc1a7..957e8e6ee28e 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -199,7 +199,7 @@ static bool remove_migration_pte(struct folio *folio,
>  #endif
>  
>  		folio_get(folio);
> -		pte = pte_mkold(mk_pte(new, READ_ONCE(vma->vm_page_prot)));
> +		pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
>  		if (pte_swp_soft_dirty(*pvmw.pte))
>  			pte = pte_mksoft_dirty(pte);
>  
> @@ -207,6 +207,10 @@ static bool remove_migration_pte(struct folio *folio,
>  		 * Recheck VMA as permissions can change since migration started
>  		 */
>  		entry = pte_to_swp_entry(*pvmw.pte);
> +		if (!is_migration_entry_young(entry))
> +			pte = pte_mkold(pte);
> +		if (folio_test_dirty(folio) && is_migration_entry_dirty(entry))
> +			pte = pte_mkdirty(pte);
>  		if (is_writable_migration_entry(entry))
>  			pte = maybe_mkwrite(pte, vma);
>  		else if (pte_swp_uffd_wp(*pvmw.pte))
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index 7feeb447e3b9..47d90df04cc6 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -221,6 +221,10 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  			else
>  				entry = make_readable_migration_entry(
>  							page_to_pfn(page));
> +			if (pte_young(pte))
> +				entry = make_migration_entry_young(entry);
> +			if (pte_dirty(pte))
> +				entry = make_migration_entry_dirty(entry);

I don't find pte_dirty() is synced to PageDirty() as in
try_to_migrate_one().  Is it a issue in the original code?

Best Regards,
Huang, Ying

>  			swp_pte = swp_entry_to_pte(entry);
>  			if (pte_present(pte)) {
>  				if (pte_soft_dirty(pte))
> diff --git a/mm/rmap.c b/mm/rmap.c
> index af775855e58f..28aef434ea41 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2065,7 +2065,10 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  			else
>  				entry = make_readable_migration_entry(
>  							page_to_pfn(subpage));
> -
> +			if (pte_young(pteval))
> +				entry = make_migration_entry_young(entry);
> +			if (pte_dirty(pteval))
> +				entry = make_migration_entry_dirty(entry);
>  			swp_pte = swp_entry_to_pte(entry);
>  			if (pte_soft_dirty(pteval))
>  				swp_pte = pte_swp_mksoft_dirty(swp_pte);
