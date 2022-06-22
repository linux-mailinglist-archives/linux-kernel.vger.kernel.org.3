Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80E3555239
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377343AbiFVRTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376717AbiFVRS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:18:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257C52180C;
        Wed, 22 Jun 2022 10:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655918337; x=1687454337;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CW1y5IDbjPjtCIKvflTqoe0LEPdTAbEMuAa5hhCumaw=;
  b=WyYCVfw2z2IcQXpqC+LHSlNhgDD+xjyB+EhQKdZX5k6C3nOJrcf3W+ta
   xXEZqh0xhuPeQf4EE6StUkqTdBA2cVASkw30lq8FXViI6cibGkYXzj0/C
   S5BnIrOtxlvNEF473VgwnHzciV1YZz5NfgWlJ48ijgqHmLGmd5cYQ2kUC
   q8k837YPA/Wec6Yv0pmM207TNryFfAvHHormR1byBVbN4hU8BgqsEFQjo
   Jw+YFLQu9SbyHwssn9aAz49UJZvm47VpJkdp8Ub8nvy7enHLX8ukC6zJg
   swwGZNYLbOEr3FR76/qvKecjkv5FnQ7a12cz578UjmLQCqrlsl+oyujq8
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="278029172"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="278029172"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:18:57 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="677654980"
Received: from bshakya-mobl.amr.corp.intel.com (HELO [10.212.188.76]) ([10.212.188.76])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:18:55 -0700
Message-ID: <485dd428-9aaa-9571-49a5-9d17c6e72e00@intel.com>
Date:   Wed, 22 Jun 2022 10:18:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 4/4] x86/cpuid: check for dependencies violations in CPUID
 and attempt to fix them
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>, linux-kernel@vger.kernel.org
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
 <20220622144820.751402-5-mlevitsk@redhat.com>
 <c271cbf5-dfb5-c3dd-002b-9a358c90e984@intel.com>
 <70deac4c885b2bf41daecaed054f80f867ed19de.camel@redhat.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <70deac4c885b2bf41daecaed054f80f867ed19de.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/22 10:09, Maxim Levitsky wrote:
> On Wed, 2022-06-22 at 08:32 -0700, Dave Hansen wrote:
>> On 6/22/22 07:48, Maxim Levitsky wrote:
>>> Due to configuration bugs, sometimes a CPU feature is disabled in CPUID,
>>> but not features that depend on it.
>>>
>>> While the above is not supported, the kernel should try to not crash,
>>> and clearing the dependent cpu caps is the best way to do it.
>>
>> That's a rather paltry changelog.
>>
>> If I remember correctly, there's a crystal clear problem:
>>
>> 	If a CPU enumerates support for AVX2 but AVX via CPUID, the
>> 	kernel crashes.
>>
>> There's also a follow-on problem.  The kernel has all the data it needs
>> to fix this, but just doesn't consult it:
>>
>> 	To make matters worse, the kernel _knows_ that this is an ill-
>> 	advised situation: The kernel prevents itself from clearing the
>> 	software representation of the AVX CPUID bit without also
>> 	clearing AVX2.
>>
>> 	But, the kernel only consults this knowledge when it is clearing
>> 	cpu_cap bits.  It does not consult this information when it is
>> 	populating those cpu_cap bits.
> 
> Yes, I agree. I'll update the changelog with something more in depth.
> 
>>
>>> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
>>> index 4cc79971d2d847..c83a8f447d6aed 100644
>>> --- a/arch/x86/kernel/cpu/common.c
>>> +++ b/arch/x86/kernel/cpu/common.c
>>> @@ -1469,7 +1469,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
>>>  			this_cpu->c_early_init(c);
>>>  
>>>  		c->cpu_index = 0;
>>> -		filter_cpuid_features(c, false);
>>> +		filter_cpuid_features(c, true);
>>>  
>>>  		if (this_cpu->c_bsp_init)
>>>  			this_cpu->c_bsp_init(c);
>>> @@ -1757,7 +1757,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
>>>  	 */
>>>  
>>>  	/* Filter out anything that depends on CPUID levels we don't have */
>>> -	filter_cpuid_features(c, true);
>>> +	filter_cpuid_features(c, false);
>>>  
>>>  	/* If the model name is still unset, do table lookup. */
>>>  	if (!c->x86_model_id[0]) {
>>
>> While we're at it, could we please rid ourselves of this unreadable
>> mystery true/false gunk?
> 
> It is present if I understand the code correctly to avoid printing a warning twice.
> It used to be 'warn' parameter, and I changed it to 'early' parameter, 
> inverting its boolean value, because I have seen that warning is not printed at all, 
> and I assumed that it is because the first early call already clears the cpuid cap
> and the second call doesn't get the warning.

If the goal is truly to suppress the warning once per dependency, it
would be trivial to do:

	struct cpuid_dep {
	        unsigned int    feature;
        	unsigned int    depends;
+		bool warned;
	};

Then:

	...
	clear_feature(c, d->feature);
+	if (!d->warned)
+		pr_warn(...);
+	d->warned = 1;

You could even have two bits if you feel that we need separate warnings
for the hardware (true CPUID) and software (setup_clear_cpu_cap()) checks.

>>>  		pr_warn("CPU: CPU feature " X86_CAP_FMT " disabled, no CPUID level 0x%x\n",
>>>  			x86_cap_flag(df->feature), df->level);
>>>  	}
>>> +
>>> +	for (d = cpuid_deps; d->feature; d++) {
>>> +
>>> +		if (!test_feature(c, d->feature) || test_feature(c, d->depends))
>>> +			continue;
>>> +
>>> +		clear_feature(c, d->feature);
>>> +
>>> +		pr_warn("CPU: CPU feature " X86_CAP_FMT " disabled, because it depends on "
>>> +			X86_CAP_FMT " which is not supported in CPUID\n",
>>> +			x86_cap_flag(d->feature), x86_cap_flag(d->depends));
>>> +	}
>>>  }
>>
>> The do_clear_cpu_cap() does this with a loop, presumably because a later
>> (higher index in the array) feature in cpuid_deps[] could theoretically
>> clear an earlier (lower index) feature.
> 
> Sorry this is my silly mistake. I intended to call clear_cpu_cap here,
> which will if needed disable all the depedencies, so a loop doesn't
> seem to be needed here. 
> 
> It's not very efficient but this is only done once per vCPU so shouldn't matter.

Right, and it only loops if it is actually clearing features, which is
arguably the result of a broken CPU or hypervisor, which is rare too.
It's not inefficient in any case that matters.
