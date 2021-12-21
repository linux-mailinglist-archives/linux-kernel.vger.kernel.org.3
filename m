Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6DE47C0B8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238177AbhLUNYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:24:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56460 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238226AbhLUNYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:24:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B4C0B816AD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 13:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB65C36AE8;
        Tue, 21 Dec 2021 13:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640093083;
        bh=0p0GBbh9OIzW55YKUeVeBjY9r31CqJNcU7kpK7AiRx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=SXBmsM56fGHT+Bth4Z5L6YojgaXCY2VJUkNenVrfpcUPAb/cqGfTs+N+kIl3t728z
         HkDgzNUlyvYggG2mSdMJiLB+JBnSgAjxTlcyMK+QVDReyFw6N23eO7jx+2w+fmMTkk
         A4nHbkf6oHxiUxsdpDU+6ZSfYlN/AGW8d2quHSQc2mD0wofHtc4IEXvsEjBsm+Nw9v
         EdZLZ6OsPTsTRd6CjYDw0XdqgdpFL0m3Tm1sWZPsRwZQ7WMLyLirRILuufCp/2/G2J
         aHeKf+kSrrRdGD1GYXBGH/a3Acel89QXFGqbuNnxk/YJC1TzifWVcg+p1ozS3NBDCt
         ZDk2wytD4riVw==
From:   SeongJae Park <sj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, ying.huang@intel.com,
        dave.hansen@linux.intel.com, ziy@nvidia.com, shy828301@gmail.com,
        zhongjiang-ali@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/damon: Add a new scheme to support demotion on tiered memory system
Date:   Tue, 21 Dec 2021 13:24:39 +0000
Message-Id: <20211221132439.14997-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1c014ce5c6f6c62a30d07096c5e28aa1310c1bbd.1640077468.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,


Thank you for this great patch!  I left some comments below.

On Tue, 21 Dec 2021 17:18:04 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> On tiered memory system, the reclaim path in shrink_page_list() already
> support demoting pages to slow memory node instead of discarding the
> pages. However, at that time the fast memory node memory wartermark is
> already tense, which will increase the memory allocation latency during
> page demotion.
> 
> We can rely on the DAMON in user space to help to monitor the cold
> memory on fast memory node, and demote the cold pages to slow memory
> node proactively to keep the fast memory node in a healthy state.
> Thus this patch introduces a new scheme named DAMOS_DEMOTE to support
> this feature.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  include/linux/damon.h |   3 +
>  mm/damon/dbgfs.c      |   1 +
>  mm/damon/vaddr.c      | 156 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 160 insertions(+)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index af64838..da9957c 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -87,6 +87,8 @@ struct damon_target {
>   * @DAMOS_PAGEOUT:	Call ``madvise()`` for the region with MADV_PAGEOUT.
>   * @DAMOS_HUGEPAGE:	Call ``madvise()`` for the region with MADV_HUGEPAGE.
>   * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
> + * @DAMOS_DEMOTE:	Migate cold pages from fast memory type (DRAM) to slow
> + * memory type (persistent memory).

s/Migate/Migrate/

Also, could you make the second line of the description aligned with the first
line? e.g.,

    + * @DAMOS_DEMOTE:	Migate cold pages from fast memory type (DRAM) to slow
    + *                 memory type (persistent memory).

>   * @DAMOS_STAT:		Do nothing but count the stat.
>   */
>  enum damos_action {
> @@ -95,6 +97,7 @@ enum damos_action {
>  	DAMOS_PAGEOUT,
>  	DAMOS_HUGEPAGE,
>  	DAMOS_NOHUGEPAGE,
> +	DAMOS_DEMOTE,
>  	DAMOS_STAT,		/* Do nothing but only record the stat */

This would make user space people who were using 'DAMOS_STAT' be confused.
Could you put 'DAMOS_DEMOTE' after 'DAMOS_STAT'?

>  };
>  
> diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
> index 58dbb96..43355ab 100644
> --- a/mm/damon/dbgfs.c
> +++ b/mm/damon/dbgfs.c
> @@ -168,6 +168,7 @@ static bool damos_action_valid(int action)
>  	case DAMOS_PAGEOUT:
>  	case DAMOS_HUGEPAGE:
>  	case DAMOS_NOHUGEPAGE:
> +	case DAMOS_DEMOTE:
>  	case DAMOS_STAT:
>  		return true;
>  	default:
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 9e213a1..b354d3e 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -14,6 +14,10 @@
>  #include <linux/page_idle.h>
>  #include <linux/pagewalk.h>
>  #include <linux/sched/mm.h>
> +#include <linux/migrate.h>
> +#include <linux/mm_inline.h>
> +#include <linux/swapops.h>
> +#include "../internal.h"
>  
>  #include "prmtv-common.h"
>  
> @@ -693,6 +697,156 @@ static unsigned long damos_madvise(struct damon_target *target,
>  }
>  #endif	/* CONFIG_ADVISE_SYSCALLS */
>  
> +static bool damos_isolate_page(struct page *page, struct list_head *demote_list)
> +{
> +	struct page *head = compound_head(page);
> +
> +	/* Do not interfere with other mappings of this page */
> +	if (page_mapcount(head) != 1)
> +		return false;
> +
> +	/* No need migration if the target demotion node is empty. */
> +	if (next_demotion_node(page_to_nid(head)) == NUMA_NO_NODE)
> +		return false;
> +
> +	if (isolate_lru_page(head))
> +		return false;
> +
> +	list_add_tail(&head->lru, demote_list);
> +	mod_node_page_state(page_pgdat(head),
> +			    NR_ISOLATED_ANON + page_is_file_lru(head),
> +			    thp_nr_pages(head));
> +	return true;

The return value is not used by callers.  If not needed, let's remove it.

> +}
> +
> +static int damos_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
> +				   unsigned long end, struct mm_walk *walk)
> +{
> +	struct vm_area_struct *vma = walk->vma;
> +	struct list_head *demote_list = walk->private;
> +	spinlock_t *ptl;
> +	struct page *page;
> +	pte_t *pte, *mapped_pte;
> +
> +	if (!vma_migratable(vma))
> +		return -EFAULT;
> +
> +	ptl = pmd_trans_huge_lock(pmd, vma);
> +	if (ptl) {
> +		/* Bail out if THP migration is not supported. */
> +		if (!thp_migration_supported())
> +			goto thp_out;
> +
> +		/* If the THP pte is under migration, do not bother it. */
> +		if (unlikely(is_pmd_migration_entry(*pmd)))
> +			goto thp_out;
> +
> +		page = damon_get_page(pmd_pfn(*pmd));
> +		if (!page)
> +			goto thp_out;
> +
> +		damos_isolate_page(page, demote_list);
> +
> +		put_page(page);
> +thp_out:
> +		spin_unlock(ptl);
> +		return 0;
> +	}

Could we wrap above THP handling code with '#ifdef CONFIG_TRANSPARENT_HUGEPAGE'?

> +
> +	/* regular page handling */
> +	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
> +		return -EINVAL;
> +
> +	mapped_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> +	for (; addr != end; pte++, addr += PAGE_SIZE) {
> +		if (pte_none(*pte) || !pte_present(*pte))
> +			continue;
> +
> +		page = damon_get_page(pte_pfn(*pte));
> +		if (!page)
> +			continue;
> +
> +		damos_isolate_page(page, demote_list);
> +		put_page(page);
> +	}
> +	pte_unmap_unlock(mapped_pte, ptl);
> +	cond_resched();
> +
> +	return 0;
> +}
> +
> +static const struct mm_walk_ops damos_migrate_pages_walk_ops = {
> +	.pmd_entry              = damos_migrate_pmd_entry,

The names are little bit confusing to me.  How about 's/migrate/isolate/'?

> +};
> +
> +/*
> + * damos_demote() - demote cold pages from fast memory to slow memory
> + * @target:    the given target
> + * @r:         region of the target
> + *
> + * On tiered memory system, if DAMON monitored cold pages on fast memory
> + * node (DRAM), we can demote them to slow memory node proactively in case
> + * accumulating much more cold memory on fast memory node (DRAM) to reclaim.
> + *
> + * Return:
> + * = 0 means no pages were demoted.
> + * > 0 means how many cold pages were demoted successfully.
> + * < 0 means errors happened.

damon_va_apply_scheme(), which returns what this function returns when
DAMOS_DEMOTE action is given, should return bytes of the region that the action
is successfully applied.

> + */
> +static int damos_demote(struct damon_target *target, struct damon_region *r)
> +{
> +	struct mm_struct *mm;
> +	LIST_HEAD(demote_pages);
> +	LIST_HEAD(pagelist);
> +	int target_nid, nr_pages, ret = 0;
> +	unsigned int nr_succeeded, demoted_pages = 0;
> +	struct page *page, *page2;
> +
> +	/* Validate if allowing to do page demotion */
> +	if (!numa_demotion_enabled)
> +		return -EINVAL;
> +
> +	mm = damon_get_mm(target);
> +	if (!mm)
> +		return -ENOMEM;
> +
> +	mmap_read_lock(mm);
> +	walk_page_range(mm, PAGE_ALIGN(r->ar.start), PAGE_ALIGN(r->ar.end),

I guess PAGE_ALIGN()s are not necessary here?

> +			&damos_migrate_pages_walk_ops, &demote_pages);
> +	mmap_read_unlock(mm);
> +
> +	mmput(mm);
> +	if (list_empty(&demote_pages))
> +		return 0;
> +
> +	list_for_each_entry_safe(page, page2, &demote_pages, lru) {

I'd prefer 'next' or 'next_page' instead of 'page2'.

> +		list_add(&page->lru, &pagelist);
> +		target_nid = next_demotion_node(page_to_nid(page));
> +		nr_pages = thp_nr_pages(page);
> +
> +		ret = migrate_pages(&pagelist, alloc_demote_page, NULL,
> +				    target_nid, MIGRATE_SYNC, MR_DEMOTION,
> +				    &nr_succeeded);
> +		if (ret) {
> +			if (!list_empty(&pagelist)) {
> +				list_del(&page->lru);
> +				mod_node_page_state(page_pgdat(page),
> +						    NR_ISOLATED_ANON + page_is_file_lru(page),
> +						    -nr_pages);
> +				putback_lru_page(page);
> +			}
> +		} else {
> +			__count_vm_events(PGDEMOTE_DIRECT, nr_succeeded);
> +			demoted_pages += nr_succeeded;
> +		}

Why should we do above work for each page on our own instead of exporting and
calling 'demote_page_list()'?


Thanks,
SJ

> +
> +		INIT_LIST_HEAD(&pagelist);
> +		cond_resched();
> +	}
> +
> +	return demoted_pages;
> +}
> +
>  static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
>  		struct damon_target *t, struct damon_region *r,
>  		struct damos *scheme)
> @@ -715,6 +869,8 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
>  	case DAMOS_NOHUGEPAGE:
>  		madv_action = MADV_NOHUGEPAGE;
>  		break;
> +	case DAMOS_DEMOTE:
> +		return damos_demote(t, r);
>  	case DAMOS_STAT:
>  		return 0;
>  	default:
> -- 
> 1.8.3.1
