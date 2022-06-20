Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E096A552400
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 20:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243057AbiFTSgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 14:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245637AbiFTSgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 14:36:16 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B9B1EEE5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 11:36:15 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z11so10135846edp.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 11:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EeAsgQ3GIlVGEAepa+i4Hi0kQwfLv0Ae3M0nvzjNJCs=;
        b=ecpFFp2LIzJfzuugw4iO/tyegmruvVz+Rybu8I1gqsBUw1j1bYbM8wzgueZwvLv0FC
         wo4PV48Dh39jqnEKEUwWboCKRo7ay4j2f6rR7rSfQO3Ltq/7/mebeDc3GAqZE+08BWwH
         nhGGjRGKrw2132NJ3MNaACUHesjEHrntojFTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EeAsgQ3GIlVGEAepa+i4Hi0kQwfLv0Ae3M0nvzjNJCs=;
        b=CBdUcQqxPwmlY7himnzUqgu5enGbYZO1ks4SDPI/iUE5Sbn/ey+sttEvn+J5pEj8Si
         keRyv0LvCkACLe/vNCGHoRQ3QHbZ0R5rCq5JrNL9B9SNjmssSAiBE23x4lBU7gdiJSQC
         hFItf1E87/zYuMJ//VETo5bVGq8AMeDeYuy+RlcV8ENJGmpbMiTG3RPvhx/igsBNrFvU
         Ttm3T1ZYIKW1ivz3BNtbf8g6/b7yV6l30vD/z6FIBovUBnadrorSCLqvWWpXq4DeiYz8
         egCvUydQnSW9+rurNZkP0apB/PZK5jXWreh7jQWV5ry4qS1gjsNV443Ihs1+UGJejy5O
         uyGA==
X-Gm-Message-State: AJIora+MsAOoTi8ChiJIHfcZgO0io2Sp4p8+LBlsQ1TDk4Mwv5v5S8AY
        /WY5eTlK7xa6FcEaNAO7rVUmzv3ivhP++qqcI7W2aA==
X-Google-Smtp-Source: AGRyM1sUYqd+i5DpTeNPJoYhjbMJKSY4AkfYsxB50t1Hz9JRh+SiYXtd/jMGRyYqdjRXUlXqelDqD8jGQfFeYXniWYk=
X-Received: by 2002:a05:6402:2548:b0:42d:dd95:5bfe with SMTP id
 l8-20020a056402254800b0042ddd955bfemr31122072edb.285.1655750173442; Mon, 20
 Jun 2022 11:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220618182515.95831-1-minhquangbui99@gmail.com>
 <258546133.12151.1655739550814.JavaMail.zimbra@efficios.com>
 <CAJqdLroJ6eTD02dAi8Nnb63Sog5x9Pwt9CDwXaUeBQe1Sn2EBg@mail.gmail.com> <648712158.13199.1655748645141.JavaMail.zimbra@efficios.com>
In-Reply-To: <648712158.13199.1655748645141.JavaMail.zimbra@efficios.com>
From:   Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date:   Mon, 20 Jun 2022 21:36:02 +0300
Message-ID: <CAJqdLrpKLO8Wh_AytFS9XPMkaq22cOJ+fPi06kyJY55yQUpScg@mail.gmail.com>
Subject: Re: [PATCH] rseq: x86: Fix rseq_cs get cleared when returning from
 signal handler
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Paul Turner <pjt@google.com>,
        Simon Marchi <simon.marchi@efficios.com>,
        Peter Oskolkov <posk@posk.io>,
        Chris Kennelly <ckennelly@google.com>,
        Kevin Malachowski <chowski@google.com>,
        Pedro Alves <palves@redhat.com>,
        Bui Quang Minh <minhquangbui99@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mathieu,

On Mon, Jun 20, 2022 at 9:10 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Jun 20, 2022, at 11:46 AM, Alexander Mikhalitsyn alexander@mihalicyn.com wrote:
>
> > Hi Mathieu!
> >
> > It comes from CRIU ;)
> >
> > We have seen periodic failures of our ZDTM test (rseq02):
> > zdtm: add rseq02 transition test with NO_RESTART CS flag
> > https://github.com/checkpoint-restore/criu/commit/db9ec13616625f98db95b00438a370f8a660bfee
> > zdtm: temporary disable rseq02 test
> > https://github.com/checkpoint-restore/criu/commit/ead227994b4918422496e06d3f3802188c091a7a
> >
> > Bui Quang Minh wanted to investigate this problem and come up with
> > this kernel patch.
>
> OK, so from the CRIU point of view, the only use of those flags is to set them
> again when they are observed in a process which is the target of a checkpoint-restore,
> right ?

Definitely.

>
> I'm just tying to figure out whether there are valid real-world use-cases for this flag.

Yep, as we discussed with you privately some time ago, I've just tried
to implement rseq support as fully as possible from the CRIU side.
Btw, thanks to you for your help with that!

So, we, CRIUers, have no requirements about these flags. If you and
kernel community decide to deprecate them - it's okay.

>
> Initially, for RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT (not SIGNAL) rseq_cs flag, one use-case I
> had in mind was for a critical section for which it's only important that it stays on the same
> CPU, but can be preempted without abort. But I think the importance of not being restarted on
> preemption is limited, given that it is an optimization for a rare situation.
>
> For all 3 of no-restart on preempt/migrate/signal rseq flags, another use-case I had envisioned
> was to allow debuggers to single-step through rseq critical sections by taking control of
> the scheduling of all threads belonging to a process. I wonder how realistic it is to
> expect debuggers to implement this kind of feature, especially given that rseq could
> be used with data structures shared across processes over shared memory. AFAIK none of the
> debuggers implement this today, and I don't expect debuggers nor DynamoRIO (https://dynamorio.org/page_rseq.html)
> to implement this.
>
> The alternative way that debuggers can handle rseq critical sections is to skip over them
> using the entry/exit points defined within rseq entry/exit points array sections, in a fashion
> not completely unlike the handling of ll/sc "atomic" code by architecture-specific heuristics.
> It does not allow single-stepping through the rseq c.s. assembly, but it does prevent retrying
> forever when trying to single-step through an rseq c.s.
>
> I'm adding a few people concerned by those topics in CC. Feedback is very welcome.

Great!

+CC Andrei Vagin, Pavel Tikhomirov

>
> The key question here is: who would be sad to see the following flags be deprecated ?
>
> RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
> RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT
> RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL
>
> Thanks,
>
> Mathieu

Regards,
Alex

>
> >
> > Regards,
> > Alex
> >
> > On Mon, Jun 20, 2022 at 6:39 PM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >>
> >> ----- On Jun 18, 2022, at 2:25 PM, Bui Quang Minh minhquangbui99@gmail.com
> >> wrote:
> >>
> >> > rseq.rseq_cs is not expected to be cleared when we are still in critical
> >> > section. When using rseq with RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL, if the
> >> > signal is delivered, we don't restart to the abort ip but go to signal
> >> > handler then return and continue the critical section execution. While in
> >> > signal handler, if a preemption, migration or another signal is delivered,
> >> > we will fall into rseq_ip_fixup again. At that moment, the IP is in signal
> >> > handler not in critical section so the rseq.rseq_cs is cleared. Later, when
> >> > we return back to critical section from signal handlers, we get the
> >> > rseq.rseq_cs incorrectly cleared.
> >> >
> >> > Another scenario is when a preemption or migration happens, then a signal
> >> > is delivered. When preparing to return to user mode, in
> >> > exit_to_user_mode_loop, we first handle the signal and set return IP to
> >> > signal handler. After that, rseq_handle_notify_resume is called to handle
> >> > the preemption/migration, sees the IP is the address of signal handler not
> >> > in critical section and clear rseq.rseq_cs.
> >> >
> >> > To handle this case, a RSEQ_CS_FLAG_IN_SIGNAL_HANDLER is added. This flag
> >> > is set in rseq.flags (it is easier to read and update rseq.flags than
> >> > rseq.rseq_cs.flags) by the kernel when rseq does not restart on signal.
> >> > When this flag is set, we don't clear rseq.rseq_cs when the IP is outside
> >> > of critical section. The flag is unset in sigreturn path when the last
> >> > signal handler returns back to the critical section.
> >>
> >> Hi,
> >>
> >> You raise valid points.
> >>
> >> May I first ask what is your use-case for RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL ?
> >>
> >> Considering the added per-arch complexity, I think we should consider whether
> >> it's worthwhile to keep supporting this flag, and whether there are actual users
> >> of it out there, or if we should handle this by deprecating this flag.
> >>
> >> Thanks,
> >>
> >> Mathieu
> >>
> >> >
> >> > Reviewed-by: Alexander Mikhalitsyn <alexander@mihalicyn.com>
> >> > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> >> > ---
> >> > arch/x86/kernel/signal.c  |  7 ++++
> >> > include/linux/sched.h     |  5 +++
> >> > include/uapi/linux/rseq.h |  8 +++-
> >> > kernel/rseq.c             | 80 ++++++++++++++++++++++++++++++++++++---
> >> > 4 files changed, 94 insertions(+), 6 deletions(-)
> >> >
> >> > diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> >> > index 9c7265b524c7..7aadf69d6849 100644
> >> > --- a/arch/x86/kernel/signal.c
> >> > +++ b/arch/x86/kernel/signal.c
> >> > @@ -646,6 +646,10 @@ SYSCALL_DEFINE0(sigreturn)
> >> >        */
> >> >       if (!restore_sigcontext(regs, &frame->sc, 0))
> >> >               goto badframe;
> >> > +
> >> > +     if (rseq_sigreturn(regs))
> >> > +             goto badframe;
> >> > +
> >> >       return regs->ax;
> >> >
> >> > badframe:
> >> > @@ -678,6 +682,9 @@ SYSCALL_DEFINE0(rt_sigreturn)
> >> >       if (restore_altstack(&frame->uc.uc_stack))
> >> >               goto badframe;
> >> >
> >> > +     if (rseq_sigreturn(regs))
> >> > +             goto badframe;
> >> > +
> >> >       return regs->ax;
> >> >
> >> > badframe:
> >> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> >> > index c46f3a63b758..656b03232d0a 100644
> >> > --- a/include/linux/sched.h
> >> > +++ b/include/linux/sched.h
> >> > @@ -2340,6 +2340,8 @@ static inline void rseq_execve(struct task_struct *t)
> >> >       t->rseq_event_mask = 0;
> >> > }
> >> >
> >> > +int rseq_sigreturn(struct pt_regs *regs);
> >> > +
> >> > #else
> >> >
> >> > static inline void rseq_set_notify_resume(struct task_struct *t)
> >> > @@ -2365,6 +2367,9 @@ static inline void rseq_fork(struct task_struct *t,
> >> > unsigned long clone_flags)
> >> > static inline void rseq_execve(struct task_struct *t)
> >> > {
> >> > }
> >> > +static inline int rseq_sigreturn(struct pt_regs *regs)
> >> > +{
> >> > +}
> >> >
> >> > #endif
> >> >
> >> > diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
> >> > index 77ee207623a9..f946af8e21e6 100644
> >> > --- a/include/uapi/linux/rseq.h
> >> > +++ b/include/uapi/linux/rseq.h
> >> > @@ -26,6 +26,7 @@ enum rseq_cs_flags_bit {
> >> >       RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT  = 0,
> >> >       RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT   = 1,
> >> >       RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT  = 2,
> >> > +     RSEQ_CS_FLAG_IN_SIGNAL_HANDLER_BIT      = 3,
> >> > };
> >> >
> >> > enum rseq_cs_flags {
> >> > @@ -35,6 +36,8 @@ enum rseq_cs_flags {
> >> >               (1U << RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT),
> >> >       RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE      =
> >> >               (1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
> >> > +     RSEQ_CS_FLAG_IN_SIGNAL_HANDLER          =
> >> > +             (1U << RSEQ_CS_FLAG_IN_SIGNAL_HANDLER_BIT),
> >> > };
> >> >
> >> > /*
> >> > @@ -115,7 +118,7 @@ struct rseq {
> >> >        * Restartable sequences flags field.
> >> >        *
> >> >        * This field should only be updated by the thread which
> >> > -      * registered this data structure. Read by the kernel.
> >> > +      * registered this data structure. Read and set by the kernel.
> >> >        * Mainly used for single-stepping through rseq critical sections
> >> >        * with debuggers.
> >> >        *
> >> > @@ -128,6 +131,9 @@ struct rseq {
> >> >        * - RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
> >> >        *     Inhibit instruction sequence block restart on migration for
> >> >        *     this thread.
> >> > +      * - RSEQ_CS_FLAG_IN_SIGNAL_HANDLER
> >> > +      *     Mark that this thread is in critical section but currently in
> >> > +      *     signal handlers, so don't clear the rseq_cs field.
> >> >        */
> >> >       __u32 flags;
> >> > } __attribute__((aligned(4 * sizeof(__u64))));
> >> > diff --git a/kernel/rseq.c b/kernel/rseq.c
> >> > index 97ac20b4f738..a4aca612724b 100644
> >> > --- a/kernel/rseq.c
> >> > +++ b/kernel/rseq.c
> >> > @@ -172,14 +172,16 @@ static int rseq_get_rseq_cs(struct task_struct *t, struct
> >> > rseq_cs *rseq_cs)
> >> >
> >> > static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
> >> > {
> >> > -     u32 flags, event_mask;
> >> > +     u32 old_flags, flags, event_mask;
> >> >       int ret;
> >> >
> >> >       /* Get thread flags. */
> >> > -     ret = get_user(flags, &t->rseq->flags);
> >> > +     ret = get_user(old_flags, &t->rseq->flags);
> >> >       if (ret)
> >> >               return ret;
> >> >
> >> > +     flags = old_flags;
> >> > +
> >> >       /* Take critical section flags into account. */
> >> >       flags |= cs_flags;
> >> >
> >> > @@ -203,6 +205,21 @@ static int rseq_need_restart(struct task_struct *t, u32
> >> > cs_flags)
> >> >       t->rseq_event_mask = 0;
> >> >       preempt_enable();
> >> >
> >> > +     /*
> >> > +      * If we don't restart on signal event, set the
> >> > +      * RSEQ_CS_FLAG_IN_SIGNAL_HANDLER flag so that later rseq_ip_fixup
> >> > +      * doesn't clear rseq_cs pointer as the IP is outside of critical
> >> > +      * section.
> >> > +      */
> >> > +     if ((flags & RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL) &&
> >> > +         (event_mask & RSEQ_EVENT_SIGNAL) &&
> >> > +         !(old_flags & RSEQ_CS_FLAG_IN_SIGNAL_HANDLER)) {
> >> > +             old_flags |= RSEQ_CS_FLAG_IN_SIGNAL_HANDLER;
> >> > +             ret = put_user(old_flags, &t->rseq->flags);
> >> > +             if (ret)
> >> > +                     return ret;
> >> > +     }
> >> > +
> >> >       return !!(event_mask & ~flags);
> >> > }
> >> >
> >> > @@ -248,10 +265,23 @@ static int rseq_ip_fixup(struct pt_regs *regs)
> >> >       /*
> >> >        * Handle potentially not being within a critical section.
> >> >        * If not nested over a rseq critical section, restart is useless.
> >> > -      * Clear the rseq_cs pointer and return.
> >> > +      * In case the RSEQ_CS_FLAG_IN_SIGNAL_HANDLER is set, we are in
> >> > +      * signal handlers and later return to critical section so don't
> >> > +      * clear rseq_cs pointer.
> >> > +      * Otherwise, clear the rseq_cs pointer and return.
> >> >        */
> >> > -     if (!in_rseq_cs(ip, &rseq_cs))
> >> > -             return clear_rseq_cs(t);
> >> > +     if (!in_rseq_cs(ip, &rseq_cs)) {
> >> > +             u32 flags;
> >> > +
> >> > +             ret = get_user(flags, &t->rseq->flags);
> >> > +             if (ret)
> >> > +                     return ret;
> >> > +             if (flags & RSEQ_CS_FLAG_IN_SIGNAL_HANDLER)
> >> > +                     return 0;
> >> > +             else
> >> > +                     return clear_rseq_cs(t);
> >> > +     }
> >> > +
> >> >       ret = rseq_need_restart(t, rseq_cs.flags);
> >> >       if (ret <= 0)
> >> >               return ret;
> >> > @@ -322,6 +352,46 @@ void rseq_syscall(struct pt_regs *regs)
> >> >
> >> > #endif
> >> >
> >> > +#ifdef CONFIG_RSEQ
> >> > +
> >> > +int rseq_sigreturn(struct pt_regs *regs)
> >> > +{
> >> > +     int ret;
> >> > +     struct rseq_cs rseq_cs;
> >> > +     struct task_struct *t = current;
> >> > +
> >> > +     if (t->rseq) {
> >> > +             u32 flags;
> >> > +
> >> > +             ret = get_user(flags, &t->rseq->flags);
> >> > +             if (ret)
> >> > +                     return ret;
> >> > +
> >> > +             if (flags & RSEQ_CS_FLAG_IN_SIGNAL_HANDLER) {
> >> > +                     ret = rseq_get_rseq_cs(t, &rseq_cs);
> >> > +                     if (ret)
> >> > +                             return ret;
> >> > +
> >> > +                     /*
> >> > +                      * If the returned IP is in critical section, it
> >> > +                      * means we handle all the possible nested signal,
> >> > +                      * so unset the RSEQ_CS_FLAG_IN_SIGNAL_HANDLER.
> >> > +                      */
> >> > +                     if (in_rseq_cs(regs->ip, &rseq_cs)) {
> >> > +                             flags &= ~RSEQ_CS_FLAG_IN_SIGNAL_HANDLER;
> >> > +
> >> > +                             ret = put_user(flags, &t->rseq->flags);
> >> > +                             if (ret)
> >> > +                                     return ret;
> >> > +                     }
> >> > +             }
> >> > +     }
> >> > +
> >> > +     return 0;
> >> > +}
> >> > +
> >> > +#endif
> >> > +
> >> > /*
> >> >  * sys_rseq - setup restartable sequences for caller thread.
> >> >  */
> >> > --
> >> > 2.25.1
> >>
> >> --
> >> Mathieu Desnoyers
> >> EfficiOS Inc.
> > > http://www.efficios.com
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
