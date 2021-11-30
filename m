Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD5B462D2C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238852AbhK3G7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:59:17 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:38582 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhK3G7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:59:17 -0500
Received: by mail-lf1-f43.google.com with SMTP id bi37so51161757lfb.5;
        Mon, 29 Nov 2021 22:55:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MHYqAW5YIiOfidkiw0qYSoyiNgaHBHN3qo9wxWi8vVM=;
        b=oPXeQjv4REFagUVzf6iCtXRu9valrDsxh7yKFWQ6wdlVKXuKWUJm2uHGbTMlZm33BL
         s0REqf+OZzCELVnO0Z81sEKktEAHX+0vl35ONPxXGt9Lxh5liAUh/A7XXH7fcZonVenm
         PWgeb3DdbmHWg1hXwhZeFS3SNcbEMolzSa5WNb3AyHIO5zDGfJIjQja4HZR9Abfw9bX0
         UtFLCm3MNR6x1mBk4reNRVgA8BuwSPBPX7+dEOZgYjaLd/h2p5gUSOKelwRI2EC8AEiX
         dMb5KJc0UjtTLVV70miu1uGOBpdx994a8bpJL/aMModKTlwS0OfLMakpiY0fRwH83rHI
         h+SQ==
X-Gm-Message-State: AOAM532RNd7SzjYUIJDCI03gznFDR22zT1a5E+nQZgcL3IzivtRScuwl
        v5Hbt371+S7/SoB9CDqXG1aEiStx5HHn/Lp0WfZii0cw
X-Google-Smtp-Source: ABdhPJwLGt0JPNHhn38ZzvDMyT/AUfoCK06ynaZW0rZpwlKXLIMYcxIyY4vNO/YjjCcFlRweUZqFRc9jxYCKF+OS70Y=
X-Received: by 2002:ac2:5607:: with SMTP id v7mr52301175lfd.71.1638255356843;
 Mon, 29 Nov 2021 22:55:56 -0800 (PST)
MIME-Version: 1.0
References: <20211123020341.3073673-1-irogers@google.com> <20211123020341.3073673-2-irogers@google.com>
 <YaO1FIOYpF/Y5BDK@krava> <CAP-5=fU5MFQAidNWTp0hRjesKpFper6wy9MJ0taL9k804amn6A@mail.gmail.com>
In-Reply-To: <CAP-5=fU5MFQAidNWTp0hRjesKpFper6wy9MJ0taL9k804amn6A@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 29 Nov 2021 22:55:45 -0800
Message-ID: <CAM9d7cgiy4at+Tc1n9xRHNi=icYnurYDtxWJ=BPO-pLV=aVBEA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf evsel: Improve error message for uncore events
To:     Ian Rogers <irogers@google.com>
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

Hi Ian,

On Mon, Nov 29, 2021 at 3:48 PM Ian Rogers <irogers@google.com> wrote:
>
> On Sun, Nov 28, 2021 at 8:58 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Mon, Nov 22, 2021 at 06:03:41PM -0800, Ian Rogers wrote:
> > > When a group has multiple events and the leader fails it can yield
> > > errors like:
> > >
> > > $ perf stat -e '{uncore_imc/cas_count_read/},instructions' /bin/true
> > > Error:
> > > The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (uncore_imc/cas_count_read/).
> > > /bin/dmesg | grep -i perf may provide additional information.
> > >
> > > However, when not the group leader <not supported> is given:
> > >
> > > $ perf stat -e '{instructions,uncore_imc/cas_count_read/}' /bin/true
> > > ...
> > >          1,619,057      instructions
> > >    <not supported> MiB  uncore_imc/cas_count_read/
> > >
> > > This is necessary because get_group_fd will fail if the leader fails and
> > > is the direct result of the check on line 750 of builtin-stat.c in
> > > stat_handle_error that returns COUNTER_SKIP for the latter case.
> > >
> > > This patch improves the error message to:
> > >
> > > $ perf stat -e '{uncore_imc/cas_count_read/},instructions' /bin/true
> > > Error:
> > > Invalid event (uncore_imc/cas_count_read/) in per-thread mode, enable system wide with '-a'.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/evsel.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > index a59fb2ecb84e..48696ff4bddb 100644
> > > --- a/tools/perf/util/evsel.c
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -2950,6 +2950,11 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
> > >                       return scnprintf(msg, size, "wrong clockid (%d).", clockid);
> > >               if (perf_missing_features.aux_output)
> > >                       return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
> > > +             if ((evsel__leader(evsel) == evsel) &&
> > > +                 (evsel->core.leader->nr_members > 1))
> > > +                     return scnprintf(msg, size,
> > > +     "Invalid event (%s) in per-thread mode, enable system wide with '-a'.",
> > > +                                     evsel__name(evsel));
> >
> > should we rather check 'target' pointer for the per-thread mode?
> > I'm not sure that per-thread mode will always be the case for the failure
>
> Unfortunately the target isn't populated at that point:

It might be populated properly, as in this case
it should have no target.  I think you can use
!target__has_cpu().

Thanks,
Namhyung


>
> gdb --args perf stat -e '{uncore_imc/cas_count_write/},instructions' /bin/true
> (gdb) p *target
> $2 = {pid = 0x0, tid = 0x0, cpu_list = 0x0, uid_str = 0x0, bpf_str =
> 0x0, uid = 4294967295, system_wide = false, uses_mmap = false,
>   default_per_cpu = false, per_thread = false, use_bpf = false, hybrid
> = false, attr_map = 0x0}
>
> #0  evsel__open_strerror (evsel=0x616000015680, target=0x5555586aa140
> <target>, err=22, msg=0x7fffffff78d0 "]k\264WUU", size=8192)
>     at util/evsel.c:2857
> #1  0x00005555561744e8 in stat_handle_error (counter=0x616000015680)
> at builtin-stat.c:771
> #2  0x0000555556174f05 in __run_perf_stat (argc=1,
> argv=0x7fffffffe450, run_idx=0) at builtin-stat.c:852
> #3  0x00005555561763e1 in run_perf_stat (argc=1, argv=0x7fffffffe450,
> run_idx=0) at builtin-stat.c:1048
> #4  0x000055555617df82 in cmd_stat (argc=1, argv=0x7fffffffe450) at
> builtin-stat.c:2550
> #5  0x00005555562f36b8 in run_builtin (p=0x5555586bad00
> <commands+288>, argc=4, argv=0x7fffffffe450) at perf.c:313
> #6  0x00005555562f3c11 in handle_internal_command (argc=4,
> argv=0x7fffffffe450) at perf.c:365
> #7  0x00005555562f3fce in run_argv (argcp=0x7fffffffe230,
> argv=0x7fffffffe240) at perf.c:409
> #8  0x00005555562f47bd in main (argc=4, argv=0x7fffffffe450) at perf.c:539
>
> Thanks,
> Ian
>
> > jirka
> >
> > >               break;
> > >       case ENODATA:
> > >               return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
> > > --
> > > 2.34.0.rc2.393.gf8c9666880-goog
> > >
> >
