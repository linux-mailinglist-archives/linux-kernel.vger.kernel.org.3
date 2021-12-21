Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A644447BE7A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbhLUKyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhLUKyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:54:03 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708E2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 02:54:03 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bq20so27344454lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 02:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=87VcK+iQighJg5zj7ze4C2dKKB7zV4zvOTE4j5zOnU0=;
        b=n63mGF0BHKqOPr0fjceMwIl3/w93BgTojZ1jLeljtA9aec/Yow3swK/N7tRljux4WA
         2Sxv5oEQo4riOZSsCmwd/ra1Chb47+TxZBx+WuDO20NMMgvzUSt/53mLHmVDGkLRvNA6
         NoHfoKYNwgNaTZujS37Vdnaj8YKjAXwrEt4/ykvhQj8397esvRHQV7cmQJKnA+7Ft6j0
         xQn+JB9zBUm5Qxe/WZoHXqtz53xmUZ/3f0+0bm5WTjYiWc8e4kzF9X+hekoKhAUKoGLA
         8yaeifbylYaf+8hxnMXLN52KAR/WzSWdiqZS/CvEpnHptlj6k86TM5cV5t3++8geBK/u
         G5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=87VcK+iQighJg5zj7ze4C2dKKB7zV4zvOTE4j5zOnU0=;
        b=x+F6rw/vfM7TTjMscrWXl57f2Ux/xg0n/amB5cr1ZfiU/GgRA10RSagNBReZWeaQIg
         2H3pTYiI8kw+R0QaRHZPGfBQbULFZotwQVW6LOK6ZGY2WmhXQt4Y/G7lYj+8jUpDffAH
         pOvkdu1Ui5P06fQtcXZK3ps7dSJFPJRC/b6TodG9Ci7Bn43O+8a92fxKn8RNG4C4eRUT
         FzntQTCqp47vell9LQNg77kwTyegSPR8/VxmOo280DuSPRkprLfg4NcPLIOPFMPAvodJ
         LWTi8w8qHv9lNlIq6xLRu9S7tqih6piOmW8UheW5EWM60h8n4UTiBr/F3Ghbt0f+5MY4
         FzxA==
X-Gm-Message-State: AOAM532M1DpAhsaiwAtibKZyBrYXvbXc9wZ9t1J3ba2i+iElmu2Pi9EO
        FH5fFg4+CaRSDgtJO20AwffnjzWNOwT3Erhvmc/QBw==
X-Google-Smtp-Source: ABdhPJz0xRkMLtB6puzGUDl9dPVtYELrAm4NS7RWwk1vnDhc2w3eJK+dws6MPoPTeTuJLfFJRrrf5G7/Gzd73ieRUzM=
X-Received: by 2002:a05:6512:3d17:: with SMTP id d23mr2527189lfv.523.1640084041572;
 Tue, 21 Dec 2021 02:54:01 -0800 (PST)
MIME-Version: 1.0
References: <20211210093307.31701-1-mgorman@techsingularity.net> <20211210093307.31701-2-mgorman@techsingularity.net>
In-Reply-To: <20211210093307.31701-2-mgorman@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 21 Dec 2021 11:53:50 +0100
Message-ID: <CAKfTPtDPu6r3dsSmY-ZDB0k4muoSk1a2J3=NKqoBG1y8aEwNYQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/fair: Use weight of SD_NUMA domain in find_busiest_group
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021 at 10:33, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> find_busiest_group uses the child domain's group weight instead of
> the sched_domain's weight that has SD_NUMA set when calculating the
> allowed imbalance between NUMA nodes. This is wrong and inconsistent
> with find_idlest_group.

I agree that find_busiest_group and find_idlest_group should be
consistent and use the same parameters but I wonder if sched_domain's
weight is the right one to use instead of the target group's weight.

IIRC, the goal of adjust_numa_imbalance is to keep some threads on the
same node as long as we consider that there is no performance impact
because of sharing  resources as they can even take advantage of
locality if they interact. So we consider that tasks will not be
impacted by sharing resources if they use less than 25% of the CPUs of
a node. If we use the sd->span_weight instead, we consider that we can
pack threads in the same node as long as it uses less than 25% of the
CPUs in all nodes.

>
> This patch uses the SD_NUMA weight in both.
>
> Fixes: 7d2b5dd0bcc4 ("sched/numa: Allow a floating imbalance between NUMA nodes")
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6e476f6d9435..0a969affca76 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9397,7 +9397,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>                 /* Consider allowing a small imbalance between NUMA groups */
>                 if (env->sd->flags & SD_NUMA) {
>                         env->imbalance = adjust_numa_imbalance(env->imbalance,
> -                               busiest->sum_nr_running, busiest->group_weight);
> +                               busiest->sum_nr_running, env->sd->span_weight);
>                 }
>
>                 return;
> --
> 2.31.1
>
