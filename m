Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6AA5553D7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 20:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376883AbiFVS5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 14:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235707AbiFVS5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:57:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6478167E9;
        Wed, 22 Jun 2022 11:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655924240; x=1687460240;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GfUjOXbnbljOCWDgJqhlMo6F4sjejR8sLGNLfJqUuMw=;
  b=Ic4I7KQ7uCh/cnUu7dQJNLJ/M0CGmP0n5uIaQB3egn2FaxL44w23QTKs
   ALpmjdKHrdevzFyzCnWqf8g7DjTYQ5E6s0POAFlkSVoqPU0vM3iSXfbGW
   cBCbTS78mu13FEhIv+8xR57FD2OSob/Dqh1qNsOIZMSSJybtTeIt981nF
   k00r1oVPqHsNE5N5p7Cz+DYVAdNYTGI7oYBT1er2jNodaVJz+lDDWxpDu
   0lbhBTI5aNDKI80bADTcc8wgRK7TUna0rDA8PDB+0+krEdOwqzF/t1Ti/
   PlAN98Av25tIMb++f63fK0pNJqzefBCufIzfTjua4kE/XpeMvet7E73m/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="281245147"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="281245147"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 11:57:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="563141901"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2022 11:57:20 -0700
Received: from [10.252.208.245] (kliang2-MOBL.ccr.corp.intel.com [10.252.208.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id F2A35580970;
        Wed, 22 Jun 2022 11:57:16 -0700 (PDT)
Message-ID: <4a635493-4e06-af5a-d4d7-e9e669051b08@linux.intel.com>
Date:   Wed, 22 Jun 2022 14:57:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] perf/x86/intel/lbr: use setup_clear_cpu_cap instead
 of clear_cpu_cap
Content-Language: en-US
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
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <84c84de9-f5f1-1f8c-fa7c-6a416ea3373e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/22/2022 10:58 AM, Dave Hansen wrote:
> On 6/22/22 07:48, Maxim Levitsky wrote:
>> clear_cpu_cap(&boot_cpu_data) is very similar to setup_clear_cpu_cap
>> except that the latter also sets a bit in 'cpu_caps_cleared' which
>> later clears the same cap in secondary cpus, which is likely
>> what is meant here.
>>
>> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> 
> Seems like a:
> 
> Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
> 
> would be in order.
> 
> Kan, does this change look right to you?

For the current implementation, the Arch LBR feature should be either 
supported by all the CPUs or disabled on all the CPUs. It cannot be only 
enabled for partial CPUs, even in a hybrid platform.
So the current code only check the boot CPU via static_cpu_has().

Ideally, Yes, I think it may be better to clear the bit for all CPUs, 
which makes the capability consistent among CPUs.

Thanks,
Kan
> 
>>   arch/x86/events/intel/lbr.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> index 13179f31fe10fa..b08715172309a7 100644
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
>> @@ -1860,7 +1860,7 @@ void __init intel_pmu_arch_lbr_init(void)
>>   	return;
>>   
>>   clear_arch_lbr:
>> -	clear_cpu_cap(&boot_cpu_data, X86_FEATURE_ARCH_LBR);
>> +	setup_clear_cpu_cap(X86_FEATURE_ARCH_LBR);
>>   }
>>   
>>   /**
> 
