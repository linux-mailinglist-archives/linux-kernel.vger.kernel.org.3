Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE70C5A0E80
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241267AbiHYKyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240996AbiHYKyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:54:03 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D16CADCC2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:54:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VNDJSvi_1661424837;
Received: from 30.97.48.44(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VNDJSvi_1661424837)
          by smtp.aliyun-inc.com;
          Thu, 25 Aug 2022 18:53:58 +0800
Message-ID: <9b5b9b7a-3cba-37a1-411a-5031a67208fe@linux.alibaba.com>
Date:   Thu, 25 Aug 2022 18:54:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/5] mm/hugetlb: fix races when looking up a CONT-PTE
 size hugetlb page
To:     David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1661240170.git.baolin.wang@linux.alibaba.com>
 <0e5d92da043d147a867f634b17acbcc97a7f0e64.1661240170.git.baolin.wang@linux.alibaba.com>
 <4c24b891-04ce-2608-79d2-a75dc236533f@redhat.com>
 <376d2e0a-d28a-984b-903c-1f6451b04a15@linux.alibaba.com>
 <7d4e7f47-30a5-3cc6-dc9f-aa89120847d8@redhat.com> <YwVo7xSO+VebkIfQ@monkey>
 <64669c0a-4a6e-f034-a15b-c4a8deea9e5d@linux.alibaba.com>
 <7ee73879-e402-9175-eae8-41471d80d59e@redhat.com>
 <f7544713-d856-0875-41dd-52a5c27ba015@linux.alibaba.com>
 <Ywa1jp/6naTmUh42@monkey> <887ca2e2-a7c5-93a7-46cb-185daccd4444@redhat.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <887ca2e2-a7c5-93a7-46cb-185daccd4444@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/25/2022 3:25 PM, David Hildenbrand wrote:
>> Is the primary concern the locking?  If so, I am not sure we have an issue.
>> As mentioned in your commit message, current code will use
>> pte_offset_map_lock().  pte_offset_map_lock uses pte_lockptr, and pte_lockptr
>> will either be the mm wide lock or pmd_page lock.  To me, it seems that
>> either would provide correct synchronization for CONT-PTE entries.  Am I
>> missing something or misreading the code?
>>
>> I started looking at code cleanup suggested by David.  Here is a quick
>> patch (not tested and likely containing errors) to see if this is a step
>> in the right direction.
>>
>> I like it because we get rid of/combine all those follow_huge_p*d
>> routines.
>>
> 
> Yes, see comments below.
> 
>>  From 35d117a707c1567ddf350554298697d40eace0d7 Mon Sep 17 00:00:00 2001
>> From: Mike Kravetz <mike.kravetz@oracle.com>
>> Date: Wed, 24 Aug 2022 15:59:15 -0700
>> Subject: [PATCH] hugetlb: call hugetlb_follow_page_mask for hugetlb pages in
>>   follow_page_mask
>>
>> At the beginning of follow_page_mask, there currently is a call to
>> follow_huge_addr which 'may' handle hugetlb pages.  ia64 is the only
>> architecture which (incorrectly) provides a follow_huge_addr routine
>> that does not return error.  Instead, at each level of the page table a
>> check is made for a hugetlb entry.  If a hugetlb entry is found, a call
>> to a routine associated with that page table level such as
>> follow_huge_pmd is made.
>>
>> All the follow_huge_p*d routines are basically the same.  In addition
>> huge page size can be derived from the vma, so we know where in the page
>> table a huge page would reside.  So, replace follow_huge_addr with a
>> new architecture independent routine which will provide the same
>> functionality as the follow_huge_p*d routines.  We can then eliminate
>> the p*d_huge checks in follow_page_mask page table walking as well as
>> the follow_huge_p*d routines themselves.>
>> follow_page_mask still has is_hugepd hugetlb checks during page table
>> walking.  This is due to these checks and follow_huge_pd being
>> architecture specific.  These can be eliminated if
>> hugetlb_follow_page_mask can be overwritten by architectures (powerpc)
>> that need to do follow_huge_pd processing.
> 
> But won't the
> 
>> +	/* hugetlb is special */
>> +	if (is_vm_hugetlb_page(vma))
>> +		return hugetlb_follow_page_mask(vma, address, flags);
> 
> code route everything via hugetlb_follow_page_mask() and all these
> (beloved) hugepd checks would essentially be unreachable?
> 
> At least my understanding is that hugepd only applies to hugetlb.
> 
> Can't we move the hugepd handling code into hugetlb_follow_page_mask()
> as well?
> 
> I mean, doesn't follow_hugetlb_page() also have to handle that hugepd
> stuff already ... ?

Yes, I also think about this, and I did a simple patch (without testing) 
based on Mike's patch to make it more clean.

diff --git a/mm/gup.c b/mm/gup.c
index d3239ea63159..1003c03dcf78 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -626,14 +626,7 @@ static struct page *follow_pmd_mask(struct 
vm_area_struct *vma,
         pmdval = READ_ONCE(*pmd);
         if (pmd_none(pmdval))
                 return no_page_table(vma, flags);
-       if (is_hugepd(__hugepd(pmd_val(pmdval)))) {
-               page = follow_huge_pd(vma, address,
-                                     __hugepd(pmd_val(pmdval)), flags,
-                                     PMD_SHIFT);
-               if (page)
-                       return page;
-               return no_page_table(vma, flags);
-       }
+
  retry:
         if (!pmd_present(pmdval)) {
                 /*
@@ -723,14 +716,6 @@ static struct page *follow_pud_mask(struct 
vm_area_struct *vma,
         pud = pud_offset(p4dp, address);
         if (pud_none(*pud))
                 return no_page_table(vma, flags);
-       if (is_hugepd(__hugepd(pud_val(*pud)))) {
-               page = follow_huge_pd(vma, address,
-                                     __hugepd(pud_val(*pud)), flags,
-                                     PUD_SHIFT);
-               if (page)
-                       return page;
-               return no_page_table(vma, flags);
-       }
         if (pud_devmap(*pud)) {
                 ptl = pud_lock(mm, pud);
                 page = follow_devmap_pud(vma, address, pud, flags, 
&ctx->pgmap);
@@ -759,14 +744,6 @@ static struct page *follow_p4d_mask(struct 
vm_area_struct *vma,
         if (unlikely(p4d_bad(*p4d)))
                 return no_page_table(vma, flags);

-       if (is_hugepd(__hugepd(p4d_val(*p4d)))) {
-               page = follow_huge_pd(vma, address,
-                                     __hugepd(p4d_val(*p4d)), flags,
-                                     P4D_SHIFT);
-               if (page)
-                       return page;
-               return no_page_table(vma, flags);
-       }
         return follow_pud_mask(vma, address, p4d, flags, ctx);
  }

@@ -813,15 +790,6 @@ static struct page *follow_page_mask(struct 
vm_area_struct *vma,
         if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
                 return no_page_table(vma, flags);

-       if (is_hugepd(__hugepd(pgd_val(*pgd)))) {
-               page = follow_huge_pd(vma, address,
-                                     __hugepd(pgd_val(*pgd)), flags,
-                                     PGDIR_SHIFT);
-               if (page)
-                       return page;
-               return no_page_table(vma, flags);
-       }
-
         return follow_p4d_mask(vma, address, pgd, flags, ctx);
  }

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2c107e7ebd66..848b4fb7a05d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6118,6 +6118,81 @@ static inline bool 
__follow_hugetlb_must_fault(unsigned int flags, pte_t *pte,
         return false;
  }

+static struct page *hugetlb_follow_hugepd(struct vm_area_struct *vma,
+                                         unsigned long address,
+                                         unsigned int flags)
+{
+       struct mm_struct *mm = vma->vm_mm;
+       struct page *page;
+       pgd_t *pgd;
+       p4d_t *p4d;
+       pud_t *pud;
+       pmd_t *pmd;
+
+       pgd = pgd_offset(mm, address);
+       if (pgd_none(*pgd) || pgd_bad(*pgd))
+               return ERR_PTR(-EFAULT);
+
+       if (pgd_huge(*pgd))
+               return NULL;
+
+       if (is_hugepd(__hugepd(pgd_val(*pgd)))) {
+               page = follow_huge_pd(vma, address,
+                                     __hugepd(pgd_val(*pgd)), flags,
+                                     PGDIR_SHIFT);
+               if (page)
+                       return page;
+               return ERR_PTR(-EFAULT);
+       }
+
+       p4d = p4d_offset(pgd, address);
+       if (p4d_none(*p4d) || p4d_bad(*p4d))
+               return ERR_PTR(-EFAULT);
+
+       if (is_hugepd(__hugepd(p4d_val(*p4d)))) {
+               page = follow_huge_pd(vma, address,
+                                     __hugepd(p4d_val(*p4d)), flags,
+                                     P4D_SHIFT);
+               if (page)
+                       return page;
+               return ERR_PTR(-EFAULT);
+       }
+
+       pud = pud_offset(p4d, address);
+       if (pud_none(*pud) || pud_bad(*pud))
+               return ERR_PTR(-EFAULT);
+
+       if (pud_huge(*pud))
+               return NULL;
+
+       if (is_hugepd(__hugepd(pud_val(*pud)))) {
+               page = follow_huge_pd(vma, address,
+                                     __hugepd(pud_val(*pud)), flags,
+                                     PUD_SHIFT);
+               if (page)
+                       return page;
+               return ERR_PTR(-EFAULT);
+       }
+
+       pmd = pmd_offset(pud, address);+       if (pmd_none(*pmd) || 
pmd_bad(*pmd))
+                return ERR_PTR(-EFAULT);
+
+       if (pmd_huge(*pmd))
+               return NULL;
+
+       if (is_hugepd(__hugepd(pmd_val(*pmd)))) {
+               page = follow_huge_pd(vma, address,
+                                     __hugepd(pmd_val(*pmd)), flags,
+                                     PMD_SHIFT);
+               if (page)
+                       return page;
+               return ERR_PTR(-EFAULT);
+       }
+
+       return NULL;
+}
+
  struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
                                 unsigned long address, unsigned int flags)
  {
@@ -6135,6 +6210,10 @@ struct page *hugetlb_follow_page_mask(struct 
vm_area_struct *vma,
         if (WARN_ON_ONCE(flags & FOLL_PIN))
                 return NULL;

+       page = hugetlb_follow_hugepd(vma, address, flags);
+       if (page)
+               return page;
+
         pte = huge_pte_offset(mm, haddr, huge_page_size(h));
         if (!pte)
                 return NULL;


>>   
>> +struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>> +				unsigned long address, unsigned int flags)
>> +{
>> +	struct hstate *h = hstate_vma(vma);
>> +	struct mm_struct *mm = vma->vm_mm;
>> +	unsigned long haddr = address & huge_page_mask(h);
>> +	struct page *page = NULL;
>> +	spinlock_t *ptl;
>> +	pte_t *pte, entry;
>> +
>> +	/*
>> +	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
>> +	 * follow_hugetlb_page().
>> +	 */
>> +	if (WARN_ON_ONCE(flags & FOLL_PIN))
>> +		return NULL;
>> +
>> +	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
>> +	if (!pte)
>> +		return NULL;
>> +
>> +retry:
>> +	ptl = huge_pte_lock(h, mm, pte);
>> +	entry = huge_ptep_get(pte);
>> +	if (pte_present(entry)) {
>> +		page = pte_page(entry);
>> +		/*
>> +		 * try_grab_page() should always succeed here, because we hold
>> +		 * the ptl lock and have verified pte_present().
>> +		 */
>> +		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
>> +			page = NULL;
>> +			goto out;
>> +		}
>> +	} else {
>> +		if (is_hugetlb_entry_migration(entry)) {
>> +			spin_unlock(ptl);
>> +			__migration_entry_wait_huge(pte, ptl);
>> +			goto retry;
>> +		}
>> +		/*
>> +		 * hwpoisoned entry is treated as no_page_table in
>> +		 * follow_page_mask().
>> +		 */
>> +	}
>> +out:
>> +	spin_unlock(ptl);
>> +	return page;
> 
> 
> This is neat and clean enough to not reuse follow_hugetlb_page(). I
> wonder if we want to add some comment to the function how this differs
> to follow_hugetlb_page().
> 
> ... or do we maybe want to rename follow_hugetlb_page() to someting like
> __hugetlb_get_user_pages() to make it clearer in which context it will
> get called?

Sounds reasonable to me.

> I guess it might be feasible in the future to eliminate
> follow_hugetlb_page() and centralizing the faulting code. For now, this
> certainly improves the situation.
> 
