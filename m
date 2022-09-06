Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC6E5AE483
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbiIFJmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238808AbiIFJli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:41:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E5E7548B;
        Tue,  6 Sep 2022 02:41:37 -0700 (PDT)
Date:   Tue, 06 Sep 2022 09:41:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662457295;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QxBtKZImDVSiLRUEyCfb0h8S+fixhSTXGWu2oQYrWbs=;
        b=louzQiWDj6LbTkVu+C7FTmd8t5afRE4fxQar+SlolfAudHrZdN+i2qO62R/ScfUFU5Eg1L
        eYQS4pyy/2EivR7tQvdlVqG7fCvcHhMu6hbbGlgar0o91RyFkRe/uQU+dmU2qIn5zftzH9
        Qz1VeXRiLURftQc/961seAN9e6t3Kq1rHxl8WDItoeMmanlAtdRdGZk/ehSinOumvFu842
        VBh2DhbhqsIWR727pirFxNpJAC8xjpjn1yV7DeB2NTL/AQCeSIT7CsnZDeYrVAaZzDimO2
        jV2ekmm3M/qQz+/Pwm893JeAFeFkeXy8Eiu0u8GkD3Z93SUUQpoSHTJ8bLsKZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662457295;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QxBtKZImDVSiLRUEyCfb0h8S+fixhSTXGWu2oQYrWbs=;
        b=jGPzCWmO7rkupzb9bu4uZqMn0KPmtPpwkiuEykFHQHpmkjXewVaL8GKOBYbq+fxHIT3iL9
        ZyhBSWw0hfOPVyCQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Add sample_flags to indicate the PMU-filled
 sample data
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220901130959.1285717-2-kan.liang@linux.intel.com>
References: <20220901130959.1285717-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <166245729447.401.11991256046190321886.tip-bot2@tip-bot2>
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

Commit-ID:     3aac580d5cc3001ca1627725b3b61edb529f341d
Gitweb:        https://git.kernel.org/tip/3aac580d5cc3001ca1627725b3b61edb529f341d
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 01 Sep 2022 06:09:54 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Sep 2022 11:33:01 +02:00

perf: Add sample_flags to indicate the PMU-filled sample data

On some platforms, some data e.g., timestamps, can be retrieved from
the PMU driver. Usually, the data from the PMU driver is more accurate.
The current perf kernel should output the PMU-filled sample data if
it's available.

To check the availability of the PMU-filled sample data, the current
perf kernel initializes the related fields in the
perf_sample_data_init(). When outputting a sample, the perf checks
whether the field is updated by the PMU driver. If yes, the updated
value will be output. If not, the perf uses an SW way to calculate the
value or just outputs the initialized value if an SW way is unavailable
either.

With more and more data being provided by the PMU driver, more fields
has to be initialized in the perf_sample_data_init(). That will
increase the number of cache lines touched in perf_sample_data_init()
and be harmful to the performance.

Add new "sample_flags" to indicate the PMU-filled sample data. The PMU
driver should set the corresponding PERF_SAMPLE_ flag when the field is
updated. The initialization of the corresponding field is not required
anymore. The following patches will make use of it and remove the
corresponding fields from the perf_sample_data_init(), which will
further minimize the number of cache lines touched.

Only clear the sample flags that have already been done by the PMU
driver in the perf_prepare_sample() for the PERF_RECORD_SAMPLE. For the
other PERF_RECORD_ event type, the sample data is not available.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220901130959.1285717-2-kan.liang@linux.intel.com
---
 include/linux/perf_event.h |  2 ++
 kernel/events/core.c       | 17 +++++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1999408..0978165 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1008,6 +1008,7 @@ struct perf_sample_data {
 	 * Fields set by perf_sample_data_init(), group so as to
 	 * minimize the cachelines touched.
 	 */
+	u64				sample_flags;
 	u64				addr;
 	struct perf_raw_record		*raw;
 	struct perf_branch_stack	*br_stack;
@@ -1057,6 +1058,7 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 					 u64 addr, u64 period)
 {
 	/* remaining struct members initialized in perf_prepare_sample() */
+	data->sample_flags = 0;
 	data->addr = addr;
 	data->raw  = NULL;
 	data->br_stack = NULL;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2621fd2..c9b9cb7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6794,11 +6794,10 @@ out_put:
 
 static void __perf_event_header__init_id(struct perf_event_header *header,
 					 struct perf_sample_data *data,
-					 struct perf_event *event)
+					 struct perf_event *event,
+					 u64 sample_type)
 {
-	u64 sample_type = event->attr.sample_type;
-
-	data->type = sample_type;
+	data->type = event->attr.sample_type;
 	header->size += event->id_header_size;
 
 	if (sample_type & PERF_SAMPLE_TID) {
@@ -6827,7 +6826,7 @@ void perf_event_header__init_id(struct perf_event_header *header,
 				struct perf_event *event)
 {
 	if (event->attr.sample_id_all)
-		__perf_event_header__init_id(header, data, event);
+		__perf_event_header__init_id(header, data, event, event->attr.sample_type);
 }
 
 static void __perf_event__output_id_sample(struct perf_output_handle *handle,
@@ -7303,6 +7302,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 			 struct pt_regs *regs)
 {
 	u64 sample_type = event->attr.sample_type;
+	u64 filtered_sample_type;
 
 	header->type = PERF_RECORD_SAMPLE;
 	header->size = sizeof(*header) + event->header_size;
@@ -7310,7 +7310,12 @@ void perf_prepare_sample(struct perf_event_header *header,
 	header->misc = 0;
 	header->misc |= perf_misc_flags(regs);
 
-	__perf_event_header__init_id(header, data, event);
+	/*
+	 * Clear the sample flags that have already been done by the
+	 * PMU driver.
+	 */
+	filtered_sample_type = sample_type & ~data->sample_flags;
+	__perf_event_header__init_id(header, data, event, filtered_sample_type);
 
 	if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE))
 		data->ip = perf_instruction_pointer(regs);
