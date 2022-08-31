Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF13C5A7F45
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiHaNw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiHaNwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:52:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F1ED418D
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661953942; x=1693489942;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HWBRbF2PbdvN4PBXDLfgRZ00K3DXNb6yDsqH36AIk+0=;
  b=ggIIWJJvEoeC7udWOmOx89LlP/EHofHnRQx/9eFsH91SI8fm1WfnpUzw
   L+yHMNVbtUd5mD/dPLdBpmYcTTOhg8QWKKBijc5PBDCDCtdB4KCe7TYMl
   7wzY658kQBtlfe7DescFZTOgck+ciK+2UbVOE1iTKh20ZlTYFgFdiExa7
   LUpILRVqCHsMNgrCI88fgMpR72FIdiDFUtxba9SjCC0+hcOh0yBnsb6mt
   o3n/Lcks7RRHuNF9Yaz8b9bmlmvO1dIdDbO6Lp1zvXu/LiBaVezqaUG9x
   Zq7ug41Z8E41Ma+4jOAPidClpnhMVfJMM+qT5OzAR0TJONcOIR98WmoFi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="296234840"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="296234840"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 06:52:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="645236922"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 31 Aug 2022 06:52:21 -0700
Received: from [10.252.208.162] (kliang2-mobl1.ccr.corp.intel.com [10.252.208.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 23BCD580871;
        Wed, 31 Aug 2022 06:52:20 -0700 (PDT)
Message-ID: <0b8477e2-6e85-b349-0e92-e6a298531c18@linux.intel.com>
Date:   Wed, 31 Aug 2022 09:52:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 8/9] perf/x86/intel: Shadow
 MSR_ARCH_PERFMON_FIXED_CTR_CTRL
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        eranian@google.com, ravi.bangoria@amd.com
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org
References: <20220829100959.917169441@infradead.org>
 <20220829101321.905673933@infradead.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220829101321.905673933@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-08-29 6:10 a.m., Peter Zijlstra wrote:
> Less RDMSR is more better.

I had an RFC patch which does a further step to move the fixed
control register write to right before the entire PMU re-enabling, which
could also save some writes if there are several fixed counters enabled.
https://lore.kernel.org/lkml/20220804140729.2951259-1-kan.liang@linux.intel.com/

Do you have any comments for the RFC patch?

If the method is OK, I will rebase the RFC patch on top of this patch.

Thanks,
Kan
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/events/intel/core.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2405,6 +2405,8 @@ static inline void intel_clear_masks(str
>  	__clear_bit(idx, (unsigned long *)&cpuc->intel_cp_status);
>  }
>  
> +static DEFINE_PER_CPU(u64, intel_fixed_ctrl);
> +
>  static void intel_pmu_disable_fixed(struct perf_event *event)
>  {
>  	struct hw_perf_event *hwc = &event->hw;
> @@ -2426,8 +2428,9 @@ static void intel_pmu_disable_fixed(stru
>  	intel_clear_masks(event, idx);
>  
>  	mask = 0xfULL << ((idx - INTEL_PMC_IDX_FIXED) * 4);
> -	rdmsrl(hwc->config_base, ctrl_val);
> +	ctrl_val = this_cpu_read(intel_fixed_ctrl);
>  	ctrl_val &= ~mask;
> +	this_cpu_write(intel_fixed_ctrl, ctrl_val);>  	wrmsrl(hwc->config_base, ctrl_val);
>  }
>  
> @@ -2746,9 +2749,10 @@ static void intel_pmu_enable_fixed(struc
>  		mask |= ICL_FIXED_0_ADAPTIVE << (idx * 4);
>  	}
>  
> -	rdmsrl(hwc->config_base, ctrl_val);
> +	ctrl_val = this_cpu_read(intel_fixed_ctrl);
>  	ctrl_val &= ~mask;
>  	ctrl_val |= bits;
> +	this_cpu_write(intel_fixed_ctrl, ctrl_val);
>  	wrmsrl(hwc->config_base, ctrl_val);
>  }
>  
> 
> 
