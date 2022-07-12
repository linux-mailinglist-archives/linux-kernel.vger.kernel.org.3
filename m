Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0A65729AA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 01:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiGLXIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 19:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGLXIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 19:08:40 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BA0645A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 16:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657667318; x=1689203318;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PVqTNIAp+lc24rMsgXbL56W/LS11GiDcSpu24HAnK+M=;
  b=C+kNR9JCZJDdXMI6gKe3lRYtMIhLwHgqs2xCUavS24urtOzHMvlb+hB2
   o3b5/BXG+HZGRQ8LKJmmd6LxzMJO9s9MkSrb1+wFw/yYN2gXEvJrRbCWn
   hTFFcQyHqzlhmAKkSySiiZrpmVfMsy24zk//ENTxct97scaszyTv4Jb0N
   dl/GaPA8vkHKCKwYvLi8zgRdb7U8LdOb/m5vtdpSiYTHDWZOFnXlc6vXX
   cF9Ns6gahQi/A42g3gVUhgGFZcFZ+XJWSUC0znZnYoOHhYHzgCuj+JS//
   hygQEmcs2uQExIfad1X6pVb0za0Rs2pEo5+CGBOrTbKqQ4CTbLhdTZQVp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="283818255"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="283818255"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 16:08:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="545611921"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 12 Jul 2022 16:08:33 -0700
Received: from [10.252.208.254] (kliang2-mobl1.ccr.corp.intel.com [10.252.208.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 93C315805BD;
        Tue, 12 Jul 2022 16:08:25 -0700 (PDT)
Message-ID: <0e3b3e6e-53b9-b426-71cd-911d3ecbfc24@linux.intel.com>
Date:   Tue, 12 Jul 2022 19:08:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: [perf] unchecked MSR access error: WRMSR to 0x689 in
 intel_pmu_lbr_restore
Content-Language: en-US
To:     Vince Weaver <vincent.weaver@maine.edu>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
References: <66961a7d-a6d8-2536-9ed3-68c2e7f4e03d@maine.edu>
 <e71fa75-a718-ffb-c3f3-40cccf77ba9b@maine.edu>
 <4b15d3d1-389b-fee4-d1b9-8732859e3696@linux.intel.com>
 <20220711221658.4gpkizopmftpnav6@guptapa-desk>
 <32ccdda1-63bf-746e-48fb-935fa58285b1@maine.edu>
 <20220712204830.kvblayj37s3udt4b@guptapa-desk>
 <487465e6-b034-f08-907-de37a0a173b5@maine.edu>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <487465e6-b034-f08-907-de37a0a173b5@maine.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-07-12 5:26 p.m., Vince Weaver wrote:
> On Tue, 12 Jul 2022, Pawan Gupta wrote:
> 
>> On Tue, Jul 12, 2022 at 03:39:56PM -0400, Vince Weaver wrote:
>> It appears this CPU does not support TSX feature (or disabling TSX). If
>> the bug is easy to reproduce, bisecting can help.
> 
> I thought TSX was disabled via firmware update for all Haswell machines?
> 
> In any case, the fuzzer is triggering the
> 	unchecked MSR access error: WRMSR to 0x689
> in intel_pmu_lbr_restore.  So either this is a false error and should be 
> disabled, or else it's a real issue and should be fixed.
> 

Could you please double check if the quirk can fix the issue on your
machine?

#Try write the exact same value from the error log to 0x689. The write
should fail.
wrmsr -p 0 0x689 0x1fffffff8101349e

#The quirk copy bits 59:60 to bits 61:62. The below write should succeed.
wrmsr -p 0 0x689 0x7fffffff8101349e

> Unfortunately the fuzzer can take up to a few days to trigger the message 
> (it's not easily repeatable) so doing a kernel bisect would take a very 
> long time.
> 

The lbr_from_signext_quirk_needed() is only invoked at boot time. Maybe
we can dump some logs to understand which variable is not expected.

Could you please apply the below patch, reboot to the patched kernel and
share the dmesg log?

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 13179f31fe10..50435ab627ad 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -300,6 +300,9 @@ static inline bool lbr_from_signext_quirk_needed(void)
 	bool tsx_support = boot_cpu_has(X86_FEATURE_HLE) ||
 			   boot_cpu_has(X86_FEATURE_RTM);

+	pr_info("%s %s. LBR has tsx %d\n", boot_cpu_has(X86_FEATURE_HLE) ?
"HLE" : "NO HLE",
+			boot_cpu_has(X86_FEATURE_RTM) ? "RTM" : "NO RTM",
+			x86_pmu.lbr_has_tsx);
 	return !tsx_support && x86_pmu.lbr_has_tsx;
 }


Thanks,
Kan

