Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543B45345FE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 23:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242129AbiEYVsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 17:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbiEYVsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 17:48:14 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED2FAF313
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 14:48:09 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220525214804euoutp018161aeba48817aece646ba6e2bd2b1dd~yd2PiRzuV2880528805euoutp01C
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 21:48:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220525214804euoutp018161aeba48817aece646ba6e2bd2b1dd~yd2PiRzuV2880528805euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653515284;
        bh=ecox37O3khF7Vnj4ROPf9Uy8P78JKAjPaK3FkmFjRs4=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=ANzLJiX3MD9xQcSTsYzXkWc/BJ5XFBdO/G8R+CNTSU+KY7OzpOfCKOsrztgh/hoRW
         eCrs+HBWotGp5yoJ5Z3e0SCx1hwjT/WouhG6g9iRRvVPoeYol9bm8CFhPqKKQJG/Ty
         9ElZ5SpMBQke0HvSuuXNYdmHamnsfIV6IM+iBYf0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220525214803eucas1p2784dd6c6812a348ad9c42bf3d4aec87a~yd2O66Cbz1762017620eucas1p2G;
        Wed, 25 May 2022 21:48:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C6.25.09887.314AE826; Wed, 25
        May 2022 22:48:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220525214802eucas1p1edda2be0c03b9048c3712af8ad425345~yd2NqN4rB1851518515eucas1p1g;
        Wed, 25 May 2022 21:48:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220525214802eusmtrp19441dc37c8ea4447e31afcfef72def91~yd2NpX5hg1452514525eusmtrp1P;
        Wed, 25 May 2022 21:48:02 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-ce-628ea4132903
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B0.21.09522.114AE826; Wed, 25
        May 2022 22:48:01 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220525214801eusmtip12a83cf06ddf4982112f5fe5f5f152b86~yd2M8-1YI3195831958eusmtip1T;
        Wed, 25 May 2022 21:48:01 +0000 (GMT)
Message-ID: <9b31868d-cec2-121a-cd1c-008dd9880cca@samsung.com>
Date:   Wed, 25 May 2022 23:48:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH] mm: fix a potential infinite loop in
 start_isolate_page_range().
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, Qian Cai <quic_qiancai@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220524194756.1698351-1-zi.yan@sent.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7djPc7rCS/qSDOb3CVrMWb+GzeLOpOfs
        Fl/X/2K2uLxrDpvFvTX/WS12LN3HZHFmWpHF91cHmCwWHF7HaHFk/XYmi9mNfYwWy8/OY7OY
        ffQeuwOvx9eb55g8ds66y+6xaVUnm8emT5PYPU7M+M3iMfnGckaP3uZ3bB4T99R5vN93lc3j
        zIIj7B6bT1d7bP1l5/F5k1wAbxSXTUpqTmZZapG+XQJXxsP2xYwF750qulpaWRoYJ5p0MXJy
        SAiYSCzd/Z+1i5GLQ0hgBaPEsn1noZwvjBJn2m6xQDifGSUmTNzBDtPytP8wG0RiOaPEvQOb
        oVo+Mkos/vaJEaSKV8BO4uLy70BVHBwsAqoS0xZFQIQFJU7OfMICYosKJEnM39bKCmILC4RL
        XN/aywxiMwuIS9x6Mp8JZKaIwEpGiTUL28G2MQtsYZKY9OsWWDebgKFE19suNhCbU8Bc4uGn
        CSwQ3fIS29/OYQZpkBDYzSnxqGUuE8gVEgIuEgcOFUO8ICzx6vgWqHdkJE5P7mGBKMmX+DvD
        GCJcIXHt9RpmCNta4s65X2C/MAtoSqzfpQ8RdpTYs/w81HA+iRtvBSEO4JOYtG06M0SYV6Kj
        TQiiWk1i1vF1cDsPXrjEPIFRaRZSoMxC8vwsJK/MQti7gJFlFaN4amlxbnpqsVFearlecWJu
        cWleul5yfu4mRmASPP3v+JcdjMtffdQ7xMjEwXiIUYKDWUmE98LT3iQh3pTEyqrUovz4otKc
        1OJDjNIcLErivMmZGxKFBNITS1KzU1MLUotgskwcnFINTEUdHVpmB5v7l2klemvFiE6ovN6S
        9ytoOeubXpElMvqXL3SFneNq95RX3CzZ0r+V4cuyJ8JTs3iXHnvct6mR8e8O9i+2Las3pQdY
        rg5YGr/B/WZq8DPpAwee6oiL3wh5uzjNokxNU1ncauW2RjZJf8GzbJr338XuV5AMtvVTy576
        oq5I/v455WtPLdxtA3u29DgUc3w8G7Lya+C1S89uZVq0B6mLvefWejzh7QSVaH2n3taVrxk7
        C5/HHOgXvCAsN+uKCRe39aw2NaWIAIlQRk1NNR3G6BPve8QWrOrz3Ppo+x7DPeHP37PdrqtP
        rpPwLmi4ufqG2I//+XUGBrf3p9RpVL6K2iUQErOtoVmJpTgj0VCLuag4EQA58trn8QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsVy+t/xu7qCS/qSDFY2WVrMWb+GzeLOpOfs
        Fl/X/2K2uLxrDpvFvTX/WS12LN3HZHFmWpHF91cHmCwWHF7HaHFk/XYmi9mNfYwWy8/OY7OY
        ffQeuwOvx9eb55g8ds66y+6xaVUnm8emT5PYPU7M+M3iMfnGckaP3uZ3bB4T99R5vN93lc3j
        zIIj7B6bT1d7bP1l5/F5k1wAb5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGp
        kr6dTUpqTmZZapG+XYJexsP2xYwF750qulpaWRoYJ5p0MXJySAiYSDztP8zWxcjFISSwlFHi
        yuRJbBAJGYmT0xpYIWxhiT/XuqCK3jNKvN+/jxEkwStgJ3Fx+XegBAcHi4CqxLRFERBhQYmT
        M5+wgNiiAkkS8/auBisXFgiXuL61lxnEZhYQl7j1ZD4TyEwRgZWMEi0vfkIltjFJPP2mAmIL
        CZhJtG1tBjuITcBQouttF5jNKWAu8fDTBBaIejOJrq1djBC2vMT2t3OYJzAKzUJyxywk+2Yh
        aZmFpGUBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwMjfduzn5h2M81591DvEyMTBeIhR
        goNZSYT3wtPeJCHelMTKqtSi/Pii0pzU4kOMpsCwmMgsJZqcD0w9eSXxhmYGpoYmZpYGppZm
        xkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFINTBFiIhmzDylbT70be/HOtHWSd9jlQvyiKiLm
        Chb1fr1bmnXyYdGqGU7fJax+ukm0fFpr0Zo690H00oUnrK4U5hUbR7qzrN7xcVVIjhSrCe/D
        9vMbOJ2ydJOauOZP36DVXuSXb7SWcapc9rvbk7d5Vmdxs224XLBS++j9bXLz1ZcblNyPXGz9
        /FJ8wq/Y+R8EhMJm+q7XjjD+c7um9sP8yLx6rbxzvvUHVTkflfxy+cvy+v1VwUsdcjd042wZ
        Ws7s9/t571SG/6Vt0wXu+E1d1J0fp+NZ9Fjcg2v3esPdZ9N67v1Y94vX336bZItvJPvVyVVr
        A77W51dcD1riW8yitqlezqpL4nL0jVfhHB7sSizFGYmGWsxFxYkA6y7LDYUDAAA=
X-CMS-MailID: 20220525214802eucas1p1edda2be0c03b9048c3712af8ad425345
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220525214802eucas1p1edda2be0c03b9048c3712af8ad425345
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220525214802eucas1p1edda2be0c03b9048c3712af8ad425345
References: <20220524194756.1698351-1-zi.yan@sent.com>
        <CGME20220525214802eucas1p1edda2be0c03b9048c3712af8ad425345@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.05.2022 21:47, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
>
> In isolate_single_pageblock() called by start_isolate_page_range(),
> there are some pageblock isolation issues causing a potential
> infinite loop when isolating a page range. This is reported by Qian Cai.
>
> 1. the pageblock was isolated by just changing pageblock migratetype
>     without checking unmovable pages. Calling set_migratetype_isolate() to
>     isolate pageblock properly.
> 2. an off-by-one error caused migrating pages unnecessarily, since the page
>     is not crossing pageblock boundary.
> 3. migrating a compound page across pageblock boundary then splitting the
>     free page later has a small race window that the free page might be
>     allocated again, so that the code will try again, causing an potential
>     infinite loop. Temporarily set the to-be-migrated page's pageblock to
>     MIGRATE_ISOLATE to prevent that and bail out early if no free page is
>     found after page migration.
>
> An additional fix to split_free_page() aims to avoid crashing in
> __free_one_page(). When the free page is split at the specified
> split_pfn_offset, free_page_order should check both the first bit of
> free_page_pfn and the last bit of split_pfn_offset and use the smaller one.
> For example, if free_page_pfn=0x10000, split_pfn_offset=0xc000,
> free_page_order should first be 0x8000 then 0x4000, instead of 0x4000 then
> 0x8000, which the original algorithm did.
>
> Fixes: b2c9e2fbba ("mm: make alloc_contig_range work at pageblock granularity")
> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>

This patch landed in linux next-20220525 as commit 29a8af92b874 ("mm: 
fix a potential infinite loop in start_isolate_page_range()"). 
Unfortunately it breaks all CMA allocations done by the DMA-mapping 
framework. I've observed this on ARM 32bit and 64bit. In the logs I only 
see messages like:

cma: cma_alloc: linux,cma: alloc failed, req-size: 128 pages, ret: -16

I will try to analyze it a bit more tomorrow, but it looks that 
isolation always fails.

> ---
>   mm/page_alloc.c     |  5 ++++-
>   mm/page_isolation.c | 52 ++++++++++++++++++++++++++++++++++-----------
>   2 files changed, 44 insertions(+), 13 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 267599dd9706..6eec0211e0be 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1114,13 +1114,16 @@ void split_free_page(struct page *free_page,
>   	unsigned long flags;
>   	int free_page_order;
>   
> +	if (split_pfn_offset == 0)
> +		return;
> +
>   	spin_lock_irqsave(&zone->lock, flags);
>   	del_page_from_free_list(free_page, zone, order);
>   	for (pfn = free_page_pfn;
>   	     pfn < free_page_pfn + (1UL << order);) {
>   		int mt = get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
>   
> -		free_page_order = ffs(split_pfn_offset) - 1;
> +		free_page_order = min(pfn ? __ffs(pfn) : order, __fls(split_pfn_offset));
>   		__free_one_page(pfn_to_page(pfn), pfn, zone, free_page_order,
>   				mt, FPI_NONE);
>   		pfn += 1UL << free_page_order;
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index b3f074d1682e..c643c8420809 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -283,6 +283,7 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>    * isolate_single_pageblock() -- tries to isolate a pageblock that might be
>    * within a free or in-use page.
>    * @boundary_pfn:		pageblock-aligned pfn that a page might cross
> + * @flags:			isolation flags
>    * @gfp_flags:			GFP flags used for migrating pages
>    * @isolate_before:	isolate the pageblock before the boundary_pfn
>    *
> @@ -298,14 +299,15 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>    * either. The function handles this by splitting the free page or migrating
>    * the in-use page then splitting the free page.
>    */
> -static int isolate_single_pageblock(unsigned long boundary_pfn, gfp_t gfp_flags,
> -			bool isolate_before)
> +static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
> +			gfp_t gfp_flags, bool isolate_before)
>   {
>   	unsigned char saved_mt;
>   	unsigned long start_pfn;
>   	unsigned long isolate_pageblock;
>   	unsigned long pfn;
>   	struct zone *zone;
> +	int ret;
>   
>   	VM_BUG_ON(!IS_ALIGNED(boundary_pfn, pageblock_nr_pages));
>   
> @@ -325,7 +327,11 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, gfp_t gfp_flags,
>   				      zone->zone_start_pfn);
>   
>   	saved_mt = get_pageblock_migratetype(pfn_to_page(isolate_pageblock));
> -	set_pageblock_migratetype(pfn_to_page(isolate_pageblock), MIGRATE_ISOLATE);
> +	ret = set_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt, flags,
> +			isolate_pageblock, isolate_pageblock + pageblock_nr_pages);
> +
> +	if (ret)
> +		return ret;
>   
>   	/*
>   	 * Bail out early when the to-be-isolated pageblock does not form
> @@ -374,7 +380,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, gfp_t gfp_flags,
>   			struct page *head = compound_head(page);
>   			unsigned long head_pfn = page_to_pfn(head);
>   
> -			if (head_pfn + nr_pages < boundary_pfn) {
> +			if (head_pfn + nr_pages <= boundary_pfn) {
>   				pfn = head_pfn + nr_pages;
>   				continue;
>   			}
> @@ -386,7 +392,8 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, gfp_t gfp_flags,
>   			if (PageHuge(page) || PageLRU(page) || __PageMovable(page)) {
>   				int order;
>   				unsigned long outer_pfn;
> -				int ret;
> +				int page_mt = get_pageblock_migratetype(page);
> +				bool isolate_page = !is_migrate_isolate_page(page);
>   				struct compact_control cc = {
>   					.nr_migratepages = 0,
>   					.order = -1,
> @@ -399,9 +406,31 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, gfp_t gfp_flags,
>   				};
>   				INIT_LIST_HEAD(&cc.migratepages);
>   
> +				/*
> +				 * XXX: mark the page as MIGRATE_ISOLATE so that
> +				 * no one else can grab the freed page after migration.
> +				 * Ideally, the page should be freed as two separate
> +				 * pages to be added into separate migratetype free
> +				 * lists.
> +				 */
> +				if (isolate_page) {
> +					ret = set_migratetype_isolate(page, page_mt,
> +						flags, head_pfn, head_pfn + nr_pages);
> +					if (ret)
> +						goto failed;
> +				}
> +
>   				ret = __alloc_contig_migrate_range(&cc, head_pfn,
>   							head_pfn + nr_pages);
>   
> +				/*
> +				 * restore the page's migratetype so that it can
> +				 * be split into separate migratetype free lists
> +				 * later.
> +				 */
> +				if (isolate_page)
> +					unset_migratetype_isolate(page, page_mt);
> +
>   				if (ret)
>   					goto failed;
>   				/*
> @@ -417,10 +446,9 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, gfp_t gfp_flags,
>   				order = 0;
>   				outer_pfn = pfn;
>   				while (!PageBuddy(pfn_to_page(outer_pfn))) {
> -					if (++order >= MAX_ORDER) {
> -						outer_pfn = pfn;
> -						break;
> -					}
> +					/* stop if we cannot find the free page */
> +					if (++order >= MAX_ORDER)
> +						goto failed;
>   					outer_pfn &= ~0UL << order;
>   				}
>   				pfn = outer_pfn;
> @@ -435,7 +463,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, gfp_t gfp_flags,
>   	return 0;
>   failed:
>   	/* restore the original migratetype */
> -	set_pageblock_migratetype(pfn_to_page(isolate_pageblock), saved_mt);
> +	unset_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt);
>   	return -EBUSY;
>   }
>   
> @@ -496,12 +524,12 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>   	int ret;
>   
>   	/* isolate [isolate_start, isolate_start + pageblock_nr_pages) pageblock */
> -	ret = isolate_single_pageblock(isolate_start, gfp_flags, false);
> +	ret = isolate_single_pageblock(isolate_start, flags, gfp_flags, false);
>   	if (ret)
>   		return ret;
>   
>   	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock */
> -	ret = isolate_single_pageblock(isolate_end, gfp_flags, true);
> +	ret = isolate_single_pageblock(isolate_end, flags, gfp_flags, true);
>   	if (ret) {
>   		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
>   		return ret;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

