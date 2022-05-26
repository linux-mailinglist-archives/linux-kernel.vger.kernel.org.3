Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FEA535443
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239618AbiEZUMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiEZUMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:12:03 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD959A9B5
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:11:59 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220526201154euoutp0184381100c71b91fb253b214eeb6de255~ywLkinRrU0292202922euoutp014
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 20:11:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220526201154euoutp0184381100c71b91fb253b214eeb6de255~ywLkinRrU0292202922euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653595914;
        bh=31KuGjxR08IwJ09kN+cFK8RkvnAC1lHMIrx4YJnpcAQ=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=SimxpIUxg8uMuAOi+9ijtt12BxLBfzmgNQGAn4O58wQScPmAfhXVBrICNj3/Eh3IW
         l8gho/JerptYWOX9i/qPSK4LWqU6k9MPqpPS/9OK2aBhgWGr2+xFTtm+iUMnMTkYLk
         eByFz1AYauH0xffeNN4ktIn1+rlKLt8L/WWSYCNg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220526201153eucas1p211dba4ce96934e6c31e0ff5ed4933ac2~ywLjTmCAu0440804408eucas1p2S;
        Thu, 26 May 2022 20:11:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 24.8F.10260.90FDF826; Thu, 26
        May 2022 21:11:53 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220526201152eucas1p1e45adf35fb1f6bef57489983418906ee~ywLiPeC1M1115311153eucas1p1a;
        Thu, 26 May 2022 20:11:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220526201152eusmtrp102dbc434c56306a5844a0a3bde08cfe8~ywLiOm4GQ2659426594eusmtrp1k;
        Thu, 26 May 2022 20:11:52 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-a9-628fdf09cf97
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 27.08.09404.70FDF826; Thu, 26
        May 2022 21:11:51 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220526201151eusmtip1a9aed8a942f29c34694379f7ec94d502~ywLhgRqm52606726067eusmtip1e;
        Thu, 26 May 2022 20:11:51 +0000 (GMT)
Message-ID: <ac65adc0-a7e4-cdfe-a0d8-757195b86293@samsung.com>
Date:   Thu, 26 May 2022 22:11:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH] mm: fix a potential infinite loop in
 start_isolate_page_range().
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <8C74B0BA-3C69-46EE-8C14-0CE6787D0B65@nvidia.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsWy7djPc7qc9/uTDG4c4rCYs34Nm8WdSc/Z
        Lb6u/8VscXnXHDaLe2v+s1rsWLqPyeLMtCKL768OMFksOLyO0eLI+u1MFrMb+xgtlp+dx2Yx
        ++g9dgdej683zzF57Jx1l91j06pONo9Nnyaxe5yY8ZvFY/KN5Ywevc3v2Dwm7qnzeL/vKpvH
        mQVH2D02n6722PrLzuPzJrkA3igum5TUnMyy1CJ9uwSujA+PMwseeVT8/tzF1MC43KqLkZND
        QsBEYu71RUxdjFwcQgIrGCVmHupgAUkICXxhlDjYEgGR+MwocWD5HKAqDrCO7qYCiPhyRon3
        V7sYIZyPjBKnr/SwgnTzCthJ/O7uYwSxWQRUJXY8fsgOEReUODnzCdgGUYEkifnbWsHqhQXC
        Ja5v7WUGsZkFxCVuPZnPBGKLCEhLnO77wwyygFngCLPE/K3LwIrYBAwlut52sYHYnEDLZv/f
        zATRLC+x/e0csAYJgf2cEkfn/WaBeNRFYtf7+1C2sMSr41vYIWwZidOTe1ggXsuX+DvDGCJc
        IXHt9RpmCNta4s65X2wgJcwCmhLrd+lDhB0l9iw/Dw0UPokbbwUhLuCTmLRtOjNEmFeio00I
        olpNYtbxdXA7D164xDyBUWkWUqDMQvL8LCS/zELYu4CRZRWjeGppcW56arFxXmq5XnFibnFp
        Xrpecn7uJkZgAjz97/jXHYwrXn3UO8TIxMF4iFGCg1lJhPfC094kId6UxMqq1KL8+KLSnNTi
        Q4zSHCxK4rzJmRsShQTSE0tSs1NTC1KLYLJMHJxSDUwtpRonim0smu8ciHla6G/IcF3xp3DY
        2mLbs0LJcfXW+tfknddu1TkW7xeQZnC7J+I7Y8hdpnsBxgZ6GreCK5dzWXKkFisKiyTNZGCs
        2KLyr86qZcfiCxmddfz7D3I8NnggKyC28UP/wdMlq+Ksjq3Q2XIp8qRi0L8XFnqFl3JePO3Q
        ZxOcf9ns69qVT/YejtGXcKtwEvufMt32msAyS4nLM7fd/BDhGbr+vtv8xSUTYs9EFf3Kvs14
        LjEzainz5/aX3IrrIhz/M/i/7NwxU+vP7bc9RQfnlN9cYNZQY/Jp7mG/Bocs98na3msm3reo
        btmn+2LZ5k6PsCMcD8qKZjPfFC/WW67+nENqjn9ZtRJLcUaioRZzUXEiACX3ZATvAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsVy+t/xu7rs9/uTDDY+traYs34Nm8WdSc/Z
        Lb6u/8VscXnXHDaLe2v+s1rsWLqPyeLMtCKL768OMFksOLyO0eLI+u1MFrMb+xgtlp+dx2Yx
        ++g9dgdej683zzF57Jx1l91j06pONo9Nnyaxe5yY8ZvFY/KN5Ywevc3v2Dwm7qnzeL/vKpvH
        mQVH2D02n6722PrLzuPzJrkA3ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNT
        JX07m5TUnMyy1CJ9uwS9jA+PMwseeVT8/tzF1MC43KqLkYNDQsBEorupoIuRi0NIYCmjxNv7
        q9m7GDmB4jISJ6c1sELYwhJ/rnWxQRS9Z5RY9nQeG0iCV8BO4nd3HyOIzSKgKrHj8UN2iLig
        xMmZT1hAbFGBJIl5e1eD1QgLhEtc39rLDGIzC4hL3HoynwnEFhGQljjd94cZZAGzwDFmiUeH
        XjNCbPvMKLHqxDewbWwChhJdb7vAbE6gzbP/b2aCmGQm0bW1ixHClpfY/nYO8wRGoVlIDpmF
        ZOEsJC2zkLQsYGRZxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERj524793LKDceWrj3qHGJk4
        GA8xSnAwK4nwXnjamyTEm5JYWZValB9fVJqTWnyI0RQYGhOZpUST84GpJ68k3tDMwNTQxMzS
        wNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgWm7wq4pm89pm4f+FzFt5LpyfdebnYJL
        G08VuyuocP/icxLLZjB5Nr+H4cQh7+k3gjg+fFp2mYv9ZFhaIccpx2dXAnpZfYrmlPzVO7xr
        1oHVHDe3CbKlZDCV2t3qYDnaMD9jR3ubadDkltdFGQ9SfQ9dUlm151MmT4y4xDdJ9f9NZ48f
        Kr8VdfSyfss0R+Ojj36fy10y8XV0rfJCc5mJAUYHtWccKt9yO72FVbHndvwk96ft29I+1H5k
        El75bcKWni7PGrbHhssURVh91CKX37D7XRonnsvrWfSM4V28bPvpyEstATtumd8IbrSZrPV0
        yu8dNS0fGsRdfWqU2Zbzz8p7fnd1nmuNjFvX/jjZRCWW4oxEQy3mouJEAHKmGr+FAwAA
X-CMS-MailID: 20220526201152eucas1p1e45adf35fb1f6bef57489983418906ee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220525214802eucas1p1edda2be0c03b9048c3712af8ad425345
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220525214802eucas1p1edda2be0c03b9048c3712af8ad425345
References: <20220524194756.1698351-1-zi.yan@sent.com>
        <CGME20220525214802eucas1p1edda2be0c03b9048c3712af8ad425345@eucas1p1.samsung.com>
        <9b31868d-cec2-121a-cd1c-008dd9880cca@samsung.com>
        <8C74B0BA-3C69-46EE-8C14-0CE6787D0B65@nvidia.com>
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26.05.2022 19:32, Zi Yan wrote:
> On 25 May 2022, at 17:48, Marek Szyprowski wrote:
>> On 24.05.2022 21:47, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> In isolate_single_pageblock() called by start_isolate_page_range(),
>>> there are some pageblock isolation issues causing a potential
>>> infinite loop when isolating a page range. This is reported by Qian Cai.
>>>
>>> 1. the pageblock was isolated by just changing pageblock migratetype
>>>      without checking unmovable pages. Calling set_migratetype_isolate() to
>>>      isolate pageblock properly.
>>> 2. an off-by-one error caused migrating pages unnecessarily, since the page
>>>      is not crossing pageblock boundary.
>>> 3. migrating a compound page across pageblock boundary then splitting the
>>>      free page later has a small race window that the free page might be
>>>      allocated again, so that the code will try again, causing an potential
>>>      infinite loop. Temporarily set the to-be-migrated page's pageblock to
>>>      MIGRATE_ISOLATE to prevent that and bail out early if no free page is
>>>      found after page migration.
>>>
>>> An additional fix to split_free_page() aims to avoid crashing in
>>> __free_one_page(). When the free page is split at the specified
>>> split_pfn_offset, free_page_order should check both the first bit of
>>> free_page_pfn and the last bit of split_pfn_offset and use the smaller one.
>>> For example, if free_page_pfn=0x10000, split_pfn_offset=0xc000,
>>> free_page_order should first be 0x8000 then 0x4000, instead of 0x4000 then
>>> 0x8000, which the original algorithm did.
>>>
>>> Fixes: b2c9e2fbba ("mm: make alloc_contig_range work at pageblock granularity")
>>> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> This patch landed in linux next-20220525 as commit 29a8af92b874 ("mm:
>> fix a potential infinite loop in start_isolate_page_range()").
>> Unfortunately it breaks all CMA allocations done by the DMA-mapping
>> framework. I've observed this on ARM 32bit and 64bit. In the logs I only
>> see messages like:
>>
>> cma: cma_alloc: linux,cma: alloc failed, req-size: 128 pages, ret: -16
>>
>> I will try to analyze it a bit more tomorrow, but it looks that
>> isolation always fails.
>>
> Hi Marek,
>
> Thanks for reporting the issue.
>
> Can you try the patch below to see if it fixes the issue?
>
> Basically, the bug introduced by this commit is that it does not consider
> the situation when a smaller than pageblock range is to be isolated,
> the set_migratetype_isolate() in the second isolate_single_pageblock()
> called by start_isolate_page_range() returns with a failure. Skipping isolating
> the pageblock which has been isolated by the first isolate_single_pageblock()
> solves the issue.
>
> The patch below also includes the fix for the free memory accounting issue.

This patch fixed the issue, thanks!

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


> diff --git a/mm/internal.h b/mm/internal.h
> index 64e61b032dac..c0f8fbe0445b 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -374,8 +374,8 @@ extern void *memmap_alloc(phys_addr_t size, phys_addr_t align,
>   			  phys_addr_t min_addr,
>   			  int nid, bool exact_nid);
>
> -void split_free_page(struct page *free_page,
> -				int order, unsigned long split_pfn_offset);
> +int split_free_page(struct page *free_page,
> +			unsigned int order, unsigned long split_pfn_offset);
>
>   #if defined CONFIG_COMPACTION || defined CONFIG_CMA
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index bc93a82e51e6..6f6e4649ac21 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1100,30 +1100,44 @@ static inline void __free_one_page(struct page *page,
>    * @order:		the order of the page
>    * @split_pfn_offset:	split offset within the page
>    *
> + * Return -ENOENT if the free page is changed, otherwise 0
> + *
>    * It is used when the free page crosses two pageblocks with different migratetypes
>    * at split_pfn_offset within the page. The split free page will be put into
>    * separate migratetype lists afterwards. Otherwise, the function achieves
>    * nothing.
>    */
> -void split_free_page(struct page *free_page,
> -				int order, unsigned long split_pfn_offset)
> +int split_free_page(struct page *free_page,
> +			unsigned int order, unsigned long split_pfn_offset)
>   {
>   	struct zone *zone = page_zone(free_page);
>   	unsigned long free_page_pfn = page_to_pfn(free_page);
>   	unsigned long pfn;
>   	unsigned long flags;
>   	int free_page_order;
> +	int mt;
> +	int ret = 0;
>
>   	if (split_pfn_offset == 0)
> -		return;
> +		return ret;
>
>   	spin_lock_irqsave(&zone->lock, flags);
> +
> +	if (!PageBuddy(free_page) || buddy_order(free_page) != order) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +
> +	mt = get_pageblock_migratetype(free_page);
> +	if (likely(!is_migrate_isolate(mt)))
> +		__mod_zone_freepage_state(zone, -(1UL << order), mt);
> +
>   	del_page_from_free_list(free_page, zone, order);
>   	for (pfn = free_page_pfn;
>   	     pfn < free_page_pfn + (1UL << order);) {
>   		int mt = get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
>
> -		free_page_order = min_t(int,
> +		free_page_order = min_t(unsigned int,
>   					pfn ? __ffs(pfn) : order,
>   					__fls(split_pfn_offset));
>   		__free_one_page(pfn_to_page(pfn), pfn, zone, free_page_order,
> @@ -1134,7 +1148,9 @@ void split_free_page(struct page *free_page,
>   		if (split_pfn_offset == 0)
>   			split_pfn_offset = (1UL << order) - (pfn - free_page_pfn);
>   	}
> +out:
>   	spin_unlock_irqrestore(&zone->lock, flags);
> +	return ret;
>   }
>   /*
>    * A bad page could be due to a number of fields. Instead of multiple branches,
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index c643c8420809..f539ccf7fb44 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -300,7 +300,7 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>    * the in-use page then splitting the free page.
>    */
>   static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
> -			gfp_t gfp_flags, bool isolate_before)
> +			gfp_t gfp_flags, bool isolate_before, bool skip_isolation)
>   {
>   	unsigned char saved_mt;
>   	unsigned long start_pfn;
> @@ -327,11 +327,16 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>   				      zone->zone_start_pfn);
>
>   	saved_mt = get_pageblock_migratetype(pfn_to_page(isolate_pageblock));
> -	ret = set_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt, flags,
> -			isolate_pageblock, isolate_pageblock + pageblock_nr_pages);
>
> -	if (ret)
> -		return ret;
> +	if (skip_isolation)
> +		VM_BUG_ON(!is_migrate_isolate(saved_mt));
> +	else {
> +		ret = set_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt, flags,
> +				isolate_pageblock, isolate_pageblock + pageblock_nr_pages);
> +
> +		if (ret)
> +			return ret;
> +	}
>
>   	/*
>   	 * Bail out early when the to-be-isolated pageblock does not form
> @@ -367,8 +372,11 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>   			int order = buddy_order(page);
>
>   			if (pfn + (1UL << order) > boundary_pfn)
> -				split_free_page(page, order, boundary_pfn - pfn);
> -			pfn += (1UL << order);
> +				/* free page changed before split, check it again */
> +				if (split_free_page(page, order, boundary_pfn - pfn))
> +				    continue;
> +
> +			pfn += 1UL << order;
>   			continue;
>   		}
>   		/*
> @@ -463,7 +471,8 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>   	return 0;
>   failed:
>   	/* restore the original migratetype */
> -	unset_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt);
> +	if (!skip_isolation)
> +		unset_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt);
>   	return -EBUSY;
>   }
>
> @@ -522,14 +531,18 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>   	unsigned long isolate_start = ALIGN_DOWN(start_pfn, pageblock_nr_pages);
>   	unsigned long isolate_end = ALIGN(end_pfn, pageblock_nr_pages);
>   	int ret;
> +	bool skip_isolation = false;
>
>   	/* isolate [isolate_start, isolate_start + pageblock_nr_pages) pageblock */
> -	ret = isolate_single_pageblock(isolate_start, flags, gfp_flags, false);
> +	ret = isolate_single_pageblock(isolate_start, flags, gfp_flags, false, skip_isolation);
>   	if (ret)
>   		return ret;
>
> +	if (isolate_start == isolate_end - pageblock_nr_pages)
> +		skip_isolation = true;
> +
>   	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock */
> -	ret = isolate_single_pageblock(isolate_end, flags, gfp_flags, true);
> +	ret = isolate_single_pageblock(isolate_end, flags, gfp_flags, true, skip_isolation);
>   	if (ret) {
>   		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
>   		return ret;
>
>
>
> --
> Best Regards,
> Yan, Zi

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

