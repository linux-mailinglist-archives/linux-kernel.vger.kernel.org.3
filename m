Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231DB492F99
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 21:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345879AbiARUoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 15:44:01 -0500
Received: from linux.microsoft.com ([13.77.154.182]:43832 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345711AbiARUnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 15:43:32 -0500
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id AAF8420B927D;
        Tue, 18 Jan 2022 12:43:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AAF8420B927D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642538611;
        bh=Xllnhc2NZewvYwvrWoFMtROtoHHNqU9MMDssi+lUA2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TpIEurxmK9Ll6Wy+igZ3atzsgL2oLF3sz0t5s05iKfIN00TxThDWbcpFOdJJ/gT80
         hwVbMCjUMQ2Dr7anVTWLQf6zh89Xc5dUhwu+cPuTFtJ02A/v1C2qp1bWnMwzROCjR2
         w/bE2ZcrNwK7o1A/0r33PFjT/XxRfVlesP+HTp3s=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        beaub@linux.microsoft.com
Subject: [PATCH v10 05/12] user_events: Optimize writing events by only copying data once
Date:   Tue, 18 Jan 2022 12:43:19 -0800
Message-Id: <20220118204326.2169-6-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118204326.2169-1-beaub@linux.microsoft.com>
References: <20220118204326.2169-1-beaub@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass iterator through to probes to allow copying data directly to the
probe buffers instead of taking multiple copies. Enables eBPF user and
raw iterator types out to programs for no-copy scenarios.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
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
2.17.1

