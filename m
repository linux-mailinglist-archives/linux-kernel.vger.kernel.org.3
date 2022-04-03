Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FA64F0A2C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 16:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359013AbiDCOdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 10:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237607AbiDCOdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 10:33:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539BD2FFDB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 07:31:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCCAB611CF
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 14:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21970C34119;
        Sun,  3 Apr 2022 14:31:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nb1GW-001EhS-5I;
        Sun, 03 Apr 2022 10:31:40 -0400
Message-ID: <20220403143140.000072935@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 03 Apr 2022 10:25:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-linus][PATCH 4/7] tracing/user_events: Remove eBPF interfaces
References: <20220403142500.388473000@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beau Belgrave <beaub@linux.microsoft.com>

Remove eBPF interfaces within user_events to ensure they are fully
reviewed.

Link: https://lore.kernel.org/all/20220329165718.GA10381@kbox/
Link: https://lkml.kernel.org/r/20220329173051.10087-1-beaub@linux.microsoft.com

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/user_events.rst | 14 ++----
 include/uapi/linux/user_events.h    | 53 ---------------------
 kernel/trace/trace_events_user.c    | 73 +----------------------------
 3 files changed, 4 insertions(+), 136 deletions(-)

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
diff --git a/include/uapi/linux/user_events.h b/include/uapi/linux/user_events.h
index e570840571e1..736e05603463 100644
--- a/include/uapi/linux/user_events.h
+++ b/include/uapi/linux/user_events.h
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
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 61d78d64bdf0..846c27bc7aef 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -42,9 +42,6 @@
 #define MAX_FIELD_ARRAY_SIZE 1024
 #define MAX_FIELD_ARG_NAME 256
 
-#define MAX_BPF_COPY_SIZE PAGE_SIZE
-#define MAX_STACK_BPF_DATA 512
-
 static char *register_page_data;
 
 static DEFINE_MUTEX(reg_mutex);
@@ -405,19 +402,6 @@ static int user_event_parse_field(char *field, struct user_event *user,
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
@@ -713,64 +697,14 @@ static void user_event_ftrace(struct user_event *user, struct iov_iter *i,
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
@@ -1136,8 +1070,6 @@ static int user_event_parse(char *name, char *args, char *flags,
 
 	user->tracepoint.name = name;
 
-	user_event_parse_flags(user, flags);
-
 	ret = user_event_parse_fields(user, args);
 
 	if (ret)
@@ -1579,9 +1511,6 @@ static int user_seq_show(struct seq_file *m, void *p)
 			busy++;
 		}
 
-		if (flags & FLAG_BPF_ITER)
-			seq_puts(m, " FLAG:BPF_ITER");
-
 		seq_puts(m, "\n");
 		active++;
 	}
-- 
2.35.1
