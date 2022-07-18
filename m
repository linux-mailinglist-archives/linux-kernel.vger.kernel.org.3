Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA806578E33
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbiGRXSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 19:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbiGRXRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 19:17:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5263C33414
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:17:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5E9CB8167A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 23:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576D0C341CB;
        Mon, 18 Jul 2022 23:17:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oDZzo-000Zev-0Y;
        Mon, 18 Jul 2022 19:17:48 -0400
Message-ID: <20220718231747.994566341@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 18 Jul 2022 19:17:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 1/2] tracing: Add example and documentation for new __vstring() macro
References: <20220718231725.880245563@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Update the sample trace events to include an example that uses the new
__vstring() helpers for TRACE_EVENTS.

Link: https://lkml.kernel.org/r/20220715175555.16375a3b@gandalf.local.home

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 samples/trace_events/trace-events-sample.c | 14 ++++++++--
 samples/trace_events/trace-events-sample.h | 32 +++++++++++++++++++---
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/samples/trace_events/trace-events-sample.c b/samples/trace_events/trace-events-sample.c
index 4d34dc0b0fee..608c4ae3b08a 100644
--- a/samples/trace_events/trace-events-sample.c
+++ b/samples/trace_events/trace-events-sample.c
@@ -19,9 +19,10 @@ static const char *random_strings[] = {
 	"One ring to rule them all"
 };
 
-static void simple_thread_func(int cnt)
+static void do_simple_thread_func(int cnt, const char *fmt, ...)
 {
 	unsigned long bitmask[1] = {0xdeadbeefUL};
+	va_list va;
 	int array[6];
 	int len = cnt % 5;
 	int i;
@@ -33,9 +34,13 @@ static void simple_thread_func(int cnt)
 		array[i] = i + 1;
 	array[i] = 0;
 
+	va_start(va, fmt);
+
 	/* Silly tracepoints */
 	trace_foo_bar("hello", cnt, array, random_strings[len],
-		      current->cpus_ptr);
+		      current->cpus_ptr, fmt, &va);
+
+	va_end(va);
 
 	trace_foo_with_template_simple("HELLO", cnt);
 
@@ -48,6 +53,11 @@ static void simple_thread_func(int cnt)
 	trace_foo_rel_loc("Hello __rel_loc", cnt, bitmask);
 }
 
+static void simple_thread_func(int cnt)
+{
+	do_simple_thread_func(cnt, "iter=%d", cnt);
+}
+
 static int simple_thread(void *arg)
 {
 	int cnt = 0;
diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index cbbbb83beced..1a92226202fc 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -141,6 +141,27 @@
  *         In most cases, the __assign_str() macro will take the same
  *         parameters as the __string() macro had to declare the string.
  *
+ *   __vstring: This is similar to __string() but instead of taking a
+ *         dynamic length, it takes a variable list va_list 'va' variable.
+ *         Some event callers already have a message from parameters saved
+ *         in a va_list. Passing in the format and the va_list variable
+ *         will save just enough on the ring buffer for that string.
+ *         Note, the va variable used is a pointer to a va_list, not
+ *         to the va_list directly.
+ *
+ *           (va_list *va)
+ *
+ *         __vstring(foo, fmt, va)  is similar to:  vsnprintf(foo, fmt, va)
+ *
+ *         To assign the string, use the helper macro __assign_vstr().
+ *
+ *         __assign_vstr(foo, fmt, va);
+ *
+ *         In most cases, the __assign_vstr() macro will take the same
+ *         parameters as the __vstring() macro had to declare the string.
+ *         Use __get_str() to retrieve the __vstring() just like it would for
+ *         __string().
+ *
  *   __string_len: This is a helper to a __dynamic_array, but it understands
  *	   that the array has characters in it, and with the combined
  *         use of __assign_str_len(), it will allocate 'len' + 1 bytes
@@ -256,9 +277,10 @@ TRACE_DEFINE_ENUM(TRACE_SAMPLE_ZOO);
 TRACE_EVENT(foo_bar,
 
 	TP_PROTO(const char *foo, int bar, const int *lst,
-		 const char *string, const struct cpumask *mask),
+		 const char *string, const struct cpumask *mask,
+		 const char *fmt, va_list *va),
 
-	TP_ARGS(foo, bar, lst, string, mask),
+	TP_ARGS(foo, bar, lst, string, mask, fmt, va),
 
 	TP_STRUCT__entry(
 		__array(	char,	foo,    10		)
@@ -266,6 +288,7 @@ TRACE_EVENT(foo_bar,
 		__dynamic_array(int,	list,   __length_of(lst))
 		__string(	str,	string			)
 		__bitmask(	cpus,	num_possible_cpus()	)
+		__vstring(	vstr,	fmt,	va		)
 	),
 
 	TP_fast_assign(
@@ -274,10 +297,11 @@ TRACE_EVENT(foo_bar,
 		memcpy(__get_dynamic_array(list), lst,
 		       __length_of(lst) * sizeof(int));
 		__assign_str(str, string);
+		__assign_vstr(vstr, fmt, va);
 		__assign_bitmask(cpus, cpumask_bits(mask), num_possible_cpus());
 	),
 
-	TP_printk("foo %s %d %s %s %s %s (%s)", __entry->foo, __entry->bar,
+	TP_printk("foo %s %d %s %s %s %s (%s) %s", __entry->foo, __entry->bar,
 
 /*
  * Notice here the use of some helper functions. This includes:
@@ -321,7 +345,7 @@ TRACE_EVENT(foo_bar,
 		  __print_array(__get_dynamic_array(list),
 				__get_dynamic_array_len(list) / sizeof(int),
 				sizeof(int)),
-		  __get_str(str), __get_bitmask(cpus))
+		  __get_str(str), __get_bitmask(cpus), __get_str(vstr))
 );
 
 /*
-- 
2.35.1
