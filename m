Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA4558FC1A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbiHKMXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbiHKMXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:23:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DDA5925A
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 05:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660220615; x=1691756615;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OOQjmw22ZTBmgLTLgTnejA/3mhIIsQqZEO2imt1ZhSk=;
  b=KeNAQ3akNXEfBciYbKpL5KiTeAuL6Av0HLyHDSmbXeNdBdIMTZ11QW/+
   ikgms1cfaN1aNMDAikeAEWM8zm/PxzqN/lQ3VipNDRaAPrDWROEJqf+YK
   9eID+ZwMvQGhOIEgjosvDhL2VjpfCiYThwFTBcpGISd4woHFAipZltz22
   NxZL4OwkyRSCaejAsDP0+xGV6hfOmveRjKTjO5RCwE/SEgTndxqbyw2w4
   jr2e4ZdLkrXPd/YY1AOgRNhVezQYpvaoJdHZ6HllK2nTTCRC6s6cvuTAv
   4Jniy1CqzSNSwUq+H3QU0to4x0EdOZ/1rVYPxAF9FV59avCfyFu1uZ44u
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="271107804"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="271107804"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 05:23:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="694874256"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Aug 2022 05:23:34 -0700
Received: from [10.252.211.46] (kliang2-mobl1.ccr.corp.intel.com [10.252.211.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 2EF41580ADE;
        Thu, 11 Aug 2022 05:23:33 -0700 (PDT)
Message-ID: <0267c94e-7989-ca92-4175-d820d1d63a0c@linux.intel.com>
Date:   Thu, 11 Aug 2022 08:23:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] perf/x86/intel/lbr: fix branch type encoding
To:     Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kan.liang@intel.com, ak@linux.intel.com,
        acme@redhat.com, namhyung@kernel.org, irogers@google.com
References: <20220810210656.2799243-1-eranian@google.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220810210656.2799243-1-eranian@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-08-10 5:06 p.m., Stephane Eranian wrote:
> With architected LBR, the procesosr can record the type of each sampled taken
> branch. The type is encoded in 4-bit field in the LBR_INFO MSR of each entry.
> 
> The branch type must then extracted and saved in the perf_branch_entry in the
> perf_events sampling buffer. With the current code, the raw Intel encoding of
> the branch is exported to user tools. 

In the intel_pmu_lbr_filter(), the raw encoding will be converted into
the X86_BR_* format via arch_lbr_br_type_map[]. Then the
common_branch_type() will convert the X86_BR_* format to the generic
PERF_BR_* type and expose to user tools.

I double check the existing arch_lbr_br_type_map[] and branch_map[].
They should generate the same PERF_BR_* type as your arch_lbr_type_map[].

Is there a test case which I can use to reproduce the problem?

Thanks,
Kan

> Yet tools, such as perf, expected the
> branch type to be encoded using perf_events branch type enum
> (see tools/perf/util/branch.c). As a result of the discrepancy, the output of
> perf report -D shows bogus branch types.
> 
> Fix the problem by converting the Intel raw encoding into the perf_events
> branch type enum values. With that in place and with no changes to the tools,
> the branch types are now reported properly.
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> ---
>  arch/x86/events/intel/lbr.c | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 4f70fb6c2c1e..ef63d4d46b50 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -894,9 +894,23 @@ static DEFINE_STATIC_KEY_FALSE(x86_lbr_mispred);
>  static DEFINE_STATIC_KEY_FALSE(x86_lbr_cycles);
>  static DEFINE_STATIC_KEY_FALSE(x86_lbr_type);
>  
> -static __always_inline int get_lbr_br_type(u64 info)
> +/*
> + * Array index encodes IA32_LBR_x_INFO Branch Type Encodings
> + * as per Intel SDM Vol3b Branch Types section
> + */
> +static const int arch_lbr_type_map[]={
> +	[0] = PERF_BR_COND,
> +	[1] = PERF_BR_IND,
> +	[2] = PERF_BR_UNCOND,
> +	[3] = PERF_BR_IND_CALL,
> +	[4] = PERF_BR_CALL,
> +	[5] = PERF_BR_RET,
> +};
> +#define ARCH_LBR_TYPE_COUNT ARRAY_SIZE(arch_lbr_type_map)
> +
> +static __always_inline u16 get_lbr_br_type(u64 info)
>  {
> -	int type = 0;
> +	u16 type = 0;
>  
>  	if (static_branch_likely(&x86_lbr_type))
>  		type = (info & LBR_INFO_BR_TYPE) >> LBR_INFO_BR_TYPE_OFFSET;
> @@ -904,6 +918,21 @@ static __always_inline int get_lbr_br_type(u64 info)
>  	return type;
>  }
>  
> +/*
> + * The kernel cannot expose raw Intel branch type encodings because they are
> + * not generic. Instead, the function below  maps the encoding to the
> + * perf_events user visible branch types.
> + */
> +static __always_inline int get_lbr_br_type_mapping(u64 info)
> +{
> +	if (static_branch_likely(&x86_lbr_type)) {
> +		u16 raw_type = get_lbr_br_type(info);
> +		if (raw_type < ARCH_LBR_TYPE_COUNT)
> +			return arch_lbr_type_map[raw_type];
> +	}
> +	return PERF_BR_UNKNOWN;
> +}
> +
>  static __always_inline bool get_lbr_mispred(u64 info)
>  {
>  	bool mispred = 0;
> @@ -957,7 +986,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
>  		e->in_tx	= !!(info & LBR_INFO_IN_TX);
>  		e->abort	= !!(info & LBR_INFO_ABORT);
>  		e->cycles	= get_lbr_cycles(info);
> -		e->type		= get_lbr_br_type(info);
> +		e->type		= get_lbr_br_type_mapping(info);
>  	}
>  
>  	cpuc->lbr_stack.nr = i;
