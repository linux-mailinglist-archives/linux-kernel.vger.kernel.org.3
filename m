Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C38758D762
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 12:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241274AbiHIK0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 06:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiHIK0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 06:26:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7748F22B14
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 03:26:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F72DB80B7F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 10:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED389C433D6;
        Tue,  9 Aug 2022 10:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660040793;
        bh=mCCs/zYMdyZ+VwDvlaFQuS5p6AkvVRrlr2b5NUiT/bs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hvnV5A6GcMrjrpnBKmBxTEQKQHi6K70KLmT1GDYoz0Ga76dx/LKj5bpQmuOVSeFRS
         8ctR6wQeSNXEQGqhUVYuPaHvsZGIetuOGrbcIge8VeJSlJ6H4YiWW50MR4EV0jMUqD
         1TV6YO0Jw3p8tE5ZjK44KeEkx4lR3UOzZXo2JO4R+v9G+4yDFblrh4GP3bw6GOZBeb
         5hB7ZFACiw+WQr4SLTMFLD5+mViZTepCrsZaCTVUJCk8E4+mJLudacpmNeubRpTkMZ
         x+oQ+JhlpojFjxpFGt2fIWcpwtYRSf5yzdB6tUkVt3hLEGt/iJSqj505RkGKtP4nCM
         khOf+MW5wG25Q==
Message-ID: <8bbaabe4-d066-3b6e-f477-262289f4ec27@kernel.org>
Date:   Tue, 9 Aug 2022 12:26:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH] hugetlb: freeze allocated pages before creating hugetlb
 pages
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220808212836.111749-1-mike.kravetz@oracle.com>
From:   "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20220808212836.111749-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/22 23:28, Mike Kravetz wrote:
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

<snip>

> @@ -1918,6 +1918,7 @@ static struct page *alloc_buddy_huge_page(struct hstate *h,
>  	int order = huge_page_order(h);
>  	struct page *page;
>  	bool alloc_try_hard = true;
> +	bool retry = true;
>  
>  	/*
>  	 * By default we always try hard to allocate the page with
> @@ -1933,7 +1934,21 @@ static struct page *alloc_buddy_huge_page(struct hstate *h,
>  		gfp_mask |= __GFP_RETRY_MAYFAIL;
>  	if (nid == NUMA_NO_NODE)
>  		nid = numa_mem_id();
> +retry:
>  	page = __alloc_pages(gfp_mask, order, nid, nmask);
> +
> +	/* Freeze head page */
> +	if (!page_ref_freeze(page, 1)) {
> +		__free_pages(page, order);
> +		if (retry) {	/* retry once */
> +			retry = false;
> +			goto retry;
> +		}
> +		/* WOW!  twice in a row. */
> +		pr_warn("HugeTLB head page unexpected inflated ref count\n");
> +		page = NULL;

The previous approach of waiting and hoping the temporary refcount increase
will drop made sense to me, but yeah, what if it doesn't drop. So this
freeing and reallocating makes sense even if it's theoretically wasteful.
Should be moot anyway once we have the way to allocate frozen pages directly
from buddy.

> +	}
> +
>  	if (page)
>  		__count_vm_event(HTLB_BUDDY_PGALLOC);
>  	else

