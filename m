Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F01569ED1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiGGJtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbiGGJtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:49:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28FD04D4E1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 02:49:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DF301063;
        Thu,  7 Jul 2022 02:49:12 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3D023F792;
        Thu,  7 Jul 2022 02:49:07 -0700 (PDT)
Date:   Thu, 7 Jul 2022 10:47:56 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Conor Dooley <mail@conchuod.ie>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Zong Li <zong.li@sifive.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jonas Hahnfeld <hahnjo@hahnjo.de>, Guo Ren <guoren@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Changbin Du <changbin.du@intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Brice Goglin <Brice.Goglin@inria.fr>
Subject: Re: [PATCH] riscv: arch-topology: fix default topology reporting
Message-ID: <20220707094756.rftfann3rcixdfp4@bogus>
References: <20220706184558.2557301-1-mail@conchuod.ie>
 <CAOnJCUL-RCkXi=1GSEipYmf1qMxkOASr_H65kGU+5c=AqJBZKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOnJCUL-RCkXi=1GSEipYmf1qMxkOASr_H65kGU+5c=AqJBZKA@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 02:38:01PM -0700, Atish Patra wrote:
> On Wed, Jul 6, 2022 at 11:46 AM Conor Dooley <mail@conchuod.ie> wrote:
> >
> > From: Conor Dooley <conor.dooley@microchip.com>
> >
> > RISC-V has no sane defaults to fall back on where there is no cpu-map
> > in the devicetree.
> > Without sane defaults, the package, core and thread IDs are all set to
> > -1. This causes user-visible inaccuracies for tools like hwloc/lstopo
> > which rely on the sysfs cpu topology files to detect a system's
> > topology.
> >
> > Add sane defaults in ~the exact same way as ARM64.
> >
> > CC: stable@vger.kernel.org
> > Fixes: 03f11f03dbfe ("RISC-V: Parse cpu topology during boot.")
> > Reported-by: Brice Goglin <Brice.Goglin@inria.fr>
> > Link: https://github.com/open-mpi/hwloc/issues/536
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >
> > Sudeep suggested that this be backported rather than the changes to
> > the devicetrees adding cpu-map since that property is optional.
> > That patchset is still valid in it's own right.
> >
> >  arch/riscv/include/asm/topology.h | 13 +++++++++++++
> >  arch/riscv/kernel/Makefile        |  1 +
> >  arch/riscv/kernel/smpboot.c       |  4 ++++
> >  arch/riscv/kernel/topology.c      | 32 +++++++++++++++++++++++++++++++
> >  4 files changed, 50 insertions(+)
> >  create mode 100644 arch/riscv/include/asm/topology.h
> >  create mode 100644 arch/riscv/kernel/topology.c
> >
> > diff --git a/arch/riscv/include/asm/topology.h b/arch/riscv/include/asm/topology.h
> > new file mode 100644
> > index 000000000000..36bc6ecda898
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/topology.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (c) 2022 Microchip Technology Inc. and its subsidiaries
> > + */
> > +
> > +#ifndef _ASM_RISCV_TOPOLOGY_H
> > +#define _ASM_RISCV_TOPOLOGY_H
> > +
> > +#include <asm-generic/topology.h>
> > +
> > +void store_cpu_topology(unsigned int cpuid);
> > +
> > +#endif /* _ASM_RISCV_TOPOLOGY_H */
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index c71d6591d539..9518882ba6f9 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -50,6 +50,7 @@ obj-y += riscv_ksyms.o
> >  obj-y  += stacktrace.o
> >  obj-y  += cacheinfo.o
> >  obj-y  += patch.o
> > +obj-y  += topology.o
> >  obj-y  += probes/
> >  obj-$(CONFIG_MMU) += vdso.o vdso/
> >
> > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> > index f1e4948a4b52..d551c7f452d4 100644
> > --- a/arch/riscv/kernel/smpboot.c
> > +++ b/arch/riscv/kernel/smpboot.c
> > @@ -32,6 +32,7 @@
> >  #include <asm/sections.h>
> >  #include <asm/sbi.h>
> >  #include <asm/smp.h>
> > +#include <asm/topology.h>
> >
> >  #include "head.h"
> >
> > @@ -40,6 +41,8 @@ static DECLARE_COMPLETION(cpu_running);
> >  void __init smp_prepare_boot_cpu(void)
> >  {
> >         init_cpu_topology();
> > +
> > +       store_cpu_topology(smp_processor_id());
> >  }
> >
> >  void __init smp_prepare_cpus(unsigned int max_cpus)
> > @@ -161,6 +164,7 @@ asmlinkage __visible void smp_callin(void)
> >         mmgrab(mm);
> >         current->active_mm = mm;
> >
> > +       store_cpu_topology(curr_cpuid);
> >         notify_cpu_starting(curr_cpuid);
> >         numa_add_cpu(curr_cpuid);
> >         update_siblings_masks(curr_cpuid);
> > diff --git a/arch/riscv/kernel/topology.c b/arch/riscv/kernel/topology.c
> > new file mode 100644
> > index 000000000000..db72862bd5b5
> > --- /dev/null
> > +++ b/arch/riscv/kernel/topology.c
> > @@ -0,0 +1,32 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2022 Microchip Technology Inc. and its subsidiaries
> > + *
> > + * Based on the arm64 version, which was in turn based on arm32, which was
> > + * ultimately based on sh's.
> > + * The arm64 version was listed as:
> > + * Copyright (C) 2011,2013,2014 Linaro Limited.
> > + */
> > +
> > +#include <linux/arch_topology.h>
> > +#include <linux/topology.h>
> > +#include <asm/topology.h>
> > +
> > +void store_cpu_topology(unsigned int cpuid)
> > +{
> > +       struct cpu_topology *cpuid_topo = &cpu_topology[cpuid];
> > +
> > +       if (cpuid_topo->package_id != -1)
> > +               goto topology_populated;
> > +
> > +       cpuid_topo->thread_id = -1;
> > +       cpuid_topo->core_id = cpuid;
> > +       cpuid_topo->package_id = cpu_to_node(cpuid);
> > +
> > +       pr_debug("CPU%u: package %d core %d thread %d\n",
> > +                cpuid, cpuid_topo->package_id, cpuid_topo->core_id,
> > +                cpuid_topo->thread_id);
> > +
> > +topology_populated:
> > +       update_siblings_masks(cpuid);
> > +}
> >
> 
> This function is pretty much the same as the arm64 one except the
> UP/mpidr check.
> Can we move this to the common code as well ?
>

While I completely agree with the idea, not sure if that makes backports
(if required) any difficult. If so, I would rather keep this way for a
release and then move both to the common place in arch_topology.

> > base-commit: b6f1f2fa2bddd69ff46a190b8120bd440fd50563
> > --
> > 2.37.0
> >
> 
> 
> -- 
> Regards,
> Atish

-- 
Regards,
Sudeep
