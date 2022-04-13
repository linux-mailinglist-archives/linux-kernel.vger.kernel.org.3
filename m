Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB454FF1CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiDMI1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbiDMI1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:27:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE75832055
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:25:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6DF7B1F38D;
        Wed, 13 Apr 2022 08:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649838314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HdKDKj+n4FUzRh9JIKpSWp18OPIWOtswFRpKcTIEJ9I=;
        b=QdnpT+FQjm0lGbWs4ckB78zDIU7dMjIoogldUTquohHAdOx1gJvLXQ+ErGUjG/CssawzWl
        IKngXO+jWh8XAkjLVKTI/5NOFP881yQzTXl0njyt/0ZnTnOlsv3eKZQEeIfL5eeLnLxVZs
        Td14RebWjLnNnYTbRxWFcNCkFk1mg2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649838314;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HdKDKj+n4FUzRh9JIKpSWp18OPIWOtswFRpKcTIEJ9I=;
        b=rq61aqBQGn4tR/C1EI1ZBSplk9jdFngICXMP/A17Dpy44vk6smBxzyOyjFQ1r81vCiXTjJ
        qjnS7WexcFT953Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F1BE613AB8;
        Wed, 13 Apr 2022 08:25:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aEJdOumIVmLhfAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 13 Apr 2022 08:25:13 +0000
Message-ID: <84c0bcbb-5c8f-d3b2-2a8c-d68462d0bc04@suse.cz>
Date:   Wed, 13 Apr 2022 10:25:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Vlastimil Babka <vbabka@suse.cz>
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
 <20220329160440.193848-12-david@redhat.com>
Content-Language: en-US
Subject: Re: [PATCH v3 11/16] mm/page-flags: reuse PG_mappedtodisk as
 PG_anon_exclusive for PageAnon() pages
In-Reply-To: <20220329160440.193848-12-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 18:04, David Hildenbrand wrote:
> The basic question we would like to have a reliable and efficient answer
> to is: is this anonymous page exclusive to a single process or might it
> be shared? We need that information for ordinary/single pages, hugetlb
> pages, and possibly each subpage of a THP.
> 
> Introduce a way to mark an anonymous page as exclusive, with the
> ultimate goal of teaching our COW logic to not do "wrong COWs", whereby
> GUP pins lose consistency with the pages mapped into the page table,
> resulting in reported memory corruptions.
> 
> Most pageflags already have semantics for anonymous pages, however,
> PG_mappedtodisk should never apply to pages in the swapcache, so let's
> reuse that flag.
> 
> As PG_has_hwpoisoned also uses that flag on the second tail page of a
> compound page, convert it to PG_error instead, which is marked as
> PF_NO_TAIL, so never used for tail pages.
> 
> Use custom page flag modification functions such that we can do
> additional sanity checks. The semantics we'll put into some kernel doc
> in the future are:
> 
> "
>   PG_anon_exclusive is *usually* only expressive in combination with a
>   page table entry. Depending on the page table entry type it might
>   store the following information:
> 
>        Is what's mapped via this page table entry exclusive to the
>        single process and can be mapped writable without further
>        checks? If not, it might be shared and we might have to COW.
> 
>   For now, we only expect PTE-mapped THPs to make use of
>   PG_anon_exclusive in subpages. For other anonymous compound
>   folios (i.e., hugetlb), only the head page is logically mapped and
>   holds this information.
> 
>   For example, an exclusive, PMD-mapped THP only has PG_anon_exclusive
>   set on the head page. When replacing the PMD by a page table full
>   of PTEs, PG_anon_exclusive, if set on the head page, will be set on
>   all tail pages accordingly. Note that converting from a PTE-mapping
>   to a PMD mapping using the same compound page is currently not
>   possible and consequently doesn't require care.
> 
>   If GUP wants to take a reliable pin (FOLL_PIN) on an anonymous page,
>   it should only pin if the relevant PG_anon_bit is set. In that case,

					^ PG_anon_exclusive bit ?

>   the pin will be fully reliable and stay consistent with the pages
>   mapped into the page table, as the bit cannot get cleared (e.g., by
>   fork(), KSM) while the page is pinned. For anonymous pages that
>   are mapped R/W, PG_anon_exclusive can be assumed to always be set
>   because such pages cannot possibly be shared.
> 
>   The page table lock protecting the page table entry is the primary
>   synchronization mechanism for PG_anon_exclusive; GUP-fast that does
>   not take the PT lock needs special care when trying to clear the
>   flag.
> 
>   Page table entry types and PG_anon_exclusive:
>   * Present: PG_anon_exclusive applies.
>   * Swap: the information is lost. PG_anon_exclusive was cleared.
>   * Migration: the entry holds this information instead.
>                PG_anon_exclusive was cleared.
>   * Device private: PG_anon_exclusive applies.
>   * Device exclusive: PG_anon_exclusive applies.
>   * HW Poison: PG_anon_exclusive is stale and not changed.
> 
>   If the page may be pinned (FOLL_PIN), clearing PG_anon_exclusive is
>   not allowed and the flag will stick around until the page is freed
>   and folio->mapping is cleared.

Or also if it's unpinned?

> "
> 
> We won't be clearing PG_anon_exclusive on destructive unmapping (i.e.,
> zapping) of page table entries, page freeing code will handle that when
> also invalidate page->mapping to not indicate PageAnon() anymore.
> Letting information about exclusivity stick around will be an important
> property when adding sanity checks to unpinning code.
> 
> Note that we properly clear the flag in free_pages_prepare() via
> PAGE_FLAGS_CHECK_AT_PREP for each individual subpage of a compound page,
> so there is no need to manually clear the flag.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3663,6 +3663,17 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		goto out_nomap;
>  	}
>  
> +	/*
> +	 * PG_anon_exclusive reuses PG_mappedtodisk for anon pages. A swap pte
> +	 * must never point at an anonymous page in the swapcache that is
> +	 * PG_anon_exclusive. Sanity check that this holds and especially, that
> +	 * no filesystem set PG_mappedtodisk on a page in the swapcache. Sanity
> +	 * check after taking the PT lock and making sure that nobody
> +	 * concurrently faulted in this page and set PG_anon_exclusive.
> +	 */
> +	BUG_ON(!PageAnon(page) && PageMappedToDisk(page));
> +	BUG_ON(PageAnon(page) && PageAnonExclusive(page));
> +

Hmm, dunno why not VM_BUG_ON?

>  	/*
>  	 * Remove the swap entry and conditionally try to free up the swapcache.
>  	 * We're already holding a reference on the page but haven't mapped it
> diff --git a/mm/memremap.c b/mm/memremap.c
> index af0223605e69..4264f78299a8 100644
