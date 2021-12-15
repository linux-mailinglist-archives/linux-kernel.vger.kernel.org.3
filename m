Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5236475C47
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244187AbhLOPxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:53:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34264 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238061AbhLOPxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639583612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Abx6XVTZxeI1Y9sqCGZVk3LIO7eRn0VFyYMe2HXMnBc=;
        b=ATbc0FhCw5O2AAwaiKHTWe4CtE3VgSUDjgEhflq8S5Jj9gfQaZ8gT+y5RJsyjhqX8cWhdU
        JhF3byd9+i3EpI+ca9GERcN0uxjBUU1HgRuE5nLBE55V0VMVv7hA6NhnlxgBT7nchTl1hy
        OhShFtSjZ2d0IXn38Uc38UazO4bhatM=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-x4gc3YEKNXyfZPP1q87_7w-1; Wed, 15 Dec 2021 10:53:31 -0500
X-MC-Unique: x4gc3YEKNXyfZPP1q87_7w-1
Received: by mail-yb1-f199.google.com with SMTP id p133-20020a255b8b000000b006086e19f89fso25045914ybb.19
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 07:53:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Abx6XVTZxeI1Y9sqCGZVk3LIO7eRn0VFyYMe2HXMnBc=;
        b=KrtZKj8WVMv8a+Y/PbXbhzqcq2jiE/EqT8r7qh0kswR95tLxiuKpEeV+/ALVgNdKSL
         ApGFHM5Hg4XTqcO+mXZSrxWYnt0Xa4JU5QlL1x+q/sWszT9kcOScOdoe+dtDWMy6duEX
         yDbmAxf0OhcRKf0SmieDQQQHgstm5wowxBUjNc3DTEf8wx7xW2eD5LmC2CEGlBKcSHLJ
         f8rJyluoQC3okVyZrMId47YWDb9DRWvMNpxuI07GqSlmztqZhUCL4G9ckJuG1CIXXhyh
         CNFKfoWe3uO9jspaztDRkKW7eDUxhnnbVKmMrikuT1jrC6zUcPAbsyPeIypwQNkqOf5U
         8ewQ==
X-Gm-Message-State: AOAM531M0bAuWL4oY/A/kAbfbCPxO8kt9OiA+2OBGjlO3lNM74gZTgfk
        7Ff0SNqkN67l8eYkkQy5sIOjUFm+7PLXzn7FLUHOLfj1SSrcUEpKP0YMtO7UrMKveqmyg+AyrHE
        1qfWtvWq6ZZmD6Kc3unwJdzarOj4HIcw7OWFeHwLt
X-Received: by 2002:a25:d16:: with SMTP id 22mr7262210ybn.51.1639583611034;
        Wed, 15 Dec 2021 07:53:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxgo9cFMLm8mx2Ky3hk+GNpyqtsSqduxH8gzk/VkQSFZWfkZLjMF1CAQ43GEotn4on8nVyw7ekmdDrUu0xOLiI=
X-Received: by 2002:a25:d16:: with SMTP id 22mr7262175ybn.51.1639583610794;
 Wed, 15 Dec 2021 07:53:30 -0800 (PST)
MIME-Version: 1.0
References: <20211208181714.880312-1-jsavitz@redhat.com> <YboN+O3QuJw1Px+7@fixkernel.com>
In-Reply-To: <YboN+O3QuJw1Px+7@fixkernel.com>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Wed, 15 Dec 2021 10:53:15 -0500
Message-ID: <CAL1p7m5K1c6SELRD=CpMNmEXyDBQc8XvcjraH8xi7xcMS=oBHA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/oom_kill: wake futex waiters before annihilating
 victim shared mutex
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        Nico Pache <npache@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I am afraid we can't call futex_exit_release() under rcu_read_lock()
> because it might sleep.

Ah that's too bad. Is there an equivalent atomic call suitable for this purpose?

>
>  BUG: sleeping function called from invalid context at kernel/locking/mutex.c:577
>  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1509, name: lsbug
>  preempt_count: 1, expected: 0
>  3 locks held by lsbug/1509:
>   #0: ffff00004de99c98 (&mm->mmap_lock){++++}-{3:3}, at: do_page_fault
>   #1: ffff800010fd8308 (oom_lock){+.+.}-{3:3}, at: __alloc_pages_slowpath.constprop.0
>   __alloc_pages_may_oom at /usr/src/linux-next/mm/page_alloc.c:4278
>   (inlined by) __alloc_pages_slowpath at /usr/src/linux-next/mm/page_alloc.c:5058
>   #2: ffff000867b3b0c0 (&p->alloc_lock){+.+.}-{2:2}, at: find_lock_task_mm
>   find_lock_task_mm at /usr/src/linux-next/mm/oom_kill.c:145
>  CPU: 5 PID: 1509 Comm: lsbug Not tainted 5.16.0-rc5-next-20211214+ #172
>  Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
>  Call trace:
>   dump_backtrace
>   show_stack
>   dump_stack_lvl
>   dump_stack
>   __might_resched
>   __might_sleep
>   __mutex_lock
>   mutex_lock_nested
>   futex_cleanup_begin
>   futex_cleanup_begin at /usr/src/linux-next/kernel/futex/core.c:1071
>   futex_exit_release
>   __oom_kill_process
>   oom_kill_process
>   out_of_memory
>   __alloc_pages_slowpath.constprop.0
>   __alloc_pages
>   alloc_pages_vma
>   alloc_zeroed_user_highpage_movable
>   do_anonymous_page
>   __handle_mm_fault
>   handle_mm_fault
>   do_page_fault
>   do_translation_fault
>   do_mem_abort
>   el0_da
>   el0t_64_sync_handler
>   el0t_64_sync
>  =============================
>  [ BUG: Invalid wait context ]
>  5.16.0-rc5-next-20211214+ #172 Tainted: G        W
>  -----------------------------
>  lsbug/1509 is trying to lock:
>  ffff000867b3ba98 (&tsk->futex_exit_mutex){+.+.}-{3:3}, at: futex_cleanup_begin
>  other info that might help us debug this:
>  context-{4:4}
>  3 locks held by lsbug/1509:
>   #0: ffff00004de99c98 (&mm->mmap_lock){++++}-{3:3}, at: do_page_fault
>   #1: ffff800010fd8308 (oom_lock){+.+.}-{3:3}, at: __alloc_pages_slowpath.constprop.0
>   #2: ffff000867b3b0c0 (&p->alloc_lock){+.+.}-{2:2}, at: find_lock_task_mm
>  stack backtrace:
>  CPU: 5 PID: 1509 Comm: lsbug Tainted: G        W         5.16.0-rc5-next-20211214+ #172
>  Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
>  Call trace:
>   dump_backtrace
>   show_stack
>   dump_stack_lvl
>   dump_stack
>   __lock_acquire
>   lock_acquire
>   __mutex_lock
>   mutex_lock_nested
>   futex_cleanup_begin
>   futex_exit_release
>   __oom_kill_process
>   oom_kill_process
>   out_of_memory
>   __alloc_pages_slowpath.constprop.0
>   __alloc_pages
>   alloc_pages_vma
>   alloc_zeroed_user_highpage_movable
>   do_anonymous_page
>   __handle_mm_fault
>   handle_mm_fault
>   do_page_fault
>   do_translation_fault
>   do_mem_abort
>   el0_da
>   el0t_64_sync_handler
>   el0t_64_sync
>
> > ---
> >  mm/oom_kill.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 1ddabefcfb5a..884a5f15fd06 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -44,6 +44,7 @@
> >  #include <linux/kthread.h>
> >  #include <linux/init.h>
> >  #include <linux/mmu_notifier.h>
> > +#include <linux/futex.h>
> >
> >  #include <asm/tlb.h>
> >  #include "internal.h"
> > @@ -885,6 +886,11 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
> >       count_vm_event(OOM_KILL);
> >       memcg_memory_event_mm(mm, MEMCG_OOM_KILL);
> >
> > +     /*
> > +      * We call futex_exit_release() on the victim task to ensure any waiters on any
> > +      * process-shared futexes held by the victim task are woken up.
> > +      */
> > +     futex_exit_release(victim);
> >       /*
> >        * We should send SIGKILL before granting access to memory reserves
> >        * in order to prevent the OOM victim from depleting the memory
> > @@ -930,6 +936,12 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
> >                */
> >               if (unlikely(p->flags & PF_KTHREAD))
> >                       continue;
> > +             /*
> > +              * We call futex_exit_release() on any task p sharing the
> > +              * victim->mm to ensure any waiters on any
> > +              * process-shared futexes held by task p are woken up.
> > +              */
> > +             futex_exit_release(p);
> >               do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_TGID);
> >       }
> >       rcu_read_unlock();
> > --
> > 2.27.0
> >
>

Best,
Joel Savitz

