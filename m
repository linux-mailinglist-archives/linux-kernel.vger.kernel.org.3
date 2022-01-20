Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCF849553B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 21:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377562AbiATUH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 15:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347187AbiATUHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 15:07:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EF1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 12:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B3+5396UaXvFEYhBocmsmHaWNgzX8iVJrkcpnR2FF40=; b=nx0iaBmPPuLI2/9GOonlnPUSEq
        EjWGaxtTNM6+8VbIeQAvX0LFJiPXBZbrZ1B4JFvGcNdcHTYt5wT0LE/lMp33cwXQrKfIbSj3E+UxZ
        Wx1HAtlu8CDzAp/1baDqEy+kggiFLdHMOWnD06RsHjYJeNBv+GZ1XynH0yF/Fnbp5yvbMDCPsHzp4
        eBbnl6Jf5HYMiPtqiyx/ztodvX2TN6qgtC80jf68vikKwyexUZoXlVV4K/n9ZGFvLTB8YKqIZM74N
        S0KuXfXftssDpaPGglmGRIwAKUz2baSxvDcU7OCWasjbcacAmFIaq8Ygnm4U1/EnPGDa8uIZI42Le
        xw7/ST2g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAdi9-00Eivm-3a; Thu, 20 Jan 2022 20:07:09 +0000
Date:   Thu, 20 Jan 2022 20:07:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        "zhangliang (AG)" <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
Message-ID: <YenA7Xzd2G2OYvqz@casper.infradead.org>
References: <a93988da-80fb-dd32-4717-a6a0bae9e4ee@huawei.com>
 <dc415c4a-63aa-19b0-0fbc-795989970f6d@redhat.com>
 <fb02087a-b102-c91e-ab65-fb02cc8ee0a2@huawei.com>
 <9cd7eee2-91fd-ddb8-e47d-e8585e5baa05@redhat.com>
 <b6df4f7f-c080-ad6c-d1ad-098115f016f3@huawei.com>
 <747ff31c-6c9e-df6c-f14d-c43aa1c77b4a@redhat.com>
 <C8734D0B-B855-4323-A7DF-2D96245951B2@gmail.com>
 <8931808d-db61-0f06-ceb3-f48a83b1f74c@redhat.com>
 <6225EAFF-B323-4DC5-AC4C-885B29ED7261@gmail.com>
 <9071d5a8-ed2d-5cf5-5526-43fe7dd377ec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9071d5a8-ed2d-5cf5-5526-43fe7dd377ec@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 08:55:12PM +0100, David Hildenbrand wrote:
> >>> David, does any of it regards the lru_cache_add() reference issue that I
> >>> mentioned? [1]

> +++ b/mm/memory.c
> @@ -3291,19 +3291,28 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>         if (PageAnon(vmf->page)) {
>                 struct page *page = vmf->page;
>  
> -               /* PageKsm() doesn't necessarily raise the page refcount */
> -               if (PageKsm(page) || page_count(page) != 1)
> +               /*
> +                * PageKsm() doesn't necessarily raise the page refcount.
> +                *
> +                * These checks are racy as long as we haven't locked the page;
> +                * they are a pure optimization to avoid trying to lock the page
> +                * and trying to free the swap cache when there is little hope
> +                * it will actually result in a refcount of 1.
> +                */
> +               if (PageKsm(page) || page_count(page) > 1 + PageSwapCache(page))
>                         goto copy;
>                 if (!trylock_page(page))
>                         goto copy;
> -               if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1) {
> +               if (PageSwapCache(page))
> +                       try_to_free_swap(page);
> +               if (PageKsm(page) || page_count(page) != 1) {
>                         unlock_page(page);
>                         goto copy;
>                 }
>                 /*
> -                * Ok, we've got the only map reference, and the only
> -                * page count reference, and the page is locked,
> -                * it's dark out, and we're wearing sunglasses. Hit it.
> +                * Ok, we've got the only page reference from our mapping
> +                * and the page is locked, it's dark out, and we're wearing
> +                * sunglasses. Hit it.
>                  */
>                 unlock_page(page);
>                 wp_page_reuse(vmf);
> 
> 
> I added some vmstats that monitor various paths. After one run of
> 	./forceswap 2 1000000 1
> I'm left with a rough delta (including some noise) of
> 	anon_wp_copy_count 1799
> 	anon_wp_copy_count_early 1
> 	anon_wp_copy_lock 983396
> 	anon_wp_reuse 0
> 
> The relevant part of your reproducer is
> 
> 	for (i = 0; i < nops; i++) {
> 		if (madvise((void *)p, PAGE_SIZE * npages, MADV_PAGEOUT)) {
> 			perror("madvise");
> 			exit(-1);
> 		}
> 
> 		for (j = 0; j < npages; j++) {
> 			c = p[j * PAGE_SIZE];
> 			c++;
> 			time -= rdtscp();
> 			p[j * PAGE_SIZE] = c;
> 			time += rdtscp();
> 		}
> 	}
> 
> For this specific reproducer at least, the page lock seems to be the thingy that prohibits
> reuse if I interpret the numbers correctly. We pass the initial page_count() check.
> 
> Haven't looked into the details, and I would be curious how that performs with actual
> workloads, if we can reproduce similar behavior.

I don't see how that patch addresses the lru issue.  Wouldn't we need
something like ...

	if (!PageLRU(page))
		lru_add_drain_all();

