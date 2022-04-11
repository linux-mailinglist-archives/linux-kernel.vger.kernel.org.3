Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B2F4FC0B6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345224AbiDKPcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244647AbiDKPcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:32:00 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6A623BF2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:29:45 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id g18so7329617wrb.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XGNIRWliO2h0rV5PJMq5A+wGOUta4TqvuZt8zvkwu8U=;
        b=TpHauy7PnsdLuuoGkLIj6iiH+z0/m2Rs/b15ngcsmm/hRwGVcrC3imcH4EQMHmqNCD
         TthqDhpL4cL1zHuRq1OXllmEvH8Pk9QfRXe54AzlFpBpcW7pC0MEeIgE1FrOFwDLkpul
         seLjX+n7fLZJ8VZv+lDLJXetTqMKg8chqckgAM/tAP95+DvG507REoAH5x0kkSRFVYcv
         2G8YxOFElb7sa6gVYzEY4hFUFMdOcE8442RBWFqIqLCtFKG8MkktKaOBZuihIwZMjgZC
         LIlj24AA3KmyNezXVp6t4rK4JALr0+bsbr1ikVHr5S6t9piQbddklZuaSlZMeNO0xWFe
         ZISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGNIRWliO2h0rV5PJMq5A+wGOUta4TqvuZt8zvkwu8U=;
        b=DrxFvQUdMTo56/nTAOtVhOpJJyJD4Q0Vx8/xfY48Hw39Zo/OIwfAWvDmuN3Iu2PdAa
         //lzuRz7ovKk7tiZYVztwiKUwletCf5/H5SX+tBVQdCWrmJZwsTLN9NiKv00BGWz3Q7I
         HXViaCCObB+n5ElWUZ0+uJEeQ27tCtRLeLYNuYoGE/EClxcAoFV6LrzMg+VPQVq5wGnI
         eGngKHq91q5e31wqA7zxC29bUzdvjdKaHWnEhqEY76aG1KzmfWljvkfmJP6DGihCcIb8
         W7vn1atOvRbLdpXv92xNJz0USQFVZkRC4168hW2lY6JH9RPmUkzcRffol8YkbA0IPtfG
         NJgQ==
X-Gm-Message-State: AOAM533kKDglofk5HbTb07zR/gK5rtPv0TNKBK7oR6ahL/ECRFEOP56t
        Yzd39EY6kW8NFg2PQ2QU0VFOd5MbPTQaETTjShb1eg==
X-Google-Smtp-Source: ABdhPJyvWXyQyxMKgjcPcX5Czb41yXvstd8O/7lilCQ0wJLap9p1elt+zFg/coXZrQRfng4blMF+eucPkgzZiOCg2RY=
X-Received: by 2002:a5d:6241:0:b0:207:ac0e:3549 with SMTP id
 m1-20020a5d6241000000b00207ac0e3549mr1040376wrv.343.1649690982963; Mon, 11
 Apr 2022 08:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <69656438-8b9a-000b-0702-02dc480639f9@linux.intel.com>
 <20220407085721.3289414-1-florian.fischer@muhq.space> <20220407085721.3289414-3-florian.fischer@muhq.space>
 <CAP-5=fWC5e9PTs9PVttVDdNbCzYQVeqyuf95q181Vkg4NqJxqg@mail.gmail.com> <20220410164136.bxqtpbrmfbqxdx4n@pasture>
In-Reply-To: <20220410164136.bxqtpbrmfbqxdx4n@pasture>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 11 Apr 2022 08:29:30 -0700
Message-ID: <CAP-5=fXuR2tK_4FDnRA88a9wQkndbqyeN6G2muppaMhV5mAQ=A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] perf stat: add rusage utime and stime events
To:     Florian Fischer <florian.fischer@muhq.space>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Florian Schmaus <flow@cs.fau.de>
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

On Sun, Apr 10, 2022 at 9:41 AM Florian Fischer
<florian.fischer@muhq.space> wrote:
>
> > > This patch adds two new tool internal events 'rusage_user_time'
> > > and 'rusage_system_time' as well as their aliases 'ru_utime' and
> > > 'ru_stime', similarly to the already present 'duration_time' event.
> > >
> > > Both events use the already collected rusage information obtained by wait4
> > > and tracked in the global ru_stats.
> > >
> > > Examples presenting cache-misses and rusage information in both human and
> > > machine-readable form:
> > >
> > > $ ./perf stat -e duration_time,ru_utime,ru_stime,cache-misses -- grep -q -r duration_time .
> > >
> > >  Performance counter stats for 'grep -q -r duration_time .':
> > >
> > >         67,422,542 ns   duration_time:u
> > >         50,517,000 ns   ru_utime:u
> > >         16,839,000 ns   ru_stime:u
> > >             30,937      cache-misses:u
> > >
> > >        0.067422542 seconds time elapsed
> > >
> > >        0.050517000 seconds user
> > >        0.016839000 seconds sys
> > >
> > > $ ./perf stat -x, -e duration_time,ru_utime,ru_stime,cache-misses -- grep -q -r duration_time .
> > > 72134524,ns,duration_time:u,72134524,100.00,,
> > > 65225000,ns,ru_utime:u,65225000,100.00,,
> > > 6865000,ns,ru_stime:u,6865000,100.00,,
> > > 38705,,cache-misses:u,71189328,100.00,,
> >
> > This is really nice. For metric code we currently handle duration_time
> > in a special way, for example:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/metricgroup.c?h=perf/core#n745
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/metricgroup.c?h=perf/core#n1131
> > We will need to do something similar with these tool events, but I'm
> > happy that it can be follow-up work.
> >
> > I'm not a huge fan of the names ru_utime and ru_stime, two thoughts
> > here we could do duration_time:u and duration_time:k but I don't think
> > that really makes sense. My preference would be to just call ru_utime
> > user_time and ru_stime system_time.
>
> I considered ru_{u,s}_time only as aliases because those are the field names in
> the rusage struct filled by wait4 and are probably known by perf users.
> The "official" names are currently rusage_{user,system}_time.
> I could change them to only {user,system}_time because those names are more in line
> with the already present duration_time and are independent of the rusage
> implementation detail.
>
> What do you think of?

I like user_time and system_time, short and to the point [1] while
satisfying being intention-revealing. The aliases, ru_utime and
ru_stime, are fine but a bit of an acronym soup. They mean we need to
special case more names in the metric code. I don't know how others
feel but I'd stick to just user_time and system_time.

Thanks,
Ian


[1] https://www.kernel.org/doc/html/v4.10/process/coding-style.html#naming

> ---
>  tools/perf/util/parse-events.c | 4 ++--
>  tools/perf/util/parse-events.l | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index c232ab79d434..afcba6671748 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -160,11 +160,11 @@ struct event_symbol event_symbols_tool[PERF_TOOL_LAST] = {
>                 .alias  = "",
>         },
>         [PERF_TOOL_RU_UTIME] = {
> -               .symbol = "rusage_user_time",
> +               .symbol = "user_time",
>                 .alias  = "ru_utime",
>         },
>         [PERF_TOOL_RU_STIME] = {
> -               .symbol = "rusage_system_time",
> +               .symbol = "system_time",
>                 .alias  = "ru_stime",
>         },
>  };
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index 3c7227b8035c..7ee8613b6011 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -353,8 +353,8 @@ alignment-faults                            { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_AL
>  emulation-faults                               { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_EMULATION_FAULTS); }
>  dummy                                          { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_DUMMY); }
>  duration_time                                  { return tool(yyscanner, PERF_TOOL_DURATION_TIME); }
> -rusage_user_time|ru_utime      { return tool(yyscanner, PERF_TOOL_RU_UTIME); }
> -rusage_system_time|ru_stime    { return tool(yyscanner, PERF_TOOL_RU_STIME); }
> +user_time|ru_utime     { return tool(yyscanner, PERF_TOOL_RU_UTIME); }
> +system_time|ru_stime   { return tool(yyscanner, PERF_TOOL_RU_STIME); }
>  bpf-output                                     { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUTPUT); }
>  cgroup-switches                                        { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CGROUP_SWITCHES); }
>
> --
> 2.35.1
>
> Florian Fischer
