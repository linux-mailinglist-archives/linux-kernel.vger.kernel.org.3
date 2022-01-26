Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC9449D65C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiAZXsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:48:01 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:46621 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiAZXsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:48:01 -0500
Received: by mail-lj1-f179.google.com with SMTP id c7so1269509ljr.13;
        Wed, 26 Jan 2022 15:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A+Sex3BBAgghx3dainDFroJl2/jGVhJ6WloIeHSgRI8=;
        b=WEUFPn/4nROPJXyMvCY/9yR95srgcSo6tTFDvIrC52Eo6FHvNGp7em3tg7Q6ZDrH1A
         nSNpyW4nrcuRiuhYfpKqTwkTy3+cYpGKgxD7NjWoolaw4DcvVuMvn5qCm6ZqBFlEbm9O
         umliS1Wjy3TKoj9LCf2asZcQ/VhhvdjbyImbejUgBtkNQEtD6UOUTekiWbpjq6kNs/Pa
         /0cRqWXFR8QFKWOBl+mh/NUjvqJ1TczXlmuDGPNUP3VEokb7rbbeoKaiB9pnwXN7dzkw
         vqAg7yqWEIjiHV8ey2bOT5TBWhxFz1YXl1PvaLYeqUl3ME5PLsCd25Mo4Edc2buYj24I
         C9Pw==
X-Gm-Message-State: AOAM531GRL034LhG9Wj0nc0TWt6ZFV5yvoz2R1BguMFYxw63L4knp2b9
        IcRtiBmEfSWyR5gmpSJb4ez6X6DbSAbihImXc0M=
X-Google-Smtp-Source: ABdhPJxDR1dAZ3mHcHkrKPv4uJ4qaBJfYG91eu96AkEl7JDmy3DXCNPk0lDuyZx3OB3V/OqFfVDC6ziO69pWyjku2Gs=
X-Received: by 2002:a2e:7219:: with SMTP id n25mr1007121ljc.204.1643240879367;
 Wed, 26 Jan 2022 15:47:59 -0800 (PST)
MIME-Version: 1.0
References: <20220126151921.2519-1-changbin.du@gmail.com>
In-Reply-To: <20220126151921.2519-1-changbin.du@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 26 Jan 2022 15:47:48 -0800
Message-ID: <CAM9d7cipbsg46=UNY8-h-e9RAsqeJRcL=mi_RXbtQwQUbwPehQ@mail.gmail.com>
Subject: Re: [PATCH] perf/ftrace: system_wide collection is not effective by default
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jan 26, 2022 at 7:19 AM Changbin Du <changbin.du@gmail.com> wrote:
>
> The ftrace.target.system_wide must be set before invoking
> evlist__create_maps(), otherwise it has no effect.

Oh, right.  Thanks for pointing that out.

>
> Fixes: 53be50282269 ("perf ftrace: Add 'latency' subcommand")
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/builtin-ftrace.c | 45 ++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 21 deletions(-)
>
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index dec24dc0e767..26bff29ad277 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -1115,6 +1115,7 @@ enum perf_ftrace_subcommand {
>  int cmd_ftrace(int argc, const char **argv)
>  {
>         int ret;
> +       int (*cmd_func)(struct perf_ftrace *) = NULL;
>         struct perf_ftrace ftrace = {
>                 .tracer = DEFAULT_TRACER,
>                 .target = { .uid = UINT_MAX, },
> @@ -1221,6 +1222,28 @@ int cmd_ftrace(int argc, const char **argv)
>                 goto out_delete_filters;
>         }
>
> +       switch (subcmd) {
> +       case PERF_FTRACE_TRACE:
> +               if (!argc && target__none(&ftrace.target))
> +                       ftrace.target.system_wide = true;

We can move only this part after parse_options().

> +               cmd_func = __cmd_ftrace;
> +               break;
> +       case PERF_FTRACE_LATENCY:
> +               if (list_empty(&ftrace.filters)) {
> +                       pr_err("Should provide a function to measure\n");
> +                       parse_options_usage(ftrace_usage, options, "T", 1);
> +                       ret = -EINVAL;
> +                       goto out_delete_evlist;

Otherwise, it should go to the out_delete_filters.

> +               }
> +               cmd_func = __cmd_latency;
> +               break;
> +       case PERF_FTRACE_NONE:
> +       default:
> +               pr_err("Invalid subcommand\n");
> +               ret = -EINVAL;
> +               goto out_delete_evlist;

Ditto.

Thanks,
Namhyung


> +       }
> +
>         ret = target__validate(&ftrace.target);
>         if (ret) {
>                 char errbuf[512];
> @@ -1248,27 +1271,7 @@ int cmd_ftrace(int argc, const char **argv)
>                         goto out_delete_evlist;
>         }
>
> -       switch (subcmd) {
> -       case PERF_FTRACE_TRACE:
> -               if (!argc && target__none(&ftrace.target))
> -                       ftrace.target.system_wide = true;
> -               ret = __cmd_ftrace(&ftrace);
> -               break;
> -       case PERF_FTRACE_LATENCY:
> -               if (list_empty(&ftrace.filters)) {
> -                       pr_err("Should provide a function to measure\n");
> -                       parse_options_usage(ftrace_usage, options, "T", 1);
> -                       ret = -EINVAL;
> -                       goto out_delete_evlist;
> -               }
> -               ret = __cmd_latency(&ftrace);
> -               break;
> -       case PERF_FTRACE_NONE:
> -       default:
> -               pr_err("Invalid subcommand\n");
> -               ret = -EINVAL;
> -               break;
> -       }
> +       ret = cmd_func(&ftrace);
>
>  out_delete_evlist:
>         evlist__delete(ftrace.evlist);
> --
> 2.32.0
>
