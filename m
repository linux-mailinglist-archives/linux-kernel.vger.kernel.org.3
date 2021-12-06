Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B91E46A4D5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347247AbhLFSqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:46:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:58950 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347252AbhLFSqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:46:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237189831"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="237189831"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 10:43:04 -0800
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="679092963"
Received: from schen9-mobl.amr.corp.intel.com ([10.212.179.140])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 10:43:04 -0800
Message-ID: <2231b5e45d2ae1b35f2dcaab672c3788cb06cfa3.camel@linux.intel.com>
Subject: Re: [PATCH 0/5] Make Cluster Scheduling Configurable
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Song Bao Hua <song.bao.hua@hisilicon.com>,
        yangyicong <yangyicong@huawei.com>,
        Michael Larabel <Michael@MichaelLarabel.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 06 Dec 2021 10:42:54 -0800
In-Reply-To: <20211204091402.GM16608@worktop.programming.kicks-ass.net>
References: <cover.1638563225.git.tim.c.chen@linux.intel.com>
         <20211204091402.GM16608@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-12-04 at 10:14 +0100, Peter Zijlstra wrote:
> On Fri, Dec 03, 2021 at 12:32:37PM -0800, Tim Chen wrote:
> > Tim Chen (5):
> >   scheduler: Create SDTL_SKIP flag to skip topology level
> >   scheduler: Add SD_CLUSTER topology flag to cluster sched domain
> >   scheduler: Add runtime knob sysctl_sched_cluster
> >   scheduler: Add boot time enabling/disabling of cluster scheduling
> >   scheduler: Default cluster scheduling to off on x86 hybrid CPU
> 
> s/scheduler:/sched:/, surely?
> 
> >  .../admin-guide/kernel-parameters.txt         |  4 +
> >  arch/x86/kernel/smpboot.c                     | 26 +++++++
> >  drivers/base/arch_topology.c                  | 23 +++++-
> >  include/linux/sched/sd_flags.h                |  7 ++
> >  include/linux/sched/sysctl.h                  |  6 ++
> >  include/linux/sched/topology.h                |  3 +-
> >  include/linux/topology.h                      |  7 ++
> >  kernel/sched/core.c                           |  1 +
> >  kernel/sched/sched.h                          |  6 ++
> >  kernel/sched/topology.c                       | 75
> > ++++++++++++++++++-
> >  kernel/sysctl.c                               | 11 +++
> >  11 files changed, 163 insertions(+), 6 deletions(-)
> 
> *groan*,... I was more thinking of something like so.
> 

Thanks.  This is much more straightforward for 
updating the default topology for hybrid CPU.

Tim

> ---
>  arch/x86/kernel/smpboot.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index ac2909f0cab3..617012f4619f 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -579,6 +579,17 @@ static struct sched_domain_topology_level
> x86_numa_in_package_topology[] = {
>  	{ NULL, },
>  };
>  
> +static struct sched_domain_topology_level x86_hybrid_topology[] = {
> +#ifdef CONFIG_SCHED_SMT
> +	{ cpu_smt_mask, x86_smt_flags, SD_INIT_NAME(SMT) },
> +#endif
> +#ifdef CONFIG_SCHED_MC
> +	{ cpu_coregroup_mask, x86_core_flags, SD_INIT_NAME(MC) },
> +#endif
> +	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
> +	{ NULL, },
> +};
> +
>  static struct sched_domain_topology_level x86_topology[] = {
>  #ifdef CONFIG_SCHED_SMT
>  	{ cpu_smt_mask, x86_smt_flags, SD_INIT_NAME(SMT) },
> @@ -1469,8 +1480,11 @@ void __init native_smp_cpus_done(unsigned int
> max_cpus)
>  
>  	calculate_max_logical_packages();
>  
> +	/* XXX for now assume numa-in-package and hybrid don't overlap
> */
>  	if (x86_has_numa_in_package)
>  		set_sched_topology(x86_numa_in_package_topology);
> +	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
> +		set_sched_topology(x86_hybrid_topology);
>  
>  	nmi_selftest();
>  	impress_friends();

