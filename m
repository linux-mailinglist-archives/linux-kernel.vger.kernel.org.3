Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B17510B43
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355435AbiDZVbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355392AbiDZVbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:31:40 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBB83BFBF;
        Tue, 26 Apr 2022 14:28:31 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x17so34189511lfa.10;
        Tue, 26 Apr 2022 14:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X3vH2FdwndHn9f33osQO3Qb0X8mmToLLsLuwU//7UdI=;
        b=M9/KR8IaWKFdg0evLWDFsdB2eETUD/lAZOhzlfwGXFhwaE8Z3Qd0cSztTSXSJ6Aojb
         Lvy0EMVrOkrguaRRrJRmzGlgZXjlyzKGaPUMjL216G1cTtxdRl87ktaktkpB+xBrpWW1
         8/FrVrN49q6A1m3X9fobDOjCUOwxHO8UiInrdCW0/6vNeO8guC8n/p9Zl5nDditr+iFR
         2N53YSyqaE3DK+KtAhB3jMTYlLTdsdax9jYeZtTfJYPUT1Xa8a4DaYNUeYapAX94quQl
         F8SXZr5YSIdBtnFVTls1aR/A4gqbN5bexj3qHzoI9HtmNyPGzPAAPujpHgLOUhbBo0aL
         1N/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X3vH2FdwndHn9f33osQO3Qb0X8mmToLLsLuwU//7UdI=;
        b=i7hlPwdDoazKArNklTReLl2b7m07nvDIgOW6ikkaBGHW3vToRDHr0uOXLfdkR728oo
         YZSjPgzJw7kgeAEKSPDMVX+T3hmmnrwmPRtjlfpejvVPO4Spqn2LnoH6jxFzehacCZh9
         XcJKGkmPftgz6oNkdGbqjlvHw4QR62mb90CI+Gv/Qv/jJ3WBGw2M/+tzhPmupsKoK24d
         AOQDbN/zKAGN7EtYf1aa/Bigod5Aq0pCnxCWFkq/ncyH5WHQwqcKkF7n7AwFg5AnoS6h
         l8AJuiOU7JcCYLKPKhHRwunZRx7AgrYIDNuy5gHspFYyDmRIkeYrPka/Bcq6trBdV2eV
         tZaw==
X-Gm-Message-State: AOAM530hfjPFO+ZLDCMm2Q+0jlfqtY/vtbKdk43+fdSgv2NwsM1sOKbo
        f1ZL6QDjqgbycppcrWdCsRiiJcPgp0hVQMSBtQk=
X-Google-Smtp-Source: ABdhPJxx2SzDrWo6M18JeOrz/WM19bkC0sm3SJhn3nnYP4q8dZNf9hOD1BXrX8zeVzq1pf+7FMQxWAhgBL/+W3C5yxU=
X-Received: by 2002:a19:c511:0:b0:471:fc54:8a5 with SMTP id
 w17-20020a19c511000000b00471fc5408a5mr12421591lfe.454.1651008509225; Tue, 26
 Apr 2022 14:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220420102354.468173-1-florian.fischer@muhq.space>
 <YmA48V09iBbqy6su@kernel.org> <CAM9d7cjcA0aYC1otY4WvCJ_h71P9wiHu42GK7iyv3=i01rQ26Q@mail.gmail.com>
 <20220423121557.z5gzbqadonmrg6ef@pasture> <CAM9d7cgcx42xD8QxOB+JBEL85mZU_va8FMiF31SRxABH8CakLg@mail.gmail.com>
 <20220426085826.f4jfu4cszbmjlafw@pasture>
In-Reply-To: <20220426085826.f4jfu4cszbmjlafw@pasture>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Tue, 26 Apr 2022 14:28:18 -0700
Message-ID: <CAM9d7cgEh0rGcwJGT3qF28=J8aQdrAa_XMQN=+QjCPvs8mKU6g@mail.gmail.com>
Subject: Re: [PATCHSET v4 next 0/3] perf stat: add user_time and system_time
 tool events
To:     Florian Fischer <florian.fischer@muhq.space>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
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

On Tue, Apr 26, 2022 at 1:58 AM Florian Fischer
<florian.fischer@muhq.space> wrote:
>
> On 25.04.2022 12:06, Namhyung Kim wrote:
> > On Sat, Apr 23, 2022 at 5:16 AM Florian Fischer
> > <florian.fischer@muhq.space> wrote:
> > >
> > > On 22.04.2022 16:52, Namhyung Kim wrote:
> > > > Hello,
> > > >
> > > > On Fri, Apr 22, 2022 at 3:05 PM Arnaldo Carvalho de Melo
> > > > <acme@kernel.org> wrote:
> > > > >
> > > > > Em Wed, Apr 20, 2022 at 12:23:51PM +0200, Florian Fischer escreveu:
> > > > > > This patch series adds new internal events to perf stat exposing the times spend
> > > > > > in user and kernel mode in nanoseconds reported by rusage.
> > > > > >
> > > > > > During some benchmarking using perf it bothered me that I could not easily
> > > > > > retrieve those times from perf stat when using the machine readable output.
> > > > > >
> > > > > > But perf definitely knows about those values because in the human readable output
> > > > > > they are present.
> > > > > >
> > > > > > Therefore I exposed the times reported by rusage via the new tool events:
> > > > > > user_time and system_time.
> > > > > >
> > > > > > This allows to retrieved them in machine-readable output:
> > > > > >
> > > > > > $ ./perf stat -x, -e duration_time,user_time,system_time,cache-misses -- grep -q -r duration_time tools/perf
> > > > > > 72134524,ns,duration_time:u,72134524,100.00,,
> > > > > > 65225000,ns,user_time:u,65225000,100.00,,
> > > > > > 6865000,ns,ssystem_time:u,6865000,100.00,,
> >
> > > > Anyway it looks a little bit strange to me if we can get
> > > > system time in user mode only (the 'u' modifier).
> > >
> > > Sorry but I don't really understand what you mean.
> > > The system_time is reported to userspace via rusage filled by wait4(2).
> > > It will always report the value reported to the user space regardless of what
> > > counters perf has access to.
> > >
> > > If you run perf as user you get the same system_time (but with the ':u' suffix)
> > > as when you run perf as root or lower kernel.perf_event_paranoid to allow access
> > > to more counters.
> >
> > The ':u' modifier means that the event should count only in user mode.
> > So I think system_time:u should be 0 by definition.
> > Likewise, user_time:k should be handled as such.
>
> Not sure if this logic applies to tool events because the time spend in user mode
> or kernel mdoe stays the same regardless of where you count it.
>
> This is consistent with how duration_time works currently in perf stat.
>
> ./perf stat -e duration_time,duration_time:u,duration_time:k -- grep -q -r duration_time .
>
>  Performance counter stats for 'grep -q -r duration_time .':
>
>         29,012,558 ns   duration_time
>         29,012,558 ns   duration_time:u
>         29,012,558 ns   duration_time:k
>
>        0.029012558 seconds time elapsed
>
>        0.029088000 seconds user
>        0.000000000 seconds sys
>
> >
> > But as I said before, we already have the task-clock event, so it's not
> > clear why we need this too.  Also these tool events won't work for
> > other use cases like perf record.
>
> Maybe I do not know enough about perf but I think this is not exactly how those
> suffixes work. This is the output of perf of next-20220420 and my rusage tool
> event patches applied:
>
> $ sysctl kernel.perf_event_paranoid
> kernel.perf_event_paranoid = -1
>
> linux/tools/perf$ ./perf stat -e task-clock,task-clock:u,task-clock:k,\
>                                  duration_time,duration_time:u,duration_time:k,\
>                                  system_time,system_time:u,system_time:k,\
>                                  user_time,user_time:u,user_time:k -- grep -q -r duration_time .
>
>  Performance counter stats for 'grep -q -r duration_time .':
>
>              42.30 msec task-clock                #    0.483 CPUs utilized
>              42.30 msec task-clock:u              #    0.483 CPUs utilized
>              42.30 msec task-clock:k              #    0.483 CPUs utilized
>         87,533,340 ns   duration_time             #    2.069 G/sec
>         87,533,340 ns   duration_time:u           #    2.069 G/sec
>         87,533,340 ns   duration_time:k           #    2.069 G/sec
>         12,841,000 ns   system_time               #  303.547 M/sec
>         12,841,000 ns   system_time:u             #  303.547 M/sec
>         12,841,000 ns   system_time:k             #  303.547 M/sec
>         30,820,000 ns   user_time                 #  728.550 M/sec
>         30,820,000 ns   user_time:u               #  728.550 M/sec
>         30,820,000 ns   user_time:k               #  728.550 M/sec
>
>        0.087533340 seconds time elapsed
>
>        0.030820000 seconds user
>        0.012841000 seconds sys
>
>
> So task-clock regardless of its ':u' or ':k' suffix shows approximately the wall
> clock time.

Ok, now I recall that these software events don't work with modifiers well.
Maybe we should reject or ignore setting modifiers on them.  But that's
a different work, of course.

>
> But for my experiments on a shared system where kernel.perf_event_paranoid is
> not set to -1 and I feel uncomfortable to test research prototypes as root I
> would like a simple and fast way to tell where my program spends its time.
>
> This can be achieved by using user_time and system_time.
> Which are reported in the human readable output anyway.
>
> Maybe I am doing something wrong here but as shown above task-clock does not
> provide the information I am interested in.

No, it's just me making this noise.  Thank you for taking the time to take
a look at the issue.

Thanks,
Namhyung
