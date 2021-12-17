Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D088D4790BE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbhLQP4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:56:45 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:38475 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238637AbhLQP4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:56:44 -0500
Received: by mail-ot1-f43.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso3401010ota.5;
        Fri, 17 Dec 2021 07:56:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZmBvjhMBhpXDtrV+fsOaOtduUQbAmmh0nl183bkYI0=;
        b=JdafafUs8Oh9UBvpQkE2Kfn2clQg5o6Gyc9w30UzSewj/6gsNFyEDib/kyaIt6PwjP
         jo5dWlP+9z6ba98k7xQyME176x29tjwMm1I697F9q8oKkv1+xvmI2a/s4jTQLv3SsHcx
         GGtoB7SvDAsDLsWcTtggg0Mhbpph0ePeU1RIhBJex7xiGoVP3M2qZnLBTqPCq9wYHKhv
         axuapyyClaGwYW0H5Et4qAeCpUTMH+5acKh1nFtBdCkrzEO5Kc0SljjOBYFtkcT1NaMt
         BdbnVT4HsdSTqxhaj0SEBi2D75UgDf61RaC+H1wsyXvwegQOQdbPk07RtGGEpL1QGZrC
         g2Gg==
X-Gm-Message-State: AOAM531RXJxdJKfGXd58Z2vxPwIJlZWoclRpxL8SEs7ArFw1h7V6FL24
        ALYgXHfOB28vzZVqTGkCPuh44/FJUOT72BNyiNk=
X-Google-Smtp-Source: ABdhPJyAvLhcJfyxzSlCB4R5Gylhha2HwIKMI4/DmMLBVrqPAzHw4+kyx9p3FjD50/S+4ni1JahobJkc0kGzWh0nl9s=
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr2672300otu.254.1639756604200;
 Fri, 17 Dec 2021 07:56:44 -0800 (PST)
MIME-Version: 1.0
References: <20211216225320.2957053-1-qais.yousef@arm.com> <20211216225320.2957053-3-qais.yousef@arm.com>
In-Reply-To: <20211216225320.2957053-3-qais.yousef@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Dec 2021 16:56:33 +0100
Message-ID: <CAJZ5v0gHNS-UDBs2cGX9j7t_+YHTdqiEC0PT9XY-5=ddGZ53iQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/uclamp: Fix iowait boost escaping uclamp restriction
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Beata Michalska <Beata.Michalska@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 11:53 PM Qais Yousef <qais.yousef@arm.com> wrote:
>
> iowait_boost signal is applied independently of util and doesn't take
> into account uclamp settings of the rq. An io heavy task that is capped
> by uclamp_max could still request higher frequency because
> sugov_iowait_apply() doesn't clamp the boost via uclamp_rq_util_with()
> like effective_cpu_util() does.
>
> Make sure that iowait_boost honours uclamp requests by calling
> uclamp_rq_util_with() when applying the boost.
>
> Fixes: 982d9cdc22c9 ("sched/cpufreq, sched/uclamp: Add clamps for FAIR and RT tasks")
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  kernel/sched/cpufreq_schedutil.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 48327970552a..93dcea233c65 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -289,6 +289,7 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time)
>          * into the same scale so we can compare.
>          */
>         boost = (sg_cpu->iowait_boost * sg_cpu->max) >> SCHED_CAPACITY_SHIFT;
> +       boost = uclamp_rq_util_with(cpu_rq(sg_cpu->cpu), boost, NULL);
>         if (sg_cpu->util < boost)
>                 sg_cpu->util = boost;
>  }
> --
> 2.25.1
>
