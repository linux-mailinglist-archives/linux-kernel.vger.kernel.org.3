Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC88C46AB38
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 23:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356298AbhLFWLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:11:47 -0500
Received: from mga11.intel.com ([192.55.52.93]:3341 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239517AbhLFWLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:11:45 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="234932709"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="234932709"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 14:07:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="479282144"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP; 06 Dec 2021 14:07:00 -0800
Date:   Mon, 6 Dec 2021 14:05:50 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Song Bao Hua <song.bao.hua@hisilicon.com>,
        yangyicong <yangyicong@huawei.com>,
        Michael Larabel <Michael@MichaelLarabel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Make Cluster Scheduling Configurable
Message-ID: <20211206220550.GA18698@ranerica-svr.sc.intel.com>
References: <cover.1638563225.git.tim.c.chen@linux.intel.com>
 <20211204091402.GM16608@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211204091402.GM16608@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2021 at 10:14:02AM +0100, Peter Zijlstra wrote:
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
> >  kernel/sched/topology.c                       | 75 ++++++++++++++++++-
> >  kernel/sysctl.c                               | 11 +++
> >  11 files changed, 163 insertions(+), 6 deletions(-)
> 
> *groan*,... I was more thinking of something like so.
> 
> ---
>  arch/x86/kernel/smpboot.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index ac2909f0cab3..617012f4619f 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -579,6 +579,17 @@ static struct sched_domain_topology_level x86_numa_in_package_topology[] = {
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
> @@ -1469,8 +1480,11 @@ void __init native_smp_cpus_done(unsigned int max_cpus)
>  
>  	calculate_max_logical_packages();
>  
> +	/* XXX for now assume numa-in-package and hybrid don't overlap */
>  	if (x86_has_numa_in_package)
>  		set_sched_topology(x86_numa_in_package_topology);
> +	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
> +		set_sched_topology(x86_hybrid_topology);
>  
>  	nmi_selftest();
>  	impress_friends();

FWIW, I tested this and now I don't see cluster scheduling interfering
with asymmetric packing when running on a x86 hybrid topology.

Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
