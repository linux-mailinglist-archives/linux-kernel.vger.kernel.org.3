Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2A74BC43C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 02:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240843AbiBSA4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:56:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240782AbiBSAzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:55:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8883427B49A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:55:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15E18B8276B
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 00:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA83C340EF;
        Sat, 19 Feb 2022 00:55:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nLE1q-0051bK-2Z;
        Fri, 18 Feb 2022 19:55:14 -0500
Message-ID: <20220219005513.907430496@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 19:54:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 09/16] user_events: Optimize writing events by only copying data once
References: <20220219005430.848118506@goodmis.org>
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

Pass iterator through to probes to allow copying data directly to the
probe buffers instead of taking multiple copies. Enables eBPF user and
raw iterator types out to programs for no-copy scenarios.

Link: https://lkml.kernel.org/r/20220118204326.2169-6-beaub@linux.microsoft.com

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 115 +++++++++++++++++++++++--------
 1 file changed, 85 insertions(+), 30 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 371f31472156..78b6b96c4cfa 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -41,6 +41,9 @@
 #define MAX_FIELD_ARRAY_SIZE 1024
 #define MAX_FIELD_ARG_NAME 256
 
+#define MAX_BPF_COPY_SIZE PAGE_SIZE
+#define MAX_STACK_BPF_DATA 512
+
 static char *register_page_data;
 
 static DEFINE_MUTEX(reg_mutex);
@@ -78,8 +81,7 @@ struct user_event_refs {
 	struct user_event *events[];
 };
 
-typedef void (*user_event_func_t) (struct user_event *user,
-				   void *data, u32 datalen,
+typedef void (*user_event_func_t) (struct user_event *user, struct iov_iter *i,
 				   void *tpdata);
 
 static int user_event_parse(char *name, char *args, char *flags,
@@ -90,6 +92,20 @@ static u32 user_event_key(char *name)
 	return jhash(name, strlen(name), 0);
 }
 
+static __always_inline __must_check
+size_t copy_nofault(void *addr, size_t bytes, struct iov_iter *i)
+{
+	size_t ret;
+
+	pagefault_disable();
+
+	ret = copy_from_iter_nocache(addr, bytes, i);
+
+	pagefault_enable();
+
+	return ret;
+}
+
 static struct list_head *user_event_get_fields(struct trace_event_call *call)
 {
 	struct user_event *user = (struct user_event *)call->data;
@@ -525,7 +541,7 @@ static struct user_event *find_user_event(char *name, u32 *outkey)
 /*
  * Writes the user supplied payload out to a trace file.
  */
-static void user_event_ftrace(struct user_event *user, void *data, u32 datalen,
+static void user_event_ftrace(struct user_event *user, struct iov_iter *i,
 			      void *tpdata)
 {
 	struct trace_event_file *file;
@@ -541,41 +557,83 @@ static void user_event_ftrace(struct user_event *user, void *data, u32 datalen,
 
 	/* Allocates and fills trace_entry, + 1 of this is data payload */
 	entry = trace_event_buffer_reserve(&event_buffer, file,
-					   sizeof(*entry) + datalen);
+					   sizeof(*entry) + i->count);
 
 	if (unlikely(!entry))
 		return;
 
-	memcpy(entry + 1, data, datalen);
-
-	trace_event_buffer_commit(&event_buffer);
+	if (unlikely(!copy_nofault(entry + 1, i->count, i)))
+		__trace_event_discard_commit(event_buffer.buffer,
+					     event_buffer.event);
+	else
+		trace_event_buffer_commit(&event_buffer);
 }
 
 #ifdef CONFIG_PERF_EVENTS
+static void user_event_bpf(struct user_event *user, struct iov_iter *i)
+{
+	struct user_bpf_context context;
+	struct user_bpf_iter bpf_i;
+	char fast_data[MAX_STACK_BPF_DATA];
+	void *temp = NULL;
+
+	if ((user->flags & FLAG_BPF_ITER) && iter_is_iovec(i)) {
+		/* Raw iterator */
+		context.data_type = USER_BPF_DATA_ITER;
+		context.data_len = i->count;
+		context.iter = &bpf_i;
+
+		bpf_i.iov_offset = i->iov_offset;
+		bpf_i.iov = i->iov;
+		bpf_i.nr_segs = i->nr_segs;
+	} else if (i->nr_segs == 1 && iter_is_iovec(i)) {
+		/* Single buffer from user */
+		context.data_type = USER_BPF_DATA_USER;
+		context.data_len = i->count;
+		context.udata = i->iov->iov_base + i->iov_offset;
+	} else {
+		/* Multi buffer from user */
+		struct iov_iter copy = *i;
+		size_t copy_size = min_t(size_t, i->count, MAX_BPF_COPY_SIZE);
+
+		context.data_type = USER_BPF_DATA_KERNEL;
+		context.kdata = fast_data;
+
+		if (unlikely(copy_size > sizeof(fast_data))) {
+			temp = kmalloc(copy_size, GFP_NOWAIT);
+
+			if (temp)
+				context.kdata = temp;
+			else
+				copy_size = sizeof(fast_data);
+		}
+
+		context.data_len = copy_nofault(context.kdata,
+						copy_size, &copy);
+	}
+
+	trace_call_bpf(&user->call, &context);
+
+	kfree(temp);
+}
+
 /*
  * Writes the user supplied payload out to perf ring buffer or eBPF program.
  */
-static void user_event_perf(struct user_event *user, void *data, u32 datalen,
+static void user_event_perf(struct user_event *user, struct iov_iter *i,
 			    void *tpdata)
 {
 	struct hlist_head *perf_head;
 
-	if (bpf_prog_array_valid(&user->call)) {
-		struct user_bpf_context context = {0};
-
-		context.data_len = datalen;
-		context.data_type = USER_BPF_DATA_KERNEL;
-		context.kdata = data;
-
-		trace_call_bpf(&user->call, &context);
-	}
+	if (bpf_prog_array_valid(&user->call))
+		user_event_bpf(user, i);
 
 	perf_head = this_cpu_ptr(user->call.perf_events);
 
 	if (perf_head && !hlist_empty(perf_head)) {
 		struct trace_entry *perf_entry;
 		struct pt_regs *regs;
-		size_t size = sizeof(*perf_entry) + datalen;
+		size_t size = sizeof(*perf_entry) + i->count;
 		int context;
 
 		perf_entry = perf_trace_buf_alloc(ALIGN(size, 8),
@@ -586,7 +644,10 @@ static void user_event_perf(struct user_event *user, void *data, u32 datalen,
 
 		perf_fetch_caller_regs(regs);
 
-		memcpy(perf_entry + 1, data, datalen);
+		if (unlikely(!copy_nofault(perf_entry + 1, i->count, i))) {
+			perf_swevent_put_recursion_context(context);
+			return;
+		}
 
 		perf_trace_buf_submit(perf_entry, size, context,
 				      user->call.event.type, 1, regs,
@@ -1024,16 +1085,11 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
 	if (likely(atomic_read(&tp->key.enabled) > 0)) {
 		struct tracepoint_func *probe_func_ptr;
 		user_event_func_t probe_func;
+		struct iov_iter copy;
 		void *tpdata;
-		void *kdata;
-		u32 datalen;
 
-		kdata = kmalloc(i->count, GFP_KERNEL);
-
-		if (unlikely(!kdata))
-			return -ENOMEM;
-
-		datalen = copy_from_iter(kdata, i->count, i);
+		if (unlikely(fault_in_iov_iter_readable(i, i->count)))
+			return -EFAULT;
 
 		rcu_read_lock_sched();
 
@@ -1041,15 +1097,14 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
 
 		if (probe_func_ptr) {
 			do {
+				copy = *i;
 				probe_func = probe_func_ptr->func;
 				tpdata = probe_func_ptr->data;
-				probe_func(user, kdata, datalen, tpdata);
+				probe_func(user, &copy, tpdata);
 			} while ((++probe_func_ptr)->func);
 		}
 
 		rcu_read_unlock_sched();
-
-		kfree(kdata);
 	}
 
 	return ret;
-- 
2.34.1
