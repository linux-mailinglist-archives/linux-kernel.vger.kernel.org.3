Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9CA523BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345663AbiEKRgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345652AbiEKRf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:35:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 627AD62CDF
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652290556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RHJ9jDCm2aZov2g6klEdi92ZsrYHfyKzIwTmWcp9UH8=;
        b=NGJbLnGGiDFyIX+Hl7BzT6EPOfvGrBeehd963Ns6mcWO1tiZ/pbENRbDTeSbBEdUJe3l31
        xvDggPY0LDlNY5FKZAsSpzoBxgaQPD/FQ+WmbS7AajKtAgDLLiPogHzmMZyzeYkK1jWisx
        KbZYFLhum9M/aQYDBM2DPlQbE7AzZ+s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-G6Sjhx2aOZayRGAIami5_A-1; Wed, 11 May 2022 13:35:55 -0400
X-MC-Unique: G6Sjhx2aOZayRGAIami5_A-1
Received: by mail-wm1-f69.google.com with SMTP id 26-20020a05600c021a00b003940660c053so930859wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=RHJ9jDCm2aZov2g6klEdi92ZsrYHfyKzIwTmWcp9UH8=;
        b=UFq/dFx2Wh1yiiHecZURlU3F53PwQLQ0OiLdVlBUhLtoHj9ktgESrzTEgvVeDJe5/O
         fQbWdo/GjMLhEo/mefkci3AS2hROA42XGzJ+I4A8UynlLhdGmnveK+hSLfe2HiZ6hWvM
         Y449AqIsfezsk9LjRuRnH1Ds7x9e//e2fq74Nk12WTvr6U/YUzS7pa3dOlhPsF95FW5y
         YzTHntlZp6cmUcOVnJ63zo/DsFkXvFoKG4jMEnU5kf544DQTca7yfGXup2++utcIObHK
         sHeyjuHlbROHfcej0a+hh/sAp14gTLpgXO/+kMeBwRQg2V0BSfMpZeLbzNXs4d9E432Y
         OyAw==
X-Gm-Message-State: AOAM530wZbh9LhvLiFeZvhMM0Li1X0WYF4oqFI1T7Wk3KAMhNaSQNFhw
        QnwzlQ0VxACpk7n7gf6ApCegXmuvmKAAs996eJyVBMr6f9inUZPToLofwuSLZU8RqSoY8K2F2gP
        JO5db/u4whcbitjlJ6BouDaxW
X-Received: by 2002:a05:6000:1f0f:b0:20c:87b6:df9d with SMTP id bv15-20020a0560001f0f00b0020c87b6df9dmr25088261wrb.115.1652290553803;
        Wed, 11 May 2022 10:35:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxowLcNuhjX33XV+v3YeRfpwZS/+uKcfuTSz0ColENR5G1SBprMZ1XzQiN/ReI3dYYeeSg9JA==
X-Received: by 2002:a05:6000:1f0f:b0:20c:87b6:df9d with SMTP id bv15-20020a0560001f0f00b0020c87b6df9dmr25088227wrb.115.1652290553449;
        Wed, 11 May 2022 10:35:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:700:2393:b0f4:ef08:bd51? (p200300cbc70107002393b0f4ef08bd51.dip0.t-ipconnect.de. [2003:cb:c701:700:2393:b0f4:ef08:bd51])
        by smtp.gmail.com with ESMTPSA id u12-20020a7bc04c000000b003942a244ed6sm387130wmc.27.2022.05.11.10.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 10:35:52 -0700 (PDT)
Message-ID: <f1c904e7-0b16-2893-eb25-0b968817fb8c@redhat.com>
Date:   Wed, 11 May 2022 19:35:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 3/3] mm: rmap: Fix CONT-PTE/PMD size hugetlb issue when
 unmapping
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, mike.kravetz@oracle.com
Cc:     catalin.marinas@arm.com, will@kernel.org, songmuchun@bytedance.com,
        tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
References: <cover.1652270205.git.baolin.wang@linux.alibaba.com>
 <0a2e547238cad5bc153a85c3e9658cb9d55f9cac.1652270205.git.baolin.wang@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <0a2e547238cad5bc153a85c3e9658cb9d55f9cac.1652270205.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.05.22 14:04, Baolin Wang wrote:
> On some architectures (like ARM64), it can support CONT-PTE/PMD size
> hugetlb, which means it can support not only PMD/PUD size hugetlb:
> 2M and 1G, but also CONT-PTE/PMD size: 64K and 32M if a 4K page
> size specified.
> 
> When unmapping a hugetlb page, we will get the relevant page table
> entry by huge_pte_offset() only once to nuke it. This is correct
> for PMD or PUD size hugetlb, since they always contain only one
> pmd entry or pud entry in the page table.
> 
> However this is incorrect for CONT-PTE and CONT-PMD size hugetlb,
> since they can contain several continuous pte or pmd entry with
> same page table attributes, so we will nuke only one pte or pmd
> entry for this CONT-PTE/PMD size hugetlb page.
> 
> And now try_to_unmap() is only passed a hugetlb page in the case
> where the hugetlb page is poisoned. Which means now we will unmap
> only one pte entry for a CONT-PTE or CONT-PMD size poisoned hugetlb
> page, and we can still access other subpages of a CONT-PTE or CONT-PMD
> size poisoned hugetlb page, which will cause serious issues possibly.
> 
> So we should change to use huge_ptep_clear_flush() to nuke the
> hugetlb page table to fix this issue, which already considered
> CONT-PTE and CONT-PMD size hugetlb.
> 
> We've already used set_huge_swap_pte_at() to set a poisoned
> swap entry for a poisoned hugetlb page. Meanwhile adding a VM_BUG_ON()
> to make sure the passed hugetlb page is poisoned in try_to_unmap().
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/rmap.c | 39 ++++++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 4e96daf..219e287 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1528,6 +1528,11 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  
>  		if (folio_test_hugetlb(folio)) {
>  			/*
> +			 * The try_to_unmap() is only passed a hugetlb page
> +			 * in the case where the hugetlb page is poisoned.
> +			 */
> +			VM_BUG_ON_PAGE(!PageHWPoison(subpage), subpage);
> +			/*
>  			 * huge_pmd_unshare may unmap an entire PMD page.
>  			 * There is no way of knowing exactly which PMDs may
>  			 * be cached for this mm, so we must flush them all.
> @@ -1562,28 +1567,28 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  					break;
>  				}
>  			}
> +			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
>  		} else {
>  			flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
> -		}
> -
> -		/*
> -		 * Nuke the page table entry. When having to clear
> -		 * PageAnonExclusive(), we always have to flush.
> -		 */
> -		if (should_defer_flush(mm, flags) && !anon_exclusive) {
>  			/*
> -			 * We clear the PTE but do not flush so potentially
> -			 * a remote CPU could still be writing to the folio.
> -			 * If the entry was previously clean then the
> -			 * architecture must guarantee that a clear->dirty
> -			 * transition on a cached TLB entry is written through
> -			 * and traps if the PTE is unmapped.
> +			 * Nuke the page table entry. When having to clear
> +			 * PageAnonExclusive(), we always have to flush.
>  			 */
> -			pteval = ptep_get_and_clear(mm, address, pvmw.pte);
> +			if (should_defer_flush(mm, flags) && !anon_exclusive) {
> +				/*
> +				 * We clear the PTE but do not flush so potentially
> +				 * a remote CPU could still be writing to the folio.
> +				 * If the entry was previously clean then the
> +				 * architecture must guarantee that a clear->dirty
> +				 * transition on a cached TLB entry is written through
> +				 * and traps if the PTE is unmapped.
> +				 */
> +				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
>  
> -			set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
> -		} else {
> -			pteval = ptep_clear_flush(vma, address, pvmw.pte);
> +				set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
> +			} else {
> +				pteval = ptep_clear_flush(vma, address, pvmw.pte);
> +			}
>  		}
>  
>  		/*

LGTM

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

