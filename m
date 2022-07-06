Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1035684A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiGFKFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbiGFKEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:04:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAFDC25287;
        Wed,  6 Jul 2022 03:04:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1EB81042;
        Wed,  6 Jul 2022 03:04:47 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8046E3F66F;
        Wed,  6 Jul 2022 03:04:44 -0700 (PDT)
Date:   Wed, 6 Jul 2022 11:03:33 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor.Dooley@microchip.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, Daire.McNamara@microchip.com,
        niklas.cassel@wdc.com, damien.lemoal@opensource.wdc.com,
        geert@linux-m68k.org, zong.li@sifive.com, kernel@esmil.dk,
        hahnjo@hahnjo.de, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Brice.Goglin@inria.fr
Subject: Re: [PATCH 0/5] RISC-V: Add cpu-map topology information nodes
Message-ID: <20220706100333.7n35rfnbdrnz6mh5@bogus>
References: <20220705190435.1790466-1-mail@conchuod.ie>
 <20220705201931.nfwi5rlku7ykmydr@bogus>
 <8f07796a-d9a2-3301-aafb-7fbec4d5b1a2@microchip.com>
 <fb7be22c-cf19-0e06-f231-bb5b9167e179@microchip.com>
 <20220706092126.k6zaknwcwzyg22ak@bogus>
 <9f26cd2a-b389-3f4b-b7d2-06fa5c2d7016@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f26cd2a-b389-3f4b-b7d2-06fa5c2d7016@microchip.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 09:43:02AM +0000, Conor.Dooley@microchip.com wrote:
> 
> 
> On 06/07/2022 10:21, Sudeep Holla wrote:
> > On Tue, Jul 05, 2022 at 11:03:54PM +0000, Conor.Dooley@microchip.com wrote:
> >>
> >>
> >> On 05/07/2022 21:33, Conor.Dooley@microchip.com wrote:
> >>>
> >>>
> >>> On 05/07/2022 21:19, Sudeep Holla wrote:
> >>>> On Tue, Jul 05, 2022 at 08:04:31PM +0100, Conor Dooley wrote:
> >>>>> From: Conor Dooley <conor.dooley@microchip.com>
> >>>>>
> >>>>> It was reported to me that the Hive Unmatched incorrectly reports
> >>>>> its topology to hwloc, but the StarFive VisionFive did in [0] &
> >>>>> a subsequent off-list email from Brice (the hwloc maintainer).
> >>>>> This turned out not to be entirely true, the /downstream/ version
> >>>>> of the VisionFive does work correctly but not upstream, as the
> >>>>> downstream devicetree has a cpu-map node that was added recently.
> >>>>>
> >>>>> This series adds a cpu-map node to all upstream devicetrees, which
> >>>>> I have tested on mpfs & fu540. The first patch is lifted directly
> >>>>> from the downstream StarFive devicetree.
> >>>>>
> >>>>
> >>>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> >>>>
> >>>> I would recommend to have sane defaults in core risc-v code in case of
> >>>> absence of /cpu-map node as it is optional. The reason I mentioned is that
> >>>> Conor mentioned how the default values in absence of the node looked quite
> >>>> wrong. I don't know if it is possible on RISC-V but on ARM64 we do have
> >>>> default values if arch_topology fails to set based on DT/ACPI.
> >>>>
> >>>
> >>> Yeah the defaults are all -1. I'll add some sane defaults for a v2.
> >>> Thanks,
> >>> Conor.
> >>
> >> I shamelessly stole from arm64... Seems to work, but have done minimal
> >> testing (only PolarFire SoC).
> >>
> >> Author: Conor Dooley <conor.dooley@microchip.com>
> >> Date:   Wed Jul 6 00:00:34 2022 +0100
> >>
> >>      riscv: arch-topology: add sane defaults
> >>      
> >>      RISC-V has no sane defaults to fall back on where there is no cpu-map
> >>      in the devicetree. Add sane defaults in ~the exact same way as ARM64.
> >>      
> >>      Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >>
> >> diff --git a/arch/riscv/include/asm/topology.h b/arch/riscv/include/asm/topology.h
> >> new file mode 100644
> >> index 000000000000..71c80710f00e
> >> --- /dev/null
> >> +++ b/arch/riscv/include/asm/topology.h
> >> @@ -0,0 +1,13 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-only */
> >> +/*
> >> + * Copyright (c) 2022 Microchip Technology Inc. and its subsidiaries
> >> + */
> >> +
> >> +#ifndef _ASM_RISCV_TOPOLOGY_H
> >> +#define _ASM_RISCV_TOPOLOGY_H
> >> +
> >> +#include <asm-generic/topology.h>
> >> +
> >> +void store_cpu_topology(unsigned int cpuid);
> >> +
> >> +#endif /* _ASM_RISCV_TOPOLOGY_H */
> >> \ No newline at end of file
> >> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> >> index c71d6591d539..9518882ba6f9 100644
> >> --- a/arch/riscv/kernel/Makefile
> >> +++ b/arch/riscv/kernel/Makefile
> >> @@ -50,6 +50,7 @@ obj-y += riscv_ksyms.o
> >>   obj-y  += stacktrace.o
> >>   obj-y  += cacheinfo.o
> >>   obj-y  += patch.o
> >> +obj-y  += topology.o
> >>   obj-y  += probes/
> >>   obj-$(CONFIG_MMU) += vdso.o vdso/
> >>   
> >> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> >> index f1e4948a4b52..d551c7f452d4 100644
> >> --- a/arch/riscv/kernel/smpboot.c
> >> +++ b/arch/riscv/kernel/smpboot.c
> >> @@ -32,6 +32,7 @@
> >>   #include <asm/sections.h>
> >>   #include <asm/sbi.h>
> >>   #include <asm/smp.h>
> >> +#include <asm/topology.h>
> >>   
> >>   #include "head.h"
> >>   
> >> @@ -40,6 +41,8 @@ static DECLARE_COMPLETION(cpu_running);
> >>   void __init smp_prepare_boot_cpu(void)
> >>   {
> >>          init_cpu_topology();
> >> +
> >> +       store_cpu_topology(smp_processor_id());
> >>   }
> >>   
> >>   void __init smp_prepare_cpus(unsigned int max_cpus)
> >> @@ -161,6 +164,7 @@ asmlinkage __visible void smp_callin(void)
> >>          mmgrab(mm);
> >>          current->active_mm = mm;
> >>   
> >> +       store_cpu_topology(curr_cpuid);
> >>          notify_cpu_starting(curr_cpuid);
> >>          numa_add_cpu(curr_cpuid);
> >>          update_siblings_masks(curr_cpuid);
> >> diff --git a/arch/riscv/kernel/topology.c b/arch/riscv/kernel/topology.c
> >> new file mode 100644
> >> index 000000000000..799b3423e0bc
> >> --- /dev/null
> >> +++ b/arch/riscv/kernel/topology.c
> >> @@ -0,0 +1,30 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Based on the arm64 version, which was in turn based on arm32, which was
> >> + * ultimately based on sh's.
> >> + * The arm64 version was listed as:
> >> + * Copyright (C) 2011,2013,2014 Linaro Limited.
> >> + *
> >> + */
> >> +#include <linux/arch_topology.h>
> >> +#include <linux/topology.h>
> >> +#include <asm/topology.h>
> >> +
> >> +void store_cpu_topology(unsigned int cpuid)
> >> +{
> >> +       struct cpu_topology *cpuid_topo = &cpu_topology[cpuid];
> >> +
> >> +       if (cpuid_topo->package_id != -1)
> >> +               goto topology_populated;
> >> +
> >> +       cpuid_topo->thread_id = -1;
> >> +       cpuid_topo->core_id = cpuid;
> >> +       cpuid_topo->package_id = cpu_to_node(cpuid);
> >> +
> >> +       pr_info("CPU%u: cluster %d core %d thread %d\n",
> >> +                cpuid, cpuid_topo->package_id, cpuid_topo->core_id,
> >> +                cpuid_topo->thread_id);
> >> +
> >> +topology_populated:
> >> +       update_siblings_masks(cpuid);
> >> +}
> >>
> > 
> > Looks good. Again package id is not cluster. This is what my series is
> > addressing. So update the log as Package instead of Cluster above. The
> > cluster id will be -1 unless you can get that for DT.
> 
> 
> Cool, I'll respin a v2 without this included then & get the series
> backported since this is user visible & will fix all existing supported
> platforms.
>

The DT /cpu-map is optional, so I don't think it needs to be backported.

> 
> I'll send the topology code changes separately to avoid it going
> forwards.

This on the other hand can be backported to fix userspace.

-- 
Regards,
Sudeep
