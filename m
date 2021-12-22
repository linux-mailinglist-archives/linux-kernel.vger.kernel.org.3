Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E400747CE6D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243430AbhLVIn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243406AbhLVIn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:43:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB26C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:43:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02FA3B81B60
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 08:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B62C36AE8;
        Wed, 22 Dec 2021 08:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640162605;
        bh=wapDDNyUYjxK8TwaujhYtrGaTdGgu9G5kJJqf5Y3oK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=ti9S4nXeZri6jvziwaCIK36pkocrhnEA5tN0FDHNSrCPTP3X3tmWzPDJg4Zsx3Bcn
         ZEq6ExU1jnOc+/1p8yCFLTRKnA33geY7GFrlteGwoUCIpJ4XuAOkMs12T+bJ6x9z9x
         6uAKybuS/vgS/s05uU/qPL67cjNUb5hlKkPZBRmYFmcdm5FZBTrY6ayseN0xC5/yej
         tZQnyx87yZt029ZKKEoSjkydHUtWa+jtmZy7NuR9hAHXJAuJBShD3csW3NN+5nf7bR
         iyCB82XaV0p50ZIS/5gPlYliQpxk2E9UJ4L3r9943GBhkpCAkxl3of+zjOHnicTYgs
         AKIohTVwr8Gzg==
From:   SeongJae Park <sj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        ying.huang@intel.com, dave.hansen@linux.intel.com, ziy@nvidia.com,
        shy828301@gmail.com, zhongjiang-ali@linux.alibaba.com,
        xlpang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/damon: Add a new scheme to support demotion on tiered memory system
Date:   Wed, 22 Dec 2021 08:43:22 +0000
Message-Id: <20211222084322.15902-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <248bd960-39b8-bbe1-ac45-bc0893acc40f@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 22:18:06 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> Hi SeongJae,
> 
> On 12/21/2021 9:24 PM, SeongJae Park Wrote:
> > Hi Baolin,
> > 
> > 
> > Thank you for this great patch!  I left some comments below.
> > 
> > On Tue, 21 Dec 2021 17:18:04 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> > 
> >> On tiered memory system, the reclaim path in shrink_page_list() already
> >> support demoting pages to slow memory node instead of discarding the
> >> pages. However, at that time the fast memory node memory wartermark is
> >> already tense, which will increase the memory allocation latency during
> >> page demotion.
> >>
> >> We can rely on the DAMON in user space to help to monitor the cold
> >> memory on fast memory node, and demote the cold pages to slow memory
> >> node proactively to keep the fast memory node in a healthy state.
> >> Thus this patch introduces a new scheme named DAMOS_DEMOTE to support
> >> this feature.
> >>
> >> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> ---
[...]
> >> + */
> >> +static int damos_demote(struct damon_target *target, struct damon_region *r)
> >> +{
> >> +	struct mm_struct *mm;
> >> +	LIST_HEAD(demote_pages);
> >> +	LIST_HEAD(pagelist);
> >> +	int target_nid, nr_pages, ret = 0;
> >> +	unsigned int nr_succeeded, demoted_pages = 0;
> >> +	struct page *page, *page2;
> >> +
> >> +	/* Validate if allowing to do page demotion */
> >> +	if (!numa_demotion_enabled)
> >> +		return -EINVAL;
> >> +
> >> +	mm = damon_get_mm(target);
> >> +	if (!mm)
> >> +		return -ENOMEM;
> >> +
> >> +	mmap_read_lock(mm);
> >> +	walk_page_range(mm, PAGE_ALIGN(r->ar.start), PAGE_ALIGN(r->ar.end),
[...]
> >> +			&damos_migrate_pages_walk_ops, &demote_pages);
> >> +	mmap_read_unlock(mm);
> >> +
> >> +	mmput(mm);
> >> +	if (list_empty(&demote_pages))
> >> +		return 0;
> >> +
> >> +	list_for_each_entry_safe(page, page2, &demote_pages, lru) {
> > 
> > I'd prefer 'next' or 'next_page' instead of 'page2'.
> 
> Sure.
> 
> > 
> >> +		list_add(&page->lru, &pagelist);
> >> +		target_nid = next_demotion_node(page_to_nid(page));
> >> +		nr_pages = thp_nr_pages(page);
> >> +
> >> +		ret = migrate_pages(&pagelist, alloc_demote_page, NULL,
> >> +				    target_nid, MIGRATE_SYNC, MR_DEMOTION,
> >> +				    &nr_succeeded);
> >> +		if (ret) {
> >> +			if (!list_empty(&pagelist)) {
> >> +				list_del(&page->lru);
> >> +				mod_node_page_state(page_pgdat(page),
> >> +						    NR_ISOLATED_ANON + page_is_file_lru(page),
> >> +						    -nr_pages);
> >> +				putback_lru_page(page);
> >> +			}
> >> +		} else {
> >> +			__count_vm_events(PGDEMOTE_DIRECT, nr_succeeded);
> >> +			demoted_pages += nr_succeeded;
> >> +		}
> > 
> > Why should we do above work for each page on our own instead of exporting and
> > calling 'demote_page_list()'?
> 
> Cuase demote_page_list() is used for demote cold pages which are from 
> one same fast memory node, they can have one same target demotion node.
> 
> But for the regions for the process, we can get some cold pages from 
> different fast memory nodes (suppose we have mulptiple dram node on the 
> system), so its target demotion node may be different. Thus we should 
> migrate each cold pages with getting the correct target demotion node.

Thank you for the kind explanation.  But, I still want to reuse the code rather
than copying if possible.  How about below dumb ideas off the top of my head?

1. Call demote_page_list() for each page from here
2. Call demote_page_list() for each page from damos_migrate_pmd_entry()
3. Make damos_migrate_pages_walk_ops to configure multiple demote_pages lists,
   each per fast memory node, and calling demote_page_list() here for each
   per-fast-memory-node demote_pages list.
4. Make demote_page_list() handles this case and use it.  e.g., NULL pgdat
   parameter means the pages are not from same node.

Please let me know if I'm missing something.


Thanks,
SJ

> 
> Thanks for your comments.
