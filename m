Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E7E4D3E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 01:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiCJA0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 19:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiCJA0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:26:06 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE6EFABCB;
        Wed,  9 Mar 2022 16:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646871907; x=1678407907;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=iSJwiUQsUrno2NOODhlHmBjcWwneKWRlPjPG9LJo6G8=;
  b=Yb08AHn0FUho51Mhr6QmLkO4R8J/F4sUj8/ziw5c+NBDlPCFR3dxVuna
   yNSJKET90lJOm6pX2jnfXc/8hjDWB2fdvGTr6BGes1EHDxG/gz2Y/TNZ3
   v8FsD9ngkxqBCrpmEKkYjIMjMyvqmT9pDkBN2665SGz+Om7l1idOs1tet
   puBHJ/bvN54mYXo/QbL2sAbZVZ1lHzpJJqN1wj539lhqqHsNzSgsftN0d
   dS2FBEOMkHcVdfnJTKDD9qfCp23doJh5YHaXAcQp+ZWu95L7YSOw8whvf
   09L8QNZFqYE8zfkLtpZp4GRAK1/S1RqiwU3HZ1M7ndnqIvB2bG4yhjARk
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="253952627"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="253952627"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 16:25:07 -0800
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="642352667"
Received: from sli6-mobl.amr.corp.intel.com (HELO [10.209.104.236]) ([10.209.104.236])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 16:25:06 -0800
Message-ID: <4331a0af-2300-ffaa-3e5c-ed15499c213b@intel.com>
Date:   Wed, 9 Mar 2022 16:24:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, dave.hansen@linux.intel.com,
        peterz@infradead.org, bp@alien8.de, rafael@kernel.org,
        ravi.v.shankar@intel.com
References: <20220309223431.26560-1-chang.seok.bae@intel.com>
 <20220309223431.26560-2-chang.seok.bae@intel.com>
 <bde83c5f-ffe9-d548-de08-de3e14738bf0@intel.com>
 <c6a9632e-cdcb-cf05-183e-a124e9cec0e2@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2 1/2] x86/fpu: Add a helper to prepare AMX state for
 low-power CPU idle
In-Reply-To: <c6a9632e-cdcb-cf05-183e-a124e9cec0e2@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/22 15:12, Chang S. Bae wrote:
> On 3/9/2022 2:46 PM, Dave Hansen wrote:
>> On 3/9/22 14:34, Chang S. Bae wrote:
>>> +/*
>>> + * Initialize register state that may prevent from entering
>>> low-power idle.
>>> + * This function will be invoked from the cpuidle driver only when
>>> needed.
>>> + */
>>> +void fpu_idle_fpregs(void)
>>> +{
>>> +    if (!fpu_state_size_dynamic())
>>> +        return;
>>
>> Is this check just an optimization?  
> 
> No. 0day reported the splat [3] with the earlier code in v1 [1]:
> 
> if (fpu_state_size_dynamic() && (xfeatures_in_use() &
> XFEATURE_MASK_XTILE)) { ... }
> 
> It looks like GCC-9 reordered to hit XGETBV without checking
> fpu_state_size_dynamic(). So this line was separated to avoid that.

I assume that splat is because 0day found a CPU which doesn't support
XGETBV1.  Since fpu_state_size_dynamic() only ever returns true on
XGETBV1 systems so it works as a proxy for checking XGETBV1 support.

Right?

If so, then fpu_state_size_dynamic() is a *bit* of an oblique way to
check for XGETBV1 support.

Why don't we do a good old:

	cpu_feature_enabled(X86_FEATURE_XGETBV1)

check?

Also, did we get the asm constraints wrong on xgetbv()?  Surely we
shouldn't be allowing the compiler to reorder it.  Do we need a "memory"
constraint?
