Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F1253364D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 07:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243904AbiEYFBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 01:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiEYFBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 01:01:17 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BA711C16
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 22:01:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u3so28455884wrg.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 22:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AgaEetNxhbUzH45+svN7VXZ8m0G3zsfmc61oVfq7E4Y=;
        b=HAOB8mGW9zw9XgIkAjDbu2Y62Fho5oUXFcfCLgSYSvy9IE7dVNHjHXC3lwA3UnulD8
         hzdDfiGv9fJ0s0onONmEjEHxGrrEDDrv4uCbBo8ebsqM+O5GlEzrtmigmQ6hR9yniGYf
         wfigJcQXUfDiJt+kqdlDyI9TKLjYR2SETrlsaIs1ar9qrcjeEMpHILx/TjR3tf11yJO/
         rukVQ2ffeYIK19McleUBi0sytBtH4oLKYTtINXbAsB9m8vv0FXAKO9DejY1LNfhANa1W
         0oWqzNqGnmYInkgaYA9dSMC/vKxrbwwJehFj0zL1oNu1yMfatDEWI1WlLEmFlaNeXHmW
         pb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AgaEetNxhbUzH45+svN7VXZ8m0G3zsfmc61oVfq7E4Y=;
        b=j9C2YY0/cyWyVuKWaWoRueFUAC6H2AgcdB1RIRX50VGK6Sic72OTLeSFGMQCA1r71O
         9hfOiAqV7djJm7GNWeBx8HZCw3NmcxQmmS8od37Jlxab7NYdOOjWfr11E/bGeeAuYvZr
         SD2UYgZEuIH2BM7OiAkmp1MCRqikeCsii5Yl49vlz6HzgSby0tp/Z8lwxjAHLLEPNB4O
         cVwch99he7gmIDdMS/onPoLu99cpp8GftK/xCT6iS4te1tf8WGrRS5UvKkWliwU5rZfr
         9sfdaNTXKYNJfzHjjV2LCvSPrQeqLt5TeQ2NR2GA/qFHeXMYsLy3sg60tnsCZByz2rtu
         AGoQ==
X-Gm-Message-State: AOAM532RBbiSLA4gWccb8f7GUK/nwXLgTNGllVjJxavhkOmlCZw9HQ1H
        3PAVbygg66HU+OdmnMVjfrUOw7na5S+DgLVywv/Wpg==
X-Google-Smtp-Source: ABdhPJyoMdh3Rf1vIJsH3v2mZMKJhqiLHOCTr3h0VoAhxABygwZbdYBK+RVse1A7PseCx3IBXGSGh7sIRAr4VPHHNiA=
X-Received: by 2002:a5d:598f:0:b0:20c:83c9:b05b with SMTP id
 n15-20020a5d598f000000b0020c83c9b05bmr25656670wri.343.1653454873762; Tue, 24
 May 2022 22:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220524075436.29144-1-adrian.hunter@intel.com>
In-Reply-To: <20220524075436.29144-1-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 24 May 2022 22:01:01 -0700
Message-ID: <CAP-5=fW3Av3e+LZy_RBWNrMPqYF7OZVf0rOe-upznDrfdeJ1CA@mail.gmail.com>
Subject: Re: [PATCH V4 00/15] perf intel-pt: Better support for perf record --cpu
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

On Tue, May 24, 2022 at 12:55 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Hi
>
> Here are V4 patches to support capturing Intel PT sideband events such as
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
> The next 5 patches (now already applied) stop auxtrace mixing up mmap idx
> between evlist and evsel.  That is going to matter when
> evlist->all_cpus != evlist->user_requested_cpus != evsel->cpus:
>
>       libperf evsel: Factor out perf_evsel__ioctl() [now applied]
>       libperf evsel: Add perf_evsel__enable_thread()
>       perf evlist: Use libperf functions in evlist__enable_event_idx()
>       perf auxtrace: Move evlist__enable_event_idx() to auxtrace.c
>       perf auxtrace: Do not mix up mmap idx
>
> The next 6 patches (first 4 now already applied) stop attempts to auxtrace
> mmap when it is not an auxtrace event e.g. when mmapping the CPUs on which
> only sideband is captured:
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
> Changes in V4:
>
>       Added Acked-by: Namhyung Kim <namhyung@kernel.org>
>       Added a couple Acked-by: Ian Rogers <irogers@google.com>

Would love to see this merged Arnaldo, I can do an:

Acked-by: Ian Rogers <irogers@google.com>

in case it helps you with b4 a little :-)

Thanks,
Ian

>       perf intel-pt: Add a test for system-wide side band
>         Put in commit message that test succeeds only after other
>         patches applied
>
>       libperf evsel: Add perf_evsel__enable_thread()
>       perf evlist: Use libperf functions in evlist__enable_event_idx()
>       perf auxtrace: Move evlist__enable_event_idx() to auxtrace.c
>       perf auxtrace: Do not mix up mmap idx
>       libperf evlist: Remove ->idx() per_cpu parameter
>       libperf evlist: Move ->idx() into mmap_per_evsel()
>       libperf evlist: Add evsel as a parameter to ->idx()
>       perf auxtrace: Record whether an auxtrace mmap is needed
>         Omitted because already applied
>
>       libperf evsel: Add comments for booleans
>         Amended comment about own_cpus
>
>
> Changes in V3:
>
>       perf auxtrace: Add mmap_needed to auxtrace_mmap_params
>         Amended mmap_needed comment
>
>       perf evlist: Add evlist__add_dummy_on_all_cpus()
>         Amended comment about all CPUs.
>
>
> Changes in V2:
>
>       Added some Acked-by: Ian Rogers <irogers@google.com>
>
>       libperf evsel: Add perf_evsel__enable_thread()
>         Use perf_cpu_map__for_each_cpu()
>
>       perf auxtrace: Add mmap_needed to auxtrace_mmap_params
>         Add documentation comment for mmap_needed
>
>       perf auxtrace: Remove auxtrace_mmap_params__set_idx() per_cpu parameter
>         Fix missing auxtrace_mmap_params__set_idx change
>
>       libperf evlist: Check nr_mmaps is correct
>         Remove unused code
>
>       libperf evsel: Add comments for booleans
>         Amend comments
>
>       perf evlist: Add evlist__add_dummy_on_all_cpus()
>         Rename evlist__add_system_wide -> evlist__add_on_all_cpus
>         Changed patch subject accordingly
>
>       perf record: Use evlist__add_dummy_on_all_cpus() in record__config_text_poke()
>         Rename evlist__add_system_wide -> evlist__add_on_all_cpus
>         Changed patch subject accordingly
>
>       perf intel-pt: Use evlist__add_dummy_on_all_cpus() for switch tracking
>         Rename evlist__add_system_wide -> evlist__add_on_all_cpus
>         Changed patch subject accordingly
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
> Adrian Hunter (15):
>       perf intel-pt: Add a test for system-wide side band
>       perf auxtrace: Add mmap_needed to auxtrace_mmap_params
>       perf auxtrace: Remove auxtrace_mmap_params__set_idx() per_cpu parameter
>       perf evlist: Factor out evlist__dummy_event()
>       perf evlist: Add evlist__add_dummy_on_all_cpus()
>       perf record: Use evlist__add_dummy_on_all_cpus() in record__config_text_poke()
>       perf intel-pt: Use evlist__add_dummy_on_all_cpus() for switch tracking
>       perf intel-pt: Track sideband system-wide when needed
>       perf tools: Allow all_cpus to be a superset of user_requested_cpus
>       libperf evlist: Allow mixing per-thread and per-cpu mmaps
>       libperf evlist: Check nr_mmaps is correct
>       perf stat: Add requires_cpu flag for uncore
>       libperf evsel: Add comments for booleans
>       perf tools: Allow system-wide events to keep their own CPUs
>       perf tools: Allow system-wide events to keep their own threads
>
>  tools/lib/perf/evlist.c                 | 71 ++++++++++++++-------------------
>  tools/lib/perf/include/internal/evsel.h | 11 +++++
>  tools/perf/arch/x86/util/intel-pt.c     | 31 ++++++--------
>  tools/perf/builtin-record.c             | 39 +++++++-----------
>  tools/perf/builtin-stat.c               |  5 +--
>  tools/perf/tests/shell/test_intel_pt.sh | 71 +++++++++++++++++++++++++++++++++
>  tools/perf/util/auxtrace.c              | 15 +++++--
>  tools/perf/util/auxtrace.h              | 13 ++++--
>  tools/perf/util/evlist.c                | 61 +++++++++++++++++++++++++---
>  tools/perf/util/evlist.h                |  5 +++
>  tools/perf/util/evsel.c                 |  1 +
>  tools/perf/util/mmap.c                  |  4 +-
>  tools/perf/util/parse-events.c          |  2 +-
>  13 files changed, 226 insertions(+), 103 deletions(-)
>  create mode 100755 tools/perf/tests/shell/test_intel_pt.sh
>
>
> Regards
> Adrian
