Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4635AA3B3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 01:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbiIAX1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 19:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbiIAX1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 19:27:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DA558B7E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 16:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662074818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4zhQGyUQdaZfg/v5RuJfK81JYWToWC40+GtvI6Qq18w=;
        b=iHV28TC774j54FPqkccV9y/0O4CbLJMFX+ErH5lpjKZ/pfsCdhyF60BK/w7amzX+lDQzp7
        VwldjhUdnivvOwX1sibMMvgjkoq0mv5BcAnqQeu35MBOIJvRmbYQi0c2IZn7rX8IERPxi5
        F16g3KZ1KWU/+FDTfKiCbfYBNCm5u8I=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-564-Y6rw-dffMDm9NN6qOaNbFw-1; Thu, 01 Sep 2022 19:26:57 -0400
X-MC-Unique: Y6rw-dffMDm9NN6qOaNbFw-1
Received: by mail-qt1-f198.google.com with SMTP id o21-20020ac87c55000000b00344646ea2ccso325423qtv.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 16:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4zhQGyUQdaZfg/v5RuJfK81JYWToWC40+GtvI6Qq18w=;
        b=uS870yYb0mRxtotmhZifIizqClR4JhV2yF20H7TcwQccBmdNzYikFxOx2PQO8ooA1X
         8fTJo6VZhKIez+HcdpbT2hQ8QPwIcqnXgDSzivkG+Nc8w8Z4yq1sn7h3CuHbWhJgrXJm
         gwtlxzqz9cMc6zwDvSdLW2jo6VdF148/xzDRGXoHChRfwBvw47hLUwyeRczG0gN966JP
         M02bCl+P0e29oaUpigY53613qAs4LspEp0TFGQgCA0R4lMH226zjUE9wfMq9X5XA8LSW
         wkqYFV1n5XdR4lVOkC4hS/jLVKAGdZz8878KZHQh85p9f62V6Qbp+NLhU0u0fMAlrLqU
         SM0A==
X-Gm-Message-State: ACgBeo0RVH7DuBCfo7r0uiClNGlf2BjaIemco7wA2dEgO6fYh7mlwZ7k
        +dufpz84IW3wZ6gsVSTVHkrdF887HdVre/It4VtZKWDHBBaRtdz6Z+emKTCecajgwtLCPBxFrVa
        j12FMKqFSJzjQdLlOH6Puej/2
X-Received: by 2002:a05:6214:238b:b0:48a:f607:c4e0 with SMTP id fw11-20020a056214238b00b0048af607c4e0mr27083583qvb.44.1662074817144;
        Thu, 01 Sep 2022 16:26:57 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7PbY3MIHgmSUi6mRoFOFLyzTJoF2sshpE2r5ybOvJGbOWappmAtfv6+P5IvtHPGmBYk24LkQ==
X-Received: by 2002:a05:6214:238b:b0:48a:f607:c4e0 with SMTP id fw11-20020a056214238b00b0048af607c4e0mr27083571qvb.44.1662074816889;
        Thu, 01 Sep 2022 16:26:56 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id d3-20020a05620a166300b006b5c061844fsm203236qko.49.2022.09.01.16.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 16:26:56 -0700 (PDT)
Date:   Thu, 1 Sep 2022 19:26:54 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     david@redhat.com, kirill.shutemov@linux.intel.com,
        jhubbard@nvidia.com, jgg@nvidia.com, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
Message-ID: <YxE/vuQlWJCJMuG2@xz-m1.local>
References: <20220901222707.477402-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220901222707.477402-1-shy828301@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yang,

On Thu, Sep 01, 2022 at 03:27:07PM -0700, Yang Shi wrote:
> Since general RCU GUP fast was introduced in commit 2667f50e8b81 ("mm:
> introduce a general RCU get_user_pages_fast()"), a TLB flush is no longer
> sufficient to handle concurrent GUP-fast in all cases, it only handles
> traditional IPI-based GUP-fast correctly.

If TLB flush (or, IPI broadcasts) used to work to protect against gup-fast,
I'm kind of confused why it's not sufficient even if with RCU gup?  Isn't
that'll keep working as long as interrupt disabled (which current fast-gup
will still do)?

IIUC the issue is you suspect not all archs correctly implemented
pmdp_collapse_flush(), or am I wrong?

> On architectures that send
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

Could the race also be fixed by impl pmdp_collapse_flush() correctly for
the archs that are missing? Do you know which arch(s) is broken with it?

It's just not clear to me whether this patch is an optimization or a fix,
if it's a fix whether the IPI broadcast in ppc pmdp_collapse_flush() would
still be needed.

Thanks,

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
> -- 
> 2.26.3
> 

-- 
Peter Xu

