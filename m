Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221EC52F38B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345047AbiETS7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237963AbiETS7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:59:48 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A0F195E92;
        Fri, 20 May 2022 11:59:47 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id w130so11041009oig.0;
        Fri, 20 May 2022 11:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GFbPgQEtbW912BPIItjV08RciM4FEzthIck0qttGkpk=;
        b=fDsPDHpCxd2z66DUW2lygsqMnwmm+Oemfn/HWNOJM5u3y+fwXKI7FC2OVjuDN/mdJL
         WGOIwyGxQin0Fs/iuoAB6cpUM117DT2VXt7Lwq/q9SUyjZG24V07OKFP8VCywKCIhwiq
         jHyUf1gOLSfJY5c5NRUV4ZL38Q21609njDFdgYm5TuKxLht69Hjp+KBQzZC49uwd3bmY
         nqyXw5/CTlR6pSEElBHjxqghCNN7TTrqEXgrOjIEc9D+o0aitpB2MZyI1ln4Dq15gEDi
         H+shatSm9R06b+e2fahalh/oVOIl1RUcORpFkdSLYhTOiTAojzg5Quryn7vNnKj+2wUR
         UtGg==
X-Gm-Message-State: AOAM531qC9rJ2vQT+Bq1CEm7yopMmzl2B2nyvDFYSOhlmoZtfNNpx0pw
        a0oLDhgx84YcL4WlUueXchgjurDkJmYiB+PrGFY=
X-Google-Smtp-Source: ABdhPJxqogoOMkG4+gq8mrfj4XEMfuHTadYZbi0FuE9/BP6hynPyQ+19JDm9/rtXUghz8nAXO8bAy051UWUXYYGCxss=
X-Received: by 2002:a05:6808:2218:b0:326:bd8c:d044 with SMTP id
 bd24-20020a056808221800b00326bd8cd044mr6204978oib.92.1653073187030; Fri, 20
 May 2022 11:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220422093833.340873-1-nakamura.shun@fujitsu.com> <20220422093833.340873-3-nakamura.shun@fujitsu.com>
In-Reply-To: <20220422093833.340873-3-nakamura.shun@fujitsu.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 20 May 2022 11:59:35 -0700
Message-ID: <CAM9d7cjoDXmQ=6B3zMfq_+0QNyTc-r5nBCJoKJBx98JrJjv-YA@mail.gmail.com>
Subject: Re: [PATCH 2/7] libperf: Introduce perf_{evsel, evlist}__open_opt
 with extensible struct opts
To:     Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Apr 22, 2022 at 2:44 AM Shunsuke Nakamura
<nakamura.shun@fujitsu.com> wrote:
>
> Introduce perf_{evsel, evlist}__open_opt with extensible structure opts.
> The mechanism of the extensible structure opts imitates
> tools/lib/bpf/libbpf.h. Currently, only open_flags is supported for the
> opts structure.
>
> Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> ---
[SNIP]
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index 210ea7c06ce8..00c0cea43b52 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -16,8 +16,12 @@
>  #include <internal/lib.h>
>  #include <linux/string.h>
>  #include <sys/ioctl.h>
> +#include <signal.h>
> +#include <fcntl.h>
> +#include <sys/types.h>
>  #include <sys/mman.h>
>  #include <asm/bug.h>
> +#include "internal.h"
>
>  void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
>                       int idx)
> @@ -26,6 +30,7 @@ void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
>         evsel->attr = *attr;
>         evsel->idx  = idx;
>         evsel->leader = evsel;
> +       evsel->open_flags = 0;

In general, you don't need to reset it to zero as it's allocated with
zalloc().

>  }
>
[SNIP]
> diff --git a/tools/lib/perf/internal.h b/tools/lib/perf/internal.h
> index 2c27e158de6b..4b91a087ed62 100644
> --- a/tools/lib/perf/internal.h
> +++ b/tools/lib/perf/internal.h
> @@ -20,4 +20,48 @@ do {                            \
>  #define pr_debug2(fmt, ...)     __pr(LIBPERF_DEBUG2, fmt, ##__VA_ARGS__)
>  #define pr_debug3(fmt, ...)     __pr(LIBPERF_DEBUG3, fmt, ##__VA_ARGS__)
>
> +static inline bool libperf_is_mem_zeroed(const char *p, ssize_t len)
> +{
> +       while (len > 0) {
> +               if (*p)
> +                       return false;
> +               p++;
> +               len--;
> +       }
> +       return true;
> +}
> +
> +static inline bool libperf_validate_opts(const char *opts,
> +                                        size_t opts_sz, size_t user_sz,
> +                                        const char *type_name)
> +{
> +       if (user_sz < sizeof(size_t)) {
> +               pr_warning("%s size (%zu) is too small\n", type_name, user_sz);
> +               return false;
> +       }
> +       if (!libperf_is_mem_zeroed(opts + opts_sz, (ssize_t)user_sz - opts_sz)) {

I don't think the cast is necessary since it'll be promoted again
to size_t due to opts_sz.  Instead, we can check if user_sz is
greater than opts_sz explicitly and call the function.

> +               pr_warning("%s has non-zero extra bytes\n", type_name);
> +               return false;
> +       }
> +       return true;
> +}
> +
> +#define offsetofend(TYPE, FIELD) \
> +       (offsetof(TYPE, FIELD) + sizeof(((TYPE *)0)->FIELD))
> +
> +#define OPTS_VALID(opts, type)                                                 \
> +       (!(opts) || libperf_validate_opts((const char *)opts,                   \
> +                                         offsetofend(struct type,              \
> +                                                     type##__last_field),      \
> +                                               (opts)->sz, #type))
> +#define OPTS_HAS(opts, field) \
> +       ((opts) && opts->sz >= offsetofend(typeof(*(opts)), field))
> +#define OPTS_GET(opts, field, fallback_value) \
> +       (OPTS_HAS(opts, field) ? (opts)->field : fallback_value)

It'd be nice if you add a blank line between the macros.

Thanks,
Namhyung


> +#define OPTS_SET(opts, field, value)           \
> +       do {                                    \
> +               if (OPTS_HAS(opts, field))      \
> +                       (opts)->field = value;  \
> +       } while (0)
> +
>  #endif /* __LIBPERF_INTERNAL_H */
> diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
> index 190b56ae923a..eeeb3075e092 100644
> --- a/tools/lib/perf/libperf.map
> +++ b/tools/lib/perf/libperf.map
> @@ -25,6 +25,7 @@ LIBPERF_0.0.1 {
>                 perf_evsel__enable;
>                 perf_evsel__disable;
>                 perf_evsel__open;
> +               perf_evsel__open_opts;
>                 perf_evsel__close;
>                 perf_evsel__mmap;
>                 perf_evsel__munmap;
> @@ -36,6 +37,7 @@ LIBPERF_0.0.1 {
>                 perf_evlist__new;
>                 perf_evlist__delete;
>                 perf_evlist__open;
> +               perf_evlist__open_opts;
>                 perf_evlist__close;
>                 perf_evlist__enable;
>                 perf_evlist__disable;
> --
> 2.25.1
>
