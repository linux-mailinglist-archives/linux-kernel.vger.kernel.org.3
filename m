Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9012546CF8D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 09:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhLHI7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 03:59:51 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46738 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhLHI7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 03:59:49 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 87B9D212B7;
        Wed,  8 Dec 2021 08:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638953777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PtiOHarMjUzcPZDcJ9qWp4eAA9eXBT5zJWjDVyQGWvM=;
        b=CYRyyfagNt+TyyqEDi82nZ7rUeelq+HO00S3BxPdD3cKLSxaRAeRkNw7btKdePJjGNCALO
        v/7pFhOimr6wrd5KeDov1s/vxemgid1mmCNPiIR4qAiZYjx3XPrLbuKmrjQ962CASMDZIY
        fUhrWdM83tTZZFT3n9ewgOj1LSEDBGw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1746FA3B81;
        Wed,  8 Dec 2021 08:56:17 +0000 (UTC)
Date:   Wed, 8 Dec 2021 09:56:16 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
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
Message-ID: <YbBzMLY59QhorG3y@dhcp22.suse.cz>
References: <20211207215031.2251719-1-surenb@google.com>
 <Ya/bFLcnqyvlVzuO@casper.infradead.org>
 <CAJuCfpFwR+uO0GJvCLGQrCaFzB42wNg-FpeOnx2VnxipONkpmg@mail.gmail.com>
 <CAJuCfpG-CU4AywZGDfMRiEtxMWkL4KMJ-xD1eM15C_z5eYdCJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpG-CU4AywZGDfMRiEtxMWkL4KMJ-xD1eM15C_z5eYdCJA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-12-21 15:08:19, Suren Baghdasaryan wrote:
> On Tue, Dec 7, 2021 at 2:47 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Tue, Dec 7, 2021 at 2:07 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Tue, Dec 07, 2021 at 01:50:30PM -0800, Suren Baghdasaryan wrote:
> > > > - Added a comment for vm_operations_struct::close, documenting restriction for
> > > > taking mmap_lock in the callback, per Michal Hocko and Matthew Wilcox
> > >
> > > This should be a separate patch because it stands alone, but ...
> >
> > I thought about it and since it was relevant to the change in
> > remove_vma locking, I thought it would fit here. However, if you
> > insist on splitting it, I'll post it as a separate patch. Please let
> > me know.
> >
> > >
> > > >  struct vm_operations_struct {
> > > >       void (*open)(struct vm_area_struct * area);
> > > > +    /*
> > > > +     * Called with mmap_lock lock held for write from __split_vma and
> > > > +     * remove_vma, therefore should never take that lock.
> > > > +     */
> > >
> > > Your whitespace indentation is weird.  And it'd be nice to make this a
> > > kernel-doc comment (I know none of the others are, but that should be
> > > fixed too).  And naming the functions that call it is wrong too.
> > >
> > >         /**
> > >          * @close: Called when the VMA is being removed from the MM.
> > >          * Context: Caller holds mmap_lock.
> 
> BTW, is the caller always required to hold mmap_lock for write or it
> *might* hold it?

I would go with might

-- 
Michal Hocko
SUSE Labs
