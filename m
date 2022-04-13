Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174684FF4B2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiDMKfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiDMKf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:35:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A524F2E9E5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:33:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 475B01570;
        Wed, 13 Apr 2022 03:33:05 -0700 (PDT)
Received: from [10.163.39.141] (unknown [10.163.39.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 907713F73B;
        Wed, 13 Apr 2022 03:32:56 -0700 (PDT)
Message-ID: <836e2f84-f8e1-5303-26c2-eedb8d78c218@arm.com>
Date:   Wed, 13 Apr 2022 16:03:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/2] arm64: mm: hugetlb: Enable
 HUGETLB_PAGE_FREE_VMEMMAP for arm64
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, will@kernel.org,
        akpm@linux-foundation.org, david@redhat.com, bodeddub@amazon.com,
        osalvador@suse.de, mike.kravetz@oracle.com, rientjes@google.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, james.morse@arm.com,
        21cnbao@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com
References: <20220331065640.5777-1-songmuchun@bytedance.com>
 <20220331065640.5777-2-songmuchun@bytedance.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220331065640.5777-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/22 12:26, Muchun Song wrote:
> The feature of minimizing overhead of struct page associated with each
> HugeTLB page aims to free its vmemmap pages (used as struct page) to
> save memory, where is ~14GB/16GB per 1TB HugeTLB pages (2MB/1GB type).
> In short, when a HugeTLB page is allocated or freed, the vmemmap array
> representing the range associated with the page will need to be remapped.
> When a page is allocated, vmemmap pages are freed after remapping.
> When a page is freed, previously discarded vmemmap pages must be
> allocated before remapping.  More implementations and details can be
> found here [1].
> 
> The infrastructure of freeing vmemmap pages associated with each HugeTLB
> page is already there, we can easily enable HUGETLB_PAGE_FREE_VMEMMAP
> for arm64, the only thing to be fixed is flush_dcache_page() .
> 
> flush_dcache_page() need to be adapted to operate on the head page's
> flags since the tail vmemmap pages are mapped with read-only after the
> feature is enabled (clear operation is not permitted).
> 
> There was some discussions about this in the thread [2], but there was
> no conclusion in the end.  And I copied the concern proposed by Anshuman
> to here and explain why those concern is superfluous.  It is safe to
> enable it for x86_64 as well as arm64.
> 
> 1st concern:
> '''
> But what happens when a hot remove section's vmemmap area (which is
> being teared down) is nearby another vmemmap area which is either created
> or being destroyed for HugeTLB alloc/free purpose. As you mentioned
> HugeTLB pages inside the hot remove section might be safe. But what about
> other HugeTLB areas whose vmemmap area shares page table entries with
> vmemmap entries for a section being hot removed ? Massive HugeTLB alloc
> /use/free test cycle using memory just adjacent to a memory hotplug area,
> which is always added and removed periodically, should be able to expose
> this problem.
> '''
> 
> Answer: At the time memory is removed, all HugeTLB pages either have been
> migrated away or dissolved.  So there is no race between memory hot remove
> and free_huge_page_vmemmap().  Therefore, HugeTLB pages inside the hot
> remove section is safe.  Let's talk your question "what about other
> HugeTLB areas whose vmemmap area shares page table entries with vmemmap
> entries for a section being hot removed ?", the question is not
> established.  The minimal granularity size of hotplug memory 128MB (on
> arm64, 4k base page), any HugeTLB smaller than 128MB is within a section,
> then, there is no share PTE page tables between HugeTLB in this section
> and ones in other sections and a HugeTLB page could not cross two
> sections.  In this case, the section cannot be freed.  Any HugeTLB bigger
> than 128MB (section size) whose vmemmap pages is an integer multiple of
> 2MB (PMD-mapped).  As long as:
> 
>   1) HugeTLBs are naturally aligned, power-of-two sizes
>   2) The HugeTLB size >= the section size
>   3) The HugeTLB size >= the vmemmap leaf mapping size
> 
> Then a HugeTLB will not share any leaf page table entries with *anything
> else*, but will share intermediate entries.  In this case, at the time memory
> is removed, all HugeTLB pages either have been migrated away or dissolved.
> So there is also no race between memory hot remove and
> free_huge_page_vmemmap().
> 
> 2nd concern:
> '''
> differently, not sure if ptdump would require any synchronization.
> 
> Dumping an wrong value is probably okay but crashing because a page table
> entry is being freed after ptdump acquired the pointer is bad. On arm64,
> ptdump() is protected against hotremove via [get|put]_online_mems().
> '''
> 
> Answer: The ptdump should be fine since vmemmap_remap_free() only exchanges
> PTEs or splits the PMD entry (which means allocating a PTE page table).  Both
> operations do not free any page tables (PTE), so ptdump cannot run into a
> UAF on any page tables.  The worst case is just dumping an wrong value.
> 
> [1] https://lore.kernel.org/all/20210510030027.56044-1-songmuchun@bytedance.com/
> [2] https://lore.kernel.org/all/20210518091826.36937-1-songmuchun@bytedance.com/
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
> v4:
>  - Introduce ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP (implemented in the previous
>    patch) to enable this feature for arm64.
> 
> v3:
>  - Rework patch's subject.
>  - Clarify the feature of HUGETLB_PAGE_FREE_VMEMMAP is already there in the
>    current code and easyly be enabled for arm64 into commit log.
>  - Add hugetlb_free_vmemmap_enabled() check into flush_dcache_page().
> 
>  Thanks for Barry's suggestions.
> 
> v2:
>  - Update commit message (Mark Rutland).
>  - Fix flush_dcache_page().
> 
>  arch/arm64/Kconfig    |  1 +
>  arch/arm64/mm/flush.c | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c842878f8133..37f72e3a75d0 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -94,6 +94,7 @@ config ARM64
>  	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
>  	select ARCH_WANT_FRAME_POINTERS
>  	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
> +	select ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP
>  	select ARCH_WANT_LD_ORPHAN_WARN
>  	select ARCH_WANTS_NO_INSTR
>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
> diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
> index 2aaf950b906c..c67c1ca856c2 100644
> --- a/arch/arm64/mm/flush.c
> +++ b/arch/arm64/mm/flush.c
> @@ -68,6 +68,19 @@ EXPORT_SYMBOL_GPL(__sync_icache_dcache);
>   */
>  void flush_dcache_page(struct page *page)
>  {
> +	/*
> +	 * Only the head page's flags of HugeTLB can be cleared since the tail
> +	 * vmemmap pages associated with each HugeTLB page are mapped with
> +	 * read-only when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is enabled (more
> +	 * details can refer to vmemmap_remap_pte()).  Although
> +	 * __sync_icache_dcache() only set PG_dcache_clean flag on the head
> +	 * page struct, some tail page structs still can be seen the flag is
> +	 * set since the head vmemmap page frame is reused (more details can
> +	 * refer to the comments above page_fixed_fake_head()).
> +	 */
> +	if (hugetlb_free_vmemmap_enabled() && PageHuge(page))
> +		page = compound_head(page);
> +
>  	if (test_bit(PG_dcache_clean, &page->flags))
>  		clear_bit(PG_dcache_clean, &page->flags);
>  }

With restructuring above code comment inside flush_dcache_page(),

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
