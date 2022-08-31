Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216665A7F0F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiHaNlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiHaNlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:41:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB041A831A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661953269; x=1693489269;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XFE5qRxQ7sfhl405yAHJz3QCH4eUpugbEXyqLmkV5xA=;
  b=aAgHn8aE3OyksyHwPLX3Yl5VoA+H4sZ1u+DqTObBS6vkhX1eAFHyrVVu
   9OL6CCgEAya5arQThS0ZZh/FQKoHGwjlHTYTqZspNCeL2eXsckfWKgQV4
   +91BfjOcTXamgY3c0f8zoa+j4qNAkq8Cq+DLb6FsJtGn5DQUZZbUvCRFN
   IrM4OwL9uDf2I2TjzzUwiJ+6QyDau+EJmcCN19s7066+C/MDBIjB9J6M1
   6Uh9JkFHPWlSKf3zdDiTDPnk86f70+2hynlPN77Og07oYetKr+VnCRmTN
   TKdn27iOhkoWTb8lN/AaruyGiODWNK/eB6OJMzCsGi6K4ZCJO84AswPyE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="296728523"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="296728523"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 06:41:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="754424620"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 31 Aug 2022 06:41:08 -0700
Received: from [10.252.208.162] (kliang2-mobl1.ccr.corp.intel.com [10.252.208.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 98516580BFE;
        Wed, 31 Aug 2022 06:41:07 -0700 (PDT)
Message-ID: <30dfae24-887d-128f-3172-d52c90c95f86@linux.intel.com>
Date:   Wed, 31 Aug 2022 09:41:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 2/9] perf/x86/intel: Move the topdown stuff into the
 intel driver
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        eranian@google.com, ravi.bangoria@amd.com
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org
References: <20220829100959.917169441@infradead.org>
 <20220829101321.505933457@infradead.org>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220829101321.505933457@infradead.org>
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
> Use the new x86_pmu::{set_period,update}() methods to push the topdown
> stuff into the Intel driver, where it belongs.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/events/core.c       |    7 -------
>  arch/x86/events/intel/core.c |   28 +++++++++++++++++++++++++---
>  2 files changed, 25 insertions(+), 10 deletions(-)
> 
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -119,9 +119,6 @@ u64 x86_perf_event_update(struct perf_ev
>  	if (unlikely(!hwc->event_base))
>  		return 0;
>  
> -	if (unlikely(is_topdown_count(event)) && x86_pmu.update_topdown_event)
> -		return x86_pmu.update_topdown_event(event);
> -
>  	/*
>  	 * Careful: an NMI might modify the previous event value.
>  	 *
> @@ -1373,10 +1370,6 @@ int x86_perf_event_set_period(struct per
>  	if (unlikely(!hwc->event_base))
>  		return 0;
>  
> -	if (unlikely(is_topdown_count(event)) &&
> -	    x86_pmu.set_topdown_event_period)
> -		return x86_pmu.set_topdown_event_period(event);
> -
>  	/*
>  	 * If we are way outside a reasonable range then just skip forward:
>  	 */
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2301,7 +2301,7 @@ static void intel_pmu_nhm_workaround(voi
>  	for (i = 0; i < 4; i++) {
>  		event = cpuc->events[i];
>  		if (event)
> -			x86_perf_event_update(event);
> +			static_call(x86_pmu_update)(event);
>  	}
>  
>  	for (i = 0; i < 4; i++) {
> @@ -2316,7 +2316,7 @@ static void intel_pmu_nhm_workaround(voi
>  		event = cpuc->events[i];
>  
>  		if (event) {
> -			x86_perf_event_set_period(event);
> +			static_call(x86_pmu_set_period)(event);
>  			__x86_pmu_enable_event(&event->hw,
>  					ARCH_PERFMON_EVENTSEL_ENABLE);
>  		} else
> @@ -2793,7 +2793,7 @@ static void intel_pmu_add_event(struct p
>   */
>  int intel_pmu_save_and_restart(struct perf_event *event)
>  {
> -	x86_perf_event_update(event);
> +	static_call(x86_pmu_update)(event);
>  	/*
>  	 * For a checkpointed counter always reset back to 0.  This
>  	 * avoids a situation where the counter overflows, aborts the
> @@ -2805,9 +2805,27 @@ int intel_pmu_save_and_restart(struct pe
>  		wrmsrl(event->hw.event_base, 0);
>  		local64_set(&event->hw.prev_count, 0);
>  	}
> +	return static_call(x86_pmu_set_period)(event);
> +}
> +
> +static int intel_pmu_set_period(struct perf_event *event)
> +{
> +	if (unlikely(is_topdown_count(event)) &&
> +	    x86_pmu.set_topdown_event_period)
> +		return x86_pmu.set_topdown_event_period(event);
> +
>  	return x86_perf_event_set_period(event);
>  }
>  
> +static u64 intel_pmu_update(struct perf_event *event)
> +{
> +	if (unlikely(is_topdown_count(event)) &&
> +	    x86_pmu.update_topdown_event)
> +		return x86_pmu.update_topdown_event(event);
> +
> +	return x86_perf_event_update(event);
> +}
> +
>  static void intel_pmu_reset(void)
>  {
>  	struct debug_store *ds = __this_cpu_read(cpu_hw_events.ds);
> @@ -4635,6 +4653,10 @@ static __initconst const struct x86_pmu
>  	.enable_all		= core_pmu_enable_all,
>  	.enable			= core_pmu_enable_event,
>  	.disable		= x86_pmu_disable_event,
> +
> +	.set_period		= intel_pmu_set_period,
> +	.update			= intel_pmu_update,

I tried the patch, but it impacts the topdown.
The root cause is that these should be added for intel_pmu rather than
core_pmu.

Thanks,
Kan
>  	.hw_config		= core_pmu_hw_config,
>  	.schedule_events	= x86_schedule_events,
>  	.eventsel		= MSR_ARCH_PERFMON_EVENTSEL0,
> 
> 
