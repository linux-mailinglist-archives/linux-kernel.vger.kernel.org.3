Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0358570EA3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiGLAL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiGLALY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:11:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C255A422C9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657584683; x=1689120683;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RqE/10F8cM5p6ujyAuxaXmD/9itGhRl3pE9JzAmilx0=;
  b=S2c44iAHh/bI2G5da0SP9dFx7oNl4Gd8pYpdxNlNAha7DrD5wyeUFZ1e
   bF8otqD0b/SuYRookvdIjYDO2ACysTaDvHfwVsll6GjFgnvyuw2Z7pkUk
   o0Wbcehg3PQWj1W+peOAKtN9uf15kD5m0QRaOj1M1XwKUVrrPb6RnuKnb
   FgiKW+XaLbhqckmIAb8RtIUP9yIetypJBy+AF8RYgbcafj0QfHrYJRmZ/
   +UDezI1aO3dyXEoiGfkS6NFx2g4Gyhglfn7qVrxYsSezwxv67vuMHfAxa
   Z+n+TuOsoxB5V+5Tif+6Nr+DVlQ5H+NwVpiOIfuPfQ9lGJDzMsmhUsjvr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="264589457"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="264589457"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:11:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="841187818"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 11 Jul 2022 17:11:23 -0700
Received: from [10.252.212.229] (kliang2-mobl1.ccr.corp.intel.com [10.252.212.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 712105805BD;
        Mon, 11 Jul 2022 17:11:21 -0700 (PDT)
Message-ID: <96d7a36e-c6d1-f45f-6d5a-3eb7c56ddc3d@linux.intel.com>
Date:   Mon, 11 Jul 2022 20:11:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: [perf] unchecked MSR access error: WRMSR to 0x689 in
 intel_pmu_lbr_restore
Content-Language: en-US
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        pawan.kumar.gupta@linux.intel.com
References: <66961a7d-a6d8-2536-9ed3-68c2e7f4e03d@maine.edu>
 <e71fa75-a718-ffb-c3f3-40cccf77ba9b@maine.edu>
 <4b15d3d1-389b-fee4-d1b9-8732859e3696@linux.intel.com>
 <f22dd6fb-48b7-99cf-3d7a-348e5792c8@maine.edu>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <f22dd6fb-48b7-99cf-3d7a-348e5792c8@maine.edu>
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



On 2022-07-11 5:13 p.m., Vince Weaver wrote:
> On Mon, 11 Jul 2022, Liang, Kan wrote:
> 
>>
>>
>> On 2022-07-08 12:13 p.m., Vince Weaver wrote:
>>> [ 7763.384369] unchecked MSR access error: WRMSR to 0x689 (tried to write 0x1fffffff8101349e) at rIP: 0xffffffff810704a4 (native_write_msr+0x4/0x20)
>>
>> The 0x689 is a valid LBR register, which is MSR_LASTBRANCH_9_FROM_IP.
>> The issue should be caused by the known TSX bug, which is mentioned in
>> the commit 9fc9ddd61e0 ("perf/x86/intel: Fix MSR_LAST_BRANCH_FROM_x bug
>> when no TSX"). It looks like the TSX support has been deactivated,
>> however the quirk in the commit isn't applied for some reason.
>>
>>
>> To apply the quirk, perf relies on the boot CPU's flag and LBR format.
>>
>> static inline bool lbr_from_signext_quirk_needed(void)
>> {
>> 	bool tsx_support = boot_cpu_has(X86_FEATURE_HLE) ||
>> 			   boot_cpu_has(X86_FEATURE_RTM);
>>
>> 	return !tsx_support && x86_pmu.lbr_has_tsx;
>> }
>>
>> Could you please share the value of the PERF_CAPABILITIES MSR	0x00000345
>> of the machine?
>> I'd like to double check whether the LBR fromat is correct. 0x5 is expected.
> 
> How would I do that?  Just something like:
> # rdmsr 0x00000345
> 32c4
>

Yes. It indicates that the LBR format is 4. That's expected for HSW.
(I made a mistake in the previous email. Skylake has format 5, not HSW.)
For the LBR format 4, the x86_pmu.lbr_has_tsx must be 1.

So it looks like an issue of the CPU flag.

Could you please collect the TSX information which Pawan mentioned in
the other thread?

Thanks,
Kan

> or is it more involved than that?
> 
> Vince Weaver
> vincent.weaver@maine.edu
