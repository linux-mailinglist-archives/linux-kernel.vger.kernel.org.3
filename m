Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0043749C3B7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiAZGep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiAZGeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:34:44 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E49C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 22:34:44 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d18so8815351plg.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 22:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=fGg1H8RUdlj9bANnq6kjCpGLWmT4oA2/ugIWQZcr1qM=;
        b=coV6d1V8PpRgGP3MW32Cu/6NhxRInJUvCKTzkMun0dMygcdjRsBd4Z2noduRtIlJzI
         VKEmwM0IiKO00yzmx0FinSQWr9lvyXeUDE6B1ddRqX2V2xLjuRuf1mPNjDCmeZalCxAW
         Qsuk//M6gW0fGrnmcLCvrQFSbylMofYgGllAz0qKMDWhgnz/FoqpydJ3qwFoL1vrlXE/
         bxg8lOYJ77sowNBVNI8Sro6utCdhkAVy+YfnMSTmKRpvhGpG1xzjgEpM59QNkenPsxg/
         Gd3QDXsQIyEQAtuDyEDurZB0RnqPkszzy1hj7OabrF5+qfYWR6pDy7z1kg/ISNdaoueF
         fQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=fGg1H8RUdlj9bANnq6kjCpGLWmT4oA2/ugIWQZcr1qM=;
        b=JYEDGmG169ATCRPrHCM2tgVQB1zO1H66S0w1Cf+vOIz+PMmyyriUVY6I358+Z3Anw2
         RWdEF2QlQwgwdNRUJXyY6CFGsqu7uLyxkUm6Bac1ofumnklubDaJq5CXVM1zhs4LzSkh
         iRvej57WK/Iwl7KSyKv31MZn/dccbia00VKn4D4LkcoTfybXIArd8JYLWNs7BrHOTSHK
         BUZ5IJomzfgmGQDNxDpAIwli/LEIZuoHg3UJA2AygNpu6Z9RjPTHKNvjpn3Y5kdGS3Z6
         7ILwInM76SFTOza0Gs/wXa49hSvgaul3op7rv3K2Ah5qO5i9zYtAHFtIVZjeQRupyGp2
         K65w==
X-Gm-Message-State: AOAM5336uMu8D4ifBan9uRwi3vYcgccT39mFP2ORgbXyEkspXtYw+mRe
        qSnrC1QLlkC3ln0pcU2hxrowZw==
X-Google-Smtp-Source: ABdhPJwwWFZST1e4Qxlr4VaZfzRqctG3RkKt6lo6cCqFFrPuOFbvYB2T5MDM2Y/3sbDGTSK+xWntzQ==
X-Received: by 2002:a17:902:f68d:b0:14b:7c0c:8f68 with SMTP id l13-20020a170902f68d00b0014b7c0c8f68mr4986324plg.153.1643178883687;
        Tue, 25 Jan 2022 22:34:43 -0800 (PST)
Received: from [2620:15c:29:204:6f7a:fc02:d37c:a8b0] ([2620:15c:29:204:6f7a:fc02:d37c:a8b0])
        by smtp.gmail.com with ESMTPSA id nl12sm2306888pjb.1.2022.01.25.22.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 22:34:42 -0800 (PST)
Date:   Tue, 25 Jan 2022 22:34:42 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>, pjt@google.com,
        weixugc@google.com, gthelen@google.com, mingo@redhat.com,
        will@kernel.org, rppt@kernel.org, dave.hansen@linux.intel.com,
        hpa@zytor.com, aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com, anshuman.khandual@arm.com
Subject: Re: [PATCH v3 3/4] mm/khugepaged: unify collapse pmd clear, flush
 and free
In-Reply-To: <20220126060514.1574935-4-pasha.tatashin@soleen.com>
Message-ID: <edd2d5d0-998a-633c-fc60-4f31ae768d3e@google.com>
References: <20220126060514.1574935-1-pasha.tatashin@soleen.com> <20220126060514.1574935-4-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022, Pasha Tatashin wrote:

> Unify the code that flushes, clears pmd entry, and frees the PTE table
> level into a new function collapse_and_free_pmd().
> 
> This clean-up is useful as in the next patch we will add another call to
> this function to iterate through PTE prior to freeing the level for page
> table check.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: David Rientjes <rientjes@google.com>

One nit below.

> ---
>  mm/khugepaged.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 35f14d0a00a6..440112355ffe 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1416,6 +1416,17 @@ static int khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
>  	return 0;
>  }
>  
> +static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *vma,
> +				  unsigned long addr, pmd_t *pmdp)
> +{
> +	spinlock_t *ptl = pmd_lock(vma->vm_mm, pmdp);
> +	pmd_t pmd = pmdp_collapse_flush(vma, addr, pmdp);
> +
> +	spin_unlock(ptl);

No strong objection, but I think the typical style would be to declare the 
local variables separately and avoid mixing the code, especially in cases 
when taking locks (and not just initializing the local variables).

> +	mm_dec_nr_ptes(mm);
> +	pte_free(mm, pmd_pgtable(pmd));
> +}
> +
>  /**
>   * collapse_pte_mapped_thp - Try to collapse a pte-mapped THP for mm at
>   * address haddr.
> @@ -1433,7 +1444,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
>  	struct vm_area_struct *vma = find_vma(mm, haddr);
>  	struct page *hpage;
>  	pte_t *start_pte, *pte;
> -	pmd_t *pmd, _pmd;
> +	pmd_t *pmd;
>  	spinlock_t *ptl;
>  	int count = 0;
>  	int i;
> @@ -1509,12 +1520,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
>  	}
>  
>  	/* step 4: collapse pmd */
> -	ptl = pmd_lock(vma->vm_mm, pmd);
> -	_pmd = pmdp_collapse_flush(vma, haddr, pmd);
> -	spin_unlock(ptl);
> -	mm_dec_nr_ptes(mm);
> -	pte_free(mm, pmd_pgtable(_pmd));
> -
> +	collapse_and_free_pmd(mm, vma, haddr, pmd);
>  drop_hpage:
>  	unlock_page(hpage);
>  	put_page(hpage);
> @@ -1552,7 +1558,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>  	struct vm_area_struct *vma;
>  	struct mm_struct *mm;
>  	unsigned long addr;
> -	pmd_t *pmd, _pmd;
> +	pmd_t *pmd;
>  
>  	i_mmap_lock_write(mapping);
>  	vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
> @@ -1591,14 +1597,8 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>  		 * reverse order. Trylock is a way to avoid deadlock.
>  		 */
>  		if (mmap_write_trylock(mm)) {
> -			if (!khugepaged_test_exit(mm)) {
> -				spinlock_t *ptl = pmd_lock(mm, pmd);
> -				/* assume page table is clear */
> -				_pmd = pmdp_collapse_flush(vma, addr, pmd);
> -				spin_unlock(ptl);
> -				mm_dec_nr_ptes(mm);
> -				pte_free(mm, pmd_pgtable(_pmd));
> -			}
> +			if (!khugepaged_test_exit(mm))
> +				collapse_and_free_pmd(mm, vma, addr, pmd);
>  			mmap_write_unlock(mm);
>  		} else {
>  			/* Try again later */
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog
> 
> 
