Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FE5466AA4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 20:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbhLBUCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 15:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbhLBUCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 15:02:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07B9C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 11:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2lzsGjuMasyWxC1shMbRa1P/BpgSesmupx2ZuN5KYd4=; b=hfOX1TOh+hRMgtHkK3eV8Vw3QZ
        mYCZx6muJCR7xnp3kqqRXn2U8/CK+TB26hJ/rpk20d6z6vIaXV0d98rjaGMISxVv1jN7A4LBND5QI
        ZU9pHum9EPwQ5IluUu6N1vvOSGbvuefbfVCAfiFZxzfqUf4cyujmqzpcKSa/KxaRmHc3qxzV5NQJF
        AZ+hr4UlbUQc2ltRyYhNGZy/3uMQ7Vcxkvn17F9+KoEXnWoYDShNiOQhomW8T9Y3eIDElFbT2bM6i
        XLC3Wd3vZg1n15Pha2t3ON3ZtYA/ZT4F0HjKlHfzcdgoYPCZf/7hkNV2LWmVr/OOO9/rDBCLurNnr
        YEWKKRng==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mssEU-005PGQ-3m; Thu, 02 Dec 2021 19:59:06 +0000
Date:   Thu, 2 Dec 2021 19:59:06 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [5.4 PATCH] mm/gup: Do not force a COW break on file-backed
 memory
Message-ID: <YaklihoYztAoKfxX@casper.infradead.org>
References: <20211201231757.332199-1-willy@infradead.org>
 <CAG48ez3YNCNZB7AktmRoYLsBQjwBdwueRUXbkFgNVMsgjmCTGA@mail.gmail.com>
 <YahHZOnT1Uh41XnP@casper.infradead.org>
 <CAHk-=wiHpPXjA=i6e=3Pk13frRd-RVXfSrT6=KfU2tg4Pu5MmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiHpPXjA=i6e=3Pk13frRd-RVXfSrT6=KfU2tg4Pu5MmQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 10:54:48AM -0800, Linus Torvalds wrote:
> On Wed, Dec 1, 2021 at 8:11 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > The other patch we've been kicking around (and works) is:
> >
> >  static inline bool should_force_cow_break(struct vm_area_struct *vma, unsigned
> > int flags)
> >  {
> > -       return is_cow_mapping(vma->vm_flags) && (flags & FOLL_GET);
> > +       return is_cow_mapping(vma->vm_flags) &&
> > +               (!(vma->vm_flags & VM_DENYWRITE)) && (flags & FOLL_GET);
> >  }
> 
> That patch makes no sense to me.
> 
> It may "work", but it doesn't actually do anything sensible or really
> fix the problem that I can tell.

Oh absolutely, it's semantically nonsense.  The only reason it fixes the
problem is that VM_DENYWRITE VMAs are the only ones considered for the
RO_THP merging, so they're the only ones which we've seen causing a
problem.

> I suspect a real fix would be bigger and more invasive.

Darn.  I was hoping you were going to say something like "The real
problem is follow_trans_huge_pmd() is complete garbage and it should
just do X, Y and Z".  Or "When we force on FOLL_WRITE, we should also
force on FOLL_SPLIT_PMD".

> If the answer is not to backport all the other changes (and they were
> _really_ invasive), I think one answer may be to simply move the
> "should_force_cow_break()" down to below the point where you've looked
> up the page.
> 
> Then you can actually look at "is this a file mapped page", and say
> "if so, that's ok, we can return it as-is".
> 
> Otherwise, you do something like
> 
>         foll_flags |= FOLL_WRITE;
>         free_page(page);
>         goto repeat;
> 
> to repeat the loop (now with FOLL_WRITE).
> 
> So the patch is bigger and more involved, because you would have done
> the page lookup (for reading) and now notice "Oh, I need it for
> writing instead" so you need to undo and re-do).
> 
> But at least - unlike backporting everything else - it would be
> limited to that one __get_user_pages() function.
> 
> Hmm?
> 
> (And you'd need to handle that follow_hugetlb_page() case too), not
> just the follow_page_mask() one)

Thanks, I'll take a look.
