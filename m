Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFB947CED9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243678AbhLVJKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbhLVJKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:10:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A30EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:10:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16AA061932
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 09:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAEAC36AE5;
        Wed, 22 Dec 2021 09:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640164210;
        bh=JLNqH5TITvgVI7p/ePqT4FK3Ji/sA5RJ201NQZxio4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=mPj9tVDFWTkcaDF5rpB/DNySFge87y2tScnqni6Ul9mbbLC72TM+eJGdYLP2QQQMV
         shRI5af5G9I82ia5S9cRH0j8Qb4G48MfojuEEDmVJo6dT9+dpWI8tctk+eeWSaBbN2
         jhAegiINgwUSoAeDOZdBTl/2NRdtkURqzt5tAYBfmvm1N9zHI+tiyOLkMtvFlupwQ/
         0yuNsWBfW0Ic1ys2U9hyn9u5VXHWsXtttm5vFjLAcZ7dNDgZKZc8zuM4C2yb5NAjof
         /WTpkN9QLCJJoU0MWlF7PFVcaDkJXYn0x6uNpw2s8X/hbtpXM1l/X67VypOINKFK9I
         bi5RMsDkytRCg==
From:   SeongJae Park <sj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon: Add access checking for hugetlb pages
Date:   Wed, 22 Dec 2021 09:10:07 +0000
Message-Id: <20211222091007.16495-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <6afcbd1fda5f9c7c24f320d26a98188c727ceec3.1639623751.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,


Basically, the code looks ok to me.  I left so trivial cosmetic nitpicks below,
though.

On Thu, 16 Dec 2021 18:38:03 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> The process's VMAs can be mapped by hugetlb page, but now the DAMON
> did not implement the access checking for hugetlb pte, so we can not
> get the actual access count like below if a process VMAs were mapped
> by hugetlb.
> 
> damon_aggregated: target_id=18446614368406014464
> nr_regions=12 4194304-5476352: 0 545
> damon_aggregated: target_id=18446614368406014464
> nr_regions=12 140662370467840-140662372970496: 0 545
> damon_aggregated: target_id=18446614368406014464
> nr_regions=12 140662372970496-140662375460864: 0 545
> damon_aggregated: target_id=18446614368406014464
> nr_regions=12 140662375460864-140662377951232: 0 545
> damon_aggregated: target_id=18446614368406014464
> nr_regions=12 140662377951232-140662380449792: 0 545
> damon_aggregated: target_id=18446614368406014464
> nr_regions=12 140662380449792-140662382944256: 0 545
> ......

I'd prefer indenting the program output with 4 spaces and not wrapping it.
e.g.,

    damon_aggregated: target_id=18446614368406014464 nr_regions=12 4194304-5476352: 0 545
    damon_aggregated: target_id=18446614368406014464 nr_regions=12 140662370467840-140662372970496: 0 545


> 
> Thus this patch adds hugetlb access checking support, with this patch
> we can see below VMA mapped by hugetlb access count.
> 
> damon_aggregated: target_id=18446613056935405824
> nr_regions=12 140296486649856-140296489914368: 1 3
> damon_aggregated: target_id=18446613056935405824
> nr_regions=12 140296489914368-140296492978176: 1 3
> damon_aggregated: target_id=18446613056935405824
> nr_regions=12 140296492978176-140296495439872: 1 3
> damon_aggregated: target_id=18446613056935405824
> nr_regions=12 140296495439872-140296498311168: 1 3
> damon_aggregated: target_id=18446613056935405824
> nr_regions=12 140296498311168-140296501198848: 1 3
> damon_aggregated: target_id=18446613056935405824
> nr_regions=12 140296501198848-140296504320000: 1 3
> damon_aggregated: target_id=18446613056935405824
> nr_regions=12 140296504320000-140296507568128: 1 2
> ......

ditto.

> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
> Changes from v1:
>  - Move damon_hugetlb_mkold() to vaddr.c file.
>  - Move some assignments in the variables definitions.
> ---
>  mm/damon/vaddr.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 78ff2bc..69c436b 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -386,8 +386,65 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
>  	return 0;
>  }
>  
> +#ifdef CONFIG_HUGETLB_PAGE
> +static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
> +				struct vm_area_struct *vma, unsigned long addr)
> +{
> +	bool referenced = false;
> +	struct hstate *h = hstate_vma(vma);
> +	pte_t entry = huge_ptep_get(pte);
> +	struct page *page = pte_page(entry);
> +
> +	if (!page)
> +		return;
> +
> +	get_page(page);
> +
> +	if (pte_young(entry)) {
> +		referenced = true;
> +		entry = pte_mkold(entry);
> +		huge_ptep_set_access_flags(vma, addr, pte, entry,
> +					   vma->vm_flags & VM_WRITE);
> +	}
> +
> +#ifdef CONFIG_MMU_NOTIFIER
> +	if (mmu_notifier_clear_young(mm, addr, addr + huge_page_size(h)))
> +		referenced = true;
> +#endif /* CONFIG_MMU_NOTIFIER */
> +
> +	if (referenced)
> +		set_page_young(page);
> +
> +	set_page_idle(page);
> +	put_page(page);
> +}
> +
> +static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
> +				     unsigned long addr, unsigned long end,
> +				     struct mm_walk *walk)
> +{
> +	struct hstate *h = hstate_vma(walk->vma);
> +	spinlock_t *ptl;
> +	pte_t entry;
> +
> +	ptl = huge_pte_lock(h, walk->mm, pte);
> +	entry = huge_ptep_get(pte);
> +	if (!pte_present(entry))
> +		goto out;
> +
> +	damon_hugetlb_mkold(pte, walk->mm, walk->vma, addr);
> +
> +out:
> +	spin_unlock(ptl);
> +	return 0;
> +}
> +#else
> +#define damon_mkold_hugetlb_entry NULL
> +#endif

Could we append a comment saying this #endif is for #ifdef CONFIG_HUGETLB_PAGE,
like below?

    #endif	/* CONFIG_HUGETLB_PAGE */

> +
>  static const struct mm_walk_ops damon_mkold_ops = {
>  	.pmd_entry = damon_mkold_pmd_entry,
> +	.hugetlb_entry = damon_mkold_hugetlb_entry,
>  };
>  
>  static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
> @@ -482,8 +539,47 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
>  	return 0;
>  }
>  
> +#ifdef CONFIG_HUGETLB_PAGE
> +static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
> +				     unsigned long addr, unsigned long end,
> +				     struct mm_walk *walk)
> +{
> +	struct damon_young_walk_private *priv = walk->private;
> +	struct hstate *h = hstate_vma(walk->vma);
> +	struct page *page;
> +	spinlock_t *ptl;
> +	pte_t entry;
> +
> +	ptl = huge_pte_lock(h, walk->mm, pte);
> +	entry = huge_ptep_get(pte);
> +	if (!pte_present(entry))
> +		goto out;
> +
> +	page = pte_page(entry);
> +	if (!page)
> +		goto out;
> +
> +	get_page(page);
> +
> +	if (pte_young(entry) || !page_is_idle(page) ||
> +	    mmu_notifier_test_young(walk->mm, addr)) {
> +		*priv->page_sz = huge_page_size(h);
> +		priv->young = true;
> +	}
> +
> +	put_page(page);
> +
> +out:
> +	spin_unlock(ptl);
> +	return 0;
> +}
> +#else
> +#define damon_young_hugetlb_entry NULL
> +#endif

ditto.

> +
>  static const struct mm_walk_ops damon_young_ops = {
>  	.pmd_entry = damon_young_pmd_entry,
> +	.hugetlb_entry = damon_young_hugetlb_entry,
>  };
>  
>  static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
> -- 
> 1.8.3.1
