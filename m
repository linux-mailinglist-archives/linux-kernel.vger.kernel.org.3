Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B15C4E98E2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243602AbiC1OGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbiC1OGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:06:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5EC165A4;
        Mon, 28 Mar 2022 07:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2M99mtkTvG5cK3m8zZkeFYPdptTQ9Ex4WvB2EKCnEKA=; b=FxvyRvKPeGf14lrLUisHLiO5o7
        ITRFIXXAnDPrMRry6X3MgjV8hFkKanuSuBJXFoOvQMDZxymkbSZqBiygcSQgCf7+tOyJS3KxokY1a
        Cp2xJkslDgv38ZHPhHbfp5svbHW7MMTqnNI6JNeXTEQmsLsSCFoNn6P5pTP4y/p9g4f27XKSRbk5b
        hExEhXPhmPrGZT/AVfBr6ecwIgKr7CklV6Z9Tj7GXK8+4HaOGlRP+Ej8m4EiLDvDMh9uJK/TXDX/i
        FDKWy/pbLPQ8aRmtLobXjfLfb1Cbsm8SxAlH54RxhvmC27vVGgyXYpDL4fe0C5wi+PEv0n1hDTQOu
        kckVnIyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nYpyQ-00Gypt-Sj; Mon, 28 Mar 2022 14:03:58 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 70F3D9861EA; Mon, 28 Mar 2022 16:03:58 +0200 (CEST)
Date:   Mon, 28 Mar 2022 16:03:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dongli Si <kvmx86@gmail.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, jolsa@kernel.org,
        joro@8bytes.org, kim.phillips@amd.com, liam.merwick@oracle.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, mingo@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH v4] perf/x86/amd: Don't touch the Host-only bit inside
 the guest hypervisor
Message-ID: <20220328140358.GF8939@worktop.programming.kicks-ass.net>
References: <20220324104217.GE8939@worktop.programming.kicks-ass.net>
 <20220327105603.2141333-1-sidongli1997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220327105603.2141333-1-sidongli1997@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2022 at 06:56:03PM +0800, Dongli Si wrote:

> From: Dongli Si <sidongli1997@gmail.com>
> 
> With nested virtualization on AMD Milan, if "perf record" is run in an
> L1 hypervisor with an L2 guest, the following warning is emitted in
> the L1 guest.
> 
> [] unchecked MSR access error: WRMSR to 0xc0010200 (tried to write 0x0000020000510076)
> at rIP: 0xffffffff81003a50 (x86_pmu_enable_all+0x60/0x100)
> [] Call Trace:
> []  <IRQ>
> []  ? x86_pmu_enable+0x146/0x300
> []  __perf_install_in_context+0x150/0x170
> 
> The AMD64_EVENTSEL_HOSTONLY bit is defined and used on the host (L0),
> while the L1 hypervisor Performance Monitor Unit should avoid such use.
> 
> Fixes: 1018faa6cf23 ("perf/x86/kvm: Fix Host-Only/Guest-Only counting with SVM disabled")
> Signed-off-by: Dongli Si <sidongli1997@gmail.com>
> Tested-by: Liam Merwick <liam.merwick@oracle.com>
> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
> ---
>  arch/x86/events/amd/core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 9687a8aef01c..5a1657c684f0 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -8,6 +8,7 @@
>  #include <linux/jiffies.h>
>  #include <asm/apicdef.h>
>  #include <asm/nmi.h>
> +#include <asm/hypervisor.h>
>  
>  #include "../perf_event.h"
>  
> @@ -1023,10 +1024,16 @@ __init int amd_pmu_init(void)
>  	return 0;
>  }
>  
> +/*
> + * Set the Host-only bit when virtualization is enabled on the Host Hypervisor
> + */
>  void amd_pmu_enable_virt(void)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  
> +	if (!hypervisor_is_type(X86_HYPER_NATIVE))
> +		return;
> +
>  	cpuc->perf_ctr_virt_mask = 0;
>  
>  	/* Reload all events */
> @@ -1035,10 +1042,16 @@ void amd_pmu_enable_virt(void)
>  }
>  EXPORT_SYMBOL_GPL(amd_pmu_enable_virt);
>  
> +/*
> + * Mask the Host-only bit when virtualization is disabled on the Host Hypervisor
> + */
>  void amd_pmu_disable_virt(void)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  
> +	if (!hypervisor_is_type(X86_HYPER_NATIVE))
> +		return;
> +
>  	/*
>  	 * We only mask out the Host-only bit so that host-only counting works
>  	 * when SVM is disabled. If someone sets up a guest-only counter when

Better I suppose, but I think the comments can be improved by covering
the 'why' of things. We can all read the code to see the what of it.

Anyway, doesn't this also affect behaviour? I'm guessing this HO bit is
only set by perf-record for events it wants to record on the host. But
by not setting it, we'll also record the activity of the guest.

So suppose we create a CPU wide HO event, then it will only count L0
activity, right? Any L1 (or higher) activite will be invisible.


But with this change on, the L1 HV doesn't provide these same semantics,
it's guest will be included in that host counter.

Or is there additional counter {dis,en}abling on virt enter,exit (resp.)
to achieve these semantics?
