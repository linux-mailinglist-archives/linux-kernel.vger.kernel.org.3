Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA9247C14B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238128AbhLUOR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:17:27 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:55020 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231443AbhLUOR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:17:26 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V.LT0oR_1640096242;
Received: from 30.39.136.247(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V.LT0oR_1640096242)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Dec 2021 22:17:23 +0800
Message-ID: <248bd960-39b8-bbe1-ac45-bc0893acc40f@linux.alibaba.com>
Date:   Tue, 21 Dec 2021 22:18:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] mm/damon: Add a new scheme to support demotion on
 tiered memory system
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, ying.huang@intel.com,
        dave.hansen@linux.intel.com, ziy@nvidia.com, shy828301@gmail.com,
        zhongjiang-ali@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20211221132439.14997-1-sj@kernel.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20211221132439.14997-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SeongJae,

On 12/21/2021 9:24 PM, SeongJae Park Wrote:
> Hi Baolin,
> 
> 
> Thank you for this great patch!  I left some comments below.
> 
> On Tue, 21 Dec 2021 17:18:04 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>> On tiered memory system, the reclaim path in shrink_page_list() already
>> support demoting pages to slow memory node instead of discarding the
>> pages. However, at that time the fast memory node memory wartermark is
>> already tense, which will increase the memory allocation latency during
>> page demotion.
>>
>> We can rely on the DAMON in user space to help to monitor the cold
>> memory on fast memory node, and demote the cold pages to slow memory
>> node proactively to keep the fast memory node in a healthy state.
>> Thus this patch introduces a new scheme named DAMOS_DEMOTE to support
>> this feature.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   include/linux/damon.h |   3 +
>>   mm/damon/dbgfs.c      |   1 +
>>   mm/damon/vaddr.c      | 156 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 160 insertions(+)
>>
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index af64838..da9957c 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -87,6 +87,8 @@ struct damon_target {
>>    * @DAMOS_PAGEOUT:	Call ``madvise()`` for the region with MADV_PAGEOUT.
>>    * @DAMOS_HUGEPAGE:	Call ``madvise()`` for the region with MADV_HUGEPAGE.
>>    * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
>> + * @DAMOS_DEMOTE:	Migate cold pages from fast memory type (DRAM) to slow
>> + * memory type (persistent memory).
> 
> s/Migate/Migrate/
> 
> Also, could you make the second line of the description aligned with the first
> line? e.g.,
> 
>      + * @DAMOS_DEMOTE:	Migate cold pages from fast memory type (DRAM) to slow
>      + *                 memory type (persistent memory).

Sure.

> 
>>    * @DAMOS_STAT:		Do nothing but count the stat.
>>    */
>>   enum damos_action {
>> @@ -95,6 +97,7 @@ enum damos_action {
>>   	DAMOS_PAGEOUT,
>>   	DAMOS_HUGEPAGE,
>>   	DAMOS_NOHUGEPAGE,
>> +	DAMOS_DEMOTE,
>>   	DAMOS_STAT,		/* Do nothing but only record the stat */
> 
> This would make user space people who were using 'DAMOS_STAT' be confused.
> Could you put 'DAMOS_DEMOTE' after 'DAMOS_STAT'?

Ah, right, will do.

> 
>>   };
>>   
>> diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
>> index 58dbb96..43355ab 100644
>> --- a/mm/damon/dbgfs.c
>> +++ b/mm/damon/dbgfs.c
>> @@ -168,6 +168,7 @@ static bool damos_action_valid(int action)
>>   	case DAMOS_PAGEOUT:
>>   	case DAMOS_HUGEPAGE:
>>   	case DAMOS_NOHUGEPAGE:
>> +	case DAMOS_DEMOTE:
>>   	case DAMOS_STAT:
>>   		return true;
>>   	default:
>> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
>> index 9e213a1..b354d3e 100644
>> --- a/mm/damon/vaddr.c
>> +++ b/mm/damon/vaddr.c
>> @@ -14,6 +14,10 @@
>>   #include <linux/page_idle.h>
>>   #include <linux/pagewalk.h>
>>   #include <linux/sched/mm.h>
>> +#include <linux/migrate.h>
>> +#include <linux/mm_inline.h>
>> +#include <linux/swapops.h>
>> +#include "../internal.h"
>>   
>>   #include "prmtv-common.h"
>>   
>> @@ -693,6 +697,156 @@ static unsigned long damos_madvise(struct damon_target *target,
>>   }
>>   #endif	/* CONFIG_ADVISE_SYSCALLS */
>>   
>> +static bool damos_isolate_page(struct page *page, struct list_head *demote_list)
>> +{
>> +	struct page *head = compound_head(page);
>> +
>> +	/* Do not interfere with other mappings of this page */
>> +	if (page_mapcount(head) != 1)
>> +		return false;
>> +
>> +	/* No need migration if the target demotion node is empty. */
>> +	if (next_demotion_node(page_to_nid(head)) == NUMA_NO_NODE)
>> +		return false;
>> +
>> +	if (isolate_lru_page(head))
>> +		return false;
>> +
>> +	list_add_tail(&head->lru, demote_list);
>> +	mod_node_page_state(page_pgdat(head),
>> +			    NR_ISOLATED_ANON + page_is_file_lru(head),
>> +			    thp_nr_pages(head));
>> +	return true;
> 
> The return value is not used by callers.  If not needed, let's remove it.

Yes.

> 
>> +}
>> +
>> +static int damos_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
>> +				   unsigned long end, struct mm_walk *walk)
>> +{
>> +	struct vm_area_struct *vma = walk->vma;
>> +	struct list_head *demote_list = walk->private;
>> +	spinlock_t *ptl;
>> +	struct page *page;
>> +	pte_t *pte, *mapped_pte;
>> +
>> +	if (!vma_migratable(vma))
>> +		return -EFAULT;
>> +
>> +	ptl = pmd_trans_huge_lock(pmd, vma);
>> +	if (ptl) {
>> +		/* Bail out if THP migration is not supported. */
>> +		if (!thp_migration_supported())
>> +			goto thp_out;
>> +
>> +		/* If the THP pte is under migration, do not bother it. */
>> +		if (unlikely(is_pmd_migration_entry(*pmd)))
>> +			goto thp_out;
>> +
>> +		page = damon_get_page(pmd_pfn(*pmd));
>> +		if (!page)
>> +			goto thp_out;
>> +
>> +		damos_isolate_page(page, demote_list);
>> +
>> +		put_page(page);
>> +thp_out:
>> +		spin_unlock(ptl);
>> +		return 0;
>> +	}
> 
> Could we wrap above THP handling code with '#ifdef CONFIG_TRANSPARENT_HUGEPAGE'?

The pmd_trans_huge_lock() will return NULL if the 
CONFIG_TRANSPARENT_HUGEPAGE is not defined, meanwhile I think the 
compiler will optimize the code if the CONFIG_TRANSPARENT_HUGEPAGE is 
not select. Se we can use it usually instead of adding annoying "#ifdef 
CONFIG_XXX" in many places to handle THP, which looks simpler and more 
readable for me.

> 
>> +
>> +	/* regular page handling */
>> +	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
>> +		return -EINVAL;
>> +
>> +	mapped_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
>> +	for (; addr != end; pte++, addr += PAGE_SIZE) {
>> +		if (pte_none(*pte) || !pte_present(*pte))
>> +			continue;
>> +
>> +		page = damon_get_page(pte_pfn(*pte));
>> +		if (!page)
>> +			continue;
>> +
>> +		damos_isolate_page(page, demote_list);
>> +		put_page(page);
>> +	}
>> +	pte_unmap_unlock(mapped_pte, ptl);
>> +	cond_resched();
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct mm_walk_ops damos_migrate_pages_walk_ops = {
>> +	.pmd_entry              = damos_migrate_pmd_entry,
> 
> The names are little bit confusing to me.  How about 's/migrate/isolate/'?

Sure.

> 
>> +};
>> +
>> +/*
>> + * damos_demote() - demote cold pages from fast memory to slow memory
>> + * @target:    the given target
>> + * @r:         region of the target
>> + *
>> + * On tiered memory system, if DAMON monitored cold pages on fast memory
>> + * node (DRAM), we can demote them to slow memory node proactively in case
>> + * accumulating much more cold memory on fast memory node (DRAM) to reclaim.
>> + *
>> + * Return:
>> + * = 0 means no pages were demoted.
>> + * > 0 means how many cold pages were demoted successfully.
>> + * < 0 means errors happened.
> 
> damon_va_apply_scheme(), which returns what this function returns when
> DAMOS_DEMOTE action is given, should return bytes of the region that the action
> is successfully applied.

OK, I will change the return values as you suggested in next version.

>> + */
>> +static int damos_demote(struct damon_target *target, struct damon_region *r)
>> +{
>> +	struct mm_struct *mm;
>> +	LIST_HEAD(demote_pages);
>> +	LIST_HEAD(pagelist);
>> +	int target_nid, nr_pages, ret = 0;
>> +	unsigned int nr_succeeded, demoted_pages = 0;
>> +	struct page *page, *page2;
>> +
>> +	/* Validate if allowing to do page demotion */
>> +	if (!numa_demotion_enabled)
>> +		return -EINVAL;
>> +
>> +	mm = damon_get_mm(target);
>> +	if (!mm)
>> +		return -ENOMEM;
>> +
>> +	mmap_read_lock(mm);
>> +	walk_page_range(mm, PAGE_ALIGN(r->ar.start), PAGE_ALIGN(r->ar.end),
> 
> I guess PAGE_ALIGN()s are not necessary here?

Yes, I think so too, will remove it.

> 
>> +			&damos_migrate_pages_walk_ops, &demote_pages);
>> +	mmap_read_unlock(mm);
>> +
>> +	mmput(mm);
>> +	if (list_empty(&demote_pages))
>> +		return 0;
>> +
>> +	list_for_each_entry_safe(page, page2, &demote_pages, lru) {
> 
> I'd prefer 'next' or 'next_page' instead of 'page2'.

Sure.

> 
>> +		list_add(&page->lru, &pagelist);
>> +		target_nid = next_demotion_node(page_to_nid(page));
>> +		nr_pages = thp_nr_pages(page);
>> +
>> +		ret = migrate_pages(&pagelist, alloc_demote_page, NULL,
>> +				    target_nid, MIGRATE_SYNC, MR_DEMOTION,
>> +				    &nr_succeeded);
>> +		if (ret) {
>> +			if (!list_empty(&pagelist)) {
>> +				list_del(&page->lru);
>> +				mod_node_page_state(page_pgdat(page),
>> +						    NR_ISOLATED_ANON + page_is_file_lru(page),
>> +						    -nr_pages);
>> +				putback_lru_page(page);
>> +			}
>> +		} else {
>> +			__count_vm_events(PGDEMOTE_DIRECT, nr_succeeded);
>> +			demoted_pages += nr_succeeded;
>> +		}
> 
> Why should we do above work for each page on our own instead of exporting and
> calling 'demote_page_list()'?

Cuase demote_page_list() is used for demote cold pages which are from 
one same fast memory node, they can have one same target demotion node.

But for the regions for the process, we can get some cold pages from 
different fast memory nodes (suppose we have mulptiple dram node on the 
system), so its target demotion node may be different. Thus we should 
migrate each cold pages with getting the correct target demotion node.

Thanks for your comments.
