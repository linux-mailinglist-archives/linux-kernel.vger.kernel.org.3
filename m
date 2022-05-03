Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D959518BF1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241059AbiECSNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbiECSNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:13:16 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EF23EAB1
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:09:43 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id u205so17227442vsu.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 11:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M8nY19u4veOpo6Bxv0M47ojfyeOfPUMIsmBfYZ+FyzU=;
        b=FxwJrBTP5gth5vjkfbyk/kOOebvrVjl4f928LwhFUhDnq1z6k1q8zcZwpjExRHjLDB
         VAxx9ktRfLqf6nap2v1PJsvolaaXas4G1Vw7bENJ8666FZa+KahKgjBon1+zUH4y+Vvr
         6g0AYK5RWQh1yPsN5Fss/eNFtAAnKjyQn6G0r0OU8G2cZivMaPZa2awqu7n1gOeiVKgP
         A03cf6DkmlA50FYwovCer8G8OBed8NBY96YDHFfR6ZjU7XpBPE0x3vETtGF99RGKL5ZV
         GvdyX+LAMgIzgnSlpPZP2+RJLo1mPnYbPWWzZO4zHU0JayiqXy9oSbop1vETOYmBwoZl
         ujvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M8nY19u4veOpo6Bxv0M47ojfyeOfPUMIsmBfYZ+FyzU=;
        b=XTc9ElxiCtHzmwBzZk/Vejq2RJw4qzYa+oBMCrXB6v/q2CiXgPr3lg8Ecm1cUcnqwr
         mmpuaBD0wA7fkBI9dex4+42vL4ZAyh4SAazBuiRbP4Dr/O2C3ar+ndiwc84PgBxVIXRB
         KXAGQswQQOGItPe/z6pXvr1OSAGwiyS01cQqAeyFHfOrx5gYV2GOiXz26Hixn1qLIgFp
         WjhUzbI908vGc9vvA3nDXqg9w1UxdmqjeKl6v5Qnn9vQ3TBMk9diTbqtyntpRlm+9VL3
         VR9vZ4bM/sgIazU6XIVEpIWVzepqZJ4ncygbWGcXW4zq6HqMMGxn5KXRqXSynxd0HD1F
         z2sw==
X-Gm-Message-State: AOAM532vZpJrj6Bha7F+8e9iFGiPi8WrBnX0YWemWIFqgMNrJf6AsviC
        idkA/0NWz0CRSPbv3TbwvY4JLX+buKlGfWux1E1HYQ==
X-Google-Smtp-Source: ABdhPJxpIW3ejOW0FbBRaJ2iZvjl6KlHzBjfy6XcnIffQA7XHgJzbOCQ+yd/N/qTtcfu5ScTLho8ER/8p5XWGbiha4U=
X-Received: by 2002:a67:df11:0:b0:32c:ba04:cf9a with SMTP id
 s17-20020a67df11000000b0032cba04cf9amr5698621vsk.18.1651601381903; Tue, 03
 May 2022 11:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220422162402.147958-1-adrian.hunter@intel.com>
In-Reply-To: <20220422162402.147958-1-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 3 May 2022 11:09:30 -0700
Message-ID: <CAP-5=fUHJqRhB4sf0WUUVWcJUDPi0EE93PKQ8ur0S00odwZWzQ@mail.gmail.com>
Subject: Re: [PATCH RFC 00/21] perf intel-pt: Better support for perf record --cpu
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

On Fri, Apr 22, 2022 at 9:24 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Hi
>
> Here are patches to support capturing Intel PT sideband events such as
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
> The first 5 patches stop auxtrace mixing up mmap idx between evlist and
> evsel.  That is going to matter when
> evlist->all_cpus != evlist->user_requested_cpus != evsel->cpus:
>
>       libperf evsel: Factor out perf_evsel__ioctl()
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
> The remaining 5 patches make more significant changes.
>
> First change from using user_requested_cpus to using all_cpus where necessary:
>
>       perf tools: Allow all_cpus to be a superset of user_requested_cpus
>
> Secondly, mmap all per-thread and all per-cpu events:
>
>       libperf evlist: Allow mixing per-thread and per-cpu mmaps
>
> Stop using system_wide flag for uncore because it will not work anymore:
>
>       perf stat: Add per_cpu_only flag for uncore
>
> Finally change map propagation so that system-wide events retain their cpus and
> (dummy) threads:
>
>       perf tools: Allow system-wide events to keep their own CPUs
>       perf tools: Allow system-wide events to keep their own threads
>
>
> Adrian Hunter (21):
>       libperf evsel: Factor out perf_evsel__ioctl()
>       libperf evsel: Add perf_evsel__enable_thread()
>       perf evlist: Use libperf functions in evlist__enable_event_idx()
>       perf auxtrace: Move evlist__enable_event_idx() to auxtrace.c
>       perf auxtrace: Do not mix up mmap idx
>       libperf evlist: Remove ->idx() per_cpu parameter
>       libperf evlist: Move ->idx() into mmap_per_evsel()
>       libperf evlist: Add evsel as a parameter to ->idx()
>       perf auxtrace: Record whether an auxtrace mmap is needed
>       perf auxctrace: Add mmap_needed to auxtrace_mmap_params
>       perf auxtrace: Remove auxtrace_mmap_params__set_idx() per_cpu parameter
>       perf evlist: Factor out evlist__dummy_event()
>       perf evlist: Add evlist__add_system_wide_dummy()
>       perf record: Use evlist__add_system_wide_dummy() in record__config_text_poke()
>       perf intel-pt: Use evlist__add_system_wide_dummy() for switch tracking
>       perf intel-pt: Track sideband system-wide when needed
>       perf tools: Allow all_cpus to be a superset of user_requested_cpus
>       libperf evlist: Allow mixing per-thread and per-cpu mmaps
>       perf stat: Add per_cpu_only flag for uncore
>       perf tools: Allow system-wide events to keep their own CPUs
>       perf tools: Allow system-wide events to keep their own threads
>
>  tools/lib/perf/evlist.c                  |  67 +++++++------------
>  tools/lib/perf/evsel.c                   |  29 +++++++--
>  tools/lib/perf/include/internal/evlist.h |   3 +-
>  tools/lib/perf/include/internal/evsel.h  |   1 +
>  tools/lib/perf/include/perf/evsel.h      |   1 +
>  tools/perf/arch/arm/util/cs-etm.c        |   1 +
>  tools/perf/arch/arm64/util/arm-spe.c     |   1 +
>  tools/perf/arch/s390/util/auxtrace.c     |   1 +
>  tools/perf/arch/x86/util/intel-bts.c     |   1 +
>  tools/perf/arch/x86/util/intel-pt.c      |  32 ++++------
>  tools/perf/builtin-record.c              |  39 +++++-------
>  tools/perf/builtin-stat.c                |   5 +-
>  tools/perf/util/auxtrace.c               |  31 +++++++--
>  tools/perf/util/auxtrace.h               |   8 ++-
>  tools/perf/util/evlist.c                 | 106 +++++++++++++++----------------
>  tools/perf/util/evlist.h                 |   7 +-
>  tools/perf/util/evsel.c                  |   1 +
>  tools/perf/util/evsel.h                  |   1 +
>  tools/perf/util/mmap.c                   |   4 +-
>  tools/perf/util/parse-events.c           |   2 +-
>  20 files changed, 176 insertions(+), 165 deletions(-)
>
>
> Regards
> Adrian

Thanks Adrian, I'm very much in favor of this patch set. Can we add
some tests for intel-pt? They could be part of the 'perf record' shell
test:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/tests/shell/record.sh?h=perf/core
but probably better as there own thing. A command line broken prior to
this change would be great!

Aside from testing, we should clean up what dummy CPUs in the cpu maps
means. As per:
https://lore.kernel.org/linux-perf-users/CAP-5=fWfs2td9nZLGdEBD+C5s=upa_7SORab8tQ7qH=jX--F7w@mail.gmail.com/

I also think landing:
https://lore.kernel.org/linux-perf-users/20220503041757.2365696-3-irogers@google.com/
will help as it avoids the all_cpus map containing references to CPUs
from PMU sysfs that had been overridden.

Thanks,
Ian
