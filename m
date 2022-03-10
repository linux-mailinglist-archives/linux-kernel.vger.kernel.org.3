Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290F54D44CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240968AbiCJKin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiCJKik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:38:40 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE52FD3D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:37:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8CF111F441;
        Thu, 10 Mar 2022 10:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646908657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P113h4crLXMl5tXV6V95ni0R4d/EjRojkyoRVUPcGwM=;
        b=m/Xn0fGKRlUXmyJ8GWh3DhNeIbKxtp8JxgRvV2aqY8oObrIIinZiza1upbjwLDIx6QqRgQ
        S6bVYc0BelHCqGIkWnuZlTbfjfyuNdFcOKnYEBG+C8rkEjzAVvYzYfG4UyrzYGZwH44JP1
        REWKoLKWA9jpDTpcc4S/mvtOSNz/VIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646908657;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P113h4crLXMl5tXV6V95ni0R4d/EjRojkyoRVUPcGwM=;
        b=/smlhImydRWpe5xsDfrS1beZ/1aietQl26wM9s+cUwPgmh3Szl93H5W4w00E1rbfp7T2Ff
        nfaAwgKEszyZ+SBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22CFA13A3D;
        Thu, 10 Mar 2022 10:37:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2afjB/HUKWK6dAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 10 Mar 2022 10:37:37 +0000
Message-ID: <e7b3070b-e1d8-618f-93ad-eb9d8b148513@suse.cz>
Date:   Thu, 10 Mar 2022 11:37:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 6/9] mm/khugepaged: remove reuse_swap_page() usage
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
        Liang Zhang <zhangliang5@huawei.com>, linux-mm@kvack.org
References: <20220131162940.210846-1-david@redhat.com>
 <20220131162940.210846-7-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220131162940.210846-7-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/22 17:29, David Hildenbrand wrote:
> reuse_swap_page() currently indicates if we can write to an anon page
> without COW. A COW is required if the page is shared by multiple
> processes (either already mapped or via swap entries) or if there is
> concurrent writeback that cannot tolerate concurrent page modifications.
> 
> However, in the context of khugepaged we're not actually going to write
> to a read-only mapped page, we'll copy the page content to our newly
> allocated THP and map that THP writable. All we have to make sure
> is that the read-only mapped page we're about to copy won't get reused
> by another process sharing the page, otherwise, page content would
> get modified. But that is already guaranteed via multiple mechanisms
> (e.g., holding a reference, holding the page lock, removing the rmap after
>  copying the page).
> 
> The swapcache handling was introduced in commit 10359213d05a ("mm:
> incorporate read-only pages into transparent huge pages") and it sounds
> like it merely wanted to mimic what do_swap_page() would do when trying
> to map a page obtained via the swapcache writable.
> 
> As that logic is unnecessary, let's just remove it, removing the last
> user of reuse_swap_page().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/trace/events/huge_memory.h |  1 -
>  mm/khugepaged.c                    | 11 -----------
>  2 files changed, 12 deletions(-)
> 
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> index 4fdb14a81108..d651f3437367 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -29,7 +29,6 @@
>  	EM( SCAN_VMA_NULL,		"vma_null")			\
>  	EM( SCAN_VMA_CHECK,		"vma_check_failed")		\
>  	EM( SCAN_ADDRESS_RANGE,		"not_suitable_address_range")	\
> -	EM( SCAN_SWAP_CACHE_PAGE,	"page_swap_cache")		\
>  	EM( SCAN_DEL_PAGE_LRU,		"could_not_delete_page_from_lru")\
>  	EM( SCAN_ALLOC_HUGE_PAGE_FAIL,	"alloc_huge_page_failed")	\
>  	EM( SCAN_CGROUP_CHARGE_FAIL,	"ccgroup_charge_failed")	\
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 35f14d0a00a6..9da9325ab4d4 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -45,7 +45,6 @@ enum scan_result {
>  	SCAN_VMA_NULL,
>  	SCAN_VMA_CHECK,
>  	SCAN_ADDRESS_RANGE,
> -	SCAN_SWAP_CACHE_PAGE,
>  	SCAN_DEL_PAGE_LRU,
>  	SCAN_ALLOC_HUGE_PAGE_FAIL,
>  	SCAN_CGROUP_CHARGE_FAIL,
> @@ -682,16 +681,6 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>  			result = SCAN_PAGE_COUNT;
>  			goto out;
>  		}
> -		if (!pte_write(pteval) && PageSwapCache(page) &&
> -				!reuse_swap_page(page)) {
> -			/*
> -			 * Page is in the swap cache and cannot be re-used.
> -			 * It cannot be collapsed into a THP.
> -			 */
> -			unlock_page(page);
> -			result = SCAN_SWAP_CACHE_PAGE;
> -			goto out;
> -		}
>  
>  		/*
>  		 * Isolate the page to avoid collapsing an hugepage

