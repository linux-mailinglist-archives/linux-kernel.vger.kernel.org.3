Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15DD482CD1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 22:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiABVdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 16:33:02 -0500
Received: from mga02.intel.com ([134.134.136.20]:59000 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229840AbiABVdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 16:33:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641159180; x=1672695180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KBYXLptNk97I2vTd1+8eaNmAncXbIYMQqvSvjA3QP40=;
  b=E4K/rifD2jKfn8IcjaD7GBXmBZ2jagBkilIsB0arxSyT09c/zgUuvlrH
   BtG0foQSBHRE+y9FVmiDBQZrQgDQMK81hRXYfLI5WNCRKTTXfcmME1GvJ
   CQIQCs+2bqQPHydLY+jpV+pQpW42tp5SWy1hbCjLJ+MVvrd1LPe9JJ7af
   1O0/DmEt2r8eTkRYcQ/eeEejRzb6c/wEBqMF6Cv8U0IABRk8mdaNKCgDQ
   7JpFODoxdDg9OAscmPF6ngtMT90yXPbkgGh8hLUTm/7AXMdAUnVt/vCVU
   4hlfJp30uEiguqhYJa6nWAK8kpM/98RM3RgH6Ctijxu9grKbWzNBuxTUh
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10215"; a="229301296"
X-IronPort-AV: E=Sophos;i="5.88,256,1635231600"; 
   d="scan'208";a="229301296"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2022 13:33:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,256,1635231600"; 
   d="scan'208";a="525310244"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga008.jf.intel.com with ESMTP; 02 Jan 2022 13:33:00 -0800
Date:   Sun, 2 Jan 2022 13:34:41 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] thermal: intel: hfi: Handle CPU hotplug events
Message-ID: <20220102213441.GA14930@ranerica-svr.sc.intel.com>
References: <20211220151438.1196-1-ricardo.neri-calderon@linux.intel.com>
 <20211220151438.1196-5-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0i+mKiB=i+QZb+OML0pmY4ZKiZ2jyfGxrvVkYeusqLr_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i+mKiB=i+QZb+OML0pmY4ZKiZ2jyfGxrvVkYeusqLr_w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 08:15:10PM +0100, Rafael J. Wysocki wrote:
> On Mon, Dec 20, 2021 at 4:23 PM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > All CPUs in a package are represented in an HFI table. There exists an
> > HFI table per package. Thus, CPUs in a package need to coordinate to
> > initialize and access the table. Do such coordination during CPU hotplug.
> > Use the first CPU to come online in a package to initialize the HFI table
> > and the data structure representing it. Other CPUs in the same package need
> > only to register or unregister themselves in that data structure.
> >
> > The HFI depends on both the package-level thermal management and the local
> > APIC thermal local vector. Thus, ensure that both are properly configured
> > before calling intel_hfi_online(). The CPU hotplug callbacks of the thermal
> > throttle events code already meet these conditions. Enable the HFI from
> > thermal_throttle_online().
> >
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Aubrey Li <aubrey.li@linux.intel.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Tim Chen <tim.c.chen@linux.intel.com>
> > Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> > Reviewed-by: Len Brown <len.brown@intel.com>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Changes since v1:
> >   * Renamed X86_FEATURE_INTEL_HFI as X86_FEATURE_HFI. (Boris)
> >   * Relocated definitions of MSR bits from intel_hfi.h to intel_hfi.c.
> >   * Renamed HFI_PTR_VALID_BIT as HW_FEEDBACK_PTR_VALID_BIT for clarity.
> >   * Reworked init_hfi_cpu_index() to take a pointer of type struct
> >     hfi_cpu_info. This makes the function more concise. (Rafael)
> >   * In intel_hfi_online(), check for null hfi_instances and improve checks
> >     of the die_id. (Rafael)
> >   * Use a local cpumask_var_t to keep track of the CPUs of each
> >     hfi_instance. (Rafael)
> >   * Removed hfi_instance::die_id. It is not used anywhere.
> >   * Renamed hfi_instance::table_base as hfi_instance::local_table for
> >     clarity.
> > ---
> >  drivers/thermal/intel/intel_hfi.c   | 204 ++++++++++++++++++++++++++++
> >  drivers/thermal/intel/intel_hfi.h   |   4 +
> >  drivers/thermal/intel/therm_throt.c |   8 ++
> >  3 files changed, 216 insertions(+)
> >
> > diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> > index 375d835cc5e3..9b68fa25950e 100644
> > --- a/drivers/thermal/intel/intel_hfi.c
> > +++ b/drivers/thermal/intel/intel_hfi.c
> > @@ -21,10 +21,15 @@
> >
> >  #define pr_fmt(fmt)  "intel-hfi: " fmt
> >
> > +#include <linux/bits.h>
> > +#include <linux/io.h>
> >  #include <linux/slab.h>
> >
> >  #include "intel_hfi.h"
> >
> > +/* Hardware Feedback Interface MSR configuration bits */
> > +#define HW_FEEDBACK_PTR_VALID_BIT              BIT(0)
> > +
> >  /* CPUID detection and enumeration definitions for HFI */
> >
> >  #define CPUID_HFI_LEAF 6
> > @@ -80,6 +85,9 @@ struct hfi_hdr {
> >   *                     Located at the base of the local table.
> >   * @hdr:               Base address of the local table header
> >   * @data:              Base address of the local table data
> > + * @cpus:              CPUs represented in this HFI table instance
> > + * @hw_table:          Pointer to the HFI table of this instance
> > + * @initialized:       True if this HFI instance has bee initialized
> >   *
> >   * A set of parameters to parse and navigate a specific HFI table.
> >   */
> > @@ -90,6 +98,9 @@ struct hfi_instance {
> >         };
> >         void                    *hdr;
> >         void                    *data;
> > +       cpumask_var_t           cpus;
> > +       void                    *hw_table;
> > +       bool                    initialized;
> >  };
> >
> >  /**
> > @@ -107,10 +118,182 @@ struct hfi_features {
> >         unsigned int    hdr_size;
> >  };
> >
> > +/**
> > + * struct hfi_cpu_info - Per-CPU attributes to consume HFI data
> > + * @index:             Row of this CPU in its HFI table
> > + * @hfi_instance:      Attributes of the HFI table to which this CPU belongs
> > + *
> > + * Parameters to link a logical processor to an HFI table and a row within it.
> > + */
> > +struct hfi_cpu_info {
> > +       s16                     index;
> > +       struct hfi_instance     *hfi_instance;
> > +};
> > +
> > +static DEFINE_PER_CPU(struct hfi_cpu_info, hfi_cpu_info) = { .index = -1 };
> > +
> >  static int max_hfi_instances;
> >  static struct hfi_instance *hfi_instances;
> >
> >  static struct hfi_features hfi_features;
> > +static DEFINE_MUTEX(hfi_lock);
> > +
> > +static void init_hfi_cpu_index(struct hfi_cpu_info *info)
> > +{
> > +       union cpuid6_edx edx;
> > +
> > +       /* Do not re-read @cpu's index if it has already been initialized. */
> > +       if (info->index > -1)
> > +               return;
> > +
> > +       edx.full = cpuid_edx(CPUID_HFI_LEAF);
> > +       info->index = edx.split.index;
> > +}
> > +
> > +/*
> > + * The format of the HFI table depends on the number of capabilities that the
> > + * hardware supports. Keep a data structure to navigate the table.
> > + */
> > +static void init_hfi_instance(struct hfi_instance *hfi_instance)
> > +{
> > +       /* The HFI header is below the time-stamp. */
> > +       hfi_instance->hdr = hfi_instance->local_table +
> > +                           sizeof(*hfi_instance->timestamp);
> > +
> > +       /* The HFI data starts below the header. */
> > +       hfi_instance->data = hfi_instance->hdr + hfi_features.hdr_size;
> > +
> > +       hfi_instance->initialized = true;

Thank you very much for your detailed review, Rafael.

> 
> Is this extra "initialized" bit really needed?
> 
> It looks like both hdr and data are 0 before initializing and nonzero
> after that, so why can't one of them be used for the instance
> initialization checking?

Yes, that is true. I can remove hfi_instance::initialized and use either
hdr or table instead.

> 
> > +}
> > +
> > +/**
> > + * intel_hfi_online() - Enable HFI on @cpu
> > + * @cpu:       CPU in which the HFI will be enabled
> > + *
> > + * Enable the HFI to be used in @cpu. The HFI is enabled at the die/package
> > + * level. The first CPU in the die/package to come online does the full HFI
> > + * initialization. Subsequent CPUs will just link themselves to the HFI
> > + * instance of their die/package.
> > + */
> > +void intel_hfi_online(unsigned int cpu)
> > +{
> > +       struct hfi_cpu_info *info = &per_cpu(hfi_cpu_info, cpu);
> > +       u16 die_id = topology_logical_die_id(cpu);
> > +       struct hfi_instance *hfi_instance;
> > +       phys_addr_t hw_table_pa;
> > +       u64 msr_val;
> > +
> > +       if (!boot_cpu_has(X86_FEATURE_HFI))
> > +               return;
> > +
> > +       /* Not much to do if hfi_instances are missing. */
> > +       if (!hfi_instances)
> > +               return;
> > +
> > +       /*
> > +        * The HFI instance of this @cpu may exist already but they have not
> > +        * been linked to @cpu.
> > +        */
> > +       hfi_instance = info->hfi_instance;
> > +       if (!hfi_instance) {
> > +               if (die_id < 0 || die_id >= max_hfi_instances)
> > +                       return;
> > +
> > +               hfi_instance = &hfi_instances[die_id];
> > +               if (!hfi_instance)
> > +                       return;
> 
> If I'm not mistaken, info->hfi_instance can be initialized right here,
> and in particular it is not necessary to do that under hfi_lock and so
> doing that under the lock is confusing.
> 
> Besides, I would call the lock hfi_instance_lock, because its role
> appears to be to protect the instance in case it is accessed from
> multiple CPUs at the same time (assuming that online and offline
> cannot run concurrently for the same CPU).

Yes, this is the very purpose of hfi_lock. I think it makes sense
renaming it as hfi_instance_lock as you suggest.
> 
> Moreover, after init the only thing protected by it seems to be the CPU mask.

That is true in this block. In blocks below it also makes sure that only
one CPU allocates and initializes an HFI instance.

> 
> > +       }
> > +
> > +       init_hfi_cpu_index(info);
> > +
> > +       /*
> > +        * Now check if the HFI instance of the package/die of this CPU has
> > +        * been initialized. In such case, all we have to do is link @cpu's info
> > +        * to the HFI instance of its die/package.
> > +        */
> > +       mutex_lock(&hfi_lock);
> > +       if (hfi_instance->initialized) {
> > +               cpumask_set_cpu(cpu, hfi_instance->cpus);
> > +               info->hfi_instance = hfi_instance;
> 
> I would do the above earlier (see above).

Sure, I can do this.

> 
> > +
> > +               mutex_unlock(&hfi_lock);
> > +               return;
> 
> And here I would do
> 
> goto unlock;

Sure.

> 
> > +       }
> > +
> > +       /*
> > +        * Hardware is programmed with the physical address of the first page
> > +        * frame of the table. Hence, the allocated memory must be page-aligned.
> > +        */
> > +       hfi_instance->hw_table = alloc_pages_exact(hfi_features.nr_table_pages,
> > +                                                  GFP_KERNEL | __GFP_ZERO);
> > +       if (!hfi_instance->hw_table)
> > +               goto err_out;
> 
> goto unlock; (see below)

Sure.

> 
> > +
> > +       hw_table_pa = virt_to_phys(hfi_instance->hw_table);
> > +
> > +       /*
> > +        * Allocate memory to keep a local copy of the table that
> > +        * hardware generates.
> > +        */
> > +       hfi_instance->local_table = kzalloc(hfi_features.nr_table_pages << PAGE_SHIFT,
> > +                                           GFP_KERNEL);
> > +       if (!hfi_instance->local_table)
> > +               goto free_hw_table;
> > +
> > +       /*
> > +        * Program the address of the feedback table of this die/package. On
> > +        * some processors, hardware remembers the old address of the HFI table
> > +        * even after having been reprogrammed and re-enabled. Thus, do not free
> > +        * pages allocated for the table or reprogram the hardware with a new
> > +        * base address. Namely, program the hardware only once.
> > +        */
> > +       msr_val = hw_table_pa | HW_FEEDBACK_PTR_VALID_BIT;
> > +       wrmsrl(MSR_IA32_HW_FEEDBACK_PTR, msr_val);
> > +
> > +       init_hfi_instance(hfi_instance);
> > +
> > +       cpumask_set_cpu(cpu, hfi_instance->cpus);
> > +       info->hfi_instance = hfi_instance;
> > +
> 
> unlock:
> 
> > +       mutex_unlock(&hfi_lock);
> > +
> > +       return;
> > +
> > +free_hw_table:
> > +       free_pages_exact(hfi_instance->hw_table, hfi_features.nr_table_pages);
> 
> I would do
> 
> goto unlock;
> 
> instead of the below.

Sure Rafael, I can implement these changes.

Thanks and BR,
Ricardo
