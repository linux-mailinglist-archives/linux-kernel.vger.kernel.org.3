Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D65555495
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 21:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357916AbiFVTe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 15:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiFVTdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 15:33:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0CF41309;
        Wed, 22 Jun 2022 12:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655926367; x=1687462367;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=juE7ac/fmDWeT7ovvAUv/0Fw/mPlnJ6xUxEfH3nyGFM=;
  b=mGTeB4LzdouX0CeNjAvyvofFbas+zOXs5aPxz5HQMYybWemgE3Xufv4S
   s+1ph0hylh3M9oT1hH7MALnol9vSNEkDhBAxt4dHuvsOQgeGZaZNQDL3w
   fd7NN1/alk2s89r6J8wquG9+MfoBYTGZFhQcpXoAZaunK5xEyGreHw61a
   HJU3asKp3y53y6yuEi+E1UaO3kUY4YJtLdY8mCNrCk+TKkV0zHsEinntd
   o+2zSuS0/KaUsHMh9GE/aEHJ3sEY3YRbcama8Pt+AH3ejNjbXR5rfbbti
   xNd37+GhNKbjxM99HKMCcqd3sYwR5Qun4uszRi0402PCDC/BG/mOr9iIU
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="366846718"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="366846718"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 12:32:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="677714581"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2022 12:32:46 -0700
Received: from [10.252.208.245] (kliang2-MOBL.ccr.corp.intel.com [10.252.208.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 995C7580970;
        Wed, 22 Jun 2022 12:32:43 -0700 (PDT)
Message-ID: <f519dabb-2cce-711f-3fea-ccb756a0b73c@linux.intel.com>
Date:   Wed, 22 Jun 2022 15:32:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] perf/x86/intel/lbr: use setup_clear_cpu_cap instead
 of clear_cpu_cap
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Jane Malalane <jane.malalane@citrix.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20220622144820.751402-1-mlevitsk@redhat.com>
 <20220622144820.751402-2-mlevitsk@redhat.com>
 <84c84de9-f5f1-1f8c-fa7c-6a416ea3373e@intel.com>
 <4a635493-4e06-af5a-d4d7-e9e669051b08@linux.intel.com>
In-Reply-To: <4a635493-4e06-af5a-d4d7-e9e669051b08@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/22/2022 2:57 PM, Liang, Kan wrote:
> 
> 
> On 6/22/2022 10:58 AM, Dave Hansen wrote:
>> On 6/22/22 07:48, Maxim Levitsky wrote:
>>> clear_cpu_cap(&boot_cpu_data) is very similar to setup_clear_cpu_cap
>>> except that the latter also sets a bit in 'cpu_caps_cleared' which
>>> later clears the same cap in secondary cpus, which is likely
>>> what is meant here.
>>>
>>> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>>
>> Seems like a:
>>
>> Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
>>
>> would be in order.
>>
>> Kan, does this change look right to you?
> 
> For the current implementation, the Arch LBR feature should be either 
> supported by all the CPUs or disabled on all the CPUs. It cannot be only 
> enabled for partial CPUs, even in a hybrid platform.
> So the current code only check the boot CPU via static_cpu_has().
> 
> Ideally, Yes, I think it may be better to clear the bit for all CPUs, 
> which makes the capability consistent among CPUs.
>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan


> Thanks,
> Kan
>>
>>>   arch/x86/events/intel/lbr.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>>> index 13179f31fe10fa..b08715172309a7 100644
>>> --- a/arch/x86/events/intel/lbr.c
>>> +++ b/arch/x86/events/intel/lbr.c
>>> @@ -1860,7 +1860,7 @@ void __init intel_pmu_arch_lbr_init(void)
>>>       return;
>>>   clear_arch_lbr:
>>> -    clear_cpu_cap(&boot_cpu_data, X86_FEATURE_ARCH_LBR);
>>> +    setup_clear_cpu_cap(X86_FEATURE_ARCH_LBR);
>>>   }
>>>   /**
>>
