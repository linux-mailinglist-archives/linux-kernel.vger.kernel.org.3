Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193CE509ADD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386791AbiDUIlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238523AbiDUIlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:41:08 -0400
Received: from outbound-smtp01.blacknight.com (outbound-smtp01.blacknight.com [81.17.249.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D085ABC00
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:38:18 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp01.blacknight.com (Postfix) with ESMTPS id 34520C4B26
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:38:17 +0100 (IST)
Received: (qmail 16182 invoked from network); 21 Apr 2022 08:38:17 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Apr 2022 08:38:16 -0000
Date:   Thu, 21 Apr 2022 09:38:11 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 1/6] mm/page_alloc: Add page->buddy_list and
 page->pcp_list
Message-ID: <20220421083811.GA4105@techsingularity.net>
References: <20220420095906.27349-1-mgorman@techsingularity.net>
 <20220420095906.27349-2-mgorman@techsingularity.net>
 <YmBwWa8Wbea4WhvF@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YmBwWa8Wbea4WhvF@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 09:43:05PM +0100, Matthew Wilcox wrote:
> On Wed, Apr 20, 2022 at 10:59:01AM +0100, Mel Gorman wrote:
> > The page allocator uses page->lru for storing pages on either buddy or
> > PCP lists. Create page->buddy_list and page->pcp_list as a union with
> > page->lru. This is simply to clarify what type of list a page is on
> > in the page allocator.
> 
> Hi Mel,
> 
> No objection to this change, and I certainly don't want to hold up
> fixing this (or any other) problem in the page allocator. 

Minimally, I think the patch makes it easier to implement your suggestion
and it can happen before or after the rest of the series.

> I would
> like to talk about splitting out free page management from struct page.
> Maybe you'd like to discuss that in person at LSFMM, but a quick
> sketch of a data structure might look like ...
> 

Unfortunately, I am unable to attend LSF/MM (or any other conference)
physically but I have no objection to splitting this out as a separate
structure. I assume the basis for the change would be for type checking.

> struct free_mem {
> 	unsigned long __page_flags;

page->flags, ok

> 	union {
> 		struct list_head buddy_list;
> 		struct list_head pcp_list;
> 	};

page->lru, ok

> 	unsigned long __rsvd4;

page->mapping, we need that

> 	unsigned long pcp_migratetype_and_order;

page->index, ok but more on this later

> 	unsigned long buddy_order;

page->private, ok.

> 	unsigned int __page_type;

page->_mapcount, we need that too.

> 	atomic_t _refcount;

page->_refcount, ok.

> };
> 
> Am I missing anything there?
> 

s/__page_flags/flags/	The allocator checks and modifies these bits so
	it has awareness of page->flags

s/__rsvd4/mapping/	The mapping is checked for debugging and the
	allocator is responsible for clearing page->mapping

s/pcp_migratetype_and_order/pcp_migratetype/
	Commit 8b10b465d0e1 ("mm/page_alloc: free pages in a single pass
	during bulk free") removed the migratetype and order stuffing
	in page->index. The order is inferred from the array index via
	order_to_pindex and pindex_to_order but migratetype is still
	stored in page->index by set_pcppage_migratetype

s/__page_type/_mapcount/ because _mapcount if checked for debugging

memcg_data needs to be accessible for debugging checks

_last_cpupid needs to be accessible as it's reset during prepare via
	page_cpupid_reset_last. Rather than putting in a dummy field
	for virtual, maybe virtual can move.

> (Would you like to use separate types for pcp and buddy?  That might be
> overkill, or it might help keep the different stages of "free" memory
> separate from each other)

I think it's overkill because there is too much overlap between a PCP
page and buddy page due to page checks and preparation. The distinguishing
factor between a free pcp page and free buddy page is the PageBuddy bit.

-- 
Mel Gorman
SUSE Labs
