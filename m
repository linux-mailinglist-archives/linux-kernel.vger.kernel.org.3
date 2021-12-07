Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108FD46C6E5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242098AbhLGVsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241973AbhLGVsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:48:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7901BC061756
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 13:44:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D0A4B81E7F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 21:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B58BC341E5;
        Tue,  7 Dec 2021 21:44:31 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1muiGE-000Hz5-Hs;
        Tue, 07 Dec 2021 16:44:30 -0500
Message-ID: <20211207214430.388444208@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 07 Dec 2021 16:44:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 08/13] tracing: Disable preemption when using the filter buffer
References: <20211207214406.148423650@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

In case trace_event_buffer_lock_reserve() is called with preemption
enabled, the algorithm that defines the usage of the per cpu filter buffer
may fail if the task schedules to another CPU after determining which
buffer it will use.

Disable preemption when using the filter buffer. And because that same
buffer must be used throughout the call, keep preemption disabled until
the filter buffer is released.

This will also keep the semantics between the use case of when the filter
buffer is used, and when the ring buffer itself is used, as that case also
disables preemption until the ring buffer is released.

Link: https://lkml.kernel.org/r/20211130024318.880190623@goodmis.org

[ Fixed warning of assignment in if statement
  Reported-by: kernel test robot <lkp@intel.com> ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 59 +++++++++++++++++++++++++-------------------
 kernel/trace/trace.h |  4 ++-
 2 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2e87b7bf2ba7..e3b8c906b7b4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -980,6 +980,8 @@ __buffer_unlock_commit(struct trace_buffer *buffer, struct ring_buffer_event *ev
 		ring_buffer_write(buffer, event->array[0], &event->array[1]);
 		/* Release the temp buffer */
 		this_cpu_dec(trace_buffered_event_cnt);
+		/* ring_buffer_unlock_commit() enables preemption */
+		preempt_enable_notrace();
 	} else
 		ring_buffer_unlock_commit(buffer, event);
 }
@@ -2745,8 +2747,8 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
 	*current_rb = tr->array_buffer.buffer;
 
 	if (!tr->no_filter_buffering_ref &&
-	    (trace_file->flags & (EVENT_FILE_FL_SOFT_DISABLED | EVENT_FILE_FL_FILTERED)) &&
-	    (entry = __this_cpu_read(trace_buffered_event))) {
+	    (trace_file->flags & (EVENT_FILE_FL_SOFT_DISABLED | EVENT_FILE_FL_FILTERED))) {
+		preempt_disable_notrace();
 		/*
 		 * Filtering is on, so try to use the per cpu buffer first.
 		 * This buffer will simulate a ring_buffer_event,
@@ -2764,33 +2766,38 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
 		 * is still quicker than no copy on match, but having
 		 * to discard out of the ring buffer on a failed match.
 		 */
-		int max_len = PAGE_SIZE - struct_size(entry, array, 1);
+		if ((entry = __this_cpu_read(trace_buffered_event))) {
+			int max_len = PAGE_SIZE - struct_size(entry, array, 1);
 
-		val = this_cpu_inc_return(trace_buffered_event_cnt);
+			val = this_cpu_inc_return(trace_buffered_event_cnt);
 
-		/*
-		 * Preemption is disabled, but interrupts and NMIs
-		 * can still come in now. If that happens after
-		 * the above increment, then it will have to go
-		 * back to the old method of allocating the event
-		 * on the ring buffer, and if the filter fails, it
-		 * will have to call ring_buffer_discard_commit()
-		 * to remove it.
-		 *
-		 * Need to also check the unlikely case that the
-		 * length is bigger than the temp buffer size.
-		 * If that happens, then the reserve is pretty much
-		 * guaranteed to fail, as the ring buffer currently
-		 * only allows events less than a page. But that may
-		 * change in the future, so let the ring buffer reserve
-		 * handle the failure in that case.
-		 */
-		if (val == 1 && likely(len <= max_len)) {
-			trace_event_setup(entry, type, trace_ctx);
-			entry->array[0] = len;
-			return entry;
+			/*
+			 * Preemption is disabled, but interrupts and NMIs
+			 * can still come in now. If that happens after
+			 * the above increment, then it will have to go
+			 * back to the old method of allocating the event
+			 * on the ring buffer, and if the filter fails, it
+			 * will have to call ring_buffer_discard_commit()
+			 * to remove it.
+			 *
+			 * Need to also check the unlikely case that the
+			 * length is bigger than the temp buffer size.
+			 * If that happens, then the reserve is pretty much
+			 * guaranteed to fail, as the ring buffer currently
+			 * only allows events less than a page. But that may
+			 * change in the future, so let the ring buffer reserve
+			 * handle the failure in that case.
+			 */
+			if (val == 1 && likely(len <= max_len)) {
+				trace_event_setup(entry, type, trace_ctx);
+				entry->array[0] = len;
+				/* Return with preemption disabled */
+				return entry;
+			}
+			this_cpu_dec(trace_buffered_event_cnt);
 		}
-		this_cpu_dec(trace_buffered_event_cnt);
+		/* __trace_buffer_lock_reserve() disables preemption */
+		preempt_enable_notrace();
 	}
 
 	entry = __trace_buffer_lock_reserve(*current_rb, type, len,
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 7162157b970b..8bd1a815ce90 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1337,10 +1337,12 @@ __trace_event_discard_commit(struct trace_buffer *buffer,
 			     struct ring_buffer_event *event)
 {
 	if (this_cpu_read(trace_buffered_event) == event) {
-		/* Simply release the temp buffer */
+		/* Simply release the temp buffer and enable preemption */
 		this_cpu_dec(trace_buffered_event_cnt);
+		preempt_enable_notrace();
 		return;
 	}
+	/* ring_buffer_discard_commit() enables preemption */
 	ring_buffer_discard_commit(buffer, event);
 }
 
-- 
2.33.0
