Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085A746288E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhK2Xvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbhK2Xvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:51:37 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FD7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 15:48:19 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id a11so18976272ilj.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 15:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zp15zRundB/Hha02wZX4a60zrBKiLIyu7v5URoolVVM=;
        b=fcx5mF/00Z0YicmJ73Lh2DvEw9G7dVYuY45un3tlQU5WwjCBsfktmHoLkhX5EDDlPl
         oa0KBldjkp92Coxjcv1hobCAeghCDimjUXtq91eaC3iFfX7wuwKPcNxRyNquUoqCbacC
         VaAhJSKu3jeWtjpn1vZ2ri/nKyVXt5OBS1jnSKnlH/5fxsrDRUg/Ec/Mwne9kQBM+KRf
         2DFbIEEjWFWbqJ9yyTnWoZls+yIOCYaOHiv05xJlRo281l1DmvY6Q12TDK1V6EusAFXJ
         bgOLgIa9Xr13jGLV+4iG7IN+4LbShw3BE09AfdwUd17aNBE/vFljSVXhFg/iUSeA6+Ef
         fJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zp15zRundB/Hha02wZX4a60zrBKiLIyu7v5URoolVVM=;
        b=nAITuGFFvrOkMWNVCiVULWK6gB+6E88M6COpvJWwvVGDXU2iTBlbrdP8Kq3VJwTkkX
         atmivwFArvGke+qFULTG+LBt1ioo2gH5NwPviypfsBDy89BdLOoZuEmpcic9UNzVRTXs
         eW0TDI4sdWw8jDZyyGu+8+V08FsxnhAhKY3ce+5s9Q0z1md9OpA+YqxFre8bXVT+crBV
         A6f1bqFBv2W1NZPyly+Lhr/+qXKXSQPCxqyH8lKGOdT0Vd/cBccOcY3xKi9qzDkxWzrj
         8ovfjHjwE1kNrldqDquk2o9jgkC/gwci/Fbt/vqkTvrfhrUa2f31dIMOX+aVBOT2isin
         GA9w==
X-Gm-Message-State: AOAM530VbcKzYqcMrXPY5U0Q2MgkdIDCgTH4hlwh+fceYXttsDWIJBi5
        yKPJ9JRfwxyNLM+PfDdFCJZ3LIm3V0IzU53LRG/E/Q==
X-Google-Smtp-Source: ABdhPJySalFBc/rMmzKvvFyj+waGeAoRaOeSShWAl3OZmvdyBYPbnivFX/jc1FleWGk6HBna6KisP3IgpuuXsMHs97E=
X-Received: by 2002:a05:6e02:f51:: with SMTP id y17mr38037345ilj.2.1638229698614;
 Mon, 29 Nov 2021 15:48:18 -0800 (PST)
MIME-Version: 1.0
References: <20211123020341.3073673-1-irogers@google.com> <20211123020341.3073673-2-irogers@google.com>
 <YaO1FIOYpF/Y5BDK@krava>
In-Reply-To: <YaO1FIOYpF/Y5BDK@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 29 Nov 2021 15:48:04 -0800
Message-ID: <CAP-5=fU5MFQAidNWTp0hRjesKpFper6wy9MJ0taL9k804amn6A@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf evsel: Improve error message for uncore events
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2021 at 8:58 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Nov 22, 2021 at 06:03:41PM -0800, Ian Rogers wrote:
> > When a group has multiple events and the leader fails it can yield
> > errors like:
> >
> > $ perf stat -e '{uncore_imc/cas_count_read/},instructions' /bin/true
> > Error:
> > The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (uncore_imc/cas_count_read/).
> > /bin/dmesg | grep -i perf may provide additional information.
> >
> > However, when not the group leader <not supported> is given:
> >
> > $ perf stat -e '{instructions,uncore_imc/cas_count_read/}' /bin/true
> > ...
> >          1,619,057      instructions
> >    <not supported> MiB  uncore_imc/cas_count_read/
> >
> > This is necessary because get_group_fd will fail if the leader fails and
> > is the direct result of the check on line 750 of builtin-stat.c in
> > stat_handle_error that returns COUNTER_SKIP for the latter case.
> >
> > This patch improves the error message to:
> >
> > $ perf stat -e '{uncore_imc/cas_count_read/},instructions' /bin/true
> > Error:
> > Invalid event (uncore_imc/cas_count_read/) in per-thread mode, enable system wide with '-a'.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/evsel.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index a59fb2ecb84e..48696ff4bddb 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -2950,6 +2950,11 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
> >                       return scnprintf(msg, size, "wrong clockid (%d).", clockid);
> >               if (perf_missing_features.aux_output)
> >                       return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
> > +             if ((evsel__leader(evsel) == evsel) &&
> > +                 (evsel->core.leader->nr_members > 1))
> > +                     return scnprintf(msg, size,
> > +     "Invalid event (%s) in per-thread mode, enable system wide with '-a'.",
> > +                                     evsel__name(evsel));
>
> should we rather check 'target' pointer for the per-thread mode?
> I'm not sure that per-thread mode will always be the case for the failure

Unfortunately the target isn't populated at that point:

gdb --args perf stat -e '{uncore_imc/cas_count_write/},instructions' /bin/true
(gdb) p *target
$2 = {pid = 0x0, tid = 0x0, cpu_list = 0x0, uid_str = 0x0, bpf_str =
0x0, uid = 4294967295, system_wide = false, uses_mmap = false,
  default_per_cpu = false, per_thread = false, use_bpf = false, hybrid
= false, attr_map = 0x0}

#0  evsel__open_strerror (evsel=0x616000015680, target=0x5555586aa140
<target>, err=22, msg=0x7fffffff78d0 "]k\264WUU", size=8192)
    at util/evsel.c:2857
#1  0x00005555561744e8 in stat_handle_error (counter=0x616000015680)
at builtin-stat.c:771
#2  0x0000555556174f05 in __run_perf_stat (argc=1,
argv=0x7fffffffe450, run_idx=0) at builtin-stat.c:852
#3  0x00005555561763e1 in run_perf_stat (argc=1, argv=0x7fffffffe450,
run_idx=0) at builtin-stat.c:1048
#4  0x000055555617df82 in cmd_stat (argc=1, argv=0x7fffffffe450) at
builtin-stat.c:2550
#5  0x00005555562f36b8 in run_builtin (p=0x5555586bad00
<commands+288>, argc=4, argv=0x7fffffffe450) at perf.c:313
#6  0x00005555562f3c11 in handle_internal_command (argc=4,
argv=0x7fffffffe450) at perf.c:365
#7  0x00005555562f3fce in run_argv (argcp=0x7fffffffe230,
argv=0x7fffffffe240) at perf.c:409
#8  0x00005555562f47bd in main (argc=4, argv=0x7fffffffe450) at perf.c:539

Thanks,
Ian

> jirka
>
> >               break;
> >       case ENODATA:
> >               return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
> > --
> > 2.34.0.rc2.393.gf8c9666880-goog
> >
>
