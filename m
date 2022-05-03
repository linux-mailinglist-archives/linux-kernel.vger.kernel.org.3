Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FA5518608
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbiECOHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236613AbiECOHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:07:19 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD96C1EAF3
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 07:03:45 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w4so23480322wrg.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 07:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4yiLw/VEdaYl/NlOASUjlFdrhZcltSNhm4gz6dSd34k=;
        b=kCtauluC6RPbNDvBY/JRShpAYoymIwgUaaCYj9BWRXXiDuSIf815m2lptCT+0twyJN
         X4OB7viRH2mwmEUlxrFWYCtI9+2svNvzxoIR3GJPkMGlaeyd1pssEWQ2N//CeWRcYzvA
         0JBUfSyzB7M6zvr8T+fT6HLcpFP1uJ4hL92VDWdFWZzB623LS1Uqvn3mXeH5MhvrDaDG
         5cPmHZUfOd8THiO3Re830/MRm8rHK1nY9fEGJiq7uw4JN7EXPGRuN8jQBitKt/YDjzAU
         ZwcIXfUnN7qeNVhXUSKi3QdJJc7JWbobyEF9Te24ClW2Ok8MDJW+1Daa+WBHTIByn3xS
         QVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4yiLw/VEdaYl/NlOASUjlFdrhZcltSNhm4gz6dSd34k=;
        b=o5lVhyUv6y4WE00BMUGY7IjcHledvA0LzzG/hzV/aY7Ki8Y79eNd8/BD6XBzTCBC2E
         w/ZSc1g7u06JjFOxBpueJXEM1gm9UW9dDd6jL//JeayAcuSwLCMiwiGJRDWuXGJ4H80c
         6xGsDf8dHqiRVL3+9KzrkaQK+mpqg78E6QNHn2PDrPq3ZCvtBnYnU1r0xMYJrB4lzhIC
         2LnMMJ3Ot9mUK/eR9LMxblSNGQavtO9rijCcFCsSXPLY5NJjliH2DZ19GL0UDSwPXOLO
         lz6qvFEvOFCE8aa0kWbjvET2vMwIxGYipPaEgmHAzYmS81JG8A3EE4+DU/uzyci4Zh01
         wSUA==
X-Gm-Message-State: AOAM530XvLZeLDPilYFXgNoXHxIoImo8uwU8rK2z/T7ffukFYjvf2a+a
        4Qy/U7cZvhsprM086FSzomvJLZBQTMVib05ya+FeGw==
X-Google-Smtp-Source: ABdhPJxIIXls0cRITSkASA+TT9aqYlg/XlcuvPUcKW+mcEfUrgFZ/oTWBOFcSD7nbqFc8D8kKLu+Cze+GzwbCbeog/c=
X-Received: by 2002:adf:f30a:0:b0:20a:e193:6836 with SMTP id
 i10-20020adff30a000000b0020ae1936836mr13028706wro.654.1651586623927; Tue, 03
 May 2022 07:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220503041757.2365696-1-irogers@google.com> <20220503041757.2365696-5-irogers@google.com>
 <b94f3863-c690-e0f7-5cde-18fbf24143e5@intel.com>
In-Reply-To: <b94f3863-c690-e0f7-5cde-18fbf24143e5@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 3 May 2022 07:03:31 -0700
Message-ID: <CAP-5=fWfs2td9nZLGdEBD+C5s=upa_7SORab8tQ7qH=jX--F7w@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] perf cpumap: Handle dummy maps as empty in subset
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Tue, May 3, 2022 at 12:43 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 3/05/22 07:17, Ian Rogers wrote:
> > perf_cpu_map__empty is true for empty and dummy maps. Make is_subset
> > respect that.
>
> As I wrote before, I am not keen on this because it prevents -1, as a
> valid 3rd parameter to perf_event_open(), from being represented
> in merged evsel cpu maps.
>
> Why do you want this?

Thanks Adrian, could you give me a test case (command line) where the
differing dummy and empty behavior matters? Normally cpus/own_cpus are
set to null during parsing. They may get replaced with
user_requested_cpus:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/evlist.c?h=perf/core#n44
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/evlist.c?h=perf/core#n45
(should it be on line 45 that !empty is expected?)

During merge the null/empty all_cpus drops this value, which doesn't
matter as the behavior with empty is the same as dummy:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/evsel.c?h=perf/core#n119

What's concerning me is the definition of empty:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/cpumap.c?h=perf/core#n279
```
return map ? map->map[0].cpu == -1 : true;
```
If the first entry can be -1 and there can be other CPUs merged after
then that cpu map will be empty by the definition above. Perhaps it
should be:
```
return map ? (map->nr == 1 && map->map[0].cpu == -1) : true;
```
but it seems you prefer:
```
return (map == NULL) ? true : false;
```

You'd asked what the behavior with a dummy is and clearly it is
somewhat muddy. That is what this patch and unit test is trying to
clean up.

Thanks,
Ian

> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/perf/cpumap.c   |  4 ++--
> >  tools/perf/tests/cpumap.c | 10 +++++++++-
> >  2 files changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> > index 384d5e076ee4..9c83675788c2 100644
> > --- a/tools/lib/perf/cpumap.c
> > +++ b/tools/lib/perf/cpumap.c
> > @@ -322,9 +322,9 @@ struct perf_cpu perf_cpu_map__max(struct perf_cpu_map *map)
> >  /** Is 'b' a subset of 'a'. */
> >  bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu_map *b)
> >  {
> > -     if (a == b || !b)
> > +     if (a == b || perf_cpu_map__empty(b))
> >               return true;
> > -     if (!a || b->nr > a->nr)
> > +     if (perf_cpu_map__empty(a) || b->nr > a->nr)
> >               return false;
> >
> >       for (int i = 0, j = 0; i < a->nr; i++) {
> > diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
> > index f94929ebb54b..d52b58395385 100644
> > --- a/tools/perf/tests/cpumap.c
> > +++ b/tools/perf/tests/cpumap.c
> > @@ -128,13 +128,21 @@ static int test__cpu_map_merge(struct test_suite *test __maybe_unused, int subte
> >       struct perf_cpu_map *a = perf_cpu_map__new("4,2,1");
> >       struct perf_cpu_map *b = perf_cpu_map__new("4,5,7");
> >       struct perf_cpu_map *c = perf_cpu_map__merge(a, b);
> > +     struct perf_cpu_map *d = perf_cpu_map__dummy_new();
> > +     struct perf_cpu_map *e = perf_cpu_map__merge(b, d);
> >       char buf[100];
> >
> >       TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(c) == 5);
> >       cpu_map__snprint(c, buf, sizeof(buf));
> >       TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "1-2,4-5,7"));
> > -     perf_cpu_map__put(b);
> > +
> > +     TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(e) == 3);
> > +     cpu_map__snprint(e, buf, sizeof(buf));
> > +     TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "4-5,7"));
> > +
> >       perf_cpu_map__put(c);
> > +     perf_cpu_map__put(d);
> > +     perf_cpu_map__put(e);
> >       return 0;
> >  }
> >
>
