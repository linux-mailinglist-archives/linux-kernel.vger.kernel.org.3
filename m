Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0D95835BB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 01:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiG0Xm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 19:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiG0XmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 19:42:25 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440E550722;
        Wed, 27 Jul 2022 16:42:24 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-10e634ecfe6so417384fac.8;
        Wed, 27 Jul 2022 16:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ggGhafiQSoObvuIzk40BM1h75vEIevml1tUUWyMjv4k=;
        b=fkuuJE549XHd8KRH5z5dMRtKU6J+8jjxap72m6YN6xS3WWXGhHvMmAF/f4fn26SeUV
         ZiuU/hh+0dVLjWIZxiCrf6a5pnYk+8L1ji5chcxXh3X2tDOc0bqu2TNQFRUEPIjuaBzb
         SDvGrHqmLYB9TdyYWZke7nPP/KKuUSOJOQaOj3Qg6q+hMOWOP3/Wwfby0bq2PKSqYrI1
         /QYDxXSXH+KBD91cPO/9vamhZyumrxpuj75hvAftwpf+kN3SkIOe+aSYbJ5F04uefyYP
         fAF6475L/VG4mfGAab5RmU7DXyna8QIEnhUR6Z0mlbdcWt+8PwPuOZUw0rTecfSjYKuw
         F8Sw==
X-Gm-Message-State: AJIora9w2OZOIB4YAcviPm8gngXd7ORgFdng6VC9WGbrABVc/Em2rucq
        omqq7cCH6scDckr3IVajhNqaHEe7HSw23dRbgq8=
X-Google-Smtp-Source: AGRyM1u0z0sUEAQIJebXkwFyW6QqvqkGZMUOJv32L5q1iPSkhOMH0l1Fo4ph4AxqZqeKKnCmWRWWRTs4dnrNsDnG7FM=
X-Received: by 2002:a05:6870:a182:b0:10b:efbe:e65d with SMTP id
 a2-20020a056870a18200b0010befbee65dmr3438317oaf.5.1658965343585; Wed, 27 Jul
 2022 16:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220709015033.38326-1-yangjihong1@huawei.com> <20220709015033.38326-3-yangjihong1@huawei.com>
In-Reply-To: <20220709015033.38326-3-yangjihong1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 27 Jul 2022 16:42:12 -0700
Message-ID: <CAM9d7civBT2-u0C1rK6OvSLAT7fzXRb8ku4xaHbF3wbUv+m1rw@mail.gmail.com>
Subject: Re: [RFC v3 02/17] perf kwork: Add irq kwork record support
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Paul Clarke <pc@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 6:53 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> Record interrupt events irq:irq_handler_entry & irq_handler_exit
>
> Test cases:
>
>  # perf kwork record -o perf_kwork.date -- sleep 1
>   [ perf record: Woken up 0 times to write data ]
>   [ perf record: Captured and wrote 0.556 MB perf_kwork.date ]
>   #
>   # perf evlist -i perf_kwork.date
>   irq:irq_handler_entry
>   irq:irq_handler_exit
>   dummy:HG
>   # Tip: use 'perf evlist --trace-fields' to show fields for tracepoint events
>   #
>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/Documentation/perf-kwork.txt |  2 +-
>  tools/perf/builtin-kwork.c              | 15 ++++++++++++++-
>  tools/perf/util/kwork.h                 |  1 +
>  3 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-kwork.txt b/tools/perf/Documentation/perf-kwork.txt
> index dc1e36da57bb..57bd5fa7d5c9 100644
> --- a/tools/perf/Documentation/perf-kwork.txt
> +++ b/tools/perf/Documentation/perf-kwork.txt
> @@ -32,7 +32,7 @@ OPTIONS
>
>  -k::
>  --kwork::
> -       List of kwork to profile
> +       List of kwork to profile (irq, etc)
>
>  -v::
>  --verbose::
> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> index f3552c56ede3..a26b7fde1e38 100644
> --- a/tools/perf/builtin-kwork.c
> +++ b/tools/perf/builtin-kwork.c
> @@ -25,7 +25,20 @@
>  #include <linux/time64.h>
>  #include <linux/zalloc.h>
>
> +const struct evsel_str_handler irq_tp_handlers[] = {
> +       { "irq:irq_handler_entry", NULL, },
> +       { "irq:irq_handler_exit",  NULL, },
> +};
> +
> +static struct kwork_class kwork_irq = {
> +       .name           = "irq",
> +       .type           = KWORK_CLASS_IRQ,
> +       .nr_tracepoints = 2,

Nit: I don't think it's gonna change frequently but
it'd be better to use ARRAY_SIZE(irq_tp_handlers)
for future changes.

Thanks,
Namhyung


> +       .tp_handlers    = irq_tp_handlers,
> +};
> +
>  static struct kwork_class *kwork_class_supported_list[KWORK_CLASS_MAX] = {
> +       [KWORK_CLASS_IRQ]       = &kwork_irq,
>  };
>
>  static void setup_event_list(struct perf_kwork *kwork,
> @@ -132,7 +145,7 @@ int cmd_kwork(int argc, const char **argv)
>         OPT_BOOLEAN('D', "dump-raw-trace", &dump_trace,
>                     "dump raw trace in ASCII"),
>         OPT_STRING('k', "kwork", &kwork.event_list_str, "kwork",
> -                  "list of kwork to profile"),
> +                  "list of kwork to profile (irq, etc)"),
>         OPT_BOOLEAN('f', "force", &kwork.force, "don't complain, do it"),
>         OPT_END()
>         };
> diff --git a/tools/perf/util/kwork.h b/tools/perf/util/kwork.h
> index 6950636aab2a..f1d89cb058fc 100644
> --- a/tools/perf/util/kwork.h
> +++ b/tools/perf/util/kwork.h
> @@ -13,6 +13,7 @@
>  #include <linux/bitmap.h>
>
>  enum kwork_class_type {
> +       KWORK_CLASS_IRQ,
>         KWORK_CLASS_MAX,
>  };
>
> --
> 2.30.GIT
>
