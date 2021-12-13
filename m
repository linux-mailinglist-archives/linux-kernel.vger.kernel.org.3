Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750A5472826
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237284AbhLMKIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239416AbhLMKDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:03:47 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54675C09CE5A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:50:10 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r25so49613709edq.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fNsh/vSNMVjdkAA/uLVUou4tO/BNCqM78wfdDeHlaFM=;
        b=H85dp9RPYwZxC/StwEAi3Y2vVA1qh6vsVJ8ojQ6wETc30U4eq3h3vRTF1K1Rgsa9tM
         2FgPWT01wQLhZP1KWsJgiYiGiMVs8se6XEfV1zzMRQ4ESj66qlOO+Ep1ws6AHWTQIzqi
         VzOrEAhh13TOGMdq60HGn1INk+PKKklF4cSD3AtQ+0TdvPGCIDUNSwXz/X/ZqnrVvN+5
         lmFPMsVO4YQlq6xCGcBrDTL+tp2T3wPaZ3zDHCy7btpTalrnIqmeHdxQyXNc38JQuVU0
         LNuSpoNQx69C0Yj0bCJGW1j4jzM5G/b2yJBMD5Rsnsm80LSz8W3t7kYE/uNUjra8fBQT
         caqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fNsh/vSNMVjdkAA/uLVUou4tO/BNCqM78wfdDeHlaFM=;
        b=Gc3OJJB6Iu8+/Wyc+UwNIb1FYFwJl5XzLCwfOaqUEzHL/IltKyZvjXmiyZeCYxtbGq
         ol3sAKBZRfWNpiGKaoHZV2HBm9rk05Kbqb8zV7BaVtzLVg7RD1FJpMT57l2IkXONWKab
         +gb0yWlVEDiiYDW47+3nKWpTidMbWV/STOtYmzPVOw9vbywsZz8Sx1sxKzdgKAHvlCk3
         q0MR38Bh1bvtQC8JTnMBW3O1gtQ0xUQ8x5TRhoKHTEzTh5971/VvYzqH9VoZ6iLlVPwS
         WdZDSnTYjNWQ0WBgfBfqD3g1jjmXo2AlB9OAZEZKBAkhP6EP2QN36wp0P/RgZSb1ezu1
         vB2g==
X-Gm-Message-State: AOAM531Xu1bKv2Txeguz7aFWKbTmVqi2X4Abd/6Po3NxHBQRwpBcfW26
        9VzvU9/krkPBwDdF7o4VM1lD4bm4dnk=
X-Google-Smtp-Source: ABdhPJzx0DUtpDk0YMkuZWSJNehrAFjQrPnz7+ImTm8XkNxVdCoLWxIRI/TajPU8iPV3Qv4CoKH1Yg==
X-Received: by 2002:a17:906:e85:: with SMTP id p5mr42541814ejf.159.1639389008883;
        Mon, 13 Dec 2021 01:50:08 -0800 (PST)
Received: from oberon.zico.biz.zico.biz ([83.222.187.186])
        by smtp.gmail.com with ESMTPSA id qb21sm5789774ejc.78.2021.12.13.01.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 01:50:08 -0800 (PST)
From:   "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] [RFC] tracing: Read and write to ring buffers with custom sub buffer size
Date:   Mon, 13 Dec 2021 11:50:02 +0200
Message-Id: <20211213095002.62110-6-tz.stoyanov@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211213095002.62110-1-tz.stoyanov@gmail.com>
References: <20211213095002.62110-1-tz.stoyanov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the size of the ring sub buffer page can be changed dynamically,
the logic that reads and writes to the buffer should be fixed to take
that into account. Some internal ring buffer APIs are changed:
 ring_buffer_alloc_read_page()
 ring_buffer_free_read_page()
 ring_buffer_read_page()
A new API is introduced:
 ring_buffer_read_page_data()

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
---
 include/linux/ring_buffer.h          | 11 ++--
 kernel/trace/ring_buffer.c           | 75 ++++++++++++++++++++--------
 kernel/trace/ring_buffer_benchmark.c | 10 ++--
 kernel/trace/trace.c                 | 34 +++++++------
 4 files changed, 89 insertions(+), 41 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 9103462f6e85..8d6807e3865d 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -192,10 +192,15 @@ bool ring_buffer_time_stamp_abs(struct trace_buffer *buffer);
 size_t ring_buffer_nr_pages(struct trace_buffer *buffer, int cpu);
 size_t ring_buffer_nr_dirty_pages(struct trace_buffer *buffer, int cpu);
 
-void *ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu);
-void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu, void *data);
-int ring_buffer_read_page(struct trace_buffer *buffer, void **data_page,
+struct buffer_data_read_page;
+struct buffer_data_read_page *
+ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu);
+void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
+				struct buffer_data_read_page *page);
+int ring_buffer_read_page(struct trace_buffer *buffer,
+			  struct buffer_data_read_page *data_page,
 			  size_t len, int cpu, int full);
+void *ring_buffer_read_page_data(struct buffer_data_read_page *page);
 
 struct trace_seq;
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a40fcb1cb299..fd22e0fc7195 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -309,6 +309,11 @@ struct buffer_data_page {
 	unsigned char	 data[] RB_ALIGN_DATA;	/* data of buffer page */
 };
 
+struct buffer_data_read_page {
+	unsigned		order;	/* order of the page */
+	struct buffer_data_page	*data;	/* actual data, stored in this page */
+};
+
 /*
  * Note, the buffer_page list must be first. The buffer pages
  * are allocated in cache lines, which means that each buffer
@@ -5414,40 +5419,48 @@ EXPORT_SYMBOL_GPL(ring_buffer_swap_cpu);
  * Returns:
  *  The page allocated, or ERR_PTR
  */
-void *ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
+struct buffer_data_read_page *
+ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	struct buffer_data_page *bpage = NULL;
+	struct buffer_data_read_page *bpage = NULL;
 	unsigned long flags;
 	struct page *page;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return ERR_PTR(-ENODEV);
 
+	bpage = kzalloc(sizeof(*bpage), GFP_KERNEL);
+	if (!bpage)
+		return ERR_PTR(-ENOMEM);
+
+	bpage->order = buffer->subbuf_order;
 	cpu_buffer = buffer->buffers[cpu];
 	local_irq_save(flags);
 	arch_spin_lock(&cpu_buffer->lock);
 
 	if (cpu_buffer->free_page) {
-		bpage = cpu_buffer->free_page;
+		bpage->data = cpu_buffer->free_page;
 		cpu_buffer->free_page = NULL;
 	}
 
 	arch_spin_unlock(&cpu_buffer->lock);
 	local_irq_restore(flags);
 
-	if (bpage)
+	if (bpage->data)
 		goto out;
 
 	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_NORETRY,
 				cpu_buffer->buffer->subbuf_order);
-	if (!page)
+	if (!page) {
+		kfree(bpage);
 		return ERR_PTR(-ENOMEM);
+	}
 
-	bpage = page_address(page);
+	bpage->data = page_address(page);
 
  out:
-	rb_init_page(bpage);
+	rb_init_page(bpage->data);
 
 	return bpage;
 }
@@ -5457,19 +5470,24 @@ EXPORT_SYMBOL_GPL(ring_buffer_alloc_read_page);
  * ring_buffer_free_read_page - free an allocated read page
  * @buffer: the buffer the page was allocate for
  * @cpu: the cpu buffer the page came from
- * @data: the page to free
+ * @page: the page to free
  *
  * Free a page allocated from ring_buffer_alloc_read_page.
  */
-void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu, void *data)
+void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
+				struct buffer_data_read_page *data_page)
 {
 	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
-	struct buffer_data_page *bpage = data;
+	struct buffer_data_page *bpage = data_page->data;
 	struct page *page = virt_to_page(bpage);
 	unsigned long flags;
 
-	/* If the page is still in use someplace else, we can't reuse it */
-	if (page_ref_count(page) > 1)
+	/*
+	 * If the page is still in use someplace else, or order of the page
+	 * is different from the subbuffer order of the buffer -
+	 * we can't reuse it
+	 */
+	if (page_ref_count(page) > 1 || data_page->order != buffer->subbuf_order)
 		goto out;
 
 	local_irq_save(flags);
@@ -5484,7 +5502,8 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu, void *data
 	local_irq_restore(flags);
 
  out:
-	free_pages((unsigned long)bpage, buffer->subbuf_order);
+	free_pages((unsigned long)bpage, data_page->order);
+	kfree(data_page);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_free_read_page);
 
@@ -5505,9 +5524,10 @@ EXPORT_SYMBOL_GPL(ring_buffer_free_read_page);
  *	rpage = ring_buffer_alloc_read_page(buffer, cpu);
  *	if (IS_ERR(rpage))
  *		return PTR_ERR(rpage);
- *	ret = ring_buffer_read_page(buffer, &rpage, len, cpu, 0);
+ *	ret = ring_buffer_read_page(buffer, rpage, len, cpu, 0);
  *	if (ret >= 0)
- *		process_page(rpage, ret);
+ *		process_page(ring_buffer_read_page_data(rpage), ret);
+ *	ring_buffer_free_read_page(buffer, cpu, rpage);
  *
  * When @full is set, the function will not return true unless
  * the writer is off the reader page.
@@ -5522,7 +5542,8 @@ EXPORT_SYMBOL_GPL(ring_buffer_free_read_page);
  *  <0 if no data has been transferred.
  */
 int ring_buffer_read_page(struct trace_buffer *buffer,
-			  void **data_page, size_t len, int cpu, int full)
+			  struct buffer_data_read_page *data_page,
+			  size_t len, int cpu, int full)
 {
 	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
 	struct ring_buffer_event *event;
@@ -5547,10 +5568,12 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 
 	len -= BUF_PAGE_HDR_SIZE;
 
-	if (!data_page)
+	if (!data_page || !data_page->data)
+		goto out;
+	if (data_page->order != buffer->subbuf_order)
 		goto out;
 
-	bpage = *data_page;
+	bpage = data_page->data;
 	if (!bpage)
 		goto out;
 
@@ -5636,11 +5659,11 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		/* swap the pages */
 		rb_init_page(bpage);
 		bpage = reader->page;
-		reader->page = *data_page;
+		reader->page = data_page->data;
 		local_set(&reader->write, 0);
 		local_set(&reader->entries, 0);
 		reader->read = 0;
-		*data_page = bpage;
+		data_page->data = bpage;
 
 		/*
 		 * Use the real_end for the data size,
@@ -5685,6 +5708,18 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 }
 EXPORT_SYMBOL_GPL(ring_buffer_read_page);
 
+/**
+ * ring_buffer_read_page_data - get pointer to the data in the page.
+ * @page:  the page to get the data from
+ *
+ * Returns pointer to the actual data in this page.
+ */
+void *ring_buffer_read_page_data(struct buffer_data_read_page *page)
+{
+	return page->data;
+}
+EXPORT_SYMBOL_GPL(ring_buffer_read_page_data);
+
 /**
  * ring_buffer_subbuf_size_get - get size of the sub buffer.
  * @buffer: the buffer to get the sub buffer size from
diff --git a/kernel/trace/ring_buffer_benchmark.c b/kernel/trace/ring_buffer_benchmark.c
index 78e576575b79..7202d6d650e6 100644
--- a/kernel/trace/ring_buffer_benchmark.c
+++ b/kernel/trace/ring_buffer_benchmark.c
@@ -104,10 +104,11 @@ static enum event_status read_event(int cpu)
 
 static enum event_status read_page(int cpu)
 {
+	struct buffer_data_read_page *bpage;
 	struct ring_buffer_event *event;
 	struct rb_page *rpage;
 	unsigned long commit;
-	void *bpage;
+	int page_size;
 	int *entry;
 	int ret;
 	int inc;
@@ -117,14 +118,15 @@ static enum event_status read_page(int cpu)
 	if (IS_ERR(bpage))
 		return EVENT_DROPPED;
 
-	ret = ring_buffer_read_page(buffer, &bpage, PAGE_SIZE, cpu, 1);
+	page_size = ring_buffer_subbuf_size_get(buffer);
+	ret = ring_buffer_read_page(buffer, bpage, page_size, cpu, 1);
 	if (ret >= 0) {
-		rpage = bpage;
+		rpage = ring_buffer_read_page_data(bpage);
 		/* The commit may have missed event flags set, clear them */
 		commit = local_read(&rpage->commit) & 0xfffff;
 		for (i = 0; i < commit && !test_error ; i += inc) {
 
-			if (i >= (PAGE_SIZE - offsetof(struct rb_page, data))) {
+			if (i >= (page_size - offsetof(struct rb_page, data))) {
 				TEST_ERROR();
 				break;
 			}
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 867a220b4ef2..edcf30ea1d25 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8004,6 +8004,8 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 {
 	struct ftrace_buffer_info *info = filp->private_data;
 	struct trace_iterator *iter = &info->iter;
+	void *trace_data;
+	int page_size;
 	ssize_t ret = 0;
 	ssize_t size;
 
@@ -8015,6 +8017,8 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 		return -EBUSY;
 #endif
 
+	page_size = ring_buffer_subbuf_size_get(iter->array_buffer->buffer);
+
 	if (!info->spare) {
 		info->spare = ring_buffer_alloc_read_page(iter->array_buffer->buffer,
 							  iter->cpu_file);
@@ -8029,13 +8033,13 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 		return ret;
 
 	/* Do we have previous read data to read? */
-	if (info->read < PAGE_SIZE)
+	if (info->read < page_size)
 		goto read;
 
  again:
 	trace_access_lock(iter->cpu_file);
 	ret = ring_buffer_read_page(iter->array_buffer->buffer,
-				    &info->spare,
+				    info->spare,
 				    count,
 				    iter->cpu_file, 0);
 	trace_access_unlock(iter->cpu_file);
@@ -8056,11 +8060,11 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 
 	info->read = 0;
  read:
-	size = PAGE_SIZE - info->read;
+	size = page_size - info->read;
 	if (size > count)
 		size = count;
-
-	ret = copy_to_user(ubuf, info->spare + info->read, size);
+	trace_data = ring_buffer_read_page_data(info->spare);
+	ret = copy_to_user(ubuf, trace_data + info->read, size);
 	if (ret == size)
 		return -EFAULT;
 
@@ -8165,6 +8169,7 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 		.spd_release	= buffer_spd_release,
 	};
 	struct buffer_ref *ref;
+	int page_size;
 	int entries, i;
 	ssize_t ret = 0;
 
@@ -8173,13 +8178,14 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 		return -EBUSY;
 #endif
 
-	if (*ppos & (PAGE_SIZE - 1))
+	page_size = ring_buffer_subbuf_size_get(iter->array_buffer->buffer);
+	if (*ppos & (page_size - 1))
 		return -EINVAL;
 
-	if (len & (PAGE_SIZE - 1)) {
-		if (len < PAGE_SIZE)
+	if (len & (page_size - 1)) {
+		if (len < page_size)
 			return -EINVAL;
-		len &= PAGE_MASK;
+		len &= (~(page_size - 1));
 	}
 
 	if (splice_grow_spd(pipe, &spd))
@@ -8189,7 +8195,7 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 	trace_access_lock(iter->cpu_file);
 	entries = ring_buffer_entries_cpu(iter->array_buffer->buffer, iter->cpu_file);
 
-	for (i = 0; i < spd.nr_pages_max && len && entries; i++, len -= PAGE_SIZE) {
+	for (i = 0; i < spd.nr_pages_max && len && entries; i++, len -= page_size) {
 		struct page *page;
 		int r;
 
@@ -8210,7 +8216,7 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 		}
 		ref->cpu = iter->cpu_file;
 
-		r = ring_buffer_read_page(ref->buffer, &ref->page,
+		r = ring_buffer_read_page(ref->buffer, ref->page,
 					  len, iter->cpu_file, 1);
 		if (r < 0) {
 			ring_buffer_free_read_page(ref->buffer, ref->cpu,
@@ -8219,14 +8225,14 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 			break;
 		}
 
-		page = virt_to_page(ref->page);
+		page = virt_to_page(ring_buffer_read_page_data(ref->page));
 
 		spd.pages[i] = page;
-		spd.partial[i].len = PAGE_SIZE;
+		spd.partial[i].len = page_size;
 		spd.partial[i].offset = 0;
 		spd.partial[i].private = (unsigned long)ref;
 		spd.nr_pages++;
-		*ppos += PAGE_SIZE;
+		*ppos += page_size;
 
 		entries = ring_buffer_entries_cpu(iter->array_buffer->buffer, iter->cpu_file);
 	}
-- 
2.31.1

