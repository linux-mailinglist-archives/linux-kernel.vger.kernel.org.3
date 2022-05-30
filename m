Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EBA53791B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbiE3KKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiE3KKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:10:21 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52BB7A827
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 03:10:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VEnS7ch_1653905414;
Received: from 30.47.200.245(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VEnS7ch_1653905414)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 30 May 2022 18:10:15 +0800
Message-ID: <437e45c5-c46a-46f4-f9cf-d8c2397c988d@linux.alibaba.com>
Date:   Mon, 30 May 2022 18:10:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH 1/3] hugetlb: skip to end of PT page mapping when pte
 not present
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220527225849.284839-1-mike.kravetz@oracle.com>
 <20220527225849.284839-2-mike.kravetz@oracle.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220527225849.284839-2-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/2022 6:58 AM, Mike Kravetz wrote:
> HugeTLB address ranges are linearly scanned during fork, unmap and
> remap operations.  If a non-present entry is encountered, the code
> currently continues to the next huge page aligned address.  However,
> a non-present entry implies that the page table page for that entry
> is not present.  Therefore, the linear scan can skip to the end of
> range mapped by the page table page.  This can speed operations on
> large sparsely populated hugetlb mappings.
> 
> Create a new routine hugetlb_mask_last_hp() that will return an
> address mask.  When the mask is ORed with an address, the result
> will be the address of the last huge page mapped by the associated
> page table page.  Use this mask to update addresses in routines which
> linearly scan hugetlb address ranges when a non-present pte is
> encountered.
> 
> hugetlb_mask_last_hp is related to the implementation of huge_pte_offset
> as hugetlb_mask_last_hp is called when huge_pte_offset returns NULL.
> This patch only provides a complete hugetlb_mask_last_hp implementation
> when CONFIG_ARCH_WANT_GENERAL_HUGETLB is defined.  Architectures which
> provide their own versions of huge_pte_offset can also provide their own
> version of hugetlb_mask_last_hp.

I tested on my ARM64 machine with implementing arm64 specific 
hugetlb_mask_last_hp() as below, and it works well.

Just a few nits inline, otherwise looks good to me.
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index d93ba128a2b0..e04a097ffcc4 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -376,6 +376,28 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
         return NULL;
  }

+unsigned long hugetlb_mask_last_hp(struct hstate *h)
+{
+       unsigned long hp_size = huge_page_size(h);
+
+       switch (hp_size) {
+       case P4D_SIZE:
+               return PGDIR_SIZE - P4D_SIZE;
+       case PUD_SIZE:
+               return P4D_SIZE - PUD_SIZE;
+       case CONT_PMD_SIZE:
+               return PUD_SIZE - CONT_PMD_SIZE;
+       case PMD_SIZE:
+               return PUD_SIZE - PMD_SIZE;
+       case CONT_PTE_SIZE:
+               return PMD_SIZE - CONT_PTE_SIZE;
+       default:
+               break;
+       }
+
+       return ~(0UL);
+}

> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   include/linux/hugetlb.h |  1 +
>   mm/hugetlb.c            | 58 +++++++++++++++++++++++++++++++++++++----
>   2 files changed, 54 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index e4cff27d1198..25078a0ea1d8 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -194,6 +194,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>   			unsigned long addr, unsigned long sz);
>   pte_t *huge_pte_offset(struct mm_struct *mm,
>   		       unsigned long addr, unsigned long sz);
> +unsigned long hugetlb_mask_last_hp(struct hstate *h);
>   int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
>   				unsigned long *addr, pte_t *ptep);
>   void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 7c468ac1d069..a2db878b2255 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4731,6 +4731,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>   	unsigned long npages = pages_per_huge_page(h);
>   	struct address_space *mapping = src_vma->vm_file->f_mapping;
>   	struct mmu_notifier_range range;
> +	unsigned long last_addr_mask;
>   	int ret = 0;
>   
>   	if (cow) {
> @@ -4750,11 +4751,14 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>   		i_mmap_lock_read(mapping);
>   	}
>   
> +	last_addr_mask = hugetlb_mask_last_hp(h);
>   	for (addr = src_vma->vm_start; addr < src_vma->vm_end; addr += sz) {
>   		spinlock_t *src_ptl, *dst_ptl;
>   		src_pte = huge_pte_offset(src, addr, sz);
> -		if (!src_pte)
> +		if (!src_pte) {
> +			addr |= last_addr_mask;
>   			continue;
> +		}
>   		dst_pte = huge_pte_alloc(dst, dst_vma, addr, sz);
>   		if (!dst_pte) {
>   			ret = -ENOMEM;
> @@ -4771,8 +4775,10 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>   		 * after taking the lock below.
>   		 */
>   		dst_entry = huge_ptep_get(dst_pte);
> -		if ((dst_pte == src_pte) || !huge_pte_none(dst_entry))
> +		if ((dst_pte == src_pte) || !huge_pte_none(dst_entry)) {
> +			addr |= last_addr_mask;
>   			continue;
> +		}
>   
>   		dst_ptl = huge_pte_lock(h, dst, dst_pte);
>   		src_ptl = huge_pte_lockptr(h, src, src_pte);
> @@ -4933,6 +4939,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>   	unsigned long sz = huge_page_size(h);
>   	struct mm_struct *mm = vma->vm_mm;
>   	unsigned long old_end = old_addr + len;
> +	unsigned long last_addr_mask;
>   	unsigned long old_addr_copy;
>   	pte_t *src_pte, *dst_pte;
>   	struct mmu_notifier_range range;
> @@ -4948,12 +4955,16 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>   	flush_cache_range(vma, range.start, range.end);
>   
>   	mmu_notifier_invalidate_range_start(&range);
> +	last_addr_mask = hugetlb_mask_last_hp(h);
>   	/* Prevent race with file truncation */
>   	i_mmap_lock_write(mapping);
>   	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
>   		src_pte = huge_pte_offset(mm, old_addr, sz);
> -		if (!src_pte)
> +		if (!src_pte) {
> +			old_addr |= last_addr_mask;
> +			new_addr |= last_addr_mask;
>   			continue;
> +		}
>   		if (huge_pte_none(huge_ptep_get(src_pte)))
>   			continue;
>   
> @@ -4998,6 +5009,7 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
>   	struct hstate *h = hstate_vma(vma);
>   	unsigned long sz = huge_page_size(h);
>   	struct mmu_notifier_range range;
> +	unsigned long last_addr_mask;
>   	bool force_flush = false;
>   
>   	WARN_ON(!is_vm_hugetlb_page(vma));
> @@ -5018,11 +5030,14 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
>   				end);
>   	adjust_range_if_pmd_sharing_possible(vma, &range.start, &range.end);
>   	mmu_notifier_invalidate_range_start(&range);
> +	last_addr_mask = hugetlb_mask_last_hp(h);
>   	address = start;
>   	for (; address < end; address += sz) {
>   		ptep = huge_pte_offset(mm, address, sz);
> -		if (!ptep)
> +		if (!ptep) {
> +			address |= last_addr_mask;
>   			continue;
> +		}
>   
>   		ptl = huge_pte_lock(h, mm, ptep);
>   		if (huge_pmd_unshare(mm, vma, &address, ptep)) {
> @@ -6285,6 +6300,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
>   	unsigned long pages = 0, psize = huge_page_size(h);
>   	bool shared_pmd = false;
>   	struct mmu_notifier_range range;
> +	unsigned long last_addr_mask;
>   	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
>   	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
>   
> @@ -6301,12 +6317,15 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
>   	flush_cache_range(vma, range.start, range.end);
>   
>   	mmu_notifier_invalidate_range_start(&range);
> +	last_addr_mask = hugetlb_mask_last_hp(h);
>   	i_mmap_lock_write(vma->vm_file->f_mapping);
>   	for (; address < end; address += psize) {
>   		spinlock_t *ptl;
>   		ptep = huge_pte_offset(mm, address, psize);
> -		if (!ptep)
> +		if (!ptep) {
> +			address |= last_addr_mask;
>   			continue;
> +		}
>   		ptl = huge_pte_lock(h, mm, ptep);
>   		if (huge_pmd_unshare(mm, vma, &address, ptep)) {
>   			/*
> @@ -6857,6 +6876,35 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
>   	return (pte_t *)pmd;
>   }
>   
> +/*
> + * Return a mask that can be used to update an address to the last huge
> + * page in a page table page mapping size.  Used to skip non-present
> + * page table entries when linearly scanning address ranges.  Architectures
> + * with unique huge page to page table relationships can define their own
> + * version of this routine.
> + */
> +unsigned long hugetlb_mask_last_hp(struct hstate *h)
> +{
> +	unsigned long hp_size = huge_page_size(h);
> +
> +	if (hp_size == P4D_SIZE)
> +		return PGDIR_SIZE - P4D_SIZE;
> +	else if (hp_size == PUD_SIZE)
> +		return P4D_SIZE - PUD_SIZE;
> +	else if (hp_size == PMD_SIZE)
> +		return PUD_SIZE - PMD_SIZE;

Changing to use 'switch' looks more readable?

> +
> +	return ~(0);

Better to return '~(0UL)' to keep function type consistent.

> +}
> +
> +#else
> +
> +/* See description above.  Architectures can provide their own version. */
> +__weak unsigned long hugetlb_mask_last_hp(struct hstate *h)
> +{
> +	return ~(0);

Ditto.
