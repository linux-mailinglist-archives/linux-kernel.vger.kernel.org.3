Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A884A4801
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378657AbiAaNYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378676AbiAaNYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:24:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9AEC06173D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 05:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=OTKoir2+xcoumP1Iky+cUAgPj3dlbdxo9BpxQp1yt8Q=; b=aQq2lT8Hv17Vxf87P/InoA66Ph
        RTKgC9KXM797g48rjI1n9nUP9Efhq28xRamieYhQs0gsOvwmP/M/ie+MZl9Nr19b51ny5F7D20Q9u
        VUzAX5ekOyGkk1bX2dh6D7TlrjPoJSRfdTHHMcTrDA8IZfih1J5wI/ITt1phKIhslvDJwb2rjbiON
        AMRMSoRzVGlMuc7yvYUy/AJ1mPIoc94tBrWCa0zYHjd8a3oPQ9jFvMalcQycH3u9zuDCgummzvnJf
        VE/m9mnL5jjhdLgo/TzeiIjy455XvQbEEoRAmde9rn8a3ITn2qOJfl4XW/zhFzkgHVu6Py4RhzdpU
        lcbAaH7g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEWfT-009teD-24; Mon, 31 Jan 2022 13:24:27 +0000
Date:   Mon, 31 Jan 2022 13:24:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/hwpoison: Check the subpage, not the head page
Message-ID: <YffjC9+JsrZB5ekr@casper.infradead.org>
References: <20220130013042.1906881-1-willy@infradead.org>
 <dcfa1ee5-1512-5e49-92c2-4a33ab59080@google.com>
 <Yfb/rVg1HYHkKBgO@casper.infradead.org>
 <20220131054432.GA856839@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220131054432.GA856839@hori.linux.bs1.fc.nec.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 05:44:35AM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Sun, Jan 30, 2022 at 09:14:21PM +0000, Matthew Wilcox wrote:
> > On Sun, Jan 30, 2022 at 12:58:17PM -0800, David Rientjes wrote:
> > > On Sun, 30 Jan 2022, Matthew Wilcox (Oracle) wrote:
> > > 
> > > > Hardware poison is tracked on a per-page basis, not on the head page.
> > > > 
> > > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > > ---
> > > >  mm/rmap.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/mm/rmap.c b/mm/rmap.c
> > > > index 6a1e8c7f6213..09b08888120e 100644
> > > > --- a/mm/rmap.c
> > > > +++ b/mm/rmap.c
> > > > @@ -1553,7 +1553,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> > > >  		/* Update high watermark before we lower rss */
> > > >  		update_hiwater_rss(mm);
> > > >  
> > > > -		if (PageHWPoison(page) && !(flags & TTU_IGNORE_HWPOISON)) {
> > > > +		if (PageHWPoison(subpage) && !(flags & TTU_IGNORE_HWPOISON)) {
> > > >  			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
> > > >  			if (PageHuge(page)) {
> > > >  				hugetlb_count_sub(compound_nr(page), mm);
> > > > @@ -1873,7 +1873,7 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
> > > >  			 * memory are supported.
> > > >  			 */
> > > >  			subpage = page;
> > > > -		} else if (PageHWPoison(page)) {
> > > > +		} else if (PageHWPoison(subpage)) {
> > > >  			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
> > > >  			if (PageHuge(page)) {
> > > >  				hugetlb_count_sub(compound_nr(page), mm);
> > > 
> > > This looks correct.  Correct me if I'm wrong that this is for consistency 
> > > and cleanup and that there is no bug being fixed by this, however.
> > 
> > Oh, no, I think there's a real bug here.  It's just that we're looking
> > at an uncommon & hence rarely-tested scenario -- a memory fault in the
> > middle of a THP (in mainline; obviously it'll be a little more common
> > with arbitrary sized folios).  I don't do HWPoison testing myself, so
> > this was by inspection and not from testing.  A scenario where things
> > would go wrong is a memory error on a non-head-page would go unnoticed
> > when migrating or unmapping.  Contrariwise, if there's a hardware error
> > on a head page, all the subpages get treated as poisoned, even though
> > they shouldn't be.
> 
> Thank you for reporting.  As you point out, the current check does not
> handle thp properly.  The reason of checking head page here is to handle
> hwpoisoned hugetlb (which has PG_hwpoison on the head page even if the error
> is on any of tail page).  So I think that the proper fix is to add a helper
> function to check page type (normal, thp, or hugetlb) as well as PageHWPoison.

I think this handles HugeTLB pages correctly:

                subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);

As I understand the HugeTLB code, pvmw.pte refers to the head page, not
the subpage (unlike a PTE-mapped THP page, where it would refer to the
precise page).  But I cheerfully admit that the intricacies of the
HugeTLB code are not something I'm an expert on.
