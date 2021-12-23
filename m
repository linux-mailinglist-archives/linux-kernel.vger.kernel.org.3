Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8735A47E09E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 09:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347309AbhLWIxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 03:53:17 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37846 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhLWIxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:53:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 066BC61DF2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 08:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD27C36AE9;
        Thu, 23 Dec 2021 08:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640249595;
        bh=76ZrrhIxMSZSloyiIsMRVOIpWVxAsx2mj6poB/Fp4gQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=MIab8DsKYgj+4YI4EHviGFdVrlVDeVX8wRRkYSWY94OePUBV8XIvux/iBO57VFFZa
         fsCUDXmfxG2/Vrwnlz5uRk8EtzEm4nDmdOT8SfDlvJKXJU0V3TH8zpQSALqdSdZ78H
         Bd7KxTkld7F/mVJmjg58dpclM66zhc7608nunEDURTub8VIWmA8VtQRBU+BQj9WCTN
         AauKKIlD3XSf9GRvrgCqoFIX9B9S/33DS9o0f/vyvFD0ZVWTeHN3YFJMUl9JUe07J2
         iKZn5lGsRHqiNkYqh7Wac/MJC6semhOQ/GQNn9HJyrkGJanim9D7MYPGoILPV7QBvK
         IPB6ziE1PS5fw==
From:   SeongJae Park <sj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        ying.huang@intel.com, dave.hansen@linux.intel.com, ziy@nvidia.com,
        shy828301@gmail.com, zhongjiang-ali@linux.alibaba.com,
        xlpang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/damon: Add a new scheme to support demotion on tiered memory system
Date:   Thu, 23 Dec 2021 08:53:12 +0000
Message-Id: <20211223085312.19748-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <9db4baa1-2efe-8c01-e2e0-f275cc192fec@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2021 17:15:18 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> 
> 
> On 12/22/2021 4:43 PM, SeongJae Park wrote:
> > On Tue, 21 Dec 2021 22:18:06 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> > 
> >> Hi SeongJae,
> >>
> >> On 12/21/2021 9:24 PM, SeongJae Park Wrote:
> >>> Hi Baolin,
> >>>
> >>>
> >>> Thank you for this great patch!  I left some comments below.
> >>>
> >>> On Tue, 21 Dec 2021 17:18:04 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> >>>
> >>>> On tiered memory system, the reclaim path in shrink_page_list() already
> >>>> support demoting pages to slow memory node instead of discarding the
> >>>> pages. However, at that time the fast memory node memory wartermark is
> >>>> already tense, which will increase the memory allocation latency during
> >>>> page demotion.
> >>>>
> >>>> We can rely on the DAMON in user space to help to monitor the cold
> >>>> memory on fast memory node, and demote the cold pages to slow memory
> >>>> node proactively to keep the fast memory node in a healthy state.
> >>>> Thus this patch introduces a new scheme named DAMOS_DEMOTE to support
> >>>> this feature.
> >>>>
> >>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >>>> ---
> 
> [snip]
> 
> >>
> >>>
> >>>> +		list_add(&page->lru, &pagelist);
> >>>> +		target_nid = next_demotion_node(page_to_nid(page));
> >>>> +		nr_pages = thp_nr_pages(page);
> >>>> +
> >>>> +		ret = migrate_pages(&pagelist, alloc_demote_page, NULL,
> >>>> +				    target_nid, MIGRATE_SYNC, MR_DEMOTION,
> >>>> +				    &nr_succeeded);
> >>>> +		if (ret) {
> >>>> +			if (!list_empty(&pagelist)) {
> >>>> +				list_del(&page->lru);
> >>>> +				mod_node_page_state(page_pgdat(page),
> >>>> +						    NR_ISOLATED_ANON + page_is_file_lru(page),
> >>>> +						    -nr_pages);
> >>>> +				putback_lru_page(page);
> >>>> +			}
> >>>> +		} else {
> >>>> +			__count_vm_events(PGDEMOTE_DIRECT, nr_succeeded);
> >>>> +			demoted_pages += nr_succeeded;
> >>>> +		}
> >>>
> >>> Why should we do above work for each page on our own instead of exporting and
> >>> calling 'demote_page_list()'?
> >>
> >> Cuase demote_page_list() is used for demote cold pages which are from
> >> one same fast memory node, they can have one same target demotion node.
> >>
> >> But for the regions for the process, we can get some cold pages from
> >> different fast memory nodes (suppose we have mulptiple dram node on the
> >> system), so its target demotion node may be different. Thus we should
> >> migrate each cold pages with getting the correct target demotion node.
> > 
> > Thank you for the kind explanation.  But, I still want to reuse the code rather
> > than copying if possible.  How about below dumb ideas off the top of my head?
> > 
> > 1. Call demote_page_list() for each page from here
> 
> Sounds reasonable.
> 
> > 2. Call demote_page_list() for each page from damos_migrate_pmd_entry()
> 
> We are under mmap lock in damos_migrate_pmd_entry(), it is not suitable 
> to do page migration.
> 
> > 3. Make damos_migrate_pages_walk_ops to configure multiple demote_pages lists,
> >     each per fast memory node, and calling demote_page_list() here for each
> >     per-fast-memory-node demote_pages list.
> 
> Which will bring more complexity I think, and we should avoid doing 
> migration under mmap lock.
> 
> > 4. Make demote_page_list() handles this case and use it.  e.g., NULL pgdat
> >     parameter means the pages are not from same node.
> 
> Thanks for your suggestion, actually after more thinking, I think we can 
> reuse the demote_page_list() and it can be easy to change. Somethink 
> like below on top of my current patch, how do you think? Thanks.

So, you selected the option 1.  I personally think option 3 or 4 would be more
optimal, but also agree that it could increase the complexity.  As we already
have the time/space quota feature for schemes overhead control, I think
starting with this simple approach makes sense to me.


Thanks,
SJ

[...]
