Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166E358AA53
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240483AbiHELtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiHELtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:49:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9843AE5C;
        Fri,  5 Aug 2022 04:49:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1106621026;
        Fri,  5 Aug 2022 11:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659700182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e+ZZRfdbIhon3NSo2YhnpBE7OBe+zKAt+72NvTnDVPI=;
        b=rmgM5steZTXv1QKaawxFkly2VI9n75TFyN1GKBF+Ugth+qVOtUFwoRKbt0txUXEhlZgSJm
        SXzt+NM66srKTdvOqW6uYY3WoY8W2TlmztNrCV/7Sv3yqOn3gkP4L0MzjM8YogVdOj2HtI
        BLVqa3HW+aG0GzbGBDsQu6qE5YeaQGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659700182;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e+ZZRfdbIhon3NSo2YhnpBE7OBe+zKAt+72NvTnDVPI=;
        b=oFXKtGKO/u22K3LRuD87SZMNXYn8FALUr/JUO8h8wM4AYxRkssiXPSZMzQKtW5Dgr6IoZD
        s8W1ykRhy3T1QrCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 96435133B5;
        Fri,  5 Aug 2022 11:49:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TcrzI9UD7WJlCgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 05 Aug 2022 11:49:41 +0000
Message-ID: <8cf143e7-2b62-1a1e-de84-e3dcc6c027a4@suse.cz>
Date:   Fri, 5 Aug 2022 13:49:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-3-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220614120231.48165-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/22 14:02, Kirill A. Shutemov wrote:
> UEFI Specification version 2.9 introduces the concept of memory
> acceptance. Some Virtual Machine platforms, such as Intel TDX or AMD
> SEV-SNP, require memory to be accepted before it can be used by the
> guest. Accepting happens via a protocol specific to the Virtual Machine
> platform.
> 
> There are several ways kernel can deal with unaccepted memory:
> 
>  1. Accept all the memory during the boot. It is easy to implement and
>     it doesn't have runtime cost once the system is booted. The downside
>     is very long boot time.
> 
>     Accept can be parallelized to multiple CPUs to keep it manageable
>     (i.e. via DEFERRED_STRUCT_PAGE_INIT), but it tends to saturate
>     memory bandwidth and does not scale beyond the point.
> 
>  2. Accept a block of memory on the first use. It requires more
>     infrastructure and changes in page allocator to make it work, but
>     it provides good boot time.
> 
>     On-demand memory accept means latency spikes every time kernel steps
>     onto a new memory block. The spikes will go away once workload data
>     set size gets stabilized or all memory gets accepted.
> 
>  3. Accept all memory in background. Introduce a thread (or multiple)
>     that gets memory accepted proactively. It will minimize time the
>     system experience latency spikes on memory allocation while keeping
>     low boot time.
> 
>     This approach cannot function on its own. It is an extension of #2:
>     background memory acceptance requires functional scheduler, but the
>     page allocator may need to tap into unaccepted memory before that.
> 
>     The downside of the approach is that these threads also steal CPU
>     cycles and memory bandwidth from the user's workload and may hurt
>     user experience.
> 
> Implement #2 for now. It is a reasonable default. Some workloads may
> want to use #1 or #3 and they can be implemented later based on user's
> demands.
> 
> Support of unaccepted memory requires a few changes in core-mm code:
> 
>   - memblock has to accept memory on allocation;
> 
>   - page allocator has to accept memory on the first allocation of the
>     page;
> 
> Memblock change is trivial.
> 
> The page allocator is modified to accept pages on the first allocation.
> The new page type (encoded in the _mapcount) -- PageUnaccepted() -- is
> used to indicate that the page requires acceptance.
> 
> Architecture has to provide two helpers if it wants to support
> unaccepted memory:
> 
>  - accept_memory() makes a range of physical addresses accepted.
> 
>  - range_contains_unaccepted_memory() checks anything within the range
>    of physical addresses requires acceptance.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>	# memblock
> Reviewed-by: David Hildenbrand <david@redhat.com>

Hmm I realize it's not ideal to raise this at v7, and maybe it was discussed
before, but it's really not great how this affects the core page allocator
paths. Wouldn't it be possible to only release pages to page allocator when
accepted, and otherwise use some new per-zone variables together with the
bitmap to track how much exactly is where to accept? Then it could be hooked
in get_page_from_freelist() similarly to CONFIG_DEFERRED_STRUCT_PAGE_INIT -
if we fail zone_watermark_fast() and there are unaccepted pages in the zone,
accept them and continue. With a static key to flip in case we eventually
accept everything. Because this is really similar scenario to the deferred
init and that one was solved in a way that adds minimal overhead.

> ---
>  include/linux/page-flags.h | 31 +++++++++++++
>  mm/internal.h              | 12 +++++
>  mm/memblock.c              |  9 ++++
>  mm/page_alloc.c            | 89 +++++++++++++++++++++++++++++++++++++-
>  4 files changed, 139 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index e66f7aa3191d..444ba8f4bfa0 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -942,6 +942,14 @@ static inline bool is_page_hwpoison(struct page *page)
>  #define PG_offline	0x00000100
>  #define PG_table	0x00000200
>  #define PG_guard	0x00000400
> +#define PG_unaccepted	0x00000800
> +
> +/*
> + * Page types allowed at page_expected_state()
> + *
> + * PageUnaccepted() will get cleared in post_alloc_hook().
> + */
> +#define PAGE_TYPES_EXPECTED	PG_unaccepted
>  
>  #define PageType(page, flag)						\
>  	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
> @@ -967,6 +975,18 @@ static __always_inline void __ClearPage##uname(struct page *page)	\
>  	page->page_type |= PG_##lname;					\
>  }
>  
> +#define PAGE_TYPE_OPS_FALSE(uname)					\
> +static __always_inline int Page##uname(struct page *page)		\
> +{									\
> +	return false;							\
> +}									\
> +static __always_inline void __SetPage##uname(struct page *page)		\
> +{									\
> +}									\
> +static __always_inline void __ClearPage##uname(struct page *page)	\
> +{									\
> +}
> +
>  /*
>   * PageBuddy() indicates that the page is free and in the buddy system
>   * (see mm/page_alloc.c).
> @@ -997,6 +1017,17 @@ PAGE_TYPE_OPS(Buddy, buddy)
>   */
>  PAGE_TYPE_OPS(Offline, offline)
>  
> +/*
> + * PageUnaccepted() indicates that the page has to be "accepted" before it can
> + * be read or written. The page allocator must call accept_page() before
> + * touching the page or returning it to the caller.
> + */
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +PAGE_TYPE_OPS(Unaccepted, unaccepted)
> +#else
> +PAGE_TYPE_OPS_FALSE(Unaccepted)
> +#endif
> +
>  extern void page_offline_freeze(void);
>  extern void page_offline_thaw(void);
>  extern void page_offline_begin(void);
> diff --git a/mm/internal.h b/mm/internal.h
> index c0f8fbe0445b..7c1a653edfc8 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -861,4 +861,16 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
>  
>  DECLARE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
>  
> +#ifndef CONFIG_UNACCEPTED_MEMORY
> +static inline bool range_contains_unaccepted_memory(phys_addr_t start,
> +						    phys_addr_t end)
> +{
> +	return false;
> +}
> +
> +static inline void accept_memory(phys_addr_t start, phys_addr_t end)
> +{
> +}
> +#endif
> +
>  #endif	/* __MM_INTERNAL_H */
> diff --git a/mm/memblock.c b/mm/memblock.c
> index e4f03a6e8e56..a1f7f8b304d5 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1405,6 +1405,15 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>  		 */
>  		kmemleak_alloc_phys(found, size, 0, 0);
>  
> +	/*
> +	 * Some Virtual Machine platforms, such as Intel TDX or AMD SEV-SNP,
> +	 * require memory to be accepted before it can be used by the
> +	 * guest.
> +	 *
> +	 * Accept the memory of the allocated buffer.
> +	 */
> +	accept_memory(found, found + size);
> +
>  	return found;
>  }
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e008a3df0485..279c2746aaa8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -122,6 +122,12 @@ typedef int __bitwise fpi_t;
>   */
>  #define FPI_SKIP_KASAN_POISON	((__force fpi_t)BIT(2))
>  
> +/*
> + * Check if the page needs to be marked as PageUnaccepted().
> + * Used for the new pages added to the buddy allocator for the first time.
> + */
> +#define FPI_UNACCEPTED_SLOWPATH	((__force fpi_t)BIT(3))
> +
>  /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
>  static DEFINE_MUTEX(pcp_batch_high_lock);
>  #define MIN_PERCPU_PAGELIST_HIGH_FRACTION (8)
> @@ -993,6 +999,35 @@ buddy_merge_likely(unsigned long pfn, unsigned long buddy_pfn,
>  			NULL) != NULL;
>  }
>  
> +/*
> + * Page acceptance can be very slow. Do not call under critical locks.
> + */
> +static void accept_page(struct page *page, unsigned int order)
> +{
> +	phys_addr_t start = page_to_phys(page);
> +	int i;
> +
> +	if (!PageUnaccepted(page))
> +		return;
> +
> +	accept_memory(start, start + (PAGE_SIZE << order));
> +	__ClearPageUnaccepted(page);
> +
> +	/* Assert that there is no PageUnaccepted() on tail pages */
> +	if (IS_ENABLED(CONFIG_DEBUG_VM)) {
> +		for (i = 1; i < (1 << order); i++)
> +			VM_BUG_ON_PAGE(PageUnaccepted(page + i), page + i);
> +	}
> +}
> +
> +static bool page_contains_unaccepted(struct page *page, unsigned int order)
> +{
> +	phys_addr_t start = page_to_phys(page);
> +	phys_addr_t end = start + (PAGE_SIZE << order);
> +
> +	return range_contains_unaccepted_memory(start, end);
> +}
> +
>  /*
>   * Freeing function for a buddy system allocator.
>   *
> @@ -1027,6 +1062,7 @@ static inline void __free_one_page(struct page *page,
>  	unsigned long combined_pfn;
>  	struct page *buddy;
>  	bool to_tail;
> +	bool page_needs_acceptance = false;
>  
>  	VM_BUG_ON(!zone_is_initialized(zone));
>  	VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
> @@ -1038,6 +1074,11 @@ static inline void __free_one_page(struct page *page,
>  	VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
>  	VM_BUG_ON_PAGE(bad_range(zone, page), page);
>  
> +	if (PageUnaccepted(page)) {
> +		page_needs_acceptance = true;
> +		__ClearPageUnaccepted(page);
> +	}
> +
>  	while (order < MAX_ORDER - 1) {
>  		if (compaction_capture(capc, page, order, migratetype)) {
>  			__mod_zone_freepage_state(zone, -(1 << order),
> @@ -1072,6 +1113,13 @@ static inline void __free_one_page(struct page *page,
>  			clear_page_guard(zone, buddy, order, migratetype);
>  		else
>  			del_page_from_free_list(buddy, zone, order);
> +
> +		/* Mark page unaccepted if any of merged pages were unaccepted */
> +		if (PageUnaccepted(buddy)) {
> +			page_needs_acceptance = true;
> +			__ClearPageUnaccepted(buddy);
> +		}
> +
>  		combined_pfn = buddy_pfn & pfn;
>  		page = page + (combined_pfn - pfn);
>  		pfn = combined_pfn;
> @@ -1081,6 +1129,23 @@ static inline void __free_one_page(struct page *page,
>  done_merging:
>  	set_buddy_order(page, order);
>  
> +	/*
> +	 * The page gets marked as PageUnaccepted() if any of merged-in pages
> +	 * is PageUnaccepted().
> +	 *
> +	 * New pages, just being added to buddy allocator, do not have
> +	 * PageUnaccepted() set. FPI_UNACCEPTED_SLOWPATH indicates that the
> +	 * page is new and page_contains_unaccepted() check is required to
> +	 * determinate if acceptance is required.
> +	 *
> +	 * Avoid calling page_contains_unaccepted() if it is known that the page
> +	 * needs acceptance. It can be costly.
> +	 */
> +	if (!page_needs_acceptance && (fpi_flags & FPI_UNACCEPTED_SLOWPATH))
> +		page_needs_acceptance = page_contains_unaccepted(page, order);
> +	if (page_needs_acceptance)
> +		__SetPageUnaccepted(page);
> +
>  	if (fpi_flags & FPI_TO_TAIL)
>  		to_tail = true;
>  	else if (is_shuffle_order(order))
> @@ -1164,7 +1229,13 @@ int split_free_page(struct page *free_page,
>  static inline bool page_expected_state(struct page *page,
>  					unsigned long check_flags)
>  {
> -	if (unlikely(atomic_read(&page->_mapcount) != -1))
> +	/*
> +	 * The page must not be mapped to userspace and must not have
> +	 * a PageType other than listed in PAGE_TYPES_EXPECTED.
> +	 *
> +	 * Note, bit cleared means the page type is set.
> +	 */
> +	if (unlikely((atomic_read(&page->_mapcount) | PAGE_TYPES_EXPECTED) != -1))
>  		return false;
>  
>  	if (unlikely((unsigned long)page->mapping |
> @@ -1669,7 +1740,9 @@ void __free_pages_core(struct page *page, unsigned int order)
>  	 * Bypass PCP and place fresh pages right to the tail, primarily
>  	 * relevant for memory onlining.
>  	 */
> -	__free_pages_ok(page, order, FPI_TO_TAIL | FPI_SKIP_KASAN_POISON);
> +	__free_pages_ok(page, order,
> +			FPI_TO_TAIL | FPI_SKIP_KASAN_POISON |
> +			FPI_UNACCEPTED_SLOWPATH);
>  }
>  
>  #ifdef CONFIG_NUMA
> @@ -1822,6 +1895,9 @@ static void __init deferred_free_range(unsigned long pfn,
>  		return;
>  	}
>  
> +	/* Accept chunks smaller than page-block upfront */
> +	accept_memory(PFN_PHYS(pfn), PFN_PHYS(pfn + nr_pages));
> +
>  	for (i = 0; i < nr_pages; i++, page++, pfn++) {
>  		if ((pfn & (pageblock_nr_pages - 1)) == 0)
>  			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
> @@ -2281,6 +2357,13 @@ static inline void expand(struct zone *zone, struct page *page,
>  		if (set_page_guard(zone, &page[size], high, migratetype))
>  			continue;
>  
> +		/*
> +		 * Transfer PageUnaccepted() to the newly split pages so
> +		 * they can be accepted after dropping the zone lock.
> +		 */
> +		if (PageUnaccepted(page))
> +			__SetPageUnaccepted(&page[size]);
> +
>  		add_to_free_list(&page[size], zone, high, migratetype);
>  		set_buddy_order(&page[size], high);
>  	}
> @@ -2411,6 +2494,8 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
>  	 */
>  	kernel_unpoison_pages(page, 1 << order);
>  
> +	accept_page(page, order);
> +
>  	/*
>  	 * As memory initialization might be integrated into KASAN,
>  	 * KASAN unpoisoning and memory initializion code must be

