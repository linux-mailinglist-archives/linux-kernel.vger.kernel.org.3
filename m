Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A55467354
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 09:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351270AbhLCImN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239222AbhLCImK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:42:10 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67C1C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 00:38:46 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y13so8315293edd.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 00:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/hxTqolfOQ3FDOOsyAsOMku4CKIQ1N9vFZMGfezW3TA=;
        b=c5bJ1hfl8GDQNHIng0EDrHR05UK+6cbZSllOIjLNHpqkONHfwp3OH19iBbhYzw73xY
         WFMDH6Y/zHKg1yeIkfGVrIcsxBd8+Ag82nMxvTvgOL0maXpMdDAtMC42n1XVkiyS7qN6
         gT/9gNZD4fI/dNK6Dcyvgt/NEsoFeHoOPpqp915DZRiniQRngAi0xKFtrB2Waqsi60MT
         UXn3p5bAex5kW+pV3DGhT3WNwaGsA8eA/MNKy5+x4Z9suS2qolwplgouDYRhleJp+Msu
         M+9WXwcXGZN5zmCOcoydZjy7heq6PrdetXb+932jUSg66GnjvSK/hQqhynsvkW2BXYl+
         Iqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/hxTqolfOQ3FDOOsyAsOMku4CKIQ1N9vFZMGfezW3TA=;
        b=kbpe03XIxgQeIOPy+tQ7VEJQGyKZd2GSk3NepUQqfy4QobqJTLS6X8dqtrmjm1hKHS
         +kOyGnIJ73fc8bk0M/mIayNMMTcxMW5Y/hBoe+B45pi2ACm+wC3aaqqUg1/B0vAExNOq
         k7tmPvMhAbePqkuZEdC+TBnY99mEgmHnU2OjsGYFFmBp+mIhpyT06BxCMxq3J5h5Bwq8
         x0y3GnqqcWm4iJXbZKFrZWz4wj6UlDk0iAuVym9XdGnl2TZZu8/k22Dv6OuLHrRgcHAJ
         VR1J7PGMZJ7CQz+I74+B6DEGCtF19zAZT3J/b+LocScU6k84//lR0FBgsvkF7PNCofDk
         Hf/w==
X-Gm-Message-State: AOAM5311ZlR1dExIzA7RKMca6UkcdEpzq41dWFgWbp2gbMDSYsPJqc+k
        e1Df7c1yvbxUtKNzo63T64M7TRp+9rkuygvtk3A=
X-Google-Smtp-Source: ABdhPJwlrQRxHiszcP8md2A6vOTKpwQGV/cmfohOs+gXkvRYvaM08C7lLoDTwlhvLO8zm6TWB0a5Ucq/g1H4tTtKb6Y=
X-Received: by 2002:a17:906:7109:: with SMTP id x9mr21779119ejj.559.1638520725285;
 Fri, 03 Dec 2021 00:38:45 -0800 (PST)
MIME-Version: 1.0
References: <20211201151844.20488-1-mgorman@techsingularity.net> <20211201151844.20488-2-mgorman@techsingularity.net>
In-Reply-To: <20211201151844.20488-2-mgorman@techsingularity.net>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 3 Dec 2021 21:38:33 +1300
Message-ID: <CAGsJ_4z30yfw=kyBNZuSLMaCcMBmstD=bK4VOsVW3vKO3kO+fA@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/fair: Use weight of SD_NUMA domain in find_busiest_group
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 8:27 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> find_busiest_group uses the child domain's group weight instead of
> the sched_domain's weight that has SD_NUMA set when calculating the
> allowed imbalance between NUMA nodes. This is wrong and inconsistent
> with find_idlest_group.
>
> This patch uses the SD_NUMA weight in both.
>
> Fixes: c4e8f691d926 ("sched/fair: Adjust the allowed NUMA imbalance when SD_NUMA spans multiple LLCS")

Hi Mel,

sorry I might be missing something. but I have failed to figure out
where this commit is.

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

Thanks
Barry
