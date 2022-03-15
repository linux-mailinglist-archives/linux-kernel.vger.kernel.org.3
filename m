Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE304DA3C9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 21:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351606AbiCOUNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 16:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236582AbiCOUNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:13:17 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749D65469E;
        Tue, 15 Mar 2022 13:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647375124; x=1678911124;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P0igHsy0agyY40a+InXlXjEkpY6Jf+LU2yEKK5b9mdI=;
  b=d3RgezXLuKRrI24gkmG4Hewc2RaGh7c0r0bEIW+CEzKk97kXxS+pGn5J
   vkyFl82K2rVTTQ/rFXbeqWRCeYskEE09UDpZKSHDh/NtL/cX7fsyF1xS4
   cE/vF/79BAEOb9sejsa3NxEvKlNnI/JUcfOPpSeBX2ya0IWl6dk3J2gLB
   bbURiBd1VI7rXjg2NgZ4PjFjujhvFSaFAMRvEWmxNB+kYsmYFm2CIdtT8
   ZSfGi+BxwU7bH6Ykm9aBfOyf59E/DhiS0xy1h62IZa0cAepYARnRkXWxH
   KSJmF7DPqaScEsmOh8jzyHu9rt23P0+OdsSy2VVRVpYv3SQkbLi3cK9Ov
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="342843389"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="342843389"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 13:12:04 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="557092735"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.111])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 13:12:00 -0700
Message-ID: <52903e58-e74c-5ea0-36b4-277ea3610af4@intel.com>
Date:   Tue, 15 Mar 2022 22:11:54 +0200
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
References: <20220310093844.982656-1-sesse@google.com>
 <586de5fc-858b-2693-1986-5c77e8c0e3d0@intel.com>
 <YiuKAk7SaXP7B7Ee@google.com>
 <ba2c49da-22c5-06ea-e953-82211b953ca8@intel.com>
 <YjBnet2813sEGjZY@google.com>
 <c50bb87d-9fee-c4f9-a350-8729e503e43a@intel.com>
 <YjDUO6bbyfGw/u0C@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <YjDUO6bbyfGw/u0C@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.3.2022 20.00, Steinar H. Gunderson wrote:
> On Tue, Mar 15, 2022 at 01:32:38PM +0200, Adrian Hunter wrote:
>>> I think the structure looks good, but I'm not sure about updating
>>> e.g. ptq->last_cy_insn_cnt in both functions? Does that make sense?
>> It should only be updated in the new intel_pt_synth_cycle_sample().
>> intel_pt_synth_instruction_sample() should be unchanged.
> 
> Hm, OK. But something definitely changed between my original patch and
> your change. (The first patch; I didn't try the last one yet.) With my
> patch, I got (on a specific trace, synthing cycles only with perf report
> --itrace=y0nse):
> 
> Samples: 4M of event 'cycles:uH', Event count (approx.): 4844309
> 
> With yours on the same file:
> 
> Samples: 2M of event 'cycles:uH', Event count (approx.): 77622449
> 
> The relative times between functions are also pretty different (although
> none of them are obviously crazy), so one of them has to be wrong.
> Is this to be expected, ie., would you expect your change to fix some
> bad bug on cycle-only synth? For reference, “perf script --itrace=i0ns
> -F +ipc | grep -c IPC:” (a quick proxy for the number of CYC packets :-) )
> yields 4836782, so I'm a bit surprised why there are only 2M events
> being emitted from that.

Sorry, my first suggestion has issues, but the second is better.
