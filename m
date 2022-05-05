Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAEA51CD06
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 01:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385987AbiEEX76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 19:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237355AbiEEX74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 19:59:56 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97A647045
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:56:15 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id s1so2234008uac.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 16:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y8uigy1rMB7YyP5N4Woy8fmkm4g+BMsdh26+oOrn6Lg=;
        b=r3GxquI1Qu2H6I7N+9DosRuS1tLLLprYi+sMTXj2adq7nUjB+i1R5b8IsJhrDb98+y
         vFRnMLWMwbI7lQZtrW2qqkMDIWhezMQUgBZGEwrjwZSV+I5FjeXigZybSzw6EY4L1fKO
         cBHIb3PUHUjyGhc66QBdudWoxeJU6uV5wmUN/ylKjQ0CEKNprs31hNhf9nmS5PtEQjMf
         I8qsUy/krWVw5zlRu9/seHopDdWbNQKjq2pHLCxbFDX8zmnqodbzuxhBJbXKkh0GLtNt
         8b/8WGgEkxG1XqOP5MhR97Z5UbeuJeWFgVKywLfKQNpzbO7om/VzALiYZddyGEEojhDZ
         7VTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y8uigy1rMB7YyP5N4Woy8fmkm4g+BMsdh26+oOrn6Lg=;
        b=cIQcHTmO4QpNTfKaDTfkbWyEgO/bKpmwgW430hsYQYrWx2hfv5NUhzvfv1hBFv/lud
         t5zKdFInD6L8JyqIPy6QfgxLFhuLbaLfVIjWqSeL5XdFF6r1dm4BV81x/PgdmQJPHkCz
         6OPc+fb4gblCBhyuefRDmZBJK34PKQqBl94eAizlLMo3+MprXrK9BjzSxtQN0EVqao0G
         qWyB+qouyKBUb0y9y0UiAgUctuz/YnXOkQf2JpFBWItXnIVXPByBlvoIL0itQAxiYgl2
         r6h8NUJpiGg1t3qvBT6+t6ATGd+h7b2KXYmq/1pTMSN0QcTAFy2fVj1zDvlghsWI/160
         oEvg==
X-Gm-Message-State: AOAM531C8VCY2XHFE+iVgMqniUGUaplogCFz8zqoZvf20K3YR8xwVTTh
        8R2gtQl82Ds/U8BwX8HOb5Gr4zCucxKR0NGXQRd/1bL0DEHPJQ==
X-Google-Smtp-Source: ABdhPJza2ACGGrj5RXHyJxgkKinq3lID4bpRXaxtU+BpdglZhbBs1yCduhgFBU+hDCJALk09FS8GjGXo1LO+vh8PGBQ=
X-Received: by 2002:ab0:240e:0:b0:360:325a:7352 with SMTP id
 f14-20020ab0240e000000b00360325a7352mr182131uan.108.1651794974911; Thu, 05
 May 2022 16:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220505165639.361733-1-adrian.hunter@intel.com> <20220505165639.361733-14-adrian.hunter@intel.com>
In-Reply-To: <20220505165639.361733-14-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 16:56:02 -0700
Message-ID: <CAP-5=fWKOYiOSs=TppGCD+k283rUUsexzVuJP17Pm76EMOs+xA@mail.gmail.com>
Subject: Re: [PATCH V1 13/23] perf evlist: Add evlist__add_system_wide_dummy()
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

On Thu, May 5, 2022 at 9:57 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Add evlist__add_system_wide_dummy() to enable creating a system-wide dummy
> event that sets up the system-wide maps before map propagation.

Perhaps this should be:
evlist__add_dummy_on_all_online_cpus()
my thoughts being that a system wide dummy sounds like the dummy CPU
map, ie {-1} whilst what happens here is opening on all online CPUs
{0-35} on a 36 hyperthread system. Note also that the libperf
cpu_map__read_all_cpu_map code doesn't discover sysfs' mount properly,
as done in:
tools/lib/api/fs/fs.h
Some tech debt.

> For convenience, add evlist__add_aux_dummy() so that the logic can be used
> whether or not the event needs to be system-wide.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/evlist.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/evlist.h |  5 +++++
>  2 files changed, 45 insertions(+)
>
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 78c47cbafbc2..58ea562ddbd2 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -264,6 +264,46 @@ int evlist__add_dummy(struct evlist *evlist)
>         return 0;
>  }
>
> +static void evlist__add_system_wide(struct evlist *evlist, struct evsel *evsel)

This would be:
evlist__add_on_all_online_cpus(..)

> +{
> +       evsel->core.system_wide = true;
> +
> +       /* All CPUs */
> +       perf_cpu_map__put(evsel->core.own_cpus);
> +       evsel->core.own_cpus = perf_cpu_map__new(NULL);
> +       perf_cpu_map__put(evsel->core.cpus);
> +       evsel->core.cpus = perf_cpu_map__get(evsel->core.own_cpus);
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
> +               evlist__add_system_wide(evlist, evsel);
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
> index 4062f5aebfc1..dd1af114e033 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -114,6 +114,11 @@ int arch_evlist__add_default_attrs(struct evlist *evlist);
>  struct evsel *arch_evlist__leader(struct list_head *list);
>
>  int evlist__add_dummy(struct evlist *evlist);
> +struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide);
> +static inline struct evsel *evlist__add_system_wide_dummy(struct evlist *evlist)
> +{
> +       return evlist__add_aux_dummy(evlist, true);
> +}
>
>  int evlist__add_sb_event(struct evlist *evlist, struct perf_event_attr *attr,
>                          evsel__sb_cb_t cb, void *data);
> --
> 2.25.1
>
