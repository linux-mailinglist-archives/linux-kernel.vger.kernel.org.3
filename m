Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DCA52DFDD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 00:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237755AbiESWOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 18:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbiESWOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 18:14:36 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E6FEBA98
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:14:34 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2ff7b90e635so4726557b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JInIfpZUYcq3BWyfoPd2F7qbA19NK6yysinA9rAJ79E=;
        b=dgEyeIh2qdnIlyJzYUEQlSyi2q6MbvAd9Y3VgnD3PNs4ZfLbiWSCavxNJhIyZ9zQhD
         zFzAcE89AUYocfdywFHIDac6Gp+ZPWRwSPr1D9rOD3mVcnIJMflQlNOC6p+N8QvwQ2+M
         m4e3X3qx5ymvjEThikcL/GZKQVNzuCA0K6XZ/E7s2lo4pGvGHGL3eP9TVQwc8zshqop5
         2G0Y0d/r0WKRDad9lcd7AzDXnot5O29mLJcwO5Z5ipmDVgFnF9CWzBt72nL8lP+BIwwR
         HqF4V6bNTs9RyKVn1DoDJQGtdBmwCqsnjiq1JkGlF6w7rGbm8FsxA95J6Dek5LI/3UM6
         3O0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JInIfpZUYcq3BWyfoPd2F7qbA19NK6yysinA9rAJ79E=;
        b=ES3QG9SO2Us7e7maJ9u+JY5XYuzE8FL+g0sd6H1yjPssaJ9F8gx0edjcJAaBvz+DV/
         8uncgO4kFzMCeHCixJigUzmie0gNRJ5ZvOwgAgxTUPmrm4PDM0qVBbycvkxNUiUgD5Pm
         KvnyWoUF3zqYMLfamjo/YYXG5gpcQCxoEr1+rIzYIaSpBIvWnusryG9rVz/AjUInRPGl
         CyV3e2PYg7w/BsWvqiNKFnL5NQ2aEe1MtoUjkDa1QPyBD/vgJ+KHTdAyk3wL18nDLW/W
         M5mK1Io3B1ESBrrLVQi2eVcKVQhW1y1x4rKoT479Yw8UstQr99e9U9MwKk9Iy6Q3o7cq
         JNDQ==
X-Gm-Message-State: AOAM5310qkrtY1NkhrlDPWru7iwBl/iABYmn/ueluAUq+oc7qc6XgrtR
        n5OZDIfaKb/gMTSX3Oac50ok5rRi1l2z4GYEQKiYuQ==
X-Google-Smtp-Source: ABdhPJxEzMjXFh/Ot46pas3miDavFYy02ALpbXRun/EWow+p7Zhod5t21WV+UhSA7OHjnn7DQgcEd0ZwUIEX9zA9j84=
X-Received: by 2002:a81:990f:0:b0:2f8:c347:d11a with SMTP id
 q15-20020a81990f000000b002f8c347d11amr6755069ywg.507.1652998473830; Thu, 19
 May 2022 15:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220516075619.1277152-1-surenb@google.com> <20220519202149.3ywynqhbxlzp6uyn@revolver>
 <CAJuCfpHeAXSLjrXxgRaTXOEPPipcFq5MhP=uU0wkqeBoPUAcsQ@mail.gmail.com>
In-Reply-To: <CAJuCfpHeAXSLjrXxgRaTXOEPPipcFq5MhP=uU0wkqeBoPUAcsQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 19 May 2022 15:14:22 -0700
Message-ID: <CAJuCfpEvrLyZHLt4vgLFqb5XAntnXfvTWqEtzC7TA0cMfVq40A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: drop oom code from exit_mmap
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "guro@fb.com" <guro@fb.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "david@redhat.com" <david@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kernel-team@android.com" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 2:33 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Thu, May 19, 2022 at 1:22 PM Liam Howlett <liam.howlett@oracle.com> wrote:
> >
> > * Suren Baghdasaryan <surenb@google.com> [220516 03:56]:
> > > The primary reason to invoke the oom reaper from the exit_mmap path used
> > > to be a prevention of an excessive oom killing if the oom victim exit
> > > races with the oom reaper (see [1] for more details). The invocation has
> > > moved around since then because of the interaction with the munlock
> > > logic but the underlying reason has remained the same (see [2]).
> > >
> > > Munlock code is no longer a problem since [3] and there shouldn't be
> > > any blocking operation before the memory is unmapped by exit_mmap so
> > > the oom reaper invocation can be dropped. The unmapping part can be done
> > > with the non-exclusive mmap_sem and the exclusive one is only required
> > > when page tables are freed.
> > >
> > > Remove the oom_reaper from exit_mmap which will make the code easier to
> > > read. This is really unlikely to make any observable difference although
> > > some microbenchmarks could benefit from one less branch that needs to be
> > > evaluated even though it almost never is true.
> > >
> > > [1] 212925802454 ("mm: oom: let oom_reap_task and exit_mmap run concurrently")
> > > [2] 27ae357fa82b ("mm, oom: fix concurrent munlock and oom reaper unmap, v3")
> > > [3] a213e5cf71cb ("mm/munlock: delete munlock_vma_pages_all(), allow oomreap")
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > ---
> > >  include/linux/oom.h |  2 --
> > >  mm/mmap.c           | 31 ++++++++++++-------------------
> > >  mm/oom_kill.c       |  2 +-
> > >  3 files changed, 13 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/include/linux/oom.h b/include/linux/oom.h
> > > index 2db9a1432511..6cdf0772dbae 100644
> > > --- a/include/linux/oom.h
> > > +++ b/include/linux/oom.h
> > > @@ -106,8 +106,6 @@ static inline vm_fault_t check_stable_address_space(struct mm_struct *mm)
> > >       return 0;
> > >  }
> > >
> > > -bool __oom_reap_task_mm(struct mm_struct *mm);
> > > -
> > >  long oom_badness(struct task_struct *p,
> > >               unsigned long totalpages);
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 313b57d55a63..ded42150e706 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -3105,30 +3105,13 @@ void exit_mmap(struct mm_struct *mm)
> > >       /* mm's last user has gone, and its about to be pulled down */
> > >       mmu_notifier_release(mm);
> > >
> > > -     if (unlikely(mm_is_oom_victim(mm))) {
> > > -             /*
> > > -              * Manually reap the mm to free as much memory as possible.
> > > -              * Then, as the oom reaper does, set MMF_OOM_SKIP to disregard
> > > -              * this mm from further consideration.  Taking mm->mmap_lock for
> > > -              * write after setting MMF_OOM_SKIP will guarantee that the oom
> > > -              * reaper will not run on this mm again after mmap_lock is
> > > -              * dropped.
> > > -              *
> > > -              * Nothing can be holding mm->mmap_lock here and the above call
> > > -              * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
> > > -              * __oom_reap_task_mm() will not block.
> > > -              */
> > > -             (void)__oom_reap_task_mm(mm);
> > > -             set_bit(MMF_OOM_SKIP, &mm->flags);
> > > -     }
> > > -
> > > -     mmap_write_lock(mm);
> > > +     mmap_read_lock(mm);
> > >       arch_exit_mmap(mm);
> >
> > arch_exit_mmap() was called under the write lock before, is it safe to
> > call it under the read lock?
>
> Ah, good catch. I missed at least one call chain which I believe would
> require arch_exit_mmap() to be called under write lock:
>
> arch_exit_mmap
>     ldt_arch_exit_mmap
>         free_ldt_pgtables
>             free_pgd_range
>
> I'll need to check whether arch_exit_mmap() has to be called before
> unmap_vmas(). If not, we could move it further down when we hold the
> write lock.
> Andrew, please remove this patchset from your tree for now until I fix this.

I think it should be fine to move arch_exit_mmap() to be called right
after mmap_write_lock. This changes the order of calls from:

arch_exit_mmap()
unmap_vmas()

to

unmap_vmas()
arch_exit_mmap()

however I don't see any implementation of arch_exit_mmap() which uses
mm->mmap. So, it seems safe. I'll wait a day or so for possible
objections and will post a new version.

>
> >
> > >
> > >       vma = mm->mmap;
> > >       if (!vma) {
> > >               /* Can happen if dup_mmap() received an OOM */
> > > -             mmap_write_unlock(mm);
> > > +             mmap_read_unlock(mm);
> > >               return;
> > >       }
> > >
> > > @@ -3138,6 +3121,16 @@ void exit_mmap(struct mm_struct *mm)
> > >       /* update_hiwater_rss(mm) here? but nobody should be looking */
> > >       /* Use -1 here to ensure all VMAs in the mm are unmapped */
> > >       unmap_vmas(&tlb, vma, 0, -1);
> > > +     mmap_read_unlock(mm);
> > > +
> > > +     /*
> > > +      * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
> > > +      * because the memory has been already freed. Do not bother checking
> > > +      * mm_is_oom_victim because setting a bit unconditionally is cheaper.
> > > +      */
> > > +     set_bit(MMF_OOM_SKIP, &mm->flags);
> > > +
> > > +     mmap_write_lock(mm);
> >
> > Is there a race here?  We had a VMA but after the read lock was dropped,
> > could the oom killer cause the VMA to be invalidated?  I don't think so
> > but the comment above about dup_mmap() receiving an OOM makes me
> > question it.  The code before kept the write lock from when the VMA was
> > found until the end of the mm edits - and it had the check for !vma
> > within the block itself.  We are also hiding it from the oom killer
> > outside the read lock so it is possible for oom to find it in that
> > window, right?
>
> When I was trying to understand that comment and looked into
> dup_mmap() code, my conclusion was that this check was there to
> protect us from the case when dup_mmap() gets interrupted and leaves
> mm->mmap=NULL. So, in a sense it was not really a race with OOM killer
> but an interrupted dup_mmap() case. So, once we checked it above we
> don't need to recheck again under write lock. When I asked Michal
> about this he was in agreement but it's possible we overlooked some
> corner case. If so, please let me know and I can add this check here.
>
> >
> > Could we just unconditionally set the skip bit before taking a write
> > lock for the duration of the exit?  I'm probably missing your reason for
> > doing it this way.
>
> That's what I'm doing - unconditionally setting MMF_OOM_SKIP before
> taking the write lock. Did I miss something?
>
> >
> > >       free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
> > >       tlb_finish_mmu(&tlb);
> > >
> > > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > > index 49d7df39b02d..36355b162727 100644
> > > --- a/mm/oom_kill.c
> > > +++ b/mm/oom_kill.c
> > > @@ -509,7 +509,7 @@ static DECLARE_WAIT_QUEUE_HEAD(oom_reaper_wait);
> > >  static struct task_struct *oom_reaper_list;
> > >  static DEFINE_SPINLOCK(oom_reaper_lock);
> > >
> > > -bool __oom_reap_task_mm(struct mm_struct *mm)
> > > +static bool __oom_reap_task_mm(struct mm_struct *mm)
> > >  {
> > >       struct vm_area_struct *vma;
> > >       bool ret = true;
> > > --
> > > 2.36.0.550.gb090851708-goog
> > >
> > >
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> >
