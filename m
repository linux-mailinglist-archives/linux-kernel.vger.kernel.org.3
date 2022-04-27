Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D32E5122D3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbiD0Tg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbiD0Tgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:36:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C8A13D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:33:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6243261A51
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 19:33:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281B4C385A7;
        Wed, 27 Apr 2022 19:33:41 +0000 (UTC)
Date:   Wed, 27 Apr 2022 15:33:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH] ring-buffer: Have absolute time stamps handle large numbers
Message-ID: <20220427153339.16c33f75@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

There's an absolute timestamp event in the ring buffer, but this only
saves 59 bits of the timestamp, as the 5 MSB is used for meta data
(stating it is an absolute time stamp). This was never an issue as all the
clocks currently in use never used those 5 MSB. But now there's a new
clock (TAI) that does.

To handle this case, when reading an absolute timestamp, a previous full
timestamp is passed in, and the 5 MSB of that timestamp is OR'd to the
absolute timestamp (if any of the 5 MSB are set), and then to test for
overflow, if the new result is smaller than the passed in previous
timestamp, then 1 << 59 is added to it.

All the extra processing is done on the reader "slow" path, with the
exception of the "too big delta" check, and the reading of timestamps
for histograms.

Note, libtraceevent will need to be updated to handle this case as well.
But this is not a user space regression, as user space was never able to
handle any timestamps that used more than 59 bits.

Link: https://lore.kernel.org/all/20220426175338.3807ca4f@gandalf.local.home/

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 49 ++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 655d6db3e3c3..3a0c7ed0e93f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -29,6 +29,14 @@
 
 #include <asm/local.h>
 
+/*
+ * The "absolute" timestamp in the buffer is only 59 bits.
+ * If a clock has the 5 MSBs set, it needs to be saved and
+ * reinserted.
+ */
+#define TS_MSB		(0xf8ULL << 56)
+#define ABS_TS_MASK	(~TS_MSB)
+
 static void update_pages_handler(struct work_struct *work);
 
 /*
@@ -783,6 +791,24 @@ static inline void verify_event(struct ring_buffer_per_cpu *cpu_buffer,
 }
 #endif
 
+/*
+ * The absolute time stamp drops the 5 MSBs and some clocks may
+ * require them. The rb_fix_abs_ts() will take a previous full
+ * time stamp, and add the 5 MSB of that time stamp on to the
+ * saved absolute time stamp. Then they are compared in case of
+ * the unlikely event that the latest time stamp incremented
+ * the 5 MSB.
+ */
+static inline u64 rb_fix_abs_ts(u64 abs, u64 save_ts)
+{
+	if (save_ts & TS_MSB) {
+		abs |= save_ts & TS_MSB;
+		/* Check for overflow */
+		if (unlikely(abs < save_ts))
+			abs += 1ULL << 59;
+	}
+	return abs;
+}
 
 static inline u64 rb_time_stamp(struct trace_buffer *buffer);
 
@@ -811,8 +837,10 @@ u64 ring_buffer_event_time_stamp(struct trace_buffer *buffer,
 	u64 ts;
 
 	/* If the event includes an absolute time, then just use that */
-	if (event->type_len == RINGBUF_TYPE_TIME_STAMP)
-		return rb_event_time_stamp(event);
+	if (event->type_len == RINGBUF_TYPE_TIME_STAMP) {
+		ts = rb_event_time_stamp(event);
+		return rb_fix_abs_ts(ts, cpu_buffer->tail_page->page->time_stamp);
+	}
 
 	nest = local_read(&cpu_buffer->committing);
 	verify_event(cpu_buffer, event);
@@ -2754,8 +2782,15 @@ static void rb_add_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
 		(RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE);
 
 	if (unlikely(info->delta > (1ULL << 59))) {
+		/*
+		 * Some timers can use more than 59 bits, and when a timestamp
+		 * is added to the buffer, it will lose those bits.
+		 */
+		if (abs && (info->ts & TS_MSB)) {
+			info->delta &= ABS_TS_MASK;
+
 		/* did the clock go backwards */
-		if (info->before == info->after && info->before > info->ts) {
+		} else if (info->before == info->after && info->before > info->ts) {
 			/* not interrupted */
 			static int once;
 
@@ -3304,7 +3339,7 @@ static void dump_buffer_page(struct buffer_data_page *bpage,
 
 		case RINGBUF_TYPE_TIME_STAMP:
 			delta = rb_event_time_stamp(event);
-			ts = delta;
+			ts = rb_fix_abs_ts(delta, ts);
 			pr_warn("  [%lld] absolute:%lld TIME STAMP\n", ts, delta);
 			break;
 
@@ -3380,7 +3415,7 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 
 		case RINGBUF_TYPE_TIME_STAMP:
 			delta = rb_event_time_stamp(event);
-			ts = delta;
+			ts = rb_fix_abs_ts(delta, ts);
 			break;
 
 		case RINGBUF_TYPE_PADDING:
@@ -4367,6 +4402,7 @@ rb_update_read_stamp(struct ring_buffer_per_cpu *cpu_buffer,
 
 	case RINGBUF_TYPE_TIME_STAMP:
 		delta = rb_event_time_stamp(event);
+		delta = rb_fix_abs_ts(delta, cpu_buffer->read_stamp);
 		cpu_buffer->read_stamp = delta;
 		return;
 
@@ -4397,6 +4433,7 @@ rb_update_iter_read_stamp(struct ring_buffer_iter *iter,
 
 	case RINGBUF_TYPE_TIME_STAMP:
 		delta = rb_event_time_stamp(event);
+		delta = rb_fix_abs_ts(delta, iter->read_stamp);
 		iter->read_stamp = delta;
 		return;
 
@@ -4650,6 +4687,7 @@ rb_buffer_peek(struct ring_buffer_per_cpu *cpu_buffer, u64 *ts,
 	case RINGBUF_TYPE_TIME_STAMP:
 		if (ts) {
 			*ts = rb_event_time_stamp(event);
+			*ts = rb_fix_abs_ts(*ts, reader->page->time_stamp);
 			ring_buffer_normalize_time_stamp(cpu_buffer->buffer,
 							 cpu_buffer->cpu, ts);
 		}
@@ -4741,6 +4779,7 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	case RINGBUF_TYPE_TIME_STAMP:
 		if (ts) {
 			*ts = rb_event_time_stamp(event);
+			*ts = rb_fix_abs_ts(*ts, iter->head_page->page->time_stamp);
 			ring_buffer_normalize_time_stamp(cpu_buffer->buffer,
 							 cpu_buffer->cpu, ts);
 		}
-- 
2.35.1

