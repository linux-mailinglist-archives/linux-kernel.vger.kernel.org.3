Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BF249EC66
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344002AbiA0UVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343981AbiA0UVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:21:22 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74338C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:21:21 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id m4so8417208ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zteXgpZ/JH4IqimdwPBayrW7aIOlMpDuJVk4lYJ5/YU=;
        b=WaiASpp09I4cE41LfRl1IYElP2t6jW/Urgc9CLi/V/9T1HmCIjuqjmzUjKMrfq1BWv
         9VlKEWW9pcyZcKsHjqC10GF4CyH+P4+r4341qe4OSmg0M5Fy7dZrAHtngVabykR9Uvft
         6RpAKb2PPUpdmvw/wtlEc+6ZP1F/xVcPSlirRFFwpKBqjncJ+UxNzk4/XCA+XxRAJWNf
         GZx2w8q4jrJnWLdPkMvpEvWQDV7Gz507O8K1KykA95mcAy38Hf6vCdaSNBe/UVu1eB56
         n8Ne6oPzgkvz8nrMoX5aCgcSH+g0pEy1kPvtG8lvm7ST/AdHV+nkLbO9wBmyMqv6B+2q
         qOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zteXgpZ/JH4IqimdwPBayrW7aIOlMpDuJVk4lYJ5/YU=;
        b=bgneGRXfW5SIOpl12VWfezjfsCzFgGa2cyQ/CEyBO9I+BoAyj0l5dANWhLMcb/WRin
         6fI3oh0and4BLSikez1XuPNcJpghw6QAlqJeOVCLvzGfuumGwzDEfkypf56DPSRBWUGi
         1MieP1vjpsgqCD1ows3H+x8nKEO0levkp7KkoZTLqPfZBwqGrEaRB/xw7N0mvLgUAHkL
         SmGxjw1GritszTHh01J6Erm7qRlca2JKcdZZxrCcPscniug7QGS/YJZvFpC/+npDm6d7
         A/C4CArllJY3p6Gsc/JlqX7zkt8QUL0M1TKYps8dtDzJDTVnzXzmI3WuUpGEYSbthizD
         UOIw==
X-Gm-Message-State: AOAM533Nwtgbh7/ZpydITl7twImfvOgRrj8xwtaeAhuzC7VZ0xOO+BvO
        Q9kcLC817LfjhWmMfHbGzWXKKjfVsJCMjtsGJkY=
X-Google-Smtp-Source: ABdhPJx5JZCIJRCofzXsOZZYujBAN5o9bM+cU4dUvHmF2uHF7ZRIAKghbvkM75vJucUsEuQWQFLmF5p1D8jnck5thYg=
X-Received: by 2002:a17:907:60cf:: with SMTP id hv15mr4127275ejc.702.1643314879801;
 Thu, 27 Jan 2022 12:21:19 -0800 (PST)
MIME-Version: 1.0
References: <20220126080947.4529-1-yangyicong@hisilicon.com>
 <20220126080947.4529-3-yangyicong@hisilicon.com> <YfK9DSMFabjYm/MV@BLR-5CG11610CF.amd.com>
In-Reply-To: <YfK9DSMFabjYm/MV@BLR-5CG11610CF.amd.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 28 Jan 2022 09:21:08 +1300
Message-ID: <CAGsJ_4xL3tynB9P=rKMoX2otW4bMMU5Z-P9zSudMV3+fr2hpXw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc:     Yicong Yang <yangyicong@hisilicon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        prime.zeng@huawei.com,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        ego@linux.vnet.ibm.com,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Linuxarm <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Guodong Xu <guodong.xu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 4:41 AM Gautham R. Shenoy
<gautham.shenoy@amd.com> wrote:
>
> On Wed, Jan 26, 2022 at 04:09:47PM +0800, Yicong Yang wrote:
> > From: Barry Song <song.bao.hua@hisilicon.com>
> >
> > For platforms having clusters like Kunpeng920, CPUs within the same
> > cluster have lower latency when synchronizing and accessing shared
> > resources like cache. Thus, this patch tries to find an idle cpu
> > within the cluster of the target CPU before scanning the whole LLC
> > to gain lower latency.
> >
> > Note neither Kunpeng920 nor x86 Jacobsville supports SMT, so this
> > patch doesn't consider SMT for this moment.
> >
> > Testing has been done on Kunpeng920 by pinning tasks to one numa
> > and two numa. On Kunpeng920, Each numa has 8 clusters and each
> > cluster has 4 CPUs.
> >
> > With this patch, We noticed enhancement on tbench within one
> > numa or cross two numa.
> >
> > On numa 0:
> >                             5.17-rc1                patched
> > Hmean     1        324.73 (   0.00%)      378.01 *  16.41%*
> > Hmean     2        645.36 (   0.00%)      754.63 *  16.93%*
> > Hmean     4       1302.09 (   0.00%)     1507.54 *  15.78%*
> > Hmean     8       2612.03 (   0.00%)     2982.57 *  14.19%*
> > Hmean     16      5307.12 (   0.00%)     5886.66 *  10.92%*
> > Hmean     32      9354.22 (   0.00%)     9908.13 *   5.92%*
> > Hmean     64      7240.35 (   0.00%)     7278.78 *   0.53%*
> > Hmean     128     6186.40 (   0.00%)     6187.85 (   0.02%)
> >
> > On numa 0-1:
> >                             5.17-rc1                patched
> > Hmean     1        320.01 (   0.00%)      378.44 *  18.26%*
> > Hmean     2        643.85 (   0.00%)      752.52 *  16.88%*
> > Hmean     4       1287.36 (   0.00%)     1505.62 *  16.95%*
> > Hmean     8       2564.60 (   0.00%)     2955.29 *  15.23%*
> > Hmean     16      5195.69 (   0.00%)     5814.74 *  11.91%*
> > Hmean     32      9769.16 (   0.00%)    10872.63 *  11.30%*
> > Hmean     64     15952.50 (   0.00%)    17281.98 *   8.33%*
> > Hmean     128    13113.77 (   0.00%)    13895.20 *   5.96%*
> > Hmean     256    10997.59 (   0.00%)    11244.69 *   2.25%*
> > Hmean     512    14623.60 (   0.00%)    15526.25 *   6.17%*
> >
> > This will also help to improve the MySQL. With MySQL server
> > running on numa 0 and client running on numa 1, both QPS and
> > latency is imporved on read-write case:
> >                         5.17-rc1        patched
> > QPS-16threads        143333.2633    145077.4033(+1.22%)
> > QPS-24threads        195085.9367    202719.6133(+3.91%)
> > QPS-32threads        241165.6867      249020.74(+3.26%)
> > QPS-64threads        244586.8433    253387.7567(+3.60%)
> > avg-lat-16threads           2.23           2.19(+1.19%)
> > avg-lat-24threads           2.46           2.36(+3.79%)
> > avg-lat-36threads           2.66           2.57(+3.26%)
> > avg-lat-64threads           5.23           5.05(+3.44%)
> >
> > Tested-by: Yicong Yang <yangyicong@hisilicon.com>
> > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > ---
> >  kernel/sched/fair.c | 46 +++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 42 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 5146163bfabb..2f84a933aedd 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6262,12 +6262,46 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
> >
> >  #endif /* CONFIG_SCHED_SMT */
> >
> > +#ifdef CONFIG_SCHED_CLUSTER
> > +/*
> > + * Scan the cluster domain for idle CPUs and clear cluster cpumask after scanning
> > + */
> > +static inline int scan_cluster(struct task_struct *p, int prev_cpu, int target)
> > +{
> > +     struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> > +     struct sched_domain *sd = rcu_dereference(per_cpu(sd_cluster, target));
> > +     int cpu, idle_cpu;
> > +
> > +     /* TODO: Support SMT case while a machine with both cluster and SMT born */
> > +     if (!sched_smt_active() && sd) {
> > +             for_each_cpu_and(cpu, cpus, sched_domain_span(sd)) {
> > +                     idle_cpu = __select_idle_cpu(cpu, p);
> > +                     if ((unsigned int)idle_cpu < nr_cpumask_bits)
> > +                             return idle_cpu;
> > +             }
> > +
> > +             /* Don't ping-pong tasks in and out cluster frequently */
> > +             if (cpus_share_resources(target, prev_cpu))
> > +                     return target;
>
> We reach here when there aren't any idle CPUs within the
> cluster. However there might be idle CPUs in the MC domain. Is a busy
> @target preferable to a potentially idle CPU within the larger domain
> ?

Hi Gautham,

My benchmark showed some performance regression while load was medium or above
if we grabbed idle cpu in and out the cluster. it turned out the
regression disappeared if
we blocked the ping-pong. so the logic here is that if we have scanned
and found an
idle cpu within the cluster before, we don't let the task jumping back
and forth frequently
as cache synchronization is higher cost. but the code still allows
scanning out of the cluster
if we haven't packed waker and wakee together yet.

it might not be a universal win in all kinds of workload. we saw
tbench, mysql benefit from
the whole change. but pgbench seems not always. so we are still on the
way to make possible
further tuning here.

>
>
> --
> Thanks and Regards
> gautham.

Thanks
Barry
