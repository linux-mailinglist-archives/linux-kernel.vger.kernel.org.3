Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E84346BFDB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239182AbhLGPxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:53:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:63626 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239105AbhLGPxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:53:15 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="224861394"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="224861394"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 07:49:25 -0800
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="605757057"
Received: from schen9-mobl.amr.corp.intel.com ([10.251.1.182])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 07:49:24 -0800
Message-ID: <e774c2abc7f2e016db8e3c8b7117e2bad1488d23.camel@linux.intel.com>
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
Date:   Tue, 07 Dec 2021 07:49:23 -0800
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
> 
> 

Peter,

If you wish, you can use the following change log for your
abbreviated patch.

---

sched: Don't use cluster topology for x86 hybrid CPUs

For x86 hybrid CPUs like Alder Lake, the order of CPU selection should
be based strictly on CPU priority.  Don't include cluster topology for
hybrid CPUs to avoid interference with such CPU selection order.

On Alder Lake, the Atom CPU cluster has more capacity (4 Atom CPUs) 
vs Big core cluster (2 hyperthread CPUs). This could potentially 
bias CPU selection towards Atom over Big Core, when Big core
CPU has higher priority. 

---

Thanks.

Acked-by: Tim Chen <tim.c.chen@linux.intel.com>

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

