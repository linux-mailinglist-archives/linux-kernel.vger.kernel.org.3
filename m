Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0670D46A4B3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242669AbhLFSip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239809AbhLFSio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:38:44 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3105C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 10:35:15 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id e136so33859656ybc.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 10:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y3HjktOv6t21xt7CIAInQWpNPiqttIzPZJjBymy0evo=;
        b=Cy4AQZseFCuEIVua+q27GHpAGlc/ed7HEBF2dsr2OkWge98n9/t/wA4+fgAjORzeTO
         sVToNyEJAW4VPHW7m4/3bCcFHhx4A0p9+ccaIRHZGgPvfyjmUT3QX8alLgCAzYlynF3W
         pTF2yLhR/qQlUPbMGKBfbwQAkAb+Azcad4FBfOVLrhPEet0lfrcUSS9t9rdX7zc4ePG4
         ysLRqdKYfuMkn//al3DsZdjU/Op6EApplDnJyFEcdjlT8a5PQScvBknxScmmNSr3iqZ8
         EbBoVAqRVFjCtN3JqwvQpH0pb16JR1E9nEpvnrzEEHLgnJwqCXiwhDQbuuBX+qxsbV2S
         6f4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y3HjktOv6t21xt7CIAInQWpNPiqttIzPZJjBymy0evo=;
        b=0Be+YWxUijDzIg8CSl9S6ApA9EFVlCJ95QqLY4Gwr+XOEXx99rMMsrsD1kTTC60Bj/
         KjAW7I7alTPbMie86IRqt823lUKewt0y3aWbjD6EYnUf+/OHh1mmNCT4jHk76qY2fPzP
         maxxYXI7lYk0UEpih4/hbWtrM+ZfqT5KRNBQDZez83yuIPJonltrI5xN3p4Wl4v2AVhY
         mwBuSlmu0kXPPFBw12BoZUZw6CLZT2JgC7mfMdRIzmOf3oKEr46mp1g6WYaM7I/X7FFd
         RLsGsTryA/3wHt6uDyRN/M/ZP4srmsOQMKqQVcriqL00PtnfGIFcK/gaaaoSR1aPrt01
         hjuQ==
X-Gm-Message-State: AOAM532D1ylm65EIkxIqj2/Ev/EsbUad+QNMM3pt+C63D1K2sbHCGObA
        L7UxpMnsyU5o/swIlahmnMaCK6J7e5CzhAl9apwBDg==
X-Google-Smtp-Source: ABdhPJzFnBMVAi2zKaKaX24HcMX1B/t/eiFdgd2HmTaJnugWVLJ4ZpaxKqmeXJciAgBJPWZ547+s3oTYmsEZ9rECeCU=
X-Received: by 2002:a25:610d:: with SMTP id v13mr42107773ybb.1.1638815714773;
 Mon, 06 Dec 2021 10:35:14 -0800 (PST)
MIME-Version: 1.0
References: <20211124235906.14437-1-surenb@google.com> <YaS4KxCSLK+02xaF@dhcp22.suse.cz>
In-Reply-To: <YaS4KxCSLK+02xaF@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 6 Dec 2021 10:35:03 -0800
Message-ID: <CAJuCfpEZi=4V7=nD-4gWi=QyQ8-=ezwmx80twndtoPpZSCzEGQ@mail.gmail.com>
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

On Mon, Nov 29, 2021 at 3:23 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 24-11-21 15:59:05, Suren Baghdasaryan wrote:
> > oom-reaper and process_mrelease system call should protect against
> > races with exit_mmap which can destroy page tables while they
> > walk the VMA tree. oom-reaper protects from that race by setting
> > MMF_OOM_VICTIM and by relying on exit_mmap to set MMF_OOM_SKIP
> > before taking and releasing mmap_write_lock. process_mrelease has
> > to elevate mm->mm_users to prevent such race. Both oom-reaper and
> > process_mrelease hold mmap_read_lock when walking the VMA tree.
> > The locking rules and mechanisms could be simpler if exit_mmap takes
> > mmap_write_lock while executing destructive operations such as
> > free_pgtables.
> > Change exit_mmap to hold the mmap_write_lock when calling
> > free_pgtables. Operations like unmap_vmas() and unlock_range() are not
> > destructive and could run under mmap_read_lock but for simplicity we
> > take one mmap_write_lock during almost the entire operation. Note
> > also that because oom-reaper checks VM_LOCKED flag, unlock_range()
> > should not be allowed to race with it.
> > In most cases this lock should be uncontended. Previously, Kirill
> > reported ~4% regression caused by a similar change [1]. We reran the
> > same test and although the individual results are quite noisy, the
> > percentiles show lower regression with 1.6% being the worst case [2].
> > The change allows oom-reaper and process_mrelease to execute safely
> > under mmap_read_lock without worries that exit_mmap might destroy page
> > tables from under them.
> >
> > [1] https://lore.kernel.org/all/20170725141723.ivukwhddk2voyhuc@node.shutemov.name/
> > [2] https://lore.kernel.org/all/CAJuCfpGC9-c9P40x7oy=jy5SphMcd0o0G_6U1-+JAziGKG6dGA@mail.gmail.com/
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> > changes in v2
> > - Moved mmap_write_unlock to cover remove_vma loop as well, per Matthew Wilcox
> >
> >  mm/mmap.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index bfb0ea164a90..f4e09d390a07 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -3142,25 +3142,27 @@ void exit_mmap(struct mm_struct *mm)
> >                * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
> >                * __oom_reap_task_mm() will not block.
> >                *
> > -              * This needs to be done before calling munlock_vma_pages_all(),
> > +              * This needs to be done before calling unlock_range(),
> >                * which clears VM_LOCKED, otherwise the oom reaper cannot
> >                * reliably test it.
> >                */
> >               (void)__oom_reap_task_mm(mm);
> >
> >               set_bit(MMF_OOM_SKIP, &mm->flags);
>
> Why do you keep this in place?

Sorry for the delay, I was out last week.
I missed your comment about removing MMF_OOM_SKIP at
https://lore.kernel.org/all/YYrO%2FPwdsyaxJaNZ@dhcp22.suse.cz
I'll look into removing it in a separate patch, which I think would be cleaner.

>
> Other than that looks OK to me. Maybe we want to add an explicit note
> that vm_ops::close cannot take mmap_sem in any form. The changelog
> should also mention that you have considered remove_vma and its previous
> no MM locking assumption. You can argue that fput is async and close
> callback shouldn't really need mmap_sem.

Should I post another version of this patch with the patch description
clarifying these points and additional comments as you suggested?

> --
> Michal Hocko
> SUSE Labs
