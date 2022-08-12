Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18118590A50
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 04:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236855AbiHLCds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 22:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbiHLCdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 22:33:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A30A260B
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 19:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660271626; x=1691807626;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=xkeAbGPwDxWwfKUruJSOQz3E6SaQJBOfBYpGSAmqQKI=;
  b=nyhhYWV9V+XZSgif1+zGWqa2joaYMcNyRz1oZ6QSoyyCuojwZoWIw0DC
   WpOv14dPwsNni4fjBWQPjNTEkhv6HWarBL0pX8i63T8l8iATeH2TVVnpx
   ytmb4McMJtRaQ34VeRko3qMl3X7BjEpXoXXyUjUzjBFIcquyl/OExh8ur
   MRoZ8IO/S1g5WaI9CLc6GTtjHEcfdFov7VrYUInpLBV3vJT4QXcilgZDP
   9PkFts0EsclICrOWPhOFsKY2XgIhJXvYTPb/XRbLQc3alCAV7tKaVZxlX
   93I8IcQXcDESkWEdVZF1sQJi/ODsnES2VEjFDciuOA9D2KJmDw6u2PwU7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="271280194"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="271280194"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 19:33:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="695114494"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 19:33:43 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 3/7] mm/swap: Add swp_offset_pfn() to fetch PFN from
 swap entry
References: <20220811161331.37055-1-peterx@redhat.com>
        <20220811161331.37055-4-peterx@redhat.com>
Date:   Fri, 12 Aug 2022 10:33:40 +0800
In-Reply-To: <20220811161331.37055-4-peterx@redhat.com> (Peter Xu's message of
        "Thu, 11 Aug 2022 12:13:27 -0400")
Message-ID: <87lerudwcb.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> We've got a bunch of special swap entries that stores PFN inside the swap
> offset fields.  To fetch the PFN, normally the user just calls swp_offset()
> assuming that'll be the PFN.
>
> Add a helper swp_offset_pfn() to fetch the PFN instead, fetching only the
> max possible length of a PFN on the host, meanwhile doing proper check with
> MAX_PHYSMEM_BITS to make sure the swap offsets can actually store the PFNs
> properly always using the BUILD_BUG_ON() in is_pfn_swap_entry().
>
> One reason to do so is we never tried to sanitize whether swap offset can
> really fit for storing PFN.  At the meantime, this patch also prepares us
> with the future possibility to store more information inside the swp offset
> field, so assuming "swp_offset(entry)" to be the PFN will not stand any
> more very soon.
>
> Replace many of the swp_offset() callers to use swp_offset_pfn() where
> proper.  Note that many of the existing users are not candidates for the
> replacement, e.g.:
>
>   (1) When the swap entry is not a pfn swap entry at all, or,
>   (2) when we wanna keep the whole swp_offset but only change the swp type.
>
> For the latter, it can happen when fork() triggered on a write-migration
> swap entry pte, we may want to only change the migration type from
> write->read but keep the rest, so it's not "fetching PFN" but "changing
> swap type only".  They're left aside so that when there're more information
> within the swp offset they'll be carried over naturally in those cases.
>
> Since at it, dropping hwpoison_entry_to_pfn() because that's exactly what
> the new swp_offset_pfn() is about.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

LGTM, Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  arch/arm64/mm/hugetlbpage.c |  2 +-
>  fs/proc/task_mmu.c          | 20 +++++++++++++++++---
>  include/linux/swapops.h     | 35 +++++++++++++++++++++++++++++------
>  mm/hmm.c                    |  2 +-
>  mm/memory-failure.c         |  2 +-
>  mm/page_vma_mapped.c        |  6 +++---
>  6 files changed, 52 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 0795028f017c..35e9a468d13e 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -245,7 +245,7 @@ static inline struct folio *hugetlb_swap_entry_to_folio(swp_entry_t entry)
>  {
>  	VM_BUG_ON(!is_migration_entry(entry) && !is_hwpoison_entry(entry));
>  
> -	return page_folio(pfn_to_page(swp_offset(entry)));
> +	return page_folio(pfn_to_page(swp_offset_pfn(entry)));
>  }
>  
>  void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index d56c65f98d00..b3e79128fca0 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1419,9 +1419,19 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
>  		if (pte_swp_uffd_wp(pte))
>  			flags |= PM_UFFD_WP;
>  		entry = pte_to_swp_entry(pte);
> -		if (pm->show_pfn)
> +		if (pm->show_pfn) {
> +			pgoff_t offset;
> +			/*
> +			 * For PFN swap offsets, keeping the offset field
> +			 * to be PFN only to be compatible with old smaps.
> +			 */
> +			if (is_pfn_swap_entry(entry))
> +				offset = swp_offset_pfn(entry);
> +			else
> +				offset = swp_offset(entry);
>  			frame = swp_type(entry) |
> -				(swp_offset(entry) << MAX_SWAPFILES_SHIFT);
> +			    (offset << MAX_SWAPFILES_SHIFT);
> +		}
>  		flags |= PM_SWAP;
>  		migration = is_migration_entry(entry);
>  		if (is_pfn_swap_entry(entry))
> @@ -1478,7 +1488,11 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  			unsigned long offset;
>  
>  			if (pm->show_pfn) {
> -				offset = swp_offset(entry) +
> +				if (is_pfn_swap_entry(entry))
> +					offset = swp_offset_pfn(entry);
> +				else
> +					offset = swp_offset(entry);
> +				offset = offset +
>  					((addr & ~PMD_MASK) >> PAGE_SHIFT);
>  				frame = swp_type(entry) |
>  					(offset << MAX_SWAPFILES_SHIFT);
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index 3a2901ff4f1e..bd4c6f0c2103 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -23,6 +23,20 @@
>  #define SWP_TYPE_SHIFT	(BITS_PER_XA_VALUE - MAX_SWAPFILES_SHIFT)
>  #define SWP_OFFSET_MASK	((1UL << SWP_TYPE_SHIFT) - 1)
>  
> +/*
> + * Definitions only for PFN swap entries (see is_pfn_swap_entry()).  To
> + * store PFN, we only need SWP_PFN_BITS bits.  Each of the pfn swap entries
> + * can use the extra bits to store other information besides PFN.
> + */
> +#ifdef MAX_PHYSMEM_BITS
> +#define SWP_PFN_BITS			(MAX_PHYSMEM_BITS - PAGE_SHIFT)
> +#else  /* MAX_PHYSMEM_BITS */
> +#define SWP_PFN_BITS			(BITS_PER_LONG - PAGE_SHIFT)
> +#endif	/* MAX_PHYSMEM_BITS */
> +#define SWP_PFN_MASK			(BIT(SWP_PFN_BITS) - 1)
> +
> +static inline bool is_pfn_swap_entry(swp_entry_t entry);
> +
>  /* Clear all flags but only keep swp_entry_t related information */
>  static inline pte_t pte_swp_clear_flags(pte_t pte)
>  {
> @@ -64,6 +78,17 @@ static inline pgoff_t swp_offset(swp_entry_t entry)
>  	return entry.val & SWP_OFFSET_MASK;
>  }
>  
> +/*
> + * This should only be called upon a pfn swap entry to get the PFN stored
> + * in the swap entry.  Please refers to is_pfn_swap_entry() for definition
> + * of pfn swap entry.
> + */
> +static inline unsigned long swp_offset_pfn(swp_entry_t entry)
> +{
> +	VM_BUG_ON(!is_pfn_swap_entry(entry));
> +	return swp_offset(entry) & SWP_PFN_MASK;
> +}
> +
>  /* check whether a pte points to a swap entry */
>  static inline int is_swap_pte(pte_t pte)
>  {
> @@ -369,7 +394,7 @@ static inline int pte_none_mostly(pte_t pte)
>  
>  static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
>  {
> -	struct page *p = pfn_to_page(swp_offset(entry));
> +	struct page *p = pfn_to_page(swp_offset_pfn(entry));
>  
>  	/*
>  	 * Any use of migration entries may only occur while the
> @@ -387,6 +412,9 @@ static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
>   */
>  static inline bool is_pfn_swap_entry(swp_entry_t entry)
>  {
> +	/* Make sure the swp offset can always store the needed fields */
> +	BUILD_BUG_ON(SWP_TYPE_SHIFT < SWP_PFN_BITS);
> +
>  	return is_migration_entry(entry) || is_device_private_entry(entry) ||
>  	       is_device_exclusive_entry(entry);
>  }
> @@ -475,11 +503,6 @@ static inline int is_hwpoison_entry(swp_entry_t entry)
>  	return swp_type(entry) == SWP_HWPOISON;
>  }
>  
> -static inline unsigned long hwpoison_entry_to_pfn(swp_entry_t entry)
> -{
> -	return swp_offset(entry);
> -}
> -
>  static inline void num_poisoned_pages_inc(void)
>  {
>  	atomic_long_inc(&num_poisoned_pages);
> diff --git a/mm/hmm.c b/mm/hmm.c
> index f2aa63b94d9b..3850fb625dda 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -253,7 +253,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
>  			cpu_flags = HMM_PFN_VALID;
>  			if (is_writable_device_private_entry(entry))
>  				cpu_flags |= HMM_PFN_WRITE;
> -			*hmm_pfn = swp_offset(entry) | cpu_flags;
> +			*hmm_pfn = swp_offset_pfn(entry) | cpu_flags;
>  			return 0;
>  		}
>  
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 0dfed9d7b273..e48f6f6a259d 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -632,7 +632,7 @@ static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
>  		swp_entry_t swp = pte_to_swp_entry(pte);
>  
>  		if (is_hwpoison_entry(swp))
> -			pfn = hwpoison_entry_to_pfn(swp);
> +			pfn = swp_offset_pfn(swp);
>  	}
>  
>  	if (!pfn || pfn != poisoned_pfn)
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index 8e9e574d535a..93e13fc17d3c 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -86,7 +86,7 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw)
>  		    !is_device_exclusive_entry(entry))
>  			return false;
>  
> -		pfn = swp_offset(entry);
> +		pfn = swp_offset_pfn(entry);
>  	} else if (is_swap_pte(*pvmw->pte)) {
>  		swp_entry_t entry;
>  
> @@ -96,7 +96,7 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw)
>  		    !is_device_exclusive_entry(entry))
>  			return false;
>  
> -		pfn = swp_offset(entry);
> +		pfn = swp_offset_pfn(entry);
>  	} else {
>  		if (!pte_present(*pvmw->pte))
>  			return false;
> @@ -221,7 +221,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  					return not_found(pvmw);
>  				entry = pmd_to_swp_entry(pmde);
>  				if (!is_migration_entry(entry) ||
> -				    !check_pmd(swp_offset(entry), pvmw))
> +				    !check_pmd(swp_offset_pfn(entry), pvmw))
>  					return not_found(pvmw);
>  				return true;
>  			}
