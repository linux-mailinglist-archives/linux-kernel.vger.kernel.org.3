Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA1C472816
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbhLMKIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239512AbhLMKDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:03:48 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D9AC09CE57
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:50:09 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w1so49884850edc.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dEBZrJY7x9+p5wonW466oAoCm/VHVN/Kkq9coJG1KbM=;
        b=O5nWTAyXNAkUChCH/QI6LK8Lwz9l3gothhuXeguNbUu1qzodHmk31/NTpN2W0A0aU0
         ZR01bpqRfU9cCGOi303g3/+N1G7mVF4G/3Hw5LHQF7J+WvpyBEzn6T8UOYTgPmc9KpB4
         WqDCFFc9J11uMEr2loFlAILbok/bOJ955Scia+qu990DXGe82btCY9qGY3tv4E8AGBwJ
         QdER5a39S5gr4N5WnB6sOvQRhdePi277touZcwXCs2qCuK0YJmB9p6yT6tPqVIjsNn58
         8JuN0EMTkPpuHZTA0SB1x9xSXnztL9d5aXi1WDYxlF3+fCe3rq7cLL0+nVxmdR2BG0CW
         NuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dEBZrJY7x9+p5wonW466oAoCm/VHVN/Kkq9coJG1KbM=;
        b=7CZfyE4A272PUWLWrig0hE0evIlvFf3zztF4Sn5usZiZj4lrP4TUF0yk33C7bstQgO
         192V7fLd2N4rw0yUoB7QP/QrSUhrSissLKxBsJBdUTpDuhJZP5amPUSovJLKg5LakeCw
         E5zcWA4QurE5275LOlxdjrOr3KssvrB3TlNc+X7Tr21p8uHheOeJVW37fsgpH8Is9qDD
         UsMuXLwlJupM+TkOcMNNFxLUfNOScq1b1AnlID5O/yP876WRDh88DPJk0E4IrdogcQYJ
         SfTyEUXBG3NOxNSZzvCS+x6nie6U7gkSB9x/FqaD5gZgfaQSa5zy4nkMLHuXWYvetU/B
         1qfg==
X-Gm-Message-State: AOAM533g7HnwvCcIs+f/a49edIVerEJMFmEGAuS9FsHChJTVvx8Twu/a
        4S/ol4ci2iGSQluqTMdOLblOFBvnLO0=
X-Google-Smtp-Source: ABdhPJxFdWguz78kYJrbAak05LoUMRqxwcwgXlkRs+9tZyQCAcjkRPWLzI10L1OsEvpl75efZ1ejwQ==
X-Received: by 2002:a05:6402:2789:: with SMTP id b9mr60986513ede.28.1639389007890;
        Mon, 13 Dec 2021 01:50:07 -0800 (PST)
Received: from oberon.zico.biz.zico.biz ([83.222.187.186])
        by smtp.gmail.com with ESMTPSA id qb21sm5789774ejc.78.2021.12.13.01.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 01:50:07 -0800 (PST)
From:   "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] [RFC] tracing: Set new size of the ring buffer sub page
Date:   Mon, 13 Dec 2021 11:50:01 +0200
Message-Id: <20211213095002.62110-5-tz.stoyanov@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211213095002.62110-1-tz.stoyanov@gmail.com>
References: <20211213095002.62110-1-tz.stoyanov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two approaches when changing the size of the ring buffer
sub page:
 1. Destroying all pages and allocating new pages with the new size.
 2. Allocating new pages, copying the content of the old pages before
    destroying them.
The first approach is easier, it is selected in the proposed
implementation. Changing the ring buffer sub page size is supposed to
not happen frequently. Usually, that size should be set only once,
when the buffer is not in use yet and is supposed to be empty.

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
---
 kernel/trace/ring_buffer.c | 80 ++++++++++++++++++++++++++++++++++----
 1 file changed, 73 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 4aa5361a8f4c..a40fcb1cb299 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -323,6 +323,7 @@ struct buffer_page {
 	unsigned	 read;		/* index for next read */
 	local_t		 entries;	/* entries on this page */
 	unsigned long	 real_end;	/* real end of data */
+	unsigned	 order;		/* order of the page */
 	struct buffer_data_page *page;	/* Actual data page */
 };
 
@@ -352,7 +353,7 @@ static void rb_init_page(struct buffer_data_page *bpage)
  */
 static void free_buffer_page(struct buffer_page *bpage)
 {
-	free_page((unsigned long)bpage->page);
+	free_pages((unsigned long)bpage->page, bpage->order);
 	kfree(bpage);
 }
 
@@ -1563,10 +1564,12 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 
 		list_add(&bpage->list, pages);
 
-		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu), mflags, 0);
+		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu), mflags,
+					cpu_buffer->buffer->subbuf_order);
 		if (!page)
 			goto free_pages;
 		bpage->page = page_address(page);
+		bpage->order = cpu_buffer->buffer->subbuf_order;
 		rb_init_page(bpage->page);
 
 		if (user_thread && fatal_signal_pending(current))
@@ -1645,7 +1648,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	rb_check_bpage(cpu_buffer, bpage);
 
 	cpu_buffer->reader_page = bpage;
-	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, 0);
+
+	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, cpu_buffer->buffer->subbuf_order);
 	if (!page)
 		goto fail_free_reader;
 	bpage->page = page_address(page);
@@ -1725,6 +1729,7 @@ struct trace_buffer *__ring_buffer_alloc(unsigned long size, unsigned flags,
 		goto fail_free_buffer;
 
 	/* Default buffer page size - one system page */
+	buffer->subbuf_order = 0;
 	buffer->subbuf_size = PAGE_SIZE - BUF_PAGE_HDR_SIZE;
 
 	/* Max payload is buffer page size - header (8bytes) */
@@ -5434,8 +5439,8 @@ void *ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	if (bpage)
 		goto out;
 
-	page = alloc_pages_node(cpu_to_node(cpu),
-				GFP_KERNEL | __GFP_NORETRY, 0);
+	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_NORETRY,
+				cpu_buffer->buffer->subbuf_order);
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
@@ -5479,7 +5484,7 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu, void *data
 	local_irq_restore(flags);
 
  out:
-	free_page((unsigned long)bpage);
+	free_pages((unsigned long)bpage, buffer->subbuf_order);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_free_read_page);
 
@@ -5731,7 +5736,13 @@ EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_get);
  */
 int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 {
+	struct ring_buffer_per_cpu **cpu_buffers;
+	int old_order, old_size;
+	int nr_pages;
 	int psize;
+	int bsize;
+	int err;
+	int cpu;
 
 	if (!buffer || order < 0)
 		return -EINVAL;
@@ -5743,12 +5754,67 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	if (psize <= BUF_PAGE_HDR_SIZE)
 		return -EINVAL;
 
+	bsize = sizeof(void *) * buffer->cpus;
+	cpu_buffers = kzalloc(bsize, GFP_KERNEL);
+	if (!cpu_buffers)
+		return -ENOMEM;
+
+	old_order = buffer->subbuf_order;
+	old_size = buffer->subbuf_size;
+
+	/* prevent another thread from changing buffer sizes */
+	mutex_lock(&buffer->mutex);
+	atomic_inc(&buffer->record_disabled);
+
+	/* Make sure all commits have finished */
+	synchronize_rcu();
+
 	buffer->subbuf_order = order;
 	buffer->subbuf_size = psize - BUF_PAGE_HDR_SIZE;
 
-	/* Todo: reset the buffer with the new page size */
+	/* Make sure all new buffers are allocated, before deleting the old ones */
+	for_each_buffer_cpu(buffer, cpu) {
+		if (!cpumask_test_cpu(cpu, buffer->cpumask))
+			continue;
+
+		nr_pages = buffer->buffers[cpu]->nr_pages;
+		cpu_buffers[cpu] = rb_allocate_cpu_buffer(buffer, nr_pages, cpu);
+		if (!cpu_buffers[cpu]) {
+			err = -ENOMEM;
+			goto error;
+		}
+	}
+
+	for_each_buffer_cpu(buffer, cpu) {
+		if (!cpumask_test_cpu(cpu, buffer->cpumask))
+			continue;
+
+		rb_free_cpu_buffer(buffer->buffers[cpu]);
+		buffer->buffers[cpu] = cpu_buffers[cpu];
+	}
+
+	atomic_dec(&buffer->record_disabled);
+	mutex_unlock(&buffer->mutex);
+
+	kfree(cpu_buffers);
 
 	return 0;
+
+error:
+	buffer->subbuf_order = old_order;
+	buffer->subbuf_size = old_size;
+
+	atomic_dec(&buffer->record_disabled);
+	mutex_unlock(&buffer->mutex);
+
+	for_each_buffer_cpu(buffer, cpu) {
+		if (!cpu_buffers[cpu])
+			continue;
+		kfree(cpu_buffers[cpu]);
+	}
+	kfree(cpu_buffers);
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_set);
 
-- 
2.31.1

