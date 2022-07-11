Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083EC570D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiGKWRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiGKWRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:17:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEA03C17C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657577820; x=1689113820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a2VEMBrBwf95XawaFo8Ry7AYAN1Bm+G4i5Qf4XWud/c=;
  b=Pj6kW4CKYTj43HsEcijOyNK8t9hG/b5s3sZJ4bSaolLcxs9EiZaG09cP
   X5X0R95MTscC7VPdWQqLwIG8c+WApBiZF0nCkff58Vkr6ZzrdPEEXIV8q
   RaSkMrfvItukSW81YtKYNhgX9pyzVCSxSU9oVW+1dnU6HuHHsPhurAaRN
   +YmVVguiJ+mJZ2GFpz2/4/1DkOZr8wqrfupF/XKEu1w8hTPTI0T5XasLb
   hUGsOG0xmvdF8hcJK/vgIbHIii/kIxgmFo3mKIsgPw2k6beLSBgXdDuMX
   MojZDhOgQo4hYlO5iqRAU+ivkGFc/RmX75aq/NnDSxMpwny2YRJlG9+XG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="265192911"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="265192911"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 15:16:59 -0700
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="841158565"
Received: from guptapa-desk.jf.intel.com (HELO guptapa-desk) ([10.24.8.127])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 15:16:59 -0700
Date:   Mon, 11 Jul 2022 15:16:58 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Vince Weaver <vincent.weaver@maine.edu>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [perf] unchecked MSR access error: WRMSR to 0x689 in
 intel_pmu_lbr_restore
Message-ID: <20220711221658.4gpkizopmftpnav6@guptapa-desk>
References: <66961a7d-a6d8-2536-9ed3-68c2e7f4e03d@maine.edu>
 <e71fa75-a718-ffb-c3f3-40cccf77ba9b@maine.edu>
 <4b15d3d1-389b-fee4-d1b9-8732859e3696@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <4b15d3d1-389b-fee4-d1b9-8732859e3696@linux.intel.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 11:25:34AM -0400, Liang, Kan wrote:
>
>
>On 2022-07-08 12:13 p.m., Vince Weaver wrote:
>> On Wed, 6 Jul 2022, Vince Weaver wrote:
>>
>>> Let the fuzzer running a long time on 5.19-rc1 and after a few weeks it
>>> triggered this weird trace.  It is repeatable (although I haven't
>>> narrowed down exactly what's causing it).
>>>
>>> It's odd in that it just dumps a <TASK>, it doesn't provide any info on
>>> what the actual trigger is.
>>>
>>> This is on a Haswell machine.
>>
>> I bumped up to current git and managed to trigger this again, this time
>> it actually managed to print the error message.
>>
>> [ 7763.384369] unchecked MSR access error: WRMSR to 0x689 (tried to write 0x1fffffff8101349e) at rIP: 0xffffffff810704a4 (native_write_msr+0x4/0x20)
>
>The 0x689 is a valid LBR register, which is MSR_LASTBRANCH_9_FROM_IP.
>The issue should be caused by the known TSX bug, which is mentioned in
>the commit 9fc9ddd61e0 ("perf/x86/intel: Fix MSR_LAST_BRANCH_FROM_x bug
>when no TSX"). It looks like the TSX support has been deactivated,
>however the quirk in the commit isn't applied for some reason.
>
>
>To apply the quirk, perf relies on the boot CPU's flag and LBR format.
>
>static inline bool lbr_from_signext_quirk_needed(void)
>{
>	bool tsx_support = boot_cpu_has(X86_FEATURE_HLE) ||
>			   boot_cpu_has(X86_FEATURE_RTM);
>
>	return !tsx_support && x86_pmu.lbr_has_tsx;
>}
>
>Could you please share the value of the PERF_CAPABILITIES MSR	0x00000345
>of the machine?
>I'd like to double check whether the LBR fromat is correct. 0x5 is expected.
>
>
>If the LBR format is correct, maybe the boot CPU's flag is not cleared
>when the TSX support is deactivated.
>I noticed that Pawan recently had several TSX patches merged which may
>impact the flags.
>400331f8ffa3 ("x86/tsx: Disable TSX development mode at boot")
>258f3b8c3210 ("x86/tsx: Use MSR_TSX_CTRL to clear CPUID bits")
>If you only observe the issue with the latest kernel, you may want to
>revert the above two patches and see if it helps.

Output of below would be helpful:

# grep "rtm\|hle" /proc/cpuinfo

ARCH_CAP
# rdmsr 0x10a

TSX_CTRL
# rdmsr 0x122

MCU_OPT_CTRL
# rdmsr 0x123

TSX_FORCE_ABORT
# rdmsr 0x10f

Please note, some of these MSRs may not exist on your platform.

Thanks,
Pawan
