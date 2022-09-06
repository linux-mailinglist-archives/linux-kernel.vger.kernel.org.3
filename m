Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175345AE488
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239346AbiIFJlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiIFJle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:41:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F877548F;
        Tue,  6 Sep 2022 02:41:33 -0700 (PDT)
Date:   Tue, 06 Sep 2022 09:41:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662457291;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ITdw/O0XEu8sP5BO0JDZeYMkOXAGyzyfSv87Q2LPBA=;
        b=mQMt9FU7WfrjJocjCiTn6GnZGUQYQj4tGx77HOm2+UgRe1ZwHfM7ljCkBS8XmDSObsbV4o
        LL1PGNZtvYyt6IZsji+QAlHne51ekYQNAccuFX+56o8JazQrdU7Lb8/2ZJV2/KF3mx3GUZ
        vKzlD4Es65OUtpc3cpohOx84NByKkmMygANgp4CWX5zs6Xk0MIEbOs+QO+PbU76vibAw2H
        QXw1q5lS9KhQzGo8vb/KMQi3BOgB5ej36aAD0JCVd9qFjdh7jlAf3xx/eOge1CcKmqYDjM
        5+PRE+5JCimJbr74vmHW+DJTB5JHl1fJZu04/cweoVQBsJ79SRXF4z3QKfU88w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662457291;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ITdw/O0XEu8sP5BO0JDZeYMkOXAGyzyfSv87Q2LPBA=;
        b=9QsOMI9L+Q8Lkh7vqHwOscUdfosDyVTqT7gChwu2AnBXAMAURVOYwntoIiCIBduFdz0hjm
        o971npQQZKgsq3BA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Use sample_flags for data_src
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220901130959.1285717-6-kan.liang@linux.intel.com>
References: <20220901130959.1285717-6-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <166245729021.401.8203777083518863304.tip-bot2@tip-bot2>
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

Commit-ID:     e16fd7f2cb1a65555cfe76f983eaefb1eab7471f
Gitweb:        https://git.kernel.org/tip/e16fd7f2cb1a65555cfe76f983eaefb1eab7471f
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 01 Sep 2022 06:09:58 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Sep 2022 11:33:03 +02:00

perf: Use sample_flags for data_src

Use the new sample_flags to indicate whether the data_src field is
filled by the PMU driver.

Remove the data_src field from the perf_sample_data_init() to minimize
the number of cache lines touched.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220901130959.1285717-6-kan.liang@linux.intel.com
---
 arch/powerpc/perf/core-book3s.c | 4 +++-
 arch/x86/events/intel/ds.c      | 8 ++++++--
 include/linux/perf_event.h      | 3 +--
 kernel/events/core.c            | 3 +++
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index a5c95a2..6ec7069 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2301,8 +2301,10 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 		}
 
 		if (event->attr.sample_type & PERF_SAMPLE_DATA_SRC &&
-						ppmu->get_mem_data_src)
+						ppmu->get_mem_data_src) {
 			ppmu->get_mem_data_src(&data.data_src, ppmu->flags, regs);
+			data.sample_flags |= PERF_SAMPLE_DATA_SRC;
+		}
 
 		if (event->attr.sample_type & PERF_SAMPLE_WEIGHT_TYPE &&
 						ppmu->get_mem_weight) {
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 4c51118..bde73d4 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1535,8 +1535,10 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	/*
 	 * data.data_src encodes the data source
 	 */
-	if (sample_type & PERF_SAMPLE_DATA_SRC)
+	if (sample_type & PERF_SAMPLE_DATA_SRC) {
 		data->data_src.val = get_data_src(event, pebs->dse);
+		data->sample_flags |= PERF_SAMPLE_DATA_SRC;
+	}
 
 	/*
 	 * We must however always use iregs for the unwinder to stay sane; the
@@ -1770,8 +1772,10 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 			data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
 		}
 
-		if (sample_type & PERF_SAMPLE_DATA_SRC)
+		if (sample_type & PERF_SAMPLE_DATA_SRC) {
 			data->data_src.val = get_data_src(event, meminfo->aux);
+			data->sample_flags |= PERF_SAMPLE_DATA_SRC;
+		}
 
 		if (sample_type & PERF_SAMPLE_ADDR_TYPE)
 			data->addr = meminfo->address;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 06a587b..6849f10 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1013,7 +1013,6 @@ struct perf_sample_data {
 	struct perf_raw_record		*raw;
 	u64				period;
 	u64				txn;
-	union  perf_mem_data_src	data_src;
 
 	/*
 	 * The other fields, optionally {set,used} by
@@ -1021,6 +1020,7 @@ struct perf_sample_data {
 	 */
 	struct perf_branch_stack	*br_stack;
 	union perf_sample_weight	weight;
+	union  perf_mem_data_src	data_src;
 
 	u64				type;
 	u64				ip;
@@ -1063,7 +1063,6 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 	data->addr = addr;
 	data->raw  = NULL;
 	data->period = period;
-	data->data_src.val = PERF_MEM_NA;
 	data->txn = 0;
 }
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f0af45d..163e2f4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7411,6 +7411,9 @@ void perf_prepare_sample(struct perf_event_header *header,
 	if (filtered_sample_type & PERF_SAMPLE_WEIGHT_TYPE)
 		data->weight.full = 0;
 
+	if (filtered_sample_type & PERF_SAMPLE_DATA_SRC)
+		data->data_src.val = PERF_MEM_NA;
+
 	if (sample_type & PERF_SAMPLE_REGS_INTR) {
 		/* regs dump ABI info */
 		int size = sizeof(u64);
