Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848E454BD15
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358488AbiFNVzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358400AbiFNVzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:55:01 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D9B51321;
        Tue, 14 Jun 2022 14:54:53 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id 111-20020a9d0378000000b0060c2db66d44so7535665otv.6;
        Tue, 14 Jun 2022 14:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aPkt6OutKwD8jCYv2fsTMQtVwLarWjjJ5QWfFp7LHmA=;
        b=B6jxOURtCRPtUoHFXYB5QxIgQyFOFLplqOrxY/W7T/2wzRPNQH2IfWgIWnvNC8SVcX
         8fTghBGm+YWjpM7iODsaR+A0ECZZrCpFdxq8KAbfCzq5hNd+c4caEauK6oFGfaJIir+g
         Vu2j59XJXnYPpjEPM8WoiXTyCssOfl5cX/Y1fzjZEyqUEmEqpI0JwXQa7BvnH86vBel7
         LyjENLFuBe15q7L2W89WW0bH47mWYNMuToVzdCmrHVxyssZC/KaOm2Zm3KagENvhbzrB
         RWQxm8mo5IAqJm4kOmwwx4LRgCTkq+F/N/dKUDdFnenNQ8iQk+Sl84kt8MPKSHSFWNpe
         5w4g==
X-Gm-Message-State: AOAM531+HlRiMVR65cAtZDw5f+z75EjXv8DTb6APGuIhwl1ZvGyT2F6S
        Q9xoLLHa+66Mgfr3u5kQtCULWpGbaPbl9tmWoGM=
X-Google-Smtp-Source: ABdhPJx2x7GBI/4hsnXMT5Lj2uVuoEzpYooApUaaOJsZJiRbsmSXCHqSnKZ/XPjKpKm/Kx9qLrSaPdyhGjFmxwcBTLo=
X-Received: by 2002:a9d:22aa:0:b0:60c:3ab6:5ba with SMTP id
 y39-20020a9d22aa000000b0060c3ab605bamr2841192ota.247.1655243692582; Tue, 14
 Jun 2022 14:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220613094605.208401-1-yangjihong1@huawei.com> <20220613094605.208401-10-yangjihong1@huawei.com>
In-Reply-To: <20220613094605.208401-10-yangjihong1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 14 Jun 2022 14:54:41 -0700
Message-ID: <CAM9d7cijyKgCt7su96yM9OWgHP5Hh1UMQh+iBskO+m+rb_y5ww@mail.gmail.com>
Subject: Re: [RFC 09/13] perf kwork: Add workqueue report support
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
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

On Mon, Jun 13, 2022 at 2:48 AM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> Implements workqueue report function.
>
> test case:
>
>   # perf kwork -k workqueue rep
>
>     Kwork Name                | Cpu  | Total Runtime | Frequency | Max runtime   | Max runtime start   | Max runtime end     |
>    ---------------------------------------------------------------------------------------------------------------------------
>     (w)0xffffffff83e09fa0     | 0001 |   2152.678 ms |       194 |     12.376 ms |    2059361.546621 s |    2059361.558997 s |
>     (w)0xffff888332fea180     | 0000 |     17.125 ms |       301 |      1.018 ms |    2059358.441070 s |    2059358.442089 s |
>     (w)0xffff8881035a83d8     | 0007 |      7.556 ms |         3 |      3.212 ms |    2059362.614643 s |    2059362.617855 s |
>     (w)0xffff888102fc14a0     | 0002 |      7.080 ms |         5 |      1.962 ms |    2059365.421753 s |    2059365.423714 s |
>     (w)0xffffffff82f7da00     | 0000 |      4.277 ms |         7 |      3.778 ms |    2059360.851063 s |    2059360.854841 s |
>     (w)0xffffffff8305d680     | 0006 |      1.796 ms |         1 |      1.796 ms |    2059360.046818 s |    2059360.048613 s |
>     (w)0xffff8883339e9040     | 0005 |      1.659 ms |         2 |      1.619 ms |    2059361.266051 s |    2059361.267670 s |
>     (w)0xffff888333de9040     | 0007 |      1.121 ms |         5 |      0.783 ms |    2059368.238059 s |    2059368.238842 s |
>     (w)0xffff888332fe9040     | 0000 |      0.990 ms |         4 |      0.911 ms |    2059359.604075 s |    2059359.604986 s |
>     (w)0xffff8883331e9040     | 0001 |      0.244 ms |         6 |      0.046 ms |    2059362.689277 s |    2059362.689323 s |
>     (w)0xffff888102e44400     | 0007 |      0.239 ms |         2 |      0.137 ms |    2059363.117537 s |    2059363.117674 s |
>     (w)0xffff8883333ea180     | 0002 |      0.141 ms |         5 |      0.049 ms |    2059365.423784 s |    2059365.423833 s |
>     (w)0xffffffff83062f28     | 0006 |      0.084 ms |         2 |      0.047 ms |    2059358.208033 s |    2059358.208080 s |
>     (w)0xffffffff8305ca48     | 0003 |      0.078 ms |         2 |      0.041 ms |    2059361.071371 s |    2059361.071412 s |
>     (w)0xffff8883337e9040     | 0004 |      0.062 ms |         1 |      0.062 ms |    2059362.605723 s |    2059362.605785 s |
>     (w)0xffff8881035a81e8     | 0001 |      0.056 ms |         1 |      0.056 ms |    2059363.118231 s |    2059363.118287 s |
>     (w)0xffff8883335e9040     | 0003 |      0.026 ms |         1 |      0.026 ms |    2059358.573397 s |    2059358.573423 s |
>     (w)0xffffffff83062e70     | 0006 |      0.023 ms |         1 |      0.023 ms |    2059368.398864 s |    2059368.398888 s |
>     (w)0xffffffff83e06480     | 0002 |      0.000 ms |         1 |      0.000 ms |    2059359.986792 s |    2059359.986792 s |

Using "function" in the tracepoint and symbolizing it would be
far more intuitive.

Thanks,
Namhyung


>    ---------------------------------------------------------------------------------------------------------------------------
>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/builtin-kwork.c | 65 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 63 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> index 1eb416faf8ef..f27ffad223a3 100644
> --- a/tools/perf/builtin-kwork.c
> +++ b/tools/perf/builtin-kwork.c
> @@ -813,16 +813,77 @@ static struct kwork_class kwork_softirq = {
>         .cluster_name   = softirq_cluster_name,
>  };
>
> +static struct kwork_class kwork_workqueue;
> +static int process_workqueue_execute_start_event(struct perf_tool *tool,
> +                                                struct evsel *evsel,
> +                                                struct perf_sample *sample,
> +                                                struct machine *machine)
> +{
> +       struct perf_kwork *kwork = container_of(tool, struct perf_kwork, tool);
> +
> +       if (kwork->tp_handler->entry_event)
> +               return kwork->tp_handler->entry_event(kwork, &kwork_workqueue,
> +                                                   evsel, sample, machine);
> +
> +       return 0;
> +}
> +
> +static int process_workqueue_execute_end_event(struct perf_tool *tool,
> +                                              struct evsel *evsel,
> +                                              struct perf_sample *sample,
> +                                              struct machine *machine)
> +{
> +       struct perf_kwork *kwork = container_of(tool, struct perf_kwork, tool);
> +
> +       if (kwork->tp_handler->exit_event)
> +               return kwork->tp_handler->exit_event(kwork, &kwork_workqueue,
> +                                                  evsel, sample, machine);
> +
> +       return 0;
> +}
> +
>  const struct evsel_str_handler workqueue_tp_handlers[] = {
>         { "workqueue:workqueue_activate_work", NULL, },
> -       { "workqueue:workqueue_execute_start", NULL, },
> -       { "workqueue:workqueue_execute_end",   NULL, },
> +       { "workqueue:workqueue_execute_start", process_workqueue_execute_start_event, },
> +       { "workqueue:workqueue_execute_end",   process_workqueue_execute_end_event, },
>  };
>
> +static int workqueue_class_init(struct kwork_class *class,
> +                               struct perf_session *session)
> +{
> +       if (perf_session__set_tracepoints_handlers(session,
> +                                                  workqueue_tp_handlers)) {
> +               pr_debug("Failed to set workqueue tracepoints handlers\n");
> +               return -1;
> +       }
> +
> +       class->cluster_root = RB_ROOT_CACHED;
> +       return 0;
> +}
> +
> +static void workqueue_cluster_init(struct kwork_class *class,
> +                                  struct kwork_cluster *cluster,
> +                                  struct evsel *evsel,
> +                                  struct perf_sample *sample)
> +{
> +       cluster->name = NULL;
> +       cluster->class = class;
> +       cluster->cpu = sample->cpu;
> +       cluster->id = evsel__intval(evsel, sample, "work");
> +}
> +
> +static void workqueue_cluster_name(struct kwork_cluster *cluster, char *buf, int len)
> +{
> +       snprintf(buf, len, "(w)0x%" PRIx64, cluster->id);
> +}
> +
>  static struct kwork_class kwork_workqueue = {
>         .name           = "workqueue",
>         .nr_tracepoints = 3,
>         .tp_handlers    = workqueue_tp_handlers,
> +       .class_init     = workqueue_class_init,
> +       .cluster_init   = workqueue_cluster_init,
> +       .cluster_name   = workqueue_cluster_name,
>  };
>
>  static struct kwork_class *kwork_class_supported_list[KWORK_CLASS_MAX] = {
> --
> 2.30.GIT
>
