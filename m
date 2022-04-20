Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AF6509184
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 22:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380876AbiDTUqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 16:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiDTUqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 16:46:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BD134B84
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 13:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sc6vMSh29FXFMOxHdh8/k5TpOxZ+/Ckh32u1TBe7ffY=; b=uVaWmWoxPOVjgn/PAs+FuiZZ3Y
        jthciLPP8g1gBgzFSoW8ORucEXldJYp5fXeGkqj04+Cl6Y/oFsf8iXHVqK7U9zrsYOGjcpuHr/O1h
        XhYFQ+ZphcoObyohah3E6WimoJWzuvn4H6N2Kgb6Oax331yePFQUGFGFuladE+IC6S6xdmu4NnmZO
        Jzka/tzLRlykNOjTLc6VMY/XknG3VlVJOKQvRMSZeon6i3zEVa0IElUN5rRjCVKj17YMVm6gF9NdZ
        gmE2wjAJQr/LIGGnJ+GwSaQfqZBfjv/dT3HyPoofpjxgLFVUquVXDH6imv3mIFiz4sjpnrf3bwot6
        xbyNPm3A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhHAH-004R5x-Id; Wed, 20 Apr 2022 20:43:05 +0000
Date:   Wed, 20 Apr 2022 21:43:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 1/6] mm/page_alloc: Add page->buddy_list and
 page->pcp_list
Message-ID: <YmBwWa8Wbea4WhvF@casper.infradead.org>
References: <20220420095906.27349-1-mgorman@techsingularity.net>
 <20220420095906.27349-2-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420095906.27349-2-mgorman@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 10:59:01AM +0100, Mel Gorman wrote:
> The page allocator uses page->lru for storing pages on either buddy or
> PCP lists. Create page->buddy_list and page->pcp_list as a union with
> page->lru. This is simply to clarify what type of list a page is on
> in the page allocator.

Hi Mel,

No objection to this change, and I certainly don't want to hold up
fixing this (or any other) problem in the page allocator.  I would
like to talk about splitting out free page management from struct page.
Maybe you'd like to discuss that in person at LSFMM, but a quick
sketch of a data structure might look like ...

struct free_mem {
	unsigned long __page_flags;
	union {
		struct list_head buddy_list;
		struct list_head pcp_list;
	};
	unsigned long __rsvd4;
	unsigned long pcp_migratetype_and_order;
	unsigned long buddy_order;
	unsigned int __page_type;
	atomic_t _refcount;
};

Am I missing anything there?

(Would you like to use separate types for pcp and buddy?  That might be
overkill, or it might help keep the different stages of "free" memory
separate from each other)
