Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A4846B880
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbhLGKNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:13:31 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41794 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbhLGKNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:13:30 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A974D1FD2F;
        Tue,  7 Dec 2021 10:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638871799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lfsjs8k6aVAvDBSMSsv9epTpHubEEZQUmQTxDrYjVW8=;
        b=sCopTl9C7JY48GuMafPEE5asyJ/ioU/Kv8o+Ek/Mimy0Qgph6G4OJ56S7Fcpmoswgubgh+
        IbG6dg/wuKVHdvZR522xnp+1I+CoriW/ldCqlKhy3N7hKQO7yzdN2Ib9Qg07jv8h7+BNx2
        z8LpMefUeVVwwOMSdFvjYsZvRXSKu40=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 709E8A3B87;
        Tue,  7 Dec 2021 10:09:59 +0000 (UTC)
Date:   Tue, 7 Dec 2021 11:09:59 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/2] mm: protect free_pgtables with mmap_lock write
 lock in exit_mmap
Message-ID: <Ya8y9ya1NEZhx03e@dhcp22.suse.cz>
References: <20211124235906.14437-1-surenb@google.com>
 <YaS4KxCSLK+02xaF@dhcp22.suse.cz>
 <CAJuCfpEZi=4V7=nD-4gWi=QyQ8-=ezwmx80twndtoPpZSCzEGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEZi=4V7=nD-4gWi=QyQ8-=ezwmx80twndtoPpZSCzEGQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06-12-21 10:35:03, Suren Baghdasaryan wrote:
> On Mon, Nov 29, 2021 at 3:23 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 24-11-21 15:59:05, Suren Baghdasaryan wrote:
> > > oom-reaper and process_mrelease system call should protect against
> > > races with exit_mmap which can destroy page tables while they
> > > walk the VMA tree. oom-reaper protects from that race by setting
> > > MMF_OOM_VICTIM and by relying on exit_mmap to set MMF_OOM_SKIP
> > > before taking and releasing mmap_write_lock. process_mrelease has
> > > to elevate mm->mm_users to prevent such race. Both oom-reaper and
> > > process_mrelease hold mmap_read_lock when walking the VMA tree.
> > > The locking rules and mechanisms could be simpler if exit_mmap takes
> > > mmap_write_lock while executing destructive operations such as
> > > free_pgtables.
> > > Change exit_mmap to hold the mmap_write_lock when calling
> > > free_pgtables. Operations like unmap_vmas() and unlock_range() are not
> > > destructive and could run under mmap_read_lock but for simplicity we
> > > take one mmap_write_lock during almost the entire operation. Note
> > > also that because oom-reaper checks VM_LOCKED flag, unlock_range()
> > > should not be allowed to race with it.
> > > In most cases this lock should be uncontended. Previously, Kirill
> > > reported ~4% regression caused by a similar change [1]. We reran the
> > > same test and although the individual results are quite noisy, the
> > > percentiles show lower regression with 1.6% being the worst case [2].
> > > The change allows oom-reaper and process_mrelease to execute safely
> > > under mmap_read_lock without worries that exit_mmap might destroy page
> > > tables from under them.
> > >
> > > [1] https://lore.kernel.org/all/20170725141723.ivukwhddk2voyhuc@node.shutemov.name/
> > > [2] https://lore.kernel.org/all/CAJuCfpGC9-c9P40x7oy=jy5SphMcd0o0G_6U1-+JAziGKG6dGA@mail.gmail.com/
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > > changes in v2
> > > - Moved mmap_write_unlock to cover remove_vma loop as well, per Matthew Wilcox
> > >
> > >  mm/mmap.c | 16 ++++++++--------
> > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index bfb0ea164a90..f4e09d390a07 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -3142,25 +3142,27 @@ void exit_mmap(struct mm_struct *mm)
> > >                * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
> > >                * __oom_reap_task_mm() will not block.
> > >                *
> > > -              * This needs to be done before calling munlock_vma_pages_all(),
> > > +              * This needs to be done before calling unlock_range(),
> > >                * which clears VM_LOCKED, otherwise the oom reaper cannot
> > >                * reliably test it.
> > >                */
> > >               (void)__oom_reap_task_mm(mm);
> > >
> > >               set_bit(MMF_OOM_SKIP, &mm->flags);
> >
> > Why do you keep this in place?
> 
> Sorry for the delay, I was out last week.
> I missed your comment about removing MMF_OOM_SKIP at
> https://lore.kernel.org/all/YYrO%2FPwdsyaxJaNZ@dhcp22.suse.cz
> I'll look into removing it in a separate patch, which I think would be cleaner.

The point of this code was to sync up the oom_repaer and exit_mmap. Now
that your patch uses proper locking for that to happen then MMF_OOM_SKIP
is not really necessary. IIRC all you need to guarantee is that the vma
tree is empty when exit_mmap does all its work - i.e set mm->mmap to
NULL. You can do that after remove_vma loop but it would be equally safe
at any time after vma = mm->mmap as the loop relies on the vma chain.
Doing that after would be slightly nicer if you ask me.
 
> > Other than that looks OK to me. Maybe we want to add an explicit note
> > that vm_ops::close cannot take mmap_sem in any form. The changelog
> > should also mention that you have considered remove_vma and its previous
> > no MM locking assumption. You can argue that fput is async and close
> > callback shouldn't really need mmap_sem.
> 
> Should I post another version of this patch with the patch description
> clarifying these points and additional comments as you suggested?

Yes please.

-- 
Michal Hocko
SUSE Labs
