Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0643E488086
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 02:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbiAHB1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 20:27:53 -0500
Received: from mga18.intel.com ([134.134.136.126]:16479 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232154AbiAHB1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 20:27:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641605272; x=1673141272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=//8VGUMooQPPnCZuqgRzt27L6N6BiaBo37so/qlf+0A=;
  b=OA70PPysMdgX2yg2u0cbB2SQQLNm9oeimwsQUgx20IwaCbtM3GA4xR+i
   aB5aWWqBxdsEMDcowjJE8MMkYXcG4vBDf2JtBwKlpaMprkfzng/SGFuB6
   gM2Gw9O/9ApzIw7Xl3rDOagWsZCN6Ye7e/uxwSBept1itIo3CqQB9khGc
   sTao3hgEGaDlakj7XOa4xhNWn+LFwDQmX/a74bF/GmtrXVvmjGBmeCIrz
   5BSwGaLiYSVDawpv571k4CuksWvMA211Jdq7Xh99CZfT2PT9eq1ilgN1p
   hPKbxzwkg2fbS5LxCxrgp5Wlu0Srj7WII8yV+X6gttzclcIdeADbvtgfx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="229778960"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="229778960"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 17:27:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="471487856"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 07 Jan 2022 17:27:51 -0800
Date:   Fri, 7 Jan 2022 17:29:37 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] thermal: intel: hfi: Handle CPU hotplug events
Message-ID: <20220108012937.GA19633@ranerica-svr.sc.intel.com>
References: <20220106025059.25847-1-ricardo.neri-calderon@linux.intel.com>
 <20220106025059.25847-5-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106025059.25847-5-ricardo.neri-calderon@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 06:50:56PM -0800, Ricardo Neri wrote:
> All CPUs in a package are represented in an HFI table. There exists an
> HFI table per package. Thus, CPUs in a package need to coordinate to
> initialize and access the table. Do such coordination during CPU hotplug.
> Use the first CPU to come online in a package to initialize the HFI table
> and the data structure representing it. Other CPUs in the same package need
> only to register or unregister themselves in that data structure.
> 
> The HFI depends on both the package-level thermal management and the local
> APIC thermal local vector. Thus, ensure that both are properly configured
> before calling intel_hfi_online(). The CPU hotplug callbacks of the thermal
> throttle events code already meet these conditions. Enable the HFI from
> thermal_throttle_online().
> 
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v2:
>   * Removed hfi_instance::initialized. Instead, use hfi_instance::
>     hdr to determine if the instance has been initialized. (Rafael)
>   * Renamed hfi_lock as hfi_instance_lock to reflect the fact that it is
>     used to protect accesses to HFI instances. (Rafael)
>   * Removed unnecessary locking when linking a CPU to an HFI instance
>     in intel_hfi_online(). (Rafael)
>   * Improved locking in error paths in intel_hfi_online(). (Rafael)
>   * Unconditionally link the hfi_instance of a package/die to CPUs in
>     the same package in intel_hfi_online(). Initialization is taken care
>     of separately.
>   * Removed a pointless check for NULL when taking a pointer of an element
>     of hfi_instances.
>   * Added missing #include files.
> 
> Changes since v1:
>   * Renamed X86_FEATURE_INTEL_HFI as X86_FEATURE_HFI. (Boris)
>   * Relocated definitions of MSR bits from intel_hfi.h to intel_hfi.c.
>   * Renamed HFI_PTR_VALID_BIT as HW_FEEDBACK_PTR_VALID_BIT for clarity.
>   * Reworked init_hfi_cpu_index() to take a pointer of type struct
>     hfi_cpu_info. This makes the function more concise. (Rafael)
>   * In intel_hfi_online(), check for null hfi_instances and improve checks
>     of the die_id. (Rafael)
>   * Use a local cpumask_var_t to keep track of the CPUs of each
>     hfi_instance. (Rafael)
>   * Removed hfi_instance::die_id. It is not used anywhere.
>   * Renamed hfi_instance::table_base as hfi_instance::local_table for
>     clarity.
> ---
>  drivers/thermal/intel/intel_hfi.c   | 203 ++++++++++++++++++++++++++++
>  drivers/thermal/intel/intel_hfi.h   |   4 +
>  drivers/thermal/intel/therm_throt.c |   8 ++
>  3 files changed, 215 insertions(+)
> 
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> index 52e16d2bc957..cf506ef1bfca 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -23,14 +23,24 @@
>  
>  #include <linux/bitops.h>
>  #include <linux/cpufeature.h>
> +#include <linux/cpumask.h>
> +#include <linux/gfp.h>
> +#include <linux/io.h>
>  #include <linux/math.h>
> +#include <linux/mutex.h>
> +#include <linux/percpu-defs.h>
>  #include <linux/printk.h>
>  #include <linux/processor.h>
>  #include <linux/slab.h>
>  #include <linux/topology.h>
>  
> +#include <asm/msr.h>
> +
>  #include "intel_hfi.h"
>  
> +/* Hardware Feedback Interface MSR configuration bits */
> +#define HW_FEEDBACK_PTR_VALID_BIT		BIT(0)
> +
>  /* CPUID detection and enumeration definitions for HFI */
>  
>  #define CPUID_HFI_LEAF 6
> @@ -86,6 +96,8 @@ struct hfi_hdr {
>   *			Located at the base of the local table.
>   * @hdr:		Base address of the local table header
>   * @data:		Base address of the local table data
> + * @cpus:		CPUs represented in this HFI table instance
> + * @hw_table:		Pointer to the HFI table of this instance
>   *
>   * A set of parameters to parse and navigate a specific HFI table.
>   */
> @@ -96,6 +108,8 @@ struct hfi_instance {
>  	};
>  	void			*hdr;
>  	void			*data;
> +	cpumask_var_t		cpus;
> +	void			*hw_table;
>  };
>  
>  /**
> @@ -113,10 +127,178 @@ struct hfi_features {
>  	unsigned int	hdr_size;
>  };
>  
> +/**
> + * struct hfi_cpu_info - Per-CPU attributes to consume HFI data
> + * @index:		Row of this CPU in its HFI table
> + * @hfi_instance:	Attributes of the HFI table to which this CPU belongs
> + *
> + * Parameters to link a logical processor to an HFI table and a row within it.
> + */
> +struct hfi_cpu_info {
> +	s16			index;
> +	struct hfi_instance	*hfi_instance;
> +};
> +
> +static DEFINE_PER_CPU(struct hfi_cpu_info, hfi_cpu_info) = { .index = -1 };
> +
>  static int max_hfi_instances;
>  static struct hfi_instance *hfi_instances;
>  
>  static struct hfi_features hfi_features;
> +static DEFINE_MUTEX(hfi_instance_lock);
> +
> +static void init_hfi_cpu_index(struct hfi_cpu_info *info)
> +{
> +	union cpuid6_edx edx;
> +
> +	/* Do not re-read @cpu's index if it has already been initialized. */
> +	if (info->index > -1)
> +		return;
> +
> +	edx.full = cpuid_edx(CPUID_HFI_LEAF);
> +	info->index = edx.split.index;
> +}
> +
> +/*
> + * The format of the HFI table depends on the number of capabilities that the
> + * hardware supports. Keep a data structure to navigate the table.
> + */
> +static void init_hfi_instance(struct hfi_instance *hfi_instance)
> +{
> +	/* The HFI header is below the time-stamp. */
> +	hfi_instance->hdr = hfi_instance->local_table +
> +			    sizeof(*hfi_instance->timestamp);
> +
> +	/* The HFI data starts below the header. */
> +	hfi_instance->data = hfi_instance->hdr + hfi_features.hdr_size;
> +}
> +
> +/**
> + * intel_hfi_online() - Enable HFI on @cpu
> + * @cpu:	CPU in which the HFI will be enabled
> + *
> + * Enable the HFI to be used in @cpu. The HFI is enabled at the die/package
> + * level. The first CPU in the die/package to come online does the full HFI
> + * initialization. Subsequent CPUs will just link themselves to the HFI
> + * instance of their die/package.
> + */
> +void intel_hfi_online(unsigned int cpu)
> +{
> +	struct hfi_cpu_info *info = &per_cpu(hfi_cpu_info, cpu);
> +	u16 die_id = topology_logical_die_id(cpu);
> +	struct hfi_instance *hfi_instance;
> +	phys_addr_t hw_table_pa;
> +	u64 msr_val;
> +
> +	if (!boot_cpu_has(X86_FEATURE_HFI))
> +		return;
> +
> +	/* Not much to do if hfi_instances are missing. */
> +	if (!hfi_instances)
> +		return;
> +
> +	/*
> +	 * The HFI instance of this @cpu may exist already but they have not
> +	 * been linked to @cpu.
> +	 */
> +	hfi_instance = info->hfi_instance;
> +	if (!hfi_instance) {
> +		if (die_id < 0 || die_id >= max_hfi_instances)
> +			return;
> +
> +		/*
> +		 * Link @cpu to the HFI instance of its package/die. It does
> +		 * not matter whether the instance has been initialized.
> +		 */
> +		info->hfi_instance = hfi_instance;

There is a bug here. info->hfi_instance would be set to NULL because
hfi_instance is NULL. The latter needs to be set to
&hfi_instances[die_id] first.

Thanks and BR,
Ricardo
