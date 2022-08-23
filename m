Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793C259D6FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 11:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349645AbiHWJXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 05:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349514AbiHWJUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 05:20:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E6E89902
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661243580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0M7MKXuIOUn+65HKb9s0vuBPYqXY5iZeLpoXphpzO/Q=;
        b=XS2UxXNvYc1ESWEgLc4P0cicRIVmGTpW2ZscoAbhllrLDOy1nOiPrx4rX3KMgT479pZIkr
        BVzM18xwjnn49MX+eaTY0uQXIBl0vylynG8I+6pOJMwlcAbotUe9K/scCQfYI8vZGD6le4
        eM4MS2xMGPVfEj4VqYHjkQk6D6ftLbU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-674-YpfAct1cMymU-dAu3QnnZQ-1; Tue, 23 Aug 2022 04:29:08 -0400
X-MC-Unique: YpfAct1cMymU-dAu3QnnZQ-1
Received: by mail-wr1-f71.google.com with SMTP id i24-20020adfaad8000000b002251cb5e812so2081886wrc.14
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=0M7MKXuIOUn+65HKb9s0vuBPYqXY5iZeLpoXphpzO/Q=;
        b=D9DZ9oSiDiOI4e+/SiXK96/NE006atX9JKrFzMmbD2IjV7mCzagbFY8/XeijMlWLuI
         qTdZjBZJwlTWZmVClpNmy8xfxrA9aIKW2FrwkBAELuUG/3uSWS00Ni7+8KCydnnA8ma1
         kVrEIiN/McagcrM4+ujCcNt98ldgJdCaP6gvLaLdeDsX7eSQ9Uv7zsbE7v9ETpKuygGY
         gPItQpF3mCgrJDPEkDEpo6KrggZlSaZgQb4jrO9XQm80L2eND0qow0fivpyS+gB/QLVQ
         xIbOO0jlBHvDMAVpeo84uHf+6mCoY9DO4VAaxTFhs8YBJFrN3zMTDA85uoVREWqSevHo
         89/A==
X-Gm-Message-State: ACgBeo0cA5Q0e//ZJPeRgNpUaFprVOJc+uTmRl9JHWT2/rM/lyqlmlnq
        xF1H1LpFk27OFPAy4HhngGv7zxiV9msiAqHb7N0TQhkECMH+ffLmxas4kbxbw8Bx6vfmbGhZSm/
        pVfDWg7sZaAmaBKE9UnwLloj+
X-Received: by 2002:a5d:51c8:0:b0:225:3a78:217f with SMTP id n8-20020a5d51c8000000b002253a78217fmr10214984wrv.592.1661243347279;
        Tue, 23 Aug 2022 01:29:07 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7VvdMi/xvXogR4Z17pNGIVYldfQOJelfE5tffAABZFc/ifwnwcFRJkpm4v99ogtcJuAQnJ0w==
X-Received: by 2002:a5d:51c8:0:b0:225:3a78:217f with SMTP id n8-20020a5d51c8000000b002253a78217fmr10214965wrv.592.1661243346996;
        Tue, 23 Aug 2022 01:29:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:1600:c48b:1fab:a330:5182? (p200300cbc70b1600c48b1faba3305182.dip0.t-ipconnect.de. [2003:cb:c70b:1600:c48b:1fab:a330:5182])
        by smtp.gmail.com with ESMTPSA id h13-20020a5d4fcd000000b0022533c4fa48sm12238050wrw.55.2022.08.23.01.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 01:29:06 -0700 (PDT)
Message-ID: <4c24b891-04ce-2608-79d2-a75dc236533f@redhat.com>
Date:   Tue, 23 Aug 2022 10:29:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1661240170.git.baolin.wang@linux.alibaba.com>
 <0e5d92da043d147a867f634b17acbcc97a7f0e64.1661240170.git.baolin.wang@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 1/5] mm/hugetlb: fix races when looking up a CONT-PTE
 size hugetlb page
In-Reply-To: <0e5d92da043d147a867f634b17acbcc97a7f0e64.1661240170.git.baolin.wang@linux.alibaba.com>
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

On 23.08.22 09:50, Baolin Wang wrote:
> On some architectures (like ARM64), it can support CONT-PTE/PMD size
> hugetlb, which means it can support not only PMD/PUD size hugetlb
> (2M and 1G), but also CONT-PTE/PMD size(64K and 32M) if a 4K page size
> specified.
> 
> So when looking up a CONT-PTE size hugetlb page by follow_page(), it
> will use pte_offset_map_lock() to get the pte entry lock for the CONT-PTE
> size hugetlb in follow_page_pte(). However this pte entry lock is incorrect
> for the CONT-PTE size hugetlb, since we should use huge_pte_lock() to
> get the correct lock, which is mm->page_table_lock.
> 
> That means the pte entry of the CONT-PTE size hugetlb under current
> pte lock is unstable in follow_page_pte(), we can continue to migrate
> or poison the pte entry of the CONT-PTE size hugetlb, which can cause
> some potential race issues, and following pte_xxx() validation is also
> unstable in follow_page_pte(), even though they are under the 'pte lock'.
> 
> Moreover we should use huge_ptep_get() to get the pte entry value of
> the CONT-PTE size hugetlb, which already takes into account the subpages'
> dirty or young bits in case we missed the dirty or young state of the
> CONT-PTE size hugetlb.
> 
> To fix above issues, introducing a new helper follow_huge_pte() to look
> up a CONT-PTE size hugetlb page, which uses huge_pte_lock() to get the
> correct pte entry lock to make the pte entry stable, as well as
> supporting non-present pte handling.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  include/linux/hugetlb.h |  8 ++++++++
>  mm/gup.c                | 11 ++++++++++
>  mm/hugetlb.c            | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 72 insertions(+)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 3ec981a..d491138 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -207,6 +207,8 @@ struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
>  struct page *follow_huge_pd(struct vm_area_struct *vma,
>  			    unsigned long address, hugepd_t hpd,
>  			    int flags, int pdshift);
> +struct page *follow_huge_pte(struct vm_area_struct *vma, unsigned long address,
> +			     pmd_t *pmd, int flags);
>  struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
>  				pmd_t *pmd, int flags);
>  struct page *follow_huge_pud(struct mm_struct *mm, unsigned long address,
> @@ -312,6 +314,12 @@ static inline struct page *follow_huge_pd(struct vm_area_struct *vma,
>  	return NULL;
>  }
>  
> +static inline struct page *follow_huge_pte(struct vm_area_struct *vma,
> +				unsigned long address, pmd_t *pmd, int flags)
> +{
> +	return NULL;
> +}
> +
>  static inline struct page *follow_huge_pmd(struct mm_struct *mm,
>  				unsigned long address, pmd_t *pmd, int flags)
>  {
> diff --git a/mm/gup.c b/mm/gup.c
> index 3b656b7..87a94f5 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -534,6 +534,17 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>  	if (unlikely(pmd_bad(*pmd)))
>  		return no_page_table(vma, flags);
>  
> +	/*
> +	 * Considering PTE level hugetlb, like continuous-PTE hugetlb on
> +	 * ARM64 architecture.
> +	 */
> +	if (is_vm_hugetlb_page(vma)) {
> +		page = follow_huge_pte(vma, address, pmd, flags);
> +		if (page)
> +			return page;
> +		return no_page_table(vma, flags);
> +	}
> +
>  	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
>  	pte = *ptep;
>  	if (!pte_present(pte)) {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6c00ba1..cf742d1 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6981,6 +6981,59 @@ struct page * __weak
>  	return NULL;
>  }
>  
> +/* Support looking up a CONT-PTE size hugetlb page. */
> +struct page * __weak
> +follow_huge_pte(struct vm_area_struct *vma, unsigned long address,
> +		pmd_t *pmd, int flags)
> +{
> +	struct mm_struct *mm = vma->vm_mm;
> +	struct hstate *hstate = hstate_vma(vma);
> +	unsigned long size = huge_page_size(hstate);
> +	struct page *page = NULL;
> +	spinlock_t *ptl;
> +	pte_t *ptep, pte;
> +
> +	/*
> +	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
> +	 * follow_hugetlb_page().
> +	 */
> +	if (WARN_ON_ONCE(flags & FOLL_PIN))
> +		return NULL;
> +
> +	ptep = huge_pte_offset(mm, address, size);
> +	if (!ptep)
> +		return NULL;
> +
> +retry:
> +	ptl = huge_pte_lock(hstate, mm, ptep);
> +	pte = huge_ptep_get(ptep);
> +	if (pte_present(pte)) {
> +		page = pte_page(pte);
> +		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
> +			page = NULL;
> +			goto out;
> +		}
> +	} else {
> +		if (!(flags & FOLL_MIGRATION)) {
> +			page = NULL;
> +			goto out;
> +		}
> +
> +		if (is_hugetlb_entry_migration(pte)) {
> +			spin_unlock(ptl);
> +			__migration_entry_wait_huge(ptep, ptl);
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
>  struct page * __weak
>  follow_huge_pmd(struct mm_struct *mm, unsigned long address,
>  		pmd_t *pmd, int flags)


Can someone explain why:
* follow_page() goes via follow_page_mask() for hugetlb
* __get_user_pages() goes via follow_hugetlb_page() and never via
  follow_page_mask() for hugetlb?

IOW, why can't we make follow_page_mask() just not handle hugetlb and
route everything via follow_hugetlb_page() -- we primarily only have to
teach it to not trigger faults.


What's the reason that this hugetlb code has to be overly complicated?

-- 
Thanks,

David / dhildenb

