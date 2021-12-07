Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2589C46C0F5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 17:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239207AbhLGQxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 11:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239026AbhLGQxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 11:53:46 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0C4C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 08:50:16 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id f186so42510615ybg.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 08:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Coee/ZPuNSVySMXoX42VaPVzCeLKQsHWecglETbTUjs=;
        b=FwdeANTcQCdcMtKb07Jo5JVa2I7xGWSfrOieceySp/BgWpC645eRgjwctWMOmTjl2+
         lRNOpacBvqvdBOzzug95tj1BTnC3yVmaPilJyZ13goMcI9xx4wANJbDfLUbTJWcr99zU
         mvqCi1ybyqLuoFFI4u78/1rlnbwKAMf7lB81K4+NkJcioCWPJVNebdOdFYEb5UDPefbw
         1ztIak4J2YBT7ZCOaHF/G01xiNz2g/mzbT3cM9UrGw9l5KZK9u2a/33eyj0sVmT3EJyl
         65v7Ju28jqwCxrV765ZNv/vmIXjvRamunMkYebDOF943qCzJUSeVRyWwMxptvv+TgMGD
         Y8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Coee/ZPuNSVySMXoX42VaPVzCeLKQsHWecglETbTUjs=;
        b=McVs21z9Oezr5JH6UFSYgUP//w1CKpXXNG15HIJ2nVcT8splxFi4VTf1io/yc4Lx0K
         SlzmRM4QOqfcxJW5x0P+ZvrzrcKxYUdAQ3bRzElRvPV7La6SEgF6SJ50mmjz9OLRw37w
         ucaV2sZs5Gov1loFRRBpkQSfYyNmbQ+3p6rQX/tdpwy1Vuq8shXN+0O7zPcQRGaTUVsR
         equOVzZYWzJ2G8ZuRl+vtQRm2gn34n97Sz9ChmG7TsjjrOS3+8G6IgZ51dC9RFfd3+R2
         +xsno85C6agBZ8T1+CHs/+3Znv46jlKc7QNmsJ26WC5iLQ/P3+zyMqZMFFQ/fv3PhdDG
         raog==
X-Gm-Message-State: AOAM530XIk7OFDm83AZ+H9QK4lw6ilc0gEX3X5VtTciIQp7oiJ3DLrXy
        d4W8jdY0YYFc3GIzMMUzkx7lxmbmVrUSNoPRGVDKeA==
X-Google-Smtp-Source: ABdhPJy8WYKqDTiM71KToLHA3KaZzhA9PEA2rdqcL15s+hZPvYSLPvyCNAqwdaum6x6MU+qhdUsoOgnKFI47oYJYLbQ=
X-Received: by 2002:a25:6ec5:: with SMTP id j188mr52452546ybc.602.1638895815343;
 Tue, 07 Dec 2021 08:50:15 -0800 (PST)
MIME-Version: 1.0
References: <20211124235906.14437-1-surenb@google.com> <YaS4KxCSLK+02xaF@dhcp22.suse.cz>
 <CAJuCfpEZi=4V7=nD-4gWi=QyQ8-=ezwmx80twndtoPpZSCzEGQ@mail.gmail.com> <Ya8y9ya1NEZhx03e@dhcp22.suse.cz>
In-Reply-To: <Ya8y9ya1NEZhx03e@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 7 Dec 2021 08:50:04 -0800
Message-ID: <CAJuCfpHFy6EhzxR6Zj8X_s=qwrNh0S8-o4ugEzYbh-z_LDtJSQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: protect free_pgtables with mmap_lock write
 lock in exit_mmap
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 2:10 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 06-12-21 10:35:03, Suren Baghdasaryan wrote:
> > On Mon, Nov 29, 2021 at 3:23 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Wed 24-11-21 15:59:05, Suren Baghdasaryan wrote:
> > > > oom-reaper and process_mrelease system call should protect against
> > > > races with exit_mmap which can destroy page tables while they
> > > > walk the VMA tree. oom-reaper protects from that race by setting
> > > > MMF_OOM_VICTIM and by relying on exit_mmap to set MMF_OOM_SKIP
> > > > before taking and releasing mmap_write_lock. process_mrelease has
> > > > to elevate mm->mm_users to prevent such race. Both oom-reaper and
> > > > process_mrelease hold mmap_read_lock when walking the VMA tree.
> > > > The locking rules and mechanisms could be simpler if exit_mmap takes
> > > > mmap_write_lock while executing destructive operations such as
> > > > free_pgtables.
> > > > Change exit_mmap to hold the mmap_write_lock when calling
> > > > free_pgtables. Operations like unmap_vmas() and unlock_range() are not
> > > > destructive and could run under mmap_read_lock but for simplicity we
> > > > take one mmap_write_lock during almost the entire operation. Note
> > > > also that because oom-reaper checks VM_LOCKED flag, unlock_range()
> > > > should not be allowed to race with it.
> > > > In most cases this lock should be uncontended. Previously, Kirill
> > > > reported ~4% regression caused by a similar change [1]. We reran the
> > > > same test and although the individual results are quite noisy, the
> > > > percentiles show lower regression with 1.6% being the worst case [2].
> > > > The change allows oom-reaper and process_mrelease to execute safely
> > > > under mmap_read_lock without worries that exit_mmap might destroy page
> > > > tables from under them.
> > > >
> > > > [1] https://lore.kernel.org/all/20170725141723.ivukwhddk2voyhuc@node.shutemov.name/
> > > > [2] https://lore.kernel.org/all/CAJuCfpGC9-c9P40x7oy=jy5SphMcd0o0G_6U1-+JAziGKG6dGA@mail.gmail.com/
> > > >
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > ---
> > > > changes in v2
> > > > - Moved mmap_write_unlock to cover remove_vma loop as well, per Matthew Wilcox
> > > >
> > > >  mm/mmap.c | 16 ++++++++--------
> > > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > index bfb0ea164a90..f4e09d390a07 100644
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> > > > @@ -3142,25 +3142,27 @@ void exit_mmap(struct mm_struct *mm)
> > > >                * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
> > > >                * __oom_reap_task_mm() will not block.
> > > >                *
> > > > -              * This needs to be done before calling munlock_vma_pages_all(),
> > > > +              * This needs to be done before calling unlock_range(),
> > > >                * which clears VM_LOCKED, otherwise the oom reaper cannot
> > > >                * reliably test it.
> > > >                */
> > > >               (void)__oom_reap_task_mm(mm);
> > > >
> > > >               set_bit(MMF_OOM_SKIP, &mm->flags);
> > >
> > > Why do you keep this in place?
> >
> > Sorry for the delay, I was out last week.
> > I missed your comment about removing MMF_OOM_SKIP at
> > https://lore.kernel.org/all/YYrO%2FPwdsyaxJaNZ@dhcp22.suse.cz
> > I'll look into removing it in a separate patch, which I think would be cleaner.
>
> The point of this code was to sync up the oom_repaer and exit_mmap. Now
> that your patch uses proper locking for that to happen then MMF_OOM_SKIP
> is not really necessary. IIRC all you need to guarantee is that the vma
> tree is empty when exit_mmap does all its work - i.e set mm->mmap to
> NULL. You can do that after remove_vma loop but it would be equally safe
> at any time after vma = mm->mmap as the loop relies on the vma chain.
> Doing that after would be slightly nicer if you ask me.

Will do. But if you don't mind I'll post the removal of MMF_OOM_SKIP
as a separate patch. This patchset has already been extensively tested
and it will be easier for me to test MMF_OOM_SKIP removal separately.

>
> > > Other than that looks OK to me. Maybe we want to add an explicit note
> > > that vm_ops::close cannot take mmap_sem in any form. The changelog
> > > should also mention that you have considered remove_vma and its previous
> > > no MM locking assumption. You can argue that fput is async and close
> > > callback shouldn't really need mmap_sem.
> >
> > Should I post another version of this patch with the patch description
> > clarifying these points and additional comments as you suggested?
>
> Yes please.

Will re-post. So, to clarify, we want:
- Patch description to include explanation that remove_vma is now
being called under MM lock but this should not be a problem because
fput and vm_ops->close do not and should not take mmap_sem.
- Add a comment for vm_ops->close that the callback should not take
mmap_sem, with explanation that __split_vma and exit_mmap use this
callback with the mmap_sem write lock taken.
Is that correct?

>
> --
> Michal Hocko
> SUSE Labs
