Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FCA524068
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 00:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348887AbiEKWuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 18:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbiEKWuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 18:50:44 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9374F60C7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:50:42 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so4632050fac.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Dp3qQlHInb2Tjwxsw8R8BtRkQS2CxgrojIDrtLsQhI=;
        b=1CT528MsrM/g2UFfAWJIwgGaS5gpv5MZdzdnk6ItmUktHQlGo8Jx44o6Yi3Y18aRHk
         7x13AY+kP5cpc/cI6VYJcX6SkTrkR0auBxJao4l4j09NR0TG6szqChAWs/4ZzY6paRRq
         SlOCb2DlRwJUIFiDdMti+/yjFphlRYWfkm2fmIo8Mh8iJCYJs1u7wWUR8aWt7zC7kmhm
         Dd6qzrn92mkNgYdWxQf/q4RnWNBBk3A1S+3tlK7ShpoUtxSuRZlypbncqxkngVumXYO+
         vQ0OdX+2UlF7lawlLiVPf7Kj+UAfxpLhFHcxHBQQRrGk53n992RCDocVv3H1D8vE7vJB
         rxrA==
X-Gm-Message-State: AOAM533MTz1AyaC6uoNoYg3bjILf8QYY/nqwqNqXIzLXFMB2SnAschcr
        S9gw91j5cK7aAkNKIUDmECpfN3blMYhPKvnNepY=
X-Google-Smtp-Source: ABdhPJxxh1T8nuK1hNIFi/rVEFuh+SdhlEiUHV8FsUqk5mGyHsHLtHVvdefwCYv3UNeXgGe0X604YJAtacomveqCApE=
X-Received: by 2002:a05:6870:d1cd:b0:e1:e7ee:faa0 with SMTP id
 b13-20020a056870d1cd00b000e1e7eefaa0mr4023689oac.5.1652309441766; Wed, 11 May
 2022 15:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-14-adrian.hunter@intel.com> <1bce56f9-2e4c-6cff-c668-d62cab038591@intel.com>
In-Reply-To: <1bce56f9-2e4c-6cff-c668-d62cab038591@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 11 May 2022 15:50:30 -0700
Message-ID: <CAM9d7cgTpZ1KFLMG5DT63twJZUgoxQ6zhUeMkSya0x4O6U9TMg@mail.gmail.com>
Subject: Re: [PATCH V3 13/23] perf evlist: Add evlist__add_dummy_on_all_cpus()
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 12:02 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Add evlist__add_dummy_on_all_cpus() to enable creating a system-wide dummy
> event that sets up the system-wide maps before map propagation.
>
> For convenience, add evlist__add_aux_dummy() so that the logic can be used
> whether or not the event needs to be system-wide.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>
> Changes in V3: Amended comment about all CPUs.
>
>  tools/perf/util/evlist.c | 45 ++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/evlist.h |  5 +++++
>  2 files changed, 50 insertions(+)
>
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 78c47cbafbc2..2b2900434bba 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -264,6 +264,51 @@ int evlist__add_dummy(struct evlist *evlist)
>         return 0;
>  }
>
> +static void evlist__add_on_all_cpus(struct evlist *evlist, struct evsel *evsel)
> +{
> +       evsel->core.system_wide = true;
> +
> +       /*
> +        * All CPUs.
> +        *
> +        * Note perf_event_open() does not accept CPUs that are not online, so
> +        * in fact this CPU list will include only all online CPUs.
> +        */
> +       perf_cpu_map__put(evsel->core.own_cpus);
> +       evsel->core.own_cpus = perf_cpu_map__new(NULL);
> +       perf_cpu_map__put(evsel->core.cpus);
> +       evsel->core.cpus = perf_cpu_map__get(evsel->core.own_cpus);

Maybe I'm missing something.. Wouldn't it be overwritten
by the user requested cpus during map propagation in
evlist__add()?

Thanks,
Namhyung


> +
> +       /* No threads */
> +       perf_thread_map__put(evsel->core.threads);
> +       evsel->core.threads = perf_thread_map__new_dummy();
> +
> +       evlist__add(evlist, evsel);
> +}
> +
> +struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
> +{
> +       struct evsel *evsel = evlist__dummy_event(evlist);
> +
> +       if (!evsel)
> +               return NULL;
> +
> +       evsel->core.attr.exclude_kernel = 1;
> +       evsel->core.attr.exclude_guest = 1;
> +       evsel->core.attr.exclude_hv = 1;
> +       evsel->core.attr.freq = 0;
> +       evsel->core.attr.sample_period = 1;
> +       evsel->no_aux_samples = true;
> +       evsel->name = strdup("dummy:u");
> +
> +       if (system_wide)
> +               evlist__add_on_all_cpus(evlist, evsel);
> +       else
> +               evlist__add(evlist, evsel);
> +
> +       return evsel;
> +}
> +
>  static int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs)
>  {
>         struct evsel *evsel, *n;
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 4062f5aebfc1..1bde9ccf4e7d 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -114,6 +114,11 @@ int arch_evlist__add_default_attrs(struct evlist *evlist);
>  struct evsel *arch_evlist__leader(struct list_head *list);
>
>  int evlist__add_dummy(struct evlist *evlist);
> +struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide);
> +static inline struct evsel *evlist__add_dummy_on_all_cpus(struct evlist *evlist)
> +{
> +       return evlist__add_aux_dummy(evlist, true);
> +}
>
>  int evlist__add_sb_event(struct evlist *evlist, struct perf_event_attr *attr,
>                          evsel__sb_cb_t cb, void *data);
> --
> 2.25.1
>
