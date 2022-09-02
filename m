Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23875AA809
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbiIBG3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiIBG3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:29:34 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C1CA5726;
        Thu,  1 Sep 2022 23:29:33 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso831115otb.6;
        Thu, 01 Sep 2022 23:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hBGBH/+TJrRnJKDPQdaZcWqC9vhka6qkw0n5az1cQDA=;
        b=rzTMPp54fOuExCITXYdRmIc/IYspfC/aBMSkw+PYkBZgoHEpnutFlrUpyZt1igzH0h
         WBB0P45/8m6vVfwQSL63ecxbe/xiWKQbh+gvcUdmOM4Oj43Qmane6YQWNQdFgQy8ewja
         bvKmKpyVKEBWc+TdAlNvofGciJdcRV1W9P6GKSKIiS2ek5628POtxoAtNx9gafrhsGKS
         h9wX9jU/5OCA1qYCrHUGmjMJRJpcKeObTzfvXCXvFaZo3vtwbnF+G0P+CWDVxsEYMRts
         lIrdJLtbLKArtkD8Rfh3oUppvAmFC0zjsraIOdR13D1+Td4yug2Ml51cEpTjwrwTy5lu
         PFug==
X-Gm-Message-State: ACgBeo3IrUa+Bj2A3iKDHTakuZKG3whZssdGqjVvBtNcUavQ8ln14sQ6
        i3Xdm2Hoy41N43mysl+w9Du6Ef26j6+f6j1sHRA=
X-Google-Smtp-Source: AA6agR762yC8dOLn9FQ/B7W+c6yYXUh0q82icyZKtjXuoWy6vMDsUlU+lRO/mt2aqswuWEeRXwgz5Ne7fcCoVwp/MuQ=
X-Received: by 2002:a9d:6f18:0:b0:638:b4aa:a546 with SMTP id
 n24-20020a9d6f18000000b00638b4aaa546mr13373103otq.124.1662100172989; Thu, 01
 Sep 2022 23:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220831174926.579643-1-irogers@google.com> <20220831174926.579643-5-irogers@google.com>
In-Reply-To: <20220831174926.579643-5-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 1 Sep 2022 23:29:22 -0700
Message-ID: <CAM9d7cgRb6_jFXCfoZZ+=K5WSH42hj4U2ZH-i-4oZTMKw+LAiA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] perf topology: Add core_wide
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com, ahmad.yasin@intel.com,
        Stephane Eranian <eranian@google.com>
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

Hi Ian,

On Wed, Aug 31, 2022 at 10:50 AM Ian Rogers <irogers@google.com> wrote:
>
> It is possible to optimize metrics when all SMT threads (CPUs) on a
> core are measuring events in system wide mode. For example, TMA
> metrics defines CORE_CLKS for Sandybrdige as:
>
> if SMT is disabled:
>   CPU_CLK_UNHALTED.THREAD
> if SMT is enabled and recording on all SMT threads:
>   CPU_CLK_UNHALTED.THREAD_ANY / 2
> if SMT is enabled and not recording on all SMT threads:
>   (CPU_CLK_UNHALTED.THREAD/2)*
>   (1+CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE/CPU_CLK_UNHALTED.REF_XCLK )
>
> That is two more events are necessary when not gathering counts on all
> SMT threads. To distinguish all SMT threads on a core vs system wide
> (all CPUs) call the new property core wide.  Add a core wide test that
> determines the property from user requested CPUs, the topology and
> system wide. System wide is required as other processes running on a
> SMT thread will change the counts.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
[SNIP]
> diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
> index ce90c4ee4138..994e9e418227 100644
> --- a/tools/perf/util/smt.c
> +++ b/tools/perf/util/smt.c
> @@ -21,3 +21,17 @@ bool smt_on(const struct cpu_topology *topology)
>         cached = true;
>         return cached_result;
>  }
> +
> +bool core_wide(bool system_wide, const char *user_requested_cpu_list,
> +              const struct cpu_topology *topology)
> +{
> +       /* If not everything running on a core is being recorded then we can't use core_wide. */
> +       if (!system_wide)
> +               return false;

I'm not sure if it's correct.  Wouldn't it be ok if it runs on all
threads in a core
even if system wide is off?  I thought that's what the below code checks.

In fact I thought the opposite logic like

    if (system_wide)
        return true;

But it seems the code allows to have cpu_list in the system wide mode.
Then it also needs to check the user requested cpus being NULL.
(IMHO system_wide should be cleared when it has a cpu list...)

    if (system_wide && !user_requested_cpu_list)
        return true;

And if we have a target pointer, we could add this too.

    if (!target__has_cpu(target))
        return false;

Thanks,
Namhyung


> +
> +       /* Cheap case that SMT is disabled and therefore we're inherently core_wide. */
> +       if (!smt_on(topology))
> +               return true;
> +
> +       return cpu_topology__core_wide(topology, user_requested_cpu_list);
> +}
> diff --git a/tools/perf/util/smt.h b/tools/perf/util/smt.h
> index e26999c6b8d4..ae9095f2c38c 100644
> --- a/tools/perf/util/smt.h
> +++ b/tools/perf/util/smt.h
> @@ -7,4 +7,11 @@ struct cpu_topology;
>  /* Returns true if SMT (aka hyperthreading) is enabled. */
>  bool smt_on(const struct cpu_topology *topology);
>
> +/*
> + * Returns true when system wide and all SMT threads for a core are in the
> + * user_requested_cpus map.
> + */
> +bool core_wide(bool system_wide, const char *user_requested_cpu_list,
> +              const struct cpu_topology *topology);
> +
>  #endif /* __SMT_H */
> --
> 2.37.2.672.g94769d06f0-goog
>
