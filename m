Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73FF58D214
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 04:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiHICs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 22:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiHICs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 22:48:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C19BDEA0
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 19:48:55 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M1y9g4ntxzjXkZ;
        Tue,  9 Aug 2022 10:45:43 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 9 Aug 2022 10:48:53 +0800
Subject: Re: [PATCH] hugetlb: freeze allocated pages before creating hugetlb
 pages
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220808212836.111749-1-mike.kravetz@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <119542cd-939f-3185-1d51-a177d4da1dff@huawei.com>
Date:   Tue, 9 Aug 2022 10:48:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220808212836.111749-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/9 5:28, Mike Kravetz wrote:
> When creating hugetlb pages, the hugetlb code must first allocate
> contiguous pages from a low level allocator such as buddy, cma or
> memblock.  The pages returned from these low level allocators are
> ref counted.  This creates potential issues with other code taking
> speculative references on these pages before they can be transformed to
> a hugetlb page.  This issue has been addressed with methods and code
> such as that provided in [1].
> 
> Recent discussions about vmemmap freeing [2] have indicated that it
> would be beneficial to freeze all sub pages, including the head page
> of pages returned from low level allocators before converting to a
> hugetlb page.  This helps avoid races if want to replace the page
> containing vmemmap for the head page.
> 
> There have been proposals to change at least the buddy allocator to
> return frozen pages as described at [3].  If such a change is made, it
> can be employed by the hugetlb code.  However, as mentioned above
> hugetlb uses several low level allocators so each would need to be
> modified to return frozen pages.  For now, we can manually freeze the
> returned pages.  This is done in two places:
> 1) alloc_buddy_huge_page, only the returned head page is ref counted.
>    We freeze the head page, retrying once in the VERY rare case where
>    there may be an inflated ref count.
> 2) prep_compound_gigantic_page, for gigantic pages the current code
>    freezes all pages except the head page.  New code will simply freeze
>    the head page as well.
> 
> In a few other places, code checks for inflated ref counts on newly
> allocated hugetlb pages.  With the modifications to freeze after
> allocating, this code can be removed.
> 
> After hugetlb pages are freshly allocated, they are often added to the
> hugetlb free lists.  Since these pages were previously ref counted, this
> was done via put_page() which would end up calling the hugetlb
> destructor: free_huge_page.  With changes to freeze pages, we simply
> call free_huge_page directly to add the pages to the free list.
> 
> In a few other places, freshly allocated hugetlb pages were immediately
> put into use, and the expectation was they were already ref counted.  In
> these cases, we must manually ref count the page.
> 
> [1] https://lore.kernel.org/linux-mm/20210622021423.154662-3-mike.kravetz@oracle.com/
> [2] https://lore.kernel.org/linux-mm/20220802180309.19340-1-joao.m.martins@oracle.com/
> [3] https://lore.kernel.org/linux-mm/20220531150611.1303156-1-willy@infradead.org/
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c | 97 +++++++++++++++++++---------------------------------
>  1 file changed, 35 insertions(+), 62 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 28516881a1b2..6b90d85d545b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1769,13 +1769,12 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
>  {
>  	int i, j;
>  	int nr_pages = 1 << order;
> -	struct page *p = page + 1;
> +	struct page *p = page;
>  
>  	/* we rely on prep_new_huge_page to set the destructor */
>  	set_compound_order(page, order);
> -	__ClearPageReserved(page);
>  	__SetPageHead(page);
> -	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
> +	for (i = 0; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
>  		/*
>  		 * For gigantic hugepages allocated through bootmem at
>  		 * boot, it's safer to be consistent with the not-gigantic
> @@ -1814,7 +1813,8 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
>  		} else {
>  			VM_BUG_ON_PAGE(page_count(p), p);
>  		}
> -		set_compound_head(p, page);
> +		if (i != 0)
> +			set_compound_head(p, page);

It seems we forget to unfreeze the head page in out_error path. If unexpected inflated ref count occurs,
the ref count of head page will become negative in free_gigantic_page?

Thanks for your patch, Mike. I hope this will help solve the races with memory failure. ;) And I will take
a more close review when I have enough time.

