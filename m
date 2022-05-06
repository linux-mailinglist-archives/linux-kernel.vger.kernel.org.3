Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821B351CE67
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387787AbiEFBKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 21:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiEFBKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 21:10:47 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCDB5F8F2
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 18:07:06 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t6so8102936wra.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 18:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X5qXtCecZTQByWQ5K3qhS448hcsmS9iI9bFun8j3gT0=;
        b=TY66UqxOS8vH5CwpHnlyhJex/1NI6c7Mvz0MX96Lgs8WXa59lL6Wgo/dZOO0be96tM
         3ZLiGwjapp02BtlttwI+U+FZZTxCYOOJ0zYynWYX1CdZkMe1h6jVgfp4Rgjj6I9/XvDq
         KgFOF059xdfrn9rwJHMs6Ib27ijnnPPJcYtWUUwGfGa3jNj58NqP9fh//loGD/ui88vu
         YBCGcj3angXXTZbRy2oTZrFZsCDI3ntdzK12GYuoTejrnVI8XSRlytr6if6d0KNNeNb2
         PVnEtoF1eptQruTeiptvDAoZc+OPZHg8vo6xQxlBo3pV91/zAIk76TrMOvUq+X60LgAK
         J14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X5qXtCecZTQByWQ5K3qhS448hcsmS9iI9bFun8j3gT0=;
        b=2DyudXiDB1R3yu5gD0NH1+YJ8PQbOCRXni2pJ+3ovaCO8FDDbCG480nuhch296vcgT
         ssfzvey/o4Py3z+tmGKufksSvg6nMmj+va6R9MZUfKBDAAzyjXI4MBNZPUzv6GTY1roL
         Mg7Iok/8PimePd/gpvJFlsXo02Nu/bL2oP4bJ+0+J4t+n1J5HgLV5posgC8c8khbGZNC
         oS8QQRkQDk9w7EnfuVZKf/PmKeoh1L7SEN8xO2ahu/iXcGtVWAVjOBLAFyIV82bGGqoD
         jjIJVA/j39w/kRwYBYVbfnDopoZjnzvcvaFO7/Ityq5Rwg1jtiOuPx+N3juJDVDnQzwz
         HMxw==
X-Gm-Message-State: AOAM5329SSto5UrPxaNRHnH8JPpGVYSuf8dVjqFOZzILDM0yP/1ffiIB
        FsqT5l1dIR/GmiJUMpBHK1cOUWZP+QtmU3B06IH8Gw==
X-Google-Smtp-Source: ABdhPJwvlFXCGALuLTfUxBpiIUaSPpUrvlZYjMTsJMv+82GMrbTqo9lwFYdPeELb4dyf/VdEa+oywYUuwDLwwdULZ4s=
X-Received: by 2002:a05:6000:1f1b:b0:20c:9ea8:b650 with SMTP id
 bv27-20020a0560001f1b00b0020c9ea8b650mr571519wrb.300.1651799224587; Thu, 05
 May 2022 18:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220505165639.361733-1-adrian.hunter@intel.com>
In-Reply-To: <20220505165639.361733-1-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 18:06:50 -0700
Message-ID: <CAP-5=fV1h9dnDYnqBgf5596YQTkNJqd-OKO6qmNG0wxb=tR5TQ@mail.gmail.com>
Subject: Re: [PATCH V1 00/23] perf intel-pt: Better support for perf record --cpu
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
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

On Thu, May 5, 2022 at 9:56 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Hi
>
> Here are V1 patches to support capturing Intel PT sideband events such as
> mmap, task, context switch, text poke etc, on every CPU even when tracing
> selected user_requested_cpus.  That is, when using the perf record -C or
>  --cpu option.
>
> This is needed for:
> 1. text poke: a text poke on any CPU affects all CPUs
> 2. tracing user space: a user space process can migrate between CPUs so
> mmap events that happen on a different CPU can be needed to decode a
> user_requested_cpus CPU.
>
> For example:
>
>         Trace on CPU 1:
>
>         perf record --kcore -C 1 -e intel_pt// &
>
>         Start a task on CPU 0:
>
>         taskset 0x1 testprog &
>
>         Migrate it to CPU 1:
>
>         taskset -p 0x2 <testprog pid>
>
>         Stop tracing:
>
>         kill %1
>
>         Prior to these changes there will be errors decoding testprog
>         in userspace because the comm and mmap events for testprog will not
>         have been captured.
>
> There is quite a bit of preparation:
>
> The first patch is a small Intel PT test for system-wide side band.  The
> test fails before the patches are applied, passed afterwards.
>
>       perf intel-pt: Add a test for system-wide side band [new in V1]
>
> The next 5 patches stop auxtrace mixing up mmap idx between evlist and
> evsel.  That is going to matter when
> evlist->all_cpus != evlist->user_requested_cpus != evsel->cpus:
>
>       libperf evsel: Factor out perf_evsel__ioctl() [now applied]
>       libperf evsel: Add perf_evsel__enable_thread()
>       perf evlist: Use libperf functions in evlist__enable_event_idx()
>       perf auxtrace: Move evlist__enable_event_idx() to auxtrace.c
>       perf auxtrace: Do not mix up mmap idx
>
> The next 6 patches stop attempts to auxtrace mmap when it is not an
> auxtrace event e.g. when mmapping the CPUs on which only sideband is
> captured:
>
>       libperf evlist: Remove ->idx() per_cpu parameter
>       libperf evlist: Move ->idx() into mmap_per_evsel()
>       libperf evlist: Add evsel as a parameter to ->idx()
>       perf auxtrace: Record whether an auxtrace mmap is needed
>       perf auxctrace: Add mmap_needed to auxtrace_mmap_params
>       perf auxtrace: Remove auxtrace_mmap_params__set_idx() per_cpu parameter
>
> The next 5 patches switch to setting up dummy event maps before adding the
> evsel so that the evsel is subject to map propagation, primarily to cause
> addition of the evsel's CPUs to all_cpus.
>
>       perf evlist: Factor out evlist__dummy_event()
>       perf evlist: Add evlist__add_system_wide_dummy()
>       perf record: Use evlist__add_system_wide_dummy() in record__config_text_poke()
>       perf intel-pt: Use evlist__add_system_wide_dummy() for switch tracking
>       perf intel-pt: Track sideband system-wide when needed
>
> The remaining patches make more significant changes.
>
> First change from using user_requested_cpus to using all_cpus where necessary:
>
>       perf tools: Allow all_cpus to be a superset of user_requested_cpus
>
> Secondly, mmap all per-thread and all per-cpu events:
>
>       libperf evlist: Allow mixing per-thread and per-cpu mmaps
>       libperf evlist: Check nr_mmaps is correct [new in V1]
>
> Stop using system_wide flag for uncore because it will not work anymore:
>
>       perf stat: Add requires_cpu flag for uncore
>       libperf evsel: Add comments for booleans [new in V1]
>
> Finally change map propagation so that system-wide events retain their cpus and
> (dummy) threads:
>
>       perf tools: Allow system-wide events to keep their own CPUs
>       perf tools: Allow system-wide events to keep their own threads
>
>
> Changes in V1:
>
>       perf intel-pt: Add a test for system-wide side band
>         New patch
>
>       libperf evsel: Factor out perf_evsel__ioctl()
>         Dropped because it has been applied.
>
>       libperf evsel: Add perf_evsel__enable_thread()
>         Rename variable i -> idx
>
>       perf auxtrace: Do not mix up mmap idx
>         Rename variable cpu to cpu_map_idx
>
>       perf tools: Allow all_cpus to be a superset of user_requested_cpus
>         Add Acked-by: Ian Rogers <irogers@google.com>
>
>       libperf evlist: Allow mixing per-thread and per-cpu mmaps
>         Fix perf_evlist__nr_mmaps() calculation
>
>       libperf evlist: Check nr_mmaps is correct
>         New patch
>
>       libperf evsel: Add comments for booleans
>         New patch
>
>       perf tools: Allow system-wide events to keep their own CPUs
>       perf tools: Allow system-wide events to keep their own threads
>
>
> Adrian Hunter (23):
>       perf intel-pt: Add a test for system-wide side band
>       libperf evsel: Add perf_evsel__enable_thread()
>       perf evlist: Use libperf functions in evlist__enable_event_idx()
>       perf auxtrace: Move evlist__enable_event_idx() to auxtrace.c
>       perf auxtrace: Do not mix up mmap idx
>       libperf evlist: Remove ->idx() per_cpu parameter
>       libperf evlist: Move ->idx() into mmap_per_evsel()
>       libperf evlist: Add evsel as a parameter to ->idx()
>       perf auxtrace: Record whether an auxtrace mmap is needed
>       perf auxtrace: Add mmap_needed to auxtrace_mmap_params
>       perf auxtrace: Remove auxtrace_mmap_params__set_idx() per_cpu parameter
>       perf evlist: Factor out evlist__dummy_event()
>       perf evlist: Add evlist__add_system_wide_dummy()
>       perf record: Use evlist__add_system_wide_dummy() in record__config_text_poke()
>       perf intel-pt: Use evlist__add_system_wide_dummy() for switch tracking
>       perf intel-pt: Track sideband system-wide when needed
>       perf tools: Allow all_cpus to be a superset of user_requested_cpus
>       libperf evlist: Allow mixing per-thread and per-cpu mmaps
>       libperf evlist: Check nr_mmaps is correct
>       perf stat: Add requires_cpu flag for uncore
>       libperf evsel: Add comments for booleans
>       perf tools: Allow system-wide events to keep their own CPUs
>       perf tools: Allow system-wide events to keep their own threads
>
>  tools/lib/perf/evlist.c                  |  80 ++++++++++-------------
>  tools/lib/perf/evsel.c                   |  10 +++
>  tools/lib/perf/include/internal/evlist.h |   3 +-
>  tools/lib/perf/include/internal/evsel.h  |   9 +++
>  tools/lib/perf/include/internal/mmap.h   |   5 ++
>  tools/lib/perf/include/perf/evsel.h      |   1 +
>  tools/perf/arch/arm/util/cs-etm.c        |   1 +
>  tools/perf/arch/arm64/util/arm-spe.c     |   1 +
>  tools/perf/arch/s390/util/auxtrace.c     |   1 +
>  tools/perf/arch/x86/util/intel-bts.c     |   1 +
>  tools/perf/arch/x86/util/intel-pt.c      |  32 ++++------
>  tools/perf/builtin-record.c              |  39 +++++-------
>  tools/perf/builtin-stat.c                |   5 +-
>  tools/perf/tests/shell/test_intel_pt.sh  |  71 +++++++++++++++++++++
>  tools/perf/util/auxtrace.c               |  31 +++++++--
>  tools/perf/util/auxtrace.h               |   8 ++-
>  tools/perf/util/evlist.c                 | 106 +++++++++++++++----------------
>  tools/perf/util/evlist.h                 |   7 +-
>  tools/perf/util/evsel.c                  |   1 +
>  tools/perf/util/evsel.h                  |   1 +
>  tools/perf/util/mmap.c                   |   4 +-
>  tools/perf/util/parse-events.c           |   2 +-
>  22 files changed, 259 insertions(+), 160 deletions(-)
>  create mode 100755 tools/perf/tests/shell/test_intel_pt.sh
>
>
> Regards
> Adrian

Thanks Adrian, other than a minor build breakage, and some possible
function name and comment tweaks, I'm happy with the change. I did
'perf test' on my SkylakeX and things look good too. One last minor
thing is the test_intel_pt.sh doesn't test --per-thread mode, this
might be good to cover for CPU map propagation issues.

Thanks,
Ian
