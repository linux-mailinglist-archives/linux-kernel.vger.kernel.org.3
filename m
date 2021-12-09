Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFC846F396
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhLITHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhLITG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:06:57 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F10C0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 11:03:23 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id e136so15987423ybc.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 11:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mFgPKxEL0IYHP9XylpFOWxnMIuX8VMB5Vdn/l5Gnhv4=;
        b=d49r+a/yxhwOKt2CtOzzbORMPT/pqNpe+rgLAEHE+SZtZY+J0Q/dASqGQEoOO63AKl
         IZGCxDaRUpLkaPs65s0MelNCEZMOzGWu1jxmrZ5NMk5dQFW7Au7fieqDSWvLVewsPghi
         JXyseLJkwccRHATEPFZhMQW8coGfhXWVFI5DXDa2n/mkNMcBfzlrWlcmzrrNPZi9GbN5
         EXjFZQ23bMTrQD0h2s3J5ByCxNqWXe7wGhQr+exDwJ6XnHRB0+m+hrj0kNvx7hVgwMJd
         0IeO9FYOCWP8SCL3UyqUcFOiT6+XAFctnrpvoAonrahMEdKNAy5CdS57TCljfW/BBsbw
         +BTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFgPKxEL0IYHP9XylpFOWxnMIuX8VMB5Vdn/l5Gnhv4=;
        b=c57HePOVPPr/dTnFBmYOlaLte5tsyJC4YJ2Di5nll6+hnggFauL3jd+IFwwAHJvXtV
         w28GUX3QpfJ7uezO1HZLZD8HwgW6SWV1wK/ajW/FJ9zutCKPZ0c4AdADt8eWbEg4+awh
         S0b7uNkEnBKULHfRMNDTIG0s2T6VpVzXs3PPP5FtR7/xGk/fNPqJHwO3v3I2rrUvwiXi
         6VwGRl95pNSjVCrTBxe/sZjtyFePRSpNwJY468z6FAXs5CG7EgiFmu0/Z/nRBG3DyL24
         BCnbwVULxbDnetzlDAniTsUVQR99mbwHCy5qflj83FUI0PQ3p+Lvfpk7VdHXGQP/mi1u
         CnqA==
X-Gm-Message-State: AOAM530skfGAYmO8sZFZBU3H5Faw2Aj5vpdst7v8EZdAPNwjDVPJ3dbb
        7c5GqrusPPylkman3gbjpQ8s3YmjMsYIJXoT3PkFzQ==
X-Google-Smtp-Source: ABdhPJyLoK6MoV/dr1IqHWQLckho4ke9rkGF44TsXb9R/qALOruPqSksrOVV/ixlpa0mwThmIPfWCovcEqSJsBovAWE=
X-Received: by 2002:a25:610d:: with SMTP id v13mr7892030ybb.1.1639076602764;
 Thu, 09 Dec 2021 11:03:22 -0800 (PST)
MIME-Version: 1.0
References: <20211208212211.2860249-1-surenb@google.com> <YbHEgLi1g1XtsOgh@dhcp22.suse.cz>
In-Reply-To: <YbHEgLi1g1XtsOgh@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 9 Dec 2021 11:03:11 -0800
Message-ID: <CAJuCfpE4CWMAAFGPjvEz=a6_2kpMSY8hhUMWJ5GtfDv7uD8jng@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] mm: protect free_pgtables with mmap_lock write
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

On Thu, Dec 9, 2021 at 12:55 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 08-12-21 13:22:09, Suren Baghdasaryan wrote:
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
> > free_pgtables and remove_vma. Operations like unmap_vmas and
> > unlock_range are not destructive and could run under mmap_read_lock
> > but for simplicity we take one mmap_write_lock during almost the entire
> > operation.
>
> unlock_range is not safe to be called under read lock. See 27ae357fa82b
> ("mm, oom: fix concurrent munlock and oom reaper unmap, v3").

Ok, I'll remove the sentence above.
Is my understanding correct that it is unsafe only because oom-reaper
can't deal with VM_LOCKED, otherwise it would be fine?

>
> > Note also that because oom-reaper checks VM_LOCKED flag,
> > unlock_range() should not be allowed to race with it.
> > Before this patch, remove_vma used to be called with no locks held,
> > however with fput being executed asynchronously and vm_ops->close
> > not being allowed to hold mmap_lock (it is called from __split_vma
> > with mmap_sem held for write), changing that should be fine.
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
>
> The patch looks good otherwise. Btw. when I was trying to do something
> similar in the past Hugh has noted that we can get rid of the same
> lock&&unlock trick in ksm. Maybe you want to have a look at that as well
> ;)

I'll take a look after we cleanup this path completely (oom pieces included).

>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

>
> Thanks!
>
> > ---
> > changes in v4
> > - Separated comments describing vm_operations_struct::close locking
> > requirements into a separate patch, per Matthew Wilcox
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
> > -             mmap_write_lock(mm);
> > -             mmap_write_unlock(mm);
> >       }
> >
> > +     mmap_write_lock(mm);
> >       if (mm->locked_vm)
> >               unlock_range(mm->mmap, ULONG_MAX);
> >
> >       arch_exit_mmap(mm);
> >
> >       vma = mm->mmap;
> > -     if (!vma)       /* Can happen if dup_mmap() received an OOM */
> > +     if (!vma) {
> > +             /* Can happen if dup_mmap() received an OOM */
> > +             mmap_write_unlock(mm);
> >               return;
> > +     }
> >
> >       lru_add_drain();
> >       flush_cache_mm(mm);
> > @@ -3171,16 +3173,14 @@ void exit_mmap(struct mm_struct *mm)
> >       free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
> >       tlb_finish_mmu(&tlb);
> >
> > -     /*
> > -      * Walk the list again, actually closing and freeing it,
> > -      * with preemption enabled, without holding any MM locks.
> > -      */
> > +     /* Walk the list again, actually closing and freeing it. */
> >       while (vma) {
> >               if (vma->vm_flags & VM_ACCOUNT)
> >                       nr_accounted += vma_pages(vma);
> >               vma = remove_vma(vma);
> >               cond_resched();
> >       }
> > +     mmap_write_unlock(mm);
> >       vm_unacct_memory(nr_accounted);
> >  }
> >
> > --
> > 2.34.1.400.ga245620fadb-goog
>
> --
> Michal Hocko
> SUSE Labs
