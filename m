Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4782C5A50C8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiH2Pzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiH2Pzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:55:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0672E83F14
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661788537; x=1693324537;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HFPLv6WoHq6EGa80dvFEMfVw+Tqm+g1GYQJ/bxU+Ws4=;
  b=Nh+WRxHa+Fp9/APY1WMpJm9zsHrUD6YmzSkg/YpTGO+ts/EGhNrg9DMG
   Z48HeSAI4dJIbeqD7urqnsqp8o3WYlDdTzd0VNn6qq0m+yasUmQtQkjz1
   jtFWcxJtMQv4qbA0ZUiyZgR4sWefSVahPlvQ0Jx9SU8ZY5RMbM7CvYEkm
   MP/Dmu96+OzUV7ma9QsvE+TecAnLbF2N7CcoKKFfafOg7hDtK94Ppoprd
   h640/+NOPU42nNPeFcEMDgJ11n5bJ+hU/JV/wZQaima8vFkrDxA5IWndB
   +D7ktFbY4bSpETSR87Jtcm6bL0Gjo4cMq3O4dAMTtfi4+ZoiQOa4Cwt3F
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="296204814"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="296204814"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 08:55:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="939621320"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 29 Aug 2022 08:55:14 -0700
Received: from [10.252.208.168] (kliang2-mobl1.ccr.corp.intel.com [10.252.208.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 6CCA5580C20;
        Mon, 29 Aug 2022 08:55:13 -0700 (PDT)
Message-ID: <e8b5086e-735f-51ea-f413-3b2d456c0e32@linux.intel.com>
Date:   Mon, 29 Aug 2022 11:55:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 9/9] perf/x86/intel: Optimize short PEBS counters
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        eranian@google.com, ravi.bangoria@amd.com
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org
References: <20220829100959.917169441@infradead.org>
 <20220829101321.971473694@infradead.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220829101321.971473694@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-08-29 6:10 a.m., Peter Zijlstra wrote:
> XXX: crazy idea; really not sure this is worth the extra complexity
> 
> It is possible to have the counter programmed to a value smaller than
> the sampling period.

I'm not quite sure how the above case can be triggered.

For the most of the cases, the pmc_prev_left[idx] should be the same as
the hwc->period_left.

For the left < 2 or the limit_period case, I think perf usually program
a larger value, so the pmc_prev_left[idx] > hwc->period_left.

It looks like the only case, which triggers the pmc_prev_left[idx] <
hwc->period_left, is the left > max_period. I don't think it's common
for a user to set a period which is larger than the HW counter limit.
Even if they set a huge period, the PEBS overhead should not be an
issue, since it may causes days to trigger a sample.

If so, it may not be a good idea to introduce such complexity to only
handle such rare cases.

Thanks,
Kan

> In that case, the code suppresses the sample,
> recalculates the remaining events and reprograms the counter.
> 
> This should also work for PEBS counters (and it does); however
> triggering a full PEBS assist and parsing the event from the DS is
> more overhead than is required.
> 
> As such, detect this case and temporarily suppress PEBS. This will
> then trigger a regular PMI for the counter which will reprogram the
> event and re-enable PEBS once the target period is in reach.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/events/intel/core.c |   80 ++++++++++++++++++++++++++++++++++++++-----
>  arch/x86/events/perf_event.h |    9 ++++
>  2 files changed, 81 insertions(+), 8 deletions(-)
> 
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2722,12 +2722,7 @@ static void intel_pmu_enable_fixed(struc
>  
>  	intel_set_masks(event, idx);
>  
> -	/*
> -	 * Enable IRQ generation (0x8), if not PEBS,
> -	 * and enable ring-3 counting (0x2) and ring-0 counting (0x1)
> -	 * if requested:
> -	 */
> -	if (!event->attr.precise_ip)
> +	if (hwc->config & ARCH_PERFMON_EVENTSEL_INT)
>  		bits |= 0x8;
>  	if (hwc->config & ARCH_PERFMON_EVENTSEL_USR)
>  		bits |= 0x2;
> @@ -2816,12 +2811,75 @@ int intel_pmu_save_and_restart(struct pe
>  	return static_call(x86_pmu_set_period)(event);
>  }
>  
> +static void intel_pmu_update_config(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 config = hwc->config;
> +
> +	if (hwc->idx >= INTEL_PMC_IDX_FIXED) { /* PEBS is limited to real PMCs */
> +		u64 mask = 0xf, bits = 0;
> +
> +		if (config & ARCH_PERFMON_EVENTSEL_INT)
> +			bits |= 0x8;
> +		if (config & ARCH_PERFMON_EVENTSEL_USR)
> +			bits |= 0x2;
> +		if (config & ARCH_PERFMON_EVENTSEL_OS)
> +			bits |= 0x1;
> +
> +		bits <<= (hwc->idx * 4);
> +		mask <<= (hwc->idx * 4);
> +
> +		config = this_cpu_read(intel_fixed_ctrl);
> +		config &= ~mask;
> +		config |= bits;
> +		this_cpu_write(intel_fixed_ctrl, config);
> +	}
> +
> +	wrmsrl(hwc->config_base, config);
> +}
> +
> +static void intel_pmu_handle_short_pebs(struct perf_event *event)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	/* if the event is not enabled; intel_pmu_pebs_enable() DTRT */
> +	if (!test_bit(hwc->idx, cpuc->active_mask))
> +		return;
> +
> +	WARN_ON_ONCE(cpuc->enabled);
> +
> +	if (intel_pmu_is_short_pebs(event)) {
> +
> +		/* stripped down intel_pmu_pebs_disable() */
> +		cpuc->pebs_enabled &= ~(1ULL << hwc->idx);
> +		hwc->config |= ARCH_PERFMON_EVENTSEL_INT;
> +
> +		intel_pmu_update_config(event);
> +
> +	} else if (!(cpuc->pebs_enabled & (1ULL << hwc->idx))) {
> +
> +		/* stripped down intel_pmu_pebs_enable() */
> +		hwc->config &= ~ARCH_PERFMON_EVENTSEL_INT;
> +		cpuc->pebs_enabled |= (1ULL << hwc->idx);
> +
> +		intel_pmu_update_config(event);
> +	}
> +}
> +
>  static int intel_pmu_set_period(struct perf_event *event)
>  {
> +	int ret;
> +
>  	if (unlikely(is_topdown_count(event)))
>  		return static_call(intel_pmu_set_topdown_event_period)(event);
>  
> -	return x86_perf_event_set_period(event);
> +	ret = x86_perf_event_set_period(event);
> +
> +	if (event->attr.precise_ip)
> +		intel_pmu_handle_short_pebs(event);
> +
> +	return ret;
>  }
>  
>  static u64 intel_pmu_update(struct perf_event *event)
> @@ -2975,6 +3033,9 @@ static int handle_pmi_common(struct pt_r
>  		 * MSR_IA32_PEBS_ENABLE is not updated. Because the
>  		 * cpuc->enabled has been forced to 0 in PMI.
>  		 * Update the MSR if pebs_enabled is changed.
> +		 *
> +		 * Also; short counters temporarily disable PEBS, see
> +		 * intel_pmu_set_period().
>  		 */
>  		if (pebs_enabled != cpuc->pebs_enabled)
>  			wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
> @@ -3856,7 +3917,10 @@ static int intel_pmu_hw_config(struct pe
>  		if ((event->attr.config & INTEL_ARCH_EVENT_MASK) == INTEL_FIXED_VLBR_EVENT)
>  			return -EINVAL;
>  
> -		if (!(event->attr.freq || (event->attr.wakeup_events && !event->attr.watermark))) {
> +		if (!(event->attr.freq ||
> +		      (event->attr.wakeup_events && !event->attr.watermark) ||
> +		      event->attr.sample_period > x86_pmu.max_period)) {
> +
>  			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
>  			if (!(event->attr.sample_type &
>  			      ~intel_pmu_large_pebs_flags(event))) {
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -1063,6 +1063,15 @@ static inline bool x86_pmu_has_lbr_calls
>  DECLARE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
>  DECLARE_PER_CPU(u64 [X86_PMC_IDX_MAX], pmc_prev_left);
>  
> +static inline bool intel_pmu_is_short_pebs(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	s64 counter = this_cpu_read(pmc_prev_left[hwc->idx]);
> +	s64 left = local64_read(&hwc->period_left);
> +
> +	return counter < left;
> +}
> +
>  int x86_perf_event_set_period(struct perf_event *event);
>  
>  /*
> 
> 
