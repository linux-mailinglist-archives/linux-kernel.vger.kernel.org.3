Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AE15130EA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbiD1KMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbiD1KLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:11:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A0876007E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:02:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AD2D1474;
        Thu, 28 Apr 2022 03:02:41 -0700 (PDT)
Received: from wubuntu (unknown [10.57.76.183])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7134C3F774;
        Thu, 28 Apr 2022 03:02:37 -0700 (PDT)
Date:   Thu, 28 Apr 2022 11:02:35 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Delyan Kratunov <delyank@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "legion@kernel.org" <legion@kernel.org>,
        "adharmap@quicinc.com" <adharmap@quicinc.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "ed.tsai@mediatek.com" <ed.tsai@mediatek.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH] sched/tracing: append prev_state to tp args instead
Message-ID: <20220428100235.sqoxunbylqk2surk@wubuntu>
References: <20220120162520.570782-1-valentin.schneider@arm.com>
 <93a20759600c05b6d9e4359a1517c88e06b44834.camel@fb.com>
 <20220422110903.GW2731@worktop.programming.kicks-ass.net>
 <056e9bb0d0e3fc20572d42db7386face1d0665d6.camel@fb.com>
 <CAADnVQKsah4aka-LJ+X+5XHHESKbbw36D8fXTLqcYp2io3PN_w@mail.gmail.com>
 <YmflVPQlwpiBuxRc@hirez.programming.kicks-ass.net>
 <20220426140959.op6u5m7id57aq7yc@wubuntu>
 <CAEf4BzaoL5HVc8U16kz7m--RiPhBwuLt8ZGZppwfxV85AXXrcw@mail.gmail.com>
 <20220427103458.ecnqtaj3af63625h@wubuntu>
 <CAEf4BzYc3f2-9hvuGL_mTO8qNxZjdQn8AabEb-N6Q7XjmEQQ1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzYc3f2-9hvuGL_mTO8qNxZjdQn8AabEb-N6Q7XjmEQQ1A@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27/22 11:17, Andrii Nakryiko wrote:
> On Wed, Apr 27, 2022 at 3:35 AM Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > On 04/26/22 08:54, Andrii Nakryiko wrote:
> > > On Tue, Apr 26, 2022 at 7:10 AM Qais Yousef <qais.yousef@arm.com> wrote:
> > > >
> > > > On 04/26/22 14:28, Peter Zijlstra wrote:
> > > > > On Fri, Apr 22, 2022 at 11:30:12AM -0700, Alexei Starovoitov wrote:
> > > > > > On Fri, Apr 22, 2022 at 10:22 AM Delyan Kratunov <delyank@fb.com> wrote:
> > > > > > >
> > > > > > > On Fri, 2022-04-22 at 13:09 +0200, Peter Zijlstra wrote:
> > > > > > > > And on the other hand; those users need to be fixed anyway, right?
> > > > > > > > Accessing prev->__state is equally broken.
> > > > > > >
> > > > > > > The users that access prev->__state would most likely have to be fixed, for sure.
> > > > > > >
> > > > > > > However, not all users access prev->__state. `offcputime` for example just takes a
> > > > > > > stack trace and associates it with the switched out task. This kind of user
> > > > > > > would continue working with the proposed patch.
> > > > > > >
> > > > > > > > If bpf wants to ride on them, it needs to suffer the pain of doing so.
> > > > > > >
> > > > > > > Sure, I'm just advocating for a fairly trivial patch to avoid some of the suffering,
> > > > > > > hopefully without being a burden to development. If that's not the case, then it's a
> > > > > > > clear no-go.
> > > > > >
> > > > > >
> > > > > > Namhyung just sent this patch set:
> > > > > > https://patchwork.kernel.org/project/netdevbpf/patch/20220422053401.208207-3-namhyung@kernel.org/
> > > > >
> > > > > That has:
> > > > >
> > > > > + * recently task_struct->state renamed to __state so it made an incompatible
> > > > > + * change.
> > > > >
> > > > > git tells me:
> > > > >
> > > > >   2f064a59a11f ("sched: Change task_struct::state")
> > > > >
> > > > > is almost a year old by now. That don't qualify as recently in my book.
> > > > > That says that 'old kernels used to call this...'.
> > > > >
> > > > > > to add off-cpu profiling to perf.
> > > > > > It also hooks into sched_switch tracepoint.
> > > > > > Notice it deals with state->__state rename just fine.
> > > > >
> > > > > So I don't speak BPF much; it always takes me more time to make bpf work
> > > > > than to just hack up the kernel, which makes it hard to get motivated.
> > > > >
> > > > > However, it was not just a rename, state changed type too, which is why I
> > > > > did the rename, to make sure all users would get a compile fail and
> > > > > could adjust.
> > > > >
> > > > > If you're silently making it work by frobbing the name, you loose that.
> > > > >
> > > > > Specifically, task_struct::state used to be 'volatile long', while
> > > > > task_struct::__state is 'unsigned int'. As such, any user must now be
> > > > > very careful to use READ_ONCE(). I don't see that happening with just
> > > > > frobbing the name.
> > > > >
> > > > > Additinoally, by shrinking the field, I suppose BE systems get to keep
> > > > > the pieces?
> > > > >
> > > > > > But it will have a hard time without this patch
> > > > > > until we add all the extra CO-RE features to detect
> > > > > > and automatically adjust bpf progs when tracepoint
> > > > > > arguments order changed.
> > > > >
> > > > > Could be me, but silently making it work sounds like fail :/ There's a
> > > > > reason code changes, users need to adapt, not silently pretend stuff is
> > > > > as before.
> > > > >
> > > > > How will you know you need to fix your tool?
> > > >
> > > > If libbpf doesn't fail, then yeah it's a big problem. I wonder how users of
> > > > kprobe who I suppose are more prone to this kind of problems have been coping.
> > >
> > > See my reply to Peter. libbpf can't know user's intent to fail this
> > > automatically, in general. In some cases when it can it does
> > > accommodate this automatically. In other cases it provides instruments
> > > for user to handle this (bpf_core_field_size(),
> > > BPF_CORE_READ_BITFIELD(), etc).
> >
> > My naiive thinking is that the function signature has changed (there's 1 extra
> > arg not just a subtle swap of args of the same type) - so I thought that can be
> > detected. But maybe it is harder said than done.
> 
> It is. We don't have number of arguments either:
> 
> struct bpf_raw_tracepoint_args {
>         __u64 args[0];
> };
> 
> What BPF program is getting is just an array of u64s.
> 
> >
> > I am trying to remember as I've used this before; I think you get the arg list
> > as part of ctx when you attach to a function?
> >
> > I wonder if it'd be hard to provide a macro for the user to provide the
> > signature of the function they expect; this macro can try then to verify/assert
> > the number, type and order is the same. Not bullet proof and requires opt-in,
> > but could be useful?
> >
> >
> > // dummy pseudo-code
> >
> >         BPF_CORE_ASSERT_SIG(sched_switch, NR_ARGS, ARG0, ARG1, ...)
> >                 if (ctx->nr_args != NR_ARGS)
> >                         assert()
> >                 if (type_of(ctx->args[0]) != type_of(ARG0))
> >                         assert()
> >                 ...
> >
> > I'm not sure if you have any info about the type though..
> 
> What we have now under discussion is more generic way for user to
> check signature of function prototype, struct/union, etc. But all that
> will take some time to implement and finalize. So this patch is a way
> to stop/prevent the bleeding until we have that available to users.

Okay good to know. Alexei mentioned a plan, but I didn't get that it included
signature verification.

Cheers

--
Qais Yousef
