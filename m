Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A88A512457
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 23:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbiD0VLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 17:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbiD0VL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 17:11:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213E5D87
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 14:08:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEFA3B82AD2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 21:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9638C385A9;
        Wed, 27 Apr 2022 21:08:13 +0000 (UTC)
Date:   Wed, 27 Apr 2022 17:08:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH] ring-buffer: Have 32 bit time stamps use all 64 bits
Message-ID: <20220427170812.53cc7139@gandalf.local.home>
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

When the new logic was made to handle deltas of events from interrupts
that interrupted other events, it required 64 bit local atomics.
Unfortunately, 64 bit local atomics are expensive on 32 bit architectures.
Thus, commit 10464b4aa605e ("ring-buffer: Add rb_time_t 64 bit operations
for speeding up 32 bit") created a type of seq lock timer for 32 bits.
It used two 32 bit local atomics, but required 2 bits from them each for
synchronization, making it only 60 bits.

Add a new "msb" field to hold the extra 4 bits that are cut off.

Link: https://lore.kernel.org/all/20220426175338.3807ca4f@gandalf.local.home/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 3a0c7ed0e93f..d59b6a328b7f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -476,6 +476,7 @@ struct rb_time_struct {
 	local_t		cnt;
 	local_t		top;
 	local_t		bottom;
+	local_t		msb;
 };
 #else
 #include <asm/local64.h>
@@ -577,7 +578,6 @@ struct ring_buffer_iter {
  * For the ring buffer, 64 bit required operations for the time is
  * the following:
  *
- *  - Only need 59 bits (uses 60 to make it even).
  *  - Reads may fail if it interrupted a modification of the time stamp.
  *      It will succeed if it did not interrupt another write even if
  *      the read itself is interrupted by a write.
@@ -602,6 +602,7 @@ struct ring_buffer_iter {
  */
 #define RB_TIME_SHIFT	30
 #define RB_TIME_VAL_MASK ((1 << RB_TIME_SHIFT) - 1)
+#define RB_TIME_MSB_SHIFT	 60
 
 static inline int rb_time_cnt(unsigned long val)
 {
@@ -621,7 +622,7 @@ static inline u64 rb_time_val(unsigned long top, unsigned long bottom)
 
 static inline bool __rb_time_read(rb_time_t *t, u64 *ret, unsigned long *cnt)
 {
-	unsigned long top, bottom;
+	unsigned long top, bottom, msb;
 	unsigned long c;
 
 	/*
@@ -633,6 +634,7 @@ static inline bool __rb_time_read(rb_time_t *t, u64 *ret, unsigned long *cnt)
 		c = local_read(&t->cnt);
 		top = local_read(&t->top);
 		bottom = local_read(&t->bottom);
+		msb = local_read(&t->msb);
 	} while (c != local_read(&t->cnt));
 
 	*cnt = rb_time_cnt(top);
@@ -641,7 +643,8 @@ static inline bool __rb_time_read(rb_time_t *t, u64 *ret, unsigned long *cnt)
 	if (*cnt != rb_time_cnt(bottom))
 		return false;
 
-	*ret = rb_time_val(top, bottom);
+	/* The shift to msb will lose its cnt bits */
+	*ret = rb_time_val(top, bottom) | ((u64)msb << RB_TIME_MSB_SHIFT);
 	return true;
 }
 
@@ -657,10 +660,12 @@ static inline unsigned long rb_time_val_cnt(unsigned long val, unsigned long cnt
 	return (val & RB_TIME_VAL_MASK) | ((cnt & 3) << RB_TIME_SHIFT);
 }
 
-static inline void rb_time_split(u64 val, unsigned long *top, unsigned long *bottom)
+static inline void rb_time_split(u64 val, unsigned long *top, unsigned long *bottom,
+				 unsigned long *msb)
 {
 	*top = (unsigned long)((val >> RB_TIME_SHIFT) & RB_TIME_VAL_MASK);
 	*bottom = (unsigned long)(val & RB_TIME_VAL_MASK);
+	*msb = (unsigned long)(val >> RB_TIME_MSB_SHIFT);
 }
 
 static inline void rb_time_val_set(local_t *t, unsigned long val, unsigned long cnt)
@@ -671,15 +676,16 @@ static inline void rb_time_val_set(local_t *t, unsigned long val, unsigned long
 
 static void rb_time_set(rb_time_t *t, u64 val)
 {
-	unsigned long cnt, top, bottom;
+	unsigned long cnt, top, bottom, msb;
 
-	rb_time_split(val, &top, &bottom);
+	rb_time_split(val, &top, &bottom, &msb);
 
 	/* Writes always succeed with a valid number even if it gets interrupted. */
 	do {
 		cnt = local_inc_return(&t->cnt);
 		rb_time_val_set(&t->top, top, cnt);
 		rb_time_val_set(&t->bottom, bottom, cnt);
+		rb_time_val_set(&t->msb, val >> RB_TIME_MSB_SHIFT, cnt);
 	} while (cnt != local_read(&t->cnt));
 }
 
@@ -694,8 +700,8 @@ rb_time_read_cmpxchg(local_t *l, unsigned long expect, unsigned long set)
 
 static int rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
 {
-	unsigned long cnt, top, bottom;
-	unsigned long cnt2, top2, bottom2;
+	unsigned long cnt, top, bottom, msb;
+	unsigned long cnt2, top2, bottom2, msb2;
 	u64 val;
 
 	/* The cmpxchg always fails if it interrupted an update */
@@ -711,16 +717,18 @@ static int rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
 
 	 cnt2 = cnt + 1;
 
-	 rb_time_split(val, &top, &bottom);
+	 rb_time_split(val, &top, &bottom, &msb);
 	 top = rb_time_val_cnt(top, cnt);
 	 bottom = rb_time_val_cnt(bottom, cnt);
 
-	 rb_time_split(set, &top2, &bottom2);
+	 rb_time_split(set, &top2, &bottom2, &msb2);
 	 top2 = rb_time_val_cnt(top2, cnt2);
 	 bottom2 = rb_time_val_cnt(bottom2, cnt2);
 
 	if (!rb_time_read_cmpxchg(&t->cnt, cnt, cnt2))
 		return false;
+	if (!rb_time_read_cmpxchg(&t->msb, msb, msb2))
+		return false;
 	if (!rb_time_read_cmpxchg(&t->top, top, top2))
 		return false;
 	if (!rb_time_read_cmpxchg(&t->bottom, bottom, bottom2))
-- 
2.35.1

