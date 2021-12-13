Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188EC47282A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239188AbhLMKIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbhLMKDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:03:37 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DF0C09CE4E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:50:07 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id r25so49613292edq.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xXegPPtPOndfC/um6fa7hjWe/09fEFMOxsx6gYansIg=;
        b=PURgFoBtBXOpQspt9iT43hDjYGsaBF7QgUCHBxZXFVEQ2ccDllcsQjYsq387ISUGiG
         bD/QxgQFDkNGwHKKj9KTt4cRtffA8AvxYxopdpHieoMXC7uxnp99DUWT/jySorcnIww1
         jQUH7I7WSjlvHo5vMDcNsRdvnDE5v8D0B8ufHTYNBcw0yGe64/XI/JeDc4jIhO2uPYxu
         C3ah+cJgQD9rwT/l1Ds9okyxwy2oNQCzMNH7jJiPqGp/i7cZo79P4m4yawD9Mdf9OF2a
         HKnsrMDUA0CIOCJ8pmJi0VRE6s/b6QeE04Mwa6syVmeSVp3cGa1SbCTn5Hii5rHJtKCc
         oEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xXegPPtPOndfC/um6fa7hjWe/09fEFMOxsx6gYansIg=;
        b=Zftug2lWRaVI7oQVQIeBjmTMbp4y0PfkU60Cq1r6B4ip/XS8nIZxMfADBLHI+XKSBT
         W+Qmka94K3cmsqq0mG/FY8LO5tE0I3E4ZjAMc73/NYmABUsy0PXGUJFgQbP9cxtSYxbq
         HEtJ+lsbOHjR0W48Q72yh4PaTXfrtya4BOF7DYvg1t3yt2hEFfEeG3Pyo7vzHLV5ZrG1
         r/2mfqPPbxsLmiZGT4umYvGMM5sqGlbmFMKyykvCBPouwdKC6V+5NbNsXI2uSJisfeVL
         ourHaIjXZiZB15NMwB8g0vlyb+9yteDhTCSQ3Ew6duBomDg1zZHlrd9JuMzatP7aoWGJ
         vCwA==
X-Gm-Message-State: AOAM532ZH0h8RBoRQl9EEh8w6tUyKeTQDQfbGe2EjcDEjjqpGd8jWgZR
        LEoVm+uwUurTg7T4B78fOAFOHd+lnww=
X-Google-Smtp-Source: ABdhPJyP1lVdvkeSl40px2kn+zIxZw0oj18ZBkQ4LVLB6Z2JmBnJi97ZwSMS1XPITubqOxv+Oes4Yg==
X-Received: by 2002:a17:907:dab:: with SMTP id go43mr42361411ejc.537.1639389005976;
        Mon, 13 Dec 2021 01:50:05 -0800 (PST)
Received: from oberon.zico.biz.zico.biz ([83.222.187.186])
        by smtp.gmail.com with ESMTPSA id qb21sm5789774ejc.78.2021.12.13.01.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 01:50:05 -0800 (PST)
From:   "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] [RFC] tracing: Page size per ring buffer
Date:   Mon, 13 Dec 2021 11:49:59 +0200
Message-Id: <20211213095002.62110-3-tz.stoyanov@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211213095002.62110-1-tz.stoyanov@gmail.com>
References: <20211213095002.62110-1-tz.stoyanov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the size of one sub buffer page is global for all buffers and
it is hard coded to one system page. In order to introduce configurable
ring buffer sub page size, the internal logic should be refactored to
work with sub page size per ring buffer.

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
---
 include/linux/ring_buffer.h |  2 +-
 kernel/trace/ring_buffer.c  | 66 ++++++++++++++++++++-----------------
 kernel/trace/trace.c        |  2 +-
 kernel/trace/trace.h        |  1 +
 kernel/trace/trace_events.c | 50 ++++++++++++++++++++++------
 5 files changed, 79 insertions(+), 42 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index dac53fd3afea..d9a2e6e8fb79 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -200,7 +200,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer, void **data_page,
 struct trace_seq;
 
 int ring_buffer_print_entry_header(struct trace_seq *s);
-int ring_buffer_print_page_header(struct trace_seq *s);
+int ring_buffer_print_page_header(struct trace_buffer *buffer, struct trace_seq *s);
 
 enum ring_buffer_flags {
 	RB_FL_OVERWRITE		= 1 << 0,
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index cc34dbfdd29b..68fdeff449c3 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -366,12 +366,6 @@ static inline int test_time_stamp(u64 delta)
 	return 0;
 }
 
-#define BUF_PAGE_SIZE (PAGE_SIZE - BUF_PAGE_HDR_SIZE)
-
-/* Max payload is BUF_PAGE_SIZE - header (8bytes) */
-#define BUF_MAX_DATA_SIZE (BUF_PAGE_SIZE - (sizeof(u32) * 2))
-
-
 struct rb_irq_work {
 	struct irq_work			work;
 	wait_queue_head_t		waiters;
@@ -515,6 +509,9 @@ struct trace_buffer {
 
 	struct rb_irq_work		irq_work;
 	bool				time_stamp_abs;
+
+	unsigned int			subbuf_size;
+	unsigned int			max_data_size;
 };
 
 struct ring_buffer_iter {
@@ -530,7 +527,7 @@ struct ring_buffer_iter {
 	int				missed_events;
 };
 
-int ring_buffer_print_page_header(struct trace_seq *s)
+int ring_buffer_print_page_header(struct trace_buffer *buffer, struct trace_seq *s)
 {
 	struct buffer_data_page field;
 
@@ -554,7 +551,7 @@ int ring_buffer_print_page_header(struct trace_seq *s)
 	trace_seq_printf(s, "\tfield: char data;\t"
 			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
 			 (unsigned int)offsetof(typeof(field), data),
-			 (unsigned int)BUF_PAGE_SIZE,
+			 (unsigned int)buffer->subbuf_size,
 			 (unsigned int)is_signed_type(char));
 
 	return !trace_seq_has_overflowed(s);
@@ -1726,7 +1723,13 @@ struct trace_buffer *__ring_buffer_alloc(unsigned long size, unsigned flags,
 	if (!zalloc_cpumask_var(&buffer->cpumask, GFP_KERNEL))
 		goto fail_free_buffer;
 
-	nr_pages = DIV_ROUND_UP(size, BUF_PAGE_SIZE);
+	/* Default buffer page size - one system page */
+	buffer->subbuf_size = PAGE_SIZE - BUF_PAGE_HDR_SIZE;
+
+	/* Max payload is buffer page size - header (8bytes) */
+	buffer->max_data_size = buffer->subbuf_size - (sizeof(u32) * 2);
+
+	nr_pages = DIV_ROUND_UP(size, buffer->subbuf_size);
 	buffer->flags = flags;
 	buffer->clock = trace_clock_local;
 	buffer->reader_lock_key = key;
@@ -1920,7 +1923,8 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 			 * Increment overrun to account for the lost events.
 			 */
 			local_add(page_entries, &cpu_buffer->overrun);
-			local_sub(BUF_PAGE_SIZE, &cpu_buffer->entries_bytes);
+			local_sub(cpu_buffer->buffer->subbuf_size,
+				  &cpu_buffer->entries_bytes);
 		}
 
 		/*
@@ -2042,7 +2046,7 @@ static void update_pages_handler(struct work_struct *work)
  * @size: the new size.
  * @cpu_id: the cpu buffer to resize
  *
- * Minimum size is 2 * BUF_PAGE_SIZE.
+ * Minimum size is 2 * buffer->subbuf_size.
  *
  * Returns 0 on success and < 0 on failure.
  */
@@ -2064,7 +2068,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 	    !cpumask_test_cpu(cpu_id, buffer->cpumask))
 		return 0;
 
-	nr_pages = DIV_ROUND_UP(size, BUF_PAGE_SIZE);
+	nr_pages = DIV_ROUND_UP(size, buffer->subbuf_size);
 
 	/* we need a minimum of two pages */
 	if (nr_pages < 2)
@@ -2291,7 +2295,7 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
 	 */
 	barrier();
 
-	if ((iter->head + length) > commit || length > BUF_MAX_DATA_SIZE)
+	if ((iter->head + length) > commit || length > iter->cpu_buffer->buffer->max_data_size)
 		/* Writer corrupted the read? */
 		goto reset;
 
@@ -2404,7 +2408,8 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
 		 * the counters.
 		 */
 		local_add(entries, &cpu_buffer->overrun);
-		local_sub(BUF_PAGE_SIZE, &cpu_buffer->entries_bytes);
+		local_sub(cpu_buffer->buffer->subbuf_size,
+			  &cpu_buffer->entries_bytes);
 
 		/*
 		 * The entries will be zeroed out when we move the
@@ -2523,6 +2528,7 @@ static inline void
 rb_reset_tail(struct ring_buffer_per_cpu *cpu_buffer,
 	      unsigned long tail, struct rb_event_info *info)
 {
+	unsigned long bsize = READ_ONCE(cpu_buffer->buffer->subbuf_size);
 	struct buffer_page *tail_page = info->tail_page;
 	struct ring_buffer_event *event;
 	unsigned long length = info->length;
@@ -2531,13 +2537,13 @@ rb_reset_tail(struct ring_buffer_per_cpu *cpu_buffer,
 	 * Only the event that crossed the page boundary
 	 * must fill the old tail_page with padding.
 	 */
-	if (tail >= BUF_PAGE_SIZE) {
+	if (tail >= bsize) {
 		/*
 		 * If the page was filled, then we still need
 		 * to update the real_end. Reset it to zero
 		 * and the reader will ignore it.
 		 */
-		if (tail == BUF_PAGE_SIZE)
+		if (tail == bsize)
 			tail_page->real_end = 0;
 
 		local_sub(length, &tail_page->write);
@@ -2547,7 +2553,7 @@ rb_reset_tail(struct ring_buffer_per_cpu *cpu_buffer,
 	event = __rb_page_index(tail_page, tail);
 
 	/* account for padding bytes */
-	local_add(BUF_PAGE_SIZE - tail, &cpu_buffer->entries_bytes);
+	local_add(bsize - tail, &cpu_buffer->entries_bytes);
 
 	/*
 	 * Save the original length to the meta data.
@@ -2567,7 +2573,7 @@ rb_reset_tail(struct ring_buffer_per_cpu *cpu_buffer,
 	 * If we are less than the minimum size, we don't need to
 	 * worry about it.
 	 */
-	if (tail > (BUF_PAGE_SIZE - RB_EVNT_MIN_SIZE)) {
+	if (tail > (bsize - RB_EVNT_MIN_SIZE)) {
 		/* No room for any events */
 
 		/* Mark the rest of the page with padding */
@@ -2579,13 +2585,13 @@ rb_reset_tail(struct ring_buffer_per_cpu *cpu_buffer,
 	}
 
 	/* Put in a discarded event */
-	event->array[0] = (BUF_PAGE_SIZE - tail) - RB_EVNT_HDR_SIZE;
+	event->array[0] = (bsize - tail) - RB_EVNT_HDR_SIZE;
 	event->type_len = RINGBUF_TYPE_PADDING;
 	/* time delta must be non zero */
 	event->time_delta = 1;
 
 	/* Set write to end of buffer */
-	length = (tail + length) - BUF_PAGE_SIZE;
+	length = (tail + length) - bsize;
 	local_sub(length, &tail_page->write);
 }
 
@@ -3477,7 +3483,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	tail = write - info->length;
 
 	/* See if we shot pass the end of this buffer page */
-	if (unlikely(write > BUF_PAGE_SIZE)) {
+	if (unlikely(write > cpu_buffer->buffer->subbuf_size)) {
 		/* before and after may now different, fix it up*/
 		b_ok = rb_time_read(&cpu_buffer->before_stamp, &info->before);
 		a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
@@ -3686,7 +3692,7 @@ ring_buffer_lock_reserve(struct trace_buffer *buffer, unsigned long length)
 	if (unlikely(atomic_read(&cpu_buffer->record_disabled)))
 		goto out;
 
-	if (unlikely(length > BUF_MAX_DATA_SIZE))
+	if (unlikely(length > buffer->max_data_size))
 		goto out;
 
 	if (unlikely(trace_recursive_lock(cpu_buffer)))
@@ -3836,7 +3842,7 @@ int ring_buffer_write(struct trace_buffer *buffer,
 	if (atomic_read(&cpu_buffer->record_disabled))
 		goto out;
 
-	if (length > BUF_MAX_DATA_SIZE)
+	if (length > buffer->max_data_size)
 		goto out;
 
 	if (unlikely(trace_recursive_lock(cpu_buffer)))
@@ -4958,7 +4964,7 @@ ring_buffer_read_prepare(struct trace_buffer *buffer, int cpu, gfp_t flags)
 	if (!iter)
 		return NULL;
 
-	iter->event = kmalloc(BUF_MAX_DATA_SIZE, flags);
+	iter->event = kmalloc(buffer->max_data_size, flags);
 	if (!iter->event) {
 		kfree(iter);
 		return NULL;
@@ -5076,14 +5082,14 @@ unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
 {
 	/*
 	 * Earlier, this method returned
-	 *	BUF_PAGE_SIZE * buffer->nr_pages
+	 *	buffer->subbuf_size * buffer->nr_pages
 	 * Since the nr_pages field is now removed, we have converted this to
 	 * return the per cpu buffer value.
 	 */
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return 0;
 
-	return BUF_PAGE_SIZE * buffer->buffers[cpu]->nr_pages;
+	return buffer->subbuf_size * buffer->buffers[cpu]->nr_pages;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_size);
 
@@ -5619,7 +5625,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	} else {
 		/* update the entry counter */
 		cpu_buffer->read += rb_page_entries(reader);
-		cpu_buffer->read_bytes += BUF_PAGE_SIZE;
+		cpu_buffer->read_bytes += buffer->subbuf_size;
 
 		/* swap the pages */
 		rb_init_page(bpage);
@@ -5650,7 +5656,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		/* If there is room at the end of the page to save the
 		 * missed events, then record it there.
 		 */
-		if (BUF_PAGE_SIZE - commit >= sizeof(missed_events)) {
+		if (buffer->subbuf_size - commit >= sizeof(missed_events)) {
 			memcpy(&bpage->data[commit], &missed_events,
 			       sizeof(missed_events));
 			local_add(RB_MISSED_STORED, &bpage->commit);
@@ -5662,8 +5668,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	/*
 	 * This page may be off to user land. Zero it out here.
 	 */
-	if (commit < BUF_PAGE_SIZE)
-		memset(&bpage->data[commit], 0, BUF_PAGE_SIZE - commit);
+	if (commit < buffer->subbuf_size)
+		memset(&bpage->data[commit], 0, buffer->subbuf_size - commit);
 
  out_unlock:
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 88de94da596b..0eb8af875184 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4877,7 +4877,7 @@ static int tracing_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static int tracing_release_generic_tr(struct inode *inode, struct file *file)
+int tracing_release_generic_tr(struct inode *inode, struct file *file)
 {
 	struct trace_array *tr = inode->i_private;
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 38715aa6cfdf..101be5d43117 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -580,6 +580,7 @@ void tracing_reset_current(int cpu);
 void tracing_reset_all_online_cpus(void);
 int tracing_open_generic(struct inode *inode, struct file *filp);
 int tracing_open_generic_tr(struct inode *inode, struct file *filp);
+int tracing_release_generic_tr(struct inode *inode, struct file *file);
 bool tracing_is_disabled(void);
 bool tracer_tracing_is_on(struct trace_array *tr);
 void tracer_tracing_on(struct trace_array *tr);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 92be9cb1d7d4..7424c20514ec 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1847,9 +1847,9 @@ subsystem_filter_write(struct file *filp, const char __user *ubuf, size_t cnt,
 }
 
 static ssize_t
-show_header(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
+show_header_page_file(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
 {
-	int (*func)(struct trace_seq *s) = filp->private_data;
+	struct trace_array *tr = filp->private_data;
 	struct trace_seq *s;
 	int r;
 
@@ -1862,7 +1862,31 @@ show_header(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
 
 	trace_seq_init(s);
 
-	func(s);
+	ring_buffer_print_page_header(tr->array_buffer.buffer, s);
+	r = simple_read_from_buffer(ubuf, cnt, ppos,
+				    s->buffer, trace_seq_used(s));
+
+	kfree(s);
+
+	return r;
+}
+
+static ssize_t
+show_header_event_file(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
+{
+	struct trace_seq *s;
+	int r;
+
+	if (*ppos)
+		return 0;
+
+	s = kmalloc(sizeof(*s), GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+
+	trace_seq_init(s);
+
+	ring_buffer_print_entry_header(s);
 	r = simple_read_from_buffer(ubuf, cnt, ppos,
 				    s->buffer, trace_seq_used(s));
 
@@ -2117,10 +2141,18 @@ static const struct file_operations ftrace_tr_enable_fops = {
 	.release = subsystem_release,
 };
 
-static const struct file_operations ftrace_show_header_fops = {
-	.open = tracing_open_generic,
-	.read = show_header,
+static const struct file_operations ftrace_show_header_page_fops = {
+	.open = tracing_open_generic_tr,
+	.read = show_header_page_file,
+	.llseek = default_llseek,
+	.release = tracing_release_generic_tr,
+};
+
+static const struct file_operations ftrace_show_header_event_fops = {
+	.open = tracing_open_generic_tr,
+	.read = show_header_event_file,
 	.llseek = default_llseek,
+	.release = tracing_release_generic_tr,
 };
 
 static int
@@ -3481,14 +3513,12 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 
 	/* ring buffer internal formats */
 	entry = trace_create_file("header_page", TRACE_MODE_READ, d_events,
-				  ring_buffer_print_page_header,
-				  &ftrace_show_header_fops);
+				  tr, &ftrace_show_header_page_fops);
 	if (!entry)
 		pr_warn("Could not create tracefs 'header_page' entry\n");
 
 	entry = trace_create_file("header_event", TRACE_MODE_READ, d_events,
-				  ring_buffer_print_entry_header,
-				  &ftrace_show_header_fops);
+				  tr, &ftrace_show_header_event_fops);
 	if (!entry)
 		pr_warn("Could not create tracefs 'header_event' entry\n");
 
-- 
2.31.1

