Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E29570680
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiGKPBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiGKPBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:01:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE39C5F9BA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:00:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE1D91596;
        Mon, 11 Jul 2022 08:00:57 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2DE23F70D;
        Mon, 11 Jul 2022 08:00:52 -0700 (PDT)
Date:   Mon, 11 Jul 2022 15:59:41 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
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
        Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Brice Goglin <Brice.Goglin@inria.fr>
Subject: Re: [PATCH v3 2/2] riscv: topology: fix default topology reporting
Message-ID: <20220711145941.q5rdrtavstjkp3km@bogus>
References: <20220709152354.2856586-1-mail@conchuod.ie>
 <20220709152354.2856586-3-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220709152354.2856586-3-mail@conchuod.ie>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2022 at 04:23:55PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> RISC-V has no sane defaults to fall back on where there is no cpu-map
> in the devicetree.
> Without sane defaults, the package, core and thread IDs are all set to
> -1. This causes user-visible inaccuracies for tools like hwloc/lstopo
> which rely on the sysfs cpu topology files to detect a system's
> topology.
> 
> On a PolarFire SoC, which should have 4 harts with a thread each,
> lstopo currently reports:
> 
> Machine (793MB total)
>   Package L#0
>     NUMANode L#0 (P#0 793MB)
>     Core L#0
>       L1d L#0 (32KB) + L1i L#0 (32KB) + PU L#0 (P#0)
>       L1d L#1 (32KB) + L1i L#1 (32KB) + PU L#1 (P#1)
>       L1d L#2 (32KB) + L1i L#2 (32KB) + PU L#2 (P#2)
>       L1d L#3 (32KB) + L1i L#3 (32KB) + PU L#3 (P#3)
> 
> Adding calls to store_cpu_topology() in {boot,smp} hart bringup code
> results in the correct topolgy being reported:
> 
> Machine (793MB total)
>   Package L#0
>     NUMANode L#0 (P#0 793MB)
>     L1d L#0 (32KB) + L1i L#0 (32KB) + Core L#0 + PU L#0 (P#0)
>     L1d L#1 (32KB) + L1i L#1 (32KB) + Core L#1 + PU L#1 (P#1)
>     L1d L#2 (32KB) + L1i L#2 (32KB) + Core L#2 + PU L#2 (P#2)
>     L1d L#3 (32KB) + L1i L#3 (32KB) + Core L#3 + PU L#3 (P#3)
> 
> CC: stable@vger.kernel.org
> Fixes: 03f11f03dbfe ("RISC-V: Parse cpu topology during boot.")
> Reported-by: Brice Goglin <Brice.Goglin@inria.fr>
> Link: https://github.com/open-mpi/hwloc/issues/536
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> ---
>  arch/riscv/Kconfig          | 2 +-
>  arch/riscv/kernel/smpboot.c | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 2af0701b7518..4b6c2fdbb57c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -52,7 +52,7 @@ config RISCV
>  	select COMMON_CLK
>  	select CPU_PM if CPU_IDLE
>  	select EDAC_SUPPORT
> -	select GENERIC_ARCH_TOPOLOGY if SMP
> +	select GENERIC_ARCH_TOPOLOGY

I am not sure of !SMP as ARM64 is default SMP only. I have never reviewed
the arch topology code with !SMP considered. I will leave that part to
RISC-V developers.

>  	select GENERIC_ATOMIC64 if !64BIT
>  	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
>  	select GENERIC_EARLY_IOREMAP
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index f1e4948a4b52..a1c861f84fe2 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -40,6 +40,8 @@ static DECLARE_COMPLETION(cpu_running);
>  void __init smp_prepare_boot_cpu(void)
>  {
>  	init_cpu_topology();
> +
> +	store_cpu_topology(smp_processor_id());
>  }
>  
>  void __init smp_prepare_cpus(unsigned int max_cpus)
> @@ -161,9 +163,9 @@ asmlinkage __visible void smp_callin(void)
>  	mmgrab(mm);
>  	current->active_mm = mm;
>  
> +	store_cpu_topology(curr_cpuid);
>  	notify_cpu_starting(curr_cpuid);
>  	numa_add_cpu(curr_cpuid);
> -	update_siblings_masks(curr_cpuid);
>  	set_cpu_online(curr_cpuid, 1);
>  
>  	/*

Other than that, this looks good. FWIW:
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
