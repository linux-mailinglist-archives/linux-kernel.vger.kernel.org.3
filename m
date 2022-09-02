Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F305AAA93
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbiIBItB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236125AbiIBIsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:48:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFD2C2F91
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:48:39 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MJs2T2jC7znV0F;
        Fri,  2 Sep 2022 16:46:09 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 2 Sep 2022 16:48:37 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 2 Sep 2022 16:48:36 +0800
Message-ID: <acb2c705-85c3-4d57-aa80-fb04880e169e@huawei.com>
Date:   Fri, 2 Sep 2022 16:48:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] mm: reuse pageblock_start/end_pfn() macro
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        <linux-kernel@vger.kernel.org>, Vlastimil Babka <vbabka@suse.cz>
References: <20220902064751.17890-1-wangkefeng.wang@huawei.com>
 <417630cc-eaa8-1d73-6427-d87b02c187b6@redhat.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <417630cc-eaa8-1d73-6427-d87b02c187b6@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/9/2 16:20, David Hildenbrand wrote:
> On 02.09.22 08:47, Kefeng Wang wrote:
>> Move pageblock_start_pfn/pageblock_end_pfn() into pageblock-flags.h,
>> then they could be used somewhere else, not only in compaction.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   include/linux/pageblock-flags.h |  2 ++
>>   mm/compaction.c                 |  2 --
>>   mm/memblock.c                   |  2 +-
>>   mm/page_alloc.c                 | 13 ++++++-------
>>   mm/page_isolation.c             |  2 +-
>>   mm/page_owner.c                 |  4 ++--
>>   6 files changed, 12 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
>> index 83c7248053a1..ef2e17e312ae 100644
>> --- a/include/linux/pageblock-flags.h
>> +++ b/include/linux/pageblock-flags.h
>> @@ -53,6 +53,8 @@ extern unsigned int pageblock_order;
>>   #endif /* CONFIG_HUGETLB_PAGE */
>>   
>>   #define pageblock_nr_pages	(1UL << pageblock_order)
>> +#define pageblock_start_pfn(pfn)	round_down(pfn, pageblock_nr_pages)
>> +#define pageblock_end_pfn(pfn)		ALIGN((pfn + 1), pageblock_nr_pages)
>>   
> I'd naturally have paired ALIGN with ALIGN_DOWN -- or round_up with round_down.
> (You're replacing one instance where ALIGN_DOWN was used at least.)

I think they are same for pageblock usage，but the original macro 
introduced from Vlastimil

(06b6640a3902 mm, compaction: wrap calculating first and last pfn of 
pageblock), let's

wait for Vlastimil to see if there are some background.

>
> But maybe there is an obvious reason that I am missing :)
>
>>   /* Forward declaration */
>>   struct page;
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index f72907c7cfef..65bef5f78897 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -52,8 +52,6 @@ static inline void count_compact_events(enum vm_event_item item, long delta)
>>   
>>   #define block_start_pfn(pfn, order)	round_down(pfn, 1UL << (order))
>>   #define block_end_pfn(pfn, order)	ALIGN((pfn) + 1, 1UL << (order))
>> -#define pageblock_start_pfn(pfn)	block_start_pfn(pfn, pageblock_order)
>> -#define pageblock_end_pfn(pfn)		block_end_pfn(pfn, pageblock_order)
>>   
>>   /*
>>    * Page order with-respect-to which proactive compaction
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index b5d3026979fc..46fe7575f03c 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -2000,7 +2000,7 @@ static void __init free_unused_memmap(void)
>>   		 * presume that there are no holes in the memory map inside
>>   		 * a pageblock
>>   		 */
>> -		start = round_down(start, pageblock_nr_pages);
>> +		start = pageblock_start_pfn(start);
>>   
>>   		/*
>>   		 * If we had a previous bank, and there is a space
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 36b20215a3be..93339cc61f92 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -544,7 +544,7 @@ static inline int pfn_to_bitidx(const struct page *page, unsigned long pfn)
>>   #ifdef CONFIG_SPARSEMEM
>>   	pfn &= (PAGES_PER_SECTION-1);
>>   #else
>> -	pfn = pfn - round_down(page_zone(page)->zone_start_pfn, pageblock_nr_pages);
>> +	pfn = pfn - pageblock_start_pfn(page_zone(page)->zone_start_pfn);
>>   #endif /* CONFIG_SPARSEMEM */
>>   	return (pfn >> pageblock_order) * NR_PAGEBLOCK_BITS;
>>   }
>> @@ -1857,7 +1857,7 @@ void set_zone_contiguous(struct zone *zone)
>>   	unsigned long block_start_pfn = zone->zone_start_pfn;
>>   	unsigned long block_end_pfn;
>>   
>> -	block_end_pfn = ALIGN(block_start_pfn + 1, pageblock_nr_pages);
>> +	block_end_pfn = pageblock_end_pfn(block_start_pfn);
>>   	for (; block_start_pfn < zone_end_pfn(zone);
>>   			block_start_pfn = block_end_pfn,
>>   			 block_end_pfn += pageblock_nr_pages) {
>> @@ -2653,8 +2653,8 @@ int move_freepages_block(struct zone *zone, struct page *page,
>>   		*num_movable = 0;
>>   
>>   	pfn = page_to_pfn(page);
>> -	start_pfn = pfn & ~(pageblock_nr_pages - 1);
>> -	end_pfn = start_pfn + pageblock_nr_pages - 1;
>> +	start_pfn = pageblock_start_pfn(pfn);
>> +	end_pfn = pageblock_end_pfn(pfn) - 1;
>>   
>>   	/* Do not cross zone boundaries */
>>   	if (!zone_spans_pfn(zone, start_pfn))
>> @@ -6939,9 +6939,8 @@ static void __init init_unavailable_range(unsigned long spfn,
>>   	u64 pgcnt = 0;
>>   
>>   	for (pfn = spfn; pfn < epfn; pfn++) {
>> -		if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages))) {
>> -			pfn = ALIGN_DOWN(pfn, pageblock_nr_pages)
>> -				+ pageblock_nr_pages - 1;
>> +		if (!pfn_valid(pageblock_start_pfn(pfn))) {
>> +			pfn = pageblock_end_pfn(pfn) - 1;
>>   			continue;
>>   		}
>>   		__init_single_page(pfn_to_page(pfn), pfn, zone, node);
>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>> index 9d73dc38e3d7..f2df4ad53cd6 100644
>> --- a/mm/page_isolation.c
>> +++ b/mm/page_isolation.c
>> @@ -172,7 +172,7 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>>   	 * to avoid redundant checks.
>>   	 */
>>   	check_unmovable_start = max(page_to_pfn(page), start_pfn);
>> -	check_unmovable_end = min(ALIGN(page_to_pfn(page) + 1, pageblock_nr_pages),
>> +	check_unmovable_end = min(pageblock_end_pfn(page_to_pfn(page)),
>>   				  end_pfn);
>>   
>
> There are some more cases that might need care as well:
>
>
> mm/memblock.c:          prev_end = ALIGN(end, pageblock_nr_pages);
> mm/memblock.c:          prev_end = ALIGN(end, pageblock_nr_pages);
> mm/page_isolation.c:    VM_BUG_ON(ALIGN_DOWN(start_pfn, pageblock_nr_pages) !=
> mm/page_isolation.c:              ALIGN_DOWN(end_pfn - 1, pageblock_nr_pages));
> mm/page_isolation.c:    unsigned long isolate_start = ALIGN_DOWN(start_pfn, pageblock_nr_pages);
> mm/page_isolation.c:    unsigned long isolate_end = ALIGN(end_pfn, pageblock_nr_pages);
> mm/page_isolation.c:    unsigned long isolate_start = ALIGN_DOWN(start_pfn, pageblock_nr_pages);
> mm/page_isolation.c:    unsigned long isolate_end = ALIGN(end_pfn, pageblock_nr_pages);

ok, will update.

>
>
>
