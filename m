Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F7F59C071
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbiHVNZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbiHVNZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:25:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CBC2E6A4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661174700; x=1692710700;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2StsKFZsauW9yT/NopjAZkFBhqlqqFlpbtCcQEFUvYM=;
  b=YIacjJV89KxsUX8HXIejvX07KcXf9dM7n+gTlph8q3ctWb0pYVXvlaPx
   YWH5ArTithDetc4QW7YgIbKssni5g4k5a0tK5NXoNshK4e049lLwhMyZs
   951V+0yWwWeFX6/iEgLDjhnFx0H4W7rvSp5PAIPogTtpncwzQqBUxFej3
   JZ357e8yaGZDxM/uc8ekSB4NJamciXUd9gwdj19xLumOpTTLJrhDzu3cQ
   Vbg22H9odifOUI3cpcFsYczLdzGjOEhtkVJAIPPX6LJWy0gTvp0SAupz9
   Pv5+TW81Nk5tRCYqevJ+l1V14fA0Quw6baB7ERr3C5OP5WqmBVtqodyth
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="273799360"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="273799360"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 06:25:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="751282123"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 22 Aug 2022 06:24:59 -0700
Received: from [10.252.212.31] (kliang2-mobl1.ccr.corp.intel.com [10.252.212.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id DFF4558097C;
        Mon, 22 Aug 2022 06:24:58 -0700 (PDT)
Message-ID: <b54cd275-4fa6-9b5c-fdc2-858d2f7c1b46@linux.intel.com>
Date:   Mon, 22 Aug 2022 09:24:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [RESEND PATCH] perf/x86/intel: Fix unchecked MSR access error for
 Alder Lake N
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Jianfeng Gao <jianfeng.gao@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
References: <20220818181530.2355034-1-kan.liang@linux.intel.com>
 <Yv9EVP6O9r867om4@worktop.programming.kicks-ass.net>
 <Yv9Kw21Wl/f6KJTk@worktop.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Yv9Kw21Wl/f6KJTk@worktop.programming.kicks-ass.net>
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



On 2022-08-19 4:33 a.m., Peter Zijlstra wrote:
> On Fri, Aug 19, 2022 at 10:05:40AM +0200, Peter Zijlstra wrote:
>> On Thu, Aug 18, 2022 at 11:15:30AM -0700, kan.liang@linux.intel.com wrote:
>>
>>> The Alder Lake N only has e-cores. The X86_FEATURE_HYBRID_CPU flag is
>>> not set. The perf cannot retrieve the correct CPU type via
>>> get_this_hybrid_cpu_type(). The model specific get_hybrid_cpu_type() is
>>> hardcode to p-core. The wrong CPU type is given to the PMU of the
>>> Alder Lake N.
>>
>> If ADL-N isn't in fact a hybrid CPU, then *WHY* are we running
>> init_hybrid_pmu() and setting up all that nonsense?
>>
>> That is, wouldn't the right thing be to remove ALDERLAKE_N from the rest
>> of {ALDER,RAPTOP}LAKE and create a non-hybrid PMU setup for it?
>

I think the only issue should be the PMU name. The non-hybrid PMU name
is "cpu". The hybrid PMU name is "cpu_$coretype". If we move the
ALDERLAKE_N to the non-hybrid PMU, the PMU name will be changed from
"cpu_atom" to "cpu". It will be different from the rest of
{ALDER,RAPTOP}LAKE.

Also, I think we have to update the perf tool for the events because of
the PMU name change.

But I guess it should be OK, since the ALDERLAKE_N was just added and we
know its an Atom-only system.


> Something like the *completely* untested below.. which adds it like a
> regular atom chip (which it is).

I will do more tests and send out a V2.

Thanks,
Kan
> 
> (I basically did copy/paste of tremont and added bits from the cpu_atom
> thing from alderlake -- but might well have missed something)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 2db93498ff71..e509f1033a2d 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -5974,6 +5974,38 @@ __init int intel_pmu_init(void)
>  		name = "Tremont";
>  		break;
>  
> +	case INTEL_FAM6_ALDERLAKE_N:
> +		x86_pmu.mid_ack = true;
> +		memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
> +		       sizeof(hw_cache_event_ids));
> +		memcpy(hw_cache_extra_regs, tnt_hw_cache_extra_regs,
> +		       sizeof(hw_cache_extra_regs));
> +		hw_cache_event_ids[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)] = -1;
> +
> +		intel_pmu_lbr_init_skl();
> +
> +		x86_pmu.event_constraints = intel_slm_event_constraints;
> +		x86_pmu.pebs_constraints = intel_grt_pebs_event_constraints;
> +		x86_pmu.extra_regs = intel_grt_extra_regs;
> +		/*
> +		 * It's recommended to use CPU_CLK_UNHALTED.CORE_P + NPEBS
> +		 * for precise cycles.
> +		 */
> +		x86_pmu.pebs_aliases = NULL;
> +		x86_pmu.pebs_prec_dist = true;
> +		x86_pmu.lbr_pt_coexist = true;
> +		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
> +		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
> +		x86_pmu.flags |= PMU_FL_PEBS_ALL;
> +		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
> +		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
> +		x86_pmu.get_event_constraints = tnt_get_event_constraints;
> +		td_attr = tnt_events_attrs;
> +		extra_attr = slm_format_attr;
> +		pr_cont("Gracemont events, ");
> +		name = "Gracemont";
> +		break;
> +
>  	case INTEL_FAM6_WESTMERE:
>  	case INTEL_FAM6_WESTMERE_EP:
>  	case INTEL_FAM6_WESTMERE_EX:
> @@ -6318,7 +6350,6 @@ __init int intel_pmu_init(void)
>  
>  	case INTEL_FAM6_ALDERLAKE:
>  	case INTEL_FAM6_ALDERLAKE_L:
> -	case INTEL_FAM6_ALDERLAKE_N:
>  	case INTEL_FAM6_RAPTORLAKE:
>  	case INTEL_FAM6_RAPTORLAKE_P:
>  		/*
