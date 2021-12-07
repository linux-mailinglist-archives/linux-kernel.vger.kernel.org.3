Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F90146C709
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbhLGWDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhLGWDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:03:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D2EC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 14:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GHEajNctGC/0vOa+hsD34nlStTkJcznyOuhwQaT4q4g=; b=K2Y4wmD4zAtxximZgUNDXpho8L
        fWTnDiuYs07KfvI3SAraPm1N0ivCZMHZmfSBxvPa/xdIrr8otukEfujBImdOkRNlz0bsfdQ+xZagz
        BSvSmQYirm+FoXpyQQd6G0lBunqbdYChti0pmG5MBaCzGJmFVFZD+jFs1CMF17qhhNLtjwUIIj+WU
        eKvz5nVc8QV6XLVcR+kdECZ9Jm+KziR0mZ+IDPpzm/4gVYR+QhAcVco0JQLFYhmLinwD/BSvQyS/f
        rSbNUzyKy85A/z4uA37+FqUnfmYW5noQ9E9edJ7zeCbTPoguVB0GcxvD2cc0R3sJ6rarsaH/lBtPk
        UG78sNCA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muiVP-007obU-UA; Tue, 07 Dec 2021 22:00:11 +0000
Date:   Tue, 7 Dec 2021 22:00:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+7cd473c2cac13fd2dd72@syzkaller.appspotmail.com>,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [syzbot] BUG: unable to handle kernel NULL pointer
 dereference in folio_mark_dirty
Message-ID: <Ya/ZaxznaTmrIvdO@casper.infradead.org>
References: <0000000000005f297e05d24f05f6@google.com>
 <20211206175631.5d0c3caefa96f0479f0fc2e8@linux-foundation.org>
 <Ya7jYRDwQqftGLtW@casper.infradead.org>
 <Ya/Ueh7MWyvV2zdg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya/Ueh7MWyvV2zdg@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 01:39:06PM -0800, Jaegeuk Kim wrote:
> On 12/07, Matthew Wilcox wrote:
> > > > Call Trace:
> > > >  <TASK>
> > > >  folio_mark_dirty+0x136/0x270 mm/page-writeback.c:2639
> > 
> >         if (likely(mapping)) {
> > ...
> >                 if (folio_test_reclaim(folio))
> >                         folio_clear_reclaim(folio);
> >                 return mapping->a_ops->set_page_dirty(&folio->page);
> > 
> > how do we get to a NULL ->set_page_dirty for a metadata page's
> > mapping->a_ops?  This is definitely an f2fs expert question.
> 
> I can't find anything in f2fs, since that page was got by f2fs_grab_meta_page
> along with grab_cache_page() that we never unlocked it.
> 
>   40 struct page *f2fs_grab_meta_page(struct f2fs_sb_info *sbi, pgoff_t index)
>   41 {
>   42         struct address_space *mapping = META_MAPPING(sbi);
>   43         struct page *page;
>   44 repeat:
>   45         page = f2fs_grab_cache_page(mapping, index, false);
> 
>                     -> grab_cache_page(mapping, index);
> 
>   46         if (!page) {
>   47                 cond_resched();
>   48                 goto repeat;
>   49         }
>   50         f2fs_wait_on_page_writeback(page, META, true, true);
>   51         if (!PageUptodate(page))
>   52                 SetPageUptodate(page);
>   53         return page;
>   54 }
> 
> 
> Suspecting something in folio wrt folio_mapping()?
> 
>  81 bool set_page_dirty(struct page *page)
>  82 {
>  83         return folio_mark_dirty(page_folio(page));
>  84 }

... huh?  How could folio_mapping() be getting this wrong?
page_folio() does the same thing as compound_head() -- as far as I know
you don't use compound pages for f2fs metadata, so this basically just
casts the page to a struct folio.

folio_mapping() is just like the old page_mapping() (see commit
2f52578f9c64).  Unless you've done something like set the swapcache
bit on your metadata page, it's just going to return folio->mapping
(ie the same as page->mapping).

