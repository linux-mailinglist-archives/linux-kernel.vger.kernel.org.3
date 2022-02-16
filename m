Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1814B91F0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238481AbiBPT5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:57:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237078AbiBPT50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:57:26 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 067C7222DE7;
        Wed, 16 Feb 2022 11:57:13 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nKQQI-00055x-00; Wed, 16 Feb 2022 20:57:10 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 106FEC2502; Wed, 16 Feb 2022 20:50:17 +0100 (CET)
Date:   Wed, 16 Feb 2022 20:50:17 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mips-fixes] MIPS: smp: fill in sibling and core maps
 earlier
Message-ID: <20220216195016.GA17453@alpha.franken.de>
References: <20220212221347.442070-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212221347.442070-1-alobakin@pm.me>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 10:21:11PM +0000, Alexander Lobakin wrote:
> After enabling CONFIG_SCHED_CORE (landed during 5.14 cycle),
> 2-core 2-thread-per-core interAptiv (CPS-driven) started emitting
> the following:
> 
> [    0.025698] CPU1 revision is: 0001a120 (MIPS interAptiv (multi))
> [    0.048183] ------------[ cut here ]------------
> [    0.048187] WARNING: CPU: 1 PID: 0 at kernel/sched/core.c:6025 sched_core_cpu_starting+0x198/0x240
> [    0.048220] Modules linked in:
> [    0.048233] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.17.0-rc3+ #35 b7b319f24073fd9a3c2aa7ad15fb7993eec0b26f
> [    0.048247] Stack : 817f0000 00000004 327804c8 810eb050 00000000 00000004 00000000 c314fdd1
> [    0.048278]         830cbd64 819c0000 81800000 817f0000 83070bf4 00000001 830cbd08 00000000
> [    0.048307]         00000000 00000000 815fcbc4 00000000 00000000 00000000 00000000 00000000
> [    0.048334]         00000000 00000000 00000000 00000000 817f0000 00000000 00000000 817f6f34
> [    0.048361]         817f0000 818a3c00 817f0000 00000004 00000000 00000000 4dc33260 0018c933
> [    0.048389]         ...
> [    0.048396] Call Trace:
> [    0.048399] [<8105a7bc>] show_stack+0x3c/0x140
> [    0.048424] [<8131c2a0>] dump_stack_lvl+0x60/0x80
> [    0.048440] [<8108b5c0>] __warn+0xc0/0xf4
> [    0.048454] [<8108b658>] warn_slowpath_fmt+0x64/0x10c
> [    0.048467] [<810bd418>] sched_core_cpu_starting+0x198/0x240
> [    0.048483] [<810c6514>] sched_cpu_starting+0x14/0x80
> [    0.048497] [<8108c0f8>] cpuhp_invoke_callback_range+0x78/0x140
> [    0.048510] [<8108d914>] notify_cpu_starting+0x94/0x140
> [    0.048523] [<8106593c>] start_secondary+0xbc/0x280
> [    0.048539]
> [    0.048543] ---[ end trace 0000000000000000 ]---
> [    0.048636] Synchronize counters for CPU 1: done.
> 
> ...for each but CPU 0/boot.
> Basic debug printks right before the mentioned line say:
> 
> [    0.048170] CPU: 1, smt_mask:
> 
> So smt_mask, which is sibling mask obviously, is empty when entering
> the function.
> This is critical, as sched_core_cpu_starting() calculates
> core-scheduling parameters only once per CPU start, and it's crucial
> to have all the parameters filled in at that moment (at least it
> uses cpu_smt_mask() which in fact is `&cpu_sibling_map[cpu]` on
> MIPS).
> 
> A bit of debugging led me to that set_cpu_sibling_map() performing
> the actual map calculation, was being invocated after
> notify_cpu_start(), and exactly the latter function starts CPU HP
> callback round (sched_core_cpu_starting() is basically a CPU HP
> callback).
> While the flow is same on ARM64 (maps after the notifier, although
> before calling set_cpu_online()), x86 started calculating sibling
> maps earlier than starting the CPU HP callbacks in Linux 4.14 (see
> [0] for the reference). Neither me nor my brief tests couldn't find
> any potential caveats in calculating the maps right after performing
> delay calibration, but the WARN splat is now gone.
> The very same debug prints now yield exactly what I expected from
> them:
> 
> [    0.048433] CPU: 1, smt_mask: 0-1
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/commit/?id=76ce7cfe35ef
> 
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> ---
>  arch/mips/kernel/smp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> index d542fb7af3ba..1986d1309410 100644
> --- a/arch/mips/kernel/smp.c
> +++ b/arch/mips/kernel/smp.c
> @@ -351,6 +351,9 @@ asmlinkage void start_secondary(void)
>  	cpu = smp_processor_id();
>  	cpu_data[cpu].udelay_val = loops_per_jiffy;
> 
> +	set_cpu_sibling_map(cpu);
> +	set_cpu_core_map(cpu);
> +
>  	cpumask_set_cpu(cpu, &cpu_coherent_mask);
>  	notify_cpu_starting(cpu);
> 
> @@ -362,9 +365,6 @@ asmlinkage void start_secondary(void)
>  	/* The CPU is running and counters synchronised, now mark it online */
>  	set_cpu_online(cpu, true);
> 
> -	set_cpu_sibling_map(cpu);
> -	set_cpu_core_map(cpu);
> -
>  	calculate_cpu_foreign_map();
> 
>  	/*
> --
> 2.35.1

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
