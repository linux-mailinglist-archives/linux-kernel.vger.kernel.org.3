Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4C549CC46
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242102AbiAZOZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbiAZOZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:25:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BAEC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 06:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LiOUw0BmLOCV5aXkbkiAQ3Ht3cRjDO/swK3bGS2AZxs=; b=oItQVVFfHwr0aOvBCsF7zp4OOi
        RFvfZJkzhP/JdBpwYViRO401Z2hBTt55jxtY0F2cslTDw6q2mG0oyGyu7iOM1jx1/WEQ0Xgh7jdA4
        rWMMGVggmGVjGDX9Aua0BQqGKZZnJlhHs+kmhvPXV98ap+1Rrmo3/5MwrSiJjsMDjx19u3l4RoKcn
        2MRT+3t6Sp5FeFR6X+O4aPj9y0eekKjlz5KV9uauRg3/ubAMubGjDzEZzESs0oZUAg9zadZvAqhME
        FPh6YqRM3qqH6QFsA+Ebb8xNtA5oaRmpcOSELzy4WV7bX+BFwI3C9ULl58xtmhnk7EXPzBoTuRzeo
        aBgzAS0g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCjEj-0047J8-Qd; Wed, 26 Jan 2022 14:25:25 +0000
Date:   Wed, 26 Jan 2022 14:25:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>, linux-mm@kvack.org,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH RFC v2 1/9] mm: optimize do_wp_page() for exclusive pages
 in the swapcache
Message-ID: <YfFZ1SruNMubhJLo@casper.infradead.org>
References: <20220126095557.32392-1-david@redhat.com>
 <20220126095557.32392-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126095557.32392-2-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 10:55:49AM +0100, David Hildenbrand wrote:
> Liang Zhang reported [1] that the current COW logic in do_wp_page() is
> sub-optimal when it comes to swap+read fault+write fault of anonymous
> pages that have a single user, visible via a performance degradation in
> the redis benchmark. Something similar was previously reported [2] by
> Nadav with a simple reproducer.
> 
> Let's optimize for pages that have been added to the swapcache but only
> have an exclusive owner. Try removing the swapcache reference if there is
> hope that we're the exclusive user.
> 
> We will fail removing the swapcache reference in two scenarios:
> (1) There are additional swap entries referencing the page: copying
>     instead of reusing is the right thing to do.
> (2) The page is under writeback: theoretically we might be able to reuse
>     in some cases, however, we cannot remove the additional reference
>     and will have to copy.
> 
> Further, we might have additional references from the LRU pagevecs,
> which will force us to copy instead of being able to reuse. We'll try
> handling such references for some scenarios next. Concurrent writeback
> cannot be handled easily and we'll always have to copy.
> 
> While at it, remove the superfluous page_mapcount() check: it's
> implicitly covered by the page_count() for ordinary anon pages.
> 
> [1] https://lkml.kernel.org/r/20220113140318.11117-1-zhangliang5@huawei.com
> [2] https://lkml.kernel.org/r/0480D692-D9B2-429A-9A88-9BBA1331AC3A@gmail.com
> 
> Reported-by: Liang Zhang <zhangliang5@huawei.com>
> Reported-by: Nadav Amit <nadav.amit@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
