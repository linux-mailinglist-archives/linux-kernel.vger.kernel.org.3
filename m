Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7870358ABB8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 15:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240840AbiHENhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 09:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240861AbiHENhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 09:37:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794961AD92
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 06:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659706620; x=1691242620;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cYx8WEbufGc2kIoF+g8WEsSpIhTPOn9T8tPs3QjTGcw=;
  b=PAaWiVrgl5KV/yZ7nv6eoPTunwKpcmgda5+6a31N22NgS1Qzk0yNJCiv
   vOL3IlJSt9YHs0TYnw43joB8/TnXLFIssn0IM27xu+ZqjHBwn2OgaWD8x
   GeEmTly4huZKx7XTHz3BWU6CFZzoOS0nN7NHOBtm648B8lZ+n+pqORGvN
   TV7E30h+e90qLMa2F9RvAsxEpiQyQhJOxGvadbir9glozcNqT+RTLsp2+
   K6ZPcVFrThBskVDDv/Ntc911mZ0xDMPcwCeDtKR4x8/Fgc64ZY7qmoHRV
   h8Owr/ZNJTfliqAFlPp2bEmWaoJI2s1U3OFhnOnQYifzGjetwLD1af034
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="290974289"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="290974289"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 06:36:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="607129633"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 05 Aug 2022 06:36:39 -0700
Received: from [10.252.214.183] (kliang2-mobl1.ccr.corp.intel.com [10.252.214.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 72925580AE2;
        Fri,  5 Aug 2022 06:36:38 -0700 (PDT)
Message-ID: <4fdaeb87-7f0a-78e0-2952-3035a3776198@linux.intel.com>
Date:   Fri, 5 Aug 2022 09:36:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [BUG] perf/x86/intel/pebs: PEBS timestamps overwritten
To:     Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Liang, Kan" <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>, andreas.kogler.0x@gmail.com
References: <CABPqkBTqQaaYH+ySu3reLm5i+X6P4BsqKycp8NBOP1gW3ZV4QA@mail.gmail.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CABPqkBTqQaaYH+ySu3reLm5i+X6P4BsqKycp8NBOP1gW3ZV4QA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-08-05 6:49 a.m., Stephane Eranian wrote:
> Hi,
> 
> I was alerted by an internal user that the PEBS TSC-based timestamps
> do not appear
> correctly in the final perf.data output file from perf record.
> 
> After some investigation, I came to the conclusion that indeed the
> data->time field setup
> by PEBS in the setup_pebs_fixed_sample_data() is later overwritten by
> perf_events generic
> code in perf_prepare_sample(). There is an ordering problem here.
> 
> Looking around we found that this problem had been uncovered back in
> May 2020 and a
> patch had been posted then:
> https://lore.kernel.org/lkml/e754b625-bf14-8f5f-bd1a-71d774057005@gmail.com/T/
> 
> However this patch was never commented upon or committed.
> 
> The problem is still present in the upstream code today.
> 
> 1. perf_sample_data_init()
> 2. setup_pebs_fixed_sample_data(): data->time =
> native_sched_clock_from_tsc(pebs->tsc);
> 3. perf_prepare_sample(): data->time = perf_event_clock(event);
> 
> The patch from 2020 (Andreas Kogler) fixes the problem by making the
> assignment in 3.
> conditioned to the value of data->time being 0. Andreas also suggested
> an alternative which
> would break up the call to perf_event_ouput() like this is done in the
> BTS code allowing
> the prepare_sample() call to be made before PEBS samples are
> extracted. That would
> generate some code duplication. Although this approach appears more
> robust, the one
> issue I see is that prepare_sample may need data that would be filled
> by PEBS and
> therefore it would  need to be called afterwards.
> 
> Any better ideas?

I think Andreas's patch is the most straightforward and simplest patch
to fix the issue. But, if I recall correctly, Peter prefers to minimize
the cachelines touched by the perf_sample_data_init(). So initializing
the data->time in the perf_sample_data_init() seems break the rule.

I think HW will provide more and more such kind of precise information.
Maybe we can use a flag variable to track whether the information is
already provided to avoid the overwritten.

Here are the two patches (Not test yet). The first one is to fix the
timestamp issue. The second one is to use the flag to replace
data->br_stack = NULL; as an examples. I think we can further move other
variables out of the perf_sample_data_init() to minimize the cachelines
touched by the perf_sample_data_init().


From a46c2e17597717090013d390b6d64f51a69b4ea0 Mon Sep 17 00:00:00 2001
From: Kan Liang <kan.liang@linux.intel.com>
Date: Fri, 5 Aug 2022 06:01:15 -0700
Subject: [PATCH 1/2] perf: Avoid overwriting precise timestamp

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 8 ++++++--
 include/linux/perf_event.h | 3 +++
 kernel/events/core.c       | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 34be3bc5151a..a2c26eaeb0d9 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1687,8 +1687,10 @@ static void setup_pebs_fixed_sample_data(struct
perf_event *event,
 	 * We can only do this for the default trace clock.
 	 */
 	if (x86_pmu.intel_cap.pebs_format >= 3 &&
-		event->attr.use_clockid == 0)
+		event->attr.use_clockid == 0) {
 		data->time = native_sched_clock_from_tsc(pebs->tsc);
+		data->flags |= PERF_SAMPLE_DATA_TIME;
+	}

 	if (has_branch_stack(event))
 		data->br_stack = &cpuc->lbr_stack;
@@ -1750,8 +1752,10 @@ static void
setup_pebs_adaptive_sample_data(struct perf_event *event,
 	perf_sample_data_init(data, 0, event->hw.last_period);
 	data->period = event->hw.last_period;

-	if (event->attr.use_clockid == 0)
+	if (event->attr.use_clockid == 0) {
 		data->time = native_sched_clock_from_tsc(basic->tsc);
+		data->flags |= PERF_SAMPLE_DATA_TIME;
+	}

 	/*
 	 * We must however always use iregs for the unwinder to stay sane; the
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index da759560eec5..33054bf31fc1 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -999,6 +999,7 @@ int perf_event_read_local(struct perf_event *event,
u64 *value,
 extern u64 perf_event_read_value(struct perf_event *event,
 				 u64 *enabled, u64 *running);

+#define PERF_SAMPLE_DATA_TIME		0x1

 struct perf_sample_data {
 	/*
@@ -1012,6 +1013,7 @@ struct perf_sample_data {
 	union perf_sample_weight	weight;
 	u64				txn;
 	union  perf_mem_data_src	data_src;
+	u64				flags;

 	/*
 	 * The other fields, optionally {set,used} by
@@ -1061,6 +1063,7 @@ static inline void perf_sample_data_init(struct
perf_sample_data *data,
 	data->weight.full = 0;
 	data->data_src.val = PERF_MEM_NA;
 	data->txn = 0;
+	data->flags = 0;
 }

 /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 65e0bcba2e21..057c197ae106 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6799,7 +6799,7 @@ static void __perf_event_header__init_id(struct
perf_event_header *header,
 		data->tid_entry.tid = perf_event_tid(event, current);
 	}

-	if (sample_type & PERF_SAMPLE_TIME)
+	if ((sample_type & PERF_SAMPLE_TIME) && !(data->flags &
PERF_SAMPLE_DATA_TIME))
 		data->time = perf_event_clock(event);

 	if (sample_type & (PERF_SAMPLE_ID | PERF_SAMPLE_IDENTIFIER))
-- 
2.35.1




The patch as below use a new flag to track the availability of the br_stack.



From c384353e17e200781145557cd5395c3f8adde6f9 Mon Sep 17 00:00:00 2001
From: Kan Liang <kan.liang@linux.intel.com>
Date: Fri, 5 Aug 2022 06:12:41 -0700
Subject: [PATCH 2/2] perf: Add perf sample data flag for br_stack

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 5 ++++-
 include/linux/perf_event.h | 5 +++--
 kernel/events/core.c       | 4 ++--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index a2c26eaeb0d9..27c440c13bfd 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1692,8 +1692,10 @@ static void setup_pebs_fixed_sample_data(struct
perf_event *event,
 		data->flags |= PERF_SAMPLE_DATA_TIME;
 	}

-	if (has_branch_stack(event))
+	if (has_branch_stack(event)) {
 		data->br_stack = &cpuc->lbr_stack;
+		data->flags |= PERF_SAMPLE_DATA_BR_STACK;
+	}
 }

 static void adaptive_pebs_save_regs(struct pt_regs *regs,
@@ -1847,6 +1849,7 @@ static void setup_pebs_adaptive_sample_data(struct
perf_event *event,
 		if (has_branch_stack(event)) {
 			intel_pmu_store_pebs_lbrs(lbr);
 			data->br_stack = &cpuc->lbr_stack;
+			data->flags |= PERF_SAMPLE_DATA_BR_STACK;
 		}
 	}

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 33054bf31fc1..8c4a2913ec58 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1000,6 +1000,7 @@ extern u64 perf_event_read_value(struct perf_event
*event,
 				 u64 *enabled, u64 *running);

 #define PERF_SAMPLE_DATA_TIME		0x1
+#define PERF_SAMPLE_DATA_BR_STACK	0x2

 struct perf_sample_data {
 	/*
@@ -1008,7 +1009,6 @@ struct perf_sample_data {
 	 */
 	u64				addr;
 	struct perf_raw_record		*raw;
-	struct perf_branch_stack	*br_stack;
 	u64				period;
 	union perf_sample_weight	weight;
 	u64				txn;
@@ -1019,6 +1019,8 @@ struct perf_sample_data {
 	 * The other fields, optionally {set,used} by
 	 * perf_{prepare,output}_sample().
 	 */
+	struct perf_branch_stack	*br_stack;
+
 	u64				type;
 	u64				ip;
 	struct {
@@ -1058,7 +1060,6 @@ static inline void perf_sample_data_init(struct
perf_sample_data *data,
 	/* remaining struct members initialized in perf_prepare_sample() */
 	data->addr = addr;
 	data->raw  = NULL;
-	data->br_stack = NULL;
 	data->period = period;
 	data->weight.full = 0;
 	data->data_src.val = PERF_MEM_NA;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 057c197ae106..cd19ce85ef59 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7039,7 +7039,7 @@ void perf_output_sample(struct perf_output_handle
*handle,
 	}

 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
-		if (data->br_stack) {
+		if (data->flags & PERF_SAMPLE_DATA_BR_STACK) {
 			size_t size;

 			size = data->br_stack->nr
@@ -7339,7 +7339,7 @@ void perf_prepare_sample(struct perf_event_header
*header,

 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
 		int size = sizeof(u64); /* nr */
-		if (data->br_stack) {
+		if (data->flags & PERF_SAMPLE_DATA_BR_STACK) {
 			if (perf_sample_save_hw_index(event))
 				size += sizeof(u64);

-- 
2.35.1


Thanks,
Kan
