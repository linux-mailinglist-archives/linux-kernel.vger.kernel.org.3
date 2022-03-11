Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654B44D5E11
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343583AbiCKJLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbiCKJLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:11:43 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0062A1BB70D;
        Fri, 11 Mar 2022 01:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646989841; x=1678525841;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9XZd3A5JSwNwuvRtar4ydpQDnQtwJ4sZrgR4lOTdwJM=;
  b=VnkVWAE8Nh5FEMQ7JIc9cIruW9AfbiwLZCrYV31eb1k1PjcXMEW39oLD
   AxNDC3N48YrhrIFmmdFA/HvztgOv3v+CTh6q6FgsBY/gGuU+2GjR+PR8D
   3aEjLHYitMdVSPKP8JUcXN4fm2Kqxa04tUI4Cv1qq6BTnT8e3lxYQK8Om
   Hloqlezy7IP0GUpADkh1hfY1bqhy18lUhhUrvdjbj96QlYd+hOMcfkX98
   Ni5Y8AOFdbVQZ8TBwtQ/qk0jAae7AimiGHYiWAZlSsLBSTe9ICy38ZWMh
   uv2kFepiv3rUbJ0YQMFIRknJOqQvvSngL9ElY5oUjdmLrxv0cJVf8EKDQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="341963142"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="341963142"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 01:10:40 -0800
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="555227879"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.52.194])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 01:10:36 -0800
Message-ID: <586de5fc-858b-2693-1986-5c77e8c0e3d0@intel.com>
Date:   Fri, 11 Mar 2022 11:10:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH] perf intel-pt: Synthesize cycle events
Content-Language: en-US
To:     "Steinar H. Gunderson" <sesse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220310093844.982656-1-sesse@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220310093844.982656-1-sesse@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.3.2022 11.38, Steinar H. Gunderson wrote:
> There is no good reason why we cannot synthesize "cycle" events
> from Intel PT just as we can synthesize "instruction" events,
> in particular when CYC packets are available. This enables using
> PT to getting much more accurate cycle profiles than regular sampling
> (record -e cycles) when the work last for very short periods (<10 ms).
> Thus, add support for this, based off of the existing IPC calculation
> framework. The new option to --itrace is "y" (for cYcles), as c was
> taken for calls. Cycle and instruction events can be synthesized
> together, and are by default.
> 
> The only real caveat is that CYC packets are only emitted whenever
> some other packet is, which in practice is when a branch instruction
> is encountered. Thus, even at no subsampling (e.g. --itrace=y0ns),
> it is impossible to get more accuracy than a single basic block, and all
> cycles spent executing that block will get attributed to the branch
> instruction that ends it. Thus, one cannot know whether the cycles came
> from e.g. a specific load, a mispredicted branch, or something else.
> When subsampling (which is the default), the cycle events will get
> smeared out even more, but will still be useful to attribute cycle
> counts to functions.
> 
> Signed-off-by: Steinar H. Gunderson <sesse@google.com>
> ---
>  tools/perf/Documentation/itrace.txt        |  3 +-
>  tools/perf/Documentation/perf-intel-pt.txt | 33 +++++++-----
>  tools/perf/util/auxtrace.c                 |  9 +++-
>  tools/perf/util/auxtrace.h                 |  7 ++-
>  tools/perf/util/intel-pt.c                 | 59 +++++++++++++++++++---
>  5 files changed, 88 insertions(+), 23 deletions(-)
> 

<SNIP>

> -static int intel_pt_synth_instruction_sample(struct intel_pt_queue *ptq)
> +static int intel_pt_synth_instruction_or_cycle_sample(struct intel_pt_queue *ptq)
>  {
>  	struct intel_pt *pt = ptq->pt;
>  	union perf_event *event = ptq->event_buf;
>  	struct perf_sample sample = { .ip = 0, };
> +	int err;
>  
>  	if (intel_pt_skip_event(pt))
>  		return 0;
> @@ -1633,7 +1639,7 @@ static int intel_pt_synth_instruction_sample(struct intel_pt_queue *ptq)
>  	else
>  		sample.period = ptq->state->tot_insn_cnt - ptq->last_insn_cnt;
>  
> -	if (ptq->sample_ipc)
> +	if (ptq->sample_ipc || pt->sample_cycles)

This is not quite right.  ptq->sample_ipc is set to indicate when the
cycle count is accurate for the current instruction.  It can be weakened
by using "Approx IPC" which was introduced for dlfilter-show-cycles.
Probably that approach should be followed for a "cycles" event also.

From perf-intel-pt man page:

dlfilter-show-cycles.so
~~~~~~~~~~~~~~~~~~~~~~~

Cycles can be displayed using dlfilter-show-cycles.so in which case the itrace A
option can be useful to provide higher granularity cycle information:

	perf script --itrace=A --call-trace --dlfilter dlfilter-show-cycles.so

To see a list of dlfilters:

	perf script -v --list-dlfilters

See also linkperf:perf-dlfilters[1]


>  		sample.cyc_cnt = ptq->ipc_cyc_cnt - ptq->last_in_cyc_cnt;
>  	if (sample.cyc_cnt) {
>  		sample.insn_cnt = ptq->ipc_insn_cnt - ptq->last_in_insn_cnt;
> @@ -1643,8 +1649,30 @@ static int intel_pt_synth_instruction_sample(struct intel_pt_queue *ptq)
>  
>  	ptq->last_insn_cnt = ptq->state->tot_insn_cnt;

There are variables here that are specific to the "instructions" event, so
mixing "cycles" with "instructions" means duplicating those, however maybe
it would be better not to allow "y" and "i" options at the same time?

>  
> -	return intel_pt_deliver_synth_event(pt, event, &sample,
> -					    pt->instructions_sample_type);
> +	if (pt->sample_instructions) {
> +		err = intel_pt_deliver_synth_event(pt, event, &sample,
> +						   pt->instructions_sample_type);
> +		if (err)
> +			return err;
> +	}
> +
> +	/*
> +	 * NOTE: If not doing sampling (e.g. itrace=y0us), we will in practice
> +	 * only see cycles being attributed to branches, since CYC packets
> +	 * only are emitted together with other packets are emitted.
> +	 * We should perhaps consider spreading it out over everything since
> +	 * the last CYC packet, ie., since last time sample.cyc_cnt was nonzero.
> +	 */
> +	if (pt->sample_cycles && sample.cyc_cnt) {
> +		sample.id = ptq->pt->cycles_id;
> +		sample.stream_id = ptq->pt->cycles_id;

A "cycles" sample needs to set the sample period to the number of cycles since the
last "cycles" sample.

> +		err = intel_pt_deliver_synth_event(pt, event, &sample,
> +						   pt->cycles_sample_type);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
>  }
