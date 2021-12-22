Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BAC47D30F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241255AbhLVNdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240824AbhLVNdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:33:51 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6BCC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 05:33:50 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id p8so3837415ljo.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 05:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jijhUonumXb8sc8oGgDxvK7fIcX7DucHQkjahSxK3GQ=;
        b=GZq9MaAsIbohNC8lDosYc6LLNaAyfxbvnOQxq5CwIlef3eQRIxitidHXU0pgcFEAOG
         odqjMhDFbBsm7/pER14H2OEtvaqXYYwt1/mX/B2HIwHJJCiI6+EjQiA2FjRJbQDwwq8n
         xa0xmyUcXZw4yH9Hw/MsJPJ6O4CszUFrA7+8Rkq0K28z9yXCxmSTtIXvsSluvSVTYUuB
         0LRGQ30/4fsvsANcgnCfLsU4AjANM8QOIO5zPotESu7GbzCZIFcM8wXLJJd4/vXMhbT+
         7FJX5xwAQ9K2eKB1d41807Oxy5k4rFkZclMNIS42oVmtzH6XFKDyXRyiduR5QuoSzOKw
         ijkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jijhUonumXb8sc8oGgDxvK7fIcX7DucHQkjahSxK3GQ=;
        b=4NlmRPgMvBWN9B8bTTIwaka/WsvqAaUnmBulbuUxQ8/+mz5+qAOxy4vl02ND2HeLId
         9eq1v5oKIFXZ+WJYXQegiz0qU0g8Rn8u6xCrBDNcxtAymDiM0V/zLSEHQor51qlFVFC4
         KwK6ZmAwM/sRAJUcQk2zN30VOx6Lx6JNdTk9IBG9OJ/Su1rCXmO2TfTwAq7s5lvKZixX
         3dUZRBQRwpzFgsXPSyTN7eCXUqkJK8hJclb7X5ZvPcKLnidY0tOuX0I9t6iq610WGdyY
         dYSxhbAJ4/wY2OTYwwGOpBlJv5zX3kCbOXloyBLTGRlx5fRa/6ClErHMnshobSsYPTpD
         bgnw==
X-Gm-Message-State: AOAM533BNtA9YeMaaL2gXPF0yfRoc4JcNmST+wBcqROiLt3dQXc49P9e
        JUYZq7MFDKYTX61wPued0qt+sH4ommvDBx9A9WjtaQ==
X-Google-Smtp-Source: ABdhPJyd1XjNIM0gBZJY/IEctUL8ek2YUeIe9LhGTETUnmzNvUOnFbBAlP7Nu5+nmWl4atIdhqQbtlHgafXdcKEBb7U=
X-Received: by 2002:a05:651c:1a0f:: with SMTP id by15mr2121522ljb.494.1640180028253;
 Wed, 22 Dec 2021 05:33:48 -0800 (PST)
MIME-Version: 1.0
References: <20211215041149.73171-1-yangyicong@hisilicon.com>
 <20211215041149.73171-2-yangyicong@hisilicon.com> <YcL80lUZi4f9zqjB@BLR-5CG11610CF.amd.com>
 <CAGsJ_4y_G74f1KEze__i_1qFOF30DMWaD=R3ww8rvvRMHvPELA@mail.gmail.com> <CAKfTPtDmwAFBYXdkiSdEdQx=H5t_hK9w5tRvSexBAMdVVD3ydQ@mail.gmail.com>
In-Reply-To: <CAKfTPtDmwAFBYXdkiSdEdQx=H5t_hK9w5tRvSexBAMdVVD3ydQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 22 Dec 2021 14:33:37 +0100
Message-ID: <CAKfTPtBKLDyNPXg7uLbQ3jUnEwppfC+E29=oJ1tWzzqHsNpApw@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched: Add per_cpu cluster domain info and
 cpus_share_cluster API
To:     Barry Song <21cnbao@gmail.com>
Cc:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
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

On Wed, 22 Dec 2021 at 14:14, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Wed, 22 Dec 2021 at 12:06, Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Wed, Dec 22, 2021 at 11:24 PM Gautham R. Shenoy
> > <gautham.shenoy@amd.com> wrote:
> > >
> > > Hello Yicong, Barry,
> > >
> > >
> > > On Wed, Dec 15, 2021 at 12:11:48PM +0800, Yicong Yang wrote:
> > > > From: Barry Song <song.bao.hua@hisilicon.com>
> > > >
> > > > Add per-cpu cluster domain info and cpus_share_cluster() API.
> > > > This is the preparation for the optimization of select_idle_cpu()
> > > > on platforms with cluster scheduler level.
> > > >
> > > > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > > > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > > > ---
> > > >  include/linux/sched/sd_flags.h |  5 +++++
> > > >  include/linux/sched/topology.h |  8 +++++++-
> > > >  kernel/sched/core.c            | 12 ++++++++++++
> > > >  kernel/sched/sched.h           |  2 ++
> > > >  kernel/sched/topology.c        |  9 +++++++++
> > > >  5 files changed, 35 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
> > > > index 57bde66d95f7..0f732bcfbb2c 100644
> > > > --- a/include/linux/sched/sd_flags.h
> > > > +++ b/include/linux/sched/sd_flags.h
> > > > @@ -109,6 +109,11 @@ SD_FLAG(SD_ASYM_CPUCAPACITY_FULL, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
> > > >   */
> > > >  SD_FLAG(SD_SHARE_CPUCAPACITY, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
> > > >
> > > > +/*
> > > > + * Set up for cluster domains sharing resources such as llc tags or l2
> > > > + */
> > > > +SD_FLAG(SD_CLUSTER, SDF_NEEDS_GROUPS)
> > > > +
> > > >  /*
> > > >   * Domain members share CPU package resources (i.e. caches)
> > > >   *
> > > > diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> > > > index c07bfa2d80f2..78c3a94fae66 100644
> > > > --- a/include/linux/sched/topology.h
> > > > +++ b/include/linux/sched/topology.h
> > > > @@ -45,7 +45,7 @@ static inline int cpu_smt_flags(void)
> > > >  #ifdef CONFIG_SCHED_CLUSTER
> > > >  static inline int cpu_cluster_flags(void)
> > > >  {
> > > > -     return SD_SHARE_PKG_RESOURCES;
> > > > +     return SD_CLUSTER | SD_SHARE_PKG_RESOURCES;
> > >
> > > On non-cluster systems, there would be only one group at the at the
> > > CLS domain. Since SD_CLUSTER is also tagged with SDF_NEEDS_GROUP, it
> > > would need the presence of two groups. Thus, on such non-cluster
> > > systems, the CLS domain will continue to be degenerated in favour of
> > > the SMT domain.
> > >
> > > >  }
> > > >  #endif
> > > >
> > > > @@ -177,6 +177,7 @@ cpumask_var_t *alloc_sched_domains(unsigned int ndoms);
> > > >  void free_sched_domains(cpumask_var_t doms[], unsigned int ndoms);
> > > >
> > > >  bool cpus_share_cache(int this_cpu, int that_cpu);
> > > > +bool cpus_share_cluster(int this_cpu, int that_cpu);
> > > >
> > > >  typedef const struct cpumask *(*sched_domain_mask_f)(int cpu);
> > > >  typedef int (*sched_domain_flags_f)(void);
> > > > @@ -230,6 +231,11 @@ static inline bool cpus_share_cache(int this_cpu, int that_cpu)
> > > >       return true;
> > > >  }
> > > >
> > > > +static inline bool cpus_share_cluster(int this_cpu, int that_cpu)
> > > > +{
> > > > +     return true;
> > > > +}
> > > > +
> > > >  #endif       /* !CONFIG_SMP */
> > > >
> > > >  #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
> > > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > > index 3c9b0fda64ac..11f9b25c3068 100644
> > > > --- a/kernel/sched/core.c
> > > > +++ b/kernel/sched/core.c
> > > > @@ -3732,6 +3732,18 @@ bool cpus_share_cache(int this_cpu, int that_cpu)
> > > >       return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
> > > >  }
> > > >
> > > > +/*
> > > > + * On non-Cluster machine this function works same with cpus_share_cache()
> > > > + * as sd_cluster_id equals to sd_llc_id.
> > > > + */
> > >
> > > Ok, so on a non-cluster machine, a cluster is trivially defined to be
> > > a single core (this is reflected in what the cpu_cluster_mask() shows
> > > up on such machines).
> > >
> > > However, in cpus_share_cluster(), we are upgrading the definition of a
> > > cluster to be group of CPUs that share the LLC. This is inconsistent
> > > with the original definition. Is there a way to avoid this
> > > inconsistency ?
> >
> > Hi gautham,
> > Yep but I wrote this trick to keep the change in patch2/2 compatible
> > with non-cluster machine:
> >
> > @@ -6384,7 +6422,7 @@ static int select_idle_sibling(struct
> > task_struct *p, int prev, int target)
> >   /*
> >   * If the previous CPU is cache affine and idle, don't be stupid:
> >   */
> > - if (prev != target && cpus_share_cache(prev, target) &&
> > + if (prev != target && cpus_share_cluster(prev, target) &&
> >      (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
> >      asym_fits_capacity(task_util, prev))
> >   return prev;
> > @@ -6408,7 +6446,7 @@ static int select_idle_sibling(struct
> > task_struct *p, int prev, int target)
> >   p->recent_used_cpu = prev;
> >   if (recent_used_cpu != prev &&
> >      recent_used_cpu != target &&
> > -    cpus_share_cache(recent_used_cpu, target) &&
> > +    cpus_share_cluster(recent_used_cpu, target) &&
> >      (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
> >      cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
> >      asym_fits_capacity(task_util, recent_used_cpu)) {
> > @@ -6449,7 +6487,7 @@ static int select_idle_sibling(struct
> > task_struct *p, int prev, int target)
> >   }
> >   }
> >
> > I didn't find a better way to implement this with minimum overhead and
> > code modification.
> >
> > >
> > >
> > >
> > > > +bool cpus_share_cluster(int this_cpu, int that_cpu)
> > > > +{
> > > > +     if (this_cpu == that_cpu)
> > > > +             return true;
> > > > +
> > > > +     return per_cpu(sd_cluster_id, this_cpu) == per_cpu(sd_cluster_id, that_cpu);
> > > > +}
> > > > +
> > > >  static inline bool ttwu_queue_cond(int cpu, int wake_flags)
> > > >  {
> > > >       /*
> > > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > > index 0e66749486e7..ddd29879ad40 100644
> > > > --- a/kernel/sched/sched.h
> > > > +++ b/kernel/sched/sched.h
> > > > @@ -1763,7 +1763,9 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
> > > >  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
> > > >  DECLARE_PER_CPU(int, sd_llc_size);
> > > >  DECLARE_PER_CPU(int, sd_llc_id);
> > > > +DECLARE_PER_CPU(int, sd_cluster_id);
> > > >  DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> > > > +DECLARE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
> > > >  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
> > > >  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> > > >  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
> > > > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > > > index d201a7052a29..5642df384904 100644
> > > > --- a/kernel/sched/topology.c
> > > > +++ b/kernel/sched/topology.c
> > > > @@ -644,6 +644,8 @@ static void destroy_sched_domains(struct sched_domain *sd)
> > > >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
> > > >  DEFINE_PER_CPU(int, sd_llc_size);
> > > >  DEFINE_PER_CPU(int, sd_llc_id);
> > > > +DEFINE_PER_CPU(int, sd_cluster_id);
> > > > +DEFINE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
> > > >  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> > > >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
> > > >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> > > > @@ -669,6 +671,12 @@ static void update_top_cache_domain(int cpu)
> > > >       per_cpu(sd_llc_id, cpu) = id;
> > > >       rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
> > > >
> > > > +     sd = lowest_flag_domain(cpu, SD_CLUSTER);
> > > > +     if (sd)
> > > > +             id = cpumask_first(sched_domain_span(sd));
> > > > +     rcu_assign_pointer(per_cpu(sd_cluster, cpu), sd);
> > > > +     per_cpu(sd_cluster_id, cpu) = id;
> > > > +
>
> This deserves a large comment to highlight that the new code above is
> not self contained and  relies on the fact that it is done just after
> looking for LLC and sd and that id and sd must not be changed in
> between inorder to ensures that per_cpu(sd_cluster_id, cpu) equals
> per_cpu(sd_llc_id, cpu) if there is no domain with SD_CLUSTER.
>
> and per_cpu(sd_cluster_id, cpu) might not be cluster but llc

Maybe you should not name this sd_cluster_id at all but
per_cpu(sd_share_id, cpu) = id;

Then you have a function named

+bool cpus_share_resources(int this_cpu, int that_cpu)
+{
+     if (this_cpu == that_cpu)
+             return true;
+
+     return per_cpu(sd_share_id, this_cpu) == per_cpu(sd_share_id, that_cpu);
+}
+
which returns true when cpu shares resources which can be LLC or cluster

>
> > > >       sd = lowest_flag_domain(cpu, SD_NUMA);
> > > >       rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
> > > >
> > > > @@ -1514,6 +1522,7 @@ static unsigned long __read_mostly *sched_numa_onlined_nodes;
> > > >   */
> > > >  #define TOPOLOGY_SD_FLAGS            \
> > > >       (SD_SHARE_CPUCAPACITY   |       \
> > > > +      SD_CLUSTER             |       \
> > > >        SD_SHARE_PKG_RESOURCES |       \
> > > >        SD_NUMA                |       \
> > > >        SD_ASYM_PACKING)
> > > > --
> > > > 2.33.0
> > > >
> > >
> > >
> > > --
> > > Thanks and Regards
> > > gautham.
> >
> > Thanks
> > Barry
