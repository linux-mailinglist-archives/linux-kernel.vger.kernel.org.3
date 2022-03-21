Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2654E4E2320
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345789AbiCUJSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345787AbiCUJSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:18:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359C13525E;
        Mon, 21 Mar 2022 02:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647854221; x=1679390221;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Z6FoBmMzUj/h6G67RT14tpXv61lHjD9Rx9GsVyx6fFU=;
  b=KrXmMZFvL6sejkhTqdg33Kp52/tGYhvTipetixX1CyZVDdvdlkZS8MMy
   I4wJ3lER/r6D3dqNCskW3OTyqrxA7ymFGLLTQF7qik97/M/oN62YHMbHb
   9eh6b9ZxpCZo5CxjCz2vA6s3NwDNdnsjKOqQffC7XHWWDQSLG5fxwxYUt
   E84Z9XhRpNIQd4Icu7G61Xs71p5fQFBsIbEj4m5fje6ENSxXm1nSs2zX1
   3lJRSKef1yrkhIGGYB2dTX1UFp67ajBGe5dZLE1egY20QYEfIWlwOsiCB
   OxGLW8yPU+NVdpIT7+H0bGwAXReDaWgGyphfFT8a/iEIQ9FZqc+nStM+K
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="257226115"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="257226115"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 02:16:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="582800731"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga001.jf.intel.com with ESMTP; 21 Mar 2022 02:16:57 -0700
Message-ID: <371faf0d-f794-4a2e-0a1c-9d454d7c8b12@intel.com>
Date:   Mon, 21 Mar 2022 11:16:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] perf intel-pt: Synthesize cycle events
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
 <52903e58-e74c-5ea0-36b4-277ea3610af4@intel.com>
 <YjGdoGy4Z2UUG9S9@google.com>
 <ef780335-7dc6-3a23-54a8-b6fc9c8a2ed3@intel.com>
 <YjHfGrZovk3N/H0f@google.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <YjHfGrZovk3N/H0f@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.3.2022 14.59, Steinar H. Gunderson wrote:
> On Wed, Mar 16, 2022 at 01:19:46PM +0200, Adrian Hunter wrote:
>>> I guess the good news is that the perf report coming out of your version
>>> looks more likely to me; I have some functions that are around 1% that
>>> shouldn't intuitively be that much (and, if I write some Perl to sum up
>>> the cycles from the IPC lines in perf script, are more around 0.1%).
>>> So perhaps we should stop chasing the difference? I don't know.
>> That doesn't sound right.  I will look at it more closely in the next few days.
> 
> If you need, I can supply the perf.data and binaries, but we're talking
> a couple of gigabytes of data (and I don't know immediately if there's
> an easy way I can package up everything perf.data references) :-)
> 
> /* Steinar */

I had another look at this and it seemed *mostly* OK for me.  One change
I would make is to subject the cycle period to the logic of the 'A' option
(approximate IPC).

So what does the 'A' option do.

By default, IPC is output only when the exact number of cycles and
instructions is known for the sample.  Decoding walks instructions
to reconstruct the control flow, so the exact number of instructions
is known, but the cycle count (CYC packet) is only produced with
another packet, so only indirect/async branches or the first
conditional branch of a TNT packet.

Reporting exact IPC makes sense when sampling every branch or
instruction, but makes less sense when sampling less often.

For example with:

$ perf record -e intel_pt/cyc/u uname
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.218 MB perf.data ]

Sampling every 50us, exact IPC is reported only twice:

$ perf script --itrace=i50us -F+ipc
           uname 2007962 [005] 2426597.185314:      91866 instructions:uH:      7f3feb913deb _dl_relocate_object+0x40b (/usr/lib/x86_64-linux-gnu/ld-2.31.so)
           uname 2007962 [005] 2426597.185353:      21959 instructions:uH:      7f3feb91158f do_lookup_x+0xcf (/usr/lib/x86_64-linux-gnu/ld-2.31.so)
           uname 2007962 [005] 2426597.185670:     129834 instructions:uH:      7f3feb72e05a read_alias_file+0x23a (/usr/lib/x86_64-linux-gnu/libc-2.31.so)
           uname 2007962 [005] 2426597.185709:      39373 instructions:uH:      7f3feb72ed52 _nl_explode_name+0x52 (/usr/lib/x86_64-linux-gnu/libc-2.31.so)
           uname 2007962 [005] 2426597.185947:     137486 instructions:uH:      7f3feb87e5f3 __strlen_avx2+0x13 (/usr/lib/x86_64-linux-gnu/libc-2.31.so)         IPC: 0.88 (420518/472789) 
           uname 2007962 [005] 2426597.186026:      79196 instructions:uH:      7f3feb87e5f3 __strlen_avx2+0x13 (/usr/lib/x86_64-linux-gnu/libc-2.31.so)         IPC: 1.34 (79196/59092) 
           uname 2007962 [005] 2426597.186066:      29855 instructions:uH:      7f3feb78dee6 _int_malloc+0x446 (/usr/lib/x86_64-linux-gnu/libc-2.31.so)

But if we relax the requirement and just use the number of cycles
counted so far, whether it is exactly correct or not, we can get
approx IPC for every sample:

$ perf script --itrace=i50usA -F+ipc
           uname 2007962 [005] 2426597.185314:      91866 instructions:uH:      7f3feb913deb _dl_relocate_object+0x40b (/usr/lib/x86_64-linux-gnu/ld-2.31.so)    IPC: 0.74 (91866/122744) 
           uname 2007962 [005] 2426597.185353:      21959 instructions:uH:      7f3feb91158f do_lookup_x+0xcf (/usr/lib/x86_64-linux-gnu/ld-2.31.so)     IPC: 0.92 (21959/23822) 
           uname 2007962 [005] 2426597.185670:     129834 instructions:uH:      7f3feb72e05a read_alias_file+0x23a (/usr/lib/x86_64-linux-gnu/libc-2.31.so)      IPC: 0.77 (129834/167753) 
           uname 2007962 [005] 2426597.185709:      39373 instructions:uH:      7f3feb72ed52 _nl_explode_name+0x52 (/usr/lib/x86_64-linux-gnu/libc-2.31.so)      IPC: 1.01 (39373/38881) 
           uname 2007962 [005] 2426597.185947:     137486 instructions:uH:      7f3feb87e5f3 __strlen_avx2+0x13 (/usr/lib/x86_64-linux-gnu/libc-2.31.so)         IPC: 1.14 (137486/119589) 
           uname 2007962 [005] 2426597.186026:      79196 instructions:uH:      7f3feb87e5f3 __strlen_avx2+0x13 (/usr/lib/x86_64-linux-gnu/libc-2.31.so)         IPC: 1.34 (79196/59092) 
           uname 2007962 [005] 2426597.186066:      29855 instructions:uH:      7f3feb78dee6 _int_malloc+0x446 (/usr/lib/x86_64-linux-gnu/libc-2.31.so)          IPC: 1.33 (29855/22282) 


So the cycle sample function looks like this:

static int intel_pt_synth_cycle_sample(struct intel_pt_queue *ptq)
{
	struct intel_pt *pt = ptq->pt;
	union perf_event *event = ptq->event_buf;
	struct perf_sample sample = { .ip = 0, };
	u64 period = 0;

	if (ptq->sample_ipc)
		period = ptq->ipc_cyc_cnt - ptq->last_cy_cyc_cnt;

	if (!period || intel_pt_skip_event(pt))
		return 0;

	intel_pt_prep_sample(pt, ptq, event, &sample);

	sample.id = ptq->pt->cycles_id;
	sample.stream_id = ptq->pt->cycles_id;
	sample.period = period;

	sample.cyc_cnt = period;
	sample.insn_cnt = ptq->ipc_insn_cnt - ptq->last_cy_insn_cnt;
	ptq->last_cy_insn_cnt = ptq->ipc_insn_cnt;
	ptq->last_cy_cyc_cnt = ptq->ipc_cyc_cnt;

	return intel_pt_deliver_synth_event(pt, event, &sample, pt->cycles_sample_type);
}


With regard to the results you got with perf report, please try:

	perf report --itrace=y0nse --show-total-period --stdio

and see if the percentages and cycle counts for rarely executed
functions make more sense.
