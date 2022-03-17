Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664AF4DC501
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbiCQLrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiCQLrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:47:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFEF1D2050;
        Thu, 17 Mar 2022 04:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uejdWJkIK1y9aZts1LyWLjHYedMA/hP4QQ5pF6Wz8DY=; b=BrsknFpwxai6iGoxbPLkD9nG6u
        01DQwNWWQKUGHwC3hZuQp7nKlj4tZ6c1NHqjLGoewzDC9PJP5Re5at5zxHNg58a+R667aGLhWsMes
        tHQlTvw7+DEyS0Gq/RKqQN2354NStG/nM+KsxLbFqC4gvWOnauTCxkwY0JjpzLR83hRxl4OaebdhB
        yDXV/naAza+mJOLTyZeG82WYegKwjUdIbJxzTh91yK+eAqvLcpMHcuDCHoJqUUEtcH/0znyJTxwXl
        HHtdot4d0NMlHp7utwnpOEqPRJ4BXYQUnS2JfEgs+mm9Ac9rmpt4FYQh8PkKhHWfuXC5FjwREvRKJ
        1uYRkG2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUoZw-001sOv-6i; Thu, 17 Mar 2022 11:46:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5AC4C3001EA;
        Thu, 17 Mar 2022 12:46:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3FC1F2B3B276F; Thu, 17 Mar 2022 12:46:03 +0100 (CET)
Date:   Thu, 17 Mar 2022 12:46:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        pbonzini@redhat.com, jmattson@google.com, like.xu.linux@gmail.com,
        eranian@google.com, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH 5/7] perf/x86/amd/core: Add PerfMonV2 counter control
Message-ID: <YjMfe7KyKp+a3Jkp@hirez.programming.kicks-ass.net>
References: <cover.1647498015.git.sandipan.das@amd.com>
 <7958e729c6be0f682379bec81f115b8cd7cca1ad.1647498015.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7958e729c6be0f682379bec81f115b8cd7cca1ad.1647498015.git.sandipan.das@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 11:58:34AM +0530, Sandipan Das wrote:
> @@ -625,12 +630,32 @@ static void amd_pmu_wait_on_overflow(int idx)
>  	}
>  }
>  
> +static void amd_pmu_global_enable_all(int added)
> +{
> +	amd_pmu_set_global_ctl(amd_pmu_global_cntr_mask);
> +}
> +
> +DEFINE_STATIC_CALL(amd_pmu_enable_all, x86_pmu_enable_all);
> +
> +static void amd_pmu_enable_all(int added)
> +{
> +	static_call(amd_pmu_enable_all)(added);
> +}
> +
> +static void amd_pmu_global_disable_all(void)
> +{
> +	/* Disable all PMCs */
> +	amd_pmu_set_global_ctl(0);
> +}
> +
> +DEFINE_STATIC_CALL(amd_pmu_disable_all, x86_pmu_disable_all);
> +
>  static void amd_pmu_disable_all(void)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  	int idx;
>  
> -	x86_pmu_disable_all();
> +	static_call(amd_pmu_disable_all)();
>  
>  	/*
>  	 * This shouldn't be called from NMI context, but add a safeguard here
> @@ -671,6 +696,28 @@ static void amd_pmu_disable_event(struct perf_event *event)
>  	amd_pmu_wait_on_overflow(event->hw.idx);
>  }
>  
> +static void amd_pmu_global_enable_event(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	/*
> +	 * Testing cpu_hw_events.enabled should be skipped in this case unlike
> +	 * in x86_pmu_enable_event().
> +	 *
> +	 * Since cpu_hw_events.enabled is set only after returning from
> +	 * x86_pmu_start(), the PMCs must be programmed and kept ready.
> +	 * Counting starts only after x86_pmu_enable_all() is called.
> +	 */
> +	__x86_pmu_enable_event(hwc, ARCH_PERFMON_EVENTSEL_ENABLE);
> +}
> +
> +DEFINE_STATIC_CALL(amd_pmu_enable_event, x86_pmu_enable_event);
> +
> +static void amd_pmu_enable_event(struct perf_event *event)
> +{
> +	static_call(amd_pmu_enable_event)(event);
> +}
> +
>  /*
>   * Because of NMI latency, if multiple PMC counters are active or other sources
>   * of NMIs are received, the perf NMI handler can handle one or more overflowed
> @@ -929,8 +976,8 @@ static __initconst const struct x86_pmu amd_pmu = {
>  	.name			= "AMD",
>  	.handle_irq		= amd_pmu_handle_irq,
>  	.disable_all		= amd_pmu_disable_all,
> -	.enable_all		= x86_pmu_enable_all,
> -	.enable			= x86_pmu_enable_event,
> +	.enable_all		= amd_pmu_enable_all,
> +	.enable			= amd_pmu_enable_event,
>  	.disable		= amd_pmu_disable_event,
>  	.hw_config		= amd_pmu_hw_config,
>  	.schedule_events	= x86_schedule_events,
> @@ -989,6 +1036,11 @@ static int __init amd_core_pmu_init(void)
>  		x86_pmu.num_counters = EXT_PERFMON_DEBUG_NUM_CORE_PMC(ebx);
>  
>  		amd_pmu_global_cntr_mask = (1ULL << x86_pmu.num_counters) - 1;
> +
> +		/* Update PMC handling functions */
> +		static_call_update(amd_pmu_enable_all, amd_pmu_global_enable_all);
> +		static_call_update(amd_pmu_disable_all, amd_pmu_global_disable_all);
> +		static_call_update(amd_pmu_enable_event, amd_pmu_global_enable_event);
>  	}


This makes no sense to me...

First and foremost, *please* tell me your shiny new hardware fixed the
terrible behaviour that requires the wait_on_overflow hacks in
amd_pmu_disable_all().

Second, all these x86_pmu methods are already static_calls per
arch/x86/events/core.c. So what you want to do is something like:

	x86_pmu = amd_pmu;
	if (amd_v2) {
		x86_pmu.disable_all = amd_v2_disable_all;
		x86_pmu.enable_all  = amd_v2_enable_all;
	}

And leave it at that.

