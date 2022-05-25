Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DB45341C4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245470AbiEYQ46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiEYQ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:56:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB0B92D14
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x1KHQf+5TwZyXYUK4oyCaJhl7u0Ap341ZJfy/U4kYRI=; b=DcFrQwYCoCWppcb9ObmbQ+YZmV
        12bc7CEroUdanI2WNNXMaHvT/bFywgZkiyj6zINd5uMxNA+ozoPkhrnUvp8pLQ0tuNzhQFt5gV+D2
        2t8hl9dXG8blYn7IysH+U7QuOekrn+opnqzjO36itTqaTbcC/C2lXsQmZEFWM0FUNjUu11pLJyGPm
        jVpYNf7dXev3HKpm7vuyik4g0CivLzVyGIy6i1eFCgkxZ41xAuYW+PsOjjG/DFjftUhzzcxf1IdyS
        txRlgGqd4Pdn0jrmT8tf3OnY0Ml2f+ylxcqA/dblqB8WswNtxs7OSDv/42i4Du2wY8BR5aVBa2VaQ
        hBtswZiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntuIX-001fkg-Cd; Wed, 25 May 2022 16:55:49 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 616EC980E04; Wed, 25 May 2022 18:55:48 +0200 (CEST)
Date:   Wed, 25 May 2022 18:55:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     linux-kernel@vger.kernel.org, Lewis.Carroll@amd.com,
        Mario.Limonciello@amd.com, gautham.shenoy@amd.com,
        Ananth.Narayan@amd.com, bharata@amd.com, len.brown@intel.com,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        chang.seok.bae@intel.com, keescook@chromium.org, metze@samba.org,
        zhengqi.arch@bytedance.com, mark.rutland@arm.com,
        rui.zhang@intel.com, puwen@hygon.cn, rafael.j.wysocki@intel.com,
        andrew.cooper3@citrix.com, jing2.liu@intel.com,
        jmattson@google.com, pawan.kumar.gupta@linux.intel.com
Subject: Re: [PATCH v4 2/3] x86: Remove vendor checks from
 prefer_mwait_c1_over_halt
Message-ID: <20220525165548.GJ2578@worktop.programming.kicks-ass.net>
References: <cover.7d2ba81d1918bbfd8ae5e6774db8da0502f7ed67.1653324016.git-series.wyes.karny@amd.com>
 <67ca737f7cdabfc75f930cf59b49d910d8c491d6.1653324016.git-series.wyes.karny@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ca737f7cdabfc75f930cf59b49d910d8c491d6.1653324016.git-series.wyes.karny@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 10:25:50PM +0530, Wyes Karny wrote:

> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 4e0178b066c5..7bf4d73c9522 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -813,28 +813,43 @@ static void amd_e400_idle(void)
>  }
>  
>  /*
> - * Intel Core2 and older machines prefer MWAIT over HALT for C1.
> - * We can't rely on cpuidle installing MWAIT, because it will not load
> - * on systems that support only C1 -- so the boot default must be MWAIT.
> + * Prefer MWAIT over HALT if MWAIT is supported, MWAIT_CPUID leaf
> + * exists and whenever MONITOR/MWAIT extensions are present there is at
> + * least one C1 substate.
>   *
> - * Some AMD machines are the opposite, they depend on using HALT.
> - *
> - * So for default C1, which is used during boot until cpuidle loads,
> - * use MWAIT-C1 on Intel HW that has it, else use HALT.
> + * Do not prefer MWAIT if MONITOR instruction has a bug or idle=nomwait
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
> -	if (!cpu_has(c, X86_FEATURE_MWAIT) || boot_cpu_has_bug(X86_BUG_MONITOR))
> +	/* Monitor has a bug. Fallback to HALT */
> +	if (boot_cpu_has_bug(X86_BUG_MONITOR))
>  		return 0;
>  
> -	return 1;
> +	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
> +
> +	/*
> +	 * If MWAIT extensions are not available, it is safe to use MWAIT
> +	 * with EAX=0, ECX=0.
> +	 */
> +	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED))
> +		return 1;
> +
> +	/*
> +	 * If MWAIT extensions are available, there should be at least one
> +	 * MWAIT C1 substate present.
> +	 */
> +	return (edx & MWAIT_C1_SUBSTATE_MASK);
>  }

Seems reasonable enough to me,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
