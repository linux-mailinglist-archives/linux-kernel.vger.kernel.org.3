Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDAE47D043
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 11:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244275AbhLVKru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 05:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240018AbhLVKrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 05:47:47 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77C7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 02:47:46 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id o12so4503743lfk.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 02:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sOheyfJE7P7dJwsbwxOmKy/70PxKgqALydvevJ+h1ts=;
        b=yAvRHvCTQA87VTPFuXp/r9PqeKBSMBVzKob+cvJYGeTDojtO4y7LNrJXoSSlgKq5KI
         1/JTpmK+HmHKT2DaljOv3uEC/Oh1nAPlLXeO5FCxAw7dMVsDVoj5Hb39WlTC5P4TKIWV
         48oLzsEv0+YO5lboV6IBASTUwNP8lhWej0kRubPzTqHdHW+VaVYoKdb5nCpQze5eogw2
         iCLmej5lo6F9P7lCCBo2R/zVKU2iHpclj13/19uc4nKSX4aR7bKMyJL8+sFkVQQhTOp+
         kCcDvvpBKX4wObkpWezJS1jOUzy2wqxYq7Rcij+XFwdRVJh9EdSR9MlSJOddyTTVTdbX
         rXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sOheyfJE7P7dJwsbwxOmKy/70PxKgqALydvevJ+h1ts=;
        b=mk6COOHFulFHjXHRLU+sZh0UuCcx4kGjfEC7KG4aZq/Zp4ignDd9+4DlPP0dA+YrBI
         KIKPiUb44JbPQjuGon6/T+nQT90BtyI4L4qetJd4Ib5jXUhihFUCtzglltyndntS0e6C
         AT87mWot/sVotfqAEASoeb0A+zK/z9A7A7PkNEWXJUK6AcNFilRQx0IdExqqT6nlvh6f
         V2U9biPI6DncFWXgTDr0Duf/tCaNfgv6ej1Cmuc1ljQbDYm7nmed7nW3zJkstO8S7B/X
         q561y38tDAnejZxf9QnNCXRYxiLsVeUDUSch8kI2VFtdvKtJmZhEyeRsDf7rMtrlu0Wx
         MW0w==
X-Gm-Message-State: AOAM5309z7S5pFTr03TaMUlZppvzc0Rn1I7nMlzUOM3kNOGiOwxNYWnF
        o6SybERtkwJVdZei3XsJ3XxIInGjOAGnfLZqCf0MlQ==
X-Google-Smtp-Source: ABdhPJyja+VfcTsd2oygq6VIERoUCyS6LFCxiaCbujjhwPfeCp7h8etzT0hqTiyhoP9JPNzugcvjVLlMBg5i921ONyQ=
X-Received: by 2002:ac2:52a4:: with SMTP id r4mr2039255lfm.645.1640170065183;
 Wed, 22 Dec 2021 02:47:45 -0800 (PST)
MIME-Version: 1.0
References: <20211211104324.95957-1-yangyicong@hisilicon.com>
In-Reply-To: <20211211104324.95957-1-yangyicong@hisilicon.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 22 Dec 2021 11:47:34 +0100
Message-ID: <CAKfTPtCaxGhpGk348Q8jGcEA13Xv4VHS+nX0aW4C+ba5df_4Lw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Track target domain's avg_scan_cost in select_idle_cpu
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, prime.zeng@huawei.com, linuxarm@huawei.com,
        21cnbao@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Dec 2021 at 11:43, Yicong Yang <yangyicong@hisilicon.com> wrote:
>
> We regulate the LLC domain scan in select_idle_cpu() by comparing
> the average scan cost of this_sd against the average idle time of
> this_rq. This is correct when the domain to scan is the LLC domain
> of this cpu. But when the domain to scan is different from this
> LLC domain, we'll have an inaccurate estimation of the scan cost
> on the target domain as this_sd->avg_scan_cost contains contributions
> of scanning other domains besides the target domain.
>
> Track the avg_scan_cost of the target domain to make the estimation
> more accurate.
>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6e476f6d9435..6301740d98cb 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6267,7 +6267,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>                 }
>
>                 avg_idle = this_rq->wake_avg_idle;
> -               avg_cost = this_sd->avg_scan_cost + 1;
> +               avg_cost = sd->avg_scan_cost + 1;
>
>                 span_avg = sd->span_weight * avg_idle;
>                 if (span_avg > 4*avg_cost)
> @@ -6305,7 +6305,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>                  */
>                 this_rq->wake_avg_idle -= min(this_rq->wake_avg_idle, time);
>
> -               update_avg(&this_sd->avg_scan_cost, time);
> +               update_avg(&sd->avg_scan_cost, time);

But then you can have several cpus updating the same value simultaneously

>         }
>
>         return idle_cpu;
> --
> 2.33.0
>
