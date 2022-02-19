Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A3F4BC43A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 02:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240823AbiBSAzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:55:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237526AbiBSAzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:55:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B787C2790A7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:55:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44D9661FE9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 00:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14790C340F6;
        Sat, 19 Feb 2022 00:55:15 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nLE1q-0051bt-8a;
        Fri, 18 Feb 2022 19:55:14 -0500
Message-ID: <20220219005514.099734775@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 19:54:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 10/16] user_events: Validate user payloads for size and null termination
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

Add validation to ensure data is at or greater than the min size for the
fields of the event. If a dynamic array is used and is a type of char,
ensure null termination of the array exists.

Link: https://lkml.kernel.org/r/20220118204326.2169-7-beaub@linux.microsoft.com

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 147 ++++++++++++++++++++++++++++---
 1 file changed, 133 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 78b6b96c4cfa..2b5e9fdb63a0 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -64,9 +64,11 @@ struct user_event {
 	struct dyn_event devent;
 	struct hlist_node node;
 	struct list_head fields;
+	struct list_head validators;
 	atomic_t refcnt;
 	int index;
 	int flags;
+	int min_size;
 };
 
 /*
@@ -81,8 +83,17 @@ struct user_event_refs {
 	struct user_event *events[];
 };
 
+#define VALIDATOR_ENSURE_NULL (1 << 0)
+#define VALIDATOR_REL (1 << 1)
+
+struct user_event_validator {
+	struct list_head link;
+	int offset;
+	int flags;
+};
+
 typedef void (*user_event_func_t) (struct user_event *user, struct iov_iter *i,
-				   void *tpdata);
+				   void *tpdata, bool *faulted);
 
 static int user_event_parse(char *name, char *args, char *flags,
 			    struct user_event **newuser);
@@ -215,6 +226,17 @@ static int user_field_size(const char *type)
 	return -EINVAL;
 }
 
+static void user_event_destroy_validators(struct user_event *user)
+{
+	struct user_event_validator *validator, *next;
+	struct list_head *head = &user->validators;
+
+	list_for_each_entry_safe(validator, next, head, link) {
+		list_del(&validator->link);
+		kfree(validator);
+	}
+}
+
 static void user_event_destroy_fields(struct user_event *user)
 {
 	struct ftrace_event_field *field, *next;
@@ -230,13 +252,43 @@ static int user_event_add_field(struct user_event *user, const char *type,
 				const char *name, int offset, int size,
 				int is_signed, int filter_type)
 {
+	struct user_event_validator *validator;
 	struct ftrace_event_field *field;
+	int validator_flags = 0;
 
 	field = kmalloc(sizeof(*field), GFP_KERNEL);
 
 	if (!field)
 		return -ENOMEM;
 
+	if (str_has_prefix(type, "__data_loc "))
+		goto add_validator;
+
+	if (str_has_prefix(type, "__rel_loc ")) {
+		validator_flags |= VALIDATOR_REL;
+		goto add_validator;
+	}
+
+	goto add_field;
+
+add_validator:
+	if (strstr(type, "char") != 0)
+		validator_flags |= VALIDATOR_ENSURE_NULL;
+
+	validator = kmalloc(sizeof(*validator), GFP_KERNEL);
+
+	if (!validator) {
+		kfree(field);
+		return -ENOMEM;
+	}
+
+	validator->flags = validator_flags;
+	validator->offset = offset;
+
+	/* Want sequential access when validating */
+	list_add_tail(&validator->link, &user->validators);
+
+add_field:
 	field->type = type;
 	field->name = name;
 	field->offset = offset;
@@ -246,6 +298,12 @@ static int user_event_add_field(struct user_event *user, const char *type,
 
 	list_add(&field->link, &user->fields);
 
+	/*
+	 * Min size from user writes that are required, this does not include
+	 * the size of trace_entry (common fields).
+	 */
+	user->min_size = (offset + size) - sizeof(struct trace_entry);
+
 	return 0;
 }
 
@@ -517,6 +575,7 @@ static int destroy_user_event(struct user_event *user)
 	clear_bit(user->index, page_bitmap);
 	hash_del(&user->node);
 
+	user_event_destroy_validators(user);
 	kfree(user->call.print_fmt);
 	kfree(EVENT_NAME(user));
 	kfree(user);
@@ -538,15 +597,49 @@ static struct user_event *find_user_event(char *name, u32 *outkey)
 	return NULL;
 }
 
+static int user_event_validate(struct user_event *user, void *data, int len)
+{
+	struct list_head *head = &user->validators;
+	struct user_event_validator *validator;
+	void *pos, *end = data + len;
+	u32 loc, offset, size;
+
+	list_for_each_entry(validator, head, link) {
+		pos = data + validator->offset;
+
+		/* Already done min_size check, no bounds check here */
+		loc = *(u32 *)pos;
+		offset = loc & 0xffff;
+		size = loc >> 16;
+
+		if (likely(validator->flags & VALIDATOR_REL))
+			pos += offset + sizeof(loc);
+		else
+			pos = data + offset;
+
+		pos += size;
+
+		if (unlikely(pos > end))
+			return -EFAULT;
+
+		if (likely(validator->flags & VALIDATOR_ENSURE_NULL))
+			if (unlikely(*(char *)(pos - 1) != '\0'))
+				return -EFAULT;
+	}
+
+	return 0;
+}
+
 /*
  * Writes the user supplied payload out to a trace file.
  */
 static void user_event_ftrace(struct user_event *user, struct iov_iter *i,
-			      void *tpdata)
+			      void *tpdata, bool *faulted)
 {
 	struct trace_event_file *file;
 	struct trace_entry *entry;
 	struct trace_event_buffer event_buffer;
+	size_t size = sizeof(*entry) + i->count;
 
 	file = (struct trace_event_file *)tpdata;
 
@@ -556,17 +649,25 @@ static void user_event_ftrace(struct user_event *user, struct iov_iter *i,
 		return;
 
 	/* Allocates and fills trace_entry, + 1 of this is data payload */
-	entry = trace_event_buffer_reserve(&event_buffer, file,
-					   sizeof(*entry) + i->count);
+	entry = trace_event_buffer_reserve(&event_buffer, file, size);
 
 	if (unlikely(!entry))
 		return;
 
 	if (unlikely(!copy_nofault(entry + 1, i->count, i)))
-		__trace_event_discard_commit(event_buffer.buffer,
-					     event_buffer.event);
-	else
-		trace_event_buffer_commit(&event_buffer);
+		goto discard;
+
+	if (!list_empty(&user->validators) &&
+	    unlikely(user_event_validate(user, entry, size)))
+		goto discard;
+
+	trace_event_buffer_commit(&event_buffer);
+
+	return;
+discard:
+	*faulted = true;
+	__trace_event_discard_commit(event_buffer.buffer,
+				     event_buffer.event);
 }
 
 #ifdef CONFIG_PERF_EVENTS
@@ -621,7 +722,7 @@ static void user_event_bpf(struct user_event *user, struct iov_iter *i)
  * Writes the user supplied payload out to perf ring buffer or eBPF program.
  */
 static void user_event_perf(struct user_event *user, struct iov_iter *i,
-			    void *tpdata)
+			    void *tpdata, bool *faulted)
 {
 	struct hlist_head *perf_head;
 
@@ -644,14 +745,21 @@ static void user_event_perf(struct user_event *user, struct iov_iter *i,
 
 		perf_fetch_caller_regs(regs);
 
-		if (unlikely(!copy_nofault(perf_entry + 1, i->count, i))) {
-			perf_swevent_put_recursion_context(context);
-			return;
-		}
+		if (unlikely(!copy_nofault(perf_entry + 1, i->count, i)))
+			goto discard;
+
+		if (!list_empty(&user->validators) &&
+		    unlikely(user_event_validate(user, perf_entry, size)))
+			goto discard;
 
 		perf_trace_buf_submit(perf_entry, size, context,
 				      user->call.event.type, 1, regs,
 				      perf_head, NULL);
+
+		return;
+discard:
+		*faulted = true;
+		perf_swevent_put_recursion_context(context);
 	}
 }
 #endif
@@ -971,6 +1079,7 @@ static int user_event_parse(char *name, char *args, char *flags,
 
 	INIT_LIST_HEAD(&user->class.fields);
 	INIT_LIST_HEAD(&user->fields);
+	INIT_LIST_HEAD(&user->validators);
 
 	user->tracepoint.name = name;
 
@@ -1019,6 +1128,7 @@ static int user_event_parse(char *name, char *args, char *flags,
 	return 0;
 put_user:
 	user_event_destroy_fields(user);
+	user_event_destroy_validators(user);
 	kfree(user);
 	return ret;
 }
@@ -1076,6 +1186,9 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
 	if (unlikely(user == NULL))
 		return -ENOENT;
 
+	if (unlikely(i->count < user->min_size))
+		return -EINVAL;
+
 	tp = &user->tracepoint;
 
 	/*
@@ -1087,10 +1200,13 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
 		user_event_func_t probe_func;
 		struct iov_iter copy;
 		void *tpdata;
+		bool faulted;
 
 		if (unlikely(fault_in_iov_iter_readable(i, i->count)))
 			return -EFAULT;
 
+		faulted = false;
+
 		rcu_read_lock_sched();
 
 		probe_func_ptr = rcu_dereference_sched(tp->funcs);
@@ -1100,11 +1216,14 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
 				copy = *i;
 				probe_func = probe_func_ptr->func;
 				tpdata = probe_func_ptr->data;
-				probe_func(user, &copy, tpdata);
+				probe_func(user, &copy, tpdata, &faulted);
 			} while ((++probe_func_ptr)->func);
 		}
 
 		rcu_read_unlock_sched();
+
+		if (unlikely(faulted))
+			return -EFAULT;
 	}
 
 	return ret;
-- 
2.34.1
