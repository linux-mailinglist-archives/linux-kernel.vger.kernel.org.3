Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8792146DC13
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 20:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbhLHT0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 14:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbhLHTZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 14:25:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D181DC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 11:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BaY9YTruJBe+bh4x73v02WYez6jnp/vPQ8R+2at5oXY=; b=v0rhAGbRra0+8fclVnnMARYBr2
        lf3Z/kkFdQZXsQxhBeNguUCB1HvYL23DZ4X7O8p76K8jIYu5Gfkt3Ep5WB/6nfrFImhc41xK/3j3H
        rpl3tfgVMT56nvgmFbHTM7Xs8Mkwi4caqra+ID2c2AvLA8EIEbUgUll432NXEZMxTlQfkQ+kEaRRJ
        Ws4ZIt/zkh5mw9uzhyOB9XsORMSM00XAToWgJPMvyLxWmc+x+kWRGiX+1QmMidRrKTRPyg0FrHHr3
        SYxdAIialxlDm+FH+CHMv2134Tmqfpr8DSCiTRabA4Ath6MQuNIlx5UbTgUH9mKZZ3Aa21eYO/jZe
        gAyQwSxg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mv2Vy-008hsc-2A; Wed, 08 Dec 2021 19:22:06 +0000
Date:   Wed, 8 Dec 2021 19:22:06 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        rientjes@google.com, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 1/2] mm: protect free_pgtables with mmap_lock write
 lock in exit_mmap
Message-ID: <YbEF3mvk3SUr6WHp@casper.infradead.org>
References: <20211207215031.2251719-1-surenb@google.com>
 <Ya/bFLcnqyvlVzuO@casper.infradead.org>
 <CAJuCfpFwR+uO0GJvCLGQrCaFzB42wNg-FpeOnx2VnxipONkpmg@mail.gmail.com>
 <CAJuCfpG-CU4AywZGDfMRiEtxMWkL4KMJ-xD1eM15C_z5eYdCJA@mail.gmail.com>
 <YbDIxA92ln+RTbUK@casper.infradead.org>
 <YbDUnkmQP3nxd5bv@dhcp22.suse.cz>
 <YbDXuegc6BtRzs/5@casper.infradead.org>
 <CAJuCfpFbF4C8q=40aXcbverm3QFoPzuLgfSU0eT2e7imgp2YfQ@mail.gmail.com>
 <CAJuCfpF0HHXGotVF7Sjo-b4raQcf8a4ckBto8-EE18n1ovmtXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpF0HHXGotVF7Sjo-b4raQcf8a4ckBto8-EE18n1ovmtXQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 11:13:42AM -0800, Suren Baghdasaryan wrote:
> On Wed, Dec 8, 2021 at 8:50 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Wed, Dec 8, 2021 at 8:05 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Wed, Dec 08, 2021 at 04:51:58PM +0100, Michal Hocko wrote:
> > > > On Wed 08-12-21 15:01:24, Matthew Wilcox wrote:
> > > > > On Tue, Dec 07, 2021 at 03:08:19PM -0800, Suren Baghdasaryan wrote:
> > > > > > > >         /**
> > > > > > > >          * @close: Called when the VMA is being removed from the MM.
> > > > > > > >          * Context: Caller holds mmap_lock.
> > > > > >
> > > > > > BTW, is the caller always required to hold mmap_lock for write or it
> > > > > > *might* hold it?
> > > > >
> > > > > __do_munmap() might hold it for read, thanks to:
> > > > >
> > > > >         if (downgrade)
> > > > >                 mmap_write_downgrade(mm);
> > > > >
> > > > > Should probably say:
> > > > >
> > > > >     * Context: User context.  May sleep.  Caller holds mmap_lock.
> > > > >
> > > > > I don't think we should burden the implementor of the vm_ops with the
> > > > > knowledge that the VM chooses to not hold the mmap_lock under certain
> > > > > circumstances when it doesn't matter whether it's holding the mmap_lock
> > > > > or not.
> > > >
> > > > If we document it like that some code might depend on that lock to be
> > > > held. I think we only want to document that the holder itself is not
> > > > allowed to take mmap sem or a depending lock.
> > >
> > > The only place where we're not currently holding the mmap_lock is at
> > > task exit, where the mmap_lock is effectively held because nobody else
> > > can modify the task's mm.  Besides, Suren is changing that in this patch
> > > series anyway, so it will be always true.
> >
> > Ok, I'll make it a separate patch after the patch that changes
> > exit_mmap and this statement will become always true. Sounds
> > reasonable?
> 
> Actually, while today vma_ops->close is called with mmap_lock held, I
> believe we want this comment to reflect the restrictions on the
> callback itself, not on the user. IOW, we want to say that the
> callback should not take mmap_lock while the caller might or might not
> hold it. If so, I think *might* would make more sense here, like this:
> 
> * Context: User context.  May sleep.  Caller might hold mmap_lock.
> 
> WDYT?

We're documenting the contract between the caller and the callee.
That implies responsibilities on both sides.  For example, we're
placing requirements on the caller that they're not going to tear
down the VMA in interrupt context.  So I preferred what previous-Suren
said to current-Suren, "this statement will become always true".

