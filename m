Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3814A39C1
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 22:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356423AbiA3VOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 16:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbiA3VO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 16:14:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E937C061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 13:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y6C64rp3OckgZemaQ6wbEiWdl97OAVw+WvBx+s5/qQU=; b=Oa490mYU6J3F82zaqC7vMK1vrL
        c4uVvh0LgiZWlQ5mahycnGEzdTUilgtm0Zw9UYzrGiinrmqeOu5JGRr7eopzZiEixCt++LEDO+geZ
        EIOlVaPFaEq8InEDBJQMwKbLJINaRB7M3/2MKZsZacijgO6r6SgREtYP4fFj8SOuwCI6CsljdpT9V
        UtnnUQ/aHKwVk7tqUl+VJpPmk4JPPkGLfWFjypNghBfo4+KYUGIiomGkuFx5uvNKhfYGHPl5GUtAc
        u64IN0IEOb6WdIeZ4Uu3Nelh5zMnXa0KecGDlLXve9csBHKaNIs6V13s9WFTlnBBATbN1nTZ6LBsI
        wsbPkgQA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEHWf-008nwA-Lc; Sun, 30 Jan 2022 21:14:21 +0000
Date:   Sun, 30 Jan 2022 21:14:21 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: Re: [PATCH] mm/hwpoison: Check the subpage, not the head page
Message-ID: <Yfb/rVg1HYHkKBgO@casper.infradead.org>
References: <20220130013042.1906881-1-willy@infradead.org>
 <dcfa1ee5-1512-5e49-92c2-4a33ab59080@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcfa1ee5-1512-5e49-92c2-4a33ab59080@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 12:58:17PM -0800, David Rientjes wrote:
> On Sun, 30 Jan 2022, Matthew Wilcox (Oracle) wrote:
> 
> > Hardware poison is tracked on a per-page basis, not on the head page.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  mm/rmap.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 6a1e8c7f6213..09b08888120e 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1553,7 +1553,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> >  		/* Update high watermark before we lower rss */
> >  		update_hiwater_rss(mm);
> >  
> > -		if (PageHWPoison(page) && !(flags & TTU_IGNORE_HWPOISON)) {
> > +		if (PageHWPoison(subpage) && !(flags & TTU_IGNORE_HWPOISON)) {
> >  			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
> >  			if (PageHuge(page)) {
> >  				hugetlb_count_sub(compound_nr(page), mm);
> > @@ -1873,7 +1873,7 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
> >  			 * memory are supported.
> >  			 */
> >  			subpage = page;
> > -		} else if (PageHWPoison(page)) {
> > +		} else if (PageHWPoison(subpage)) {
> >  			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
> >  			if (PageHuge(page)) {
> >  				hugetlb_count_sub(compound_nr(page), mm);
> 
> This looks correct.  Correct me if I'm wrong that this is for consistency 
> and cleanup and that there is no bug being fixed by this, however.

Oh, no, I think there's a real bug here.  It's just that we're looking
at an uncommon & hence rarely-tested scenario -- a memory fault in the
middle of a THP (in mainline; obviously it'll be a little more common
with arbitrary sized folios).  I don't do HWPoison testing myself, so
this was by inspection and not from testing.  A scenario where things
would go wrong is a memory error on a non-head-page would go unnoticed
when migrating or unmapping.  Contrariwise, if there's a hardware error
on a head page, all the subpages get treated as poisoned, even though
they shouldn't be.
