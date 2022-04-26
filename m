Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CA5510243
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352589AbiDZP5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236826AbiDZP5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:57:36 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0676D15CEAE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:54:29 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id r28so1805307iot.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HSvtwZpAkuv6AVEJodrvJP+b239G8tFOswN2WmHZxq8=;
        b=lXjd8yPyjZf18NMqeiqatwHcNE2dOivYsc7mNkxXwUVYTlkLisfHjlBnK2LoTAp1xa
         iKTta2kHOKebIQuYChpe4sNbAch9kf/Ed4F+nb0CTtwuSCpGFJU+1/QaxQuM/0K1IXst
         SnO2WiMbkcVvbJROkbhJ5VUz60X9KqKUruXfkzRgUPiBt/re410DBnH2DVBITuSlx+pW
         tVWJWMT1NN0hC9p/Qaj3KK1u3tKyjUVa1zgW7KGNP2G6gF53ZVeSz6iK/LJgFbf1oBW9
         wEPQ12vESNVx2DVIiUmW+ctHr5v/F7eHkZOvXg9P7ipdJ1OHU9F8SzRRmFXY/SinGXnr
         TqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HSvtwZpAkuv6AVEJodrvJP+b239G8tFOswN2WmHZxq8=;
        b=r5gPGcWVU7Jg1FrBYtOBOpmADX/e+ckTKaYzDByYnBwDmi4T4IQTlOT+P3nGdGIuHo
         2kmzgMC9wqQUFtXVoteAZBR9oglFS9Xp96clfdLNcbMrcCSg94Zsc9jPma0M1p2/7zNk
         R3EfX/LA6qmJmP0eh6hfz2DfSaT1KKe1iXijEKnHdgVlxZ5V9Wxh9ypilijziBHlHOe8
         bIm0hgBuQEOT/sfIZCHUTkUVsBAUpGJAuRJZghUNQ48gt6F/lSJT9L5UX0/w14WMSqnT
         V94THLg7U9JCsklNtyfC/Q0EL8B0XaIZ8vZPneqbsaXzo9+Xmliuv/5+oBcFG2uIDvjF
         LTkQ==
X-Gm-Message-State: AOAM5313MO4q8OGUVEIJWcHYrHZX6pUJOkmKaB6EFMf0Hena8axDBwN1
        K3X1lrA641y1NiNs0CI+ekHia93OZN69wHagh7o=
X-Google-Smtp-Source: ABdhPJx+h0r4To7YsiEDfg+uv/p+xfZl7R8UmHsNh2Cu9yrM2ynd+3g6PaHcek9Eoux2Vt8DNBXdcNz8uaAfEZJp894=
X-Received: by 2002:a5d:9f4e:0:b0:652:2323:2eb8 with SMTP id
 u14-20020a5d9f4e000000b0065223232eb8mr9580794iot.79.1650988468412; Tue, 26
 Apr 2022 08:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220120162520.570782-1-valentin.schneider@arm.com>
 <93a20759600c05b6d9e4359a1517c88e06b44834.camel@fb.com> <20220422110903.GW2731@worktop.programming.kicks-ass.net>
 <056e9bb0d0e3fc20572d42db7386face1d0665d6.camel@fb.com> <CAADnVQKsah4aka-LJ+X+5XHHESKbbw36D8fXTLqcYp2io3PN_w@mail.gmail.com>
 <YmflVPQlwpiBuxRc@hirez.programming.kicks-ass.net> <20220426140959.op6u5m7id57aq7yc@wubuntu>
In-Reply-To: <20220426140959.op6u5m7id57aq7yc@wubuntu>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 26 Apr 2022 08:54:17 -0700
Message-ID: <CAEf4BzaoL5HVc8U16kz7m--RiPhBwuLt8ZGZppwfxV85AXXrcw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 7:10 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 04/26/22 14:28, Peter Zijlstra wrote:
> > On Fri, Apr 22, 2022 at 11:30:12AM -0700, Alexei Starovoitov wrote:
> > > On Fri, Apr 22, 2022 at 10:22 AM Delyan Kratunov <delyank@fb.com> wrote:
> > > >
> > > > On Fri, 2022-04-22 at 13:09 +0200, Peter Zijlstra wrote:
> > > > > And on the other hand; those users need to be fixed anyway, right?
> > > > > Accessing prev->__state is equally broken.
> > > >
> > > > The users that access prev->__state would most likely have to be fixed, for sure.
> > > >
> > > > However, not all users access prev->__state. `offcputime` for example just takes a
> > > > stack trace and associates it with the switched out task. This kind of user
> > > > would continue working with the proposed patch.
> > > >
> > > > > If bpf wants to ride on them, it needs to suffer the pain of doing so.
> > > >
> > > > Sure, I'm just advocating for a fairly trivial patch to avoid some of the suffering,
> > > > hopefully without being a burden to development. If that's not the case, then it's a
> > > > clear no-go.
> > >
> > >
> > > Namhyung just sent this patch set:
> > > https://patchwork.kernel.org/project/netdevbpf/patch/20220422053401.208207-3-namhyung@kernel.org/
> >
> > That has:
> >
> > + * recently task_struct->state renamed to __state so it made an incompatible
> > + * change.
> >
> > git tells me:
> >
> >   2f064a59a11f ("sched: Change task_struct::state")
> >
> > is almost a year old by now. That don't qualify as recently in my book.
> > That says that 'old kernels used to call this...'.
> >
> > > to add off-cpu profiling to perf.
> > > It also hooks into sched_switch tracepoint.
> > > Notice it deals with state->__state rename just fine.
> >
> > So I don't speak BPF much; it always takes me more time to make bpf work
> > than to just hack up the kernel, which makes it hard to get motivated.
> >
> > However, it was not just a rename, state changed type too, which is why I
> > did the rename, to make sure all users would get a compile fail and
> > could adjust.
> >
> > If you're silently making it work by frobbing the name, you loose that.
> >
> > Specifically, task_struct::state used to be 'volatile long', while
> > task_struct::__state is 'unsigned int'. As such, any user must now be
> > very careful to use READ_ONCE(). I don't see that happening with just
> > frobbing the name.
> >
> > Additinoally, by shrinking the field, I suppose BE systems get to keep
> > the pieces?
> >
> > > But it will have a hard time without this patch
> > > until we add all the extra CO-RE features to detect
> > > and automatically adjust bpf progs when tracepoint
> > > arguments order changed.
> >
> > Could be me, but silently making it work sounds like fail :/ There's a
> > reason code changes, users need to adapt, not silently pretend stuff is
> > as before.
> >
> > How will you know you need to fix your tool?
>
> If libbpf doesn't fail, then yeah it's a big problem. I wonder how users of
> kprobe who I suppose are more prone to this kind of problems have been coping.

See my reply to Peter. libbpf can't know user's intent to fail this
automatically, in general. In some cases when it can it does
accommodate this automatically. In other cases it provides instruments
for user to handle this (bpf_core_field_size(),
BPF_CORE_READ_BITFIELD(), etc).

But in the end no one eliminated the need for testing your application
for correctness. Tracing programs do break on kernel changes and BPF
users do adapt to them. Sometimes adapting is easy (like state ->
__state transition), sometimes it's much more involved (like this
argument order change).

>
> >
> > > We will do it eventually, of course.
> > > There will be additional work in llvm, libbpf, kernel, etc.
> > > But for now I think it would be good to land Delyan's patch
> > > to avoid unnecessary pain to all the users.
> > >
> > > Peter, do you mind?
> >
> > I suppose I can help out this time, but I really don't want to set a
> > precedent for these things. Broken is broken.
> >
> > The down-side for me is that the argument order no longer makes any
> > sense.
>
> I'm intending to backport fa2c3254d7cf to 5.10 and 5.15 but waiting for
> a Tested-by. If you take this one, then it'll need to be backported too.
>
> Cheers
>
> --
> Qais Yousef
