Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F32148C3A8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 13:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353035AbiALMCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 07:02:04 -0500
Received: from foss.arm.com ([217.140.110.172]:59074 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238445AbiALMCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 07:02:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 274F11FB;
        Wed, 12 Jan 2022 04:02:03 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.1.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE2923F766;
        Wed, 12 Jan 2022 04:02:00 -0800 (PST)
Date:   Wed, 12 Jan 2022 12:01:57 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        bodeddub@amazon.com, osalvador@suse.de, mike.kravetz@oracle.com,
        rientjes@google.com, catalin.marinas@arm.com, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com
Subject: Re: [PATCH] arm64: mm: hugetlb: add support for free vmemmap pages
 of HugeTLB
Message-ID: <Yd7DNesaCACPndv2@FVFF77S0Q05N>
References: <20220111131652.61947-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111131652.61947-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 11, 2022 at 09:16:52PM +0800, Muchun Song wrote:
> The preparation of supporting freeing vmemmap associated with each
> HugeTLB page is ready, so we can support this feature for arm64.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

It's a bit difficult to understand this commit message, as there's not much
context here.

What is HUGETLB_PAGE_FREE_VMEMMAP intended to achieve? Is this intended to save
memory, find bugs, or some other goal? If this is a memory saving or
performance improvement, can we quantify that benefit?

Does the alloc/free happen dynamically, or does this happen once during kernel
boot? IIUC it's the former, which sounds pretty scary. Especially if we need to
re-allocate the vmmemmap pages later -- can't we run out of memory, and then
fail to free a HugeTLB page?

Are there any requirements upon arch code, e.g. mutual exclusion?

Below there are a bunch of comments trying to explain that this is safe. Having
some of that rationale in the commit message itself would be helpful.

I see that commit:

  6be24bed9da367c2 ("mm: hugetlb: introduce a new config HUGETLB_PAGE_FREE_VMEMMAP")

... has a much more complete description, and cribbing some of that wording
would be helpful.


> ---
> There is already some discussions about this in [1], but there was no
> conclusion in the end. I copied the concern proposed by Anshuman to here.
> 
> 1st concern:
> "
>   But what happens when a hot remove section's vmemmap area (which is being
>   teared down) is nearby another vmemmap area which is either created or
>   being destroyed for HugeTLB alloc/free purpose. As you mentioned HugeTLB
>   pages inside the hot remove section might be safe. But what about other
>   HugeTLB areas whose vmemmap area shares page table entries with vmemmap
>   entries for a section being hot removed ? Massive HugeTLB alloc/use/free
>   test cycle using memory just adjacent to a memory hotplug area, which is
>   always added and removed periodically, should be able to expose this problem.
> "
> My Answer: As you already know HugeTLB pages inside the hot remove section
> is safe.

It would be helpful if you could explain *why* that's safe, since those of us
coming at this cold have no idea whether this is the case.

> Let's talk your question "what about other HugeTLB areas whose
> vmemmap area shares page table entries with vmemmap entries for a section
> being hot removed ?", the question is not established. Why? The minimal
> granularity size of hotplug memory 128MB (on arm64, 4k base page), so any
> HugeTLB smaller than 128MB is within a section, then, there is no share
> (PTE) page tables between HugeTLB in this section and ones in other
> sections and a HugeTLB could not cross two sections.

Am I correct in assuming that in this case we never free the section?

> Any HugeTLB bigger than 128MB (e.g. 1GB) whose size is an integer multible of
> a section and vmemmap area is also an integer multiple of 2MB. At the time
> memory is removed, all huge pages either have been migrated away or
> dissolved. The vmemmap is stable. So there is no problem in this case as
> well.

Are you mention 2MB here because we PMD-map the vmemmap with 4K pages?

IIUC, so long as:

1) HugeTLBs are naturally aligned, power-of-two sizes
2) The HugeTLB size >= the section size
3) The HugeTLB size >= the vmemmap leaf mapping size

... then a HugeTLB will not share any leaf page table entries with *anything
else*, but will share intermediate entries.

Perhaps that's a clearer line of argument?

Regardless, this should be in the commit message.

> 2nd concern:
> "
>   differently, not sure if ptdump would require any synchronization.
> 
>   Dumping an wrong value is probably okay but crashing because a page table
>   entry is being freed after ptdump acquired the pointer is bad. On arm64,
>   ptdump() is protected against hotremove via [get|put]_online_mems().
> "
> My Answer: The ptdump should be fine since vmemmap_remap_free() only exchanges
> PTEs or split the PMD entry (which means allocating a PTE page table). Both
> operations do not free any page tables, so ptdump cannot run into a UAF on
> any page tables. The wrost case is just dumping an wrong value.

This should be in the commit message.

Thanks,
Mark.

> 
> [1] https://lore.kernel.org/linux-mm/b8cdc9c8-853c-8392-a2fa-4f1a8f02057a@arm.com/T/
> 
>  fs/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 7a2b11c0b803..04cfd5bf5ec9 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -247,7 +247,7 @@ config HUGETLB_PAGE
>  
>  config HUGETLB_PAGE_FREE_VMEMMAP
>  	def_bool HUGETLB_PAGE
> -	depends on X86_64
> +	depends on X86_64 || ARM64
>  	depends on SPARSEMEM_VMEMMAP
>  
>  config HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON
> -- 
> 2.11.0
> 
