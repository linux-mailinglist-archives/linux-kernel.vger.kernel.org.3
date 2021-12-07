Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55E546C6DE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241986AbhLGVsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:48:07 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:53832 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241863AbhLGVsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:48:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6BC92CE1E74
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 21:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD06C341D5;
        Tue,  7 Dec 2021 21:44:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1muiGD-000Hwq-QS;
        Tue, 07 Dec 2021 16:44:29 -0500
Message-ID: <20211207214429.659157012@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 07 Dec 2021 16:44:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 04/13] samples/trace_event: Add __rel_loc using sample event
References: <20211207214406.148423650@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add '__rel_loc' using sample event for testing.
User can use this for testing purpose. There is
no reason to use this macro from the kernel.

Link: https://lkml.kernel.org/r/163757343050.510314.2876529802471645178.stgit@devnote2

Cc: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 samples/trace_events/trace-events-sample.c |  3 ++
 samples/trace_events/trace-events-sample.h | 33 ++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/samples/trace_events/trace-events-sample.c b/samples/trace_events/trace-events-sample.c
index 1a72b7d95cdc..4d34dc0b0fee 100644
--- a/samples/trace_events/trace-events-sample.c
+++ b/samples/trace_events/trace-events-sample.c
@@ -21,6 +21,7 @@ static const char *random_strings[] = {
 
 static void simple_thread_func(int cnt)
 {
+	unsigned long bitmask[1] = {0xdeadbeefUL};
 	int array[6];
 	int len = cnt % 5;
 	int i;
@@ -43,6 +44,8 @@ static void simple_thread_func(int cnt)
 	trace_foo_with_template_cond("prints other times", cnt);
 
 	trace_foo_with_template_print("I have to be different", cnt);
+
+	trace_foo_rel_loc("Hello __rel_loc", cnt, bitmask);
 }
 
 static int simple_thread(void *arg)
diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index e61471ab7d14..5ab74fc9a2df 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -506,6 +506,39 @@ DEFINE_EVENT_PRINT(foo_template, foo_with_template_print,
 	TP_ARGS(foo, bar),
 	TP_printk("bar %s %d", __get_str(foo), __entry->bar));
 
+/*
+ * There are yet another __rel_loc dynamic data attribute. If you
+ * use __rel_dynamic_array() and __rel_string() etc. macros, you
+ * can use this attribute. There is no difference from the viewpoint
+ * of functionality with/without 'rel' but the encoding is a bit
+ * different. This is expected to be used with user-space event,
+ * there is no reason that the kernel event use this, but only for
+ * testing.
+ */
+
+TRACE_EVENT(foo_rel_loc,
+
+	TP_PROTO(const char *foo, int bar, unsigned long *mask),
+
+	TP_ARGS(foo, bar, mask),
+
+	TP_STRUCT__entry(
+		__rel_string(	foo,	foo	)
+		__field(	int,	bar	)
+		__rel_bitmask(	bitmask,
+			BITS_PER_BYTE * sizeof(unsigned long)	)
+	),
+
+	TP_fast_assign(
+		__assign_rel_str(foo, foo);
+		__entry->bar = bar;
+		__assign_rel_bitmask(bitmask, mask,
+			BITS_PER_BYTE * sizeof(unsigned long));
+	),
+
+	TP_printk("foo_rel_loc %s, %d, %s", __get_rel_str(foo), __entry->bar,
+		  __get_rel_bitmask(bitmask))
+);
 #endif
 
 /***** NOTICE! The #if protection ends here. *****/
-- 
2.33.0
