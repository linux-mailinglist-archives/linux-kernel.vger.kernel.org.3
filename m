Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1817159EB0A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiHWSb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbiHWSaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:30:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FEFE8324;
        Tue, 23 Aug 2022 09:50:45 -0700 (PDT)
Received: from [192.168.10.7] (unknown [39.53.61.43])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8FAC36601E65;
        Tue, 23 Aug 2022 17:50:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661273444;
        bh=hY4UauwPnBAn7SXILUibMKJAJRdq9GonmbVBaLHDGa4=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=VhV+UX2C2gG4FH0E2FB8l7EChKURkpPkGcS/VSWUVwe49cCkAsJQvDsP98xQqmJHD
         o2ly1QstjW/G1qzSRV1sMKz/A3J+qAchoQvNRTBtr3ZxrQP+OBQY43Tit2DmMC3emD
         juupJUBKB9oO78uurhoxu3W5zG3WQkzdEL7Z8Px71t2og2qEQTN5qj3WxKmV/fE9+/
         OyxVRKih6u4p+OKGKpsx3Du1RNiNp56J4jLujeZZKQyeDH++MiYo3K9WrA+WTG129Y
         Osg80AkZ3nqF7ztKyBX/LO2xXrYgygcX+tXJMu4KpC49mdYhLhHsdjPPvLvmbiM4B9
         C4VouDtn52uSg==
Message-ID: <84f991e0-4d14-7ea9-7553-9f688df9cd49@collabora.com>
Date:   Tue, 23 Aug 2022 21:50:34 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Cc:     usama.anjum@collabora.com, Steven Noonan <steven@uplinklabs.net>,
        kernel@collabora.com, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 1/3] x86/tsc: implement tsc=directsync for systems without
 IA32_TSC_ADJUST
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220808113954.345579-1-usama.anjum@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220808113954.345579-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kind reminder.

On 8/8/22 4:39 PM, Muhammad Usama Anjum wrote:
> From: Steven Noonan <steven@uplinklabs.net>
> 
> AMD processors don't implement any mechanism like Intel's
> IA32_TSC_ADJUST MSR to sync the TSC. Instead of just relying on the
> BIOS, TSC can be synced by calculating the difference and directly
> writing it to the TSC MSR.
> 
> Add directsync flag to turn on the TSC sync when IA32_TSC_MSR isn't
> available. Attempt 1000 times or for 30 seconds before giving up.
> 
> Signed-off-by: Steven Noonan <steven@uplinklabs.net>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  4 +-
>  arch/x86/include/asm/tsc.h                    |  1 +
>  arch/x86/kernel/tsc.c                         |  3 ++
>  arch/x86/kernel/tsc_sync.c                    | 46 +++++++++++++++----
>  4 files changed, 43 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index db5de5f0b9d3..f0e6ea580e68 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6271,7 +6271,7 @@
>  			If not specified, "default" is used. In this case,
>  			the RNG's choice is left to each individual trust source.
>  
> -	tsc=		Disable clocksource stability checks for TSC.
> +	tsc=		Disable clocksource stability checks for TSC or sync the TSC.
>  			Format: <string>
>  			[x86] reliable: mark tsc clocksource as reliable, this
>  			disables clocksource verification at runtime, as well
> @@ -6289,6 +6289,8 @@
>  			in situations with strict latency requirements (where
>  			interruptions from clocksource watchdog are not
>  			acceptable).
> +			[x86] directsync: attempt to sync the tsc via direct
> +			writes if MSR_IA32_TSC_ADJUST isn't available
>  
>  	tsc_early_khz=  [X86] Skip early TSC calibration and use the given
>  			value instead. Useful when the early TSC frequency discovery
> diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
> index fbdc3d951494..dc70909119e8 100644
> --- a/arch/x86/include/asm/tsc.h
> +++ b/arch/x86/include/asm/tsc.h
> @@ -42,6 +42,7 @@ extern unsigned long native_calibrate_tsc(void);
>  extern unsigned long long native_sched_clock_from_tsc(u64 tsc);
>  
>  extern int tsc_clocksource_reliable;
> +extern int tsc_allow_direct_sync;
>  #ifdef CONFIG_X86_TSC
>  extern bool tsc_async_resets;
>  #else
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index cafacb2e58cc..6345af65a549 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -47,6 +47,7 @@ static unsigned int __initdata tsc_early_khz;
>  static DEFINE_STATIC_KEY_FALSE(__use_tsc);
>  
>  int tsc_clocksource_reliable;
> +int tsc_allow_direct_sync;
>  
>  static u32 art_to_tsc_numerator;
>  static u32 art_to_tsc_denominator;
> @@ -303,6 +304,8 @@ static int __init tsc_setup(char *str)
>  		mark_tsc_unstable("boot parameter");
>  	if (!strcmp(str, "nowatchdog"))
>  		no_tsc_watchdog = 1;
> +	if (!strcmp(str, "directsync"))
> +		tsc_allow_direct_sync = 1;
>  	return 1;
>  }
>  
> diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
> index 9452dc9664b5..2a855991f982 100644
> --- a/arch/x86/kernel/tsc_sync.c
> +++ b/arch/x86/kernel/tsc_sync.c
> @@ -340,6 +340,8 @@ static cycles_t check_tsc_warp(unsigned int timeout)
>   */
>  static inline unsigned int loop_timeout(int cpu)
>  {
> +	if (!boot_cpu_has(X86_FEATURE_TSC_ADJUST))
> +		return 30;
>  	return (cpumask_weight(topology_core_cpumask(cpu)) > 1) ? 2 : 20;
>  }
>  
> @@ -360,13 +362,16 @@ void check_tsc_sync_source(int cpu)
>  
>  	/*
>  	 * Set the maximum number of test runs to
> -	 *  1 if the CPU does not provide the TSC_ADJUST MSR
> -	 *  3 if the MSR is available, so the target can try to adjust
> +	 *  3 if TSC_ADJUST MSR is available, so the target can try to adjust
> +	 *  1000 if TSC MSR can be written to compensate
> +	 *  1 if MSRs cannot be written
>  	 */
> -	if (!boot_cpu_has(X86_FEATURE_TSC_ADJUST))
> -		atomic_set(&test_runs, 1);
> -	else
> +	if (boot_cpu_has(X86_FEATURE_TSC_ADJUST))
>  		atomic_set(&test_runs, 3);
> +	else if (tsc_allow_direct_sync)
> +		atomic_set(&test_runs, 1000);
> +	else
> +		atomic_set(&test_runs, 1);
>  retry:
>  	/*
>  	 * Wait for the target to start or to skip the test:
> @@ -434,6 +439,21 @@ void check_tsc_sync_source(int cpu)
>  		goto retry;
>  }
>  
> +static inline cycles_t write_tsc_adjustment(cycles_t adjustment)
> +{
> +	cycles_t adjval, nextval;
> +
> +	rdmsrl(MSR_IA32_TSC, adjval);
> +	adjval += adjustment;
> +	wrmsrl(MSR_IA32_TSC, adjval);
> +	rdmsrl(MSR_IA32_TSC, nextval);
> +
> +	/*
> +	 * Estimated clock cycle overhead for wrmsr + rdmsr
> +	 */
> +	return nextval - adjval;
> +}
> +
>  /*
>   * Freshly booted CPUs call into this:
>   */
> @@ -441,7 +461,7 @@ void check_tsc_sync_target(void)
>  {
>  	struct tsc_adjust *cur = this_cpu_ptr(&tsc_adjust);
>  	unsigned int cpu = smp_processor_id();
> -	cycles_t cur_max_warp, gbl_max_warp;
> +	cycles_t cur_max_warp, gbl_max_warp, est_overhead = 0;
>  	int cpus = 2;
>  
>  	/* Also aborts if there is no TSC. */
> @@ -521,12 +541,18 @@ void check_tsc_sync_target(void)
>  	 * value is used. In the worst case the adjustment needs to go
>  	 * through a 3rd run for fine tuning.
>  	 */
> -	cur->adjusted += cur_max_warp;
> +	if (boot_cpu_has(X86_FEATURE_TSC_ADJUST)) {
> +		cur->adjusted += cur_max_warp;
>  
> -	pr_warn("TSC ADJUST compensate: CPU%u observed %lld warp. Adjust: %lld\n",
> -		cpu, cur_max_warp, cur->adjusted);
> +		pr_warn("TSC ADJUST compensate: CPU%u observed %lld warp. Adjust: %lld\n",
> +			cpu, cur_max_warp, cur->adjusted);
>  
> -	wrmsrl(MSR_IA32_TSC_ADJUST, cur->adjusted);
> +		wrmsrl(MSR_IA32_TSC_ADJUST, cur->adjusted);
> +	} else {
> +		pr_debug("TSC direct sync: CPU%u observed %lld warp. Overhead: %lld\n",
> +			cpu, cur_max_warp, est_overhead);
> +		est_overhead = write_tsc_adjustment(cur_max_warp + est_overhead);
> +	}
>  	goto retry;
>  
>  }

-- 
Muhammad Usama Anjum
