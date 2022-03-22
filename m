Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AE94E3A89
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiCVI0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiCVI0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:26:32 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6B0340EE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:25:03 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id 9-20020a05600c240900b0038c99b98f6fso533714wmp.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GInktEXBjq6+OxYFCo1yuI07Vs+lU+dzEENQ3B5Q+h8=;
        b=arBses4if+Z5s43HVEKsvN4cDnAyX2+GDU+VUK9N+jCMcbneUkfV2bV7jQWWiUxLHx
         gZzIDlIGdzrpY3XbHJwM5xGTB6Y2xEa9aiIjora8PPMU7FIYeQVwMMLTkCjpD8nPhyJz
         lNFLDqkGWqQVqFLd9uPeo/X46feG1l5lJSFlWdDx7NpBm57nBXnknW59e7+fuES4VCgn
         2PauC3EKMMvIJdKEA7lmtCdi2vDCchO32GSQNJR+IJRvIxRcSih/EFI2y3JESxoTe2Z8
         Tz8qpgjDAAMscCPKcN24Zri/NsiaRUClcGfH6tdguFVHxfGYeToZI8TGIHV6CC0nofsA
         p61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GInktEXBjq6+OxYFCo1yuI07Vs+lU+dzEENQ3B5Q+h8=;
        b=R5kWegjwvKId3zlJqSUga9jtZTr0xRNxnm4/mMdoZMv8VknG9cf0fDN0rYiLxG33AT
         fbRw/lB5xRP8Gk2JN1Phxo/l2krg2g4vEA94em/FAnRM0vDpKa+LBNOp/9qkpW+6n2YV
         BLMN4pm5uIUCrvMTS5Nf9tXNPNUftn3zCiLy0sQSn8Fz/gN+6Y4tShEnL1zeWudHSf7F
         TE3HDJ82DAYbpLIEdxGL+ZswJ2IZoFoTJJFxxtrtNwE9jZ7F8CLcc3sG5sRsZBNVnlq1
         ODgQrK8eWMRxof9yCi0VrM+jxU0AFBE4hUqrRloS+Dns1vFOGdPN0B0zhFPn627VC2iR
         fBIw==
X-Gm-Message-State: AOAM530wuj7vN9i3L1qzN09aA3ZP5eOv61k4oEaSj2EGhpFDT5t3plBL
        lElUtDXRzX1To/dYyNy6StefoxaHKA==
X-Google-Smtp-Source: ABdhPJw8HewRzF/MU+WXq5vaMD5eSZPm+oj4D8fqk80PhfoXAUUYtvS5l4v/CytQN6jvLBDDLhTbrhW5Nw==
X-Received: from sesstop.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:26f6])
 (user=sesse job=sendgmr) by 2002:a1c:f219:0:b0:38c:782c:3bb with SMTP id
 s25-20020a1cf219000000b0038c782c03bbmr2582429wmc.94.1647937501995; Tue, 22
 Mar 2022 01:25:01 -0700 (PDT)
Date:   Tue, 22 Mar 2022 09:24:52 +0100
Message-Id: <20220322082452.1429091-1-sesse@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v3] perf intel-pt: Synthesize cycle events
From:   "Steinar H. Gunderson" <sesse@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Steinar H. Gunderson" <sesse@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no good reason why we cannot synthesize "cycle" events
from Intel PT just as we can synthesize "instruction" events,
in particular when CYC packets are available. This enables using
PT to getting much more accurate cycle profiles than regular sampling
(record -e cycles) when the work last for very short periods (<10 ms).
Thus, add support for this, based off of the existing IPC calculation
framework. The new option to --itrace is "y" (for cYcles), as c was
taken for calls. Cycle and instruction events can be synthesized
together, and are by default.

The only real caveat is that CYC packets are only emitted whenever
some other packet is, which in practice is when a branch instruction
is encountered (and not even all branches). Thus, even at no subsampling
(e.g. --itrace=y0ns), it is impossible to get more accuracy than
a single basic block, and all cycles spent executing that block
will get attributed to the branch instruction that ends the packet.
Thus, one cannot know whether the cycles came from e.g. a specific load,
a mispredicted branch, or something else. When subsampling (which
is the default), the cycle events will get smeared out even more,
but will still be generally useful to attribute cycle counts to functions.

Signed-off-by: Steinar H. Gunderson <sesse@google.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/itrace.txt        |  3 +-
 tools/perf/Documentation/perf-intel-pt.txt | 36 ++++++++----
 tools/perf/util/auxtrace.c                 |  9 ++-
 tools/perf/util/auxtrace.h                 |  7 ++-
 tools/perf/util/intel-pt.c                 | 67 ++++++++++++++++++++--
 5 files changed, 101 insertions(+), 21 deletions(-)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index c52755481e2f..af69d80a05b7 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -1,4 +1,5 @@
 		i	synthesize instructions events
+		y	synthesize cycles events
 		b	synthesize branches events (branch misses for Arm SPE)
 		c	synthesize branches events (calls only)
 		r	synthesize branches events (returns only)
@@ -23,7 +24,7 @@
 		A	approximate IPC
 		Z	prefer to ignore timestamps (so-called "timeless" decoding)
 
-	The default is all events i.e. the same as --itrace=ibxwpe,
+	The default is all events i.e. the same as --itrace=iybxwpe,
 	except for perf script where it is --itrace=ce
 
 	In addition, the period (default 100000, except for perf script where it is 1)
diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index cbb920f5d056..d71710fb8e0c 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -101,12 +101,12 @@ data is available you can use the 'perf script' tool with all itrace sampling
 options, which will list all the samples.
 
 	perf record -e intel_pt//u ls
-	perf script --itrace=ibxwpe
+	perf script --itrace=iybxwpe
 
 An interesting field that is not printed by default is 'flags' which can be
 displayed as follows:
 
-	perf script --itrace=ibxwpe -F+flags
+	perf script --itrace=iybxwpe -F+flags
 
 The flags are "bcrosyiABExgh" which stand for branch, call, return, conditional,
 system, asynchronous, interrupt, transaction abort, trace begin, trace end,
@@ -146,16 +146,17 @@ displayed as follows:
 There are two ways that instructions-per-cycle (IPC) can be calculated depending
 on the recording.
 
-If the 'cyc' config term (see config terms section below) was used, then IPC is
-calculated using the cycle count from CYC packets, otherwise MTC packets are
-used - refer to the 'mtc' config term.  When MTC is used, however, the values
-are less accurate because the timing is less accurate.
+If the 'cyc' config term (see config terms section below) was used, then IPC
+and cycle events are calculated using the cycle count from CYC packets, otherwise
+MTC packets are used - refer to the 'mtc' config term.  When MTC is used, however,
+the values are less accurate because the timing is less accurate.
 
 Because Intel PT does not update the cycle count on every branch or instruction,
 the values will often be zero.  When there are values, they will be the number
 of instructions and number of cycles since the last update, and thus represent
-the average IPC since the last IPC for that event type.  Note IPC for "branches"
-events is calculated separately from IPC for "instructions" events.
+the average IPC cycle count since the last IPC for that event type.
+Note IPC for "branches" events is calculated separately from IPC for "instructions"
+events.
 
 Even with the 'cyc' config term, it is possible to produce IPC information for
 every change of timestamp, but at the expense of accuracy.  That is selected by
@@ -865,11 +866,12 @@ Having no option is the same as
 
 which, in turn, is the same as
 
-	--itrace=cepwx
+	--itrace=cepwxy
 
 The letters are:
 
 	i	synthesize "instructions" events
+	y	synthesize "cycles" events
 	b	synthesize "branches" events
 	x	synthesize "transactions" events
 	w	synthesize "ptwrite" events
@@ -890,6 +892,16 @@ The letters are:
 "Instructions" events look like they were recorded by "perf record -e
 instructions".
 
+"Cycles" events look like they were recorded by "perf record -e cycles"
+(ie., the default). Note that even with CYC packets enabled and no sampling,
+these are not fully accurate, since CYC packets are not emitted for each
+instruction, only when some other event (like an indirect branch, or a
+TNT packet representing multiple branches) happens causes a packet to
+be emitted. Thus, it is more effective for attributing cycles to functions
+(and possibly basic blocks) than to individual instructions, although it
+is not even perfect for functions (although it becomes better if the noretcomp
+option is active).
+
 "Branches" events look like they were recorded by "perf record -e branches". "c"
 and "r" can be combined to get calls and returns.
 
@@ -897,9 +909,9 @@ and "r" can be combined to get calls and returns.
 'flags' field can be used in perf script to determine whether the event is a
 transaction start, commit or abort.
 
-Note that "instructions", "branches" and "transactions" events depend on code
-flow packets which can be disabled by using the config term "branch=0".  Refer
-to the config terms section above.
+Note that "instructions", "cycles", "branches" and "transactions" events
+depend on code flow packets which can be disabled by using the config term
+"branch=0".  Refer to the config terms section above.
 
 "ptwrite" events record the payload of the ptwrite instruction and whether
 "fup_on_ptw" was used.  "ptwrite" events depend on PTWRITE packets which are
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 825336304a37..18e457b80bde 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1346,6 +1346,7 @@ void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
 		synth_opts->calls = true;
 	} else {
 		synth_opts->instructions = true;
+		synth_opts->cycles = true;
 		synth_opts->period_type = PERF_ITRACE_DEFAULT_PERIOD_TYPE;
 		synth_opts->period = PERF_ITRACE_DEFAULT_PERIOD;
 	}
@@ -1424,7 +1425,11 @@ int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
 	for (p = str; *p;) {
 		switch (*p++) {
 		case 'i':
-			synth_opts->instructions = true;
+		case 'y':
+			if (p[-1] == 'y')
+				synth_opts->cycles = true;
+			else
+				synth_opts->instructions = true;
 			while (*p == ' ' || *p == ',')
 				p += 1;
 			if (isdigit(*p)) {
@@ -1578,7 +1583,7 @@ int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
 		}
 	}
 out:
-	if (synth_opts->instructions) {
+	if (synth_opts->instructions || synth_opts->cycles) {
 		if (!period_type_set)
 			synth_opts->period_type =
 					PERF_ITRACE_DEFAULT_PERIOD_TYPE;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 19910b9011f3..7cd6bad3e46a 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -69,6 +69,9 @@ enum itrace_period_type {
  * @inject: indicates the event (not just the sample) must be fully synthesized
  *          because 'perf inject' will write it out
  * @instructions: whether to synthesize 'instructions' events
+ * @cycles: whether to synthesize 'cycles' events
+ *          (not fully accurate, since CYC packets are only emitted
+ *          together with other events, such as branches)
  * @branches: whether to synthesize 'branches' events
  *            (branch misses only for Arm SPE)
  * @transactions: whether to synthesize events for transactions
@@ -115,6 +118,7 @@ struct itrace_synth_opts {
 	bool			default_no_sample;
 	bool			inject;
 	bool			instructions;
+	bool			cycles;
 	bool			branches;
 	bool			transactions;
 	bool			ptwrites;
@@ -628,6 +632,7 @@ bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
 
 #define ITRACE_HELP \
 "				i[period]:    		synthesize instructions events\n" \
+"				y[period]:    		synthesize cycles events (same period as i)\n" \
 "				b:	    		synthesize branches events (branch misses for Arm SPE)\n" \
 "				c:	    		synthesize branches events (calls only)\n"	\
 "				r:	    		synthesize branches events (returns only)\n" \
@@ -657,7 +662,7 @@ bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
 "				A:			approximate IPC\n" \
 "				Z:			prefer to ignore timestamps (so-called \"timeless\" decoding)\n" \
 "				PERIOD[ns|us|ms|i|t]:   specify period to sample stream\n" \
-"				concatenate multiple options. Default is ibxwpe or cewp\n"
+"				concatenate multiple options. Default is iybxwpe or cewp\n"
 
 static inline
 void itrace_synth_opts__set_time_range(struct itrace_synth_opts *opts,
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index e8613cbda331..826405b843d7 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -5,6 +5,7 @@
  */
 
 #include <inttypes.h>
+#include <linux/perf_event.h>
 #include <stdio.h>
 #include <stdbool.h>
 #include <errno.h>
@@ -89,6 +90,10 @@ struct intel_pt {
 	u64 instructions_sample_type;
 	u64 instructions_id;
 
+	bool sample_cycles;
+	u64 cycles_sample_type;
+	u64 cycles_id;
+
 	bool sample_branches;
 	u32 branches_filter;
 	u64 branches_sample_type;
@@ -195,6 +200,8 @@ struct intel_pt_queue {
 	u64 ipc_cyc_cnt;
 	u64 last_in_insn_cnt;
 	u64 last_in_cyc_cnt;
+	u64 last_cy_insn_cnt;
+	u64 last_cy_cyc_cnt;
 	u64 last_br_insn_cnt;
 	u64 last_br_cyc_cnt;
 	unsigned int cbr_seen;
@@ -1217,7 +1224,7 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 	if (pt->filts.cnt > 0)
 		params.pgd_ip = intel_pt_pgd_ip;
 
-	if (pt->synth_opts.instructions) {
+	if (pt->synth_opts.instructions || pt->synth_opts.cycles) {
 		if (pt->synth_opts.period) {
 			switch (pt->synth_opts.period_type) {
 			case PERF_ITRACE_PERIOD_INSTRUCTIONS:
@@ -1647,6 +1654,33 @@ static int intel_pt_synth_instruction_sample(struct intel_pt_queue *ptq)
 					    pt->instructions_sample_type);
 }
 
+static int intel_pt_synth_cycle_sample(struct intel_pt_queue *ptq)
+{
+	struct intel_pt *pt = ptq->pt;
+	union perf_event *event = ptq->event_buf;
+	struct perf_sample sample = { .ip = 0, };
+	u64 period = 0;
+
+	if (ptq->sample_ipc)
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
+	sample.cyc_cnt = period;
+	sample.insn_cnt = ptq->ipc_insn_cnt - ptq->last_cy_insn_cnt;
+	ptq->last_cy_insn_cnt = ptq->ipc_insn_cnt;
+	ptq->last_cy_cyc_cnt = ptq->ipc_cyc_cnt;
+
+	return intel_pt_deliver_synth_event(pt, event, &sample, pt->cycles_sample_type);
+}
+
 static int intel_pt_synth_transaction_sample(struct intel_pt_queue *ptq)
 {
 	struct intel_pt *pt = ptq->pt;
@@ -2301,10 +2335,17 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 		}
 	}
 
-	if (pt->sample_instructions && (state->type & INTEL_PT_INSTRUCTION)) {
-		err = intel_pt_synth_instruction_sample(ptq);
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
@@ -3378,6 +3419,22 @@ static int intel_pt_synth_events(struct intel_pt *pt,
 		id += 1;
 	}
 
+	if (pt->synth_opts.cycles) {
+		attr.config = PERF_COUNT_HW_CPU_CYCLES;
+		if (pt->synth_opts.period_type == PERF_ITRACE_PERIOD_NANOSECS)
+			attr.sample_period =
+				intel_pt_ns_to_ticks(pt, pt->synth_opts.period);
+		else
+			attr.sample_period = pt->synth_opts.period;
+		err = intel_pt_synth_event(session, "cycles", &attr, id);
+		if (err)
+			return err;
+		pt->sample_cycles = true;
+		pt->cycles_sample_type = attr.sample_type;
+		pt->cycles_id = id;
+		id += 1;
+	}
+
 	attr.sample_type &= ~(u64)PERF_SAMPLE_PERIOD;
 	attr.sample_period = 1;
 
-- 
2.35.1

