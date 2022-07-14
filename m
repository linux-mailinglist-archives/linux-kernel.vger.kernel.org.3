Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662ED57543F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 19:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbiGNRu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 13:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiGNRuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 13:50:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCA848CAA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 10:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657821023; x=1689357023;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oDi1KqjYyowFSBZmJ2CkUXZ/qCHaUZANvNOvgg6mWT0=;
  b=hAqp4t582qQCQi9uS1326kW0d7eC3HMNkdQ994WZzSzn22Twgg56V7p6
   1uwn8w+058Ko3K4tSnpVWkNctaQ3NARTsXxM+glfOoNWFBj44V4PpfsZw
   qfnP2Qsa8lTu1BkMe1w/cw47oK7lwQ+CrZZ6bOmxAMyg7ztxBEaQlbWit
   rRYpIE9fhsI0G6W+HWTlz4NPSiu7dD4ZgLFOtE9xzMTLztGZpRUZR6bB0
   1L5NA1wL5STCV7iJ5vHVNY714C4vuhHsHbY57QksotuQzWj9reN3PUVhF
   nQJCGxnaUn4kNj6sJgAG5R8zv2yR0m88eHvEd+xkooNuVBesHMPhOQ06C
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="349557104"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="349557104"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 10:50:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="623518369"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 14 Jul 2022 10:50:22 -0700
Received: from [10.213.182.116] (kliang2-mobl1.ccr.corp.intel.com [10.213.182.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 9210558092F;
        Thu, 14 Jul 2022 10:50:21 -0700 (PDT)
Message-ID: <0f4f4f0b-7be1-97a8-feac-a3814a434a86@linux.intel.com>
Date:   Thu, 14 Jul 2022 13:50:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [perf] unchecked MSR access error: WRMSR to 0x689 in
 intel_pmu_lbr_restore
Content-Language: en-US
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        linux-kernel@vger.kernel.org,
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
 <0e3b3e6e-53b9-b426-71cd-911d3ecbfc24@linux.intel.com>
 <15f85765-ff2f-5d32-5991-06ef225706f0@maine.edu>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <15f85765-ff2f-5d32-5991-06ef225706f0@maine.edu>
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



On 2022-07-14 12:12 p.m., Vince Weaver wrote:
> On Tue, 12 Jul 2022, Liang, Kan wrote:
> 
>>
>> Could you please apply the below patch, reboot to the patched kernel and
>> share the dmesg log?
> 
> here's the info with your patch applied:
> 
> [    0.000000] microcode: microcode updated early to revision 0x28, date = 2019-11-12
> ...
> [    1.460296] NO HLE NO RTM. LBR has tsx 0


Thanks.

The issue should be introduced by the commit 1ac7fd8159a8
("perf/x86/intel/lbr: Support LBR format V7").
The quirk is invoked before the intel_pmu_lbr_init(), which set the
x86_pmu.lbr_has_tsx.

I will send out a patch to fix it shortly.

Thanks,
Kan

> [    1.468217] Haswell events, 16-deep LBR, full-width counters, Intel PMU driver.
> [    1.472292] ... version:                3
> [    1.476275] ... bit width:              48
> [    1.480275] ... generic registers:      4
> [    1.484276] ... value mask:             0000ffffffffffff
> [    1.488277] ... max period:             00007fffffffffff
> [    1.492277] ... fixed-purpose events:   3
> [    1.496271] ... event mask:             000000070000000f
> 
> Vince
