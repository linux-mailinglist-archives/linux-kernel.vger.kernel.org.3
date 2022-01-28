Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439F849FA1B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 13:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244878AbiA1MxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 07:53:18 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44958 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiA1MxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 07:53:16 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F0B451F385;
        Fri, 28 Jan 2022 12:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643374396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=My8yUIslN3g83ByWIBUrZ3wkCDsy1wmwr/8wCba+DW0=;
        b=2uvxxewpgIYlCM2Y50+yYIfQscccjxuGkFd+mWNMCI/t2TOPdDBbkfVFORgh9ltV2Edjpy
        HJfLZOBk8yvhvfm9trHm5FtVVvXvIdl/jAppk6jT5bvQp9S/GenH5w42whEr1PKA8zVx/p
        MXydr6Kla31FEFhTQDXBUOhUx/RWdPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643374396;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=My8yUIslN3g83ByWIBUrZ3wkCDsy1wmwr/8wCba+DW0=;
        b=wBXKexbbo4poemZ1IAY7YMfO7uaeClm6X7OmEJUF9sdwkcth0nsw1rRlN72CyWtWE0Yg9Y
        DpK2+DcgfZNBeHCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 85F1813ABF;
        Fri, 28 Jan 2022 12:53:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zLP2Hzvn82H6awAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 28 Jan 2022 12:53:15 +0000
Message-ID: <595b8e80-96c0-dab6-5d13-652f0a0e40ec@suse.cz>
Date:   Fri, 28 Jan 2022 13:53:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>, Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>, linux-mm@kvack.org,
        Nadav Amit <nadav.amit@gmail.com>
References: <20220126095557.32392-1-david@redhat.com>
 <20220126095557.32392-2-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH RFC v2 1/9] mm: optimize do_wp_page() for exclusive pages
 in the swapcache
In-Reply-To: <20220126095557.32392-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 10:55, David Hildenbrand wrote:
> Liang Zhang reported [1] that the current COW logic in do_wp_page() is
> sub-optimal when it comes to swap+read fault+write fault of anonymous
> pages that have a single user, visible via a performance degradation in
> the redis benchmark. Something similar was previously reported [2] by
> Nadav with a simple reproducer.

Can we make the description more self-contained? I.e. describe that
sub-optimal COW means we copy when it's not necessary, and this can happen
if swap-out is followed by a swap-in for read and a then a write fault
(IIUC), because the swap cache reference increases page_count()...

> Let's optimize for pages that have been added to the swapcache but only
> have an exclusive owner. Try removing the swapcache reference if there is
> hope that we're the exclusive user.

Can we expect any downside for reclaim efficiency due to the more aggressive
removal from swapcache? Probably not, as we are doing the removal when the
page is about to get dirty, so we wouldn't be able to reuse any previously
swapped out content anyway. Maybe it's even beneficial?

> We will fail removing the swapcache reference in two scenarios:
> (1) There are additional swap entries referencing the page: copying
>     instead of reusing is the right thing to do.
> (2) The page is under writeback: theoretically we might be able to reuse
>     in some cases, however, we cannot remove the additional reference
>     and will have to copy.
> 
> Further, we might have additional references from the LRU pagevecs,
> which will force us to copy instead of being able to reuse. We'll try
> handling such references for some scenarios next. Concurrent writeback
> cannot be handled easily and we'll always have to copy.
> 
> While at it, remove the superfluous page_mapcount() check: it's
> implicitly covered by the page_count() for ordinary anon pages.
> 
> [1] https://lkml.kernel.org/r/20220113140318.11117-1-zhangliang5@huawei.com
> [2] https://lkml.kernel.org/r/0480D692-D9B2-429A-9A88-9BBA1331AC3A@gmail.com
> 
> Reported-by: Liang Zhang <zhangliang5@huawei.com>
> Reported-by: Nadav Amit <nadav.amit@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/memory.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index c125c4969913..bcd3b7c50891 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3291,19 +3291,27 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  	if (PageAnon(vmf->page)) {
>  		struct page *page = vmf->page;
>  
> -		/* PageKsm() doesn't necessarily raise the page refcount */
> -		if (PageKsm(page) || page_count(page) != 1)
> +		/*
> +		 * We have to verify under page lock: these early checks are
> +		 * just an optimization to avoid locking the page and freeing
> +		 * the swapcache if there is little hope that we can reuse.
> +		 *
> +		 * PageKsm() doesn't necessarily raise the page refcount.
> +		 */
> +		if (PageKsm(page) || page_count(page) > 1 + PageSwapCache(page))
>  			goto copy;
>  		if (!trylock_page(page))
>  			goto copy;
> -		if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1) {
> +		if (PageSwapCache(page))
> +			try_to_free_swap(page);
> +		if (PageKsm(page) || page_count(page) != 1) {
>  			unlock_page(page);
>  			goto copy;
>  		}
>  		/*
> -		 * Ok, we've got the only map reference, and the only
> -		 * page count reference, and the page is locked,
> -		 * it's dark out, and we're wearing sunglasses. Hit it.
> +		 * Ok, we've got the only page reference from our mapping
> +		 * and the page is locked, it's dark out, and we're wearing
> +		 * sunglasses. Hit it.
>  		 */
>  		unlock_page(page);
>  		wp_page_reuse(vmf);

