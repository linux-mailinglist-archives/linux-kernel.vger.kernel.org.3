Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6760B4F0A5F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 16:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357992AbiDCOwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 10:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbiDCOwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 10:52:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91967396B6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 07:50:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19B82B80D57
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 14:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E151C340ED;
        Sun,  3 Apr 2022 14:50:33 +0000 (UTC)
Date:   Sun, 3 Apr 2022 10:50:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Lv Ruyi <lv.ruyi@zte.com.cn>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [GIT PULL] tracing: Updates to tracing 5.18 pull request
Message-ID: <20220403105030.3968c6d3@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

[
  As I mentioned in another email, this contains a patch that you pulled
  directly while I was still testing it. Let me know if you want me to
  resend this pull request without it.

  I based it off of your merge of the last pull request as it depends on
  some of the conflicts that were resolved with that last merge.
]

Updates to Tracing:

- Rename the staging files to give them some meaning.
  Just stage1,stag2,etc, does not show what they are for

- Check for NULL from allocation in bootconfig

- Hold event mutex for dyn_event call in user events

- Mark user events to broken (to work on the API)

- Remove eBPF updates from user events

- Remove user events from uapi header to keep it from being installed.

- Move ftrace_graph_is_dead() into inline as it is called from hot paths
  and also convert it into a static branch.


Please pull the latest trace-v5.18-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.18-2

Tag SHA1: 4bcc4b78c18f2efe6c8002ba5eed5cc42bfa44ac
Head SHA1: 5cfff569cab8bf544bab62c911c5d6efd5af5e05


Beau Belgrave (2):
      tracing/user_events: Hold event_mutex during dyn_event_add
      tracing/user_events: Remove eBPF interfaces

Christophe Leroy (1):
      ftrace: Make ftrace_graph_is_dead() a static branch

Lv Ruyi (1):
      proc: bootconfig: Add null pointer check

Steven Rostedt (Google) (3):
      tracing: Rename the staging files for trace_events
      tracing: Set user_events to BROKEN
      tracing: Move user_events.h temporarily out of include/uapi

----
 Documentation/trace/user_events.rst                | 14 +---
 fs/proc/bootconfig.c                               |  2 +
 include/linux/ftrace.h                             | 16 +++-
 include/{uapi => }/linux/user_events.h             | 53 -------------
 .../{stage1_defines.h => stage1_struct_define.h}   |  0
 .../{stage2_defines.h => stage2_data_offsets.h}    |  0
 .../{stage3_defines.h => stage3_trace_output.h}    |  0
 .../{stage4_defines.h => stage4_event_fields.h}    |  0
 .../{stage5_defines.h => stage5_get_offsets.h}     |  0
 .../{stage6_defines.h => stage6_event_callback.h}  |  0
 .../{stage7_defines.h => stage7_class_define.h}    |  0
 include/trace/trace_custom_events.h                | 14 ++--
 include/trace/trace_events.h                       | 14 ++--
 kernel/trace/Kconfig                               |  1 +
 kernel/trace/fgraph.c                              | 17 +----
 kernel/trace/trace_events_user.c                   | 86 +++-------------------
 16 files changed, 50 insertions(+), 167 deletions(-)
 rename include/{uapi => }/linux/user_events.h (58%)
 rename include/trace/stages/{stage1_defines.h => stage1_struct_define.h} (100%)
 rename include/trace/stages/{stage2_defines.h => stage2_data_offsets.h} (100%)
 rename include/trace/stages/{stage3_defines.h => stage3_trace_output.h} (100%)
 rename include/trace/stages/{stage4_defines.h => stage4_event_fields.h} (100%)
 rename include/trace/stages/{stage5_defines.h => stage5_get_offsets.h} (100%)
 rename include/trace/stages/{stage6_defines.h => stage6_event_callback.h} (100%)
 rename include/trace/stages/{stage7_defines.h => stage7_class_define.h} (100%)
---------------------------
diff --git a/Documentation/trace/user_events.rst b/Documentation/trace/user_events.rst
index bddedabaca80..c180936f49fc 100644
--- a/Documentation/trace/user_events.rst
+++ b/Documentation/trace/user_events.rst
@@ -7,7 +7,7 @@ user_events: User-based Event Tracing
 Overview
 --------
 User based trace events allow user processes to create events and trace data
-that can be viewed via existing tools, such as ftrace, perf and eBPF.
+that can be viewed via existing tools, such as ftrace and perf.
 To enable this feature, build your kernel with CONFIG_USER_EVENTS=y.
 
 Programs can view status of the events via
@@ -67,8 +67,7 @@ The command string format is as follows::
 
 Supported Flags
 ^^^^^^^^^^^^^^^
-**BPF_ITER** - EBPF programs attached to this event will get the raw iovec
-struct instead of any data copies for max performance.
+None yet
 
 Field Format
 ^^^^^^^^^^^^
@@ -160,7 +159,7 @@ The following values are defined to aid in checking what has been attached:
 
 **EVENT_STATUS_FTRACE** - Bit set if ftrace has been attached (Bit 0).
 
-**EVENT_STATUS_PERF** - Bit set if perf/eBPF has been attached (Bit 1).
+**EVENT_STATUS_PERF** - Bit set if perf has been attached (Bit 1).
 
 Writing Data
 ------------
@@ -204,13 +203,6 @@ It's advised for user programs to do the following::
 
 **NOTE:** *The write_index is not emitted out into the trace being recorded.*
 
-EBPF
-----
-EBPF programs that attach to a user-based event tracepoint are given a pointer
-to a struct user_bpf_context. The bpf context contains the data type (which can
-be a user or kernel buffer, or can be a pointer to the iovec) and the data
-length that was emitted (minus the write_index).
-
 Example Code
 ------------
 See sample code in samples/user_events.
diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
index 6d8d4bf20837..2e244ada1f97 100644
--- a/fs/proc/bootconfig.c
+++ b/fs/proc/bootconfig.c
@@ -32,6 +32,8 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
 	int ret = 0;
 
 	key = kzalloc(XBC_KEYLEN_MAX, GFP_KERNEL);
+	if (!key)
+		return -ENOMEM;
 
 	xbc_for_each_key_value(leaf, val) {
 		ret = xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX);
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 37b619185ec9..f15a4b76cbfc 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -9,6 +9,7 @@
 
 #include <linux/trace_recursion.h>
 #include <linux/trace_clock.h>
+#include <linux/jump_label.h>
 #include <linux/kallsyms.h>
 #include <linux/linkage.h>
 #include <linux/bitops.h>
@@ -1015,7 +1016,20 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 extern int register_ftrace_graph(struct fgraph_ops *ops);
 extern void unregister_ftrace_graph(struct fgraph_ops *ops);
 
-extern bool ftrace_graph_is_dead(void);
+/**
+ * ftrace_graph_is_dead - returns true if ftrace_graph_stop() was called
+ *
+ * ftrace_graph_stop() is called when a severe error is detected in
+ * the function graph tracing. This function is called by the critical
+ * paths of function graph to keep those paths from doing any more harm.
+ */
+DECLARE_STATIC_KEY_FALSE(kill_ftrace_graph);
+
+static inline bool ftrace_graph_is_dead(void)
+{
+	return static_branch_unlikely(&kill_ftrace_graph);
+}
+
 extern void ftrace_graph_stop(void);
 
 /* The current handlers in use */
diff --git a/include/uapi/linux/user_events.h b/include/linux/user_events.h
similarity index 58%
rename from include/uapi/linux/user_events.h
rename to include/linux/user_events.h
index e570840571e1..736e05603463 100644
--- a/include/uapi/linux/user_events.h
+++ b/include/linux/user_events.h
@@ -32,9 +32,6 @@
 /* Create dynamic location entry within a 32-bit value */
 #define DYN_LOC(offset, size) ((size) << 16 | (offset))
 
-/* Use raw iterator for attached BPF program(s), no affect on ftrace/perf */
-#define FLAG_BPF_ITER (1 << 0)
-
 /*
  * Describes an event registration and stores the results of the registration.
  * This structure is passed to the DIAG_IOCSREG ioctl, callers at a minimum
@@ -63,54 +60,4 @@ struct user_reg {
 /* Requests to delete a user_event */
 #define DIAG_IOCSDEL _IOW(DIAG_IOC_MAGIC, 1, char*)
 
-/* Data type that was passed to the BPF program */
-enum {
-	/* Data resides in kernel space */
-	USER_BPF_DATA_KERNEL,
-
-	/* Data resides in user space */
-	USER_BPF_DATA_USER,
-
-	/* Data is a pointer to a user_bpf_iter structure */
-	USER_BPF_DATA_ITER,
-};
-
-/*
- * Describes an iovec iterator that BPF programs can use to access data for
- * a given user_event write() / writev() call.
- */
-struct user_bpf_iter {
-
-	/* Offset of the data within the first iovec */
-	__u32 iov_offset;
-
-	/* Number of iovec structures */
-	__u32 nr_segs;
-
-	/* Pointer to iovec structures */
-	const struct iovec *iov;
-};
-
-/* Context that BPF programs receive when attached to a user_event */
-struct user_bpf_context {
-
-	/* Data type being passed (see union below) */
-	__u32 data_type;
-
-	/* Length of the data */
-	__u32 data_len;
-
-	/* Pointer to data, varies by data type */
-	union {
-		/* Kernel data (data_type == USER_BPF_DATA_KERNEL) */
-		void *kdata;
-
-		/* User data (data_type == USER_BPF_DATA_USER) */
-		void *udata;
-
-		/* Direct iovec (data_type == USER_BPF_DATA_ITER) */
-		struct user_bpf_iter *iter;
-	};
-};
-
 #endif /* _UAPI_LINUX_USER_EVENTS_H */
diff --git a/include/trace/stages/stage1_defines.h b/include/trace/stages/stage1_struct_define.h
similarity index 100%
rename from include/trace/stages/stage1_defines.h
rename to include/trace/stages/stage1_struct_define.h
diff --git a/include/trace/stages/stage2_defines.h b/include/trace/stages/stage2_data_offsets.h
similarity index 100%
rename from include/trace/stages/stage2_defines.h
rename to include/trace/stages/stage2_data_offsets.h
diff --git a/include/trace/stages/stage3_defines.h b/include/trace/stages/stage3_trace_output.h
similarity index 100%
rename from include/trace/stages/stage3_defines.h
rename to include/trace/stages/stage3_trace_output.h
diff --git a/include/trace/stages/stage4_defines.h b/include/trace/stages/stage4_event_fields.h
similarity index 100%
rename from include/trace/stages/stage4_defines.h
rename to include/trace/stages/stage4_event_fields.h
diff --git a/include/trace/stages/stage5_defines.h b/include/trace/stages/stage5_get_offsets.h
similarity index 100%
rename from include/trace/stages/stage5_defines.h
rename to include/trace/stages/stage5_get_offsets.h
diff --git a/include/trace/stages/stage6_defines.h b/include/trace/stages/stage6_event_callback.h
similarity index 100%
rename from include/trace/stages/stage6_defines.h
rename to include/trace/stages/stage6_event_callback.h
diff --git a/include/trace/stages/stage7_defines.h b/include/trace/stages/stage7_class_define.h
similarity index 100%
rename from include/trace/stages/stage7_defines.h
rename to include/trace/stages/stage7_class_define.h
diff --git a/include/trace/trace_custom_events.h b/include/trace/trace_custom_events.h
index b567c7202339..6e492dba96bf 100644
--- a/include/trace/trace_custom_events.h
+++ b/include/trace/trace_custom_events.h
@@ -35,7 +35,7 @@
 
 /* Stage 1 creates the structure of the recorded event layout */
 
-#include "stages/stage1_defines.h"
+#include "stages/stage1_struct_define.h"
 
 #undef DECLARE_CUSTOM_EVENT_CLASS
 #define DECLARE_CUSTOM_EVENT_CLASS(name, proto, args, tstruct, assign, print) \
@@ -56,7 +56,7 @@
 
 /* Stage 2 creates the custom class */
 
-#include "stages/stage2_defines.h"
+#include "stages/stage2_data_offsets.h"
 
 #undef DECLARE_CUSTOM_EVENT_CLASS
 #define DECLARE_CUSTOM_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
@@ -71,7 +71,7 @@
 
 /* Stage 3 create the way to print the custom event */
 
-#include "stages/stage3_defines.h"
+#include "stages/stage3_trace_output.h"
 
 #undef DECLARE_CUSTOM_EVENT_CLASS
 #define DECLARE_CUSTOM_EVENT_CLASS(call, proto, args, tstruct, assign, print) \
@@ -102,7 +102,7 @@ static struct trace_event_functions trace_custom_event_type_funcs_##call = { \
 
 /* Stage 4 creates the offset layout for the fields */
 
-#include "stages/stage4_defines.h"
+#include "stages/stage4_event_fields.h"
 
 #undef DECLARE_CUSTOM_EVENT_CLASS
 #define DECLARE_CUSTOM_EVENT_CLASS(call, proto, args, tstruct, func, print)	\
@@ -114,7 +114,7 @@ static struct trace_event_fields trace_custom_event_fields_##call[] = {	\
 
 /* Stage 5 creates the helper function for dynamic fields */
 
-#include "stages/stage5_defines.h"
+#include "stages/stage5_get_offsets.h"
 
 #undef DECLARE_CUSTOM_EVENT_CLASS
 #define DECLARE_CUSTOM_EVENT_CLASS(call, proto, args, tstruct, assign, print) \
@@ -134,7 +134,7 @@ static inline notrace int trace_custom_event_get_offsets_##call(	\
 
 /* Stage 6 creates the probe function that records the event */
 
-#include "stages/stage6_defines.h"
+#include "stages/stage6_event_callback.h"
 
 #undef DECLARE_CUSTOM_EVENT_CLASS
 #define DECLARE_CUSTOM_EVENT_CLASS(call, proto, args, tstruct, assign, print) \
@@ -182,7 +182,7 @@ static inline void ftrace_test_custom_probe_##call(void)		\
 
 /* Stage 7 creates the actual class and event structure for the custom event */
 
-#include "stages/stage7_defines.h"
+#include "stages/stage7_class_define.h"
 
 #undef DECLARE_CUSTOM_EVENT_CLASS
 #define DECLARE_CUSTOM_EVENT_CLASS(call, proto, args, tstruct, assign, print) \
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 8a8cd66cc6d5..c2f9cabf154d 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -45,7 +45,7 @@
 			     PARAMS(print));		       \
 	DEFINE_EVENT(name, name, PARAMS(proto), PARAMS(args));
 
-#include "stages/stage1_defines.h"
+#include "stages/stage1_struct_define.h"
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(name, proto, args, tstruct, assign, print)	\
@@ -109,7 +109,7 @@
  * The size of an array is also encoded, in the higher 16 bits of <item>.
  */
 
-#include "stages/stage2_defines.h"
+#include "stages/stage2_data_offsets.h"
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
@@ -181,7 +181,7 @@
  * in binary.
  */
 
-#include "stages/stage3_defines.h"
+#include "stages/stage3_trace_output.h"
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
@@ -236,7 +236,7 @@ static struct trace_event_functions trace_event_type_funcs_##call = {	\
 
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
 
-#include "stages/stage4_defines.h"
+#include "stages/stage4_event_fields.h"
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, func, print)	\
@@ -249,7 +249,7 @@ static struct trace_event_fields trace_event_fields_##call[] = {	\
 
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
 
-#include "stages/stage5_defines.h"
+#include "stages/stage5_get_offsets.h"
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
@@ -372,7 +372,7 @@ static inline notrace int trace_event_get_offsets_##call(		\
 #define _TRACE_PERF_INIT(call)
 #endif /* CONFIG_PERF_EVENTS */
 
-#include "stages/stage6_defines.h"
+#include "stages/stage6_event_callback.h"
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
@@ -418,7 +418,7 @@ static inline void ftrace_test_probe_##call(void)			\
 
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
 
-#include "stages/stage7_defines.h"
+#include "stages/stage7_class_define.h"
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 16a52a71732d..f83d29adb375 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -741,6 +741,7 @@ config USER_EVENTS
 	bool "User trace events"
 	select TRACING
 	select DYNAMIC_EVENTS
+	depends on BROKEN || COMPILE_TEST # API needs to be straighten out
 	help
 	  User trace events are user-defined trace events that
 	  can be used like an existing kernel trace event.  User trace
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 19028e072cdb..8f4fb328133a 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -7,6 +7,7 @@
  *
  * Highly modified by Steven Rostedt (VMware).
  */
+#include <linux/jump_label.h>
 #include <linux/suspend.h>
 #include <linux/ftrace.h>
 #include <linux/slab.h>
@@ -23,24 +24,12 @@
 #define ASSIGN_OPS_HASH(opsname, val)
 #endif
 
-static bool kill_ftrace_graph;
+DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
 int ftrace_graph_active;
 
 /* Both enabled by default (can be cleared by function_graph tracer flags */
 static bool fgraph_sleep_time = true;
 
-/**
- * ftrace_graph_is_dead - returns true if ftrace_graph_stop() was called
- *
- * ftrace_graph_stop() is called when a severe error is detected in
- * the function graph tracing. This function is called by the critical
- * paths of function graph to keep those paths from doing any more harm.
- */
-bool ftrace_graph_is_dead(void)
-{
-	return kill_ftrace_graph;
-}
-
 /**
  * ftrace_graph_stop - set to permanently disable function graph tracing
  *
@@ -51,7 +40,7 @@ bool ftrace_graph_is_dead(void)
  */
 void ftrace_graph_stop(void)
 {
-	kill_ftrace_graph = true;
+	static_branch_enable(&kill_ftrace_graph);
 }
 
 /* Add a function return address to the trace stack on thread info.*/
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 8b3d241a31c2..706e1686b5eb 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -18,7 +18,12 @@
 #include <linux/tracefs.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
+/* Reminder to move to uapi when everything works */
+#ifdef CONFIG_COMPILE_TEST
+#include <linux/user_events.h>
+#else
 #include <uapi/linux/user_events.h>
+#endif
 #include "trace.h"
 #include "trace_dynevent.h"
 
@@ -42,9 +47,6 @@
 #define MAX_FIELD_ARRAY_SIZE 1024
 #define MAX_FIELD_ARG_NAME 256
 
-#define MAX_BPF_COPY_SIZE PAGE_SIZE
-#define MAX_STACK_BPF_DATA 512
-
 static char *register_page_data;
 
 static DEFINE_MUTEX(reg_mutex);
@@ -405,19 +407,6 @@ static int user_event_parse_field(char *field, struct user_event *user,
 				    type[0] != 'u', FILTER_OTHER);
 }
 
-static void user_event_parse_flags(struct user_event *user, char *flags)
-{
-	char *flag;
-
-	if (flags == NULL)
-		return;
-
-	while ((flag = strsep(&flags, ",")) != NULL) {
-		if (strcmp(flag, "BPF_ITER") == 0)
-			user->flags |= FLAG_BPF_ITER;
-	}
-}
-
 static int user_event_parse_fields(struct user_event *user, char *args)
 {
 	char *field;
@@ -713,64 +702,14 @@ static void user_event_ftrace(struct user_event *user, struct iov_iter *i,
 }
 
 #ifdef CONFIG_PERF_EVENTS
-static void user_event_bpf(struct user_event *user, struct iov_iter *i)
-{
-	struct user_bpf_context context;
-	struct user_bpf_iter bpf_i;
-	char fast_data[MAX_STACK_BPF_DATA];
-	void *temp = NULL;
-
-	if ((user->flags & FLAG_BPF_ITER) && iter_is_iovec(i)) {
-		/* Raw iterator */
-		context.data_type = USER_BPF_DATA_ITER;
-		context.data_len = i->count;
-		context.iter = &bpf_i;
-
-		bpf_i.iov_offset = i->iov_offset;
-		bpf_i.iov = i->iov;
-		bpf_i.nr_segs = i->nr_segs;
-	} else if (i->nr_segs == 1 && iter_is_iovec(i)) {
-		/* Single buffer from user */
-		context.data_type = USER_BPF_DATA_USER;
-		context.data_len = i->count;
-		context.udata = i->iov->iov_base + i->iov_offset;
-	} else {
-		/* Multi buffer from user */
-		struct iov_iter copy = *i;
-		size_t copy_size = min_t(size_t, i->count, MAX_BPF_COPY_SIZE);
-
-		context.data_type = USER_BPF_DATA_KERNEL;
-		context.kdata = fast_data;
-
-		if (unlikely(copy_size > sizeof(fast_data))) {
-			temp = kmalloc(copy_size, GFP_NOWAIT);
-
-			if (temp)
-				context.kdata = temp;
-			else
-				copy_size = sizeof(fast_data);
-		}
-
-		context.data_len = copy_nofault(context.kdata,
-						copy_size, &copy);
-	}
-
-	trace_call_bpf(&user->call, &context);
-
-	kfree(temp);
-}
-
 /*
- * Writes the user supplied payload out to perf ring buffer or eBPF program.
+ * Writes the user supplied payload out to perf ring buffer.
  */
 static void user_event_perf(struct user_event *user, struct iov_iter *i,
 			    void *tpdata, bool *faulted)
 {
 	struct hlist_head *perf_head;
 
-	if (bpf_prog_array_valid(&user->call))
-		user_event_bpf(user, i);
-
 	perf_head = this_cpu_ptr(user->call.perf_events);
 
 	if (perf_head && !hlist_empty(perf_head)) {
@@ -1136,8 +1075,6 @@ static int user_event_parse(char *name, char *args, char *flags,
 
 	user->tracepoint.name = name;
 
-	user_event_parse_flags(user, flags);
-
 	ret = user_event_parse_fields(user, args);
 
 	if (ret)
@@ -1165,11 +1102,11 @@ static int user_event_parse(char *name, char *args, char *flags,
 #endif
 
 	mutex_lock(&event_mutex);
+
 	ret = user_event_trace_register(user);
-	mutex_unlock(&event_mutex);
 
 	if (ret)
-		goto put_user;
+		goto put_user_lock;
 
 	user->index = index;
 
@@ -1181,8 +1118,12 @@ static int user_event_parse(char *name, char *args, char *flags,
 	set_bit(user->index, page_bitmap);
 	hash_add(register_table, &user->node, key);
 
+	mutex_unlock(&event_mutex);
+
 	*newuser = user;
 	return 0;
+put_user_lock:
+	mutex_unlock(&event_mutex);
 put_user:
 	user_event_destroy_fields(user);
 	user_event_destroy_validators(user);
@@ -1575,9 +1516,6 @@ static int user_seq_show(struct seq_file *m, void *p)
 			busy++;
 		}
 
-		if (flags & FLAG_BPF_ITER)
-			seq_puts(m, " FLAG:BPF_ITER");
-
 		seq_puts(m, "\n");
 		active++;
 	}
