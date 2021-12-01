Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945C3465561
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbhLAS3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:29:50 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48046 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352394AbhLAS2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:28:42 -0500
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id A76BF20E61CC;
        Wed,  1 Dec 2021 10:25:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A76BF20E61CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1638383121;
        bh=qA/z8XkOUoZCT+HNyBQpWdWGIu+94sIk0wd6Ka4GYak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p16OjJNcV4n0UayADPQL7bxotziHXMku4C0z9TDxzPg0H9i+gxbmD4XNkLgV26cTk
         geuqrInaVdBRVFvHOQBjNQn3WO4OO2oxjlqa1ERYCa2U6/5j8dKc1gCks2RioS52ku
         OgQsOsfhTm/oe4pXXI4NxUjLr3PrKZA/ECCICyH8=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        beaub@linux.microsoft.com
Subject: [PATCH v6 12/13] user_events: Validate user payloads for size and null termination
Date:   Wed,  1 Dec 2021 10:25:14 -0800
Message-Id: <20211201182515.2446-13-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211201182515.2446-1-beaub@linux.microsoft.com>
References: <20211201182515.2446-1-beaub@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add validation to ensure data is at or greater than the min size for the
fields of the event. If a dynamic array is used and is a type of char,
ensure null termination of the array exists. Add unit test cases for the
above scenarios.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 include/uapi/linux/user_events.h              |   3 +
 kernel/trace/trace_events_user.c              | 151 ++++++++++++++++--
 .../selftests/user_events/ftrace_test.c       |  83 ++++++++++
 3 files changed, 220 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/user_events.h b/include/uapi/linux/user_events.h
index 5bff99418deb..f97db05e00c9 100644
--- a/include/uapi/linux/user_events.h
+++ b/include/uapi/linux/user_events.h
@@ -29,6 +29,9 @@
 #define EVENT_STATUS_PERF (1 << EVENT_BIT_PERF)
 #define EVENT_STATUS_OTHER (1 << EVENT_BIT_OTHER)
 
+/* Create dynamic location entry within a 32-bit value */
+#define DYN_LOC(offset, size) ((size) << 16 | (offset))
+
 /* Use raw iterator for attached BPF program(s), no affect on ftrace/perf */
 #define FLAG_BPF_ITER (1 << 0)
 
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 4f80f9a99542..b487d02acedf 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -38,7 +38,7 @@
 /* Limit how long of an event name plus args within the subsystem. */
 #define MAX_EVENT_DESC 512
 #define EVENT_NAME(user_event) ((user_event)->tracepoint.name)
-#define MAX_FIELD_ARRAY_SIZE (2 * PAGE_SIZE)
+#define MAX_FIELD_ARRAY_SIZE 1024
 #define MAX_FIELD_ARG_NAME 256
 
 #define MAX_BPF_COPY_SIZE PAGE_SIZE
@@ -65,9 +65,11 @@ struct user_event {
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
@@ -82,8 +84,17 @@ struct user_event_refs {
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
@@ -200,6 +211,17 @@ static int user_field_size(const char *type)
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
@@ -215,13 +237,43 @@ static int user_event_add_field(struct user_event *user, const char *type,
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
+	if (strstr(type, "char[") != 0)
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
@@ -231,6 +283,12 @@ static int user_event_add_field(struct user_event *user, const char *type,
 
 	list_add(&field->link, &user->fields);
 
+	/*
+	 * Min size from user writes that are required, this does not include
+	 * the size of trace_entry (common fields).
+	 */
+	user->min_size = (offset + size) - sizeof(struct trace_entry);
+
 	return 0;
 }
 
@@ -494,6 +552,7 @@ static int destroy_user_event(struct user_event *user)
 	clear_bit(user->index, page_bitmap);
 	hash_del(&user->node);
 
+	user_event_destroy_validators(user);
 	kfree(user->call.print_fmt);
 	kfree(EVENT_NAME(user));
 	kfree(user);
@@ -515,15 +574,49 @@ static struct user_event *find_user_event(char *name, u32 *outkey)
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
+			if (unlikely(*(char *)(pos - 1) != 0))
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
 
@@ -533,19 +626,25 @@ static void user_event_ftrace(struct user_event *user, struct iov_iter *i,
 		return;
 
 	/* Allocates and fills trace_entry, + 1 of this is data payload */
-	entry = trace_event_buffer_reserve(&event_buffer, file,
-					   sizeof(*entry) + i->count);
+	entry = trace_event_buffer_reserve(&event_buffer, file, size);
 
 	if (unlikely(!entry))
 		return;
 
-	if (unlikely(!copy_nofault(entry + 1, i->count, i))) {
-		__trace_event_discard_commit(event_buffer.buffer,
-					     event_buffer.event);
-		return;
-	}
+	if (unlikely(!copy_nofault(entry + 1, i->count, i)))
+		goto discard;
+
+	if (!list_empty(&user->validators) &&
+	    unlikely(user_event_validate(user, entry, size)))
+		goto discard;
 
 	trace_event_buffer_commit(&event_buffer);
+
+	return;
+discard:
+	*faulted = true;
+	__trace_event_discard_commit(event_buffer.buffer,
+				     event_buffer.event);
 }
 
 #ifdef CONFIG_PERF_EVENTS
@@ -573,7 +672,7 @@ static void user_event_bpf(struct user_event *user, struct iov_iter *i)
 	} else {
 		/* Multi buffer from user */
 		struct iov_iter copy = *i;
-		size_t copy_size = min(i->count, (size_t)MAX_BPF_COPY_SIZE);
+		size_t copy_size = min_t(size_t, i->count, MAX_BPF_COPY_SIZE);
 
 		context.data_type = USER_BPF_DATA_KERNEL;
 		context.kdata = fast_data;
@@ -600,7 +699,7 @@ static void user_event_bpf(struct user_event *user, struct iov_iter *i)
  * Writes the user supplied payload out to perf ring buffer or eBPF program.
  */
 static void user_event_perf(struct user_event *user, struct iov_iter *i,
-			    void *tpdata)
+			    void *tpdata, bool *faulted)
 {
 	struct hlist_head *perf_head;
 
@@ -623,14 +722,21 @@ static void user_event_perf(struct user_event *user, struct iov_iter *i,
 
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
@@ -945,6 +1051,7 @@ static int user_event_parse(char *name, char *args, char *flags,
 
 	INIT_LIST_HEAD(&user->class.fields);
 	INIT_LIST_HEAD(&user->fields);
+	INIT_LIST_HEAD(&user->validators);
 
 	user->tracepoint.name = name;
 
@@ -993,6 +1100,7 @@ static int user_event_parse(char *name, char *args, char *flags,
 	return 0;
 put_user:
 	user_event_destroy_fields(user);
+	user_event_destroy_validators(user);
 	kfree(user);
 	return ret;
 }
@@ -1050,6 +1158,9 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
 	if (unlikely(user == NULL))
 		return -ENOENT;
 
+	if (unlikely(i->count < user->min_size))
+		return -EINVAL;
+
 	tp = &user->tracepoint;
 
 	/*
@@ -1061,10 +1172,13 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
 		user_event_func_t probe_func;
 		struct iov_iter copy;
 		void *tpdata;
+		bool faulted;
 
 		if (unlikely(iov_iter_fault_in_readable(i, i->count)))
 			return -EFAULT;
 
+		faulted = false;
+
 		rcu_read_lock_sched();
 		pagefault_disable();
 
@@ -1075,12 +1189,15 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
 				copy = *i;
 				probe_func = probe_func_ptr->func;
 				tpdata = probe_func_ptr->data;
-				probe_func(user, &copy, tpdata);
+				probe_func(user, &copy, tpdata, &faulted);
 			} while ((++probe_func_ptr)->func);
 		}
 
 		pagefault_enable();
 		rcu_read_unlock_sched();
+
+		if (unlikely(faulted))
+			return -EFAULT;
 	}
 
 	return ret;
diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index 9d53717139e6..16aff1fb295a 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -47,6 +47,22 @@ static int trace_bytes(void)
 	return bytes;
 }
 
+static int clear(void)
+{
+	int fd = open(data_file, O_RDWR);
+
+	if (fd == -1)
+		return -1;
+
+	if (ioctl(fd, DIAG_IOCSDEL, "__test_event") == -1)
+		if (errno != ENOENT)
+			return -1;
+
+	close(fd);
+
+	return 0;
+}
+
 FIXTURE(user) {
 	int status_fd;
 	int data_fd;
@@ -71,6 +87,8 @@ FIXTURE_TEARDOWN(user) {
 		write(self->enable_fd, "0", sizeof("0"));
 		close(self->enable_fd);
 	}
+
+	ASSERT_EQ(0, clear());
 }
 
 TEST_F(user, register_events) {
@@ -199,6 +217,71 @@ TEST_F(user, write_fault) {
 	ASSERT_EQ(0, munmap(anon, l));
 }
 
+TEST_F(user, write_validator) {
+	struct user_reg reg = {0};
+	struct iovec io[3];
+	int loc, bytes;
+	char data[8];
+	int before = 0, after = 0;
+
+	reg.size = sizeof(reg);
+	reg.name_args = (__u64)"__test_event __rel_loc char[] data";
+
+	/* Register should work */
+	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
+	ASSERT_EQ(0, reg.write_index);
+	ASSERT_NE(0, reg.status_index);
+
+	io[0].iov_base = &reg.write_index;
+	io[0].iov_len = sizeof(reg.write_index);
+	io[1].iov_base = &loc;
+	io[1].iov_len = sizeof(loc);
+	io[2].iov_base = data;
+	bytes = snprintf(data, sizeof(data), "Test") + 1;
+	io[2].iov_len = bytes;
+
+	/* Undersized write should fail */
+	ASSERT_EQ(-1, writev(self->data_fd, (const struct iovec *)io, 1));
+	ASSERT_EQ(EINVAL, errno);
+
+	/* Enable event */
+	self->enable_fd = open(enable_file, O_RDWR);
+	ASSERT_NE(-1, write(self->enable_fd, "1", sizeof("1")))
+
+	/* Full in-bounds write should work */
+	before = trace_bytes();
+	loc = DYN_LOC(0, bytes);
+	ASSERT_NE(-1, writev(self->data_fd, (const struct iovec *)io, 3));
+	after = trace_bytes();
+	ASSERT_GT(after, before);
+
+	/* Out of bounds write should fault (offset way out) */
+	loc = DYN_LOC(1024, bytes);
+	ASSERT_EQ(-1, writev(self->data_fd, (const struct iovec *)io, 3));
+	ASSERT_EQ(EFAULT, errno);
+
+	/* Out of bounds write should fault (offset 1 byte out) */
+	loc = DYN_LOC(1, bytes);
+	ASSERT_EQ(-1, writev(self->data_fd, (const struct iovec *)io, 3));
+	ASSERT_EQ(EFAULT, errno);
+
+	/* Out of bounds write should fault (size way out) */
+	loc = DYN_LOC(0, bytes + 1024);
+	ASSERT_EQ(-1, writev(self->data_fd, (const struct iovec *)io, 3));
+	ASSERT_EQ(EFAULT, errno);
+
+	/* Out of bounds write should fault (size 1 byte out) */
+	loc = DYN_LOC(0, bytes + 1);
+	ASSERT_EQ(-1, writev(self->data_fd, (const struct iovec *)io, 3));
+	ASSERT_EQ(EFAULT, errno);
+
+	/* Non-Null should fault */
+	memset(data, 'A', sizeof(data));
+	loc = DYN_LOC(0, bytes);
+	ASSERT_EQ(-1, writev(self->data_fd, (const struct iovec *)io, 3));
+	ASSERT_EQ(EFAULT, errno);
+}
+
 int main(int argc, char **argv)
 {
 	return test_harness_run(argc, argv);
-- 
2.17.1

