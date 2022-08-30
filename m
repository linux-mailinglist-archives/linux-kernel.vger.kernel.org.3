Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9605A5DCE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiH3IMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiH3IL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:11:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C225B2858
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661847113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XyVU1ACRwMw2c3Z4knWk/NSoLw2ZcqvVGKGSGx3FqMU=;
        b=iP0txUS6JPGwRvyEJeIxQNxxIiQY+b+rxaQTA5kB+XrKc01XkeHjPZoZ/wnxfES+Aj9jfd
        G9CaP2bUJKsHEKC8xdPm8G82jTgk21rXU25lls0An8gNTNq3OcfoDooMTJf56nb7Rns7xc
        idYeqYMvVn6u6Ur6buqmsWTZNeXOBak=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-623-8xeOQi6jOpCbW9gQCYP5zQ-1; Tue, 30 Aug 2022 04:11:52 -0400
X-MC-Unique: 8xeOQi6jOpCbW9gQCYP5zQ-1
Received: by mail-wm1-f72.google.com with SMTP id b16-20020a05600c4e1000b003a5a47762c3so6277902wmq.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=XyVU1ACRwMw2c3Z4knWk/NSoLw2ZcqvVGKGSGx3FqMU=;
        b=FmhMCqZFlLn14a5kl+9GCIkdIxTYXsZWZbpAiBSSwwTanW6alWbcCfbiYtCNZAynLL
         E1fdJfdCYNWllyTs4fI7XMXa4gPqUJggA1/pE+KoioTseGpUtTbFSatAtIP3vGmfLLlU
         0W0dwhMrSdL9fJbyqn/zrh1mMZNQ2pNa1+7dBLqjBRb8iYIuv1XQrkyBUn5OZemOWAQU
         d/chwthN3yhIJjpzXYkMfPS4ZAnd/51pd+zRXPUVS1ZeOjQFNBHdXGKl3sPXIImkYwE+
         C0z+/JZp+w6Z3qo2OSQBzxoylr7q4Vl1JtM/6Or6jtgCenDqVbrR83Op7HPdUt41xRVG
         Z3Tg==
X-Gm-Message-State: ACgBeo0UFemC+qCGy0CcJXPCdB9mwWFeX82QNwHRNmPs0n9qiKBj/omC
        04JSs+i6VAD2nKOK8S6qMP729+eh3/7rQWktqP4dUhxWSOEiSoi/IBGxoPiC+G1+RYK3+i4chX3
        Sk9gQH39Q6g56cKBt4T7rMoXp
X-Received: by 2002:a05:6000:1f85:b0:225:4057:e95f with SMTP id bw5-20020a0560001f8500b002254057e95fmr8021232wrb.661.1661847111474;
        Tue, 30 Aug 2022 01:11:51 -0700 (PDT)
X-Google-Smtp-Source: AA6agR49o/2TxpeySc3SlwiyevzVDcAYLal2XehazCP+tO9Q3ufOCO3bGHmKcmkLHtYT5LbrAjLBzg==
X-Received: by 2002:a05:6000:1f85:b0:225:4057:e95f with SMTP id bw5-20020a0560001f8500b002254057e95fmr8021211wrb.661.1661847111176;
        Tue, 30 Aug 2022 01:11:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:1000:ecb4:919b:e3d3:e20b? (p200300cbc70a1000ecb4919be3d3e20b.dip0.t-ipconnect.de. [2003:cb:c70a:1000:ecb4:919b:e3d3:e20b])
        by smtp.gmail.com with ESMTPSA id b17-20020adfde11000000b0021eaf4138aesm10476909wrm.108.2022.08.30.01.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 01:11:50 -0700 (PDT)
Message-ID: <608934d4-466d-975e-6458-34a91ccb4669@redhat.com>
Date:   Tue, 30 Aug 2022 10:11:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, inuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220829234053.159158-1-mike.kravetz@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] hugetlb: simplify hugetlb handling in follow_page_mask
In-Reply-To: <20220829234053.159158-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.22 01:40, Mike Kravetz wrote:
> During discussions of this series [1], it was suggested that hugetlb
> handling code in follow_page_mask could be simplified.  At the beginning

Feel free to use a Suggested-by if you consider it appropriate.

> of follow_page_mask, there currently is a call to follow_huge_addr which
> 'may' handle hugetlb pages.  ia64 is the only architecture which provides
> a follow_huge_addr routine that does not return error.  Instead, at each
> level of the page table a check is made for a hugetlb entry.  If a hugetlb
> entry is found, a call to a routine associated with that entry is made.
> 
> Currently, there are two checks for hugetlb entries at each page table
> level.  The first check is of the form:
> 	if (p?d_huge())
> 		page = follow_huge_p?d();
> the second check is of the form:
> 	if (is_hugepd())
> 		page = follow_huge_pd().

BTW, what about all this hugepd stuff in mm/pagewalk.c?

Isn't this all dead code as we're essentially routing all hugetlb VMAs
via walk_hugetlb_range? [yes, all that hugepd stuff in generic code that
overcomplicates stuff has been annoying me for a long time]

> 
> We can replace these checks, as well as the special handling routines
> such as follow_huge_p?d() and follow_huge_pd() with a single routine to
> handle hugetlb vmas.
> 
> A new routine hugetlb_follow_page_mask is called for hugetlb vmas at the
> beginning of follow_page_mask.  hugetlb_follow_page_mask will use the
> existing routine huge_pte_offset to walk page tables looking for hugetlb
> entries.  huge_pte_offset can be overwritten by architectures, and already
> handles special cases such as hugepd entries.
> 
> [1] https://lore.kernel.org/linux-mm/cover.1661240170.git.baolin.wang@linux.alibaba.com/
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

[...]

> +static struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> +				unsigned long address, unsigned int flags)
> +{
> +	/* should never happen, but do not want to BUG */
> +	return ERR_PTR(-EINVAL);

Should there be a WARN_ON_ONCE() instead or could we use a BUILD_BUG_ON()?

> +}


[...]

> @@ -851,10 +814,15 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
>  
>  	ctx->page_mask = 0;
>  
> -	/* make this handle hugepd */
> -	page = follow_huge_addr(mm, address, flags & FOLL_WRITE);
> -	if (!IS_ERR(page)) {
> -		WARN_ON_ONCE(flags & (FOLL_GET | FOLL_PIN));
> +	/*
> +	 * Call hugetlb_follow_page_mask for hugetlb vmas as it will use
> +	 * special hugetlb page table walking code.  This eliminates the
> +	 * need to check for hugetlb entries in the general walking code.
> +	 */

Maybe also comment that ordinary GUP never ends up in here and instead
directly uses follow_hugetlb_page(). This is for follow_page() handling
only.

[me suggestion to rename follow_hugetlb_page() still stands ;) ]

> +	if (is_vm_hugetlb_page(vma)) {
> +		page = hugetlb_follow_page_mask(vma, address, flags);
> +		if (!page)
> +			page = no_page_table(vma, flags);
>  		return page;
>  	}
>  
> @@ -863,21 +831,6 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
>  	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
>  		return no_page_table(vma, flags);
>  
> -	if (pgd_huge(*pgd)) {
> -		page = follow_huge_pgd(mm, address, pgd, flags);
> -		if (page)
> -			return page;
> -		return no_page_table(vma, flags);
> -	}
> -	if (is_hugepd(__hugepd(pgd_val(*pgd)))) {
> -		page = follow_huge_pd(vma, address,
> -				      __hugepd(pgd_val(*pgd)), flags,
> -				      PGDIR_SHIFT);
> -		if (page)
> -			return page;
> -		return no_page_table(vma, flags);
> -	}
> -
>  	return follow_p4d_mask(vma, address, pgd, flags, ctx);
>  }
>  
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d0617d64d718..b3da421ba5be 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6190,6 +6190,62 @@ static inline bool __follow_hugetlb_must_fault(unsigned int flags, pte_t *pte,
>  	return false;
>  }
>  
> +struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> +				unsigned long address, unsigned int flags)
> +{
> +	struct hstate *h = hstate_vma(vma);
> +	struct mm_struct *mm = vma->vm_mm;
> +	unsigned long haddr = address & huge_page_mask(h);
> +	struct page *page = NULL;
> +	spinlock_t *ptl;
> +	pte_t *pte, entry;
> +
> +	/*
> +	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
> +	 * follow_hugetlb_page().
> +	 */
> +	if (WARN_ON_ONCE(flags & FOLL_PIN))
> +		return NULL;
> +
> +	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
> +	if (!pte)
> +		return NULL;
> +
> +retry:
> +	ptl = huge_pte_lock(h, mm, pte);
> +	entry = huge_ptep_get(pte);
> +	if (pte_present(entry)) {
> +		page = pte_page(entry) +
> +				((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
> +		/*
> +		 * Note that page may be a sub-page, and with vmemmap
> +		 * optimizations the page struct may be read only.
> +		 * try_grab_page() will increase the ref count on the
> +		 * head page, so this will be OK.
> +		 *
> +		 * try_grab_page() should always succeed here, because we hold
> +		 * the ptl lock and have verified pte_present().
> +		 */
> +		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
> +			page = NULL;
> +			goto out;
> +		}
> +	} else {
> +		if (is_hugetlb_entry_migration(entry)) {
> +			spin_unlock(ptl);
> +			__migration_entry_wait_huge(pte, ptl);
> +			goto retry;
> +		}
> +		/*
> +		 * hwpoisoned entry is treated as no_page_table in
> +		 * follow_page_mask().
> +		 */
> +	}
> +out:
> +	spin_unlock(ptl);
> +	return page;
> +}
> +
>  long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  			 struct page **pages, struct vm_area_struct **vmas,
>  			 unsigned long *position, unsigned long *nr_pages,
> @@ -7140,123 +7196,6 @@ __weak unsigned long hugetlb_mask_last_page(struct hstate *h)
>   * These functions are overwritable if your architecture needs its own
>   * behavior.
>   */

[...]

Numbers speak for themselves.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

