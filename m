Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E595AE486
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbiIFJlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbiIFJle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:41:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F427538A;
        Tue,  6 Sep 2022 02:41:32 -0700 (PDT)
Date:   Tue, 06 Sep 2022 09:41:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662457290;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=74OyvidmN9+oi6pdkOajSJGHunp0IvnXC2FF+xQ1V8I=;
        b=devkIU7P+LJEyMAXIb2M/BNCvPF4o1MSQHpfTk+o/q8F0enK7NQKjtoK7AWZMtUHQyicwe
        rMFRnh417jAB/B+VDwjH89s31jfVn5VVrF/FiCvrfWQWxhapzN6bOYnI8X6DI29R1NJ3Ki
        5kEHour8rhtPxULkw/fL/Y02jq1MoJPE0c2Z4i5qsvYGr3yGO4Uyni/VmdhqbH3jK54tA9
        ob8psWooFUcELvlcNgWJkS7RyDUPJn3pKoD3BtwKhmMaN4iuqWJAa508wjvnte64y7PPao
        A6hf8H9BDOF4UHoaOQyMDLfodAndoRP32RHf+u+HnpDRAdFtVW91WkNPF0rwXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662457290;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=74OyvidmN9+oi6pdkOajSJGHunp0IvnXC2FF+xQ1V8I=;
        b=asrjzbLAlFwakZ2vYnY+GFzUdXc8v9A+IDE5vsHFw+E+FMmql4KBB2d2VZxVyK9D6Kokhn
        wri1A1mI8UEF5WCw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Use sample_flags for txn
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220901130959.1285717-7-kan.liang@linux.intel.com>
References: <20220901130959.1285717-7-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <166245728904.401.8050095818158375126.tip-bot2@tip-bot2>
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

Commit-ID:     ee9db0e14b0575aa827579dc2471a29ec5fc6877
Gitweb:        https://git.kernel.org/tip/ee9db0e14b0575aa827579dc2471a29ec5fc6877
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 01 Sep 2022 06:09:59 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Sep 2022 11:33:03 +02:00

perf: Use sample_flags for txn

Use the new sample_flags to indicate whether the txn field is filled by
the PMU driver.

Remove the txn field from the perf_sample_data_init() to minimize the
number of cache lines touched.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220901130959.1285717-7-kan.liang@linux.intel.com
---
 arch/x86/events/intel/ds.c | 8 ++++++--
 include/linux/perf_event.h | 3 +--
 kernel/events/core.c       | 3 +++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index bde73d4..a5275c2 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1628,9 +1628,11 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 			data->weight.full = intel_get_tsx_weight(pebs->tsx_tuning);
 			data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
 		}
-		if (sample_type & PERF_SAMPLE_TRANSACTION)
+		if (sample_type & PERF_SAMPLE_TRANSACTION) {
 			data->txn = intel_get_tsx_transaction(pebs->tsx_tuning,
 							      pebs->ax);
+			data->sample_flags |= PERF_SAMPLE_TRANSACTION;
+		}
 	}
 
 	/*
@@ -1780,9 +1782,11 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		if (sample_type & PERF_SAMPLE_ADDR_TYPE)
 			data->addr = meminfo->address;
 
-		if (sample_type & PERF_SAMPLE_TRANSACTION)
+		if (sample_type & PERF_SAMPLE_TRANSACTION) {
 			data->txn = intel_get_tsx_transaction(meminfo->tsx_tuning,
 							  gprs ? gprs->ax : 0);
+			data->sample_flags |= PERF_SAMPLE_TRANSACTION;
+		}
 	}
 
 	if (format_size & PEBS_DATACFG_XMMS) {
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 6849f10..581880d 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1012,7 +1012,6 @@ struct perf_sample_data {
 	u64				addr;
 	struct perf_raw_record		*raw;
 	u64				period;
-	u64				txn;
 
 	/*
 	 * The other fields, optionally {set,used} by
@@ -1021,6 +1020,7 @@ struct perf_sample_data {
 	struct perf_branch_stack	*br_stack;
 	union perf_sample_weight	weight;
 	union  perf_mem_data_src	data_src;
+	u64				txn;
 
 	u64				type;
 	u64				ip;
@@ -1063,7 +1063,6 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 	data->addr = addr;
 	data->raw  = NULL;
 	data->period = period;
-	data->txn = 0;
 }
 
 /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 163e2f4..15d27b1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7414,6 +7414,9 @@ void perf_prepare_sample(struct perf_event_header *header,
 	if (filtered_sample_type & PERF_SAMPLE_DATA_SRC)
 		data->data_src.val = PERF_MEM_NA;
 
+	if (filtered_sample_type & PERF_SAMPLE_TRANSACTION)
+		data->txn = 0;
+
 	if (sample_type & PERF_SAMPLE_REGS_INTR) {
 		/* regs dump ABI info */
 		int size = sizeof(u64);
