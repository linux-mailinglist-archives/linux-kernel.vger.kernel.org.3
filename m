Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB37520556
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 21:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240641AbiEITgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 15:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240590AbiEITgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 15:36:38 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D0128F7EC
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 12:32:42 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id e3so16426261ios.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 12:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OaSitDuE8C6499r8aXHWuv+yMccSKrA1pR4U1fjVnmM=;
        b=S4u/5fR9po7T/TSHS4xFSRzPH2Oc86oBNUPP5gSZdbWRDdSwexi1e6h3/Q6JQGH00z
         IYTKkB/7DK5lGYKr2i909gVxMQMcCSx20VKgpzNqaQNrZAGLpvhUJr049djXW4bgWF1B
         b0e+sSwLl9sRs1F0Lg0QdJpN7UMucRL9P5w0SAlybSYaKH82TtcT2YCy2LgyQxUqNrfO
         D/nev2U367sT0VuRbxLjLUNquL8kaazi0r4md5Kd4XBEo3/27UgXrX04AhR/Mpo7865c
         oPhBUdwGbD0dTsYFgLdqmqUkZ5mN8+xytPTbTEcuepxDUJcfnYQK0UssbH9mqwR43ti6
         5gng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OaSitDuE8C6499r8aXHWuv+yMccSKrA1pR4U1fjVnmM=;
        b=PCi6faQ//UxlDsv6O2I1CTKzx/Pald9n1hqGPF3sVTuKbfP6piTnGa06oQvAQGAXQa
         8uQFsj8qenTJ7wCxBVz5wQXCTT2ZRsKh2NSpIZ68WJ5XdJTeHkxGznBNmCSxAXzkdfFR
         CxfK39pyM68nc95MiT/mYmlLXFn64piiwHSgFcY6EpiXsRABBO+m7IIQ20H2vd5FExPU
         QQImunzg8HJPZn/PBQB0x4s8W126oAmX/jl8cgf/p8bWDrH99eNUwNAZWmoYpal7COBE
         HlJ+kc7r3OCL/RotCGY3CCNj/PCR2gz2/yNi1sI5AMAhhVzIoCdYsZHxitT8RjuyY4a0
         m7Xg==
X-Gm-Message-State: AOAM5334Snxn3dqgz0CrgZ5Z1EP47KWFpE4q0JopabNZeJJPtlcU+NU4
        aBU6K2qP2OeL7LihpXaUiBBHan1ekKXpmnCYsD4=
X-Google-Smtp-Source: ABdhPJxDrVKGK/GgIRJf7J7Rsau9rXzRxhGiDa+PRLW9H9EphhoPQMRL9iKnh43XIGMpGIEd9zpEnzAy3lS1jysMkvw=
X-Received: by 2002:a02:5d47:0:b0:32b:4387:51c8 with SMTP id
 w68-20020a025d47000000b0032b438751c8mr8136383jaa.103.1652124761965; Mon, 09
 May 2022 12:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220120162520.570782-1-valentin.schneider@arm.com>
 <93a20759600c05b6d9e4359a1517c88e06b44834.camel@fb.com> <20220422110903.GW2731@worktop.programming.kicks-ass.net>
 <056e9bb0d0e3fc20572d42db7386face1d0665d6.camel@fb.com> <CAADnVQKsah4aka-LJ+X+5XHHESKbbw36D8fXTLqcYp2io3PN_w@mail.gmail.com>
 <YmflVPQlwpiBuxRc@hirez.programming.kicks-ass.net> <20220426140959.op6u5m7id57aq7yc@wubuntu>
 <CAEf4BzaoL5HVc8U16kz7m--RiPhBwuLt8ZGZppwfxV85AXXrcw@mail.gmail.com>
 <20220427103458.ecnqtaj3af63625h@wubuntu> <CAEf4BzYc3f2-9hvuGL_mTO8qNxZjdQn8AabEb-N6Q7XjmEQQ1A@mail.gmail.com>
 <20220428100235.sqoxunbylqk2surk@wubuntu>
In-Reply-To: <20220428100235.sqoxunbylqk2surk@wubuntu>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 May 2022 12:32:31 -0700
Message-ID: <CAEf4BzaEo+dxSRJZHQiXYrj-a3_B-eODZUxGh3HrnPjquMYFXQ@mail.gmail.com>
Subject: Re: [PATCH] sched/tracing: append prev_state to tp args instead
To:     Qais Yousef <qais.yousef@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 3:02 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 04/27/22 11:17, Andrii Nakryiko wrote:
> > On Wed, Apr 27, 2022 at 3:35 AM Qais Yousef <qais.yousef@arm.com> wrote:
> > >
> > > On 04/26/22 08:54, Andrii Nakryiko wrote:
> > > > On Tue, Apr 26, 2022 at 7:10 AM Qais Yousef <qais.yousef@arm.com> wrote:
> > > > >
> > > > > On 04/26/22 14:28, Peter Zijlstra wrote:
> > > > > > On Fri, Apr 22, 2022 at 11:30:12AM -0700, Alexei Starovoitov wrote:
> > > > > > > On Fri, Apr 22, 2022 at 10:22 AM Delyan Kratunov <delyank@fb.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, 2022-04-22 at 13:09 +0200, Peter Zijlstra wrote:
> > > > > > > > > And on the other hand; those users need to be fixed anyway, right?
> > > > > > > > > Accessing prev->__state is equally broken.
> > > > > > > >
> > > > > > > > The users that access prev->__state would most likely have to be fixed, for sure.
> > > > > > > >
> > > > > > > > However, not all users access prev->__state. `offcputime` for example just takes a
> > > > > > > > stack trace and associates it with the switched out task. This kind of user
> > > > > > > > would continue working with the proposed patch.
> > > > > > > >
> > > > > > > > > If bpf wants to ride on them, it needs to suffer the pain of doing so.
> > > > > > > >
> > > > > > > > Sure, I'm just advocating for a fairly trivial patch to avoid some of the suffering,
> > > > > > > > hopefully without being a burden to development. If that's not the case, then it's a
> > > > > > > > clear no-go.
> > > > > > >
> > > > > > >
> > > > > > > Namhyung just sent this patch set:
> > > > > > > https://patchwork.kernel.org/project/netdevbpf/patch/20220422053401.208207-3-namhyung@kernel.org/
> > > > > >
> > > > > > That has:
> > > > > >
> > > > > > + * recently task_struct->state renamed to __state so it made an incompatible
> > > > > > + * change.
> > > > > >
> > > > > > git tells me:
> > > > > >
> > > > > >   2f064a59a11f ("sched: Change task_struct::state")
> > > > > >
> > > > > > is almost a year old by now. That don't qualify as recently in my book.
> > > > > > That says that 'old kernels used to call this...'.
> > > > > >
> > > > > > > to add off-cpu profiling to perf.
> > > > > > > It also hooks into sched_switch tracepoint.
> > > > > > > Notice it deals with state->__state rename just fine.
> > > > > >
> > > > > > So I don't speak BPF much; it always takes me more time to make bpf work
> > > > > > than to just hack up the kernel, which makes it hard to get motivated.
> > > > > >
> > > > > > However, it was not just a rename, state changed type too, which is why I
> > > > > > did the rename, to make sure all users would get a compile fail and
> > > > > > could adjust.
> > > > > >
> > > > > > If you're silently making it work by frobbing the name, you loose that.
> > > > > >
> > > > > > Specifically, task_struct::state used to be 'volatile long', while
> > > > > > task_struct::__state is 'unsigned int'. As such, any user must now be
> > > > > > very careful to use READ_ONCE(). I don't see that happening with just
> > > > > > frobbing the name.
> > > > > >
> > > > > > Additinoally, by shrinking the field, I suppose BE systems get to keep
> > > > > > the pieces?
> > > > > >
> > > > > > > But it will have a hard time without this patch
> > > > > > > until we add all the extra CO-RE features to detect
> > > > > > > and automatically adjust bpf progs when tracepoint
> > > > > > > arguments order changed.
> > > > > >
> > > > > > Could be me, but silently making it work sounds like fail :/ There's a
> > > > > > reason code changes, users need to adapt, not silently pretend stuff is
> > > > > > as before.
> > > > > >
> > > > > > How will you know you need to fix your tool?
> > > > >
> > > > > If libbpf doesn't fail, then yeah it's a big problem. I wonder how users of
> > > > > kprobe who I suppose are more prone to this kind of problems have been coping.
> > > >
> > > > See my reply to Peter. libbpf can't know user's intent to fail this
> > > > automatically, in general. In some cases when it can it does
> > > > accommodate this automatically. In other cases it provides instruments
> > > > for user to handle this (bpf_core_field_size(),
> > > > BPF_CORE_READ_BITFIELD(), etc).
> > >
> > > My naiive thinking is that the function signature has changed (there's 1 extra
> > > arg not just a subtle swap of args of the same type) - so I thought that can be
> > > detected. But maybe it is harder said than done.
> >
> > It is. We don't have number of arguments either:
> >
> > struct bpf_raw_tracepoint_args {
> >         __u64 args[0];
> > };
> >
> > What BPF program is getting is just an array of u64s.
> >
> > >
> > > I am trying to remember as I've used this before; I think you get the arg list
> > > as part of ctx when you attach to a function?
> > >
> > > I wonder if it'd be hard to provide a macro for the user to provide the
> > > signature of the function they expect; this macro can try then to verify/assert
> > > the number, type and order is the same. Not bullet proof and requires opt-in,
> > > but could be useful?
> > >
> > >
> > > // dummy pseudo-code
> > >
> > >         BPF_CORE_ASSERT_SIG(sched_switch, NR_ARGS, ARG0, ARG1, ...)
> > >                 if (ctx->nr_args != NR_ARGS)
> > >                         assert()
> > >                 if (type_of(ctx->args[0]) != type_of(ARG0))
> > >                         assert()
> > >                 ...
> > >
> > > I'm not sure if you have any info about the type though..
> >
> > What we have now under discussion is more generic way for user to
> > check signature of function prototype, struct/union, etc. But all that
> > will take some time to implement and finalize. So this patch is a way
> > to stop/prevent the bleeding until we have that available to users.
>
> Okay good to know. Alexei mentioned a plan, but I didn't get that it included
> signature verification.
>

Given the discussion subsided, I'm still a bit unclear about the
outcome. Hopefully the discussion made it a bit clearer why this
one-time change is so helpful to the broader BPF community and is
rather an exception and not an expectation (and we have work in
progress to be able to handle even such changes in the future).

So can this patch be applied, please, or it's a hard no?

> Cheers
>
> --
> Qais Yousef
