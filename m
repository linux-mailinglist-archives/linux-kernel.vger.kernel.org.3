Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CC44E274E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347788AbiCUNQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347691AbiCUNQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:16:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66335286CC;
        Mon, 21 Mar 2022 06:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647868483; x=1679404483;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sjb101FGT2qlwEkPfKE4XTwqZyBSG+Zqst7PnnvuPPg=;
  b=TuZ6waQ2LlzSSDpH5/mq5+2n8mSu3poTTEcCzOHOY/yjoBHEXUnLrc5s
   Iqzu/k0MYbg6keZWp/iIymwwBcUEkhFZHFGd6kmJdE7+ya8Fz5AfW++wh
   6H0rjHisRHZl/JxthjZrhgKgKyJIVXZ+h92TUF7Av0xA8z14K8SyImuqz
   Bsumnj4jPQP04YQtFW/sdK4QeepXQZtpU1TIquxqYOhV9Rcxmnz80xEYo
   j/qY8y2Hsw30OvfOQUAr3//VyGqoCtLViwJkfvz6WiFsGX21zGwehNoly
   GVsjpilZpG47nzANlVGiNnFCX+8LPFduF+V99+BMfn6gR9p215XkCk8ey
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="238151931"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="238151931"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 06:09:18 -0700
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="559862757"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.56.148])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 06:09:14 -0700
Message-ID: <ffa56520-09b5-9c5d-7733-6767d2f8e350@intel.com>
Date:   Mon, 21 Mar 2022 15:09:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH] perf intel-pt: Synthesize cycle events
Content-Language: en-US
To:     "Steinar H. Gunderson" <sesse@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <YiuKAk7SaXP7B7Ee@google.com>
 <ba2c49da-22c5-06ea-e953-82211b953ca8@intel.com>
 <YjBnet2813sEGjZY@google.com>
 <c50bb87d-9fee-c4f9-a350-8729e503e43a@intel.com>
 <YjDUO6bbyfGw/u0C@google.com>
 <52903e58-e74c-5ea0-36b4-277ea3610af4@intel.com>
 <YjGdoGy4Z2UUG9S9@google.com>
 <ef780335-7dc6-3a23-54a8-b6fc9c8a2ed3@intel.com>
 <YjHfGrZovk3N/H0f@google.com>
 <371faf0d-f794-4a2e-0a1c-9d454d7c8b12@intel.com>
 <YjhUjotmo+kYvoNP@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <YjhUjotmo+kYvoNP@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.3.2022 12.33, Steinar H. Gunderson wrote:
> On Mon, Mar 21, 2022 at 11:16:56AM +0200, Adrian Hunter wrote:
>> I had another look at this and it seemed *mostly* OK for me.  One change
>> I would make is to subject the cycle period to the logic of the 'A' option
>> (approximate IPC).
>>
>> So what does the 'A' option do.
>>
>> By default, IPC is output only when the exact number of cycles and
>> instructions is known for the sample.  Decoding walks instructions
>> to reconstruct the control flow, so the exact number of instructions
>> is known, but the cycle count (CYC packet) is only produced with
>> another packet, so only indirect/async branches or the first
>> conditional branch of a TNT packet.
> 
> Ah, I hadn't thought of the fact that you only get the first branch per
> packet. It's a bit unfortunate for (exact) cycle counts, since I guess
> TNT packets can also easily cross functions?

Yes, it can cross calls and returns.  'returns' due to "Return Compression"
which can be switched off at record time with config term noretcomp, but
that may cause more overflows / trace data loss.

To get accurate times for a single function there is Intel PT
address filtering.

Otherwise LBRs can have cycle times.

> 
>> So the cycle sample function looks like this:
>>
>> static int intel_pt_synth_cycle_sample(struct intel_pt_queue *ptq)
>>
>> [...]
>>
>> With regard to the results you got with perf report, please try:
>>
>> 	perf report --itrace=y0nse --show-total-period --stdio
>>
>> and see if the percentages and cycle counts for rarely executed
>> functions make more sense.
> 
> I already run mostly with 0ns period, so I don't think that's it.
> I tried your new version, and it's very similar to your previous one;
> there are some small changes (largest is that one function goes from
> 2.5% to 2.2% or so), but the general gist of it is the same.
> I am increasingly leaning towards that my original version is wrong
> somehow, though.
> 
> By the way, I noticed that synthesized call stacks do not respect
> --inline; is that on purpose? The patch seems simple enough (just
> a call to add_inlines), although it exposes extreme slowness in libbfd
> when run over large binaries, which I'll have to look into.
> (10+ ms for each address-to-symbol lookup is rather expensive when you
> have 4M samples to churn through!)

No, not on purpose.
