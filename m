Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C99C4FC3FD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 20:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349124AbiDKSUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 14:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349104AbiDKSUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 14:20:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ABE1EC62
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 11:18:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 64B181F864;
        Mon, 11 Apr 2022 18:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649701110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9rwmjqY/Hr1f5h6HYYWQymxcjH9AvmzShmJ/szJdFG8=;
        b=rQDz49TQRDKjiHrsPtwvnSQfXrC45tSOp7KKgS2VJwBzntHE740J3ICE2oq0q1KK1PsP6n
        Rsgy6K9oBChXkkDQrqX7BdYQENTWjTcZQ3tMTq288ju4q8IkhHnVedqDZzNnCvUXfTyMcc
        I7eCrTyFazpcwQ62nauksU2lYEY0m5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649701110;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9rwmjqY/Hr1f5h6HYYWQymxcjH9AvmzShmJ/szJdFG8=;
        b=90vftVHB04f2xIV5eUZzqqFGsIDsAVhzcm+ncL7/U060hmQJpHXZ0zdh7p/6gw4Mr8YJJx
        pDhKisIL4ZC4OjCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5E6A13A93;
        Mon, 11 Apr 2022 18:18:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id g+NuN/VwVGIXIQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 11 Apr 2022 18:18:29 +0000
Message-ID: <bec1b401-fb2e-6672-d904-396402434890@suse.cz>
Date:   Mon, 11 Apr 2022 20:18:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
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
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org
References: <20220329160440.193848-1-david@redhat.com>
 <20220329160440.193848-5-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3 04/16] mm/rmap: split page_dup_rmap() into
 page_dup_file_rmap() and page_try_dup_anon_rmap()
In-Reply-To: <20220329160440.193848-5-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 18:04, David Hildenbrand wrote:
> ... and move the special check for pinned pages into
> page_try_dup_anon_rmap() to prepare for tracking exclusive anonymous
> pages via a new pageflag, clearing it only after making sure that there
> are no GUP pins on the anonymous page.
> 
> We really only care about pins on anonymous pages, because they are
> prone to getting replaced in the COW handler once mapped R/O. For !anon
> pages in cow-mappings (!VM_SHARED && VM_MAYWRITE) we shouldn't really
> care about that, at least not that I could come up with an example.
> 
> Let's drop the is_cow_mapping() check from page_needs_cow_for_dma(), as we
> know we're dealing with anonymous pages. Also, drop the handling of
> pinned pages from copy_huge_pud() and add a comment if ever supporting
> anonymous pages on the PUD level.
> 
> This is a preparation for tracking exclusivity of anonymous pages in
> the rmap code, and disallowing marking a page shared (-> failing to
> duplicate) if there are GUP pins on a page.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Nit:

> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -825,7 +825,8 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  		 */
>  		get_page(page);
>  		rss[mm_counter(page)]++;
> -		page_dup_rmap(page, false);
> +		/* Cannot fail as these pages cannot get pinned. */
> +		BUG_ON(page_try_dup_anon_rmap(page, false, src_vma));

Should we just call __page_dup_rmap() here? This is block for the condition
is_device_private_entry(), and page_try_dup_anon_rmap() can't return -EBUSY
for is_device_private_page().

>  
>  		/*
>  		 * We do not preserve soft-dirty information, because so
> @@ -921,18 +922,24 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>  	struct page *page;
>  
>  	page = vm_normal_page(src_vma, addr, pte);
> -	if (page && unlikely(page_needs_cow_for_dma(src_vma, page))) {
> +	if (page && PageAnon(page)) {
>  		/*
>  		 * If this page may have been pinned by the parent process,
>  		 * copy the page immediately for the child so that we'll always
>  		 * guarantee the pinned page won't be randomly replaced in the
>  		 * future.
>  		 */
> -		return copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
> -					 addr, rss, prealloc, page);
> +		get_page(page);
> +		if (unlikely(page_try_dup_anon_rmap(page, false, src_vma))) {
> +			/* Page maybe pinned, we have to copy. */
> +			put_page(page);
> +			return copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
> +						 addr, rss, prealloc, page);
> +		}
> +		rss[mm_counter(page)]++;
>  	} else if (page) {
>  		get_page(page);
> -		page_dup_rmap(page, false);
> +		page_dup_file_rmap(page, false);
>  		rss[mm_counter(page)]++;
>  	}
>  
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 3d60823afd2d..97de2fc17f34 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -234,7 +234,7 @@ static bool remove_migration_pte(struct folio *folio,
>  			if (folio_test_anon(folio))
>  				hugepage_add_anon_rmap(new, vma, pvmw.address);
>  			else
> -				page_dup_rmap(new, true);
> +				page_dup_file_rmap(new, true);
>  			set_huge_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
>  		} else
>  #endif

