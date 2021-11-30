Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785A5462B02
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 04:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbhK3DYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 22:24:53 -0500
Received: from mga06.intel.com ([134.134.136.31]:29829 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237827AbhK3DYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 22:24:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="296937878"
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="296937878"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 19:21:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="458674461"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 29 Nov 2021 19:21:33 -0800
Date:   Mon, 29 Nov 2021 19:20:29 -0800
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
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] thermal: intel: hfi: Minimally initialize the
 Hardware Feedback Interface
Message-ID: <20211130032029.GA1371@ranerica-svr.sc.intel.com>
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
 <20211106013312.26698-4-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0gd5ZAs4nkbMA4ONt=9ULnrTPqxe_+3M78t9ZC9upEiXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gd5ZAs4nkbMA4ONt=9ULnrTPqxe_+3M78t9ZC9upEiXw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 03:09:20PM +0100, Rafael J. Wysocki wrote:
> On Sat, Nov 6, 2021 at 2:34 AM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > The Intel Hardware Feedback Interface provides guidance to the operating
> > system about the performance and energy efficiency capabilities of each
> > CPU in the system. Capabilities are numbers between 0 and 255 where a
> > higher number represents a higher capability. For each CPU, energy
> > efficiency and performance are reported as separate capabilities.
> >
> > Hardware computes these capabilities based on the operating conditions of
> > the system such as power and thermal limits. These capabilities are shared
> > with the operating system in a table resident in memory. Each package in
> > the system has its own HFI instance. Every logical CPU in the package is
> > represented in the table. More than one logical CPUs may be represented in
> > a single table entry. When the hardware updates the table, it generates a
> > package-level thermal interrupt.
> >
> > The size and format of the HFI table depend on the supported features and
> > can only be determined at runtime. To minimally initialize the HFI, parse
> > its features and allocate one instance per package of a data structure with
> > the necessary parameters to read and navigate individual HFI tables.
> >
> > A subsequent changeset will provide per-CPU initialization and interrupt
> > handling.
> >
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Aubrey Li <aubrey.li@linux.intel.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Tim Chen <tim.c.chen@linux.intel.com>
> > Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> > Reviewed-by: Len Brown <len.brown@intel.com>
> > Co-developed by: Aubrey Li <aubrey.li@linux.intel.com>
> > Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> >  drivers/thermal/intel/Kconfig       |  12 +++
> >  drivers/thermal/intel/Makefile      |   1 +
> >  drivers/thermal/intel/intel_hfi.c   | 155 ++++++++++++++++++++++++++++
> >  drivers/thermal/intel/intel_hfi.h   |  34 ++++++
> >  drivers/thermal/intel/therm_throt.c |   3 +
> >  5 files changed, 205 insertions(+)
> >  create mode 100644 drivers/thermal/intel/intel_hfi.c
> >  create mode 100644 drivers/thermal/intel/intel_hfi.h
> >
> > diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
> > index c83ea5d04a1d..d4c6bdcacddb 100644
> > --- a/drivers/thermal/intel/Kconfig
> > +++ b/drivers/thermal/intel/Kconfig
> > @@ -99,3 +99,15 @@ config INTEL_MENLOW
> >           Intel Menlow platform.
> >
> >           If unsure, say N.
> > +
> > +config INTEL_HFI
> > +       bool "Intel Hardware Feedback Interface"
> > +       depends on CPU_SUP_INTEL
> > +       depends on SCHED_MC && X86_THERMAL_VECTOR
> > +       help
> > +         Select this option to enable the Hardware Feedback Interface. If
> > +         selected, hardware provides guidance to the operating system on
> > +         the performance and energy efficiency capabilities of each CPU.
> > +         These capabilities may change as a result of changes in the operating
> > +         conditions of the system such power and thermal limits. If selected,
> > +         the kernel relays updates in CPUs' capabilities to userspace.
> > diff --git a/drivers/thermal/intel/Makefile b/drivers/thermal/intel/Makefile
> > index 960b56268b4a..1a80bffcd699 100644
> > --- a/drivers/thermal/intel/Makefile
> > +++ b/drivers/thermal/intel/Makefile
> > @@ -13,3 +13,4 @@ obj-$(CONFIG_INTEL_PCH_THERMAL)       += intel_pch_thermal.o
> >  obj-$(CONFIG_INTEL_TCC_COOLING)        += intel_tcc_cooling.o
> >  obj-$(CONFIG_X86_THERMAL_VECTOR) += therm_throt.o
> >  obj-$(CONFIG_INTEL_MENLOW)     += intel_menlow.o
> > +obj-$(CONFIG_INTEL_HFI) += intel_hfi.o
> > diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> > new file mode 100644
> > index 000000000000..edfe343507b3
> > --- /dev/null
> > +++ b/drivers/thermal/intel/intel_hfi.c
> > @@ -0,0 +1,155 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Hardware Feedback Interface Driver
> > + *
> > + * Copyright (c) 2021, Intel Corporation.
> > + *
> > + * Authors: Aubrey Li <aubrey.li@linux.intel.com>
> > + *          Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > + *
> > + *
> > + * The Hardware Feedback Interface provides a performance and energy efficiency
> > + * capability information for each CPU in the system. Depending on the processor
> > + * model, hardware may periodically update these capabilities as a result of
> > + * changes in the operating conditions (e.g., power limits or thermal
> > + * constraints). On other processor models, there is a single HFI update
> > + * at boot.
> > + *
> > + * This file provides functionality to process HFI updates and relay these
> > + * updates to userspace.
> > + */
> > +
> > +#define pr_fmt(fmt)  "intel-hfi: " fmt
> > +
> > +#include <linux/slab.h>
> > +
> > +#include "intel_hfi.h"
> > +
> > +/**
> > + * struct hfi_cpu_data - HFI capabilities per CPU
> > + * @perf_cap:          Performance capability
> > + * @ee_cap:            Energy efficiency capability
> > + *
> > + * Capabilities of a logical processor in the HFI table. These capabilities are
> > + * unitless.
> > + */
> > +struct hfi_cpu_data {
> > +       u8      perf_cap;
> > +       u8      ee_cap;
> > +} __packed;
> > +
> > +/**
> > + * struct hfi_hdr - Header of the HFI table
> > + * @perf_updated:      Hardware updated performance capabilities
> > + * @ee_updated:                Hardware updated energy efficiency capabilities
> > + *
> > + * Properties of the data in an HFI table.
> > + */
> > +struct hfi_hdr {
> > +       u8 perf_updated;
> > +       u8 ee_updated;
> > +} __packed;
> > +
> > +/**
> > + * struct hfi_instance - Representation of an HFI instance (i.e., a table)
> > + * @ts_counter:                Time stamp of the last update of the table
> > + * @hdr:               Base address of the table header
> > + * @data:              Base address of the table data
> > + *
> > + * A set of parameters to parse and navigate a specific HFI table.
> > + */
> > +struct hfi_instance {
> > +       u64                     *ts_counter;
> > +       void                    *hdr;
> > +       void                    *data;
> > +};
> > +
> > +/**
> > + * struct hfi_features - Supported HFI features
> > + * @capabilities:      Bitmask of supported capabilities
> > + * @nr_table_pages:    Size of the HFI table in 4KB pages
> > + * @cpu_stride:                Stride size to locate capability data of a logical
> > + *                     processor within the table (i.e., row stride)
> > + * @hdr_size:          Size of table header
> > + * @parsed:            True if HFI features have been parsed
> > + *
> > + * Parameters and supported features that are common to all HFI instances
> > + */
> > +struct hfi_features {
> > +       unsigned long   capabilities;
> > +       unsigned int    nr_table_pages;
> > +       unsigned int    cpu_stride;
> > +       unsigned int    hdr_size;
> > +       bool            parsed;

Thank you very much for your feedback, Rafael!
> 
> I'm not sure why this field is needed.
> 
> It looks like it is only checked by hfi_parse_features() which is only
> called by intel_hfi_init() which is invoked by
> thermal_throttle_init_device() which can happen only once if I'm not
> mistaken.

This is very true. It is not needed. I will remove it.

> > +};
> > +
> > +static int max_hfi_instances;
> > +static struct hfi_instance *hfi_instances;
> > +
> > +static struct hfi_features hfi_features;
> > +
> > +static __init int hfi_parse_features(void)
> > +{
> > +       unsigned int nr_capabilities, reg;
> > +
> > +       if (!boot_cpu_has(X86_FEATURE_INTEL_HFI))
> > +               return -ENODEV;
> > +
> > +       if (hfi_features.parsed)
> > +               return 0;
> > +
> > +       /*
> > +        * If we are here we know that CPUID_HFI_LEAF exists. Parse the
> > +        * supported capabilities and the size of the HFI table.
> > +        */
> > +       reg = cpuid_edx(CPUID_HFI_LEAF);
> > +
> > +       hfi_features.capabilities = reg & HFI_CAPABILITIES_MASK;
> > +       if (!(hfi_features.capabilities & HFI_CAPABILITIES_PERFORMANCE)) {
> > +               pr_err("Performance reporting not supported! Not using HFI\n");
> 
> This doesn't need to be pr_err().

Should it be a pr_warn() or perhaps pr_info()?

Thanks and BR,
Ricardo

