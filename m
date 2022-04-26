Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA83510239
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352631AbiDZPyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242400AbiDZPyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:54:50 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921E74507C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:51:42 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id g21so20469592iom.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5zrRO/+5huIYXdKY8I32fCReo43SRfTwaBNjdukwSuw=;
        b=Y6RJXvVvJydXkqSgHCZ3Zjpjlqm/Kn1jAZ5113K1yRh6032AtTpHWl7/Jkv75lMy88
         lG6PMX8bINYKvZQ3ny101eC6kdk+3e9pDo3jh+uQMeZX/1418M8W1e5BYixPYDNwIg8d
         ycxuuYYVzV3Y6ETsH6xMnPRJESrsnsKbjJlfjbvKlznfwAx/QkqDlkJFTAicGfcsWaBA
         zDNRWUtxyYEfWgT9QSAN8k+PkbE2eNDZcKlozxakByHNmFE/c1T1yYVHF4uct+D9LZF+
         u5/5bujurA4wKgSrrLrPhpfZZig7d4dI5VxWbcqIBRvFDjk2swWOwzCwnSIHnSOi6GsD
         rlwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5zrRO/+5huIYXdKY8I32fCReo43SRfTwaBNjdukwSuw=;
        b=vD+3HH2GrMpNcowKyDYVLuw/Q6ZO82S78ypjV3aZm/R2khL1ynInQ7Ua+JmpgSS5C4
         rG0By3idYlKndw2/CMWT2DiTX/CNyTFHgEolcNPDDx0NNib32/n4RxmwfysHuDQk4u/R
         ll6fBcntntgloecgTLOt6AoPY6pOOa2DDh/o5h3dLnLDyWI4p4V+gqkklHsnAKBHDKm9
         vN0GngAqIM0MEC9OEU+34O0oNOrfyNtccJgpshC08jNf4hQBeBLmcmAMDaYd//MZ6DUD
         kKl/d5El1ux77DGYy/V4EYqbk9Lg+DA4kXc7QajtgZ3Vs1ZeCE2xza+RL3yNUl4c/aoP
         rF8Q==
X-Gm-Message-State: AOAM532myn1P4b+e8mH6isfK1Us2++DkQrMuxZvcGNfwo8aMeKJOo/3w
        EJf/14gtUH7Kt94H6nIzuxn790xLbPAdiBMu2CM=
X-Google-Smtp-Source: ABdhPJyoKenckq1VNEN3Swh8n2axLkgVEGYHKXI8T6DU2QkxmoUwq9DbCbdSRRSL9thezW6MGI7x9XLIVg6BmhwUl0s=
X-Received: by 2002:a05:6e02:1b89:b0:2cd:942d:86e3 with SMTP id
 h9-20020a056e021b8900b002cd942d86e3mr4628848ili.71.1650988301825; Tue, 26 Apr
 2022 08:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220120162520.570782-1-valentin.schneider@arm.com>
 <93a20759600c05b6d9e4359a1517c88e06b44834.camel@fb.com> <20220422110903.GW2731@worktop.programming.kicks-ass.net>
 <056e9bb0d0e3fc20572d42db7386face1d0665d6.camel@fb.com> <CAADnVQKsah4aka-LJ+X+5XHHESKbbw36D8fXTLqcYp2io3PN_w@mail.gmail.com>
 <YmflVPQlwpiBuxRc@hirez.programming.kicks-ass.net>
In-Reply-To: <YmflVPQlwpiBuxRc@hirez.programming.kicks-ass.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 26 Apr 2022 08:51:30 -0700
Message-ID: <CAEf4BzbJ2N9sOyKuM4iNPX2kqkKJ3zxWrT6eSt74S+McP2U8yA@mail.gmail.com>
Subject: Re: [PATCH] sched/tracing: append prev_state to tp args instead
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 5:28 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Apr 22, 2022 at 11:30:12AM -0700, Alexei Starovoitov wrote:
> > On Fri, Apr 22, 2022 at 10:22 AM Delyan Kratunov <delyank@fb.com> wrote:
> > >
> > > On Fri, 2022-04-22 at 13:09 +0200, Peter Zijlstra wrote:
> > > > And on the other hand; those users need to be fixed anyway, right?
> > > > Accessing prev->__state is equally broken.
> > >
> > > The users that access prev->__state would most likely have to be fixed, for sure.
> > >
> > > However, not all users access prev->__state. `offcputime` for example just takes a
> > > stack trace and associates it with the switched out task. This kind of user
> > > would continue working with the proposed patch.
> > >
> > > > If bpf wants to ride on them, it needs to suffer the pain of doing so.
> > >
> > > Sure, I'm just advocating for a fairly trivial patch to avoid some of the suffering,
> > > hopefully without being a burden to development. If that's not the case, then it's a
> > > clear no-go.
> >
> >
> > Namhyung just sent this patch set:
> > https://patchwork.kernel.org/project/netdevbpf/patch/20220422053401.208207-3-namhyung@kernel.org/
>
> That has:
>
> + * recently task_struct->state renamed to __state so it made an incompatible
> + * change.
>
> git tells me:
>
>   2f064a59a11f ("sched: Change task_struct::state")
>
> is almost a year old by now. That don't qualify as recently in my book.
> That says that 'old kernels used to call this...'.
>
> > to add off-cpu profiling to perf.
> > It also hooks into sched_switch tracepoint.
> > Notice it deals with state->__state rename just fine.
>
> So I don't speak BPF much; it always takes me more time to make bpf work
> than to just hack up the kernel, which makes it hard to get motivated.
>
> However, it was not just a rename, state changed type too, which is why I
> did the rename, to make sure all users would get a compile fail and
> could adjust.
>
> If you're silently making it work by frobbing the name, you loose that.

In general, libbpf is trying to accommodate it as best as it can. It
will adjust load size automatically based on BTF information for
direct memory reads. For cases when users have to use
bpf_probe_read_kernel(), it's impossible to do this automatically, but
libbpf and BPF CO-RE provide primitives to accommodate changes to
field types. We have bpf_core_field_size() and
BPF_CORE_READ_BITFIELD()/BPF_CORE_READ_BITFIELD_PROBED() macros that
can read any bitfield or integer type properly and store them into
u64.

So yes, user will still have to test and validate their BPF programs
for new kernels, but they do have instruments to handle this in a
contained way in BPF code without awkward extra user-space side
feature detection.

With __state rename, it's been done, it's easy to accommodate. That
easiness of being able to deal with this change is one of the reasons
we never asked to do anything about that. It was rather mild
inconveniences for a bunch of tools and applications.

This argument reordering, as I mentioned before, is a much bigger deal
and much harder to deal with easily. As Alexei mentioned, we are
discussing extending BPF CO-RE to be able to accommodate even such
changes in pure BPF-side code, but we don't have that mechanism yet,
so if it's not too hard, we still kindly ask to consider appending a
new argument at the end.


>
> Specifically, task_struct::state used to be 'volatile long', while
> task_struct::__state is 'unsigned int'. As such, any user must now be
> very careful to use READ_ONCE(). I don't see that happening with just
> frobbing the name.
>
> Additinoally, by shrinking the field, I suppose BE systems get to keep
> the pieces?
>
> > But it will have a hard time without this patch
> > until we add all the extra CO-RE features to detect
> > and automatically adjust bpf progs when tracepoint
> > arguments order changed.
>
> Could be me, but silently making it work sounds like fail :/ There's a
> reason code changes, users need to adapt, not silently pretend stuff is
> as before.
>
> How will you know you need to fix your tool?

There is no denying that tracing BPF code successfully compiling
doesn't mean it's going to work correctly (like with any other code,
really). So testing is still mandatory. This is more about being able
to deal with such changes without having to maintain two separately
compiled BPF programs or doing extensive and expensive feature
detection in user-space code.

>
> > We will do it eventually, of course.
> > There will be additional work in llvm, libbpf, kernel, etc.
> > But for now I think it would be good to land Delyan's patch
> > to avoid unnecessary pain to all the users.
> >
> > Peter, do you mind?
>
> I suppose I can help out this time, but I really don't want to set a
> precedent for these things. Broken is broken.

We'd really appreciate it if you do help out this time. The intent is
not to set any kind of precedent. This ask is due to
sched_switch is a very popular target *and* this change can't be
easily detected (once detected it can be easily accommodated, but
detection is painful), so overall impact is disproportionate.

>
> The down-side for me is that the argument order no longer makes any
> sense.

The order changes only for tracing-related macros/functions, so
hopefully that doesn't make the rest of scheduler code illogical or
inconvenient.
