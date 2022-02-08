Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9C44AD6A5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358966AbiBHL1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbiBHKcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:32:20 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8C7C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 02:32:19 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id z7so13500099ilb.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 02:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IiwkpuM+BfLL6jHkWVkc0DGHd+y4pmtd32Iu8/4ilfc=;
        b=c34Yqufwr+tpl4Ls9NyohNK+tbfd7eD7QWVO23mmKLmOQplMwAiRZH4JxpVLsbcSLD
         ZjrnpBi4zlEiv+2yuO0AA3o37PVhrimSWqty//ByE1PcwJj2DPC0zUyD5tdFa41ApGuc
         ExF6gcgHxTjTmMsSGeiKGvthGPBqELlAP4WlcDDV+QjNMfx7cQTOcXjp52V8OIDZfNPq
         cJwhpKGuPc7RfJ5WpfLj0kHIExXZaSORc54NAO+z2brqOPtn0y+AcCAORXoax4UXOLKu
         zYjZPjGhbHHiVOt6susQrPHsmKiqFCoXEpBgp0D9nD/zaOiKVRTb0eoqrD+VzPrqt0NC
         lr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IiwkpuM+BfLL6jHkWVkc0DGHd+y4pmtd32Iu8/4ilfc=;
        b=5OEDsq2qyYQj8MQKiMA8ZJEq70Pvn8f77zBJVkqCbshsMTfUiZY7OSs4jROz1oP0Hy
         z8rdDFZvOUEGI1QetKbFR57epBt9VJYnUXhZ7miDthgjsskbKxxJsikOIAC/5AF+Eo0n
         4OxvJ16FAVCuzmBl7b38Y0uFhntwbnIF6Jx7NMfOBoQ2mocktoakC4jvyexIAxX/iQ00
         IDrybWCWOlSOfdEB9D3528SemLD2zBmvyJ7wLLAnI++wRcEpJxa2hEdea66hs5PGPDpz
         7knLsTYgLsyOCwz1EYr/ttiSkeudbRfP7dI1DUkbVgbtAyWeTGZnOvMSsg6DjSOR5MmX
         T8rQ==
X-Gm-Message-State: AOAM530fRavba36jzUueuAeLwP5hsH9Op/54jfcEdTWm6y903crxXreL
        bWuO3AgbVNasmwC2kqQuLEf+zjp68w6eMhCuUGaBDg==
X-Google-Smtp-Source: ABdhPJwO7h+SNAUC6DS01GMY8SZPwIRsrITZWvxiKolM4+z3P2mez8dPra7ycisZCpd/a7IFPAVYshy3EHmGWbJP1pg=
X-Received: by 2002:a05:6e02:194b:: with SMTP id x11mr1773801ilu.123.1644316338411;
 Tue, 08 Feb 2022 02:32:18 -0800 (PST)
MIME-Version: 1.0
References: <000000000000ef8cbb05d3bf84cd@google.com> <20211225005253.1962-1-hdanton@sina.com>
 <6396f046-b292-1a73-8339-d32b611d9b7f@redhat.com> <YczTPYx0L7y8TgIE@mit.edu> <20211230125018.2272-1-hdanton@sina.com>
In-Reply-To: <20211230125018.2272-1-hdanton@sina.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 8 Feb 2022 11:32:07 +0100
Message-ID: <CANp29Y4wyREoKO60XjOfh618Udf5h21boF3R_=qYY8tJc0otfg@mail.gmail.com>
Subject: Re: [syzbot] INFO: rcu detected stall in ext4_file_write_iter (4)
To:     Hillf Danton <hdanton@sina.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Waiman Long <longman@redhat.com>,
        syzbot <syzbot+03464269af631f4a4bdf@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs@googlegroups.com
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

Closing the bug. Syzkaller now is much more careful with sched_setattr
and perf_event_open, so, hopefully, we'll see fewer such false
positive reports in the future.

#syz invalid

On Thu, Dec 30, 2021 at 1:50 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Wed, 29 Dec 2021 16:29:33 -0500 Theodore Ts'o wrote:
> > On Mon, Dec 27, 2021 at 10:14:23PM -0500, Waiman Long wrote:
> > >
> > > The test was running on a CONFIG_PREEMPT kernel. So if the syzkaller kthread
> > > is running at a higher priority than the rcu_preempt kthread, it is possible
> > > for the rcu_preempt kthread to be starved of cpu time. The rwsem optimistic
> > > spinning code will relinquish the cpu if there is a higher priority thread
> > > running. Since rcu_preempt kthread did not seem to be able to get the cpu, I
> > > suspect that it is probably caused by the syzkaller thread having a higher
> > > priority.
> >
> > It's even worse than that.  The Syzkaller reproducer is calling
> > sched_setattr():
> >
> >   *(uint32_t*)0x20000080 = 0x38;    // sched_attr.sched_size
> >   *(uint32_t*)0x20000084 = 1;       // sched_attr.sched_policy == SCHED_FIFO
> >   *(uint64_t*)0x20000088 = 0;       // sched_attr.sched_flags
> >   *(uint32_t*)0x20000090 = 0;       // sched_attr.sched_nice
> >   *(uint32_t*)0x20000094 = 1;       // sched_attr.sched_priority
> >   *(uint64_t*)0x20000098 = 0;       // ...
> >   *(uint64_t*)0x200000a0 = 0;
> >   *(uint64_t*)0x200000a8 = 0;
> >   *(uint32_t*)0x200000b0 = 0;
> >   *(uint32_t*)0x200000b4 = 0;
> >   syscall(__NR_sched_setattr, 0, 0x20000080ul, 0ul);
> >
> > So one or more of the syzkaller threads is SCHED_FIFO, and SCHED_FIFO
> > threads will *never* relinquish the CPU in favor of SCHED_OTHER
> > threads (which in practice will include all kernel threads unless
> > special measures are taken by someone who knows what they are doing)
> > so long as it they are runable.
> >
> > See the discussion at:
> >
> >     https://lore.kernel.org/all/Yb5RMWRsJl5TMk8H@casper.infradead.org/
> >
> > I recommend that kernel developers simply ignore any syzkaller report
> > that relates to tasks being hung or rcu detected and where the
> > reproducer is trying to set a real-time priority (e.g., sched_policy
> > of SCHED_FIFO or SCHED_RR), since the number of ways that
> > sched_setattr can be used as a foot-gun are near infinite....
> >
> > Syzkaller reports that include sched_setattr are great for inflating
> > the OMG!  There are tons of unhandled syzkaller reports, "companies
> > need to fund more engineering headcount to fix syzkaller bugs" slide
> > decks.  But IMHO, they are not good for much else.
> >
> >                                           - Ted
> >
>
> On the other hand, this report suggests IMHO the need for setting the
> deadline, a couple of ticks by default, for spinners, to cut the chance
> for FIFO tasks to make trouble in scenarios like the report.
>
> Mutex needs the same mechanism if it makes sense.
>
> Thanks
>                 Hillf
>
>
> +++ x/kernel/locking/rwsem.c
> @@ -716,6 +716,7 @@ rwsem_spin_on_owner(struct rw_semaphore
>         struct task_struct *new, *owner;
>         unsigned long flags, new_flags;
>         enum owner_state state;
> +       unsigned long deadline;
>
>         lockdep_assert_preemption_disabled();
>
> @@ -724,6 +725,10 @@ rwsem_spin_on_owner(struct rw_semaphore
>         if (state != OWNER_WRITER)
>                 return state;
>
> +       /* avoid spinning long enough to make rcu stall
> +        * particularly in case of FIFO spinner
> +        */
> +       deadline = jiffies + 2;
>         for (;;) {
>                 /*
>                  * When a waiting writer set the handoff flag, it may spin
> @@ -747,7 +752,8 @@ rwsem_spin_on_owner(struct rw_semaphore
>                  */
>                 barrier();
>
> -               if (need_resched() || !owner_on_cpu(owner)) {
> +               if (need_resched() || !owner_on_cpu(owner) ||
> +                   time_after(jiffies, deadline)) {
>                         state = OWNER_NONSPINNABLE;
>                         break;
>                 }
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20211230125018.2272-1-hdanton%40sina.com.
