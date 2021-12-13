Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79640472828
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238078AbhLMKIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241365AbhLMKDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:03:38 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CCAC09CE50
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:50:08 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id t5so49736485edd.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nT5H9R/pOtRAaqy/oVUuO0tXM2N6pl9SsLnStip9vsg=;
        b=Re+BDHUgp4o7mw4OArrWKyPl1UB1XvdblJaLsOp+LisSWsEOMdJ6UtqZwPCw1NIqzT
         YP1Vy/HKaHkfEBvZn2FL7bzOnGhQtlJViVBn/Dz9Cp48XMDc7eYeOAxfnOSjo7/DNNfz
         hylBFbx6yqdbwj/WHsCLmWUVYyMErApRB3E0yRXJ38ZuGIkrLyQY3+mWWrKRC09P3EJO
         e0F2EZ/FGYbpfxPdxYKXklxF8FCXiNZ0p9yHnb++RZb6bnzKi+RTWH2oMyH/lyPX+0TJ
         yLi/x6FlY6+RIvMroAxsmIvYQLggHJPtucPYbE73oCPmj8+PJnhlZc9br99fcZ38eovQ
         H95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nT5H9R/pOtRAaqy/oVUuO0tXM2N6pl9SsLnStip9vsg=;
        b=qGndnhsed/pU2ZrjY9oYHQ7ZH2nvlriBtXjggwOKiIK0ywFAkEDCoJRPOWzi1jQxff
         kxGzAoRNC4cdKGQH+miu/4q1IrP1pnGayuAZVIN1kThrBN01wbXZdUU9wLAZIbE4o0BI
         3o4HU1VJsw4uQ40q3DNwRbOUTDjEq7gh9IK48oJ1n2+ddeHqMk0ry/gzofzozTj1lO8w
         gDS49PJ+fFr89ipZK1N4rZeiH2IwO1fagSZRPC9Y1BOAAzWtB4bLDY2kl3t2sMG5DX9D
         IQGj8JNBN5FzTx/NFh+ME1zT6k7ojtx+gLPKMSrWDz+mO2Nz3HyGTAFWk4UK8GxKodzS
         Vbxw==
X-Gm-Message-State: AOAM533kPPVNNAg/tkIf7fNszcdsNa0FAPoPEO7EwWH/cIUrNZHO7Ee4
        Op/IrLDg7U1kgIbad9W4Y8CooBLiXxE=
X-Google-Smtp-Source: ABdhPJyre3o2cQFTrBBIAI7w5sPNIMl6lTJdDFYSTQowR3okUNbMtMQ312/Xd8smsgt1YVcmu/zGDQ==
X-Received: by 2002:a17:907:2454:: with SMTP id yw20mr43553624ejb.428.1639389006895;
        Mon, 13 Dec 2021 01:50:06 -0800 (PST)
Received: from oberon.zico.biz.zico.biz ([83.222.187.186])
        by smtp.gmail.com with ESMTPSA id qb21sm5789774ejc.78.2021.12.13.01.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 01:50:06 -0800 (PST)
From:   "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] [RFC] tracing: Add interface for configuring trace sub buffer size
Date:   Mon, 13 Dec 2021 11:50:00 +0200
Message-Id: <20211213095002.62110-4-tz.stoyanov@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211213095002.62110-1-tz.stoyanov@gmail.com>
References: <20211213095002.62110-1-tz.stoyanov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trace ring buffer sub page size can be configured, per trace
instance. A new ftrace file "buffer_subbuf_order" is added to get and
set the size of the ring buffer sub page for current trace instance.
The size must be an order of system page size, that's why the new
interface works with system page order, instead of absolute page size:
0 means the ring buffer sub page is equal to 1 system page and so
forth:
0 - 1 system page
1 - 2 system pages
2 - 4 system pages
...
The ring buffer sub page size is limited between 1 and 128 system
pages. The default value is 1 system page.
New ring buffer APIs are introduced:
 ring_buffer_subbuf_order_set()
 ring_buffer_subbuf_order_get()
 ring_buffer_subbuf_size_get()

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
---
 include/linux/ring_buffer.h |  4 ++
 kernel/trace/ring_buffer.c  | 73 +++++++++++++++++++++++++++++++++++++
 kernel/trace/trace.c        | 48 ++++++++++++++++++++++++
 3 files changed, 125 insertions(+)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index d9a2e6e8fb79..9103462f6e85 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -202,6 +202,10 @@ struct trace_seq;
 int ring_buffer_print_entry_header(struct trace_seq *s);
 int ring_buffer_print_page_header(struct trace_buffer *buffer, struct trace_seq *s);
 
+int ring_buffer_subbuf_order_get(struct trace_buffer *buffer);
+int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order);
+int ring_buffer_subbuf_size_get(struct trace_buffer *buffer);
+
 enum ring_buffer_flags {
 	RB_FL_OVERWRITE		= 1 << 0,
 };
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 68fdeff449c3..4aa5361a8f4c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -511,6 +511,7 @@ struct trace_buffer {
 	bool				time_stamp_abs;
 
 	unsigned int			subbuf_size;
+	unsigned int			subbuf_order;
 	unsigned int			max_data_size;
 };
 
@@ -5679,6 +5680,78 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 }
 EXPORT_SYMBOL_GPL(ring_buffer_read_page);
 
+/**
+ * ring_buffer_subbuf_size_get - get size of the sub buffer.
+ * @buffer: the buffer to get the sub buffer size from
+ *
+ * Returns size of the sub buffer, in bytes.
+ */
+int ring_buffer_subbuf_size_get(struct trace_buffer *buffer)
+{
+	return buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
+}
+EXPORT_SYMBOL_GPL(ring_buffer_subbuf_size_get);
+
+/**
+ * ring_buffer_subbuf_order_get - get order of system sub pages in one buffer page.
+ * @buffer: The ring_buffer to get the system sub page order from
+ *
+ * By default, one ring buffer sub page equals to one system page. This parameter
+ * is configurable, per ring buffer. The size of the ring buffer sub page can be
+ * extended, but must be an order of system page size.
+ *
+ * Returns the order of buffer sub page size, in system pages:
+ * 0 means the sub buffer size is 1 system page and so forth.
+ * In case of an error < 0 is returned.
+ */
+int ring_buffer_subbuf_order_get(struct trace_buffer *buffer)
+{
+	if (!buffer)
+		return -EINVAL;
+
+	return buffer->subbuf_order;
+}
+EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_get);
+
+/**
+ * ring_buffer_subbuf_order_set - set the size of ring buffer sub page.
+ * @buffer: The ring_buffer to set the new page size.
+ * @order: Order of the system pages in one sub buffer page
+ *
+ * By default, one ring buffer pages equals to one system page. This API can be
+ * used to set new size of the ring buffer page. The size must be order of
+ * system page size, that's why the input parameter @order is the order of
+ * system pages that are allocated for one ring buffer page:
+ *  0 - 1 system page
+ *  1 - 2 system pages
+ *  3 - 4 system pages
+ *  ...
+ *
+ * Returns 0 on success or < 0 in case of an error.
+ */
+int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
+{
+	int psize;
+
+	if (!buffer || order < 0)
+		return -EINVAL;
+
+	if (buffer->subbuf_order == order)
+		return 0;
+
+	psize = (1 << order) * PAGE_SIZE;
+	if (psize <= BUF_PAGE_HDR_SIZE)
+		return -EINVAL;
+
+	buffer->subbuf_order = order;
+	buffer->subbuf_size = psize - BUF_PAGE_HDR_SIZE;
+
+	/* Todo: reset the buffer with the new page size */
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_set);
+
 /*
  * We only allocate new buffers, never free them if the CPU goes down.
  * If we were to free the buffer, then the user would lose any trace that was in
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0eb8af875184..867a220b4ef2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9015,6 +9015,51 @@ static const struct file_operations buffer_percent_fops = {
 	.llseek		= default_llseek,
 };
 
+static ssize_t
+buffer_order_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
+{
+	struct trace_array *tr = filp->private_data;
+	char buf[64];
+	int r;
+
+	r = sprintf(buf, "%d\n", ring_buffer_subbuf_order_get(tr->array_buffer.buffer));
+
+	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
+}
+
+static ssize_t
+buffer_order_write(struct file *filp, const char __user *ubuf,
+		   size_t cnt, loff_t *ppos)
+{
+	struct trace_array *tr = filp->private_data;
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
+	if (ret)
+		return ret;
+
+	/* limit between 1 and 128 system pages */
+	if (val < 0 || val > 7)
+		return -EINVAL;
+
+	ret = ring_buffer_subbuf_order_set(tr->array_buffer.buffer, val);
+	if (ret)
+		return ret;
+
+	(*ppos)++;
+
+	return cnt;
+}
+
+static const struct file_operations buffer_order_fops = {
+	.open		= tracing_open_generic_tr,
+	.read		= buffer_order_read,
+	.write		= buffer_order_write,
+	.release	= tracing_release_generic_tr,
+	.llseek		= default_llseek,
+};
+
 static struct dentry *trace_instance_dir;
 
 static void
@@ -9468,6 +9513,9 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	trace_create_file("buffer_percent", TRACE_MODE_READ, d_tracer,
 			tr, &buffer_percent_fops);
 
+	trace_create_file("buffer_subbuf_order", TRACE_MODE_WRITE, d_tracer,
+			  tr, &buffer_order_fops);
+
 	create_trace_options_dir(tr);
 
 	trace_create_maxlat_file(tr, d_tracer);
-- 
2.31.1

