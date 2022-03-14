Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3F94D8900
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242973AbiCNQZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237485AbiCNQZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:25:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C64A1BB;
        Mon, 14 Mar 2022 09:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647275063; x=1678811063;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rVw+GbK2gXIEUaYudbzUjTMPHTwyhB1+YAiu7H9QzH0=;
  b=HMrNFDoRxtDk+XY+LXXoii96YwvJ6qvbxCn6vSCkuCKN0wNHLiZrfugu
   QelaYzF/tSM3RC+olToLVLNK9N4LcOAzIgPWtTyk+8yO3uJd1kV04D211
   8SZCrwrO7Q/E2QtqD+mRKU5ZQrNmGzPPmuJfTbK1pGhrjGtwGrg+ysoJl
   JmCKiu6d70esOsiB37wsxcA7GuFcweauHdTRBLNjLUvXws/YpwPk1USzH
   scJk6HR6eiSCkX0j4k656C1jsRFFgmPCSL6wMy5CmB004zhYp8pDqwxMU
   FMtlzU5qA1nCcnZGBc9S/3dOhy5Dl7x6z9GTI4mybWr5p0aLRbxyWfbn2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="342503417"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="342503417"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 09:24:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="515497538"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga006.jf.intel.com with ESMTP; 14 Mar 2022 09:24:20 -0700
Message-ID: <ba2c49da-22c5-06ea-e953-82211b953ca8@intel.com>
Date:   Mon, 14 Mar 2022 18:24:19 +0200
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
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <YiuKAk7SaXP7B7Ee@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2022 19:42, Steinar H. Gunderson wrote:
> On Fri, Mar 11, 2022 at 11:10:30AM +0200, Adrian Hunter wrote:
>>> @@ -1633,7 +1639,7 @@ static int intel_pt_synth_instruction_sample(struct intel_pt_queue *ptq)
>>>  	else
>>>  		sample.period = ptq->state->tot_insn_cnt - ptq->last_insn_cnt;
>>>  
>>> -	if (ptq->sample_ipc)
>>> +	if (ptq->sample_ipc || pt->sample_cycles)
>> This is not quite right.  ptq->sample_ipc is set to indicate when the
>> cycle count is accurate for the current instruction.  It can be weakened
>> by using "Approx IPC" which was introduced for dlfilter-show-cycles.
>> Probably that approach should be followed for a "cycles" event also.
> 
> Thanks for the review!
> 
> I'm not sure if I understand this entirely. The point of the code here
> is to get sample.cyc_cnt computed, even if we're not sampling IPC.
> I've seen the approx IPC code, but I'm not entirely sure how it
> interacts with this?
> 
>>>  		sample.cyc_cnt = ptq->ipc_cyc_cnt - ptq->last_in_cyc_cnt;
>>>  	if (sample.cyc_cnt) {
>>>  		sample.insn_cnt = ptq->ipc_insn_cnt - ptq->last_in_insn_cnt;
>>> @@ -1643,8 +1649,30 @@ static int intel_pt_synth_instruction_sample(struct intel_pt_queue *ptq)
>>>  
>>>  	ptq->last_insn_cnt = ptq->state->tot_insn_cnt;
>> There are variables here that are specific to the "instructions" event, so
>> mixing "cycles" with "instructions" means duplicating those, however maybe
>> it would be better not to allow "y" and "i" options at the same time?
> 
> Given that a decode can easily take an hour, it would be really nice to
> be able to keep y and i at the same time :-) (A long-standing pet peeve
> of mine in perf is that you can't show two events side-by-side;
> oprofile did that back in the day, at least on annotations.)
> 
> What specifically do you mean by duplicating? That we need to calculate
> them twice in a way I don't do in my current patch, or something else?
> It feels like I'm missing some context here.
> 
>>> -	return intel_pt_deliver_synth_event(pt, event, &sample,
>>> -					    pt->instructions_sample_type);
>>> +	if (pt->sample_instructions) {
>>> +		err = intel_pt_deliver_synth_event(pt, event, &sample,
>>> +						   pt->instructions_sample_type);
>>> +		if (err)
>>> +			return err;
>>> +	}
>>> +
>>> +	/*
>>> +	 * NOTE: If not doing sampling (e.g. itrace=y0us), we will in practice
>>> +	 * only see cycles being attributed to branches, since CYC packets
>>> +	 * only are emitted together with other packets are emitted.
>>> +	 * We should perhaps consider spreading it out over everything since
>>> +	 * the last CYC packet, ie., since last time sample.cyc_cnt was nonzero.
>>> +	 */
>>> +	if (pt->sample_cycles && sample.cyc_cnt) {
>>> +		sample.id = ptq->pt->cycles_id;
>>> +		sample.stream_id = ptq->pt->cycles_id;
>> A "cycles" sample needs to set the sample period to the number of cycles since the
>> last "cycles" sample.
> 
> OK. If I understand you right, is this as simple as sample.period =
> sample.cyc_cnt?
> 
> /* Steinar */

Perhaps changing it something like below.  What do you think?


diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 062cd25f7cd7..cec0444277f6 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -215,6 +215,8 @@ struct intel_pt_queue {
 	u64 ipc_cyc_cnt;
 	u64 last_in_insn_cnt;
 	u64 last_in_cyc_cnt;
+	u64 last_cy_insn_cnt;
+	u64 last_cy_cyc_cnt;
 	u64 last_br_insn_cnt;
 	u64 last_br_cyc_cnt;
 	unsigned int cbr_seen;
@@ -1666,12 +1668,11 @@ static void intel_pt_prep_sample(struct intel_pt *pt,
 	}
 }
 
-static int intel_pt_synth_instruction_or_cycle_sample(struct intel_pt_queue *ptq)
+static int intel_pt_synth_instruction_sample(struct intel_pt_queue *ptq)
 {
 	struct intel_pt *pt = ptq->pt;
 	union perf_event *event = ptq->event_buf;
 	struct perf_sample sample = { .ip = 0, };
-	int err;
 
 	if (intel_pt_skip_event(pt))
 		return 0;
@@ -1685,7 +1686,7 @@ static int intel_pt_synth_instruction_or_cycle_sample(struct intel_pt_queue *ptq
 	else
 		sample.period = ptq->state->tot_insn_cnt - ptq->last_insn_cnt;
 
-	if (ptq->sample_ipc || pt->sample_cycles)
+	if (ptq->sample_ipc)
 		sample.cyc_cnt = ptq->ipc_cyc_cnt - ptq->last_in_cyc_cnt;
 	if (sample.cyc_cnt) {
 		sample.insn_cnt = ptq->ipc_insn_cnt - ptq->last_in_insn_cnt;
@@ -1695,30 +1696,40 @@ static int intel_pt_synth_instruction_or_cycle_sample(struct intel_pt_queue *ptq
 
 	ptq->last_insn_cnt = ptq->state->tot_insn_cnt;
 
-	if (pt->sample_instructions) {
-		err = intel_pt_deliver_synth_event(pt, event, &sample,
-						   pt->instructions_sample_type);
-		if (err)
-			return err;
-	}
+	return intel_pt_deliver_synth_event(pt, event, &sample,
+					    pt->instructions_sample_type);
+}
 
-	/*
-	 * NOTE: If not doing sampling (e.g. itrace=y0us), we will in practice
-	 * only see cycles being attributed to branches, since CYC packets
-	 * only are emitted together with other packets are emitted.
-	 * We should perhaps consider spreading it out over everything since
-	 * the last CYC packet, ie., since last time sample.cyc_cnt was nonzero.
-	 */
-	if (pt->sample_cycles && sample.cyc_cnt) {
-		sample.id = ptq->pt->cycles_id;
-		sample.stream_id = ptq->pt->cycles_id;
-		err = intel_pt_deliver_synth_event(pt, event, &sample,
-						   pt->cycles_sample_type);
-		if (err)
-			return err;
+static int intel_pt_synth_cycle_sample(struct intel_pt_queue *ptq)
+{
+	struct intel_pt *pt = ptq->pt;
+	union perf_event *event = ptq->event_buf;
+	struct perf_sample sample = { .ip = 0, };
+	u64 period;
+
+	if (pt->synth_opts.quick)
+		period = 1;
+	else
+		period = ptq->ipc_cyc_cnt - ptq->last_cy_cyc_cnt;
+
+	if (!period || intel_pt_skip_event(pt))
+		return 0;
+
+	intel_pt_prep_sample(pt, ptq, event, &sample);
+
+	sample.id = ptq->pt->cycles_id;
+	sample.stream_id = ptq->pt->cycles_id;
+	sample.period = period;
+
+	if (ptq->sample_ipc)
+		sample.cyc_cnt = sample.period;
+	if (sample.cyc_cnt) {
+		sample.insn_cnt = ptq->ipc_insn_cnt - ptq->last_cy_insn_cnt;
+		ptq->last_cy_insn_cnt = ptq->ipc_insn_cnt;
+		ptq->last_cy_cyc_cnt = ptq->ipc_cyc_cnt;
 	}
 
-	return 0;
+	return intel_pt_deliver_synth_event(pt, event, &sample, pt->cycles_sample_type);
 }
 
 static int intel_pt_synth_transaction_sample(struct intel_pt_queue *ptq)
@@ -2457,11 +2468,17 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 		}
 	}
 
-	if ((pt->sample_instructions || pt->sample_cycles) &&
-	    (state->type & INTEL_PT_INSTRUCTION)) {
-		err = intel_pt_synth_instruction_or_cycle_sample(ptq);
-		if (err)
-			return err;
+	if (state->type & INTEL_PT_INSTRUCTION) {
+		if (pt->sample_instructions) {
+			err = intel_pt_synth_instruction_sample(ptq);
+			if (err)
+				return err;
+		}
+		if (pt->sample_cycles) {
+			err = intel_pt_synth_cycle_sample(ptq);
+			if (err)
+				return err;
+		}
 	}
 
 	if (pt->sample_transactions && (state->type & INTEL_PT_TRANSACTION)) {


