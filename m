Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FD846C6E0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbhLGVsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241959AbhLGVsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:48:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCACC061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 13:44:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4310B81E87
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 21:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7308DC341CE;
        Tue,  7 Dec 2021 21:44:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1muiGD-000HwI-Kd;
        Tue, 07 Dec 2021 16:44:29 -0500
Message-ID: <20211207214429.470467247@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 07 Dec 2021 16:44:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 03/13] tracing: Add __rel_loc using trace event macros
References: <20211207214406.148423650@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add '__rel_loc' using trace event macros. These macros are usually
not used in the kernel, except for testing purpose.
This also add "rel_" variant of macros for dynamic_array string,
and bitmask.

Link: https://lkml.kernel.org/r/163757342119.510314.816029622439099016.stgit@devnote2

Cc: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/trace/bpf_probe.h    |  16 +++++
 include/trace/perf.h         |  16 +++++
 include/trace/trace_events.h | 120 ++++++++++++++++++++++++++++++++++-
 kernel/trace/trace.h         |   3 +
 4 files changed, 153 insertions(+), 2 deletions(-)

diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index a8e97f84b652..7660a7846586 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -21,6 +21,22 @@
 #undef __get_bitmask
 #define __get_bitmask(field) (char *)__get_dynamic_array(field)
 
+#undef __get_rel_dynamic_array
+#define __get_rel_dynamic_array(field)	\
+		((void *)(&__entry->__rel_loc_##field) +	\
+		 sizeof(__entry->__rel_loc_##field) +		\
+		 (__entry->__rel_loc_##field & 0xffff))
+
+#undef __get_rel_dynamic_array_len
+#define __get_rel_dynamic_array_len(field)	\
+		((__entry->__rel_loc_##field >> 16) & 0xffff)
+
+#undef __get_rel_str
+#define __get_rel_str(field) ((char *)__get_rel_dynamic_array(field))
+
+#undef __get_rel_bitmask
+#define __get_rel_bitmask(field) (char *)__get_rel_dynamic_array(field)
+
 #undef __perf_count
 #define __perf_count(c)	(c)
 
diff --git a/include/trace/perf.h b/include/trace/perf.h
index dbc6c74defc3..ea4405de175a 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -21,6 +21,22 @@
 #undef __get_bitmask
 #define __get_bitmask(field) (char *)__get_dynamic_array(field)
 
+#undef __get_rel_dynamic_array
+#define __get_rel_dynamic_array(field)	\
+		((void *)(&__entry->__rel_loc_##field) +	\
+		 sizeof(__entry->__rel_loc_##field) +		\
+		 (__entry->__rel_loc_##field & 0xffff))
+
+#undef __get_rel_dynamic_array_len
+#define __get_rel_dynamic_array_len(field)	\
+		((__entry->__rel_loc_##field >> 16) & 0xffff)
+
+#undef __get_rel_str
+#define __get_rel_str(field) ((char *)__get_rel_dynamic_array(field))
+
+#undef __get_rel_bitmask
+#define __get_rel_bitmask(field) (char *)__get_rel_dynamic_array(field)
+
 #undef __perf_count
 #define __perf_count(c)	(__count = (c))
 
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 08810a463880..8c6f7c433518 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -108,6 +108,18 @@ TRACE_MAKE_SYSTEM_STR();
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(char, item, -1)
 
+#undef __rel_dynamic_array
+#define __rel_dynamic_array(type, item, len) u32 __rel_loc_##item;
+
+#undef __rel_string
+#define __rel_string(item, src) __rel_dynamic_array(char, item, -1)
+
+#undef __rel_string_len
+#define __rel_string_len(item, src, len) __rel_dynamic_array(char, item, -1)
+
+#undef __rel_bitmask
+#define __rel_bitmask(item, nr_bits) __rel_dynamic_array(char, item, -1)
+
 #undef TP_STRUCT__entry
 #define TP_STRUCT__entry(args...) args
 
@@ -200,11 +212,23 @@ TRACE_MAKE_SYSTEM_STR();
 #undef __string
 #define __string(item, src) __dynamic_array(char, item, -1)
 
+#undef __bitmask
+#define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
+
 #undef __string_len
 #define __string_len(item, src, len) __dynamic_array(char, item, -1)
 
-#undef __bitmask
-#define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
+#undef __rel_dynamic_array
+#define __rel_dynamic_array(type, item, len)	u32 item;
+
+#undef __rel_string
+#define __rel_string(item, src) __rel_dynamic_array(char, item, -1)
+
+#undef __rel_string_len
+#define __rel_string_len(item, src, len) __rel_dynamic_array(char, item, -1)
+
+#undef __rel_bitmask
+#define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item, -1)
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
@@ -293,6 +317,19 @@ TRACE_MAKE_SYSTEM_STR();
 #undef __get_str
 #define __get_str(field) ((char *)__get_dynamic_array(field))
 
+#undef __get_rel_dynamic_array
+#define __get_rel_dynamic_array(field)	\
+		((void *)(&__entry->__rel_loc_##field) +	\
+		 sizeof(__entry->__rel_loc_##field) +		\
+		 (__entry->__rel_loc_##field & 0xffff))
+
+#undef __get_rel_dynamic_array_len
+#define __get_rel_dynamic_array_len(field)	\
+		((__entry->__rel_loc_##field >> 16) & 0xffff)
+
+#undef __get_rel_str
+#define __get_rel_str(field) ((char *)__get_rel_dynamic_array(field))
+
 #undef __get_bitmask
 #define __get_bitmask(field)						\
 	({								\
@@ -302,6 +339,15 @@ TRACE_MAKE_SYSTEM_STR();
 		trace_print_bitmask_seq(p, __bitmask, __bitmask_size);	\
 	})
 
+#undef __get_rel_bitmask
+#define __get_rel_bitmask(field)						\
+	({								\
+		void *__bitmask = __get_rel_dynamic_array(field);		\
+		unsigned int __bitmask_size;				\
+		__bitmask_size = __get_rel_dynamic_array_len(field);	\
+		trace_print_bitmask_seq(p, __bitmask, __bitmask_size);	\
+	})
+
 #undef __print_flags
 #define __print_flags(flag, delim, flag_array...)			\
 	({								\
@@ -471,6 +517,21 @@ static struct trace_event_functions trace_event_type_funcs_##call = {	\
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
+#undef __rel_dynamic_array
+#define __rel_dynamic_array(_type, _item, _len) {			\
+	.type = "__rel_loc " #_type "[]", .name = #_item,		\
+	.size = 4, .align = 4,						\
+	.is_signed = is_signed_type(_type), .filter_type = FILTER_OTHER },
+
+#undef __rel_string
+#define __rel_string(item, src) __rel_dynamic_array(char, item, -1)
+
+#undef __rel_string_len
+#define __rel_string_len(item, src, len) __rel_dynamic_array(char, item, -1)
+
+#undef __rel_bitmask
+#define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item, -1)
+
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, func, print)	\
 static struct trace_event_fields trace_event_fields_##call[] = {	\
@@ -519,6 +580,22 @@ static struct trace_event_fields trace_event_fields_##call[] = {	\
 #undef __string_len
 #define __string_len(item, src, len) __dynamic_array(char, item, (len) + 1)
 
+#undef __rel_dynamic_array
+#define __rel_dynamic_array(type, item, len)				\
+	__item_length = (len) * sizeof(type);				\
+	__data_offsets->item = __data_size +				\
+			       offsetof(typeof(*entry), __data) -	\
+			       offsetof(typeof(*entry), __rel_loc_##item) -	\
+			       sizeof(u32);				\
+	__data_offsets->item |= __item_length << 16;			\
+	__data_size += __item_length;
+
+#undef __rel_string
+#define __rel_string(item, src) __rel_dynamic_array(char, item,			\
+		    strlen((src) ? (const char *)(src) : "(null)") + 1)
+
+#undef __rel_string_len
+#define __rel_string_len(item, src, len) __rel_dynamic_array(char, item, (len) + 1)
 /*
  * __bitmask_size_in_bytes_raw is the number of bytes needed to hold
  * num_possible_cpus().
@@ -542,6 +619,10 @@ static struct trace_event_fields trace_event_fields_##call[] = {	\
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item,	\
 					 __bitmask_size_in_longs(nr_bits))
 
+#undef __rel_bitmask
+#define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item,	\
+					 __bitmask_size_in_longs(nr_bits))
+
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
 static inline notrace int trace_event_get_offsets_##call(		\
@@ -706,6 +787,37 @@ static inline notrace int trace_event_get_offsets_##call(		\
 #define __assign_bitmask(dst, src, nr_bits)					\
 	memcpy(__get_bitmask(dst), (src), __bitmask_size_in_bytes(nr_bits))
 
+#undef __rel_dynamic_array
+#define __rel_dynamic_array(type, item, len)				\
+	__entry->__rel_loc_##item = __data_offsets.item;
+
+#undef __rel_string
+#define __rel_string(item, src) __rel_dynamic_array(char, item, -1)
+
+#undef __rel_string_len
+#define __rel_string_len(item, src, len) __rel_dynamic_array(char, item, -1)
+
+#undef __assign_rel_str
+#define __assign_rel_str(dst, src)					\
+	strcpy(__get_rel_str(dst), (src) ? (const char *)(src) : "(null)");
+
+#undef __assign_rel_str_len
+#define __assign_rel_str_len(dst, src, len)				\
+	do {								\
+		memcpy(__get_rel_str(dst), (src), (len));		\
+		__get_rel_str(dst)[len] = '\0';				\
+	} while (0)
+
+#undef __rel_bitmask
+#define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item, -1)
+
+#undef __get_rel_bitmask
+#define __get_rel_bitmask(field) (char *)__get_rel_dynamic_array(field)
+
+#undef __assign_rel_bitmask
+#define __assign_rel_bitmask(dst, src, nr_bits)					\
+	memcpy(__get_rel_bitmask(dst), (src), __bitmask_size_in_bytes(nr_bits))
+
 #undef TP_fast_assign
 #define TP_fast_assign(args...) args
 
@@ -770,6 +882,10 @@ static inline void ftrace_test_probe_##call(void)			\
 #undef __get_dynamic_array_len
 #undef __get_str
 #undef __get_bitmask
+#undef __get_rel_dynamic_array
+#undef __get_rel_dynamic_array_len
+#undef __get_rel_str
+#undef __get_rel_bitmask
 #undef __print_array
 #undef __print_hex_dump
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 5db2bec8ca7e..7162157b970b 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -83,6 +83,9 @@ enum trace_type {
 #undef __dynamic_array
 #define __dynamic_array(type, item)	type	item[];
 
+#undef __rel_dynamic_array
+#define __rel_dynamic_array(type, item)	type	item[];
+
 #undef F_STRUCT
 #define F_STRUCT(args...)		args
 
-- 
2.33.0
