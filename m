Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1154857070F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiGKPZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiGKPZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:25:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D84D28731
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657553138; x=1689089138;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PJY0gCVqbX61mhga+/o/dwiJnok4+p1Q97+JBuljLlI=;
  b=XCHLK7GkI5TFmTWEZgNVOGpBg4n7tvsou3V2XEHFq8UsKdIRReE1QXuZ
   cdi/MrRNfkVfoqwTCkNofTgcjzfhqHjrZAk6ZZQhBhXEDjf95vs/m08Z7
   LSTIbTKYqZgCYSI/tSFbRq/sdsXIiubs0dSs/rRge2ySTeKMSlRN6vE64
   GV0jP5dche3hQHVXxGMbQyDNX33dtGTizMrqPp7f8PgV2e6bQD5wz9TPX
   /Rpaz+Jv41EQLda0dUxmvLK0fAFiKLwZ4AlvGzyatVJ44YqWDMuUbjFvL
   YouhjzqVp71zmlaXMuzzPpPLP/8shLlM9rCoCrPGVDpWyCXvS0ZagHgx/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="284715463"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="284715463"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 08:25:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="569803689"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 11 Jul 2022 08:25:37 -0700
Received: from [10.252.212.229] (kliang2-mobl1.ccr.corp.intel.com [10.252.212.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 12E6E580BDA;
        Mon, 11 Jul 2022 08:25:35 -0700 (PDT)
Message-ID: <4b15d3d1-389b-fee4-d1b9-8732859e3696@linux.intel.com>
Date:   Mon, 11 Jul 2022 11:25:34 -0400
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
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <e71fa75-a718-ffb-c3f3-40cccf77ba9b@maine.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-07-08 12:13 p.m., Vince Weaver wrote:
> On Wed, 6 Jul 2022, Vince Weaver wrote:
> 
>> Let the fuzzer running a long time on 5.19-rc1 and after a few weeks it 
>> triggered this weird trace.  It is repeatable (although I haven't 
>> narrowed down exactly what's causing it).
>>
>> It's odd in that it just dumps a <TASK>, it doesn't provide any info on 
>> what the actual trigger is.
>>
>> This is on a Haswell machine.
> 
> I bumped up to current git and managed to trigger this again, this time 
> it actually managed to print the error message.
> 
> [ 7763.384369] unchecked MSR access error: WRMSR to 0x689 (tried to write 0x1fffffff8101349e) at rIP: 0xffffffff810704a4 (native_write_msr+0x4/0x20)

The 0x689 is a valid LBR register, which is MSR_LASTBRANCH_9_FROM_IP.
The issue should be caused by the known TSX bug, which is mentioned in
the commit 9fc9ddd61e0 ("perf/x86/intel: Fix MSR_LAST_BRANCH_FROM_x bug
when no TSX"). It looks like the TSX support has been deactivated,
however the quirk in the commit isn't applied for some reason.


To apply the quirk, perf relies on the boot CPU's flag and LBR format.

static inline bool lbr_from_signext_quirk_needed(void)
{
	bool tsx_support = boot_cpu_has(X86_FEATURE_HLE) ||
			   boot_cpu_has(X86_FEATURE_RTM);

	return !tsx_support && x86_pmu.lbr_has_tsx;
}

Could you please share the value of the PERF_CAPABILITIES MSR	0x00000345
of the machine?
I'd like to double check whether the LBR fromat is correct. 0x5 is expected.


If the LBR format is correct, maybe the boot CPU's flag is not cleared
when the TSX support is deactivated.
I noticed that Pawan recently had several TSX patches merged which may
impact the flags.
400331f8ffa3 ("x86/tsx: Disable TSX development mode at boot")
258f3b8c3210 ("x86/tsx: Use MSR_TSX_CTRL to clear CPUID bits")
If you only observe the issue with the latest kernel, you may want to
revert the above two patches and see if it helps.


Thanks,
Kan

> [ 7763.397420] Call Trace:
> [ 7763.399881]  <TASK>
> [ 7763.401994]  intel_pmu_lbr_restore+0x9a/0x1f0
> [ 7763.406363]  intel_pmu_lbr_sched_task+0x91/0x1c0
> [ 7763.410992]  __perf_event_task_sched_in+0x1cd/0x240
> [ 7763.415879]  ? __perf_event_task_sched_out+0x75/0x5c0
> [ 7763.420939]  finish_task_switch.isra.0+0x15b/0x2a0
> [ 7763.425740]  ? __switch_to+0x112/0x430
> [ 7763.429503]  __schedule+0x2cf/0x10d0
> [ 7763.433088]  ? send_signal_locked+0xc8/0x130
> [ 7763.437364]  schedule+0x4e/0xb0
> [ 7763.440518]  do_wait+0x15b/0x2f0
> [ 7763.443757]  kernel_wait4+0xa6/0x140
> [ 7763.447337]  ? thread_group_exited+0x60/0x60
> [ 7763.451608]  do_syscall_64+0x3b/0xc0
> [ 7763.455199]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [ 7763.460259] RIP: 0033:0x7f9063feba26
> [ 7763.463838] Code: ff e9 0e 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 90 48 83 ec 28 89 54 24 14 48 89 74 24
> [ 7763.482587] RSP: 002b:00007ffca3875c08 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
> [ 7763.490161] RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007f9063feba26
> [ 7763.497303] RDX: 0000000000000000 RSI: 00007ffca3875c1c RDI: 0000000000002214
> [ 7763.504441] RBP: 00007ffca3875c20 R08: 00007f90640f321c R09: 00007f90640f3240
> [ 7763.511577] R10: 0000000000000000 R11: 0000000000000246 R12: 000055d6ce93c4f0
> [ 7763.518718] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [ 7763.525850]  </TASK>
> 
