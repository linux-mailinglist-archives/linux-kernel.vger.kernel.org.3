Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC184B7821
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242326AbiBORNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:13:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235970AbiBORNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:13:20 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E57119F59
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:13:10 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id n17so24683975iod.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OS2cyXoSspyXwzMzdQfxlaygJp0VzdjIQki92+JEQJE=;
        b=F2C0H7NwLZq7SwwCNHKBEwU2PyifSnI7C1jhDRvWqIDcEeTOE130F7MWfIFwurDJmw
         xB4yuM/usHuhGFDgAxxuhLuzJ6Z3PyC1ArcAKjXqkCM6euYp+Di87tMphcjgTnoB3ZC3
         T1bLtRUa9qcjaQgkXPgp5veMMRSFtHqCgbMb/ETYgxQ73DJlMKhidTki9ymYru2JPwct
         yMsZg6eW0U+707aGDCdRJYL67ZptyBLqQw0n29OPyjYVphre6vhta6VZDKy4xxEBER/e
         VSsLMm/ZhNC5nBE3/m5DAj+tknNUmKJvFY4BBGmd86qqqsu4Z6ilDkfNr3b8iUaxfydu
         QJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OS2cyXoSspyXwzMzdQfxlaygJp0VzdjIQki92+JEQJE=;
        b=2t/8E2H3Lw7LyoEX02AZKmb/EPb5XjGXeTpJt9bXf+jrX+aw2YI0Rj3Jd7qDMS0Xb6
         RKuP12m/9gajjpfdcVNnLDHMXHL1Dbah8+fB8ZjmhIRRe8lth6Ajci1lQWwKshP0wAVF
         U+mzzkquEIpyhzznEQ9Jh9zTNJp4mWPxEX0dGw7GE1F/A53tfOP+uuTOb1thpXk6cZW9
         D4ImSh0szILn+hEYdZv2d9en89SNo6hK9urn4yPHSp+u7AwMepS8UT1VLf71j7tVhchJ
         fSp/dcAG5QfO+OzCFmyLePDe3MvWb/PkmCcoD76m1/FclzYCUkeYJRI887KRg9JJkKza
         pc0g==
X-Gm-Message-State: AOAM532w5+ceSOnSGSHiLAFIS4HhoUm20E4TIYt9ZeN65oc70sxEaZbP
        LkqC2hJAt+h009AI3NfNQz7+ylZKWzwgttk18fRFjg==
X-Google-Smtp-Source: ABdhPJyW23kbU/WeCcDN5jeFQO3EIItRo03FlyJ5Rzffil9N0Cbr6zrxfkRty3e2IVs0PKaP9MNreER4dNODBBc1HOA=
X-Received: by 2002:a6b:f904:: with SMTP id j4mr2960824iog.97.1644945189403;
 Tue, 15 Feb 2022 09:13:09 -0800 (PST)
MIME-Version: 1.0
References: <20220215153713.31395-1-jolsa@kernel.org>
In-Reply-To: <20220215153713.31395-1-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 15 Feb 2022 09:12:57 -0800
Message-ID: <CAP-5=fVytzO7XexSPC7ymgJ01_QfAaK0Ys-0NQ73QzRM8xwgbA@mail.gmail.com>
Subject: Re: [PATCH] libperf: Fix perf_cpu_map__for_each_cpu macro
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org
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

On Tue, Feb 15, 2022 at 7:37 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Tzvetomir Stoyanov reported an issue with using macro
> perf_cpu_map__for_each_cpu using private perf_cpu object.
>
> The issue is caused by recent change that wrapped cpu in struct
> perf_cpu to distinguish it from cpu indexes. We need to make
> struct perf_cpu public.
>
> Adding simple test for using perf_cpu_map__for_each_cpu
> macro.
>
> Fixes: 6d18804b963b ("perf cpumap: Give CPUs their own type")
> Reported-by: Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/lib/perf/include/internal/cpumap.h |  6 +-----
>  tools/lib/perf/include/perf/cpumap.h     |  5 +++++
>  tools/lib/perf/libperf.map               |  1 +
>  tools/lib/perf/tests/test-cpumap.c       | 11 +++++++++++
>  4 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
> index 581f9ffb4237..1973a18c096b 100644
> --- a/tools/lib/perf/include/internal/cpumap.h
> +++ b/tools/lib/perf/include/internal/cpumap.h
> @@ -3,11 +3,7 @@
>  #define __LIBPERF_INTERNAL_CPUMAP_H
>
>  #include <linux/refcount.h>
> -
> -/** A wrapper around a CPU to avoid confusion with the perf_cpu_map's map's indices. */
> -struct perf_cpu {
> -       int cpu;
> -};
> +#include <perf/cpumap.h>
>
>  /**
>   * A sized, reference counted, sorted array of integers representing CPU
> diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
> index 15b8faafd615..4a2edbdb5e2b 100644
> --- a/tools/lib/perf/include/perf/cpumap.h
> +++ b/tools/lib/perf/include/perf/cpumap.h
> @@ -7,6 +7,11 @@
>  #include <stdio.h>
>  #include <stdbool.h>
>
> +/** A wrapper around a CPU to avoid confusion with the perf_cpu_map's map's indices. */
> +struct perf_cpu {
> +       int cpu;
> +};
> +
>  LIBPERF_API struct perf_cpu_map *perf_cpu_map__dummy_new(void);
>  LIBPERF_API struct perf_cpu_map *perf_cpu_map__default_new(void);
>  LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
> diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
> index 93696affda2e..6fa0d651576b 100644
> --- a/tools/lib/perf/libperf.map
> +++ b/tools/lib/perf/libperf.map
> @@ -2,6 +2,7 @@ LIBPERF_0.0.1 {
>         global:
>                 libperf_init;
>                 perf_cpu_map__dummy_new;
> +               perf_cpu_map__default_new;
>                 perf_cpu_map__get;
>                 perf_cpu_map__put;
>                 perf_cpu_map__new;
> diff --git a/tools/lib/perf/tests/test-cpumap.c b/tools/lib/perf/tests/test-cpumap.c
> index d39378eaf897..87b0510a556f 100644
> --- a/tools/lib/perf/tests/test-cpumap.c
> +++ b/tools/lib/perf/tests/test-cpumap.c
> @@ -14,6 +14,8 @@ static int libperf_print(enum libperf_print_level level,
>  int test_cpumap(int argc, char **argv)
>  {
>         struct perf_cpu_map *cpus;
> +       struct perf_cpu cpu;
> +       int idx;
>
>         __T_START;
>
> @@ -27,6 +29,15 @@ int test_cpumap(int argc, char **argv)
>         perf_cpu_map__put(cpus);
>         perf_cpu_map__put(cpus);
>
> +       cpus = perf_cpu_map__default_new();
> +       if (!cpus)
> +               return -1;
> +
> +       perf_cpu_map__for_each_cpu(cpu, idx, cpus)
> +               __T("wrong cpu number", cpu.cpu != -1);
> +
> +       perf_cpu_map__put(cpus);
> +
>         __T_END;
>         return tests_failed == 0 ? 0 : -1;
>  }
> --
> 2.35.1
>
