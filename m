Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D773515DA7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 15:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382803AbiD3Niz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 09:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241968AbiD3Nig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:38:36 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA58E13
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 06:35:14 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y38so9064771pfa.6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 06:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HQ59R31kOZxcptZQ/S5iazOxCiS3izDuAYFbVd8n5/E=;
        b=069McI4DqR70XB3lIDxTUYctr70jsgeTteu9YrPkryeuCdx5reEP5fsrwymoWOztw0
         UeacU9zAQAPbNv7GDh66Z6jn6K1L63pamKDQZbfImlOn6hHqtmNb4ofb2OkWugzt199f
         jqMTrTWtn1ei+Rz+J0TYmpapdXx32AvycWXHPUd3jSYaK7B5GJKw2aTyXoT4aAdpOvzq
         1/FgH64mmfuA/zm8GlAqH6C42e+yRk2rIkYybNE77mMNpwZ77ux8m9D0O08+RhW4pvqX
         I8oWSX2QXZ+jZcH9xaUIJOWUSsWaPtg3YFtYQwzxGu4T9pOls3nmfVLOomr+RQvUUNzy
         pmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HQ59R31kOZxcptZQ/S5iazOxCiS3izDuAYFbVd8n5/E=;
        b=nqjxorQWvmnppNS1VitsdKb/Wj+ofjGy/vUc5WAH9Aw1BvXF8KLAO0vnBb8VYX318V
         l1uP7oMpIMOmbrqG6YE+3rZswc0LIowXegXxfO6GyTYgIWMMZ5AeE2M6hHH51icvk1v4
         tQmW6KRv26Iffec71i4chymaNMGYZGskRPNFIXG0O0CxyedfNA+7XJ6DjUFayjCHRXQC
         Ri5ZvcFNDddqBvM1Q/E9pDFGO8gGeVZnntFfFcd2bh9+07mqhqCMcfoRLI2VsoBQSYyu
         e/9OE78wsUvNnuvuvSG/WNfryfFMnOgmevbk4xXbBcGJFJ/2RO7Nby2yme5XiC/C7+Mc
         Qhbg==
X-Gm-Message-State: AOAM532Eqozrtp3zeykUcCakgwXbHv1tAT0TUoCgFJ/m+l483LZ9VOT+
        Rtb1cHlI7BLd1iqNSntklXmKWg==
X-Google-Smtp-Source: ABdhPJw+GOcmPoRu8CvP5yUGeeT5/UT0/kkYaRyU2YknYleqFK6MVAW8Aww/4XsGKgnRkkTxY7ozXg==
X-Received: by 2002:a63:1711:0:b0:3a6:d2df:65f6 with SMTP id x17-20020a631711000000b003a6d2df65f6mr3141798pgl.72.1651325713814;
        Sat, 30 Apr 2022 06:35:13 -0700 (PDT)
Received: from [10.254.246.218] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a71cb00b001cd4989feebsm16625792pjs.55.2022.04.30.06.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Apr 2022 06:35:13 -0700 (PDT)
Message-ID: <a0b0b3f0-f10e-2832-f494-7cd111d038ff@bytedance.com>
Date:   Sat, 30 Apr 2022 21:35:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [RFC PATCH 13/18] mm: add try_to_free_user_pte() helper
Content-Language: en-US
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, david@redhat.com, jgg@nvidia.com,
        tj@kernel.org, dennis@kernel.org, ming.lei@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com
References: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
 <20220429133552.33768-14-zhengqi.arch@bytedance.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20220429133552.33768-14-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/29 9:35 PM, Qi Zheng wrote:
> Normally, the percpu_ref of the user PTE page table page is in
> percpu mode. This patch add try_to_free_user_pte() to switch
> the percpu_ref to atomic mode and check if it is 0. If the
> percpu_ref is 0, which means that no one is using the user PTE
> page table page, then we can safely reclaim it.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   include/linux/pte_ref.h |  7 +++
>   mm/pte_ref.c            | 99 ++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 104 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/pte_ref.h b/include/linux/pte_ref.h
> index bfe620038699..379c3b45a6ab 100644
> --- a/include/linux/pte_ref.h
> +++ b/include/linux/pte_ref.h
> @@ -16,6 +16,8 @@ void free_user_pte(struct mm_struct *mm, pmd_t *pmd, unsigned long addr);
>   bool pte_tryget(struct mm_struct *mm, pmd_t *pmd, unsigned long addr);
>   void __pte_put(pgtable_t page);
>   void pte_put(pte_t *ptep);
> +void try_to_free_user_pte(struct mm_struct *mm, pmd_t *pmd, unsigned long addr,
> +			  bool switch_back);
>   
>   #else /* !CONFIG_FREE_USER_PTE */
>   
> @@ -47,6 +49,11 @@ static inline void pte_put(pte_t *ptep)
>   {
>   }
>   
> +static inline void try_to_free_user_pte(struct mm_struct *mm, pmd_t *pmd,
> +					unsigned long addr, bool switch_back)
> +{
> +}
> +
>   #endif /* CONFIG_FREE_USER_PTE */
>   
>   #endif /* _LINUX_PTE_REF_H */
> diff --git a/mm/pte_ref.c b/mm/pte_ref.c
> index 5b382445561e..bf9629272c71 100644
> --- a/mm/pte_ref.c
> +++ b/mm/pte_ref.c
> @@ -8,6 +8,9 @@
>   #include <linux/pte_ref.h>
>   #include <linux/percpu-refcount.h>
>   #include <linux/slab.h>
> +#include <linux/hugetlb.h>
> +#include <asm/tlbflush.h>
> +#include <asm/pgalloc.h>
>   
>   #ifdef CONFIG_FREE_USER_PTE
>   
> @@ -44,8 +47,6 @@ void pte_ref_free(pgtable_t pte)
>   	kfree(ref);
>   }
>   
> -void free_user_pte(struct mm_struct *mm, pmd_t *pmd, unsigned long addr) {}
> -
>   /*
>    * pte_tryget - try to get the pte_ref of the user PTE page table page
>    * @mm: pointer the target address space
> @@ -102,4 +103,98 @@ void pte_put(pte_t *ptep)
>   }
>   EXPORT_SYMBOL(pte_put);
>   
> +#ifdef CONFIG_DEBUG_VM
> +void pte_free_debug(pmd_t pmd)
> +{
> +	pte_t *ptep = (pte_t *)pmd_page_vaddr(pmd);
> +	int i = 0;
> +
> +	for (i = 0; i < PTRS_PER_PTE; i++)
> +		BUG_ON(!pte_none(*ptep++));
> +}
> +#else
> +static inline void pte_free_debug(pmd_t pmd)
> +{
> +}
> +#endif
> +
> +static inline void pte_free_rcu(struct rcu_head *rcu)
> +{
> +	struct page *page = container_of(rcu, struct page, rcu_head);
> +
> +	pgtable_pte_page_dtor(page);
> +	__free_page(page);
> +}
> +
> +/*
> + * free_user_pte - free the user PTE page table page
> + * @mm: pointer the target address space
> + * @pmd: pointer to a PMD
> + * @addr: start address of the tlb range to be flushed
> + *
> + * Context: The pmd range has been unmapped and TLB purged. And the user PTE
> + *	    page table page will be freed by rcu handler.
> + */
> +void free_user_pte(struct mm_struct *mm, pmd_t *pmd, unsigned long addr)
> +{
> +	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
> +	spinlock_t *ptl;
> +	pmd_t pmdval;
> +
> +	ptl = pmd_lock(mm, pmd);
> +	pmdval = *pmd;
> +	if (pmd_none(pmdval) || pmd_leaf(pmdval)) {
> +		spin_unlock(ptl);
> +		return;
> +	}
> +	pmd_clear(pmd);
> +	flush_tlb_range(&vma, addr, addr + PMD_SIZE);
> +	spin_unlock(ptl);
> +
> +	pte_free_debug(pmdval);
> +	mm_dec_nr_ptes(mm);
> +	call_rcu(&pmd_pgtable(pmdval)->rcu_head, pte_free_rcu);
> +}
> +
> +/*
> + * try_to_free_user_pte - try to free the user PTE page table page
> + * @mm: pointer the target address space
> + * @pmd: pointer to a PMD
> + * @addr: virtual address associated with pmd
> + * @switch_back: indicates if switching back to percpu mode is required
> + */
> +void try_to_free_user_pte(struct mm_struct *mm, pmd_t *pmd, unsigned long addr,
> +			  bool switch_back)
> +{
> +	pgtable_t pte;
> +
> +	if (&init_mm == mm)
> +		return;
> +
> +	if (!pte_tryget(mm, pmd, addr))
> +		return;
> +	pte = pmd_pgtable(*pmd);
> +	percpu_ref_switch_to_atomic_sync(pte->pte_ref);
> +	rcu_read_lock();
> +	/*
> +	 * Here we can safely put the pte_ref because we already hold the rcu
> +	 * lock, which guarantees that the user PTE page table page will not
> +	 * be released.
> +	 */
> +	__pte_put(pte);
> +	if (percpu_ref_is_zero(pte->pte_ref)) {
> +		rcu_read_unlock();
> +		free_user_pte(mm, pmd, addr & PMD_MASK);
> +		return;
> +	}
> +	rcu_read_unlock();
> +
> +	if (switch_back) {
> +		if (pte_tryget(mm, pmd, addr)) {
> +			percpu_ref_switch_to_percpu(pte->pte_ref);
> +			__pte_put(pte);
> +		}
> +	}

We shouldn't switch back to percpu mode here, it will drastically reduce
performance.

> +}
> +
>   #endif /* CONFIG_FREE_USER_PTE */

-- 
Thanks,
Qi
