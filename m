Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA83569490
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbiGFViP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbiGFViO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:38:14 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CFCE8C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 14:38:13 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-31c89111f23so102709487b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 14:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YMOUx8tRXrNtuUeXMdx6sLrOQrLpo6dcTRjSCKuQc0Y=;
        b=UYKAelmyu8hR8xtMcdAR5kd1mv8eoTvSrr43mXrkLTDNp7Up1QaEHT06vXLI2hfzGi
         UgyOvRNXV+lnTdsGajUy0ju4uTNazHUOkRkqbgyEg9cM3N8iAYjp4BSKrQMLIxcIPNF8
         jCzJvOSiH9aVkes4u0/X29QTr5+jvw3j86MAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YMOUx8tRXrNtuUeXMdx6sLrOQrLpo6dcTRjSCKuQc0Y=;
        b=h7ZtqobUvU2B2VDWA8at3E9hZm+xyeFXRWixm0rmct1rsEF24Di30mzx2Jg6haGtLH
         WaqxP1DhvFOypkUeQzArhD5Jh48ry25cwcVU/75Wa79V1ZsH0o4/VAj6HpHMLM6lDAS1
         e+48FxXgjvuPRsp5PUNUUzW2Hz/BojyI7DK77IUs87Ow6BMbzAjwnGO2QtwsfIbrzEmj
         KZUO6ddI2gSDtAUfv6wuFh0WBwTgQfjNe9OiI4Qa8qy+uoJv/DpQJFEp9zE3sxDgd2zG
         efieu85k7axrHNKTp/OICNXKGfW/SZWGAdAzmyKe9NDjHRf6kYWZ0IPDXwhI3DDUQSAm
         C/ZQ==
X-Gm-Message-State: AJIora/qCKAOhBSrFIFP2XZbjE+Ch0FelQqdXAfBmqS6qFFjLqxuTWZ2
        4hyPLLaaiqqcQ57dSHp+EZGhX37eUkq4L8HS1k3Z
X-Google-Smtp-Source: AGRyM1sNTMRWdcWaAn/JcWOrEElU7WU313tb8SJ6Kx2VtTNjPmBkJmDIQgRho/GXT0d2qFVlZcIMuFkHuyG4GfG7DBs=
X-Received: by 2002:a81:5d55:0:b0:31c:dce7:96c9 with SMTP id
 r82-20020a815d55000000b0031cdce796c9mr9652700ywb.519.1657143492665; Wed, 06
 Jul 2022 14:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220706184558.2557301-1-mail@conchuod.ie>
In-Reply-To: <20220706184558.2557301-1-mail@conchuod.ie>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 6 Jul 2022 14:38:01 -0700
Message-ID: <CAOnJCUL-RCkXi=1GSEipYmf1qMxkOASr_H65kGU+5c=AqJBZKA@mail.gmail.com>
Subject: Re: [PATCH] riscv: arch-topology: fix default topology reporting
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sudeep Holla <sudeep.holla@arm.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 6, 2022 at 11:46 AM Conor Dooley <mail@conchuod.ie> wrote:
>
> From: Conor Dooley <conor.dooley@microchip.com>
>
> RISC-V has no sane defaults to fall back on where there is no cpu-map
> in the devicetree.
> Without sane defaults, the package, core and thread IDs are all set to
> -1. This causes user-visible inaccuracies for tools like hwloc/lstopo
> which rely on the sysfs cpu topology files to detect a system's
> topology.
>
> Add sane defaults in ~the exact same way as ARM64.
>
> CC: stable@vger.kernel.org
> Fixes: 03f11f03dbfe ("RISC-V: Parse cpu topology during boot.")
> Reported-by: Brice Goglin <Brice.Goglin@inria.fr>
> Link: https://github.com/open-mpi/hwloc/issues/536
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>
> Sudeep suggested that this be backported rather than the changes to
> the devicetrees adding cpu-map since that property is optional.
> That patchset is still valid in it's own right.
>
>  arch/riscv/include/asm/topology.h | 13 +++++++++++++
>  arch/riscv/kernel/Makefile        |  1 +
>  arch/riscv/kernel/smpboot.c       |  4 ++++
>  arch/riscv/kernel/topology.c      | 32 +++++++++++++++++++++++++++++++
>  4 files changed, 50 insertions(+)
>  create mode 100644 arch/riscv/include/asm/topology.h
>  create mode 100644 arch/riscv/kernel/topology.c
>
> diff --git a/arch/riscv/include/asm/topology.h b/arch/riscv/include/asm/topology.h
> new file mode 100644
> index 000000000000..36bc6ecda898
> --- /dev/null
> +++ b/arch/riscv/include/asm/topology.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022 Microchip Technology Inc. and its subsidiaries
> + */
> +
> +#ifndef _ASM_RISCV_TOPOLOGY_H
> +#define _ASM_RISCV_TOPOLOGY_H
> +
> +#include <asm-generic/topology.h>
> +
> +void store_cpu_topology(unsigned int cpuid);
> +
> +#endif /* _ASM_RISCV_TOPOLOGY_H */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index c71d6591d539..9518882ba6f9 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -50,6 +50,7 @@ obj-y += riscv_ksyms.o
>  obj-y  += stacktrace.o
>  obj-y  += cacheinfo.o
>  obj-y  += patch.o
> +obj-y  += topology.o
>  obj-y  += probes/
>  obj-$(CONFIG_MMU) += vdso.o vdso/
>
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index f1e4948a4b52..d551c7f452d4 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -32,6 +32,7 @@
>  #include <asm/sections.h>
>  #include <asm/sbi.h>
>  #include <asm/smp.h>
> +#include <asm/topology.h>
>
>  #include "head.h"
>
> @@ -40,6 +41,8 @@ static DECLARE_COMPLETION(cpu_running);
>  void __init smp_prepare_boot_cpu(void)
>  {
>         init_cpu_topology();
> +
> +       store_cpu_topology(smp_processor_id());
>  }
>
>  void __init smp_prepare_cpus(unsigned int max_cpus)
> @@ -161,6 +164,7 @@ asmlinkage __visible void smp_callin(void)
>         mmgrab(mm);
>         current->active_mm = mm;
>
> +       store_cpu_topology(curr_cpuid);
>         notify_cpu_starting(curr_cpuid);
>         numa_add_cpu(curr_cpuid);
>         update_siblings_masks(curr_cpuid);
> diff --git a/arch/riscv/kernel/topology.c b/arch/riscv/kernel/topology.c
> new file mode 100644
> index 000000000000..db72862bd5b5
> --- /dev/null
> +++ b/arch/riscv/kernel/topology.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 Microchip Technology Inc. and its subsidiaries
> + *
> + * Based on the arm64 version, which was in turn based on arm32, which was
> + * ultimately based on sh's.
> + * The arm64 version was listed as:
> + * Copyright (C) 2011,2013,2014 Linaro Limited.
> + */
> +
> +#include <linux/arch_topology.h>
> +#include <linux/topology.h>
> +#include <asm/topology.h>
> +
> +void store_cpu_topology(unsigned int cpuid)
> +{
> +       struct cpu_topology *cpuid_topo = &cpu_topology[cpuid];
> +
> +       if (cpuid_topo->package_id != -1)
> +               goto topology_populated;
> +
> +       cpuid_topo->thread_id = -1;
> +       cpuid_topo->core_id = cpuid;
> +       cpuid_topo->package_id = cpu_to_node(cpuid);
> +
> +       pr_debug("CPU%u: package %d core %d thread %d\n",
> +                cpuid, cpuid_topo->package_id, cpuid_topo->core_id,
> +                cpuid_topo->thread_id);
> +
> +topology_populated:
> +       update_siblings_masks(cpuid);
> +}
>

This function is pretty much the same as the arm64 one except the
UP/mpidr check.
Can we move this to the common code as well ?

> base-commit: b6f1f2fa2bddd69ff46a190b8120bd440fd50563
> --
> 2.37.0
>


-- 
Regards,
Atish
