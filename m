Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DF748DA5F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbiAMPCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbiAMPCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:02:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A6AC06161C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 07:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B11Ie4xk5bhkeIzwoNtpBIh4wfJJi+YAtt7ECX6UPrY=; b=ArD+YXOtK+Dd+ZwEFfcxBbHWnF
        Dya1ULbAXp7RamN0GjE2Kgzg89oG7QnUUzlMRA4cdna4LXlT/9UOyIz0rXNsLbTx9XfMTduNV1thA
        nJfuybt91e6f3Nw9/HADphhEABf99j1DS8XHfw6+rupshBWxaiRgCp9GthZU60QaNC0ymo/fxnd2Z
        PT4Zal1qlgYrq/V9K9zf+f34zRYZGQ4FYLAUc2QpJ3CVpoSDhka0+ED6c0oKFuq/wiRHpZkSi2rGY
        1OXEmyfGHHLJ2CZTd10cugWVtV45FhDSTllVPtWUnd4hQHLnbmAdsx5JQrowip3qQIXyJ+nHK70ct
        trymDh4w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n81cb-0050k2-TX; Thu, 13 Jan 2022 15:02:37 +0000
Date:   Thu, 13 Jan 2022 15:02:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Liang Zhang <zhangliang5@huawei.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        wangzhigang17@huawei.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
Message-ID: <YeA/DQptAz3fl6ym@casper.infradead.org>
References: <20220113140318.11117-1-zhangliang5@huawei.com>
 <YeA5oP/iaxtVPHb3@casper.infradead.org>
 <ec0f57e6-f1f6-b9d9-b507-20e845fe7f17@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec0f57e6-f1f6-b9d9-b507-20e845fe7f17@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 03:46:54PM +0100, David Hildenbrand wrote:
> On 13.01.22 15:39, Matthew Wilcox wrote:
> > On Thu, Jan 13, 2022 at 10:03:18PM +0800, Liang Zhang wrote:
> >> In current implementation, process's read requestions will fault in pages
> >> with WP flags in PTEs. Next, if process emit a write requestion will go
> >> into do_wp_page() and copy data to a new allocated page from the old one
> >> due to refcount > 1 (page table mapped and swapcache), which could be
> >> result in performance degradation. In fact, this page is exclusively owned
> >> by this process and the duplication from old to a new allocated page is
> >> really unnecessary.
> >>
> >> So In this situation, these unshared pages can be reused by its process.
> > 
> > Let's bring Linus in on this, but I think this reintroduces all of the
> > mapcount problems that we've been discussing recently.
> > 
> > How about this as an alternative?
> > 
> > +++ b/mm/memory.c
> > @@ -3291,11 +3291,11 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
> >                 struct page *page = vmf->page;
> > 
> >                 /* PageKsm() doesn't necessarily raise the page refcount */
> > -               if (PageKsm(page) || page_count(page) != 1)
> > +               if (PageKsm(page) || page_count(page) != 1 + PageSwapCache(page))
> >                         goto copy;
> >                 if (!trylock_page(page))
> >                         goto copy;
> > -               if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1) {
> > +               if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1 + PageSwapCache(page)) {
> >                         unlock_page(page);
> >                         goto copy;
> >                 }
> 
> Funny, I was staring at swap reuse code as I received this mail ...
> because if we're not using reuse_swap_page() here anymore, we shouldn't
> really be reusing it anywhere for consistency, most prominently in
> do_swap_page() when we handle vmf->flags & FAULT_FLAG_WRITE just
> similarly as we do here ...
> 
> And that's where things get hairy and I am still trying to figure out
> all of the details.
> 
> Regarding above: If the page is swapped out in multiple processes but
> was only faulted into the current process R/O, and then we try to write:
> 
> 1. Still in the swapcache: PageSwapCache()
> 2. Mapped only by one process: page_mapcount(page) == 1
> 3. Reference from one page table and the swap cache: page_count(page) ==
> 
> But other processes could read-fault on the swapcache page, no?
> 
> I think we'd really have to check against the swapcount as well ...
> essentially reuse_swap_page(), no?

Unfortunately the last digit is missing from your "3.", but I
think you're absolutely right; we need to check swapcount.  So
once reuse_swap_page() checks page_count instead of mapcount, we'll
be good?
