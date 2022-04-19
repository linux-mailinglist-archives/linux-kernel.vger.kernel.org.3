Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A645076B5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353689AbiDSRnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349765AbiDSRnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:43:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBB91D33A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:40:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EF817210FD;
        Tue, 19 Apr 2022 17:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650390051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NPmQFOC09HGnA6JA0olfRcv8MOi5ek3og/OWW6F6GSg=;
        b=SfAiQHmZppRAszAHrKvDRwVpZ+ePMmhKpRztXXqApXTnNXFRdT/TYdJur1dI7QxrtuuBGP
        B03+Xf8S/RdFNQ1J98tKXvGuSYrcrpYHEscUAAoiZtt7ntYOiYpTuRKTp5JRGwAu8vcSdQ
        yFiP2/ySqmJx46uAiqyeXxUGAso2i18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650390051;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NPmQFOC09HGnA6JA0olfRcv8MOi5ek3og/OWW6F6GSg=;
        b=EoFq89jDHw1SFNtDvGzuCsy0aiuGzdtUGPORWrF14iEe5QZlB/qK0RiaG9ywEAXDLLo1nP
        DVnh0toZxYdHgLAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 846D2139BE;
        Tue, 19 Apr 2022 17:40:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T11tHyL0XmLDbQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 19 Apr 2022 17:40:50 +0000
Message-ID: <be2c1ad4-1557-677e-dfd8-2089c98fe85d@suse.cz>
Date:   Tue, 19 Apr 2022 19:40:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 16/16] mm/gup: sanity-check with CONFIG_DEBUG_VM that
 anonymous pages are exclusive when (un)pinning
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
 <20220329160440.193848-17-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220329160440.193848-17-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 18:04, David Hildenbrand wrote:
> Let's verify when (un)pinning anonymous pages that we always deal with
> exclusive anonymous pages, which guarantees that we'll have a reliable
> PIN, meaning that we cannot end up with the GUP pin being inconsistent
> with he pages mapped into the page tables due to a COW triggered
> by a write fault.
> 
> When pinning pages, after conditionally triggering GUP unsharing of
> possibly shared anonymous pages, we should always only see exclusive
> anonymous pages. Note that anonymous pages that are mapped writable
> must be marked exclusive, otherwise we'd have a BUG.
> 
> When pinning during ordinary GUP, simply add a check after our
> conditional GUP-triggered unsharing checks. As we know exactly how the
> page is mapped, we know exactly in which page we have to check for
> PageAnonExclusive().
> 
> When pinning via GUP-fast we have to be careful, because we can race with
> fork(): verify only after we made sure via the seqcount that we didn't
> race with concurrent fork() that we didn't end up pinning a possibly
> shared anonymous page.
> 
> Similarly, when unpinning, verify that the pages are still marked as
> exclusive: otherwise something turned the pages possibly shared, which
> can result in random memory corruptions, which we really want to catch.
> 
> With only the pinned pages at hand and not the actual page table entries
> we have to be a bit careful: hugetlb pages are always mapped via a
> single logical page table entry referencing the head page and
> PG_anon_exclusive of the head page applies. Anon THP are a bit more
> complicated, because we might have obtained the page reference either via
> a PMD or a PTE -- depending on the mapping type we either have to check
> PageAnonExclusive of the head page (PMD-mapped THP) or the tail page
> (PTE-mapped THP) applies: as we don't know and to make our life easier,
> check that either is set.
> 
> Take care to not verify in case we're unpinning during GUP-fast because
> we detected concurrent fork(): we might stumble over an anonymous page
> that is now shared.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Nits:

> @@ -510,6 +563,10 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>  		page = ERR_PTR(-EMLINK);
>  		goto out;
>  	}
> +
> +	VM_BUG_ON((flags & FOLL_PIN) && PageAnon(page) &&
> +		  !PageAnonExclusive(page));

Do we rather want VM_BUG_ON_PAGE? Also for the same tests in mm/huge*.c below.

> +
>  	/* try_grab_page() does nothing unless FOLL_GET or FOLL_PIN is set. */
>  	if (unlikely(!try_grab_page(page, flags))) {
>  		page = ERR_PTR(-ENOMEM);
> @@ -2744,8 +2801,10 @@ static unsigned long lockless_pages_from_mm(unsigned long start,
>  	 */
>  	if (gup_flags & FOLL_PIN) {
>  		if (read_seqcount_retry(&current->mm->write_protect_seq, seq)) {
> -			unpin_user_pages(pages, nr_pinned);
> +			unpin_user_pages_lockless(pages, nr_pinned);
>  			return 0;
> +		} else {
> +			sanity_check_pinned_pages(pages, nr_pinned);
>  		}
>  	}
>  	return nr_pinned;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2dc820e8c873..b32774f289d6 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1392,6 +1392,9 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
>  	if (!pmd_write(*pmd) && gup_must_unshare(flags, page))
>  		return ERR_PTR(-EMLINK);
>  
> +	VM_BUG_ON((flags & FOLL_PIN) && PageAnon(page) &&
> +		  !PageAnonExclusive(page));
> +
>  	if (!try_grab_page(page, flags))
>  		return ERR_PTR(-ENOMEM);
>  
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 21f2ec446117..48740e6c3476 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6097,6 +6097,9 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  		pfn_offset = (vaddr & ~huge_page_mask(h)) >> PAGE_SHIFT;
>  		page = pte_page(huge_ptep_get(pte));
>  
> +		VM_BUG_ON((flags & FOLL_PIN) && PageAnon(page) &&
> +			  !PageAnonExclusive(page));
> +
>  		/*
>  		 * If subpage information not requested, update counters
>  		 * and skip the same_page loop below.

