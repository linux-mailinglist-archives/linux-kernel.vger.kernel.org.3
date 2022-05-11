Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FAE523BD8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345796AbiEKRrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345040AbiEKRrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:47:12 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81B860D85
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652291229; x=1683827229;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iudZefHiDDwGdu63jqJ3y2xIQR76a6F1SKxwqrOVhrY=;
  b=GlWYvujOeQ8aSaarkhFcmWJuYgqJZOCVM2VnMsMkdXnOTTGQmRCtLwFS
   vWUza7+kanSbStABWYbNvU/vYHyIO7h6d8B3wobNrtvI46d7eHsWFtKcT
   TH0Hm63qyDJMnKpe71LvqJ9OfPBBcSo26q0Gd4huSejEPqd6Krcs06MaH
   F2+tSdfeyX7nlJ2yyPynKTPgtFyIsCKP+6NnjSsqMvOgLk1UuHh6Ks4/h
   jMWPRA9mQEgkVDyuZParvqmrTJwEtKn2kKl46GIdYkOr3lzD5eMrDWDQA
   R4UIjccI9rx0xRzYTidDu45g11ZwA/spHgTBB9Z3ATPvrXe/l1HNp3Je3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="332805622"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="332805622"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 10:47:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="636507570"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2022 10:47:08 -0700
Received: from [10.252.212.126] (kliang2-MOBL.ccr.corp.intel.com [10.252.212.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id ABDA05807E7;
        Wed, 11 May 2022 10:47:07 -0700 (PDT)
Message-ID: <208c46f9-ca5e-5825-3b4f-a805054315f4@linux.intel.com>
Date:   Wed, 11 May 2022 13:47:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 4/5] perf/x86: Change x86_pmu::limit_period signature
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        eranian@google.com
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org
References: <20220511142037.353492804@infradead.org>
 <20220511142345.289907761@infradead.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220511142345.289907761@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/2022 10:20 AM, Peter Zijlstra wrote:
> In preparation for making it a static_call, change the signature.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   arch/x86/events/amd/core.c   |    8 +++-----
>   arch/x86/events/core.c       |   18 ++++++++----------
>   arch/x86/events/intel/core.c |   19 ++++++++-----------
>   arch/x86/events/perf_event.h |    2 +-
>   4 files changed, 20 insertions(+), 27 deletions(-)
> 
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -1258,16 +1258,14 @@ static void amd_pmu_sched_task(struct pe
>   		amd_pmu_brs_sched_task(ctx, sched_in);
>   }
>   
> -static u64 amd_pmu_limit_period(struct perf_event *event, u64 left)
> +static void amd_pmu_limit_period(struct perf_event *event, s64 *left)
>   {
>   	/*
>   	 * Decrease period by the depth of the BRS feature to get the last N
>   	 * taken branches and approximate the desired period
>   	 */
> -	if (has_branch_stack(event) && left > x86_pmu.lbr_nr)
> -		left -= x86_pmu.lbr_nr;
> -
> -	return left;
> +	if (has_branch_stack(event) && *left > x86_pmu.lbr_nr)
> +		*left -= x86_pmu.lbr_nr;
>   }
>   
>   static __initconst const struct x86_pmu amd_pmu = {
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -621,8 +621,9 @@ int x86_pmu_hw_config(struct perf_event
>   		event->hw.config |= event->attr.config & X86_RAW_EVENT_MASK;
>   
>   	if (event->attr.sample_period && x86_pmu.limit_period) {
> -		if (x86_pmu.limit_period(event, event->attr.sample_period) >
> -				event->attr.sample_period)
> +		s64 left = event->attr.sample_period;
> +		x86_pmu.limit_period(event, &left);
> +		if (left > event->attr.sample_period)
>   			return -EINVAL;
>   	}
>   
> @@ -1386,19 +1387,14 @@ int x86_perf_event_set_period(struct per
>   		hwc->last_period = period;
>   		ret = 1;
>   	}
> -	/*
> -	 * Quirk: certain CPUs dont like it if just 1 hw_event is left:
> -	 */
> -	if (unlikely(left < 2))
> -		left = 2;
>

Is the quirk accidentally deleted?
We should still need the quirk for certain CPUs.

Thanks,
Kan

>   	if (left > x86_pmu.max_period)
>   		left = x86_pmu.max_period;
>   
>   	if (x86_pmu.limit_period)
> -		left = x86_pmu.limit_period(event, left);
> +		x86_pmu.limit_period(event, &left);
>   
> -	per_cpu(pmc_prev_left[idx], smp_processor_id()) = left;
> +	this_cpu_write(pmc_prev_left[idx], left);
>   
>   	/*
>   	 * The hw event starts counting from this event offset,
> @@ -2672,7 +2668,9 @@ static int x86_pmu_check_period(struct p
>   		return -EINVAL;
>   
>   	if (value && x86_pmu.limit_period) {
> -		if (x86_pmu.limit_period(event, value) > value)
> +		s64 left = value;
> +		x86_pmu.limit_period(event, &left);
> +		if (left > value)
>   			return -EINVAL;
>   	}
>   
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4244,28 +4244,25 @@ static u8 adl_get_hybrid_cpu_type(void)
>    * Therefore the effective (average) period matches the requested period,
>    * despite coarser hardware granularity.
>    */
> -static u64 bdw_limit_period(struct perf_event *event, u64 left)
> +static void bdw_limit_period(struct perf_event *event, s64 *left)
>   {
>   	if ((event->hw.config & INTEL_ARCH_EVENT_MASK) ==
>   			X86_CONFIG(.event=0xc0, .umask=0x01)) {
> -		if (left < 128)
> -			left = 128;
> -		left &= ~0x3fULL;
> +		if (*left < 128)
> +			*left = 128;
> +		*left &= ~0x3fULL;
>   	}
> -	return left;
>   }
>   
> -static u64 nhm_limit_period(struct perf_event *event, u64 left)
> +static void nhm_limit_period(struct perf_event *event, s64 *left)
>   {
> -	return max(left, 32ULL);
> +	*left = max(*left, 32LL);
>   }
>   
> -static u64 spr_limit_period(struct perf_event *event, u64 left)
> +static void spr_limit_period(struct perf_event *event, s64 *left)
>   {
>   	if (event->attr.precise_ip == 3)
> -		return max(left, 128ULL);
> -
> -	return left;
> +		*left = max(*left, 128LL);
>   }
>   
>   PMU_FORMAT_ATTR(event,	"config:0-7"	);
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -773,7 +773,7 @@ struct x86_pmu {
>   	struct event_constraint *event_constraints;
>   	struct x86_pmu_quirk *quirks;
>   	int		perfctr_second_write;
> -	u64		(*limit_period)(struct perf_event *event, u64 l);
> +	void		(*limit_period)(struct perf_event *event, s64 *l);
>   
>   	/* PMI handler bits */
>   	unsigned int	late_ack		:1,
> 
> 
