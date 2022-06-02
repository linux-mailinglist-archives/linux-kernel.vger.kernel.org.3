Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C297453BBF8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 17:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbiFBP5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 11:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236679AbiFBP5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 11:57:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB76C3B02F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 08:57:01 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s24so7000793wrb.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 08:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Ig/QhQNnSaLYheTCx1UmngTcl4ocLyAvqu6aDJbhrs=;
        b=HE5pG9/aW4cFaYUi6zQUrIpflq8Rz1EmOHhp5Vv9uU3l1AcUZYYvub4GDxHpMx5KMw
         uY/vleFSi86p0QlWLGyezZ9otl0kAng0Rd3nZuX95pp/rRZlldec20Y2LTzHC+jiBqd9
         0QTTJUZlCVjvdcLONhDBx3i7TSkiZXyES1367AcQuiiMjTI21+6pzzLv3z1IFjSC4waw
         IGL/sHVyXuljO7Vjhzo7TPlUN3fyLYUlGWpxnB5Es2TQFHXCVzh3Khxx6SKyM+6jOGEx
         tPpR7YdLpJP/dBJR9nWW5ahN/GhzX9sNawbsOr2kjaQ+lykJiLPoUlblkDuHQTayp2M9
         Wnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Ig/QhQNnSaLYheTCx1UmngTcl4ocLyAvqu6aDJbhrs=;
        b=2QaW7EzWcyFb62yI2/VnrH9GDjo9BtU5bqVMctnjd0XV/Yafkm44oirKT0XyNeumgp
         zygJRP8nrek+GX2opq1HoroURaiyLG+0nYNhSYrQluSiIzxrWfnhsbdvMvFH9mUGB/lD
         /Vysogc8kGR5XnBVQCbQg9JKbKLrud1slItzd+9DpoxVRSrA5kNUGsm38te2tFX6LR1u
         lkTOEMcrQvpSDoYfzRIUOlg2th6SpeSlcjgA+CnS8rDVHp8cAkK4lHkmCCXNUXoP0kb0
         CP/MRxU7gh0405wv4SIBJkrsMLljsX//goOKX899yhKIMye01J1NsCSYiUQnUk8BYdHL
         P8Ow==
X-Gm-Message-State: AOAM530dovDxG9Tg363lzaM/YCxkHxvSdUBBJ8tshP/C/h72ZFFzP88l
        Ga0vxFCkN55njUdgAjq32ZsB6bMDKbxjmTzzp6ZaQw==
X-Google-Smtp-Source: ABdhPJz5ISXPXoE/MgUc6zgjthJZFFkewnKP4x4ZhIf/sbQktclnaMMA/XyT6n+o3tl8kLWpfpu945b4VsR6Hx2qLxM=
X-Received: by 2002:a05:6000:1acc:b0:20f:f12a:a535 with SMTP id
 i12-20020a0560001acc00b0020ff12aa535mr4463758wry.375.1654185419962; Thu, 02
 Jun 2022 08:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220602153603.1884710-1-zhengjun.xing@linux.intel.com>
In-Reply-To: <20220602153603.1884710-1-zhengjun.xing@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Jun 2022 08:56:45 -0700
Message-ID: <CAP-5=fUw2TdA_nqbhCc7GjG6+XOfst6gW4FGAeshW7xxmq64nA@mail.gmail.com>
Subject: Re: [PATCH] perf record: Support sample-read topdown metric group for
 hybrid platforms
To:     zhengjun.xing@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com
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

On Thu, Jun 2, 2022 at 8:35 AM <zhengjun.xing@linux.intel.com> wrote:
>
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>
> With the hardware TopDown metrics feature, the sample-read feature should
> be supported for a TopDown group, e.g., sample a non-topdown event and read
> a Topdown metric group. But the current perf record code errors are out.
>
> For a TopDown metric group,the slots event must be the leader of the group,
> but the leader slots event doesn't support sampling. To support sample-read
> the TopDown metric group, uses the 2nd event of the group as the "leader"
> for the purposes of sampling.
>
> Only the platform with the TopDown metric feature supports sample-read the
> topdown group. In commit acb65150a47c ("perf record: Support sample-read
> topdown metric group"), it adds arch_topdown_sample_read() to indicate
> whether the TopDown group supports sample-read, it should only work on the
> non-hybrid systems, this patch extends the support for hybrid platforms.
>
> Before:
>
>  # ./perf record -e "{cpu_core/slots/,cpu_core/cycles/,cpu_core/topdown-retiring/}:S" -a sleep 1
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cpu_core/topdown-retiring/).
> /bin/dmesg | grep -i perf may provide additional information.
>
> After:
>
>  # ./perf record -e "{cpu_core/slots/,cpu_core/cycles/,cpu_core/topdown-retiring/}:S" -a sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.238 MB perf.data (369 samples) ]
>
> Fixes: acb65150a47c ("perf record: Support sample-read topdown metric group")
> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/arch/x86/util/evsel.c   |  3 ++-
>  tools/perf/arch/x86/util/evsel.h   |  7 +++++++
>  tools/perf/arch/x86/util/topdown.c | 21 ++++-----------------
>  3 files changed, 13 insertions(+), 18 deletions(-)
>  create mode 100644 tools/perf/arch/x86/util/evsel.h
>
> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
> index ff4561b7b600..3501399cef35 100644
> --- a/tools/perf/arch/x86/util/evsel.c
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -5,6 +5,7 @@
>  #include "util/env.h"
>  #include "util/pmu.h"
>  #include "linux/string.h"
> +#include "evsel.h"
>
>  void arch_evsel__set_sample_weight(struct evsel *evsel)
>  {
> @@ -32,7 +33,7 @@ void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr)
>  }
>
>  /* Check whether the evsel's PMU supports the perf metrics */
> -static bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
> +bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
>  {
>         const char *pmu_name = evsel->pmu_name ? evsel->pmu_name : "cpu";
>
> diff --git a/tools/perf/arch/x86/util/evsel.h b/tools/perf/arch/x86/util/evsel.h
> new file mode 100644
> index 000000000000..19ad1691374d
> --- /dev/null
> +++ b/tools/perf/arch/x86/util/evsel.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _EVSEL_H
> +#define _EVSEL_H 1
> +
> +bool evsel__sys_has_perf_metrics(const struct evsel *evsel);
> +
> +#endif
> diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
> index f4d5422e9960..f81a7cfe4d63 100644
> --- a/tools/perf/arch/x86/util/topdown.c
> +++ b/tools/perf/arch/x86/util/topdown.c
> @@ -4,6 +4,7 @@
>  #include "util/pmu.h"
>  #include "util/topdown.h"
>  #include "topdown.h"
> +#include "evsel.h"
>
>  /* Check whether there is a PMU which supports the perf metrics. */
>  bool topdown_sys_has_perf_metrics(void)
> @@ -55,33 +56,19 @@ void arch_topdown_group_warn(void)
>
>  #define TOPDOWN_SLOTS          0x0400
>
> -static bool is_topdown_slots_event(struct evsel *counter)
> -{
> -       if (!counter->pmu_name)
> -               return false;
> -
> -       if (strcmp(counter->pmu_name, "cpu"))
> -               return false;
> -
> -       if (counter->core.attr.config == TOPDOWN_SLOTS)
> -               return true;
> -
> -       return false;
> -}
> -
>  /*
>   * Check whether a topdown group supports sample-read.
>   *
> - * Only Topdown metic supports sample-read. The slots
> + * Only Topdown metric supports sample-read. The slots
>   * event must be the leader of the topdown group.
>   */
>
>  bool arch_topdown_sample_read(struct evsel *leader)
>  {
> -       if (!pmu_have_event("cpu", "slots"))
> +       if (!evsel__sys_has_perf_metrics(leader))
>                 return false;
>
> -       if (is_topdown_slots_event(leader))
> +       if (leader->core.attr.config == TOPDOWN_SLOTS)
>                 return true;
>
>         return false;
> --
> 2.25.1
>
