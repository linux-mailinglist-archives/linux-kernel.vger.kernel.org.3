Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202AE51CE55
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387753AbiEFBEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 21:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiEFBEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 21:04:08 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153161B79F
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 18:00:27 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so3533883wmn.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 18:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lIvqZeokdZfN9iEI6nvzjv8eDvxOc3GxcvOlTkNvDkQ=;
        b=OGV8ATd5xl3ZXh1HMVPMxeQ9Y2ROlipB4mQyQaHE3kweDkZzdqw4kU+4fSZEGYkyWL
         K/nr3Wd+DpGeIHgXJrKug3pGrBjHj/NzcgTwLVZstO1EqsMpNTGQTdnBwoiwcLzWUzg0
         lkBiW1+VVd8kOOjqSRVcyBqN9GnKQH99qA/rUL2/gYvMsEdJ2kYfkq/OcAeClGE2aOT/
         rphpFiH0DnnQxBFRiY078Ms+B8Mr0F+CM7qTsWaaQ0+jC7aAKIJ9q7lctdgPKwQ5bx/K
         3YX+xkxBCeOvmJ3T1U2MqRuE3cWzg4aVO6GWBNeRtThJKllrH0kQLiLWg6Ro0OPU/up0
         JTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lIvqZeokdZfN9iEI6nvzjv8eDvxOc3GxcvOlTkNvDkQ=;
        b=tEsXe0Nm6UYxUsu6mZdKuEavhz319TYyY1iYOwbiU6qV0Vk5heaUJ9JfUx3SrbDhq0
         1RR7VF2vJ2O+g8GTOc/VEDIMTJIMwXrJ3e7Zklj7ieEyPpqVfD7AUULrnIjnqEmBqVBD
         3OjO9ia5IZg98eY/4ttoptwh23qwuIVxso56X/p8Rzx+svEFVIS6ZLz740k+ypN55A8E
         /qBY2s7UBTPnwHu5QHIJFNZYAI/w19xs9Aw8kgWZiMeU0aQuVWiVrhPFOrYKeGg/t6QG
         cgXoRtCpBmZZVAAm+i+j8uatSNBXSB+G6c+KoJugmwIV5+fRh114nMGjZSTCc51LMp3t
         CAZg==
X-Gm-Message-State: AOAM531nYQAxP22ScS49nH0u6955NxVV5OPW0bgEqvmxnkrhkoiKQX2f
        aw7qlSorsJVQOPIK5EWZQU7qzkwguWTWAr772TccLw==
X-Google-Smtp-Source: ABdhPJzkYHzKT69zAO8WCNy/smMZePJYJOoSYRcrGhAbNCfZ1VPeHuJRVfjapA6uMWANsX85Py+oEPWBysliWyse6qo=
X-Received: by 2002:a05:600c:2258:b0:394:2045:bed with SMTP id
 a24-20020a05600c225800b0039420450bedmr809796wmm.174.1651798825529; Thu, 05
 May 2022 18:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220505165639.361733-1-adrian.hunter@intel.com> <20220505165639.361733-23-adrian.hunter@intel.com>
In-Reply-To: <20220505165639.361733-23-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 18:00:12 -0700
Message-ID: <CAP-5=fVxPE7D=RBMnapByyzsiKAS_MxBqz5_=0NcOyha_5Huiw@mail.gmail.com>
Subject: Re: [PATCH V1 22/23] perf tools: Allow system-wide events to keep
 their own CPUs
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

On Thu, May 5, 2022 at 9:58 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Currently, user_requested_cpus supplants system-wide CPUs when the evlist
> has_user_cpus. Change that so that system-wide events retain their own
> CPUs and they are added to all_cpus.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Note, we should really have a test on:
```
$ perf stat -A -e uncore_imc/cas_count_read/ -a -C 1,19 sleep 1

 Performance counter stats for 'system wide':

CPU1                   974.34 MiB  uncore_imc/cas_count_read/
CPU19                  262.50 MiB  uncore_imc/cas_count_read/

       1.003673356 seconds time elapsed
```
ie the user requested CPUs were respected for the uncore events even
though their CPU mask was {0,18}.

Thanks,
Ian

> ---
>  tools/lib/perf/evlist.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 3bf77f9617b6..da30e88c76b9 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -40,12 +40,11 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
>          * We already have cpus for evsel (via PMU sysfs) so
>          * keep it, if there's no target cpu list defined.
>          */
> -       if (!evsel->own_cpus || evlist->has_user_cpus) {
> -               perf_cpu_map__put(evsel->cpus);
> -               evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
> -       } else if (!evsel->system_wide &&
> -                  !evsel->requires_cpu &&
> -                  perf_cpu_map__empty(evlist->user_requested_cpus)) {
> +       if (!evsel->own_cpus ||
> +           (!evsel->system_wide && evlist->has_user_cpus) ||
> +           (!evsel->system_wide &&
> +            !evsel->requires_cpu &&
> +            perf_cpu_map__empty(evlist->user_requested_cpus))) {
>                 perf_cpu_map__put(evsel->cpus);
>                 evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
>         } else if (evsel->cpus != evsel->own_cpus) {
> --
> 2.25.1
>
