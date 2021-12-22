Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6BF47CEEC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243772AbhLVJOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:14:45 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:54660 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233974AbhLVJOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:14:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V.Po1eB_1640164473;
Received: from 30.21.164.53(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V.Po1eB_1640164473)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Dec 2021 17:14:34 +0800
Message-ID: <9db4baa1-2efe-8c01-e2e0-f275cc192fec@linux.alibaba.com>
Date:   Wed, 22 Dec 2021 17:15:18 +0800
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
References: <20211222084322.15902-1-sj@kernel.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20211222084322.15902-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/22/2021 4:43 PM, SeongJae Park wrote:
> On Tue, 21 Dec 2021 22:18:06 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>> Hi SeongJae,
>>
>> On 12/21/2021 9:24 PM, SeongJae Park Wrote:
>>> Hi Baolin,
>>>
>>>
>>> Thank you for this great patch!  I left some comments below.
>>>
>>> On Tue, 21 Dec 2021 17:18:04 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>>
>>>> On tiered memory system, the reclaim path in shrink_page_list() already
>>>> support demoting pages to slow memory node instead of discarding the
>>>> pages. However, at that time the fast memory node memory wartermark is
>>>> already tense, which will increase the memory allocation latency during
>>>> page demotion.
>>>>
>>>> We can rely on the DAMON in user space to help to monitor the cold
>>>> memory on fast memory node, and demote the cold pages to slow memory
>>>> node proactively to keep the fast memory node in a healthy state.
>>>> Thus this patch introduces a new scheme named DAMOS_DEMOTE to support
>>>> this feature.
>>>>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> ---

[snip]

>>
>>>
>>>> +		list_add(&page->lru, &pagelist);
>>>> +		target_nid = next_demotion_node(page_to_nid(page));
>>>> +		nr_pages = thp_nr_pages(page);
>>>> +
>>>> +		ret = migrate_pages(&pagelist, alloc_demote_page, NULL,
>>>> +				    target_nid, MIGRATE_SYNC, MR_DEMOTION,
>>>> +				    &nr_succeeded);
>>>> +		if (ret) {
>>>> +			if (!list_empty(&pagelist)) {
>>>> +				list_del(&page->lru);
>>>> +				mod_node_page_state(page_pgdat(page),
>>>> +						    NR_ISOLATED_ANON + page_is_file_lru(page),
>>>> +						    -nr_pages);
>>>> +				putback_lru_page(page);
>>>> +			}
>>>> +		} else {
>>>> +			__count_vm_events(PGDEMOTE_DIRECT, nr_succeeded);
>>>> +			demoted_pages += nr_succeeded;
>>>> +		}
>>>
>>> Why should we do above work for each page on our own instead of exporting and
>>> calling 'demote_page_list()'?
>>
>> Cuase demote_page_list() is used for demote cold pages which are from
>> one same fast memory node, they can have one same target demotion node.
>>
>> But for the regions for the process, we can get some cold pages from
>> different fast memory nodes (suppose we have mulptiple dram node on the
>> system), so its target demotion node may be different. Thus we should
>> migrate each cold pages with getting the correct target demotion node.
> 
> Thank you for the kind explanation.  But, I still want to reuse the code rather
> than copying if possible.  How about below dumb ideas off the top of my head?
> 
> 1. Call demote_page_list() for each page from here

Sounds reasonable.

> 2. Call demote_page_list() for each page from damos_migrate_pmd_entry()

We are under mmap lock in damos_migrate_pmd_entry(), it is not suitable 
to do page migration.

> 3. Make damos_migrate_pages_walk_ops to configure multiple demote_pages lists,
>     each per fast memory node, and calling demote_page_list() here for each
>     per-fast-memory-node demote_pages list.

Which will bring more complexity I think, and we should avoid doing 
migration under mmap lock.

> 4. Make demote_page_list() handles this case and use it.  e.g., NULL pgdat
>     parameter means the pages are not from same node.

Thanks for your suggestion, actually after more thinking, I think we can 
reuse the demote_page_list() and it can be easy to change. Somethink 
like below on top of my current patch, how do you think? Thanks.

--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -796,7 +796,7 @@ static unsigned long damos_demote(struct 
damon_target *target,
         struct mm_struct *mm;
         LIST_HEAD(demote_pages);
         LIST_HEAD(pagelist);
-       int target_nid, nr_pages, ret = 0;
+       int nr_pages;
         unsigned int nr_succeeded, demoted_pages = 0;
         struct page *page, *next;

@@ -818,14 +818,11 @@ static unsigned long damos_demote(struct 
damon_target *target,
                 return 0;

         list_for_each_entry_safe(page, next, &demote_pages, lru) {
-               list_add(&page->lru, &pagelist);
-               target_nid = next_demotion_node(page_to_nid(page));
                 nr_pages = thp_nr_pages(page);
+               list_add(&page->lru, &pagelist);

-               ret = migrate_pages(&pagelist, alloc_demote_page, NULL,
-                                   target_nid, MIGRATE_SYNC, MR_DEMOTION,
-                                   &nr_succeeded);
-               if (ret) {
+               nr_succeeded = demote_page_list(pagelist, page_pgdat(page));
+               if (!nr_succeeded) {
                         if (!list_empty(&pagelist)) {
                                 list_del(&page->lru);
                                 mod_node_page_state(page_pgdat(page),
@@ -834,11 +831,9 @@ static unsigned long damos_demote(struct 
damon_target *target,
                                 putback_lru_page(page);
                         }
                 } else {
-                       __count_vm_events(PGDEMOTE_DIRECT, nr_succeeded);
                         demoted_pages += nr_succeeded;
                 }

-               INIT_LIST_HEAD(&pagelist);
                 cond_resched();
         }
