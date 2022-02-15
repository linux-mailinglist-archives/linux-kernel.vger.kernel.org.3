Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939C04B7B25
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 00:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241539AbiBOXVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 18:21:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiBOXVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:21:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC15EF94D4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zctHsFYI39kKpZ65pfZtOmz6zeTwXvzzS07zdKOR0As=; b=XRl94yyNGudaG33KxxsztMkolj
        KUoRGCrUdxQi9s/OmlDMn77OJz7JmGQIGinlkXhDHnUD6UKq7Rk0K5skenCKjwCsMav7Fgn5rhk8N
        2OhjaQMZlSs0HWJPKLJum0MyuveiRSFzOF4UXGW/+3z5eXSC9tWB2atNS8jehM0avk3WWv9IZ/WRd
        q4S7IsIZK4wk/8mS0gPEtN0n+dbxHfjwFGka+ylGVxTtNP34c7Rl6Kh3IQgu+0NABC+sdGbrC/+JW
        xT3EK69m8tSaTBAh0x/MkLmj0sGVjROHclQ0STdUNXp+/z3bEDowXnkXntdbQNsNxbkPvcoYnhVzN
        GAjPQ9uA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nK78A-00EFfc-G7; Tue, 15 Feb 2022 23:21:10 +0000
Date:   Tue, 15 Feb 2022 23:21:10 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 04/13] mm/munlock: rmap call mlock_vma_page()
 munlock_vma_page()
Message-ID: <Ygw1Zn+WUuY5WkZy@casper.infradead.org>
References: <55a49083-37f9-3766-1de9-9feea7428ac@google.com>
 <501673c-a5a-6c5f-ab65-38545dfb723d@google.com>
 <YgvFMjWPITbD1o64@casper.infradead.org>
 <3c6097a7-df8c-f39c-36e8-8b5410e76c8a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c6097a7-df8c-f39c-36e8-8b5410e76c8a@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 01:38:20PM -0800, Hugh Dickins wrote:
> On Tue, 15 Feb 2022, Matthew Wilcox wrote:
> > On Mon, Feb 14, 2022 at 06:26:39PM -0800, Hugh Dickins wrote:
> > > Add vma argument to mlock_vma_page() and munlock_vma_page(), make them
> > > inline functions which check (vma->vm_flags & VM_LOCKED) before calling
> > > mlock_page() and munlock_page() in mm/mlock.c.
> > > 
> > > Add bool compound to mlock_vma_page() and munlock_vma_page(): this is
> > > because we have understandable difficulty in accounting pte maps of THPs,
> > > and if passed a PageHead page, mlock_page() and munlock_page() cannot
> > > tell whether it's a pmd map to be counted or a pte map to be ignored.
> > > 
> > [...]
> > > 
> > > Mlock accounting on THPs has been hard to define, differed between anon
> > > and file, involved PageDoubleMap in some places and not others, required
> > > clear_page_mlock() at some points.  Keep it simple now: just count the
> > > pmds and ignore the ptes, there is no reason for ptes to undo pmd mlocks.
> > 
> > How would you suggest we handle the accounting for folios which are
> > intermediate in size between PMDs and PTEs?  eg, an order-4 page?
> > Would it make sense to increment mlock_count by HUGE_PMD_NR for
> > each PMD mapping and by 1 for each PTE mapping?
> 
> I think you're asking the wrong question here, but perhaps you've
> already decided there's only one satisfactory answer to the right question.

Or I've gravely misunderstood the situation.  Or explained my concern
badly.  The possibilities are endless!

My concern is that a filesystem may create an order-4 folio, an
application mmaps the folio and then calls mlock() (either over a portion
or the entirety of the folio).  As far as I can tell, we then do not
move the folio onto the unevictable list because it is of order >0 and
is only mapped by PTEs.  This presumably then has performance problems
(or we wouldn't need to have an unevictable list in the first place).

> The question I thought you should be asking is about how to count them
> in Mlocked.  That's tough; but I take it for granted that you would not
> want per-subpage flags and counts involved (or not unless forced to do
> so by some regression that turns out to matter).  And I think the only
> satisfactory answer is to count the whole compound_nr() as Mlocked
> when any part of it (a single pte, a series of ptes, a pmd) is mlocked;
> and (try to) move folio to Unevictable whenever any part of it is mlocked.

I think that makes sense.  As with so many other things, we choose to
manage memory in >PAGE_SIZE chunks.  If you mlock() a part of a folio,
we lock the whole folio in memory, and it all counts as being locked.
