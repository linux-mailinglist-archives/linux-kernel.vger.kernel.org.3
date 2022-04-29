Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388345145FC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352624AbiD2Jzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357251AbiD2Jxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:53:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5403C6663
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651225726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OG90F21ilKlDNtjgRsqpwUPxSnJdXSSgvFpobfkqunQ=;
        b=WeXzV5+Cr/tcA/9s8T7c+t5LE2wFhVKWy5vEHBvZxsUnyy1rTH2j4RU1E+rvzVGOy7dedh
        pKsSG3wZAG9J5wzvZ9fe8GqcnZONJddVMfHz8kTGOcXiTfjppKpJ0AVX8jPBkCz95rfKHp
        a3bkKx/3auB76iiQbat4kkfIjddVqnI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-m1q8EyFrPa6QzzNWRwg14g-1; Fri, 29 Apr 2022 05:48:45 -0400
X-MC-Unique: m1q8EyFrPa6QzzNWRwg14g-1
Received: by mail-wm1-f69.google.com with SMTP id j5-20020a05600c1c0500b0039419a269a1so1028008wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=OG90F21ilKlDNtjgRsqpwUPxSnJdXSSgvFpobfkqunQ=;
        b=z+vCF9RdvttheI8wwUFc6XvQib73tYD9iD13/ywRKMHULGht5vKxDOWYOkegSGLVH6
         8COy8K5XDTZQMp6K7+8e0SyXuXa75KRQTNZ7EmwpIUqk/hyGBdO3mjXTwIStLLl0hYQT
         DC62inUpHSWR4bMly92QzMU9QiNqqh83jXQbxDeNfX9C0P9CjdCO4aOdL+H6PlIszUEV
         fwcXraspVgCzSRn/V5/sQ6SzU0rWCZOXMi8IpZXYssexvVMdMdff1CmfHzExt+qMkVlo
         WM1xykfBgFtQctTP5BgoydXeewCwbT+7DDKnF79DoBOQ8MtPDGHO5w2LSTUvKMcOG1M2
         GQvg==
X-Gm-Message-State: AOAM531wdSTWFSHgT6Y1iE5tKksn+cYz6tebzcyl+NwJFKDtGxLV4xI2
        xQXSeBm16ERuwA6eyi/jIAS9OEM1xZivYBgwNaPZ02JahEI3U2dLdhWvqOEkyU+Mak/v+pD+Z3y
        Imsv7grT2TG5R2pMJSdW+LQ1L
X-Received: by 2002:a1c:e916:0:b0:38e:ac96:f477 with SMTP id q22-20020a1ce916000000b0038eac96f477mr2386079wmc.160.1651225724190;
        Fri, 29 Apr 2022 02:48:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyc32NA/ClnmuNmccycfutXjbZtcGqyD1urDez24X9yKDxfuY7A2fS+Lv19Aw+r6DMbRCHLTg==
X-Received: by 2002:a1c:e916:0:b0:38e:ac96:f477 with SMTP id q22-20020a1ce916000000b0038eac96f477mr2386071wmc.160.1651225723957;
        Fri, 29 Apr 2022 02:48:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:fe00:bbeb:98e6:617a:dea1? (p200300cbc707fe00bbeb98e6617adea1.dip0.t-ipconnect.de. [2003:cb:c707:fe00:bbeb:98e6:617a:dea1])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b00393eaf94077sm2824722wmq.8.2022.04.29.02.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 02:48:43 -0700 (PDT)
Message-ID: <e7e5bcb1-362a-6868-45c9-a04756f069e7@redhat.com>
Date:   Fri, 29 Apr 2022 11:48:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 4/4] mm/migration: fix potential pte_unmap on an not
 mapped pte
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, naoya.horiguchi@nec.com
Cc:     ying.huang@intel.com, hch@lst.de, dhowells@redhat.com,
        cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220425132723.34824-1-linmiaohe@huawei.com>
 <20220425132723.34824-5-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220425132723.34824-5-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.04.22 15:27, Miaohe Lin wrote:
> __migration_entry_wait and migration_entry_wait_on_locked assume pte is
> always mapped from caller. But this is not the case when it's called from
> migration_entry_wait_huge and follow_huge_pmd. Add a hugetlbfs variant that
> calls hugetlb_migration_entry_wait(ptep == NULL) to fix this issue.
> 
> Fixes: 30dad30922cc ("mm: migration: add migrate_entry_wait_huge()")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/linux/swapops.h | 12 ++++++++----
>  mm/hugetlb.c            |  4 ++--
>  mm/migrate.c            | 23 +++++++++++++++++++----
>  3 files changed, 29 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index 30cded849ee4..862e5a2053b1 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -244,8 +244,10 @@ extern void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
>  					spinlock_t *ptl);
>  extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
>  					unsigned long address);
> -extern void migration_entry_wait_huge(struct vm_area_struct *vma,
> -		struct mm_struct *mm, pte_t *pte);
> +#ifdef CONFIG_HUGETLB_PAGE
> +extern void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl);
> +extern void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte);
> +#endif
>  #else
>  static inline swp_entry_t make_readable_migration_entry(pgoff_t offset)
>  {
> @@ -271,8 +273,10 @@ static inline void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
>  					spinlock_t *ptl) { }
>  static inline void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
>  					 unsigned long address) { }
> -static inline void migration_entry_wait_huge(struct vm_area_struct *vma,
> -		struct mm_struct *mm, pte_t *pte) { }
> +#ifdef CONFIG_HUGETLB_PAGE
> +static inline void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl) { }
> +static inline void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte) { }
> +#endif
>  static inline int is_writable_migration_entry(swp_entry_t entry)
>  {
>  	return 0;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 098f81e8550d..994361ec75e0 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5689,7 +5689,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  		 */
>  		entry = huge_ptep_get(ptep);
>  		if (unlikely(is_hugetlb_entry_migration(entry))) {
> -			migration_entry_wait_huge(vma, mm, ptep);
> +			migration_entry_wait_huge(vma, ptep);
>  			return 0;
>  		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
>  			return VM_FAULT_HWPOISON_LARGE |
> @@ -6907,7 +6907,7 @@ follow_huge_pmd(struct mm_struct *mm, unsigned long address,
>  	} else {
>  		if (is_hugetlb_entry_migration(pte)) {
>  			spin_unlock(ptl);
> -			__migration_entry_wait(mm, (pte_t *)pmd, ptl);
> +			__migration_entry_wait_huge((pte_t *)pmd, ptl);

The unlock+immediate relock looks a bit sub-optimal, but that's already
been that way before your change.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

