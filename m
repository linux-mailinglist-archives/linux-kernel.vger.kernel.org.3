Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F1452DF85
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243640AbiESVoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiESVoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:44:11 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593AA59BBF
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:44:10 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id x2so10910944ybi.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BVvEVI1gae0g+RznNTHQM5ME2ObclS23eF+qlAYsdrI=;
        b=iF98yRQS9VgFaJUFchc/P+l6Z4Fqxawr64sc7eiPBIMAfTdfu8SiPYXDzGbhQrAhrm
         WgdjcTXtP2L5AmMZSVFi9VONHfWI32sJePMGG0ULkVwAWlR5WGdiCnlRs8ThkddffuSH
         tcVsPxKpZ9M/rDaMmOu6u+NeyHyYo1n+wIfNYrATsxCPQaGVPlQmO2B9Xe5PKjbThoWA
         IkQe84iPBfv6jmTvDqdlbZ4nOiatVVxYt0CPXgFvrEjIJnj0mP34Zh1tb/lMbSB6Hdes
         1r3p45a/iwLfeB5HWz+bAVhNNsUcayXns3GbsPAhZ3zwQtx8A5Il0ID25U5NUp6tRz4/
         N2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BVvEVI1gae0g+RznNTHQM5ME2ObclS23eF+qlAYsdrI=;
        b=tCvlo66h2iU2aEACZIiA+qAJfM8FKyzG/YtvWF5p7N633vWxMCT7Hho0Fv3jWGfR+y
         8u25E3ItiZ4YUPV2XUDPia2vSCMrFD/dgeRx+B7Pjvymuztc+9cJWTgemfs0l7EGIMLq
         fZbXhQLQ9hUk989/UzrkvpWV2h4SSVYBDb28mRWetlnqePf2AgPN5wTA4QAd6wUFJqOp
         SEIF4LB+Ze22h8FLS1895pPKtBQGh9j5UKKrNUdmA7zPhKEGlXvujNeUqKFB6qtH3ozj
         hCnghgFZaAUOTwR+CLhT/UBjmM68aGSvSjD28VlGmGHkO9GFcTBNRPmtQonzMimeAiqH
         ccbw==
X-Gm-Message-State: AOAM533pcfgRsmVr9YvCNMoF1vf7zkaZvVt2y04E9xri2MLbYVRqRB06
        hS0Wu51+KGyKfyKDLY2nN1ohueJRUzdO5Dl4DoAqcA==
X-Google-Smtp-Source: ABdhPJwLR+J1deuSE4lbwc9uqFI0IBoXruOGM8RrrKmV5sjoGjro15nalSQjaegTsH67lJZZKx/KXCJh0o3OQz67w0c=
X-Received: by 2002:a25:3b86:0:b0:64d:7480:5ca7 with SMTP id
 i128-20020a253b86000000b0064d74805ca7mr6477555yba.553.1652996649252; Thu, 19
 May 2022 14:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220516075619.1277152-1-surenb@google.com> <20220519122904.5aef389360ee2cba42d7b4ca@linux-foundation.org>
 <20220519203332.qsxuzxt2mufcbv3e@revolver>
In-Reply-To: <20220519203332.qsxuzxt2mufcbv3e@revolver>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 19 May 2022 14:43:58 -0700
Message-ID: <CAJuCfpF4XjBmNGBe57aP0MYQguR4qHqeP=jeG87RcrAV4ODZYg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: drop oom code from exit_mmap
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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

On Thu, May 19, 2022 at 1:33 PM Liam Howlett <liam.howlett@oracle.com> wrote:
>
> * Andrew Morton <akpm@linux-foundation.org> [220519 15:29]:
> > On Mon, 16 May 2022 00:56:18 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
> >
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
> >
> > Liam, this mucks "mm: start tracking VMAs with maple tree" somewhat.
> >
> > > --- a/include/linux/oom.h
> > > +++ b/include/linux/oom.h
> > > @@ -106,8 +106,6 @@ static inline vm_fault_t check_stable_address_space(struct mm_struct *mm)
> > >     return 0;
> > >  }
> > >
> > > -bool __oom_reap_task_mm(struct mm_struct *mm);
> > > -
> > >  long oom_badness(struct task_struct *p,
> > >             unsigned long totalpages);
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 313b57d55a63..ded42150e706 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -3105,30 +3105,13 @@ void exit_mmap(struct mm_struct *mm)
> > >     /* mm's last user has gone, and its about to be pulled down */
> > >     mmu_notifier_release(mm);
> > >
> > > -   if (unlikely(mm_is_oom_victim(mm))) {
> > > -           /*
> > > -            * Manually reap the mm to free as much memory as possible.
> > > -            * Then, as the oom reaper does, set MMF_OOM_SKIP to disregard
> > > -            * this mm from further consideration.  Taking mm->mmap_lock for
> > > -            * write after setting MMF_OOM_SKIP will guarantee that the oom
> > > -            * reaper will not run on this mm again after mmap_lock is
> > > -            * dropped.
> > > -            *
> > > -            * Nothing can be holding mm->mmap_lock here and the above call
> > > -            * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
> > > -            * __oom_reap_task_mm() will not block.
> > > -            */
> > > -           (void)__oom_reap_task_mm(mm);
> > > -           set_bit(MMF_OOM_SKIP, &mm->flags);
> > > -   }
> > > -
> > > -   mmap_write_lock(mm);
> > > +   mmap_read_lock(mm);
> > >     arch_exit_mmap(mm);
> > >
> > >     vma = mm->mmap;
> > >     if (!vma) {
> > >             /* Can happen if dup_mmap() received an OOM */
> > > -           mmap_write_unlock(mm);
> > > +           mmap_read_unlock(mm);
> > >             return;
> > >     }
> > >
> > > @@ -3138,6 +3121,16 @@ void exit_mmap(struct mm_struct *mm)
> > >     /* update_hiwater_rss(mm) here? but nobody should be looking */
> > >     /* Use -1 here to ensure all VMAs in the mm are unmapped */
> > >     unmap_vmas(&tlb, vma, 0, -1);
> > > +   mmap_read_unlock(mm);
> > > +
> > > +   /*
> > > +    * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
> > > +    * because the memory has been already freed. Do not bother checking
> > > +    * mm_is_oom_victim because setting a bit unconditionally is cheaper.
> > > +    */
> > > +   set_bit(MMF_OOM_SKIP, &mm->flags);
> > > +
> > > +   mmap_write_lock(mm);
> > >     free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
> > >     tlb_finish_mmu(&tlb);
> > >
> >
> > I ended up with the below rework of "mm: start tracking VMAs with maple
> > tree".  Please triple check?
>
> One small fix in the first one.  Suren found a race with the oom or
> process_mrelease that needed the linked list to be removed here.  Please
> correct me if I am mistaken, Suren?
>
> >
> > void exit_mmap(struct mm_struct *mm)
> > {
> >       struct mmu_gather tlb;
> >       struct vm_area_struct *vma;
> >       unsigned long nr_accounted = 0;
> >
> >       /* mm's last user has gone, and its about to be pulled down */
> >       mmu_notifier_release(mm);
> >
> >       mmap_write_lock(mm);
> >       arch_exit_mmap(mm);
> >       vma = mm->mmap;
> >       if (!vma) {
> >               /* Can happen if dup_mmap() received an OOM */
> >               mmap_write_unlock(mm);
> >               return;
> >       }
> >
> >       lru_add_drain();
> >       flush_cache_mm(mm);
> >       tlb_gather_mmu_fullmm(&tlb, mm);
> >       /* update_hiwater_rss(mm) here? but nobody should be looking */
> >       /* Use -1 here to ensure all VMAs in the mm are unmapped */
> >       unmap_vmas(&tlb, vma, 0, -1);
> >
> >       /*
> >        * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
> >        * because the memory has been already freed. Do not bother checking
> >        * mm_is_oom_victim because setting a bit unconditionally is cheaper.
> >        */
> >       set_bit(MMF_OOM_SKIP, &mm->flags);
> >
> >       free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
> >       tlb_finish_mmu(&tlb);
> >
> >       /* Walk the list again, actually closing and freeing it. */
> >       while (vma) {
> >               if (vma->vm_flags & VM_ACCOUNT)
> >                       nr_accounted += vma_pages(vma);
> >               vma = remove_vma(vma);
> >               cond_resched();
> >       }
> >
> >       trace_exit_mmap(mm);
> >       __mt_destroy(&mm->mm_mt);
>
> +       mm->mmap = NULL;

That's correct. We need to reset mm->mmap so that the loop in
__oom_reap_task_mm() stops immediately. However with maple trees I
believe that loop is different and with an empty tree there would be
no dereferencing. Liam?

>
> >       mmap_write_unlock(mm);
> >       vm_unacct_memory(nr_accounted);
> > }
> >
> >
> > And "mm: remove the vma linked list" needed further reworking.  I ended
> > up with
> >
> > void exit_mmap(struct mm_struct *mm)
> > {
> >       struct mmu_gather tlb;
> >       struct vm_area_struct *vma;
> >       unsigned long nr_accounted = 0;
> >       MA_STATE(mas, &mm->mm_mt, 0, 0);
> >       int count = 0;
> >
> >       /* mm's last user has gone, and its about to be pulled down */
> >       mmu_notifier_release(mm);
> >
> >       mmap_write_lock(mm);
> >       arch_exit_mmap(mm);
> >       vma = mas_find(&mas, ULONG_MAX);
> >       if (!vma) {
> >               /* Can happen if dup_mmap() received an OOM */
> >               mmap_write_unlock(mm);
> >               return;
> >       }
> >
> >       lru_add_drain();
> >       flush_cache_mm(mm);
> >       tlb_gather_mmu_fullmm(&tlb, mm);
> >       /* update_hiwater_rss(mm) here? but nobody should be looking */
> >       /* Use ULONG_MAX here to ensure all VMAs in the mm are unmapped */
> >       unmap_vmas(&tlb, &mm->mm_mt, vma, 0, ULONG_MAX);
> >
> >       /*
> >        * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
> >        * because the memory has been already freed. Do not bother checking
> >        * mm_is_oom_victim because setting a bit unconditionally is cheaper.
> >        */
> >       set_bit(MMF_OOM_SKIP, &mm->flags);
> >
> >       free_pgtables(&tlb, &mm->mm_mt, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
> >       tlb_finish_mmu(&tlb);
> >
> >       /*
> >        * Walk the list again, actually closing and freeing it, with preemption
> >        * enabled, without holding any MM locks besides the unreachable
> >        * mmap_write_lock.
> >        */
> >       do {
> >               if (vma->vm_flags & VM_ACCOUNT)
> >                       nr_accounted += vma_pages(vma);
> >               remove_vma(vma);
> >               count++;
> >               cond_resched();
> >       } while ((vma = mas_find(&mas, ULONG_MAX)) != NULL);
> >
> >       BUG_ON(count != mm->map_count);
> >
> >       trace_exit_mmap(mm);
> >       __mt_destroy(&mm->mm_mt);
> >       mmap_write_unlock(mm);
> >       vm_unacct_memory(nr_accounted);
> > }
>
> It is worth noting that this drops the mmap_read_lock/unlock before the
> write locking.  I'm not sure why Suren had it in his patches and I've
> responded just now asking about it.  It may be an important aspect of
> what he was planning.

unmap_vmas() does not require a mmap_write_lock and doing in under
read lock protection allows OOM-killer and process_mrelease to run in
parallel with exit_mmap. That was the reason I start with
mmap_read_lock and then switch to mmap_write_lock. If that creates
issues we should switch to mmap_write_lock for the whole duration of
this call.
Thanks,
Suren.

>
> Thanks,
> Liam
>
>
> >
> >
> > The mapletree patches remain hidden from mm.git until, I expect, next week.
> >
> > Thanks.
> >
> >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
