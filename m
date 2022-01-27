Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781AA49D81F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 03:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbiA0Cgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 21:36:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:57606 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231508AbiA0Cgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 21:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643251009; x=1674787009;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HOBXi6jNV91HwpGZJ4KbheD8ydt/tlTqPzJCybzMozc=;
  b=P5EdOxa75D4hxSTVTvR6c1wyGWLtTWKQV2fGEw0FxZC+clTQDb3FTT8r
   aH26A9fSkSNaA/2EQzzKNAKs7gaGZI+1hiEhwDxqVbp0PVai2yoGwM5ka
   9ma8pbdYaoMWvbOPCMV2g5xZ3FiEkyY/g6SPUE+h8j48bIs+b2P0BDOlU
   fF/5lN9ah0GOnsMpV6dNwo+p6Xd66LDvrgQoeYLybu+rKN59TebevyMPY
   yMSr6qKGJR0i44ce0w4JEHauXM66WmCc+NcQE2WdFFw473uzFbka7MKqS
   nxaairTF4UDZCoL7QvYULXlEMH8azFCS9hA9s3gIV0co5FwBfGk/H5tPP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="227396838"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="227396838"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 18:36:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="495570369"
Received: from schen9-mobl.amr.corp.intel.com ([10.212.144.230])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 18:36:47 -0800
Message-ID: <62bbdd77f70f7b46a044685668e33fb031812c38.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Yicong Yang <yangyicong@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, prime.zeng@huawei.com,
        jonathan.cameron@huawei.com, ego@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, linuxarm@huawei.com, 21cnbao@gmail.com,
        song.bao.hua@hisilicon.com, guodong.xu@linaro.org
Date:   Wed, 26 Jan 2022 18:36:47 -0800
In-Reply-To: <95f82bf3524289bfbcaeee6e83b6dac48ed07f25.camel@linux.intel.com>
References: <20220126080947.4529-1-yangyicong@hisilicon.com>
         <20220126080947.4529-3-yangyicong@hisilicon.com>
         <f2617aa806df6d64718a7cb5b41bafe593bccda3.camel@linux.intel.com>
         <b793e565-670d-cc66-6947-7d927ebcb8b3@huawei.com>
         <95f82bf3524289bfbcaeee6e83b6dac48ed07f25.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-01-26 at 18:30 -0800, Tim Chen wrote:
> On Thu, 2022-01-27 at 10:02 +0800, Yicong Yang wrote:
> > On 2022/1/27 9:14, Tim Chen wrote:
> > > On Wed, 2022-01-26 at 16:09 +0800, Yicong Yang wrote:
> > > > From: Barry Song <song.bao.hua@hisilicon.com>
> > > > 
> > > > For platforms having clusters like Kunpeng920, CPUs within the
> > > > same
> > > > cluster have lower latency when synchronizing and accessing
> > > > shared
> > > > resources like cache. Thus, this patch tries to find an idle
> > > > cpu
> > > > within the cluster of the target CPU before scanning the whole
> > > > LLC
> > > > to gain lower latency.
> > > > 
> > > > Note neither Kunpeng920 nor x86 Jacobsville supports SMT, so
> > > > this
> > > > patch doesn't consider SMT for this moment.
> > > > 
> > > > Testing has been done on Kunpeng920 by pinning tasks to one
> > > > numa
> > > > and two numa. On Kunpeng920, Each numa has 8 clusters and each
> > > > cluster has 4 CPUs.
> > > > 
> > > > With this patch, We noticed enhancement on tbench within one
> > > > numa or cross two numa.
> > > > 
> > > > On numa 0:
> > > >                             5.17-rc1                patched
> > > > Hmean     1        324.73 (   0.00%)      378.01 *  16.41%*
> > > > Hmean     2        645.36 (   0.00%)      754.63 *  16.93%*
> > > > Hmean     4       1302.09 (   0.00%)     1507.54 *  15.78%*
> > > > Hmean     8       2612.03 (   0.00%)     2982.57 *  14.19%*
> > > > Hmean     16      5307.12 (   0.00%)     5886.66 *  10.92%*
> > > > Hmean     32      9354.22 (   0.00%)     9908.13 *   5.92%*
> > > > Hmean     64      7240.35 (   0.00%)     7278.78 *   0.53%*
> > > > Hmean     128     6186.40 (   0.00%)     6187.85 (   0.02%)
> > > > 
> > > > On numa 0-1:
> > > >                             5.17-rc1                patched
> > > > Hmean     1        320.01 (   0.00%)      378.44 *  18.26%*
> > > > Hmean     2        643.85 (   0.00%)      752.52 *  16.88%*
> > > > Hmean     4       1287.36 (   0.00%)     1505.62 *  16.95%*
> > > > Hmean     8       2564.60 (   0.00%)     2955.29 *  15.23%*
> > > > Hmean     16      5195.69 (   0.00%)     5814.74 *  11.91%*
> > > > Hmean     32      9769.16 (   0.00%)    10872.63 *  11.30%*
> > > > Hmean     64     15952.50 (   0.00%)    17281.98 *   8.33%*
> > > > Hmean     128    13113.77 (   0.00%)    13895.20 *   5.96%*
> > > > Hmean     256    10997.59 (   0.00%)    11244.69 *   2.25%*
> > > > Hmean     512    14623.60 (   0.00%)    15526.25 *   6.17%*
> > > > 
> > > > This will also help to improve the MySQL. With MySQL server
> > > > running on numa 0 and client running on numa 1, both QPS and
> > > > latency is imporved on read-write case:
> > > >                         5.17-rc1        patched
> > > > QPS-16threads        143333.2633    145077.4033(+1.22%)
> > > > QPS-24threads        195085.9367    202719.6133(+3.91%)
> > > > QPS-32threads        241165.6867      249020.74(+3.26%)
> > > > QPS-64threads        244586.8433    253387.7567(+3.60%)
> > > > avg-lat-16threads           2.23           2.19(+1.19%)
> > > > avg-lat-24threads           2.46           2.36(+3.79%)
> > > > avg-lat-36threads           2.66           2.57(+3.26%)
> > > > avg-lat-64threads           5.23           5.05(+3.44%)
> > > > 
> > > > Tested-by: Yicong Yang <yangyicong@hisilicon.com>
> > > > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > > > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > > > ---
> > > >  kernel/sched/fair.c | 46
> > > > +++++++++++++++++++++++++++++++++++++++++
> > > > ----
> > > >  1 file changed, 42 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 5146163bfabb..2f84a933aedd 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -6262,12 +6262,46 @@ static inline int
> > > > select_idle_smt(struct
> > > > task_struct *p, struct sched_domain *sd
> > > >  
> > > >  #endif /* CONFIG_SCHED_SMT */
> > > >  
> > > > +#ifdef CONFIG_SCHED_CLUSTER
> > > > +/*
> > > > + * Scan the cluster domain for idle CPUs and clear cluster
> > > > cpumask
> > > > after scanning
> > > > + */
> > > > +static inline int scan_cluster(struct task_struct *p, int
> > > > prev_cpu,
> > > > int target)
> > > > +{
> > > > +	struct cpumask *cpus =
> > > > this_cpu_cpumask_var_ptr(select_idle_mask);
> > > > +	struct sched_domain *sd =
> > > > rcu_dereference(per_cpu(sd_cluster,
> > > > target));
> > > > +	int cpu, idle_cpu;
> > > > +
> > > > +	/* TODO: Support SMT case while a machine with both
> > > > cluster and
> > > > SMT born */
> > > 
> > > This is probably a clearer comment
> > > 
> > > 	/* TODO: Support SMT system with cluster topology */
> > > 
> > > > +	if (!sched_smt_active() && sd) {
> > > > +		for_each_cpu_and(cpu, cpus,
> > > > sched_domain_span(sd)) {
> > > > +			idle_cpu = __select_idle_cpu(cpu, p);
> > > >   */
> > > > -static int select_idle_cpu(struct task_struct *p, struct
> > > > sched_domain *sd, bool has_idle_core, int target)
> > > > +static int select_idle_cpu(struct task_struct *p, struct
> > > > sched_domain *sd, bool has_idle_core, int prev_cpu, int target)
> > > >  {
> > > >  	struct cpumask *cpus =
> > > > this_cpu_cpumask_var_ptr(select_idle_mask);
> > > >  	int i, cpu, idle_cpu = -1, nr = INT_MAX;
> > > > @@ -6282,6 +6316,10 @@ static int select_idle_cpu(struct
> > > > task_struct
> > > > *p, struct sched_domain *sd, bool
> > > >  
> > > >  	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> > > >  
> > > > +	idle_cpu = scan_cluster(p, prev_cpu, target);
> > > 
> > > Shouldn't "cpus" from 
> > > 
> > > cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> > > 
> > > be passed to scan_cluster, to make sure that the cpu returned is 
> > > in the affinity mask of the task? I don't see p->cpus_ptr
> > > being checked in scan_cluster to make sure the cpu found is in
> > > the
> > > affinity mask.
> > > 
> > 
> > The cpus scanned in scan_cluster() is the intersection of
> > select_idle_mask and sched_domain_span(cluster_sd), and
> > we limited the select_idle_mask in the tasks' affinity mask
> > before we enter scan_cluster() here.
> 
> Ah, I missed the fact that cpus point to the select_idle_mask.
> 

I think it will be easier to read the code if you pass "cpus" directly
to scan cluster, rather than making this implicit, and having this
assignment 

*cpus = this_cpu_cpumask_var_ptr(select_idle_mask);

again in scan_cluster.

Tim


