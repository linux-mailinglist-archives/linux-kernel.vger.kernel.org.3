Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E2D5AA833
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiIBGmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiIBGme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:42:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7BCB14EB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 23:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662100952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zd920y5kuntN3Fe3mBbgf2SnydeE5HI0Dhy/WeAHKqc=;
        b=HRTkpIjYchWn9p2jMyW6p5aUwz0QDdUtnVopmASqQQ8e4q0bCdAoKEe1lJV7mwByQ5XRmc
        ZxM4wBPJJE5wlicpwqtiLMUKl8DKVkEHU1qhGWUL/TCQinVDfqEI6k70q+szIVYRS0z/DB
        Lr/K922esSxvNfRu5rdi/grGsCMmv0o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-399-Kr0q0gJYNVOTGHmxirlHNw-1; Fri, 02 Sep 2022 02:42:30 -0400
X-MC-Unique: Kr0q0gJYNVOTGHmxirlHNw-1
Received: by mail-wm1-f70.google.com with SMTP id c5-20020a7bc005000000b003a63a3570f2so272896wmb.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 23:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=zd920y5kuntN3Fe3mBbgf2SnydeE5HI0Dhy/WeAHKqc=;
        b=XxDcpPKtYBKYnYV9/YRFRUKTgi/IYbCq2yGCoBujSBZwMSn6OAqv7hs3WFjUfZOlRu
         KVBC5UXczAGUf+eGBOIt6TK3T1GViHU4OkL7A5NTiFWh0Co9vh01QzO+PWI1V9kjqRYB
         kbeuYG2v0ymVnlLmvoxVWixi9rp0MCS/iRZSmWkmJd0GobAehgVe7DPioTCe0+X7aBhb
         IgekRycqLb4DddM8sIJVuK/72yEdi3a25C3uYcqbbLF2ZFt5AvGEwJXTQikL7hiGpmVE
         o6X7pqfJ21UgYIua8IHsRoR4lLscLOWb3wp83D7TYO5WznZrUEzc04dMxOxFfpMOmATv
         TO9A==
X-Gm-Message-State: ACgBeo03wPywPAwrcL/O5JFtdJtReYgnWL8cZuPVsSwTjeFkif66nGb+
        ak0xZt6STNwI+r0O5iN4PZjpvd3PeUA3Y0zCHuYrWra6eZ1Kn4976T9/pltNQMHMrMgA+vgNC1Z
        LmNNuCVUb6jLykqft41Dogkxj
X-Received: by 2002:a05:600c:4ec9:b0:3a5:a567:137f with SMTP id g9-20020a05600c4ec900b003a5a567137fmr1673996wmq.46.1662100949462;
        Thu, 01 Sep 2022 23:42:29 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7NOLu61wFcCZ0OBX41IN7InJbnGYlfsBwf1Tz6mQhGc6CVw6ILI/UTYKBvLA+1ocvRUh+E6w==
X-Received: by 2002:a05:600c:4ec9:b0:3a5:a567:137f with SMTP id g9-20020a05600c4ec900b003a5a567137fmr1673979wmq.46.1662100949183;
        Thu, 01 Sep 2022 23:42:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c714:4800:2077:1bf6:40e7:2833? (p200300cbc714480020771bf640e72833.dip0.t-ipconnect.de. [2003:cb:c714:4800:2077:1bf6:40e7:2833])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d6103000000b002252cb35184sm747022wrt.25.2022.09.01.23.42.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 23:42:28 -0700 (PDT)
Message-ID: <e0b2593f-d259-3db8-d742-705c0a9a8f84@redhat.com>
Date:   Fri, 2 Sep 2022 08:42:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>, peterx@redhat.com,
        kirill.shutemov@linux.intel.com, jhubbard@nvidia.com,
        jgg@nvidia.com, hughd@google.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220901222707.477402-1-shy828301@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220901222707.477402-1-shy828301@gmail.com>
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

On 02.09.22 00:27, Yang Shi wrote:
> Since general RCU GUP fast was introduced in commit 2667f50e8b81 ("mm:
> introduce a general RCU get_user_pages_fast()"), a TLB flush is no longer
> sufficient to handle concurrent GUP-fast in all cases, it only handles
> traditional IPI-based GUP-fast correctly.  On architectures that send
> an IPI broadcast on TLB flush, it works as expected.  But on the
> architectures that do not use IPI to broadcast TLB flush, it may have
> the below race:
> 
>    CPU A                                          CPU B
> THP collapse                                     fast GUP
>                                               gup_pmd_range() <-- see valid pmd
>                                                   gup_pte_range() <-- work on pte
> pmdp_collapse_flush() <-- clear pmd and flush
> __collapse_huge_page_isolate()
>     check page pinned <-- before GUP bump refcount
>                                                       pin the page
>                                                       check PTE <-- no change
> __collapse_huge_page_copy()
>     copy data to huge page
>     ptep_clear()
> install huge pmd for the huge page
>                                                       return the stale page
> discard the stale page
> 
> The race could be fixed by checking whether PMD is changed or not after
> taking the page pin in fast GUP, just like what it does for PTE.  If the
> PMD is changed it means there may be parallel THP collapse, so GUP
> should back off.
> 
> Also update the stale comment about serializing against fast GUP in
> khugepaged.
> 
> Fixes: 2667f50e8b81 ("mm: introduce a general RCU get_user_pages_fast()")
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/gup.c        | 30 ++++++++++++++++++++++++------
>  mm/khugepaged.c | 10 ++++++----
>  2 files changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index f3fc1f08d90c..4365b2811269 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2380,8 +2380,9 @@ static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
>  }
>  
>  #ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
> -static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
> -			 unsigned int flags, struct page **pages, int *nr)
> +static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
> +			 unsigned long end, unsigned int flags,
> +			 struct page **pages, int *nr)
>  {
>  	struct dev_pagemap *pgmap = NULL;
>  	int nr_start = *nr, ret = 0;
> @@ -2423,7 +2424,23 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>  			goto pte_unmap;
>  		}
>  
> -		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> +		/*
> +		 * THP collapse conceptually does:
> +		 *   1. Clear and flush PMD
> +		 *   2. Check the base page refcount
> +		 *   3. Copy data to huge page
> +		 *   4. Clear PTE
> +		 *   5. Discard the base page
> +		 *
> +		 * So fast GUP may race with THP collapse then pin and
> +		 * return an old page since TLB flush is no longer sufficient
> +		 * to serialize against fast GUP.
> +		 *
> +		 * Check PMD, if it is changed just back off since it
> +		 * means there may be parallel THP collapse.
> +		 */
> +		if (unlikely(pmd_val(pmd) != pmd_val(*pmdp)) ||
> +		    unlikely(pte_val(pte) != pte_val(*ptep))) {
>  			gup_put_folio(folio, 1, flags);
>  			goto pte_unmap;
>  		}
> @@ -2470,8 +2487,9 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>   * get_user_pages_fast_only implementation that can pin pages. Thus it's still
>   * useful to have gup_huge_pmd even if we can't operate on ptes.
>   */
> -static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
> -			 unsigned int flags, struct page **pages, int *nr)
> +static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
> +			 unsigned long end, unsigned int flags,
> +			 struct page **pages, int *nr)
>  {
>  	return 0;
>  }
> @@ -2791,7 +2809,7 @@ static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned lo
>  			if (!gup_huge_pd(__hugepd(pmd_val(pmd)), addr,
>  					 PMD_SHIFT, next, flags, pages, nr))
>  				return 0;
> -		} else if (!gup_pte_range(pmd, addr, next, flags, pages, nr))
> +		} else if (!gup_pte_range(pmd, pmdp, addr, next, flags, pages, nr))
>  			return 0;
>  	} while (pmdp++, addr = next, addr != end);
>  
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 2d74cf01f694..518b49095db3 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1049,10 +1049,12 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  
>  	pmd_ptl = pmd_lock(mm, pmd); /* probably unnecessary */
>  	/*
> -	 * After this gup_fast can't run anymore. This also removes
> -	 * any huge TLB entry from the CPU so we won't allow
> -	 * huge and small TLB entries for the same virtual address
> -	 * to avoid the risk of CPU bugs in that area.
> +	 * This removes any huge TLB entry from the CPU so we won't allow
> +	 * huge and small TLB entries for the same virtual address to
> +	 * avoid the risk of CPU bugs in that area.
> +	 *
> +	 * Parallel fast GUP is fine since fast GUP will back off when
> +	 * it detects PMD is changed.
>  	 */
>  	_pmd = pmdp_collapse_flush(vma, address, pmd);
>  	spin_unlock(pmd_ptl);


As long as pmdp_collapse_flush() implies a full memory barrier (which I
think it does), this should work as expected.

Hopefully someone with experience on RCU GUP-fast (Jason, John?  :) )
can double-check.

To me this sound sane.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

