Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8657350C066
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 21:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiDVTcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 15:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiDVTcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 15:32:08 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1160921A674
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 12:10:10 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id b5so5663197ile.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 12:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rvKMiQM5BxmRRC7ajbQUzyS9sRzOBfLb0jjIwCaRIP8=;
        b=pKZncDd/5eiUgfslYCwu3tEWPP063ruyoXjkcSv5TL48nBr3RJhhYsYKPjXTpJCSdi
         PiqbG4yiv+A4ScSJHD4yr0oJk37m+CR9dqa1bgXCYI0IGIvlS0JcextYhtgEZtReQVU3
         m4fg5q2gcIdBy9zau0hMnyvYLKpn96oL/t4H6e4258anB6CTpvNL0iRtVW8kLsnT2u5d
         82+cCLl9pWNEdiMHQ9nLvAhbiszzCL8epAnWF+4klY/SaLYzaM+juCF2df+MMD2ZE2hr
         66r6rfP3njCPNXcUzxVmGwM/a1x9DmY10eCTrv8hEO079moteOdVZ47cCpM9RiBIH+Lc
         KYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rvKMiQM5BxmRRC7ajbQUzyS9sRzOBfLb0jjIwCaRIP8=;
        b=E7GPII9kBJW58ib28M9KkkcvNFvfr8y2TWkv0XBRVIYnJqinNaiZSwG2/Ins2A2Hkd
         5oSb4H7H6GsCA2emm35g6luGOe7jxT7cJxdYGfE4/bOuvHjWU+hCSOl47IjgoVd/KF/1
         rQz+5Z4WrOAToKP2HrRQorf1KhoWs021CZImcUXYs+Yjp/s66FWJM5muodVanR55aWy4
         0Hew/cJIx7xozFvvzaqXV8tm4Xt9Ey1nRqOikGGWQlKEE314GeD3qNQ2V/SZYW/2S+3q
         3PY1jQRl0oAQUanhROh1NiOhrJmcRwIvdzPxhABKzlAqsWyOmF+SAw20w8VpHh6hAlmY
         Y5QA==
X-Gm-Message-State: AOAM531H82MtbZmq0SAIDJwjmx+YGVrFJa2ZKtJaAJT0DyJjxaIM+LfB
        pZx6Fbi69RvF4L/6gg8wzvmdOufEtzypIiubW8BNLFfEhV8=
X-Google-Smtp-Source: ABdhPJzeNBbSMKYrm7MGzQ6qGhUOnjVtx8n1dn/Sds8JzghAxwR2gtytaG4V6r/JzHO/6o5NgW2JvKnP3utwlFfPe5k=
X-Received: by 2002:a63:2b4f:0:b0:398:49ba:a268 with SMTP id
 r76-20020a632b4f000000b0039849baa268mr4959451pgr.546.1650652223336; Fri, 22
 Apr 2022 11:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220120162520.570782-1-valentin.schneider@arm.com>
 <93a20759600c05b6d9e4359a1517c88e06b44834.camel@fb.com> <20220422110903.GW2731@worktop.programming.kicks-ass.net>
 <056e9bb0d0e3fc20572d42db7386face1d0665d6.camel@fb.com>
In-Reply-To: <056e9bb0d0e3fc20572d42db7386face1d0665d6.camel@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 22 Apr 2022 11:30:12 -0700
Message-ID: <CAADnVQKsah4aka-LJ+X+5XHHESKbbw36D8fXTLqcYp2io3PN_w@mail.gmail.com>
Subject: Re: [PATCH] sched/tracing: append prev_state to tp args instead
To:     Delyan Kratunov <delyank@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
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

On Fri, Apr 22, 2022 at 10:22 AM Delyan Kratunov <delyank@fb.com> wrote:
>
> On Fri, 2022-04-22 at 13:09 +0200, Peter Zijlstra wrote:
> > And on the other hand; those users need to be fixed anyway, right?
> > Accessing prev->__state is equally broken.
>
> The users that access prev->__state would most likely have to be fixed, for sure.
>
> However, not all users access prev->__state. `offcputime` for example just takes a
> stack trace and associates it with the switched out task. This kind of user
> would continue working with the proposed patch.
>
> > If bpf wants to ride on them, it needs to suffer the pain of doing so.
>
> Sure, I'm just advocating for a fairly trivial patch to avoid some of the suffering,
> hopefully without being a burden to development. If that's not the case, then it's a
> clear no-go.


Namhyung just sent this patch set:
https://patchwork.kernel.org/project/netdevbpf/patch/20220422053401.208207-3-namhyung@kernel.org/

to add off-cpu profiling to perf.
It also hooks into sched_switch tracepoint.
Notice it deals with state->__state rename just fine.
But it will have a hard time without this patch
until we add all the extra CO-RE features to detect
and automatically adjust bpf progs when tracepoint
arguments order changed.
We will do it eventually, of course.
There will be additional work in llvm, libbpf, kernel, etc.
But for now I think it would be good to land Delyan's patch
to avoid unnecessary pain to all the users.

Peter, do you mind?
