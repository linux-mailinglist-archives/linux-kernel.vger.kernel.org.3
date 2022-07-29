Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E4B5851E4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237267AbiG2O6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236896AbiG2O57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:57:59 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401C52B279;
        Fri, 29 Jul 2022 07:57:58 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-3238de26fb1so35375027b3.8;
        Fri, 29 Jul 2022 07:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1H1bSZWTf16Y6ODfrCJEATSFR15qWcwfFZg2sB/p8YY=;
        b=SsznLkPTLrKgWndEL5qgPAOKzbGR5B9ItMXhPyu5pHX+Du7PhWVOxEE/L2QrwGjy/Q
         ogN41aaIGJpO5/4U5tQ9mny7RK3piSVGzLR9qCT2qO1nE/MpXS0gW6I8DzMkDek7jd0r
         OcNVau1VUC9A8dLdyJ+bfrOdRPMkSEFHyjZmY95UM4etqemgSQGBYmMfNrMUAJjcucMm
         /tqxe0iVyo9B0goxxH0Ej3T0T+gSbs3G5Di/CayMPPcP/FrpcOh1yo4VuNCwP3v4sDcO
         y6TEHp/xBibZe1YLPp/hAze6qeWMflDaKSN/1e68XcvF71Pt6Ry2cJBnWTPo/8tLWvXQ
         XqPQ==
X-Gm-Message-State: ACgBeo2WPg6PCE8uxvKs1IApRPSbGobH9jJun09Q8Xy5qiaRiCqC3dNe
        lNRgm28KkQvlMlgLtjpmZgEhb3k4Aa5RgKOrGp4ZHgVM
X-Google-Smtp-Source: AA6agR5JDKOWKLSjvZ+1g6Ix6fu6JH58vV+VFoqN7KldDltK9s7rP50KmNFiXJBTFMtpfL6tgm64dFKvkFS5bB4BU4I=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr3331463ywb.326.1659106677210; Fri, 29
 Jul 2022 07:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <Yt/AxPFi88neW7W5@e126311.manchester.arm.com>
In-Reply-To: <Yt/AxPFi88neW7W5@e126311.manchester.arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 29 Jul 2022 16:57:46 +0200
Message-ID: <CAJZ5v0gqofRdBEzBefcB6mH9rDp=fm-p-Eqyn4SozUjsyxdttw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Add cpu_idle_miss trace event
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 12:24 PM Kajetan Puchalski
<kajetan.puchalski@arm.com> wrote:
>
> Add a trace event for cpuidle to track missed (too deep or too shallow)
> wakeups.
>
> After each wakeup, CPUIdle already computes whether the entered state was
> optimal, above or below the desired one and updates the relevant
> counters. This patch makes it possible to trace those events in addition
> to just reading the counters.
>
> The patterns of types and percentages of misses across different
> workloads appear to be very consistent. This makes the trace event very
> useful for comparing the relative correctness of different CPUIdle
> governors for different types of workloads, or for finding the
> optimal governor for a given device.
>
> Signed-off-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
> ---
>  drivers/cpuidle/cpuidle.c    |  6 +++++-
>  include/trace/events/power.h | 22 ++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index ef2ea1b12cd8..bf57cab32456 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -8,6 +8,7 @@
>   * This code is licenced under the GPL.
>   */
>
> +#include "linux/percpu-defs.h"
>  #include <linux/clockchips.h>
>  #include <linux/kernel.h>
>  #include <linux/mutex.h>
> @@ -278,6 +279,7 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>
>                                 /* Shallower states are enabled, so update. */
>                                 dev->states_usage[entered_state].above++;
> +                               trace_cpu_idle_miss(dev->cpu, entered_state, false);
>                                 break;
>                         }
>                 } else if (diff > delay) {
> @@ -289,8 +291,10 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>                                  * Update if a deeper state would have been a
>                                  * better match for the observed idle duration.
>                                  */
> -                               if (diff - delay >= drv->states[i].target_residency_ns)
> +                               if (diff - delay >= drv->states[i].target_residency_ns) {
>                                         dev->states_usage[entered_state].below++;
> +                                       trace_cpu_idle_miss(dev->cpu, entered_state, true);
> +                               }
>
>                                 break;
>                         }
> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index af5018aa9517..6539f23a5653 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -40,6 +40,28 @@ DEFINE_EVENT(cpu, cpu_idle,
>         TP_ARGS(state, cpu_id)
>  );
>
> +TRACE_EVENT(cpu_idle_miss,
> +
> +       TP_PROTO(unsigned int cpu_id, unsigned int state, bool below),
> +
> +       TP_ARGS(cpu_id, state, below),
> +
> +       TP_STRUCT__entry(
> +               __field(u32,            cpu_id)
> +               __field(u32,            state)
> +               __field(bool,           below)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->cpu_id = cpu_id;
> +               __entry->state = state;
> +               __entry->below = below;
> +       ),
> +
> +       TP_printk("cpu_id=%lu state=%lu type=%s", (unsigned long)__entry->cpu_id,
> +               (unsigned long)__entry->state, (__entry->below)?"below":"above")
> +);
> +
>  TRACE_EVENT(powernv_throttle,
>
>         TP_PROTO(int chip_id, const char *reason, int pmax),
>
> base-commit: e0dccc3b76fb35bb257b4118367a883073d7390e
> --

Applied as 5.20 material with the R-by tag from Steve, thanks!
