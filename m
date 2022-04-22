Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B28750B0EE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444581AbiDVG5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444575AbiDVG5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:57:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281AE50E31
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:54:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AB1F21F388;
        Fri, 22 Apr 2022 06:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650610447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=njRBOw0x/peGiclxIHvetS0u28ego9jjTT3f0MM6XcM=;
        b=ga+Mx9Pg/2CB3j8WuVtyN4+vrttuwTwL9pXpSDrWkysngzQeNkYz4bmkx+QKflePyyYpFL
        W/PM3erwlVQ67w18BkR6B3vKmN/byauYno//hYAvVF+omEQc+89H9kTigetrEnpaXiku3h
        DBjQyljmAfRc6BDeDw4oRf08G/1Hqlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650610447;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=njRBOw0x/peGiclxIHvetS0u28ego9jjTT3f0MM6XcM=;
        b=R6zn/3dM/IXiVR7u7a4XNA+tyseO4AL0Ati+gPoQRCPmnrteMZ8IaYJodp2Uizs+45cn83
        xCjURcR0K0GAy/AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4235F131BD;
        Fri, 22 Apr 2022 06:54:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FXGVDg9RYmK7VQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 22 Apr 2022 06:54:07 +0000
Message-ID: <85079e4e-eedc-4f7e-a41c-50bda76f484d@suse.cz>
Date:   Fri, 22 Apr 2022 08:54:06 +0200
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
 <be2c1ad4-1557-677e-dfd8-2089c98fe85d@suse.cz>
 <31b37b7c-a969-eec2-bdff-a7e4dca9b770@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <31b37b7c-a969-eec2-bdff-a7e4dca9b770@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/22 11:15, David Hildenbrand wrote:
> On 19.04.22 19:40, Vlastimil Babka wrote:
>> On 3/29/22 18:04, David Hildenbrand wrote:
>>> Let's verify when (un)pinning anonymous pages that we always deal with
>>> exclusive anonymous pages, which guarantees that we'll have a reliable
>>> PIN, meaning that we cannot end up with the GUP pin being inconsistent
>>> with he pages mapped into the page tables due to a COW triggered
>>> by a write fault.
>>>
>>> When pinning pages, after conditionally triggering GUP unsharing of
>>> possibly shared anonymous pages, we should always only see exclusive
>>> anonymous pages. Note that anonymous pages that are mapped writable
>>> must be marked exclusive, otherwise we'd have a BUG.
>>>
>>> When pinning during ordinary GUP, simply add a check after our
>>> conditional GUP-triggered unsharing checks. As we know exactly how the
>>> page is mapped, we know exactly in which page we have to check for
>>> PageAnonExclusive().
>>>
>>> When pinning via GUP-fast we have to be careful, because we can race with
>>> fork(): verify only after we made sure via the seqcount that we didn't
>>> race with concurrent fork() that we didn't end up pinning a possibly
>>> shared anonymous page.
>>>
>>> Similarly, when unpinning, verify that the pages are still marked as
>>> exclusive: otherwise something turned the pages possibly shared, which
>>> can result in random memory corruptions, which we really want to catch.
>>>
>>> With only the pinned pages at hand and not the actual page table entries
>>> we have to be a bit careful: hugetlb pages are always mapped via a
>>> single logical page table entry referencing the head page and
>>> PG_anon_exclusive of the head page applies. Anon THP are a bit more
>>> complicated, because we might have obtained the page reference either via
>>> a PMD or a PTE -- depending on the mapping type we either have to check
>>> PageAnonExclusive of the head page (PMD-mapped THP) or the tail page
>>> (PTE-mapped THP) applies: as we don't know and to make our life easier,
>>> check that either is set.
>>>
>>> Take care to not verify in case we're unpinning during GUP-fast because
>>> we detected concurrent fork(): we might stumble over an anonymous page
>>> that is now shared.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> 
>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>> 
>> Nits:
>> 
>>> @@ -510,6 +563,10 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>>>  		page = ERR_PTR(-EMLINK);
>>>  		goto out;
>>>  	}
>>> +
>>> +	VM_BUG_ON((flags & FOLL_PIN) && PageAnon(page) &&
>>> +		  !PageAnonExclusive(page));
>> 
>> Do we rather want VM_BUG_ON_PAGE? Also for the same tests in mm/huge*.c below.
> 
> Make sense, thanks:

LGTM

> diff --git a/mm/gup.c b/mm/gup.c
> index 5c17d4816441..46ffd8c51c6e 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -564,8 +564,8 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>                 goto out;
>         }
>  
> -       VM_BUG_ON((flags & FOLL_PIN) && PageAnon(page) &&
> -                 !PageAnonExclusive(page));
> +       VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
> +                      !PageAnonExclusive(page), page);
>  
>         /* try_grab_page() does nothing unless FOLL_GET or FOLL_PIN is set. */
>         if (unlikely(!try_grab_page(page, flags))) {
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 390f22334ee9..a2f44d8d3d47 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1392,8 +1392,8 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
>         if (!pmd_write(*pmd) && gup_must_unshare(flags, page))
>                 return ERR_PTR(-EMLINK);
>  
> -       VM_BUG_ON((flags & FOLL_PIN) && PageAnon(page) &&
> -                 !PageAnonExclusive(page));
> +       VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
> +                       !PageAnonExclusive(page), page);
>  
>         if (!try_grab_page(page, flags))
>                 return ERR_PTR(-ENOMEM);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 8a635b5b5270..0ba2b1930b21 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6100,8 +6100,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>                 pfn_offset = (vaddr & ~huge_page_mask(h)) >> PAGE_SHIFT;
>                 page = pte_page(huge_ptep_get(pte));
>  
> -               VM_BUG_ON((flags & FOLL_PIN) && PageAnon(page) &&
> -                         !PageAnonExclusive(page));
> +               VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
> +                              !PageAnonExclusive(page), page);
>  
>                 /*
>                  * If subpage information not requested, update counters
> 
> 
> 

