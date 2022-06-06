Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329E453E758
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbiFFMuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 08:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237822AbiFFMuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 08:50:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D492629EF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 05:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654519810; x=1686055810;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FkmXCaYNkRThvFgMKuWjh06x8owMuJed4czDVnJeMlc=;
  b=iXLN/6C3kIzDEyyVkSOxWfGa2wcJa0VkiqWuqydJZ5lfPLC2Fy375A8+
   ns1+avM+4Fac9LDBux/BuEvMc/d2pyLGqJ5j1olCvxQ7cGR19pwAlcU7D
   /UN/6TC9lh+pioGSChhsZOdPfMmloNtfXB7CqckNmYQPVlHC1dTCOMpN1
   3zmoKoLeXLxdUBq0JrcLhvfgU9C1+xtdHUKof34jaQ+hQ5DGtZctUb9F1
   uZKratCn3KBVHWRfPlFUwC6WwXq03zhBAn0kZopW7UKy2OMcEv/ciHbdi
   ewIzexW6jGdEpeI79LKqaYiqCt6NwWro51WdmHkflVG1JFse7/2/Hp44G
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="337566094"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="337566094"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 05:50:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="614344563"
Received: from hongyao1-mobl.ccr.corp.intel.com ([10.249.175.193])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 05:50:03 -0700
Message-ID: <1cc1af5000ceb5197c3b266ac82e7770d771a7b4.camel@intel.com>
Subject: Re: [PATCH v4 2/3] x86: Remove vendor checks from
 prefer_mwait_c1_over_halt
From:   Zhang Rui <rui.zhang@intel.com>
To:     Wyes Karny <wyes.karny@amd.com>, linux-kernel@vger.kernel.org
Cc:     Lewis.Carroll@amd.com, Mario.Limonciello@amd.com,
        gautham.shenoy@amd.com, Ananth.Narayan@amd.com, bharata@amd.com,
        len.brown@intel.com, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, chang.seok.bae@intel.com,
        keescook@chromium.org, metze@samba.org, zhengqi.arch@bytedance.com,
        mark.rutland@arm.com, puwen@hygon.cn, rafael.j.wysocki@intel.com,
        andrew.cooper3@citrix.com, jing2.liu@intel.com,
        jmattson@google.com, pawan.kumar.gupta@linux.intel.com
Date:   Mon, 06 Jun 2022 20:50:01 +0800
In-Reply-To: <67ca737f7cdabfc75f930cf59b49d910d8c491d6.1653324016.git-series.wyes.karny@amd.com>
References: <cover.7d2ba81d1918bbfd8ae5e6774db8da0502f7ed67.1653324016.git-series.wyes.karny@amd.com>
         <67ca737f7cdabfc75f930cf59b49d910d8c491d6.1653324016.git-series.wyes.karny@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-23 at 22:25 +0530, Wyes Karny wrote:
> Remove vendor checks from prefer_mwait_c1_over_halt function. Restore
> the decision tree to support MWAIT C1 as the default idle state based
> on
> CPUID checks as done by Thomas Gleixner in
> commit 09fd4b4ef5bc ("x86: use cpuid to check MWAIT support for C1")
> 
> The decision tree is removed in
> commit 69fb3676df33 ("x86 idle: remove mwait_idle() and "idle=mwait"
> cmdline param")
> 
> Prefer MWAIT when the following conditions are satisfied:
>     1. CPUID_Fn00000001_ECX [Monitor] should be set
>     2. CPUID_Fn00000005 should be supported
>     3. If CPUID_Fn00000005_ECX [EMX] is set then there should be
>        at least one C1 substate available, indicated by
>        CPUID_Fn00000005_EDX [MWaitC1SubStates] bits.
> 
> Otherwise use HLT for default_idle function.
> 
> HPC customers who want to optimize for lower latency are known to
> disable Global C-States in the BIOS. In fact, some vendors allow
> choosing a BIOS 'performance' profile which explicitly disables
> C-States.  In this scenario, the cpuidle driver will not be loaded
> and
> the kernel will continue with the default idle state chosen at boot
> time. On AMD systems currently the default idle state is HLT which
> has
> a higher exit latency compared to MWAIT.
> 
> The reason for the choice of HLT over MWAIT on AMD systems is:
> 
> 1. Families prior to 10h didn't support MWAIT
> 2. Families 10h-15h supported MWAIT, but not MWAIT C1. Hence it was
>    preferable to use HLT as the default state on these systems.
> 
> However, AMD Family 17h onwards supports MWAIT as well as MWAIT C1.
> And
> it is preferable to use MWAIT as the default idle state on these
> systems, as it has lower exit latencies.
> 
> The below table represents the exit latency for HLT and MWAIT on AMD
> Zen 3 system. Exit latency is measured by issuing a wakeup (IPI) to
> other CPU and measuring how many clock cycles it took to
> wakeup.  Each
> iteration measures 10K wakeups by pinning source and destination.
> 
> HLT:
> 
> 25.0000th percentile  :      1900 ns
> 50.0000th percentile  :      2000 ns
> 75.0000th percentile  :      2300 ns
> 90.0000th percentile  :      2500 ns
> 95.0000th percentile  :      2600 ns
> 99.0000th percentile  :      2800 ns
> 99.5000th percentile  :      3000 ns
> 99.9000th percentile  :      3400 ns
> 99.9500th percentile  :      3600 ns
> 99.9900th percentile  :      5900 ns
>   Min latency         :      1700 ns
>   Max latency         :      5900 ns
> Total Samples      9999
> 
> MWAIT:
> 
> 25.0000th percentile  :      1400 ns
> 50.0000th percentile  :      1500 ns
> 75.0000th percentile  :      1700 ns
> 90.0000th percentile  :      1800 ns
> 95.0000th percentile  :      1900 ns
> 99.0000th percentile  :      2300 ns
> 99.5000th percentile  :      2500 ns
> 99.9000th percentile  :      3200 ns
> 99.9500th percentile  :      3500 ns
> 99.9900th percentile  :      4600 ns
>   Min latency         :      1200 ns
>   Max latency         :      4600 ns
> Total Samples      9997
> 
> Improvement (99th percentile): 21.74%
> 
> Below is another result for context_switch2 micro-benchmark, which
> brings out the impact of improved wakeup latency through increased
> context-switches per second.
> 
> Link: https://ozlabs.org/~anton/junkcode/context_switch2.c
> 
> with HLT:
> -------------------------------
> 50.0000th percentile  :  190184
> 75.0000th percentile  :  191032
> 90.0000th percentile  :  192314
> 95.0000th percentile  :  192520
> 99.0000th percentile  :  192844
> MIN  :  190148
> MAX  :  192852
> 
> with MWAIT:
> -------------------------------
> 50.0000th percentile  :  277444
> 75.0000th percentile  :  278268
> 90.0000th percentile  :  278888
> 95.0000th percentile  :  279164
> 99.0000th percentile  :  280504
> MIN  :  273278
> MAX  :  281410
> 
> Improvement(99th percentile): ~ 45.46%
> 
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>

I couldn't evaluate the impact to other vendors, but at least for Intel
platforms,

Test-by: Zhang Rui <rui.zhang@intel.com>

> ---
>  arch/x86/include/asm/mwait.h |  1 +
>  arch/x86/kernel/process.c    | 35 +++++++++++++++++++++++++---------
> -
>  2 files changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mwait.h
> b/arch/x86/include/asm/mwait.h
> index 29dd27b5a339..3a8fdf881313 100644
> --- a/arch/x86/include/asm/mwait.h
> +++ b/arch/x86/include/asm/mwait.h
> @@ -13,6 +13,7 @@
>  #define MWAIT_SUBSTATE_SIZE		4
>  #define MWAIT_HINT2CSTATE(hint)		(((hint) >>
> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK)
>  #define MWAIT_HINT2SUBSTATE(hint)	((hint) & MWAIT_CSTATE_MASK)
> +#define MWAIT_C1_SUBSTATE_MASK  0xf0
>  
>  #define CPUID_MWAIT_LEAF		5
>  #define CPUID5_ECX_EXTENSIONS_SUPPORTED 0x1
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 4e0178b066c5..7bf4d73c9522 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -813,28 +813,43 @@ static void amd_e400_idle(void)
>  }
>  
>  /*
> - * Intel Core2 and older machines prefer MWAIT over HALT for C1.
> - * We can't rely on cpuidle installing MWAIT, because it will not
> load
> - * on systems that support only C1 -- so the boot default must be
> MWAIT.
> + * Prefer MWAIT over HALT if MWAIT is supported, MWAIT_CPUID leaf
> + * exists and whenever MONITOR/MWAIT extensions are present there is
> at
> + * least one C1 substate.
>   *
> - * Some AMD machines are the opposite, they depend on using HALT.
> - *
> - * So for default C1, which is used during boot until cpuidle loads,
> - * use MWAIT-C1 on Intel HW that has it, else use HALT.
> + * Do not prefer MWAIT if MONITOR instruction has a bug or
> idle=nomwait
> + * is passed to kernel commandline parameter.
>   */
>  static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
>  {
> +	u32 eax, ebx, ecx, edx;
> +
>  	/* User has disallowed the use of MWAIT. Fallback to HALT */
>  	if (boot_option_idle_override == IDLE_NOMWAIT)
>  		return 0;
>  
> -	if (c->x86_vendor != X86_VENDOR_INTEL)
> +	/* MWAIT is not supported on this platform. Fallback to HALT */
> +	if (!cpu_has(c, X86_FEATURE_MWAIT))
>  		return 0;
>  
> -	if (!cpu_has(c, X86_FEATURE_MWAIT) ||
> boot_cpu_has_bug(X86_BUG_MONITOR))
> +	/* Monitor has a bug. Fallback to HALT */
> +	if (boot_cpu_has_bug(X86_BUG_MONITOR))
>  		return 0;
>  
> -	return 1;
> +	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
> +
> +	/*
> +	 * If MWAIT extensions are not available, it is safe to use
> MWAIT
> +	 * with EAX=0, ECX=0.
> +	 */
> +	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED))
> +		return 1;
> +
> +	/*
> +	 * If MWAIT extensions are available, there should be at least
> one
> +	 * MWAIT C1 substate present.
> +	 */
> +	return (edx & MWAIT_C1_SUBSTATE_MASK);
>  }
>  
>  /*

