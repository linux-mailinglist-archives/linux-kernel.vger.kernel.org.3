Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4435AE485
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbiIFJls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238987AbiIFJlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:41:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1332754A3;
        Tue,  6 Sep 2022 02:41:33 -0700 (PDT)
Date:   Tue, 06 Sep 2022 09:41:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662457292;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Gl3zcThSXEHpQBvPhLpT1lJeXvGRMytsmX5MUkgI6k=;
        b=WNPZzMuS8V7MEuTp8T016Dk8+O2sEXSCztoqlVDebvWyaJzXNsEDv/hMOU3yH0DKGtXrEh
        Vbj5Du0aTG0PEwBkitoclpOyt8SRHo7yZZxQ+rjuMHiSiPkFZtTgwbv02+fgWCpW479TSZ
        NLlS8t8sWvp3qrg3y9NMgPUlzSue0GnGJax/J9m5VtzI8taPdz2oaac2TSFsPi3SUij2RO
        7yKir+vZPg5LRJnowE+/AoamX35nJlDXP5cMDoTTCfDU1GsTOuc4uQ+lKDoSLEycjtM5Lc
        3uV/A4f5qywC7Gb5eP+9XBn9XqHaRmRikAYgp8+ipq5Ot6LjCF9Rb4Tl+QjATg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662457292;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Gl3zcThSXEHpQBvPhLpT1lJeXvGRMytsmX5MUkgI6k=;
        b=aXbrnd+rHPnlaAZIZw/1XeUDCLZhEOhBX9fV7/GqhzRadbu5EkdIHEl+uBrtevoLGHCCnw
        d3lQpVFX5rw/GcAg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Use sample_flags for weight
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220901130959.1285717-5-kan.liang@linux.intel.com>
References: <20220901130959.1285717-5-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <166245729123.401.13200182862800639132.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2abe681da0a192ab850a5271d838a7817b469fca
Gitweb:        https://git.kernel.org/tip/2abe681da0a192ab850a5271d838a7817b469fca
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 01 Sep 2022 06:09:57 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Sep 2022 11:33:02 +02:00

perf: Use sample_flags for weight

Use the new sample_flags to indicate whether the weight field is filled
by the PMU driver.

Remove the weight field from the perf_sample_data_init() to minimize the
number of cache lines touched.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220901130959.1285717-5-kan.liang@linux.intel.com
---
 arch/powerpc/perf/core-book3s.c |  5 +++--
 arch/x86/events/intel/ds.c      | 10 +++++++---
 include/linux/perf_event.h      |  3 +--
 kernel/events/core.c            |  3 +++
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 1ad1efd..a5c95a2 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2305,9 +2305,10 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 			ppmu->get_mem_data_src(&data.data_src, ppmu->flags, regs);
 
 		if (event->attr.sample_type & PERF_SAMPLE_WEIGHT_TYPE &&
-						ppmu->get_mem_weight)
+						ppmu->get_mem_weight) {
 			ppmu->get_mem_weight(&data.weight.full, event->attr.sample_type);
-
+			data.sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
+		}
 		if (perf_event_overflow(event, &data, regs))
 			power_pmu_stop(event, 0);
 	} else if (period) {
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 0489f75..4c51118 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1527,8 +1527,10 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	/*
 	 * Use latency for weight (only avail with PEBS-LL)
 	 */
-	if (fll && (sample_type & PERF_SAMPLE_WEIGHT_TYPE))
+	if (fll && (sample_type & PERF_SAMPLE_WEIGHT_TYPE)) {
 		data->weight.full = pebs->lat;
+		data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
+	}
 
 	/*
 	 * data.data_src encodes the data source
@@ -1620,9 +1622,10 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 
 	if (x86_pmu.intel_cap.pebs_format >= 2) {
 		/* Only set the TSX weight when no memory weight. */
-		if ((sample_type & PERF_SAMPLE_WEIGHT_TYPE) && !fll)
+		if ((sample_type & PERF_SAMPLE_WEIGHT_TYPE) && !fll) {
 			data->weight.full = intel_get_tsx_weight(pebs->tsx_tuning);
-
+			data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
+		}
 		if (sample_type & PERF_SAMPLE_TRANSACTION)
 			data->txn = intel_get_tsx_transaction(pebs->tsx_tuning,
 							      pebs->ax);
@@ -1764,6 +1767,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 				data->weight.var1_dw = (u32)(weight & PEBS_LATENCY_MASK) ?:
 					intel_get_tsx_weight(meminfo->tsx_tuning);
 			}
+			data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
 		}
 
 		if (sample_type & PERF_SAMPLE_DATA_SRC)
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1e12e79..06a587b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1012,7 +1012,6 @@ struct perf_sample_data {
 	u64				addr;
 	struct perf_raw_record		*raw;
 	u64				period;
-	union perf_sample_weight	weight;
 	u64				txn;
 	union  perf_mem_data_src	data_src;
 
@@ -1021,6 +1020,7 @@ struct perf_sample_data {
 	 * perf_{prepare,output}_sample().
 	 */
 	struct perf_branch_stack	*br_stack;
+	union perf_sample_weight	weight;
 
 	u64				type;
 	u64				ip;
@@ -1063,7 +1063,6 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 	data->addr = addr;
 	data->raw  = NULL;
 	data->period = period;
-	data->weight.full = 0;
 	data->data_src.val = PERF_MEM_NA;
 	data->txn = 0;
 }
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 104c0c9..f0af45d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7408,6 +7408,9 @@ void perf_prepare_sample(struct perf_event_header *header,
 		header->size += size;
 	}
 
+	if (filtered_sample_type & PERF_SAMPLE_WEIGHT_TYPE)
+		data->weight.full = 0;
+
 	if (sample_type & PERF_SAMPLE_REGS_INTR) {
 		/* regs dump ABI info */
 		int size = sizeof(u64);
