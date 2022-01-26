Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33D749CCFA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242456AbiAZO6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:58:10 -0500
Received: from mga17.intel.com ([192.55.52.151]:59445 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242426AbiAZO6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643209088; x=1674745088;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aU2cxHB/rEcWcYGACRyCNBNGGjJa3uZ6907BLr6Hi0w=;
  b=Z/D5m7VY4mCOF06B0Zu6iX3DLT3t5KMeKxzr70E4syzOOa63+IB2s6SK
   gRPO852+V7GtUNQFqW5danBFoZtWDWeh2UGwlZ2tBdnJdtxbpXTlfHLzp
   NzaTYk9pujc8cTkHgDrkkONICuT40aD0rsNarN72OG8LgfXx4crQb8s4q
   MHe8Ph8xonhnShoxOAr3v0oF17CD/V/mv9qVQc/kifV9QJq6WFxyRG3hG
   F55EfpMjRhNCOJwZMDuH67qsBAf2ihb0YaQysktGdA5u0qfoHL6brDGeM
   rTaTD8r/WPwXhcE6ui1flL/fnwHbOdufAQdurH7K8KLv29lWqoOVzQ5w4
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="227237036"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="227237036"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 06:58:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="532779693"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jan 2022 06:58:06 -0800
Received: from [10.212.251.174] (kliang2-MOBL.ccr.corp.intel.com [10.212.251.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 382225808F0;
        Wed, 26 Jan 2022 06:58:05 -0800 (PST)
Message-ID: <57f21484-d8e2-afca-bf31-c11d2520b6c2@linux.intel.com>
Date:   Wed, 26 Jan 2022 09:58:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] x86/perf: Default freeze_on_smi on for Comet Lake and
 later.
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kyle Huey <me@kylehuey.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Andi Kleen <ak@linux.intel.com>
References: <20220122072644.92292-1-khuey@kylehuey.com>
 <Ye6Z31keWVPrsNWU@hirez.programming.kicks-ass.net>
 <3c35dc76-c187-8d3f-7fc9-75de32e7cbf6@linux.intel.com>
 <CAP045ArbX7cYKyv0H4X2SxUJWycB1VoLZWLME=_RXttBFBfP3A@mail.gmail.com>
 <7ef1bf66-4184-7f5b-c0bd-351ec743d4e9@linux.intel.com>
 <YfFU+2nMjEC1Mo3m@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <YfFU+2nMjEC1Mo3m@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/2022 9:04 AM, Peter Zijlstra wrote:
> On Tue, Jan 25, 2022 at 08:57:09AM -0500, Liang, Kan wrote:
>> I see. I was thought the unprivileged user can observe the SMM code on the
>> previous platforms. The CML+ change only makes part of the SMM code CPL0.
>> Seems I'm wrong. The change looks like changing the previous CPL0 code to
>> CPL3 code. If so, yes, I think we should prevent the information leaks for
>> the unprivileged user.
> 
> Right.
> 
>> Changing it to all platforms seems a too big hammer. I agree we should limit
>> it to the impacted platforms.
>>
>> I've contacted the author of the white paper. I was told that the change is
>> for the client vPro platforms. They are not sure whether it impacts Server
>> platform or Atom platforms. I'm still working on it. I will let you and
>> Peter know once I get more information.
> 
> For now I've updated the patch as per the below. I'm tempted to simply
> apply it as is and let it be.
> 
> Having different defaults for vPro vs !vPro chips seems more confusing
> than not.
>

But I think it should make sense to have different defaults for client 
vs server, or big core vs atom.

I'm still working on it and trying to figure out the affected 
generations. (Hope I can find the right contacts in the next few days.)

> We should also very much get this change reverted for future chips.
>

Yes. I will discuss it with the contacts once I get the name.

Thanks,
Kan

> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -6094,6 +6094,16 @@ __init int intel_pmu_init(void)
>   			x86_pmu.commit_scheduling = intel_tfa_commit_scheduling;
>   		}
>   
> +		if (boot_cpu_data.x86_model == INTEL_FAM6_COMETLAKE_L ||
> +		    boot_cpu_data.x86_model == INTEL_FAM6_COMETLAKE) {
> +			/*
> +			 * For some idiotic reason SMM is visible to USR
> +			 * counters. Since this is a privilege issue, default
> +			 * disable counters in SMM for these chips.
> +			 */
> +			x86_pmu.attr_freeze_on_smi = 1;
> +		}
> +
>   		pr_cont("Skylake events, ");
>   		name = "skylake";
>   		break;
> @@ -6135,6 +6145,8 @@ __init int intel_pmu_init(void)
>   		x86_pmu.num_topdown_events = 4;
>   		x86_pmu.update_topdown_event = icl_update_topdown_event;
>   		x86_pmu.set_topdown_event_period = icl_set_topdown_event_period;
> +		/* SMM visible in USR, see above */
> +		x86_pmu.attr_freeze_on_smi = 1;
>   		pr_cont("Icelake events, ");
>   		name = "icelake";
>   		break;
> @@ -6172,6 +6184,8 @@ __init int intel_pmu_init(void)
>   		x86_pmu.num_topdown_events = 8;
>   		x86_pmu.update_topdown_event = icl_update_topdown_event;
>   		x86_pmu.set_topdown_event_period = icl_set_topdown_event_period;
> +		/* SMM visible in USR, see above */
> +		x86_pmu.attr_freeze_on_smi = 1;
>   		pr_cont("Sapphire Rapids events, ");
>   		name = "sapphire_rapids";
>   		break;
> @@ -6217,6 +6231,8 @@ __init int intel_pmu_init(void)
>   		 * x86_pmu.rtm_abort_event.
>   		 */
>   		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xc9, .umask=0x04);
> +		/* SMM visible in USR, see above */
> +		x86_pmu.attr_freeze_on_smi = 1;
>   
>   		td_attr = adl_hybrid_events_attrs;
>   		mem_attr = adl_hybrid_mem_attrs;
