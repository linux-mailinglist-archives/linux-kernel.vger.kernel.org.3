Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CA647D081
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244404AbhLVLGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244385AbhLVLGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:06:19 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3183C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 03:06:18 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z29so7126092edl.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 03:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3GJ2M7D00c9DrjeKXYAsHrRWfIE9Y74Q5SgYDeIG00E=;
        b=pYJ4JxftgjRqtfoMgc4081dUripTuSoYBTTM62uOp1tt3/GabyzCz55hcejgjUlOtr
         uZmoyUD4Fis/YSXDEAYh0pd+7wu1cIIZ2JAuHDmBcVdwGIuVC5iTj97wi05/cmwQs5gF
         niC5dqXsCKOz/5PKniVM9rAfGDEzQToPeOiQxIul91LKBD+RTiAFxtbJrkRxFVpcL5Th
         C91xqlNA0gUWSMy3kQ36Q5olqq7zyffx8hLhBcyQlwLZbKBX0VmUaaCSzwWf5LuAXzij
         u/N1eaMJeyVvqkrMSJ5VWIM3AanmihSk2lz+KnhiFx2P9W6ZcE8g5J8GYQ111+OPLs/8
         nSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3GJ2M7D00c9DrjeKXYAsHrRWfIE9Y74Q5SgYDeIG00E=;
        b=mm+bleYKViMrIP63IomDJN8FrjtQs+DArDZSWfQvrlksOvR9eB4E7xvjTrDlIesjYy
         f4uB6PZhlxroxtKi4feqGafkreGPTXv0I6OKaWVaodFH/2UExErRXT6yLpCT8EK3Mqk1
         HSh+/lHNtkx4v1WIg+y2T8NXz5EZ609iDbUisYPejSxnjP4rxgVnRszGtU5mX4G/E7/M
         MoWyH7G3YFKrBPpSt3xJcyHCikawQ3DWKJ2CyspwbfndJJ9HxoF1mmi/zd87bnJBiAYp
         YzhB5d8li/v2hOcSGNp3m4eAGZCb8IjCfv/7di7QsoTsaQrS0XYiJlbGFNVURz2kxra4
         Aj5w==
X-Gm-Message-State: AOAM532+A9W1SzQ4LEYFWH3EHZeBGjblCURelbJtpaVcBK8w+O4EHmVG
        9NJfHr+i1z28LeJXdBbydegCF4SztasihrlpjbI=
X-Google-Smtp-Source: ABdhPJxxeK4wdEZ/KpoifPgoa5FXJ+6SBhtfvNfRrMEjJks0QR6WMqLEztZ/GC7Wsy8gYEL4zIEc0uEetqgqXCDPf2A=
X-Received: by 2002:a05:6402:891:: with SMTP id e17mr2418777edy.227.1640171177332;
 Wed, 22 Dec 2021 03:06:17 -0800 (PST)
MIME-Version: 1.0
References: <20211215041149.73171-1-yangyicong@hisilicon.com>
 <20211215041149.73171-2-yangyicong@hisilicon.com> <YcL80lUZi4f9zqjB@BLR-5CG11610CF.amd.com>
In-Reply-To: <YcL80lUZi4f9zqjB@BLR-5CG11610CF.amd.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 23 Dec 2021 00:06:05 +1300
Message-ID: <CAGsJ_4y_G74f1KEze__i_1qFOF30DMWaD=R3ww8rvvRMHvPELA@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched: Add per_cpu cluster domain info and
 cpus_share_cluster API
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

On Wed, Dec 22, 2021 at 11:24 PM Gautham R. Shenoy
<gautham.shenoy@amd.com> wrote:
>
> Hello Yicong, Barry,
>
>
> On Wed, Dec 15, 2021 at 12:11:48PM +0800, Yicong Yang wrote:
> > From: Barry Song <song.bao.hua@hisilicon.com>
> >
> > Add per-cpu cluster domain info and cpus_share_cluster() API.
> > This is the preparation for the optimization of select_idle_cpu()
> > on platforms with cluster scheduler level.
> >
> > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > ---
> >  include/linux/sched/sd_flags.h |  5 +++++
> >  include/linux/sched/topology.h |  8 +++++++-
> >  kernel/sched/core.c            | 12 ++++++++++++
> >  kernel/sched/sched.h           |  2 ++
> >  kernel/sched/topology.c        |  9 +++++++++
> >  5 files changed, 35 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
> > index 57bde66d95f7..0f732bcfbb2c 100644
> > --- a/include/linux/sched/sd_flags.h
> > +++ b/include/linux/sched/sd_flags.h
> > @@ -109,6 +109,11 @@ SD_FLAG(SD_ASYM_CPUCAPACITY_FULL, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
> >   */
> >  SD_FLAG(SD_SHARE_CPUCAPACITY, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
> >
> > +/*
> > + * Set up for cluster domains sharing resources such as llc tags or l2
> > + */
> > +SD_FLAG(SD_CLUSTER, SDF_NEEDS_GROUPS)
> > +
> >  /*
> >   * Domain members share CPU package resources (i.e. caches)
> >   *
> > diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> > index c07bfa2d80f2..78c3a94fae66 100644
> > --- a/include/linux/sched/topology.h
> > +++ b/include/linux/sched/topology.h
> > @@ -45,7 +45,7 @@ static inline int cpu_smt_flags(void)
> >  #ifdef CONFIG_SCHED_CLUSTER
> >  static inline int cpu_cluster_flags(void)
> >  {
> > -     return SD_SHARE_PKG_RESOURCES;
> > +     return SD_CLUSTER | SD_SHARE_PKG_RESOURCES;
>
> On non-cluster systems, there would be only one group at the at the
> CLS domain. Since SD_CLUSTER is also tagged with SDF_NEEDS_GROUP, it
> would need the presence of two groups. Thus, on such non-cluster
> systems, the CLS domain will continue to be degenerated in favour of
> the SMT domain.
>
> >  }
> >  #endif
> >
> > @@ -177,6 +177,7 @@ cpumask_var_t *alloc_sched_domains(unsigned int ndoms);
> >  void free_sched_domains(cpumask_var_t doms[], unsigned int ndoms);
> >
> >  bool cpus_share_cache(int this_cpu, int that_cpu);
> > +bool cpus_share_cluster(int this_cpu, int that_cpu);
> >
> >  typedef const struct cpumask *(*sched_domain_mask_f)(int cpu);
> >  typedef int (*sched_domain_flags_f)(void);
> > @@ -230,6 +231,11 @@ static inline bool cpus_share_cache(int this_cpu, int that_cpu)
> >       return true;
> >  }
> >
> > +static inline bool cpus_share_cluster(int this_cpu, int that_cpu)
> > +{
> > +     return true;
> > +}
> > +
> >  #endif       /* !CONFIG_SMP */
> >
> >  #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 3c9b0fda64ac..11f9b25c3068 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3732,6 +3732,18 @@ bool cpus_share_cache(int this_cpu, int that_cpu)
> >       return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
> >  }
> >
> > +/*
> > + * On non-Cluster machine this function works same with cpus_share_cache()
> > + * as sd_cluster_id equals to sd_llc_id.
> > + */
>
> Ok, so on a non-cluster machine, a cluster is trivially defined to be
> a single core (this is reflected in what the cpu_cluster_mask() shows
> up on such machines).
>
> However, in cpus_share_cluster(), we are upgrading the definition of a
> cluster to be group of CPUs that share the LLC. This is inconsistent
> with the original definition. Is there a way to avoid this
> inconsistency ?

Hi gautham,
Yep but I wrote this trick to keep the change in patch2/2 compatible
with non-cluster machine:

@@ -6384,7 +6422,7 @@ static int select_idle_sibling(struct
task_struct *p, int prev, int target)
  /*
  * If the previous CPU is cache affine and idle, don't be stupid:
  */
- if (prev != target && cpus_share_cache(prev, target) &&
+ if (prev != target && cpus_share_cluster(prev, target) &&
     (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
     asym_fits_capacity(task_util, prev))
  return prev;
@@ -6408,7 +6446,7 @@ static int select_idle_sibling(struct
task_struct *p, int prev, int target)
  p->recent_used_cpu = prev;
  if (recent_used_cpu != prev &&
     recent_used_cpu != target &&
-    cpus_share_cache(recent_used_cpu, target) &&
+    cpus_share_cluster(recent_used_cpu, target) &&
     (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
     cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
     asym_fits_capacity(task_util, recent_used_cpu)) {
@@ -6449,7 +6487,7 @@ static int select_idle_sibling(struct
task_struct *p, int prev, int target)
  }
  }

I didn't find a better way to implement this with minimum overhead and
code modification.

>
>
>
> > +bool cpus_share_cluster(int this_cpu, int that_cpu)
> > +{
> > +     if (this_cpu == that_cpu)
> > +             return true;
> > +
> > +     return per_cpu(sd_cluster_id, this_cpu) == per_cpu(sd_cluster_id, that_cpu);
> > +}
> > +
> >  static inline bool ttwu_queue_cond(int cpu, int wake_flags)
> >  {
> >       /*
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 0e66749486e7..ddd29879ad40 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -1763,7 +1763,9 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
> >  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
> >  DECLARE_PER_CPU(int, sd_llc_size);
> >  DECLARE_PER_CPU(int, sd_llc_id);
> > +DECLARE_PER_CPU(int, sd_cluster_id);
> >  DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> > +DECLARE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
> >  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
> >  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> >  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index d201a7052a29..5642df384904 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -644,6 +644,8 @@ static void destroy_sched_domains(struct sched_domain *sd)
> >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
> >  DEFINE_PER_CPU(int, sd_llc_size);
> >  DEFINE_PER_CPU(int, sd_llc_id);
> > +DEFINE_PER_CPU(int, sd_cluster_id);
> > +DEFINE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
> >  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
> >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> > @@ -669,6 +671,12 @@ static void update_top_cache_domain(int cpu)
> >       per_cpu(sd_llc_id, cpu) = id;
> >       rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
> >
> > +     sd = lowest_flag_domain(cpu, SD_CLUSTER);
> > +     if (sd)
> > +             id = cpumask_first(sched_domain_span(sd));
> > +     rcu_assign_pointer(per_cpu(sd_cluster, cpu), sd);
> > +     per_cpu(sd_cluster_id, cpu) = id;
> > +
> >       sd = lowest_flag_domain(cpu, SD_NUMA);
> >       rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
> >
> > @@ -1514,6 +1522,7 @@ static unsigned long __read_mostly *sched_numa_onlined_nodes;
> >   */
> >  #define TOPOLOGY_SD_FLAGS            \
> >       (SD_SHARE_CPUCAPACITY   |       \
> > +      SD_CLUSTER             |       \
> >        SD_SHARE_PKG_RESOURCES |       \
> >        SD_NUMA                |       \
> >        SD_ASYM_PACKING)
> > --
> > 2.33.0
> >
>
>
> --
> Thanks and Regards
> gautham.

Thanks
Barry
