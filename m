Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58969598A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343999AbiHRRSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243702AbiHRRSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:18:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E37CD520
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:15:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA07EB8221B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 17:15:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC11C433C1;
        Thu, 18 Aug 2022 17:15:24 +0000 (UTC)
Date:   Thu, 18 Aug 2022 18:15:20 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] arm64: errata: add detection for AMEVCNTR01
 incrementing incorrectly
Message-ID: <Yv5zqC2AMN9NhRrA@arm.com>
References: <20220817121551.21790-1-ionela.voinescu@arm.com>
 <Yv0eVVmrnPp7fjaB@arm.com>
 <Yv4qp9xar9EBQaD8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv4qp9xar9EBQaD8@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 01:03:51PM +0100, Ionela Voinescu wrote:
> On Wednesday 17 Aug 2022 at 17:59:01 (+0100), Catalin Marinas wrote:
> > On Wed, Aug 17, 2022 at 01:15:51PM +0100, Ionela Voinescu wrote:
> > > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > > index 869ffc4d4484..5d7efb15f7cf 100644
> > > --- a/arch/arm64/kernel/topology.c
> > > +++ b/arch/arm64/kernel/topology.c
> > > @@ -301,7 +301,8 @@ static void cpu_read_corecnt(void *val)
> > >  
> > >  static void cpu_read_constcnt(void *val)
> > >  {
> > > -	*(u64 *)val = read_constcnt();
> > > +	*(u64 *)val = this_cpu_has_cap(ARM64_WORKAROUND_2457168) ?
> > > +		      0UL : read_constcnt();
> > >  }
> > >  
> > >  static inline
> > > @@ -328,7 +329,12 @@ int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
> > >   */
> > >  bool cpc_ffh_supported(void)
> > >  {
> > > -	return freq_counters_valid(get_cpu_with_amu_feat());
> > > +	int cpu = get_cpu_with_amu_feat();
> > > +
> > > +	if ((cpu >= nr_cpu_ids) || !cpumask_test_cpu(cpu, cpu_present_mask))
> > > +		return false;
> > > +
> > > +	return true;
> > >  }
> > 
> > So here we tell the core code that FFH is supported but always return 0
> > via cpc_read_ffh() if the const counter is requested. I assume the core
> > code figures this out and doesn't use the value on the affected CPUs. I
> > was hoping cpc_ffh_supported() would be per-CPU and the core code simply
> > skips calling cpc_read() on the broken cores.
> 
> I used to think the same, but I've realised that the current approach is
> best, in my opinion.
> 
> There are two users of these counters exposed though FFH in the kernel:
> CPPC-based frequency invariance(FIE) and reading current frequency through
> sysfs. If AMU counters are disabled or the CPU is affected by this
> erratum, a single read of 0 for any of the counters will result in
> cppc_get_perf_ctrs() returning -EFAULT which:
> 
> - (cppc_cpufreq_cpu_fie_init()) Will disable the use of FIE for that
>   policy, and those counters will never be read again for that CPU, for
>   the purpose of FIE. This is the operation that would result in reading
>   those counters most often, which in this case won't happen.
> 
> - Will return -EFAULT from cppc_cpufreq_get_rate() signaling to the user
>   that it cannot return a proper frequency using those counters. That's
>   cast to unsigned int so the user would have to be knowledgeable on the
>   matter :), but that's an existing problem.
> 
> Therefore, error checking based on a counter read of 0 would be
> equivalent here to checking a potential ffh_supported(cpu). Also, in the
> future we might use FFH to not only read these counters. So it's better
> to keep ffh_supported() to just reflect whether generically FFH is
> supported, even if in some cases the "backend" (AMUs here) is disabled
> or broken.

This works for me as long as the callers are aware of what a return of 0
when reading the counter means.

> > Is the other register read by cpc_read_ffh() still useful without the
> > const one?
> 
> Not for the current uses, and unlikely to be in the future - I don't see
> how the core counter value can be useful without a constant reference.

I was thinking of return 0 directly from cpc_read_ffh() since the other
counter is not used independently but I guess your approach matches the
erratum better since it's only the const counter that's broken.

> > While the Kconfig entry describes the behaviour, I'd rather have a
> > comment in cpc_ffh_supported() and maybe cpu_read_constcnt() on why we
> > do these tricks.
> 
> Will do!

Thanks. With comments added, feel free to add:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
