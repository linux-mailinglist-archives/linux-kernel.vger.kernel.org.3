Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C4E569EDF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbiGGJv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbiGGJvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:51:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DC064D4F2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 02:51:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A332A1063;
        Thu,  7 Jul 2022 02:51:52 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 731493F792;
        Thu,  7 Jul 2022 02:51:48 -0700 (PDT)
Date:   Thu, 7 Jul 2022 10:50:37 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Zong Li <zong.li@sifive.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jonas Hahnfeld <hahnjo@hahnjo.de>, Guo Ren <guoren@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Changbin Du <changbin.du@intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Brice Goglin <Brice.Goglin@inria.fr>
Subject: Re: [PATCH] riscv: arch-topology: fix default topology reporting
Message-ID: <20220707095037.i2pjcc7zcf4pi3ht@bogus>
References: <20220706184558.2557301-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706184558.2557301-1-mail@conchuod.ie>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 07:45:59PM +0100, Conor Dooley wrote:
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

[...]

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

[...]

>  void __init smp_prepare_cpus(unsigned int max_cpus)
> @@ -161,6 +164,7 @@ asmlinkage __visible void smp_callin(void)
>  	mmgrab(mm);
>  	current->active_mm = mm;
>  
> +	store_cpu_topology(curr_cpuid);
>  	notify_cpu_starting(curr_cpuid);
>  	numa_add_cpu(curr_cpuid);
>  	update_siblings_masks(curr_cpuid);

If the above store_cpu_topology calls update_siblings_masks if required,
probably you can drop this explicit call here.

-- 
Regards,
Sudeep
