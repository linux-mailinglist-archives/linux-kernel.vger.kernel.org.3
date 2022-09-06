Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F05D5AE481
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239443AbiIFJlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiIFJlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:41:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D784B7538A;
        Tue,  6 Sep 2022 02:41:34 -0700 (PDT)
Date:   Tue, 06 Sep 2022 09:41:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662457293;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ckcqLiDdMV5IvfcHK1IP/WTcRMf6Z5JdNgB7tKK5xlM=;
        b=L+my0mwg/BUjN1BqGzLJ86RDVFyBZ4FOJVcNTRYTIeA/eV4U+PCcAl9xY38qI3mv3+D4w1
        7AGrWSsuPpuxCyjmWbeCO8ZQ3Mhg6Ag9ttlaXib0ovoYeGeQYWb/SgNxn7nqAmRBND6fVo
        XyCJHbIcEH9LPp9Nu7RcW3J8g1GpcdL2Bu4GOn5Ij9hzX/NzDaKU97uczuC3pjhNzhLXkf
        v2MtmHEUVQhlx4dgLUwRbmZvswfAqwoK0Iz/f9C92D9td7XiHC9v6RObksZQjjSsXki3Ac
        wT20azW88qD/xb4QGrpo+09ifkZFhDgxqWtNiPdkPEqIqE+hvy8zAgOuJEV9fQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662457293;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ckcqLiDdMV5IvfcHK1IP/WTcRMf6Z5JdNgB7tKK5xlM=;
        b=I693pYytKk3LE4B7tSm4tUpjprkRH6e/juPIZO9uLzq/w1dwCLw0jHMEKeBtjyZjxKigrL
        yx4kDjdpvtyF4kDg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Use sample_flags for branch stack
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220901130959.1285717-4-kan.liang@linux.intel.com>
References: <20220901130959.1285717-4-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <166245729233.401.5650973021670107932.tip-bot2@tip-bot2>
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

Commit-ID:     a9a931e2666878343782c82d7d55cc173ddeb3e9
Gitweb:        https://git.kernel.org/tip/a9a931e2666878343782c82d7d55cc173ddeb3e9
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 01 Sep 2022 06:09:56 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Sep 2022 11:33:02 +02:00

perf: Use sample_flags for branch stack

Use the new sample_flags to indicate whether the branch stack is filled
by the PMU driver.

Remove the br_stack from the perf_sample_data_init() to minimize the number
of cache lines touched.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220901130959.1285717-4-kan.liang@linux.intel.com
---
 arch/powerpc/perf/core-book3s.c | 1 +
 arch/x86/events/amd/core.c      | 4 +++-
 arch/x86/events/core.c          | 4 +++-
 arch/x86/events/intel/core.c    | 4 +++-
 arch/x86/events/intel/ds.c      | 5 ++++-
 include/linux/perf_event.h      | 4 ++--
 kernel/events/core.c            | 4 ++--
 7 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 13919eb..1ad1efd 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2297,6 +2297,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 			cpuhw = this_cpu_ptr(&cpu_hw_events);
 			power_pmu_bhrb_read(event, cpuhw);
 			data.br_stack = &cpuhw->bhrb_stack;
+			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
 		}
 
 		if (event->attr.sample_type & PERF_SAMPLE_DATA_SRC &&
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 36bede1..bd99d2a 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -929,8 +929,10 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 		if (!x86_perf_event_set_period(event))
 			continue;
 
-		if (has_branch_stack(event))
+		if (has_branch_stack(event)) {
 			data.br_stack = &cpuc->lbr_stack;
+			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
+		}
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f969410..bb34a28 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1714,8 +1714,10 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
-		if (has_branch_stack(event))
+		if (has_branch_stack(event)) {
 			data.br_stack = &cpuc->lbr_stack;
+			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
+		}
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2db9349..ba101c2 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2995,8 +2995,10 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
-		if (has_branch_stack(event))
+		if (has_branch_stack(event)) {
 			data.br_stack = &cpuc->lbr_stack;
+			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
+		}
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index cdd857b..0489f75 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1640,8 +1640,10 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 		data->sample_flags |= PERF_SAMPLE_TIME;
 	}
 
-	if (has_branch_stack(event))
+	if (has_branch_stack(event)) {
 		data->br_stack = &cpuc->lbr_stack;
+		data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
+	}
 }
 
 static void adaptive_pebs_save_regs(struct pt_regs *regs,
@@ -1791,6 +1793,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		if (has_branch_stack(event)) {
 			intel_pmu_store_pebs_lbrs(lbr);
 			data->br_stack = &cpuc->lbr_stack;
+			data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
 		}
 	}
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0978165..1e12e79 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1011,7 +1011,6 @@ struct perf_sample_data {
 	u64				sample_flags;
 	u64				addr;
 	struct perf_raw_record		*raw;
-	struct perf_branch_stack	*br_stack;
 	u64				period;
 	union perf_sample_weight	weight;
 	u64				txn;
@@ -1021,6 +1020,8 @@ struct perf_sample_data {
 	 * The other fields, optionally {set,used} by
 	 * perf_{prepare,output}_sample().
 	 */
+	struct perf_branch_stack	*br_stack;
+
 	u64				type;
 	u64				ip;
 	struct {
@@ -1061,7 +1062,6 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 	data->sample_flags = 0;
 	data->addr = addr;
 	data->raw  = NULL;
-	data->br_stack = NULL;
 	data->period = period;
 	data->weight.full = 0;
 	data->data_src.val = PERF_MEM_NA;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c9b9cb7..104c0c9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7052,7 +7052,7 @@ void perf_output_sample(struct perf_output_handle *handle,
 	}
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
-		if (data->br_stack) {
+		if (data->sample_flags & PERF_SAMPLE_BRANCH_STACK) {
 			size_t size;
 
 			size = data->br_stack->nr
@@ -7358,7 +7358,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
 		int size = sizeof(u64); /* nr */
-		if (data->br_stack) {
+		if (data->sample_flags & PERF_SAMPLE_BRANCH_STACK) {
 			if (perf_sample_save_hw_index(event))
 				size += sizeof(u64);
 
