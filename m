Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F20746C741
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbhLGWOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242247AbhLGWNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:13:54 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C1DC0698C8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 14:10:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 47BD0CE1E6C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 22:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B93C341C3;
        Tue,  7 Dec 2021 22:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638915008;
        bh=BHjSZ4MPBPA5I9nGCjac++vO6q6E/wPGv/taWiOLqC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R1fhtZrqvH8Zx9ctt1zYNJd1LPUsVopxNKFnFxUNZzMF4Cvluz2LX1SGjQgqD1GWu
         dr4+XRiQCFgarAiLpvOC2iER4TNB5wV8VX8CSYybdv89JdOWg40qJ/Mz+r4DLHO6Gx
         lJfCoELEFCu7VqfUydGGDKBO+EWFt4hPsptz8GyA48Dg+Nq6+VCuKmCjspIVR9Dn89
         kgj6Js7ladxfNfBqXM3zyovYc8wo4qRM3A9DqjoTnAQ3I4059pEkBpbDj+2cZ8UclU
         15w/X4djzH3e7J3FEmMRO62DCIHmSAa1n40v2qLEQPFWZ1V3d+stXA0QnVKZESDo7c
         X6aCn+855SZwA==
Date:   Tue, 7 Dec 2021 14:10:06 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+7cd473c2cac13fd2dd72@syzkaller.appspotmail.com>,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [syzbot] BUG: unable to handle kernel NULL pointer
 dereference in folio_mark_dirty
Message-ID: <Ya/bviwnMPsSnOcy@google.com>
References: <0000000000005f297e05d24f05f6@google.com>
 <20211206175631.5d0c3caefa96f0479f0fc2e8@linux-foundation.org>
 <Ya7jYRDwQqftGLtW@casper.infradead.org>
 <Ya/Ueh7MWyvV2zdg@google.com>
 <Ya/ZaxznaTmrIvdO@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya/ZaxznaTmrIvdO@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07, Matthew Wilcox wrote:
> On Tue, Dec 07, 2021 at 01:39:06PM -0800, Jaegeuk Kim wrote:
> > On 12/07, Matthew Wilcox wrote:
> > > > > Call Trace:
> > > > >  <TASK>
> > > > >  folio_mark_dirty+0x136/0x270 mm/page-writeback.c:2639
> > > 
> > >         if (likely(mapping)) {
> > > ...
> > >                 if (folio_test_reclaim(folio))
> > >                         folio_clear_reclaim(folio);
> > >                 return mapping->a_ops->set_page_dirty(&folio->page);
> > > 
> > > how do we get to a NULL ->set_page_dirty for a metadata page's
> > > mapping->a_ops?  This is definitely an f2fs expert question.
> > 
> > I can't find anything in f2fs, since that page was got by f2fs_grab_meta_page
> > along with grab_cache_page() that we never unlocked it.
> > 
> >   40 struct page *f2fs_grab_meta_page(struct f2fs_sb_info *sbi, pgoff_t index)
> >   41 {
> >   42         struct address_space *mapping = META_MAPPING(sbi);
> >   43         struct page *page;
> >   44 repeat:
> >   45         page = f2fs_grab_cache_page(mapping, index, false);
> > 
> >                     -> grab_cache_page(mapping, index);
> > 
> >   46         if (!page) {
> >   47                 cond_resched();
> >   48                 goto repeat;
> >   49         }
> >   50         f2fs_wait_on_page_writeback(page, META, true, true);
> >   51         if (!PageUptodate(page))
> >   52                 SetPageUptodate(page);
> >   53         return page;
> >   54 }
> > 
> > 
> > Suspecting something in folio wrt folio_mapping()?
> > 
> >  81 bool set_page_dirty(struct page *page)
> >  82 {
> >  83         return folio_mark_dirty(page_folio(page));
> >  84 }
> 
> ... huh?  How could folio_mapping() be getting this wrong?

Dunno.

> page_folio() does the same thing as compound_head() -- as far as I know
> you don't use compound pages for f2fs metadata, so this basically just
> casts the page to a struct folio.
> 
> folio_mapping() is just like the old page_mapping() (see commit
> 2f52578f9c64).  Unless you've done something like set the swapcache
> bit on your metadata page, it's just going to return folio->mapping
> (ie the same as page->mapping).

Hmm, I've never seen this call stack before, so simply started to suspect
folio.
