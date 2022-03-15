Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B31F4D9A6C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 12:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347943AbiCOLd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 07:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347204AbiCOLdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 07:33:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864294F9F9;
        Tue, 15 Mar 2022 04:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647343962; x=1678879962;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iM2O36wRdXPMXbBG10OMjmaLO4TCW82GZCSbNWA1tOE=;
  b=Iv/eRfCAy98uk94VAN2CK4BZJJcGg5jf+BJ0/Xdi+c4RKrbeUOar9B48
   GmwoefCbEvlO9lvHWGg4zATeadaYqpsZ8qQVdT88VDkOuZ8B45zvI8XUw
   sihk57euOyggwjbY3A7lG4Xmq6XiDMZ18FHA2L4ab1FPNhYKqVVo+EyOx
   Ay0aoVGTHzKK5wWijI2ImAqOam4e/glz7N7sgptn1MqmebdlPjgojUXHN
   y2FOjb+Ema5ccjU9wkyjx+e0jmOx2ApHVZUUl7EjarI6QnKfDGi16Ehce
   ZkrlDMRfZwHxGvYjrefJM4533yQl5A4oK4mMKBHzkfw62qi8UPizEYq5J
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="243726953"
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="243726953"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 04:32:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="556884063"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 15 Mar 2022 04:32:39 -0700
Message-ID: <c50bb87d-9fee-c4f9-a350-8729e503e43a@intel.com>
Date:   Tue, 15 Mar 2022 13:32:38 +0200
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
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <YjBnet2813sEGjZY@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2022 12:16, Steinar H. Gunderson wrote:
> On Mon, Mar 14, 2022 at 06:24:19PM +0200, Adrian Hunter wrote:
>> Perhaps changing it something like below.  What do you think?
> 
> I think the structure looks good, but I'm not sure about updating
> e.g. ptq->last_cy_insn_cnt in both functions? Does that make sense?

It should only be updated in the new intel_pt_synth_cycle_sample().
intel_pt_synth_instruction_sample() should be unchanged.

Also it would be better to keep the IPC count separate from the
sample period. i.e. a third new variable ptq->last_cyc_cnt
which works the same as ptq->last_insn_cnt does for intel_pt_synth_instruction_sample()

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index c1f261229932..c7a4b5feea2a 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -211,10 +211,13 @@ struct intel_pt_queue {
 	u32 flags;
 	u16 insn_len;
 	u64 last_insn_cnt;
+	u64 last_cyc_cnt;
 	u64 ipc_insn_cnt;
 	u64 ipc_cyc_cnt;
 	u64 last_in_insn_cnt;
 	u64 last_in_cyc_cnt;
+	u64 last_cy_insn_cnt;
+	u64 last_cy_cyc_cnt;
 	u64 last_br_insn_cnt;
 	u64 last_br_cyc_cnt;
 	unsigned int cbr_seen;

Then the new function becomes:

static int intel_pt_synth_cycle_sample(struct intel_pt_queue *ptq)
{
	struct intel_pt *pt = ptq->pt;
	union perf_event *event = ptq->event_buf;
	struct perf_sample sample = { .ip = 0, };
	u64 period;

	if (pt->synth_opts.quick)
		period = 1;
	else
		period = ptq->ipc_cyc_cnt - ptq->last_cyc_cnt;

	if (!period || intel_pt_skip_event(pt))
		return 0;

	intel_pt_prep_sample(pt, ptq, event, &sample);

	sample.id = ptq->pt->cycles_id;
	sample.stream_id = ptq->pt->cycles_id;
	sample.period = period;

	if (ptq->sample_ipc)
		sample.cyc_cnt = ptq->ipc_cyc_cnt - ptq->last_cy_cyc_cnt;
	if (sample.cyc_cnt) {
		sample.insn_cnt = ptq->ipc_insn_cnt - ptq->last_cy_insn_cnt;
		ptq->last_cy_insn_cnt = ptq->ipc_insn_cnt;
		ptq->last_cy_cyc_cnt = ptq->ipc_cyc_cnt;
	}

	ptq->last_cyc_cnt = ptq->ipc_cyc_cnt;

	return intel_pt_deliver_synth_event(pt, event, &sample, pt->cycles_sample_type);
}


> 
> I ran this and found something strange: I've started getting some hits
> (very small amounts, e.g. 0.14%) on instructions that are not branches.
> How can that happen?

Possibly a PSB packet.

If you have an example and recent perf tools you can see the decoder
log as follows:

perf script --itrace=y0nsed+o --time <start time>,<end time> -C <cpu>

where you select <start time>, <end time> and <cpu> to limit the
decoding to that time range and cpu.



