Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CA3462E10
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 08:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbhK3IA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 03:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239324AbhK3IAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:00:51 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D65C061748
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 23:57:32 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id p65so869964iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 23:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ANwdMOL5b2y3RX/fmlScMbR5sfXgdjPAWQRFJ08uvUw=;
        b=plZJO0HRqe+GhQPlFiNUiQ4FmsS/vSGPcixliMx+8yRfacPCCYr2hVJosl/YY1iBMy
         N6HqRFQM+Hs5YUOMvuita6QtneqC2rJoogozkt8is2EBx4g/zBeoh4dtM5GQtpLzGGsD
         fa2ZzrNTvje+TusQQUFyNs4FIAZQa9dmR4FrFv2hU6xxWqnz8+IkjJU5VyQIdzF9Prjp
         D2s18S7IUbddmxz2DA8V418O6BEWY3Y4HvhHM/FTRkF9CsPXhfy8RAui2MvMkeXQ/qw0
         p0kKA6qPjMk49D/k2sCr4w4nyxKxLRoV6PHZc6Zbt5HIPRJHIshNbsRyjjAlzpsh3rpd
         yysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ANwdMOL5b2y3RX/fmlScMbR5sfXgdjPAWQRFJ08uvUw=;
        b=pWdBHnvpFCcRQCNvdds7XfSE69erIaESY2TuFkJrcr4JqVU2OQ/Jr+LktjBK+z2eZi
         QLq7Rz9hBPnGNSVu9AP/sYd24N5QC/+ZeIIbifLsVJMZ2ou7G+EIeDV/Cox9fp8Aden9
         Zxx4IRbQ2MK8MMM0sHxmg/qzc1C4ZAyAG3CYVz4YkWcN8l+6ohOKxYtIGCrjizaNhnRm
         xYUmACOPKvBKtW45AybZvvRNfikebJ+RQESYysUPxh+z1Yy1XWccNhcbRBNhJshDEYEa
         oEpFVaO1tfvyXYA3y9l9IhIpXvKc9kXTUXv0JbOBAfVww5p2Sej5ybwB/+1qvH89rnP2
         oRxQ==
X-Gm-Message-State: AOAM530+oaimT5Qv51nt1f/CnBmdhuZgFNGfC9FHZQ0Q/NGibNCj6gLc
        Cc/lutjXT0au9OCzi6APYj1ZCOMh8G5VyoNNa9TnvQ==
X-Google-Smtp-Source: ABdhPJxjBF0LZNIDXFuDLc4mx/wWydE35Z6CuXhkYqD4OllkmOmYjOjnmpo1wl+xa/eAPu9mH/7jNh7DCFZcSnB9nps=
X-Received: by 2002:a05:6638:144f:: with SMTP id l15mr70873142jad.21.1638259051695;
 Mon, 29 Nov 2021 23:57:31 -0800 (PST)
MIME-Version: 1.0
References: <20211123020341.3073673-1-irogers@google.com> <20211123020341.3073673-2-irogers@google.com>
 <YaO1FIOYpF/Y5BDK@krava> <CAP-5=fU5MFQAidNWTp0hRjesKpFper6wy9MJ0taL9k804amn6A@mail.gmail.com>
 <CAM9d7cgiy4at+Tc1n9xRHNi=icYnurYDtxWJ=BPO-pLV=aVBEA@mail.gmail.com>
In-Reply-To: <CAM9d7cgiy4at+Tc1n9xRHNi=icYnurYDtxWJ=BPO-pLV=aVBEA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 29 Nov 2021 23:57:19 -0800
Message-ID: <CAP-5=fUYO2ebkQ_1=Wn50MouymbJ4DFHogG-JcM-XT4uaD-CGw@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf evsel: Improve error message for uncore events
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 10:55 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Ian,
>
> On Mon, Nov 29, 2021 at 3:48 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Sun, Nov 28, 2021 at 8:58 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Mon, Nov 22, 2021 at 06:03:41PM -0800, Ian Rogers wrote:
> > > > When a group has multiple events and the leader fails it can yield
> > > > errors like:
> > > >
> > > > $ perf stat -e '{uncore_imc/cas_count_read/},instructions' /bin/true
> > > > Error:
> > > > The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (uncore_imc/cas_count_read/).
> > > > /bin/dmesg | grep -i perf may provide additional information.
> > > >
> > > > However, when not the group leader <not supported> is given:
> > > >
> > > > $ perf stat -e '{instructions,uncore_imc/cas_count_read/}' /bin/true
> > > > ...
> > > >          1,619,057      instructions
> > > >    <not supported> MiB  uncore_imc/cas_count_read/
> > > >
> > > > This is necessary because get_group_fd will fail if the leader fails and
> > > > is the direct result of the check on line 750 of builtin-stat.c in
> > > > stat_handle_error that returns COUNTER_SKIP for the latter case.
> > > >
> > > > This patch improves the error message to:
> > > >
> > > > $ perf stat -e '{uncore_imc/cas_count_read/},instructions' /bin/true
> > > > Error:
> > > > Invalid event (uncore_imc/cas_count_read/) in per-thread mode, enable system wide with '-a'.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/util/evsel.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > > index a59fb2ecb84e..48696ff4bddb 100644
> > > > --- a/tools/perf/util/evsel.c
> > > > +++ b/tools/perf/util/evsel.c
> > > > @@ -2950,6 +2950,11 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
> > > >                       return scnprintf(msg, size, "wrong clockid (%d).", clockid);
> > > >               if (perf_missing_features.aux_output)
> > > >                       return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
> > > > +             if ((evsel__leader(evsel) == evsel) &&
> > > > +                 (evsel->core.leader->nr_members > 1))
> > > > +                     return scnprintf(msg, size,
> > > > +     "Invalid event (%s) in per-thread mode, enable system wide with '-a'.",
> > > > +                                     evsel__name(evsel));
> > >
> > > should we rather check 'target' pointer for the per-thread mode?
> > > I'm not sure that per-thread mode will always be the case for the failure
> >
> > Unfortunately the target isn't populated at that point:
>
> It might be populated properly, as in this case
> it should have no target.  I think you can use
> !target__has_cpu().

Thanks :-) I'm not sure having !target__has_cpu is intention
revealing. Perhaps changing the error to say that an
invalid/unsupported event can't be the group leader, unless it is the
only event, and then suggest system wide mode.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> >
> > gdb --args perf stat -e '{uncore_imc/cas_count_write/},instructions' /bin/true
> > (gdb) p *target
> > $2 = {pid = 0x0, tid = 0x0, cpu_list = 0x0, uid_str = 0x0, bpf_str =
> > 0x0, uid = 4294967295, system_wide = false, uses_mmap = false,
> >   default_per_cpu = false, per_thread = false, use_bpf = false, hybrid
> > = false, attr_map = 0x0}
> >
> > #0  evsel__open_strerror (evsel=0x616000015680, target=0x5555586aa140
> > <target>, err=22, msg=0x7fffffff78d0 "]k\264WUU", size=8192)
> >     at util/evsel.c:2857
> > #1  0x00005555561744e8 in stat_handle_error (counter=0x616000015680)
> > at builtin-stat.c:771
> > #2  0x0000555556174f05 in __run_perf_stat (argc=1,
> > argv=0x7fffffffe450, run_idx=0) at builtin-stat.c:852
> > #3  0x00005555561763e1 in run_perf_stat (argc=1, argv=0x7fffffffe450,
> > run_idx=0) at builtin-stat.c:1048
> > #4  0x000055555617df82 in cmd_stat (argc=1, argv=0x7fffffffe450) at
> > builtin-stat.c:2550
> > #5  0x00005555562f36b8 in run_builtin (p=0x5555586bad00
> > <commands+288>, argc=4, argv=0x7fffffffe450) at perf.c:313
> > #6  0x00005555562f3c11 in handle_internal_command (argc=4,
> > argv=0x7fffffffe450) at perf.c:365
> > #7  0x00005555562f3fce in run_argv (argcp=0x7fffffffe230,
> > argv=0x7fffffffe240) at perf.c:409
> > #8  0x00005555562f47bd in main (argc=4, argv=0x7fffffffe450) at perf.c:539
> >
> > Thanks,
> > Ian
> >
> > > jirka
> > >
> > > >               break;
> > > >       case ENODATA:
> > > >               return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
> > > > --
> > > > 2.34.0.rc2.393.gf8c9666880-goog
> > > >
> > >
