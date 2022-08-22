Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE4159C1FC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbiHVO7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbiHVO7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:59:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6704713E14
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661180356; x=1692716356;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aoQoGMYrTip2i9Aalx6kKBR0wCSpOUBTJ/aO5x7Lsjo=;
  b=jfo/qAiIrPpM94JVzMrs1MK6v47tZtnXGORiAxjp4TDVS3BhFr+bQM+y
   NESWOGZonMG0AsWErFW93y/M+CyaqJGtDGfWRTAL8UTkNoB7B7NWEDIW4
   wBMQYpFOjLg8WoxKupVhtqDLQ1wTi3pNO3L4m236JCr37ZXdjDogL722y
   LAo1/82GUs+9cCgdzHvAaxrvdti5jH0z7KlK6r1FafpC7odNLRDV2Wgtb
   m7OIiR7Lc/y/vbF23EvtfM+x4LunucMKLXXvLsoM28aAhbOo0Gt61+yI8
   h2ll2XTdFD/o4qOUAbVdDGBj5LIL1VnFw042Biw3YpE8TSFepuv1DU396
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="280404817"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="280404817"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 07:59:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="585551441"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 22 Aug 2022 07:59:15 -0700
Received: from [10.252.212.31] (kliang2-mobl1.ccr.corp.intel.com [10.252.212.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8F9F55806C8;
        Mon, 22 Aug 2022 07:59:14 -0700 (PDT)
Message-ID: <afb376c7-7f91-2b1c-9bef-ff4d49f066ed@linux.intel.com>
Date:   Mon, 22 Aug 2022 10:59:13 -0400
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
        Andrew Cooper <Andrew.Cooper3@citrix.com>
References: <20220818181530.2355034-1-kan.liang@linux.intel.com>
 <Yv+ggf6PRjL8Eio1@worktop.programming.kicks-ass.net>
 <80eea4f7-bb1e-ebb9-37db-9317b8d9c28f@linux.intel.com>
 <YwOVJO05Ge8V9y5i@worktop.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <YwOVJO05Ge8V9y5i@worktop.programming.kicks-ass.net>
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



On 2022-08-22 10:39 a.m., Peter Zijlstra wrote:
> On Mon, Aug 22, 2022 at 09:28:31AM -0400, Liang, Kan wrote:
>>
>>
>> On 2022-08-19 10:38 a.m., Peter Zijlstra wrote:
>>> On Thu, Aug 18, 2022 at 11:15:30AM -0700, kan.liang@linux.intel.com wrote:
>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>
>>>> For some Alder Lake N machine, the below unchecked MSR access error may be
>>>> triggered.
>>>>
>>>> [ 0.088017] rcu: Hierarchical SRCU implementation.
>>>> [ 0.088017] unchecked MSR access error: WRMSR to 0x38f (tried to write
>>>> 0x0001000f0000003f) at rIP: 0xffffffffb5684de8 (native_write_msr+0x8/0x30)
>>>> [ 0.088017] Call Trace:
>>>> [ 0.088017] <TASK>
>>>> [ 0.088017] __intel_pmu_enable_all.constprop.46+0x4a/0xa0
>>>
>>> FWIW, I seem to get the same error when booting KVM on my ADL. I'm
>>> fairly sure the whole CPUID vs vCPU thing is a trainwreck.
>>
>> We will enhance the CPUID to address the issues. Hopefully, we can have
>> them supported in the next generation.
>>
> 
> How about this?
> 
> ---
> [    0.170231] Performance Events: Alderlake Hybrid events, full-width counters, Intel PMU driver.
> [    0.171420] core: hybrid PMU and virt are incompatible
> 
> 
>  arch/x86/events/intel/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 2db93498ff71..232e24324fd7 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4473,6 +4473,11 @@ static bool init_hybrid_pmu(int cpu)
>  	struct x86_hybrid_pmu *pmu = NULL;
>  	int i;
>  
> +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
> +		pr_warn_once("hybrid PMU and virt are incompatible\n");
> +		return false;
> +	}

I would expect that KVM exposes the enhanced CPUID to the guest. The
guest vCPU should knows its specific CPU type. The KVM should bind the
vCPU to the same type of CPUs.

Before KVM provides such support, I guess it may be OK to have the
warning. Maybe more specifically, only architecture events work.

Thanks,
Kan

> +
>  	if (!cpu_type && x86_pmu.get_hybrid_cpu_type)
>  		cpu_type = x86_pmu.get_hybrid_cpu_type();
>  
