Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6895580EAE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238099AbiGZIKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237981AbiGZIK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:10:26 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D015218346
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 01:10:21 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-31f1d1c82c8so41217807b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 01:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jjVH0LRyKsPLAGZ03a5O8AhToHuTUcLbwfDz1yPqOlk=;
        b=Q2WlV6127P/FIOpihtg6o0xC4U+5rRSXWqL1vzxx4Drh2clcpSe2yUYqwLu5jvdo5r
         CETG3PLjA1jE+5G7lhpK14GzuQPMBAnfq2LqywzHSKVXttzxhew1Pd5+UiA/ayY6esYn
         q0qEeq9x2eDFPN4YybeG+PVedlkDQWHAWuYaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jjVH0LRyKsPLAGZ03a5O8AhToHuTUcLbwfDz1yPqOlk=;
        b=beoLhRZWypjeDOQ1Na9kkuOaNezA9v9D63OnZtD54C4kiWb4lE4okISrvV09dC9bFQ
         A4a8I0Sqmfh3Lb9zq2CX7orqh0zF+4CigwJXkb8sjs40Og08HyNWYzcyQlh82CCd2iXq
         kfs1LFmVDfzSvB75+8qNksyB93iKeHbPJcgfvHI2s60dLcqIzSTvMcj6h8KPQNuiREzC
         jjM59gFXljqXLYZ/CpQD8eP635gpYdiAX6KDR7hrVKxdGpCJHdwMqpfJbO7hdHRDrDBK
         qyNeheUvddWJIY+e5LwmTWlMoMkyljtLPmp2gAVea4GrsW7+WFpeCwbHhQcBQ346LQol
         MLzQ==
X-Gm-Message-State: AJIora+p1/fy+pQzSWjGz812re6SYE8cybMZvdtvLWlaYepMpPb7LpgH
        nSJXKL8mJGRXV4ArgK68ATpFWbadD5DW6796O43h
X-Google-Smtp-Source: AGRyM1uTheeiEPbmY+0HDoT9HYdyHDQf8+Qa8e9tyMEDk1B07jnrOuaPJSd0uddg9beWSG6SzO+cZHW/2cgBq6oF2rs=
X-Received: by 2002:a0d:f0c7:0:b0:31e:e814:e7d6 with SMTP id
 z190-20020a0df0c7000000b0031ee814e7d6mr9561147ywe.340.1658823021050; Tue, 26
 Jul 2022 01:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220715175155.3567243-1-mail@conchuod.ie> <20220715175155.3567243-2-mail@conchuod.ie>
In-Reply-To: <20220715175155.3567243-2-mail@conchuod.ie>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 26 Jul 2022 01:10:10 -0700
Message-ID: <CAOnJCULXZ1DXXsY=s+eMhqvmdwHvnurHT-Ozhq6UDd5AX0hHsA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] arm64: topology: move store_cpu_topology() to
 shared code
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Zong Li <zong.li@sifive.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jonas Hahnfeld <hahnjo@hahnjo.de>, Guo Ren <guoren@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Brice Goglin <Brice.Goglin@inria.fr>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 10:53 AM Conor Dooley <mail@conchuod.ie> wrote:
>
> From: Conor Dooley <conor.dooley@microchip.com>
>
> arm64's method of defining a default cpu topology requires only minimal
> changes to apply to RISC-V also. The current arm64 implementation exits
> early in a uniprocessor configuration by reading MPIDR & claiming that
> uniprocessor can rely on the default values.
>
> This is appears to be a hangover from prior to '3102bc0e6ac7 ("arm64:
> topology: Stop using MPIDR for topology information")', because the
> current code just assigns default values for multiprocessor systems.
>
> With the MPIDR references removed, store_cpu_topolgy() can be moved to
> the common arch_topology code.
>
> CC: stable@vger.kernel.org
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm64/kernel/topology.c | 40 ------------------------------------
>  drivers/base/arch_topology.c | 19 +++++++++++++++++
>  2 files changed, 19 insertions(+), 40 deletions(-)
>
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 869ffc4d4484..7889a00f5487 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -22,46 +22,6 @@
>  #include <asm/cputype.h>
>  #include <asm/topology.h>
>
> -void store_cpu_topology(unsigned int cpuid)
> -{
> -       struct cpu_topology *cpuid_topo = &cpu_topology[cpuid];
> -       u64 mpidr;
> -
> -       if (cpuid_topo->package_id != -1)
> -               goto topology_populated;
> -
> -       mpidr = read_cpuid_mpidr();
> -
> -       /* Uniprocessor systems can rely on default topology values */
> -       if (mpidr & MPIDR_UP_BITMASK)
> -               return;
> -
> -       /*
> -        * This would be the place to create cpu topology based on MPIDR.
> -        *
> -        * However, it cannot be trusted to depict the actual topology; some
> -        * pieces of the architecture enforce an artificial cap on Aff0 values
> -        * (e.g. GICv3's ICC_SGI1R_EL1 limits it to 15), leading to an
> -        * artificial cycling of Aff1, Aff2 and Aff3 values. IOW, these end up
> -        * having absolutely no relationship to the actual underlying system
> -        * topology, and cannot be reasonably used as core / package ID.
> -        *
> -        * If the MT bit is set, Aff0 *could* be used to define a thread ID, but
> -        * we still wouldn't be able to obtain a sane core ID. This means we
> -        * need to entirely ignore MPIDR for any topology deduction.
> -        */
> -       cpuid_topo->thread_id  = -1;
> -       cpuid_topo->core_id    = cpuid;
> -       cpuid_topo->package_id = cpu_to_node(cpuid);
> -
> -       pr_debug("CPU%u: cluster %d core %d thread %d mpidr %#016llx\n",
> -                cpuid, cpuid_topo->package_id, cpuid_topo->core_id,
> -                cpuid_topo->thread_id, mpidr);
> -
> -topology_populated:
> -       update_siblings_masks(cpuid);
> -}
> -
>  #ifdef CONFIG_ACPI
>  static bool __init acpi_cpu_is_threaded(int cpu)
>  {
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 0424b59b695e..0e2c6b30dd69 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -841,4 +841,23 @@ void __init init_cpu_topology(void)
>                 return;
>         }
>  }
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
>  #endif
> --
> 2.37.1
>

LGTM.
Reviewed-by: Atish Patra <atishp@rivosinc.com>



--
Regards,
Atish
