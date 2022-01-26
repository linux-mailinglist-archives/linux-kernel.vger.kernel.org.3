Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1552C49CC5A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242159AbiAZOb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbiAZOb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:31:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68183C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 06:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A0lR3wn3wIyf0krDuzNxicTwLPZDa2yhYaQ9xwjMXyQ=; b=RB2/M2k61CUNlQY4YP/wdUIkAc
        q2UGv/x3EB7O1u2GOU12SiCDcGhA3HqsJRjGRDfYNMAdrvzQjJLTOuHrkNLiKNAYdrzI3hLFdeQSX
        +IESe3EvM55hHxkeD/DhWuafALQpPsgHqKjWALqGBOVsFsds6zXguSmIXB9ozNCnYuzrTQJC/vy2A
        pmp7Ida06WBGQjjEhLzZOJ6wXfhnpXPSPm3/IWxCYPrgjF1IqxFlAQFGXGhTM6Cs+KFN8tPNhgw3w
        SuF0+aCKJe3Qic7b7MMgQ0mxiIO+yRnDS2dWKMH1vlWvHQwIG59Q2mUKErELjDjnpjP/xSYMLocL5
        5Sy7y4/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCjKV-0047hn-Az; Wed, 26 Jan 2022 14:31:23 +0000
Date:   Wed, 26 Jan 2022 14:31:23 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>, linux-mm@kvack.org
Subject: Re: [PATCH RFC v2 2/9] mm: optimize do_wp_page() for fresh pages in
 local LRU pagevecs
Message-ID: <YfFbOypqMjkeNA3q@casper.infradead.org>
References: <20220126095557.32392-1-david@redhat.com>
 <20220126095557.32392-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126095557.32392-3-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 10:55:50AM +0100, David Hildenbrand wrote:
> diff --git a/mm/memory.c b/mm/memory.c
> index bcd3b7c50891..61d67ceef734 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3298,7 +3298,17 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  		 *
>  		 * PageKsm() doesn't necessarily raise the page refcount.
>  		 */
> -		if (PageKsm(page) || page_count(page) > 1 + PageSwapCache(page))
> +		if (PageKsm(page))
> +			goto copy;
> +		if (page_count(page) > 1 + PageSwapCache(page) + !PageLRU(page))
> +			goto copy;
> +		if (!PageLRU(page))
> +			/*
> +			 * Note: We cannot easily detect+handle references from
> +			 * remote LRU pagevecs or references to PageLRU() pages.
> +			 */
> +			lru_add_drain();
> +		if (page_count(page) > 1 + PageSwapCache(page))
>  			goto copy;

I worry we're starting to get too accurate here.  How about:

		if (PageKsm(page) || page_count(page) > 3)
			goto copy;
		if (!PageLRU(page))
			lru_add_drain();
		if (!trylock_page(page))
			goto copy;
...

>  		if (!trylock_page(page))
>  			goto copy;
> -- 
> 2.34.1
> 
