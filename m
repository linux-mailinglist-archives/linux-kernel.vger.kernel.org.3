Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A13958EE52
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiHJO3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiHJO3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:29:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024A0220C8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:29:34 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n4so16194149wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=6NCrAqjcYlhGZUqWXYrABrAD13m9MCdw4daKveaKHD4=;
        b=bgwZ8VUxCN+fAD3U4mXgM1Ml0h0PkJfeoHPuPQDJtwXBrgXmoJdNesEQjwiXBMZ6N1
         3xVptBaVTSMipRn13RxDhzRoSb6IwuPdBawnOJ8BS0bUDyfRG8MUxPe8vN67XsPjc7lt
         ET5rbfrSWcA1JtHU87x43MJ6bAvXTU3UHMD0YRllFuWZJ07wPFiaju88qvItasDLohfT
         m3ikSf3kntduelZIjuipb2KCB5SzDqcXvktCKay3rFXwv7mNp9XRpMEFZkNmpVnqCNxI
         EjxAk26SWiqwhoaFcK4V2a/IJftgeaXeOuC/8oZ7RFT+bYyR/mhORuDtjSy2/ygQXIrI
         QVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=6NCrAqjcYlhGZUqWXYrABrAD13m9MCdw4daKveaKHD4=;
        b=rpGPmCzGXZMKEk3TlSqPG3CyiZP2BbV6EGc7nThLRC0B3DF/pPCOeI54cKH4HCSqcT
         AmPx5UOmhWhgzqxXAArprR1JejTyQZmkytxG/pPdb5WWjwKLjyJ/ezG0WyHAU0vIEKAR
         xBY0YaSJYgZl4Nioyo/UBvUw2f1p6JpHE7aTccABAjg1zBY0fpPcxPSUdllhwwm2b6Ze
         tJ1KmPrvnjgNnSq6Phl3py+efd7nL7sQWcgWV9wd3V3Y40MlwNNe/azukZRjE2cv52nD
         xty8URrS3Hll2ijmPuolfWhFtJslDuRiKCOQetkBXlKFckSAqMjBTDsVoZ2RuZ5rXWbA
         q84w==
X-Gm-Message-State: ACgBeo1QlACqxBkVQwytXiPvsByq0DkkQJrSv6TEyUlW0F0p8fdEB+rl
        qq5CuoPOQ0AJO9FKW1yBRYyXCewNRGuuo94++QGhvg==
X-Google-Smtp-Source: AA6agR4Qh+xvSo11mAtUPGheEe6kESQkvRLJTpuP6tvgsKczQyDx563jSC/DfY44lbHco54DLKwW0zO9691Dxsuk5qc=
X-Received: by 2002:a05:6000:1ac9:b0:220:7f40:49e3 with SMTP id
 i9-20020a0560001ac900b002207f4049e3mr17099423wry.40.1660141772234; Wed, 10
 Aug 2022 07:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220804221816.1802790-1-irogers@google.com> <20220804221816.1802790-11-irogers@google.com>
 <463cffea-51d9-98ad-86ac-d064faac05b9@huawei.com>
In-Reply-To: <463cffea-51d9-98ad-86ac-d064faac05b9@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 10 Aug 2022 07:29:19 -0700
Message-ID: <CAP-5=fXuG9Jt5x-e3um=-hYNSb18j8dL5np5Edozw+H5PoZ2eA@mail.gmail.com>
Subject: Re: [PATCH v4 10/17] perf pmu-events: Hide pmu_events_map
To:     John Garry <john.garry@huawei.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 5, 2022 at 5:31 AM John Garry <john.garry@huawei.com> wrote:
>
> On 04/08/2022 23:18, Ian Rogers wrote:
> > Move usage of the table to pmu-events.c so it may be hidden. By
> > abstracting the table the implementation can later be changed.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/pmu-events/empty-pmu-events.c |  81 ++++++++-
> >   tools/perf/pmu-events/jevents.py         |  81 ++++++++-
> >   tools/perf/pmu-events/pmu-events.h       |  29 +--
> >   tools/perf/tests/pmu-events.c            | 218 +++++++++++------------
> >   tools/perf/util/metricgroup.c            |  15 +-
> >   tools/perf/util/pmu.c                    |  34 +---
> >   tools/perf/util/pmu.h                    |   2 +-
> >   7 files changed, 280 insertions(+), 180 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
> > index 216ea0482c37..8ef75aff996c 100644
> > --- a/tools/perf/pmu-events/empty-pmu-events.c
> > +++ b/tools/perf/pmu-events/empty-pmu-events.c
> > @@ -6,6 +6,8 @@
> >    * The test cpu/soc is provided for testing.
> >    */
> >   #include "pmu-events/pmu-events.h"
> > +#include "util/header.h"
> > +#include "util/pmu.h"
> >   #include <string.h>
> >   #include <stddef.h>
> >
> > @@ -110,7 +112,26 @@ static const struct pmu_event pme_test_soc_cpu[] = {
> >       },
> >   };
> >
> > -const struct pmu_events_map pmu_events_map[] = {
> > +
> > +/*
> > + * Map a CPU to its table of PMU events. The CPU is identified by the
> > + * cpuid field, which is an arch-specific identifier for the CPU.
> > + * The identifier specified in tools/perf/pmu-events/arch/xxx/mapfile
> > + * must match the get_cpuid_str() in tools/perf/arch/xxx/util/header.c)
> > + *
> > + * The  cpuid can contain any character other than the comma.
> > + */
> > +struct pmu_events_map {
> > +     const char *arch;
> > +     const char *cpuid;
> > +     const struct pmu_event *table;
> > +};
> > +
> > +/*
> > + * Global table mapping each known CPU for the architecture to its
> > + * table of PMU events.
> > + */
> > +static const struct pmu_events_map pmu_events_map[] = {
> >       {
> >               .arch = "testarch",
> >               .cpuid = "testcpu",
> > @@ -162,6 +183,62 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
> >       },
> >   };
> >
> > +const struct pmu_event *perf_pmu__find_table(struct perf_pmu *pmu)
> > +{
> > +     const struct pmu_event *table = NULL;
> > +     char *cpuid = perf_pmu__getcpuid(pmu);
> > +     int i;
> > +
> > +     /* on some platforms which uses cpus map, cpuid can be NULL for
> > +      * PMUs other than CORE PMUs.
> > +      */
> > +     if (!cpuid)
> > +             return NULL;
> > +
> > +     i = 0;
> > +     for (;;) {
> > +             const struct pmu_events_map *map = &pmu_events_map[i++];
> > +
> > +             if (!map->table)
> > +                     break;
> > +
> > +             if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
> > +                     table = map->table;
> > +                     break;
> > +             }
> > +     }
> > +     free(cpuid);
> > +     return table;
> > +}
> > +
> > +const struct pmu_event *find_core_events_table(const char *arch, const char *cpuid)
> > +{
> > +     for (const struct pmu_events_map *tables = &pmu_events_map[0];
> > +          tables->table;
> > +          tables++) {
> > +             if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(tables->cpuid, cpuid))
> > +                     return tables->table;
> > +     }
> > +     return NULL;
> > +}
> > +
> > +int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data)
> > +{
> > +     for (const struct pmu_events_map *tables = &pmu_events_map[0];
> > +          tables->table;
> > +          tables++) {
> > +             for (const struct pmu_event *pe = &tables->table[0];
> > +                  pe->name || pe->metric_group || pe->metric_name;
> > +                  pe++) {
> > +                     int ret = fn(pe, &tables->table[0], data);
> > +
> > +                     if (ret)
> > +                             return ret;
> > +             }
> > +     }
> > +     return 0;
> > +}
> > +
> >   const struct pmu_event *find_sys_events_table(const char *name)
> >   {
> >       for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
> > @@ -181,7 +258,7 @@ int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data)
> >               for (const struct pmu_event *pe = &tables->table[0];
> >                    pe->name || pe->metric_group || pe->metric_name;
> >                    pe++) {
> > -                     int ret = fn(pe, data);
> > +                     int ret = fn(pe, &tables->table[0], data);
> >
> >                       if (ret)
> >                               return ret;
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> > index dd21bc9eeeed..e976c5e8e80b 100755
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -333,7 +333,27 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
> >
> >   def print_mapping_table(archs: Sequence[str]) -> None:
> >     """Read the mapfile and generate the struct from cpuid string to event table."""
> > -  _args.output_file.write('const struct pmu_events_map pmu_events_map[] = {\n')
> > +  _args.output_file.write("""
> > +/*
> > + * Map a CPU to its table of PMU events. The CPU is identified by the
> > + * cpuid field, which is an arch-specific identifier for the CPU.
> > + * The identifier specified in tools/perf/pmu-events/arch/xxx/mapfile
> > + * must match the get_cpuid_str() in tools/perf/arch/xxx/util/header.c)
> > + *
> > + * The  cpuid can contain any character other than the comma.
> > + */
> > +struct pmu_events_map {
> > +        const char *arch;
> > +        const char *cpuid;
> > +        const struct pmu_event *table;
> > +};
> > +
> > +/*
> > + * Global table mapping each known CPU for the architecture to its
> > + * table of PMU events.
> > + */
> > +const struct pmu_events_map pmu_events_map[] = {
> > +""")
> >     for arch in archs:
> >       if arch == 'test':
> >         _args.output_file.write("""{
> > @@ -389,6 +409,61 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
> >   \t},
> >   };
> >
> > +const struct pmu_event *perf_pmu__find_table(struct perf_pmu *pmu)
> > +{
> > +        const struct pmu_event *table = NULL;
> > +        char *cpuid = perf_pmu__getcpuid(pmu);
>
> This seems an identical implementation to that in empty-pmu-events.c -
> can we reduce this duplication? Maybe a seperate common c file which can
> be linked in
>
> The indentation seems different also - this version seems to use whitespaces

Agreed. Later on this will change, the empty version isn't compressed
and the jevents.py one is. Having a common C file would defeat the
goal of hiding the API, but ultimately we'd need to get rid of it in
later changes when the empty/compressed implementations diverge.

Thanks,
Ian

> > +        int i;
> > +
> > +        /* on some platforms which uses cpus map, cpuid can be NULL for
> > +         * PMUs other than CORE PMUs.
> > +         */
> > +        if (!cpuid)
> > +                return NULL;
> > +
> > +        i = 0;
> > +        for (;;) {
> > +                const struct pmu_events_map *map = &pmu_events_map[i++];
> > +                if (!map->table)
> > +                        break;
> > +
> > +                if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
> > +                        table = map->table;
> > +                        break;
> > +                }
> > +        }
> > +        free(cpuid);
> > +        return table;
> > +}
