Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6B5534251
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 19:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbiEYRlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 13:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiEYRlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 13:41:06 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB32AFB12
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 10:41:03 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id q4so19166097plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 10:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=94skciStQ5ymW9DUAo7HpPJI985hblEZnnynHghreMA=;
        b=HwKasncUXQo45lRkquuWZgDLaXjxuojBMk3sjNbUe/b+TEeKz1HBhOsqesRecSEIP+
         4XArGdiBUrQt+sy4KWK/JvF5A9phSs+7wOh+ZKjygNkpsAV/Bz+hApvxLncr2kdF/TDg
         RuY2/aWScvvzNlvXDYbr9S7FoP7E7IP8lnixCXSAfcibMKwq+wF8jYDwNQPGkEvoh5AI
         VQU0XjkOBFLsPeysNzwyaT+zpn4sktL0nS+sDfFJx+t93SIKc1l/i1tHrBlv71ENb4Ez
         fyl450S4EFgQuPHa42rlB0vaRxkD3bduDHBG7q+K0qXdu4+HmFg1ZR1dvafxCKw6NRx6
         88Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=94skciStQ5ymW9DUAo7HpPJI985hblEZnnynHghreMA=;
        b=pbviOxYbMaaASuKDGcbtmQdrzKSdGXBfIJ8aVgDPW5wQ/4r5djZNas3bva4bzJBbI3
         fy83WdBmEYoiTRcG6kdUwrgvaU9guKl9YmQMJnzHTrVQCHMG7eqSJ+JdmG159l6Gvsy8
         v47yQBs3fDcBXuNY0RMODdcSzGm2X0JBU3bngoPFCJMy4cDZ1pejThV4ejg3uRu/USOC
         YwhfCj0Q1aiee5RLs9AWRMsc8NnFJLcFaHCXQb+3FNRbOItS/hlPUf5ib4F6O0sDDybs
         Anx+pmhna/9zV5hUQkSCeQnUfk3SOSuiX0GS+enq73Fjgv1LQ2ZW2NqL3dCh9OdV/ZIl
         QERQ==
X-Gm-Message-State: AOAM533P0dCvHcEWtVFtK9s2hoCVcKuXBoIkPDwkpG8DjJVyf0nQs4Dd
        1gpV6O/OBNF841CxBsAxDl8=
X-Google-Smtp-Source: ABdhPJwHT+IApPaiqv9j85IpfV9bU4nn1vJ5a3jjnn/B38zsGdMxpO61uXzL4Fy1nPw9wuzw7KWQaw==
X-Received: by 2002:a17:90b:4a4a:b0:1df:a250:e583 with SMTP id lb10-20020a17090b4a4a00b001dfa250e583mr11521322pjb.172.1653500463109;
        Wed, 25 May 2022 10:41:03 -0700 (PDT)
Received: from [192.168.1.50] (ip70-191-40-110.oc.oc.cox.net. [70.191.40.110])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902e84c00b0015e8d4eb244sm9292455plg.142.2022.05.25.10.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 10:41:02 -0700 (PDT)
Message-ID: <180aaa57-28d8-30f0-e843-ea52e3a180a8@gmail.com>
Date:   Wed, 25 May 2022 10:41:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v11 3/6] mm: make alloc_contig_range work at pageblock
 granularity
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Qian Cai <quic_qiancai@quicinc.com>
References: <20220425143118.2850746-1-zi.yan@sent.com>
 <20220425143118.2850746-4-zi.yan@sent.com>
 <23A7297E-6C84-4138-A9FE-3598234004E6@nvidia.com>
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <23A7297E-6C84-4138-A9FE-3598234004E6@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing some free memory accounting problems with linux-next that I 
have bisected to this commit (i.e. b2c9e2fbba32 ("mm: make 
alloc_contig_range work at pageblock granularity").

On an arm64 SMP platform with 4GB total memory and the default 16MB 
default CMA pool, I am seeing the following after boot with a sysrq Show 
Memory (e.g. 'echo m > /proc/sysrq-trigger'):

[   16.015906] sysrq: Show Memory
[   16.019039] Mem-Info:
[   16.021348] active_anon:14604 inactive_anon:919 isolated_anon:0
[   16.021348]  active_file:0 inactive_file:0 isolated_file:0
[   16.021348]  unevictable:0 dirty:0 writeback:0
[   16.021348]  slab_reclaimable:3662 slab_unreclaimable:3333
[   16.021348]  mapped:928 shmem:15146 pagetables:63 bounce:0
[   16.021348]  kernel_misc_reclaimable:0
[   16.021348]  free:976766 free_pcp:991 free_cma:7017
[   16.056937] Node 0 active_anon:58416kB inactive_anon:3676kB 
active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB 
isolated(file):0kB mapped:3712kB dirty:0kB writeback:0kB shmem:60584kB 
writeback_tmp:0kB kernel_stack:1200kB pagetables:252kB all_unreclaimable? no
[   16.081526] DMA free:3041036kB boost:0kB min:6036kB low:9044kB 
high:12052kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB 
active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB 
present:3145728kB managed:3029992kB mlocked:0kB bounce:0kB 
free_pcp:636kB local_pcp:0kB free_cma:28068kB
[   16.108650] lowmem_reserve[]: 0 0 944 944
[   16.112746] Normal free:866028kB boost:0kB min:1936kB low:2900kB 
high:3864kB reserved_highatomic:0KB active_anon:58416kB 
inactive_anon:3676kB active_file:0kB inactive_file:0kB unevictable:0kB 
writepending:0kB present:1048576kB managed:967352kB mlocked:0kB 
bounce:0kB free_pcp:3328kB local_pcp:864kB free_cma:0kB
[   16.140393] lowmem_reserve[]: 0 0 0 0
[   16.144133] DMA: 7*4kB (UMC) 4*8kB (M) 3*16kB (M) 3*32kB (MC) 5*64kB 
(M) 4*128kB (MC) 5*256kB (UMC) 7*512kB (UM) 5*1024kB (UM) 9*2048kB (UMC) 
732*4096kB (MC) = 3027724kB
[   16.159609] Normal: 149*4kB (UM) 95*8kB (UME) 26*16kB (UME) 8*32kB 
(ME) 2*64kB (UE) 1*128kB (M) 2*256kB (ME) 2*512kB (ME) 2*1024kB (UM) 
0*2048kB 210*4096kB (M) = 866028kB
[   16.175165] Node 0 hugepages_total=0 hugepages_free=0 
hugepages_surp=0 hugepages_size=1048576kB
[   16.183937] Node 0 hugepages_total=0 hugepages_free=0 
hugepages_surp=0 hugepages_size=32768kB
[   16.192533] Node 0 hugepages_total=0 hugepages_free=0 
hugepages_surp=0 hugepages_size=2048kB
[   16.201040] Node 0 hugepages_total=0 hugepages_free=0 
hugepages_surp=0 hugepages_size=64kB
[   16.209374] 15146 total pagecache pages
[   16.213246] 0 pages in swap cache
[   16.216595] Swap cache stats: add 0, delete 0, find 0/0
[   16.221867] Free swap  = 0kB
[   16.224780] Total swap = 0kB
[   16.227693] 1048576 pages RAM
[   16.230694] 0 pages HighMem/MovableOnly
[   16.234564] 49240 pages reserved
[   16.237825] 4096 pages cma reserved

Some anomolies in the above are:
free_cma:7017 with only 4096 pages cma reserved
DMA free:3041036kB with only managed:3029992kB

I'm not sure what is going on here, but I am suspicious of 
split_free_page() since del_page_from_free_list doesn't affect 
migrate_type accounting, but __free_one_page() can.
Also PageBuddy(page) is being checked without zone->lock in 
isolate_single_pageblock().

Please investigate this as well.

Thanks!
     Doug

On 4/29/2022 6:54 AM, Zi Yan wrote:
> On 25 Apr 2022, at 10:31, Zi Yan wrote:
> 
>> From: Zi Yan <ziy@nvidia.com>
>>
>> alloc_contig_range() worked at MAX_ORDER_NR_PAGES granularity to avoid
>> merging pageblocks with different migratetypes. It might unnecessarily
>> convert extra pageblocks at the beginning and at the end of the range.
>> Change alloc_contig_range() to work at pageblock granularity.
>>
>> Special handling is needed for free pages and in-use pages across the
>> boundaries of the range specified by alloc_contig_range(). Because these
>> partially isolated pages causes free page accounting issues. The free
>> pages will be split and freed into separate migratetype lists; the
>> in-use pages will be migrated then the freed pages will be handled in
>> the aforementioned way.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   include/linux/page-isolation.h |   4 +-
>>   mm/internal.h                  |   6 ++
>>   mm/memory_hotplug.c            |   3 +-
>>   mm/page_alloc.c                |  54 ++++++++--
>>   mm/page_isolation.c            | 184 ++++++++++++++++++++++++++++++++-
>>   5 files changed, 233 insertions(+), 18 deletions(-)
>>
>> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
>> index e14eddf6741a..5456b7be38ae 100644
>> --- a/include/linux/page-isolation.h
>> +++ b/include/linux/page-isolation.h
>> @@ -42,7 +42,7 @@ int move_freepages_block(struct zone *zone, struct page *page,
>>    */
>>   int
>>   start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>> -			 unsigned migratetype, int flags);
>> +			 int migratetype, int flags, gfp_t gfp_flags);
>>
>>   /*
>>    * Changes MIGRATE_ISOLATE to MIGRATE_MOVABLE.
>> @@ -50,7 +50,7 @@ start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>>    */
>>   void
>>   undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>> -			unsigned migratetype);
>> +			int migratetype);
>>
>>   /*
>>    * Test all pages in [start_pfn, end_pfn) are isolated or not.
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 919fa07e1031..0667abd57634 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -359,6 +359,9 @@ extern void *memmap_alloc(phys_addr_t size, phys_addr_t align,
>>   			  phys_addr_t min_addr,
>>   			  int nid, bool exact_nid);
>>
>> +void split_free_page(struct page *free_page,
>> +				int order, unsigned long split_pfn_offset);
>> +
>>   #if defined CONFIG_COMPACTION || defined CONFIG_CMA
>>
>>   /*
>> @@ -422,6 +425,9 @@ isolate_freepages_range(struct compact_control *cc,
>>   int
>>   isolate_migratepages_range(struct compact_control *cc,
>>   			   unsigned long low_pfn, unsigned long end_pfn);
>> +
>> +int __alloc_contig_migrate_range(struct compact_control *cc,
>> +					unsigned long start, unsigned long end);
>>   #endif
>>   int find_suitable_fallback(struct free_area *area, unsigned int order,
>>   			int migratetype, bool only_stealable, bool *can_steal);
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 4c6065e5d274..9f8ae4cb77ee 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1845,7 +1845,8 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>>   	/* set above range as isolated */
>>   	ret = start_isolate_page_range(start_pfn, end_pfn,
>>   				       MIGRATE_MOVABLE,
>> -				       MEMORY_OFFLINE | REPORT_FAILURE);
>> +				       MEMORY_OFFLINE | REPORT_FAILURE,
>> +				       GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL);
>>   	if (ret) {
>>   		reason = "failure to isolate range";
>>   		goto failed_removal_pcplists_disabled;
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index ce23ac8ad085..70ddd9a0bcf3 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1094,6 +1094,43 @@ static inline void __free_one_page(struct page *page,
>>   		page_reporting_notify_free(order);
>>   }
>>
>> +/**
>> + * split_free_page() -- split a free page at split_pfn_offset
>> + * @free_page:		the original free page
>> + * @order:		the order of the page
>> + * @split_pfn_offset:	split offset within the page
>> + *
>> + * It is used when the free page crosses two pageblocks with different migratetypes
>> + * at split_pfn_offset within the page. The split free page will be put into
>> + * separate migratetype lists afterwards. Otherwise, the function achieves
>> + * nothing.
>> + */
>> +void split_free_page(struct page *free_page,
>> +				int order, unsigned long split_pfn_offset)
>> +{
>> +	struct zone *zone = page_zone(free_page);
>> +	unsigned long free_page_pfn = page_to_pfn(free_page);
>> +	unsigned long pfn;
>> +	unsigned long flags;
>> +	int free_page_order;
>> +
>> +	spin_lock_irqsave(&zone->lock, flags);
>> +	del_page_from_free_list(free_page, zone, order);
>> +	for (pfn = free_page_pfn;
>> +	     pfn < free_page_pfn + (1UL << order);) {
>> +		int mt = get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
>> +
>> +		free_page_order = ffs(split_pfn_offset) - 1;
>> +		__free_one_page(pfn_to_page(pfn), pfn, zone, free_page_order,
>> +				mt, FPI_NONE);
>> +		pfn += 1UL << free_page_order;
>> +		split_pfn_offset -= (1UL << free_page_order);
>> +		/* we have done the first part, now switch to second part */
>> +		if (split_pfn_offset == 0)
>> +			split_pfn_offset = (1UL << order) - (pfn - free_page_pfn);
>> +	}
>> +	spin_unlock_irqrestore(&zone->lock, flags);
>> +}
>>   /*
>>    * A bad page could be due to a number of fields. Instead of multiple branches,
>>    * try and check multiple fields with one check. The caller must do a detailed
>> @@ -8919,7 +8956,7 @@ static inline void alloc_contig_dump_pages(struct list_head *page_list)
>>   #endif
>>
>>   /* [start, end) must belong to a single zone. */
>> -static int __alloc_contig_migrate_range(struct compact_control *cc,
>> +int __alloc_contig_migrate_range(struct compact_control *cc,
>>   					unsigned long start, unsigned long end)
>>   {
>>   	/* This function is based on compact_zone() from compaction.c. */
>> @@ -9002,7 +9039,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>>   		       unsigned migratetype, gfp_t gfp_mask)
>>   {
>>   	unsigned long outer_start, outer_end;
>> -	unsigned int order;
>> +	int order;
>>   	int ret = 0;
>>
>>   	struct compact_control cc = {
>> @@ -9021,14 +9058,11 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>>   	 * What we do here is we mark all pageblocks in range as
>>   	 * MIGRATE_ISOLATE.  Because pageblock and max order pages may
>>   	 * have different sizes, and due to the way page allocator
>> -	 * work, we align the range to biggest of the two pages so
>> -	 * that page allocator won't try to merge buddies from
>> -	 * different pageblocks and change MIGRATE_ISOLATE to some
>> -	 * other migration type.
>> +	 * work, start_isolate_page_range() has special handlings for this.
>>   	 *
>>   	 * Once the pageblocks are marked as MIGRATE_ISOLATE, we
>>   	 * migrate the pages from an unaligned range (ie. pages that
>> -	 * we are interested in).  This will put all the pages in
>> +	 * we are interested in). This will put all the pages in
>>   	 * range back to page allocator as MIGRATE_ISOLATE.
>>   	 *
>>   	 * When this is done, we take the pages in range from page
>> @@ -9042,9 +9076,9 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>>   	 */
>>
>>   	ret = start_isolate_page_range(pfn_max_align_down(start),
>> -				       pfn_max_align_up(end), migratetype, 0);
>> +				pfn_max_align_up(end), migratetype, 0, gfp_mask);
>>   	if (ret)
>> -		return ret;
>> +		goto done;
>>
>>   	drain_all_pages(cc.zone);
>>
>> @@ -9064,7 +9098,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>>   	ret = 0;
>>
>>   	/*
>> -	 * Pages from [start, end) are within a MAX_ORDER_NR_PAGES
>> +	 * Pages from [start, end) are within a pageblock_nr_pages
>>   	 * aligned blocks that are marked as MIGRATE_ISOLATE.  What's
>>   	 * more, all pages in [start, end) are free in page allocator.
>>   	 * What we are going to do is to allocate all pages from
>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>> index c2f7a8bb634d..94b3467e5ba2 100644
>> --- a/mm/page_isolation.c
>> +++ b/mm/page_isolation.c
>> @@ -203,7 +203,7 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>>   	return -EBUSY;
>>   }
>>
>> -static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>> +static void unset_migratetype_isolate(struct page *page, int migratetype)
>>   {
>>   	struct zone *zone;
>>   	unsigned long flags, nr_pages;
>> @@ -279,6 +279,157 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>>   	return NULL;
>>   }
>>
>> +/**
>> + * isolate_single_pageblock() -- tries to isolate a pageblock that might be
>> + * within a free or in-use page.
>> + * @boundary_pfn:		pageblock-aligned pfn that a page might cross
>> + * @gfp_flags:			GFP flags used for migrating pages
>> + * @isolate_before:	isolate the pageblock before the boundary_pfn
>> + *
>> + * Free and in-use pages can be as big as MAX_ORDER-1 and contain more than one
>> + * pageblock. When not all pageblocks within a page are isolated at the same
>> + * time, free page accounting can go wrong. For example, in the case of
>> + * MAX_ORDER-1 = pageblock_order + 1, a MAX_ORDER-1 page has two pagelbocks.
>> + * [         MAX_ORDER-1         ]
>> + * [  pageblock0  |  pageblock1  ]
>> + * When either pageblock is isolated, if it is a free page, the page is not
>> + * split into separate migratetype lists, which is supposed to; if it is an
>> + * in-use page and freed later, __free_one_page() does not split the free page
>> + * either. The function handles this by splitting the free page or migrating
>> + * the in-use page then splitting the free page.
>> + */
>> +static int isolate_single_pageblock(unsigned long boundary_pfn, gfp_t gfp_flags,
>> +			bool isolate_before)
>> +{
>> +	unsigned char saved_mt;
>> +	unsigned long start_pfn;
>> +	unsigned long isolate_pageblock;
>> +	unsigned long pfn;
>> +	struct zone *zone;
>> +
>> +	VM_BUG_ON(!IS_ALIGNED(boundary_pfn, pageblock_nr_pages));
>> +
>> +	if (isolate_before)
>> +		isolate_pageblock = boundary_pfn - pageblock_nr_pages;
>> +	else
>> +		isolate_pageblock = boundary_pfn;
>> +
>> +	/*
>> +	 * scan at the beginning of MAX_ORDER_NR_PAGES aligned range to avoid
>> +	 * only isolating a subset of pageblocks from a bigger than pageblock
>> +	 * free or in-use page. Also make sure all to-be-isolated pageblocks
>> +	 * are within the same zone.
>> +	 */
>> +	zone  = page_zone(pfn_to_page(isolate_pageblock));
>> +	start_pfn  = max(ALIGN_DOWN(isolate_pageblock, MAX_ORDER_NR_PAGES),
>> +				      zone->zone_start_pfn);
>> +
>> +	saved_mt = get_pageblock_migratetype(pfn_to_page(isolate_pageblock));
>> +	set_pageblock_migratetype(pfn_to_page(isolate_pageblock), MIGRATE_ISOLATE);
>> +
>> +	/*
>> +	 * Bail out early when the to-be-isolated pageblock does not form
>> +	 * a free or in-use page across boundary_pfn:
>> +	 *
>> +	 * 1. isolate before boundary_pfn: the page after is not online
>> +	 * 2. isolate after boundary_pfn: the page before is not online
>> +	 *
>> +	 * This also ensures correctness. Without it, when isolate after
>> +	 * boundary_pfn and [start_pfn, boundary_pfn) are not online,
>> +	 * __first_valid_page() will return unexpected NULL in the for loop
>> +	 * below.
>> +	 */
>> +	if (isolate_before) {
>> +		if (!pfn_to_online_page(boundary_pfn))
>> +			return 0;
>> +	} else {
>> +		if (!pfn_to_online_page(boundary_pfn - 1))
>> +			return 0;
>> +	}
>> +
>> +	for (pfn = start_pfn; pfn < boundary_pfn;) {
>> +		struct page *page = __first_valid_page(pfn, boundary_pfn - pfn);
>> +
>> +		VM_BUG_ON(!page);
>> +		pfn = page_to_pfn(page);
>> +		/*
>> +		 * start_pfn is MAX_ORDER_NR_PAGES aligned, if there is any
>> +		 * free pages in [start_pfn, boundary_pfn), its head page will
>> +		 * always be in the range.
>> +		 */
>> +		if (PageBuddy(page)) {
>> +			int order = buddy_order(page);
>> +
>> +			if (pfn + (1UL << order) > boundary_pfn)
>> +				split_free_page(page, order, boundary_pfn - pfn);
>> +			pfn += (1UL << order);
>> +			continue;
>> +		}
>> +		/*
>> +		 * migrate compound pages then let the free page handling code
>> +		 * above do the rest. If migration is not enabled, just fail.
>> +		 */
>> +		if (PageHuge(page) || PageTransCompound(page)) {
>> +#if defined CONFIG_COMPACTION || defined CONFIG_CMA
>> +			unsigned long nr_pages = compound_nr(page);
>> +			int order = compound_order(page);
>> +			struct page *head = compound_head(page);
>> +			unsigned long head_pfn = page_to_pfn(head);
>> +			int ret;
>> +			struct compact_control cc = {
>> +				.nr_migratepages = 0,
>> +				.order = -1,
>> +				.zone = page_zone(pfn_to_page(head_pfn)),
>> +				.mode = MIGRATE_SYNC,
>> +				.ignore_skip_hint = true,
>> +				.no_set_skip_hint = true,
>> +				.gfp_mask = gfp_flags,
>> +				.alloc_contig = true,
>> +			};
>> +			INIT_LIST_HEAD(&cc.migratepages);
>> +
>> +			if (head_pfn + nr_pages < boundary_pfn) {
>> +				pfn += nr_pages;
>> +				continue;
>> +			}
>> +
>> +			ret = __alloc_contig_migrate_range(&cc, head_pfn,
>> +						head_pfn + nr_pages);
>> +
>> +			if (ret)
>> +				goto failed;
>> +			/*
>> +			 * reset pfn, let the free page handling code above
>> +			 * split the free page to the right migratetype list.
>> +			 *
>> +			 * head_pfn is not used here as a hugetlb page order
>> +			 * can be bigger than MAX_ORDER-1, but after it is
>> +			 * freed, the free page order is not. Use pfn within
>> +			 * the range to find the head of the free page and
>> +			 * reset order to 0 if a hugetlb page with
>> +			 * >MAX_ORDER-1 order is encountered.
>> +			 */
>> +			if (order > MAX_ORDER-1)
>> +				order = 0;
>> +			while (!PageBuddy(pfn_to_page(pfn))) {
>> +				order++;
>> +				pfn &= ~0UL << order;
>> +			}
>> +			continue;
>> +#else
>> +			goto failed;
>> +#endif
>> +		}
>> +
>> +		pfn++;
>> +	}
>> +	return 0;
>> +failed:
>> +	/* restore the original migratetype */
>> +	set_pageblock_migratetype(pfn_to_page(isolate_pageblock), saved_mt);
>> +	return -EBUSY;
>> +}
>> +
>>   /**
>>    * start_isolate_page_range() - make page-allocation-type of range of pages to
>>    * be MIGRATE_ISOLATE.
>> @@ -293,6 +444,8 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>>    *					 and PageOffline() pages.
>>    *			REPORT_FAILURE - report details about the failure to
>>    *			isolate the range
>> + * @gfp_flags:		GFP flags used for migrating pages that sit across the
>> + *			range boundaries.
>>    *
>>    * Making page-allocation-type to be MIGRATE_ISOLATE means free pages in
>>    * the range will never be allocated. Any free pages and pages freed in the
>> @@ -301,6 +454,10 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>>    * pages in the range finally, the caller have to free all pages in the range.
>>    * test_page_isolated() can be used for test it.
>>    *
>> + * The function first tries to isolate the pageblocks at the beginning and end
>> + * of the range, since there might be pages across the range boundaries.
>> + * Afterwards, it isolates the rest of the range.
>> + *
>>    * There is no high level synchronization mechanism that prevents two threads
>>    * from trying to isolate overlapping ranges. If this happens, one thread
>>    * will notice pageblocks in the overlapping range already set to isolate.
>> @@ -321,21 +478,38 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>>    * Return: 0 on success and -EBUSY if any part of range cannot be isolated.
>>    */
>>   int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>> -			     unsigned migratetype, int flags)
>> +			     int migratetype, int flags, gfp_t gfp_flags)
>>   {
>>   	unsigned long pfn;
>>   	struct page *page;
>> +	int ret;
>>
>>   	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
>>   	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
>>
>> -	for (pfn = start_pfn;
>> -	     pfn < end_pfn;
>> +	/* isolate [start_pfn, start_pfn + pageblock_nr_pages) pageblock */
>> +	ret = isolate_single_pageblock(start_pfn, gfp_flags, false);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* isolate [end_pfn - pageblock_nr_pages, end_pfn) pageblock */
>> +	ret = isolate_single_pageblock(end_pfn, gfp_flags, true);
>> +	if (ret) {
>> +		unset_migratetype_isolate(pfn_to_page(start_pfn), migratetype);
>> +		return ret;
>> +	}
>> +
>> +	/* skip isolated pageblocks at the beginning and end */
>> +	for (pfn = start_pfn + pageblock_nr_pages;
>> +	     pfn < end_pfn - pageblock_nr_pages;
>>   	     pfn += pageblock_nr_pages) {
>>   		page = __first_valid_page(pfn, pageblock_nr_pages);
>>   		if (page && set_migratetype_isolate(page, migratetype, flags,
>>   					start_pfn, end_pfn)) {
>>   			undo_isolate_page_range(start_pfn, pfn, migratetype);
>> +			unset_migratetype_isolate(
>> +				pfn_to_page(end_pfn - pageblock_nr_pages),
>> +				migratetype);
>>   			return -EBUSY;
>>   		}
>>   	}
>> @@ -346,7 +520,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>>    * Make isolated pages available again.
>>    */
>>   void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>> -			    unsigned migratetype)
>> +			    int migratetype)
>>   {
>>   	unsigned long pfn;
>>   	struct page *page;
>> -- 
>> 2.35.1
> 
> Qian hit a bug caused by this series https://lore.kernel.org/linux-mm/20220426201855.GA1014@qian/
> and the fix is:
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 75e454f5cf45..b3f074d1682e 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -367,58 +367,67 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, gfp_t gfp_flags,
>   		}
>   		/*
>   		 * migrate compound pages then let the free page handling code
> -		 * above do the rest. If migration is not enabled, just fail.
> +		 * above do the rest. If migration is not possible, just fail.
>   		 */
> -		if (PageHuge(page) || PageTransCompound(page)) {
> -#if defined CONFIG_COMPACTION || defined CONFIG_CMA
> +		if (PageCompound(page)) {
>   			unsigned long nr_pages = compound_nr(page);
> -			int order = compound_order(page);
>   			struct page *head = compound_head(page);
>   			unsigned long head_pfn = page_to_pfn(head);
> -			int ret;
> -			struct compact_control cc = {
> -				.nr_migratepages = 0,
> -				.order = -1,
> -				.zone = page_zone(pfn_to_page(head_pfn)),
> -				.mode = MIGRATE_SYNC,
> -				.ignore_skip_hint = true,
> -				.no_set_skip_hint = true,
> -				.gfp_mask = gfp_flags,
> -				.alloc_contig = true,
> -			};
> -			INIT_LIST_HEAD(&cc.migratepages);
> 
>   			if (head_pfn + nr_pages < boundary_pfn) {
> -				pfn += nr_pages;
> +				pfn = head_pfn + nr_pages;
>   				continue;
>   			}
> -
> -			ret = __alloc_contig_migrate_range(&cc, head_pfn,
> -						head_pfn + nr_pages);
> -
> -			if (ret)
> -				goto failed;
> +#if defined CONFIG_COMPACTION || defined CONFIG_CMA
>   			/*
> -			 * reset pfn, let the free page handling code above
> -			 * split the free page to the right migratetype list.
> -			 *
> -			 * head_pfn is not used here as a hugetlb page order
> -			 * can be bigger than MAX_ORDER-1, but after it is
> -			 * freed, the free page order is not. Use pfn within
> -			 * the range to find the head of the free page and
> -			 * reset order to 0 if a hugetlb page with
> -			 * >MAX_ORDER-1 order is encountered.
> +			 * hugetlb, lru compound (THP), and movable compound pages
> +			 * can be migrated. Otherwise, fail the isolation.
>   			 */
> -			if (order > MAX_ORDER-1)
> +			if (PageHuge(page) || PageLRU(page) || __PageMovable(page)) {
> +				int order;
> +				unsigned long outer_pfn;
> +				int ret;
> +				struct compact_control cc = {
> +					.nr_migratepages = 0,
> +					.order = -1,
> +					.zone = page_zone(pfn_to_page(head_pfn)),
> +					.mode = MIGRATE_SYNC,
> +					.ignore_skip_hint = true,
> +					.no_set_skip_hint = true,
> +					.gfp_mask = gfp_flags,
> +					.alloc_contig = true,
> +				};
> +				INIT_LIST_HEAD(&cc.migratepages);
> +
> +				ret = __alloc_contig_migrate_range(&cc, head_pfn,
> +							head_pfn + nr_pages);
> +
> +				if (ret)
> +					goto failed;
> +				/*
> +				 * reset pfn to the head of the free page, so
> +				 * that the free page handling code above can split
> +				 * the free page to the right migratetype list.
> +				 *
> +				 * head_pfn is not used here as a hugetlb page order
> +				 * can be bigger than MAX_ORDER-1, but after it is
> +				 * freed, the free page order is not. Use pfn within
> +				 * the range to find the head of the free page.
> +				 */
>   				order = 0;
> -			while (!PageBuddy(pfn_to_page(pfn))) {
> -				order++;
> -				pfn &= ~0UL << order;
> -			}
> -			continue;
> -#else
> -			goto failed;
> +				outer_pfn = pfn;
> +				while (!PageBuddy(pfn_to_page(outer_pfn))) {
> +					if (++order >= MAX_ORDER) {
> +						outer_pfn = pfn;
> +						break;
> +					}
> +					outer_pfn &= ~0UL << order;
> +				}
> +				pfn = outer_pfn;
> +				continue;
> +			} else
>   #endif
> +				goto failed;
>   		}
> 
>   		pfn++;

