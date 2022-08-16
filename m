Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9725A595B78
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbiHPMM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbiHPMLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:11:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D4B52FC7;
        Tue, 16 Aug 2022 05:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660651488; x=1692187488;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JPEv+INvzivRm0inCJBymjDw3Cuf7fMhvpLQofQy4gM=;
  b=NfC15h+92R68zlFNU2vJ6tqgrqTO/QofA194pRbpYfa+TrQ9S1N8YvTe
   KhtnMaDEUxX8SNlV0WL22wB1t1R2jhd2omdKSpiyIdAEWuHc088au4HhE
   s/J2DHoqzLoNbNIPadZoK8JocUOUx0mC19yOSx5TbrQSi7UKbWkj2We6O
   ezqrftdF2g9m64+LrmLJeBKrGxxZwfA5KN30mMYmIdULgFtCvFETZxN/Q
   GxJCEKRVNDxGOgK5s0HbQN1whiRFUZdu2einqqTaG/fM+zYLr9JM11kOd
   3OC2VJ02xopSDcyWWO/HC7IW8a5p0iSMzjPvaXuVGn9119K/DDMxdZaHL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="292995190"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="292995190"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 05:04:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="635863478"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 16 Aug 2022 05:04:48 -0700
Received: from [10.252.211.42] (kliang2-mobl1.ccr.corp.intel.com [10.252.211.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 22CBC58094C;
        Tue, 16 Aug 2022 05:04:47 -0700 (PDT)
Message-ID: <2b020ea0-7b1f-034c-10dd-f38721776163@linux.intel.com>
Date:   Tue, 16 Aug 2022 08:04:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] perf/x86/core: Set pebs_capable and PMU_FL_PEBS_ALL for
 the Baseline
To:     Like Xu <like.xu.linux@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220816114057.51307-1-likexu@tencent.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220816114057.51307-1-likexu@tencent.com>
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



On 2022-08-16 7:40 a.m., Like Xu wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> The SDM explicitly states that PEBS Baseline implies Extended PEBS.
> For cpu model forward compatibility (e.g. on ICX, SPR, ADL), it's
> safe to stop doing FMS table thing such as setting pebs_capable and
> PMU_FL_PEBS_ALL since it's already set in the intel_ds_init().
> 
> The Goldmont Plus is the only platform which supports extended PEBS
> but doesn't have Baseline. Keep the status quo.
> 
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Reported-by: Like Xu <likexu@tencent.com>
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  arch/x86/events/intel/core.c | 4 ----
>  arch/x86/events/intel/ds.c   | 1 +
>  2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 2db93498ff71..cb98a05ee743 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -6291,10 +6291,8 @@ __init int intel_pmu_init(void)
>  		x86_pmu.pebs_aliases = NULL;
>  		x86_pmu.pebs_prec_dist = true;
>  		x86_pmu.pebs_block = true;
> -		x86_pmu.pebs_capable = ~0ULL;
>  		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
>  		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
> -		x86_pmu.flags |= PMU_FL_PEBS_ALL;
>  		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
>  		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
>  
> @@ -6337,10 +6335,8 @@ __init int intel_pmu_init(void)
>  		x86_pmu.pebs_aliases = NULL;
>  		x86_pmu.pebs_prec_dist = true;
>  		x86_pmu.pebs_block = true;
> -		x86_pmu.pebs_capable = ~0ULL;
>  		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
>  		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
> -		x86_pmu.flags |= PMU_FL_PEBS_ALL;
>  		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
>  		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
>  		x86_pmu.lbr_pt_coexist = true;
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index ba60427caa6d..ac6dd4c96dbc 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -2262,6 +2262,7 @@ void __init intel_ds_init(void)
>  					PERF_SAMPLE_BRANCH_STACK |
>  					PERF_SAMPLE_TIME;
>  				x86_pmu.flags |= PMU_FL_PEBS_ALL;
> +				x86_pmu.pebs_capable = ~0ULL;
>  				pebs_qual = "-baseline";
>  				x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
>  			} else {
