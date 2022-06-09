Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08466544058
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 02:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbiFIAKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 20:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiFIAKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 20:10:03 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9D013CDA;
        Wed,  8 Jun 2022 17:10:00 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id c24-20020a9d4818000000b0060c2372addeso399402otf.11;
        Wed, 08 Jun 2022 17:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i3YzjZWYXJycs6wrkROezA8KHgvVM2duWk8XTiinVlQ=;
        b=HIWfbyi4oC2RfmzEJ8j2HCGR/9aB4AYyMA6qjSOSyCvQN2x13lUqJpkq7Alo9UF2jr
         sI/h08TBJ8WrftH+l1AILLtkuZw2fQBYc5TpxQtdc0jFpGCDIwLrYQKXLoreAGUQQFJq
         NoZZCoGIcJSmmbLiGltAvIyjapG/U4kwDmlJjEO8bx0V3UZZ3TDqnrN40wv+SYhHCck8
         MniMkEiHJCxnVSd+5saJLQJstXJIZ8x/6diSxaIMXthn5yaVoAnrr1L9JedonlzOVPLz
         ddyMG+cQ+CVPMfKPZo1hpn0sF5GQ2jnK2uffekfH6pnYPauRvz0v3IRPGMg/6ErLLFGO
         6P7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i3YzjZWYXJycs6wrkROezA8KHgvVM2duWk8XTiinVlQ=;
        b=YNCh8mC+zzvEy8lGLfaNgupo7QuUqGKCPWE67aIkX042JMvshau/7gDZvzlBY9LOTb
         K0L1i5qPbR4KR7VPQbuOoZkWXPmsVUigGQ4EsgeiYHIiU/w+Asqr9t81pVdl7GAv0W6o
         ILU23/0nhiYBB7dgmOfMPuLir4IQQwQHXGMiDJZhip0bEituCaWiynAF7MbEh3yT1hLj
         it9WIeX28sSBadz7vm0QcvQbiD6hMM2T/FOzbUgTysZUguFY/sdLG9OtHArGAzphNeVh
         3w51F/Dok3mS9j9qBrfyVYz9yxfAW17K2yBz92NA7FsP8WvqVO4aCMtW8ADWdnwiHh7t
         P6tA==
X-Gm-Message-State: AOAM532Iq/YpAV0HomXe5X8YlB1AWxMRPmsXmSmHbxwweFZ4u4NJ3fY5
        613sTt3eprd/W2poDExyCZIbh90PrkxqLpOFwCg=
X-Google-Smtp-Source: ABdhPJy/ZYSU7LLbrX5YXP//2zn4Q/EkT23+nyGSDv1Qbl4HLopabHpRCrGgdtOfl6K9BG7K4BksdbpKDlzk6aG1x+8=
X-Received: by 2002:a9d:7596:0:b0:60c:723:9e93 with SMTP id
 s22-20020a9d7596000000b0060c07239e93mr4810809otk.124.1654733400283; Wed, 08
 Jun 2022 17:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220607013315.1956301-1-zhengjun.xing@linux.intel.com> <20220607013315.1956301-6-zhengjun.xing@linux.intel.com>
In-Reply-To: <20220607013315.1956301-6-zhengjun.xing@linux.intel.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Wed, 8 Jun 2022 17:09:49 -0700
Message-ID: <CAM9d7ciZAZzsA=cDojZp8H5tTd-F7NC=OnTMRg3S3cdjCW0+eA@mail.gmail.com>
Subject: Re: [PATCH 5/5] perf stat: Add topdown metrics in the default perf
 stat on the hybrid machine
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, alexander.shishkin@intel.com,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 7, 2022 at 1:08 AM <zhengjun.xing@linux.intel.com> wrote:
>
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>
> Topdown metrics are missed in the default perf stat on the hybrid machine,
> add Topdown metrics in default perf stat for hybrid systems.
>
> Currently, we support the perf metrics Topdown for the p-core PMU in the
> perf stat default, the perf metrics Topdown support for e-core PMU will be
> implemented later separately. Refactor the code adds two x86 specific
> functions. Widen the size of the event name column by 7 chars, so that all
> metrics after the "#" become aligned again.
>
> The perf metrics topdown feature is supported on the cpu_core of ADL. The
> dedicated perf metrics counter and the fixed counter 3 are used for the
> topdown events. Adding the topdown metrics doesn't trigger multiplexing.
>
> Before:
>
>  # ./perf  stat  -a true
>
>  Performance counter stats for 'system wide':
>
>              53.70 msec cpu-clock                 #   25.736 CPUs utilized
>                 80      context-switches          #    1.490 K/sec
>                 24      cpu-migrations            #  446.951 /sec
>                 52      page-faults               #  968.394 /sec
>          2,788,555      cpu_core/cycles/          #   51.931 M/sec
>            851,129      cpu_atom/cycles/          #   15.851 M/sec
>          2,974,030      cpu_core/instructions/    #   55.385 M/sec
>            416,919      cpu_atom/instructions/    #    7.764 M/sec
>            586,136      cpu_core/branches/        #   10.916 M/sec
>             79,872      cpu_atom/branches/        #    1.487 M/sec
>             14,220      cpu_core/branch-misses/   #  264.819 K/sec
>              7,691      cpu_atom/branch-misses/   #  143.229 K/sec
>
>        0.002086438 seconds time elapsed
>
> After:
>
>  # ./perf stat  -a true
>
>  Performance counter stats for 'system wide':
>
>              61.39 msec cpu-clock                        #   24.874 CPUs utilized
>                 76      context-switches                 #    1.238 K/sec
>                 24      cpu-migrations                   #  390.968 /sec
>                 52      page-faults                      #  847.097 /sec
>          2,753,695      cpu_core/cycles/                 #   44.859 M/sec
>            903,899      cpu_atom/cycles/                 #   14.725 M/sec
>          2,927,529      cpu_core/instructions/           #   47.690 M/sec
>            428,498      cpu_atom/instructions/           #    6.980 M/sec
>            581,299      cpu_core/branches/               #    9.470 M/sec
>             83,409      cpu_atom/branches/               #    1.359 M/sec
>             13,641      cpu_core/branch-misses/          #  222.216 K/sec
>              8,008      cpu_atom/branch-misses/          #  130.453 K/sec
>         14,761,308      cpu_core/slots/                  #  240.466 M/sec
>          3,288,625      cpu_core/topdown-retiring/       #     22.3% retiring
>          1,323,323      cpu_core/topdown-bad-spec/       #      9.0% bad speculation
>          5,477,470      cpu_core/topdown-fe-bound/       #     37.1% frontend bound
>          4,679,199      cpu_core/topdown-be-bound/       #     31.7% backend bound
>            646,194      cpu_core/topdown-heavy-ops/      #      4.4% heavy operations       #     17.9% light operations
>          1,244,999      cpu_core/topdown-br-mispredict/  #      8.4% branch mispredict      #      0.5% machine clears
>          3,891,800      cpu_core/topdown-fetch-lat/      #     26.4% fetch latency          #     10.7% fetch bandwidth
>          1,879,034      cpu_core/topdown-mem-bound/      #     12.7% memory bound           #     19.0% Core bound
>
>        0.002467839 seconds time elapsed
>
> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> ---
[SNIP]
> +const char *arch_get_topdown_pmu_name(struct evlist *evlist, bool warn)
> +{
> +       const char *pmu_name = "cpu";
> +
> +       if (perf_pmu__has_hybrid()) {
> +               if (!evlist->hybrid_pmu_name) {
> +                       if (warn)
> +                               pr_warning
> +                                   ("WARNING: default to use cpu_core topdown events\n");
> +                       evlist->hybrid_pmu_name =
> +                           perf_pmu__hybrid_type_to_pmu("core");

This doesn't look good.  Please consider reducing the
indent level like returning early as

    if (!perf_pmu__has_hybrid())
        return "cpu";

    if (!evlist->hybrid_pmu_name) {
        ...

Thanks,
Namhyung


> +               }
> +
> +               pmu_name = evlist->hybrid_pmu_name;
> +       }
> +       return pmu_name;
> +}
