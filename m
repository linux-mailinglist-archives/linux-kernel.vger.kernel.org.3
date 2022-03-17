Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A364DC56A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbiCQMDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiCQMDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:03:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A0F1E95C3;
        Thu, 17 Mar 2022 05:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3++HdOl5/TQ4I3YFaITK3tuzbX0i4NIW2uwW5pHes2c=; b=hsM8bjhnyD5R1J89WaDw9wN/c2
        EBRm2qfvZboIuL6ynMzZTOjepKdshU12UhoOfSgIOwC+XxYgLSflUvBbUf2Pl6r2TIuWsegodyy7N
        QU2XoKI/149rpyDQqmQakB4/kFs9PPnVnrYMAjxMgMWhL4dE1lyGvVKiw83jdfLsZTS9RLSEJWhm/
        XM6FKTgZ+L4TA33DxbwS/ZhfGXjlwDxnnCUgDm1AB58RycBswdr2IU0t+zFW/YpbMPgKn1W85/e2E
        syomSXqSHIvDCFWszJZHuaCbF8UNLQWdrLqTXm/EF2imD60d6lwyl09oR7aVIxeOMpgPwAk4JDK2e
        S4RisGnA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUopM-001seJ-Hv; Thu, 17 Mar 2022 12:02:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 94DAC30003A;
        Thu, 17 Mar 2022 13:01:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7DA432B3B2764; Thu, 17 Mar 2022 13:01:58 +0100 (CET)
Date:   Thu, 17 Mar 2022 13:01:58 +0100
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
Subject: Re: [PATCH 6/7] perf/x86/amd/core: Add PerfMonV2 overflow handling
Message-ID: <YjMjNvrGa7ZK/x3H@hirez.programming.kicks-ass.net>
References: <cover.1647498015.git.sandipan.das@amd.com>
 <7d43b4ba8a7c3c0833495f3fabfcfc6df8db3732.1647498015.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d43b4ba8a7c3c0833495f3fabfcfc6df8db3732.1647498015.git.sandipan.das@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 11:58:35AM +0530, Sandipan Das wrote:

> +static inline u64 amd_pmu_get_global_overflow(void)
> +{
> +	u64 status;
> +
> +	/* PerfCntrGlobalStatus is read-only */
> +	rdmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, status);
> +
> +	return status & amd_pmu_global_cntr_mask;
> +}
> +
> +static inline void amd_pmu_ack_global_overflow(u64 status)
> +{
> +	/*
> +	 * PerfCntrGlobalStatus is read-only but an overflow acknowledgment
> +	 * mechanism exists; writing 1 to a bit in PerfCntrGlobalStatusClr
> +	 * clears the same bit in PerfCntrGlobalStatus
> +	 */
> +
> +	/* Only allow modifications to PerfCntrGlobalStatus.PerfCntrOvfl */
> +	status &= amd_pmu_global_cntr_mask;
> +	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, status);
> +}
> +
> +static bool amd_pmu_legacy_has_overflow(int idx)
> +{
> +	u64 counter;
> +
> +	rdmsrl(x86_pmu_event_addr(idx), counter);
> +
> +	return !(counter & BIT_ULL(x86_pmu.cntval_bits - 1));
> +}
> +
> +static bool amd_pmu_global_has_overflow(int idx)
> +{
> +	return amd_pmu_get_global_overflow() & BIT_ULL(idx);
> +}
> +
> +DEFINE_STATIC_CALL(amd_pmu_has_overflow, amd_pmu_legacy_has_overflow);
> +
>  /*
>   * When a PMC counter overflows, an NMI is used to process the event and
>   * reset the counter. NMI latency can result in the counter being updated
> @@ -613,7 +653,6 @@ static inline void amd_pmu_set_global_ctl(u64 ctl)
>  static void amd_pmu_wait_on_overflow(int idx)
>  {
>  	unsigned int i;
> -	u64 counter;
>  
>  	/*
>  	 * Wait for the counter to be reset if it has overflowed. This loop
> @@ -621,8 +660,7 @@ static void amd_pmu_wait_on_overflow(int idx)
>  	 * forever...
>  	 */
>  	for (i = 0; i < OVERFLOW_WAIT_COUNT; i++) {
> -		rdmsrl(x86_pmu_event_addr(idx), counter);
> -		if (counter & (1ULL << (x86_pmu.cntval_bits - 1)))
> +		if (!static_call(amd_pmu_has_overflow)(idx))
>  			break;
>  
>  		/* Might be in IRQ context, so can't sleep */

This scares me... please tell me you fixed that mess.

> @@ -718,6 +756,83 @@ static void amd_pmu_enable_event(struct perf_event *event)
>  	static_call(amd_pmu_enable_event)(event);
>  }
>  
> +static int amd_pmu_global_handle_irq(struct pt_regs *regs)
> +{
> +	struct perf_sample_data data;
> +	struct cpu_hw_events *cpuc;
> +	struct hw_perf_event *hwc;
> +	struct perf_event *event;
> +	u64 val, status, mask;
> +	int handled = 0, idx;
> +
> +	status = amd_pmu_get_global_overflow();
> +
> +	/* Check if any overflows are pending */
> +	if (!status)
> +		return 0;
> +
> +	/* Stop counting */
> +	amd_pmu_global_disable_all();


This seems weird to me, I'd first disable it, then read status. MSR
access is expensive, you want to shut down the PMU asap.

Also, this is written like PMI would not be the primary NMI source,
which seems somewhat unlikely.

> +
> +	cpuc = this_cpu_ptr(&cpu_hw_events);
> +
> +	/*
> +	 * Some chipsets need to unmask the LVTPC in a particular spot
> +	 * inside the nmi handler.  As a result, the unmasking was
> +	 * pushed into all the nmi handlers.
> +	 *
> +	 * This generic handler doesn't seem to have any issues where
> +	 * the unmasking occurs so it was left at the top.
> +	 *
> +	 * N.B. Taken from x86_pmu_handle_irq()
> +	 */

Please write an AMD specific comment here. Note how 'recent' Intel chips
ended up pushing this to the end of the handler. Verify with your
hardware team where they want this and write as much of the rationale as
you're allowed to share in the comment.

> +	apic_write(APIC_LVTPC, APIC_DM_NMI);
> +
> +	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
> +		if (!test_bit(idx, cpuc->active_mask))
> +			continue;
> +
> +		event = cpuc->events[idx];
> +		hwc = &event->hw;
> +		val = x86_perf_event_update(event);
> +		mask = BIT_ULL(idx);
> +
> +		if (!(status & mask))
> +			continue;
> +
> +		/* Event overflow */
> +		handled++;
> +		perf_sample_data_init(&data, 0, hwc->last_period);
> +
> +		if (!x86_perf_event_set_period(event))
> +			continue;
> +
> +		if (perf_event_overflow(event, &data, regs))
> +			x86_pmu_stop(event, 0);
> +
> +		status &= ~mask;
> +	}
> +
> +	/*
> +	 * It should never be the case that some overflows are not handled as
> +	 * the corresponding PMCs are expected to be inactive according to the
> +	 * active_mask
> +	 */
> +	WARN_ON(status > 0);
> +
> +	/* Clear overflow bits */
> +	amd_pmu_ack_global_overflow(~status);
> +
> +	inc_irq_stat(apic_perf_irqs);
> +
> +	/* Resume counting */
> +	amd_pmu_global_enable_all(0);

I think this is broken vs perf_pmu_{dis,en}able(), note how
intel_pmu_handle_irq() saves/restores the enable state.

> +
> +	return handled;
> +}
> +
> +DEFINE_STATIC_CALL(amd_pmu_handle_irq, x86_pmu_handle_irq);
> +
>  /*
>   * Because of NMI latency, if multiple PMC counters are active or other sources
>   * of NMIs are received, the perf NMI handler can handle one or more overflowed
> @@ -741,7 +856,7 @@ static int amd_pmu_handle_irq(struct pt_regs *regs)
>  	int handled;
>  
>  	/* Process any counter overflows */
> -	handled = x86_pmu_handle_irq(regs);
> +	handled = static_call(amd_pmu_handle_irq)(regs);
>  
>  	/*
>  	 * If a counter was handled, record a timestamp such that un-handled
> @@ -1041,6 +1156,8 @@ static int __init amd_core_pmu_init(void)
>  		static_call_update(amd_pmu_enable_all, amd_pmu_global_enable_all);
>  		static_call_update(amd_pmu_disable_all, amd_pmu_global_disable_all);
>  		static_call_update(amd_pmu_enable_event, amd_pmu_global_enable_event);
> +		static_call_update(amd_pmu_has_overflow, amd_pmu_global_has_overflow);
> +		static_call_update(amd_pmu_handle_irq, amd_pmu_global_handle_irq);
>  	}

Same, all this static_call() stuff is misguided.

Also, if you feel like it, you can create amd_pmu_v2.
