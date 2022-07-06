Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363365684E5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbiGFKM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbiGFKMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:12:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD74FB8D;
        Wed,  6 Jul 2022 03:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tkl3lxTOKWGbOCuxxKNckxHNjYRI3zGLuGc8imHNxDs=; b=WpgGH4+Y6U9gQSSnMVR6OLMxva
        3xYxeAZ7USH+mmbkdac+gWqkqSUncCao79OXiiUot5IPHXuNd6BKu4KcdJ/3wd9E6vbdtwdlfX++8
        YHg9SPa4d3D+hoJ+xHEd64U2BB0PxnnwhjCX34YKvpd3mB9eaqJ+9sCf1Ma6Y4Sc+A5HLQFse3wc3
        7p9dt+e0Yzacjyq/2QRyinJn3DEvx+LTPjMD8J3/m/+8JP5Q5o8reLw6djHCmeIC4Lr1NoUT74Cpg
        hLfvPld/nyGauGdSHTmpv4A/geUNh2jHXRL3BD0xt9eK7uievOocsG0NSTJd7nMGZkXKKLQVVrNY/
        fCxnd6CA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9207-000QRU-BY; Wed, 06 Jul 2022 10:11:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6964C3001AE;
        Wed,  6 Jul 2022 12:11:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 43F7A20207235; Wed,  6 Jul 2022 12:11:15 +0200 (CEST)
Date:   Wed, 6 Jul 2022 12:11:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org
Subject: Re: [PATCH v4 12/12] sched,signal,ptrace: Rework TASK_TRACED,
 TASK_STOPPED state
Message-ID: <YsVfw3dy7smrpEbn@hirez.programming.kicks-ass.net>
References: <YrHA5UkJLornOdCz@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <877d5ajesi.fsf@email.froward.int.ebiederm.org>
 <YrHgo8GKFPWwoBoJ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <20220628191541.34a073fc@gandalf.local.home>
 <yt9d5ykbekn3.fsf@linux.ibm.com>
 <yt9dpmijcvu6.fsf@linux.ibm.com>
 <YsSQRmCZSIQ1ewzo@worktop.programming.kicks-ass.net>
 <yt9dsfneaczk.fsf@linux.ibm.com>
 <YsVO1NU3bXGg9YJ3@worktop.programming.kicks-ass.net>
 <yt9da69ma8wm.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9da69ma8wm.fsf@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 11:27:05AM +0200, Sven Schnelle wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > On Wed, Jul 06, 2022 at 09:58:55AM +0200, Sven Schnelle wrote:
> >
> >> >> [   86.218551] kill_chi-343805    6d.... 79990141us : ptrace_stop: JOBCTL_TRACED already set, state=0 <------ valid combination of flags?
> >> >
> >> > Yeah, that's not supposed to be so. JOBCTL_TRACED is supposed to follow
> >> > __TASK_TRACED for now. Set when __TASK_TRACED, cleared when
> >> > TASK_RUNNING.
> >> >
> >> > Specifically {ptrace_,}signal_wake_up() in signal.h clear JOBCTL_TRACED
> >> > when they would wake a __TASK_TRACED task.
> >> 
> >> try_to_wake_up() clears TASK_TRACED in this case because a signal
> >> (SIGKILL) has to be delivered. As a test I put the following change
> >> on top, and it "fixes" the problem:
> >> 
> >> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >> index da0bf6fe9ecd..f2e0f5e70e77 100644
> >> --- a/kernel/sched/core.c
> >> +++ b/kernel/sched/core.c
> >> @@ -4141,6 +4149,9 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> >>          * TASK_WAKING such that we can unlock p->pi_lock before doing the
> >>          * enqueue, such as ttwu_queue_wakelist().
> >>          */
> >> +       if (p->__state & TASK_TRACED)
> >> +               trace_printk("clearing TASK_TRACED 2\n");
> >> +       p->jobctl &= ~JOBCTL_TRACED;
> >>         WRITE_ONCE(p->__state, TASK_WAKING);
> >> 
> >>         /*
> >> 
> >> There are several places where the state is changed from TASK_TRACED to
> >> something else without clearing JOBCTL_TRACED.
> >
> > I'm having difficulty spotting them; I find:
> >
> > TASK_WAKEKILL: signal_wake_up()
> > __TASK_TRACED: ptrace_signal_wake_up(), ptrace_unfreeze_traced(), ptrace_resume()
> >
> > And all those sites dutifully clear JOBCTL_TRACED.
> >
> > I'd be most interested in the calstack for the 'clearing TASK_TRACED 2'
> > events to see where we miss a spot.
> 
> The calltrace is:
> [    9.863613] Call Trace:
> [    9.863616]  [<00000000d3105f0e>] try_to_wake_up+0xae/0x620
> [    9.863620] ([<00000000d3106164>] try_to_wake_up+0x304/0x620)
> [    9.863623]  [<00000000d30d1e46>] ptrace_unfreeze_traced+0x9e/0xa8
> [    9.863629]  [<00000000d30d2ef0>] __s390x_sys_ptrace+0xc0/0x160
> [    9.863633]  [<00000000d3c5d8f4>] __do_syscall+0x1d4/0x200
> [    9.863678]  [<00000000d3c6c332>] system_call+0x82/0xb0
> [    9.863685] Last Breaking-Event-Address:
> [    9.863686]  [<00000000d3106176>] try_to_wake_up+0x316/0x620
> [    9.863688] ---[ end trace 0000000000000000 ]---
> 
> ptrace_unfreeze_traced() is:
> 
> static void ptrace_unfreeze_traced(struct task_struct *task)
> {
>         unsigned long flags;
> 
>         /*
>          * The child may be awake and may have cleared
>          * JOBCTL_PTRACE_FROZEN (see ptrace_resume).  The child will
>          * not set JOBCTL_PTRACE_FROZEN or enter __TASK_TRACED anew.
>          */
>         if (lock_task_sighand(task, &flags)) {
>                 task->jobctl &= ~JOBCTL_PTRACE_FROZEN;
>                 if (__fatal_signal_pending(task)) {
>                         task->jobctl &= ~TASK_TRACED;
> 
> Looking at this, shouldn't the line above read task->jobctl &= ~JOBCTL_TRACED?

YES! Absolutely.

>                         wake_up_state(task, __TASK_TRACED);
>                 }
>                 unlock_task_sighand(task, &flags);
>         }
> }
