Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18B158517F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbiG2OY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236981AbiG2OY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:24:26 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210D86C138
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:24:25 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j29-20020a05600c1c1d00b003a2fdafdefbso2574405wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LypYebNOHjfta90jCiEF7l4jJITyPo34Kh+cxFf5b7k=;
        b=o/VoIs1FYnbSYgcdN1Mey6VbgelHyJu1ATCEWwD53mdKhrXpjQui5rDM7ZZlXtE+fS
         MUVqTmYxWlsowO+bpTuzy/oVsaembdjMiLzApJgcq5dArVqtptZevLreiKLD8CgRs3kr
         MvGq1W04Uy8IEEITpzUTp2vB2QhQnKKJbVTNG/vMkIIndei2g1G9H7zRpNz4iiHkULmI
         aLRqDypMhjfFvunZDaLYNnqjmaQ2WYJwoTKglmL55DegwMx48k5zXYGUUqM2NuAYGUGM
         qrHPV7ks4LLs2lJBqSSgv7wmY90Cr7frvWqbTwKpyYEZDWXTz9+9QBM7I40bXPwPR1Na
         1OBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LypYebNOHjfta90jCiEF7l4jJITyPo34Kh+cxFf5b7k=;
        b=ziaXryLJQgkenpovo2zzA2SJp7CovkHjUdIf3iwdkt4cCqUNxdqft/tmNlpwMMj1Sd
         yEc8Yt3s4+2LmXqnTp1pKzMfZI28zpUNYYniMJOO4CUOMjAQwqSCNy7tRbI4B2Mrpurt
         3hrq18rl7NB/KFd/rgcZfOogq6j/sJcSCXvIcYtAJWBlRcf/kXklM1ksuENqhKvNgMBK
         +6dzlZq3Z02xhMNeya+oExmyNfCXypBSlIbsSPoDC3gm/bQ+7sO0Y8eo+D1S7CIoe9hZ
         H+gkwjJ33GF8XkpZYJfkHkGfDaCZyH8wxb5opJwQD681xhF3qA6q9jT/uIXdQPJ8M78r
         CpIg==
X-Gm-Message-State: AJIora+u3Yw7Z3chOlnAO3AvyqofizXrflBDWqTgejWqM7we/k+vNOVS
        at8P4AWArC2MFpBxLyJ/DJpkCf0+6ubJ/nUDvWGbMw==
X-Google-Smtp-Source: AGRyM1vcvoixpQIqXoSvh3g/D9PPji8zVRLepMsp2jSLV0A+j/g1kK1tqIHam+9nDFHK6ZhaYv+FN2GWeQvomzERy5c=
X-Received: by 2002:a05:600c:19d2:b0:3a3:2cdb:cc02 with SMTP id
 u18-20020a05600c19d200b003a32cdbcc02mr3018045wmq.182.1659104663337; Fri, 29
 Jul 2022 07:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220729074351.138260-1-irogers@google.com> <20220729074351.138260-6-irogers@google.com>
 <393770c6-8469-a5b5-5106-a98420bb6e00@huawei.com>
In-Reply-To: <393770c6-8469-a5b5-5106-a98420bb6e00@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 29 Jul 2022 07:24:10 -0700
Message-ID: <CAP-5=fUQ2nAHyN5Egxfpyotc0u4O1wsZ8VKzwffOhGhV++L6=Q@mail.gmail.com>
Subject: Re: [PATCH v3 05/17] perf jevents: Remove the type/version variables
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 1:30 AM John Garry <john.garry@huawei.com> wrote:
>
> On 29/07/2022 08:43, Ian Rogers wrote:
> > pmu_events_map has a type variable that is always initialized to "core"
> > and a version variable that is never read. Remove these from the API as
> > it is straightforward to add them back when necessary.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Reviewed-by: John Garry <john.garry@huawei.com>
>
> Please note the questions, below.
>
> > ---
> >   tools/perf/pmu-events/empty-pmu-events.c | 6 ++----
> >   tools/perf/pmu-events/jevents.py         | 6 ------
> >   tools/perf/pmu-events/pmu-events.h       | 2 --
> >   tools/perf/tests/expand-cgroup.c         | 2 --
> >   tools/perf/tests/parse-metric.c          | 2 --
> >   5 files changed, 2 insertions(+), 16 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
> > index 77e655c6f116..4182a986f505 100644
> > --- a/tools/perf/pmu-events/empty-pmu-events.c
> > +++ b/tools/perf/pmu-events/empty-pmu-events.c
> > @@ -110,15 +110,13 @@ static const struct pmu_event pme_test_soc_cpu[] = {
> >
> >   const struct pmu_events_map pmu_events_map[] = {
> >       {
> > +             .arch = "testarch",
>
> Is this really supposed to be part of this patch?

Agreed. Looks like it should have been in the previous.

Thanks,
Ian

> >               .cpuid = "testcpu",
> > -             .version = "v1",
> > -             .type = "core",
> >               .table = pme_test_soc_cpu,
> >       },
> >       {
> > +             .arch = 0,
>
> Same as above
>
> >               .cpuid = 0,
> > -             .version = 0,
> > -             .type = 0,
> >               .table = 0,
> >       },
> >   };
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> > index e6e6c42c3f8a..98d18d5c3830 100755
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -312,8 +312,6 @@ def print_mapping_table(archs: Sequence[str]) -> None:
> >         _args.output_file.write("""{
> >   \t.arch = "testarch",
> >   \t.cpuid = "testcpu",
> > -\t.version = "v1",
> > -\t.type = "core",
> >   \t.table = pme_test_soc_cpu,
> >   },
> >   """)
> > @@ -329,8 +327,6 @@ def print_mapping_table(archs: Sequence[str]) -> None:
> >               _args.output_file.write(f"""{{
> >   \t.arch = "{arch}",
> >   \t.cpuid = "{cpuid}",
> > -\t.version = "{row[1]}",
> > -\t.type = "{row[3]}",
> >   \t.table = {tblname}
> >   }},
> >   """)
> > @@ -339,8 +335,6 @@ def print_mapping_table(archs: Sequence[str]) -> None:
> >     _args.output_file.write("""{
> >   \t.arch = 0,
> >   \t.cpuid = 0,
> > -\t.version = 0,
> > -\t.type = 0,
> >   \t.table = 0,
> >   }
> >   };
> > diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
> > index 7a360792635f..a491b117c8ac 100644
> > --- a/tools/perf/pmu-events/pmu-events.h
> > +++ b/tools/perf/pmu-events/pmu-events.h
> > @@ -40,8 +40,6 @@ struct pmu_event {
> >   struct pmu_events_map {
> >       const char *arch;
> >       const char *cpuid;
> > -     const char *version;
> > -     const char *type;               /* core, uncore etc */
> >       const struct pmu_event *table;
> >   };
> >
> > diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
> > index dfefe5b60eb2..dc4038f997d7 100644
> > --- a/tools/perf/tests/expand-cgroup.c
> > +++ b/tools/perf/tests/expand-cgroup.c
> > @@ -197,8 +197,6 @@ static int expand_metric_events(void)
> >       };
> >       const struct pmu_events_map ev_map = {
> >               .cpuid          = "test",
> > -             .version        = "1",
> > -             .type           = "core",
> >               .table          = pme_test,
> >       };
> >
> > diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> > index 07b6f4ec024f..1b811a26f4ee 100644
> > --- a/tools/perf/tests/parse-metric.c
> > +++ b/tools/perf/tests/parse-metric.c
> > @@ -81,8 +81,6 @@ static struct pmu_event pme_test[] = {
> >
> >   static const struct pmu_events_map map = {
> >       .cpuid          = "test",
> > -     .version        = "1",
> > -     .type           = "core",
> >       .table          = pme_test,
> >   };
> >
>
