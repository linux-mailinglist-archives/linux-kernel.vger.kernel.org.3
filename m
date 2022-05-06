Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1ED51CE0A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387673AbiEFAzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352227AbiEFAzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:55:10 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CEE1EEEA
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 17:51:29 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x18so8103713wrc.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 17:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T9MYuDJ2wsnyovw0Xu57miYdH33p/30ZPxTRJfIyzJA=;
        b=pPS8Yn/cD/N8reBU9OZpXKTZJBpyjrtfRqyIsfYJEt+noftWlP6Z3evo8SeGhVsnYW
         lhOiOSktCXj9/cTrDF0/R1KpZgx8CCBB2tPth5QA0IgGuAovOLU3NjA0H9CZW8mHIhgv
         +Kfhj36Mtf8rx2VORzvINUoocUWrrLNsU5bUhWJiPF7tX6BU48DxMDNdxVe1xjbe82Xs
         cZFDl6/t5uyOyHlaq/wQyT+qEC+OT1wXh5+EPB75EXsiRPEOTgdTPaz4IjamuQM8NayI
         e+jQpNlIhKVfNX0YbRxlqg3CHSC9TOHvBwn3wHbisfsMM7KzYJiynrPbLtVMlR/44d9d
         uRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T9MYuDJ2wsnyovw0Xu57miYdH33p/30ZPxTRJfIyzJA=;
        b=bErv7e8Xi8hjYYaqFnRlP0D1O8/ZXVX4iHRXIu/v6s6LjbEAEBHhdl668wS4nlKZT6
         VOdR9LdQKO6MP0FyhVDGIqDphYLWQCsXeTBKa2XV9F0QWACSB2J3QX8GRGIIDVVCzBqt
         UcswUIq6KD+Swca8rzy88u/3q8G8uPvfUnHEciZB3E8CevyXJIIL5E0boaGlh9fSIHhI
         RUgob45W//xv35H6k8kMbJQSUn5g2SUULQG+zRKz/P8dqbycC806Oj7FCndHrAEG++ie
         3TC9carMXVRU6H/mzaLfDkNUVXy5JKFdcIy+OjMgXZ38nA2uhmMwLpLcmJsdpPeXnKCe
         SVUg==
X-Gm-Message-State: AOAM533jTVUT/hz7JqmaRbKsjmj4Z9w3+y1TKQa2lcyuAb0qoCfidFcB
        /zQjxLGqT5y3FE9rRUcMPYlGPCMzMiVFd6OYuj8jcA==
X-Google-Smtp-Source: ABdhPJyM51mlh5mPKrHTAD9AV0uCIaZVV0ZD6NrCqJ1mSYvY0cr5B/l4IPG2mrJWRLHzCkUz27ekW1NOgB3d1Ejd1LU=
X-Received: by 2002:adf:d1e9:0:b0:20c:6c76:14d5 with SMTP id
 g9-20020adfd1e9000000b0020c6c7614d5mr543030wrd.375.1651798288308; Thu, 05 May
 2022 17:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220505165639.361733-1-adrian.hunter@intel.com> <20220505165639.361733-24-adrian.hunter@intel.com>
In-Reply-To: <20220505165639.361733-24-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 17:51:11 -0700
Message-ID: <CAP-5=fUyne-2zs7u4XUnfjVCXCzQLchLZMjxUhuMYMvHRd6DGQ@mail.gmail.com>
Subject: Re: [PATCH V1 23/23] perf tools: Allow system-wide events to keep
 their own threads
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
> System-wide events do not have threads, so do not propagate threads to
> them.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/lib/perf/evlist.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index da30e88c76b9..fe75d2cf3696 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -52,8 +52,11 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
>                 evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
>         }
>
> -       perf_thread_map__put(evsel->threads);
> -       evsel->threads = perf_thread_map__get(evlist->threads);
> +       if (!evsel->system_wide) {
> +               perf_thread_map__put(evsel->threads);
> +               evsel->threads = perf_thread_map__get(evlist->threads);
> +       }
> +
>         evlist->all_cpus = perf_cpu_map__merge(evlist->all_cpus, evsel->cpus);
>  }
>
> --
> 2.25.1
>
