Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C13583417
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 22:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiG0Uap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 16:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiG0Uan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 16:30:43 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13074186D6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 13:30:42 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-31e7ca45091so187501267b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 13:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qC/2GpX8G1YxmI7AUAGx9cdmS+R/MtU1fjbm5R4/Jec=;
        b=ErpR4J7KGPLRGFTeh7WSrlbaCVKxU6h+F40DUq9lM3MEtkVqAi/6ULVCfZOoCeYHJO
         vFzug27yaISebUNhmAWpEmoqfFsTDdhHbkgEwEeCSh1SiiVRdnbmZLRL0UO0DW/NyAWV
         vn6ALx1BuxYECq/isTZMp18Iq/EPVLT7Cca/B8e9ZHJXj/xId1+VifkVZEYY70xbFWfq
         cgsjZXbsI/YlSt5s97I9Uq3hZW/b8FYFVhiPeo+UuUdOKrl/K6zUCYUzIu3uwwiAlpzB
         IpNHits3Q79nGlf+4+GfygpjRvfdYqca7/O5oH1O99iW7dhRaSJW3L3CQNisGH8eGY71
         +lFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qC/2GpX8G1YxmI7AUAGx9cdmS+R/MtU1fjbm5R4/Jec=;
        b=oHH9g68SVCyHEvqAA9fkRMnmCUbHdkU5/JRlQk9GlRP4gxCpqKy+Uh1sUpvEzH4VlF
         d6CoikuqZ8aSwI4JN09Pfp5lBsd4jCN+dEdc2xXrnWoKi0hefYB4EUgGcQKSfX/D01O8
         TEWsMfgzPif0cJ7WpVSon/GyuqaMZK0fMXdBT65Kbim6+7WsxXzfltHv9KNd7KoW7cyl
         RlRNmZCnFm9tZi+9tBeCsi3XoWQUaDuqXYkidxNwx8Rfopv6r65b2ZUSZBCIdiVIwBom
         GWKavpx3w93BgEmGxKLeLzc7A4mUUMTXVateGzJgq8lcAV8VDlm0cbTPOUXGXwfzxJWM
         X8Gw==
X-Gm-Message-State: AJIora/0CGNipJ51RMonnJpBTrcznUVfsvw/Qd9ZdE6IeM0VD0VJxEFf
        kto8JQpC0eQODkyQm15tHBZHD2w0QjE2fKqm3GbrVQ==
X-Google-Smtp-Source: AGRyM1tF9tqlr/OBQG5UXGRIEwwgef5cEbQqoI+epbDEySB8RGnwa70IMHc3cAhVXNq9/NOFtZFrS4i640PWV9ZQGeI=
X-Received: by 2002:a81:a247:0:b0:31d:72da:e931 with SMTP id
 z7-20020a81a247000000b0031d72dae931mr20987026ywg.469.1658953841024; Wed, 27
 Jul 2022 13:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220128131006.67712-1-michel@lespinasse.org> <20220128131006.67712-24-michel@lespinasse.org>
 <20220727073420.GA8985@hu-pkondeti-hyd.qualcomm.com>
In-Reply-To: <20220727073420.GA8985@hu-pkondeti-hyd.qualcomm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 27 Jul 2022 13:30:29 -0700
Message-ID: <CAJuCfpG0_xwGhTbzWRRwcBKO263TgrVm0T1gJ+PdzcL-EzcHpA@mail.gmail.com>
Subject: Re: [PATCH v2 23/35] mm: add mmu_notifier_lock
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 12:34 AM Pavan Kondeti
<quic_pkondeti@quicinc.com> wrote:
>
> On Fri, Jan 28, 2022 at 05:09:54AM -0800, Michel Lespinasse wrote:
> > Introduce mmu_notifier_lock as a per-mm percpu_rw_semaphore,
> > as well as the code to initialize and destroy it together with the mm.
> >
> > This lock will be used to prevent races between mmu_notifier_register()
> > and speculative fault handlers that need to fire MMU notifications
> > without holding any of the mmap or rmap locks.
> >
> > Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
> > ---
> >  include/linux/mm_types.h     |  6 +++++-
> >  include/linux/mmu_notifier.h | 27 +++++++++++++++++++++++++--
> >  kernel/fork.c                |  3 ++-
> >  3 files changed, 32 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 305f05d2a4bc..f77e2dec038d 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -462,6 +462,7 @@ struct vm_area_struct {
> >  } __randomize_layout;
> >
> >  struct kioctx_table;
> > +struct percpu_rw_semaphore;
> >  struct mm_struct {
> >       struct {
> >               struct vm_area_struct *mmap;            /* list of VMAs */
> > @@ -608,7 +609,10 @@ struct mm_struct {
> >               struct file __rcu *exe_file;
> >  #ifdef CONFIG_MMU_NOTIFIER
> >               struct mmu_notifier_subscriptions *notifier_subscriptions;
> > -#endif
> > +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
> > +             struct percpu_rw_semaphore *mmu_notifier_lock;
> > +#endif       /* CONFIG_SPECULATIVE_PAGE_FAULT */
> > +#endif       /* CONFIG_MMU_NOTIFIER */
> >  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
> >               pgtable_t pmd_huge_pte; /* protected by page_table_lock */
> >  #endif
> > diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> > index 45fc2c81e370..ace76fe91c0c 100644
> > --- a/include/linux/mmu_notifier.h
> > +++ b/include/linux/mmu_notifier.h
> > @@ -6,6 +6,8 @@
> >  #include <linux/spinlock.h>
> >  #include <linux/mm_types.h>
> >  #include <linux/mmap_lock.h>
> > +#include <linux/percpu-rwsem.h>
> > +#include <linux/slab.h>
> >  #include <linux/srcu.h>
> >  #include <linux/interval_tree.h>
> >
> > @@ -499,15 +501,35 @@ static inline void mmu_notifier_invalidate_range(struct mm_struct *mm,
> >               __mmu_notifier_invalidate_range(mm, start, end);
> >  }
> >
> > -static inline void mmu_notifier_subscriptions_init(struct mm_struct *mm)
> > +static inline bool mmu_notifier_subscriptions_init(struct mm_struct *mm)
> >  {
> > +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
> > +     mm->mmu_notifier_lock = kzalloc(sizeof(struct percpu_rw_semaphore), GFP_KERNEL);
> > +     if (!mm->mmu_notifier_lock)
> > +             return false;
> > +     if (percpu_init_rwsem(mm->mmu_notifier_lock)) {
> > +             kfree(mm->mmu_notifier_lock);
> > +             return false;
> > +     }
> > +#endif
> > +
> >       mm->notifier_subscriptions = NULL;
> > +     return true;
> >  }
> >
> >  static inline void mmu_notifier_subscriptions_destroy(struct mm_struct *mm)
> >  {
> >       if (mm_has_notifiers(mm))
> >               __mmu_notifier_subscriptions_destroy(mm);
> > +
> > +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
> > +     if (!in_atomic()) {
> > +             percpu_free_rwsem(mm->mmu_notifier_lock);
> > +             kfree(mm->mmu_notifier_lock);
> > +     } else {
> > +             percpu_rwsem_async_destroy(mm->mmu_notifier_lock);
> > +     }
> > +#endif
> >  }
> >
>
> We have received a bug report from our customer running Android GKI kernel
> android-13-5.15 branch where this series is included. As the callstack [1]
> indicates, the non-atomic test it self is not sufficient to free the percpu
> rwsem.
>
> The scenario deduced from the callstack:
>
> - context switch on CPU#0 from 'A' to idle. idle thread took A's mm
>
> - 'A' later ran on another CPU and exited. A's mm has still reference.
>
> - Now CPU#0 is being hotplugged out. As part of this, idle thread's
> mm is switched (in idle_task_exit()) but its active_mm freeing is
> deferred to finish_cpu() which gets called later from the control processor
> (the thread which initiated the CPU hotplug). Please see the reasoning
> on why mmdrop() is not called in idle_task_exit() at
> commit bf2c59fce4074('sched/core: Fix illegal RCU from offline CPUs')
>
> - Now when finish_cpu() tries call percpu_free_rwsem() directly since we are
> not in atomic path but hotplug path where cpus_write_lock() called is causing
> the deadlock.
>
> I am not sure if there is a clean way other than freeing the per-cpu
> rwsemaphore asynchronously all the time.

Thanks for reporting this issue, Pavan. I think your suggestion of
doing unconditional async destruction of mmu_notifier_lock would be
fine here. percpu_rwsem_async_destroy has a bit of an overhead to
schedule that work but I don't think the exit path is too performance
critical to suffer from that. Michel, WDYT?

>
> [1]
>
> -001|context_switch(inline)
> -001|__schedule()
> -002|__preempt_count_sub(inline)
> -002|schedule()
> -003|_raw_spin_unlock_irq(inline)
> -003|spin_unlock_irq(inline)
> -003|percpu_rwsem_wait()
> -004|__preempt_count_add(inline)
> -004|__percpu_down_read()
> -005|percpu_down_read(inline)
> -005|cpus_read_lock() // trying to get cpu_hotplug_lock again
> -006|rcu_barrier()
> -007|rcu_sync_dtor()
> -008|mmu_notifier_subscriptions_destroy(inline)
> -008|__mmdrop()
> -009|mmdrop(inline)
> -009|finish_cpu()
> -010|cpuhp_invoke_callback()
> -011|cpuhp_invoke_callback_range(inline)
> -011|cpuhp_down_callbacks()
> -012|_cpu_down() // acquired cpu_hotplug_lock (write lock)
>
> Thanks,
> Pavan
>
