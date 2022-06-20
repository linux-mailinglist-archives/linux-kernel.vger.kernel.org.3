Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9267550E11
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238165AbiFTApR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238425AbiFTAnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:43:53 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932A4CE6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:51 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id cu16so13426196qvb.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=REYl/Kybw+QGOp3MKvOBE9VFTohBSgCoBZHGLGjR7yo=;
        b=SIV11o6c4n5zvMP1XmLZbKyVVbM8kHdlWfdGCqw3L5wQ8w4/Q8TlFtlmfsKK72puBl
         G9vZkcbm1Jkd0pdqdzhLGOOpakjzJsHgsBdp7rlLwirwxUkBOSQ7q91VGdtfqUKnS9/n
         kBvJ19oMnUjZGNujcSMiK3uozGTarsR2yad98lk7DwQ+mtUlLCn+uKEjkqRvEAldkcCx
         ZzNFeZU0zCNfjHvjUh6dkITW1i2hM6fWcvkO+lFuLheeMf+7iET7Clx+a7MYJhacEaQT
         B7u9Duirf52NLnR/reVrC3gYXKObjHnvfDolP3hmIxtqYVy2kIYosqyAy1+WWgYf1uIk
         /TlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=REYl/Kybw+QGOp3MKvOBE9VFTohBSgCoBZHGLGjR7yo=;
        b=D+0mjl97KXozvuFFJNLPTywnhZnK6Y1zxIrh0gaURp+RDTsWycAFFCBfsv6QKp4W3/
         t4PzDVJ/AGMVpp7oGCsTmn6SPVrz9Xt24uJSFUSN6VXsCkDxUKye36JXILWglYca/hPF
         BJtDL6vppzp3MdfKWDBy3tA40ClrrmyRtdq0mehWpNCYPXIXHuhke/Ti5lPEdsf7LWt4
         pN6DH8bHBJI36DCRpxNRym2s+YqICJonRH1OTPKXUcfqYKZu0Oaemr2Rg49SDkX8dJyW
         kltpVZfPLu6e4yvwv3FwXeywDEoyBnm/dRAQxNc1Zb94XemklTPGaN+uhsVC+gHQNTLu
         PJ5w==
X-Gm-Message-State: AJIora95GyhCvJItQPmILx84SLhReyhBC9WSqyKB42twmHsxWE44IUz1
        kg9WXnPRfezt7hO//dCTOgW85EnhKr6soR0=
X-Google-Smtp-Source: AGRyM1t5gBaXytT+IVdgBcfGLTFuRAQjLFb3HfPV7oLFNQeuv6NcUXOCk6z1ok5wjD9l/5AfthMQUg==
X-Received: by 2002:ac8:7f15:0:b0:306:6adf:8ae9 with SMTP id f21-20020ac87f15000000b003066adf8ae9mr17414973qtk.137.1655685830506;
        Sun, 19 Jun 2022 17:43:50 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id n4-20020a05620a294400b006a793bde241sm11843958qkp.63.2022.06.19.17.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:43:49 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: [PATCH v4 33/34] tracing: Convert to printbuf
Date:   Sun, 19 Jun 2022 20:42:32 -0400
Message-Id: <20220620004233.3805-34-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620004233.3805-1-kent.overstreet@gmail.com>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the seq_bufs in dynevent_cmd and trace_seq to printbufs.

 - read_pos in seq_buf doesn't exist in printbuf, so is added to
   trace_seq

 - seq_buf_to_user doesn't have a printbuf equivalent, so is inlined
   into trace_seq_to_user

 - seq_buf_putmem_hex currently swabs bytes on little endian, hardcoded
   to 8 byte units. This patch switches it to prt_hex_bytes(), which
   does _not_ swab.

Otherwise this is largely a direct conversion, with a few slight
refactorings and cleanups.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 include/linux/trace_events.h         |   2 +-
 include/linux/trace_seq.h            |  17 ++--
 kernel/trace/trace.c                 |  45 ++++-------
 kernel/trace/trace_dynevent.c        |  34 ++++----
 kernel/trace/trace_events_filter.c   |   2 +-
 kernel/trace/trace_events_synth.c    |   2 +-
 kernel/trace/trace_functions_graph.c |   6 +-
 kernel/trace/trace_kprobe.c          |   2 +-
 kernel/trace/trace_seq.c             | 111 ++++++++++++++-------------
 9 files changed, 103 insertions(+), 118 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index e6e95a9f07..48471e32f8 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -496,7 +496,7 @@ struct dynevent_cmd;
 typedef int (*dynevent_create_fn_t)(struct dynevent_cmd *cmd);
 
 struct dynevent_cmd {
-	struct seq_buf		seq;
+	struct printbuf		seq;
 	const char		*event_name;
 	unsigned int		n_fields;
 	enum dynevent_type	type;
diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index 5a2c650d9e..d2b51007b3 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -2,10 +2,12 @@
 #ifndef _LINUX_TRACE_SEQ_H
 #define _LINUX_TRACE_SEQ_H
 
-#include <linux/seq_buf.h>
+#include <linux/printbuf.h>
 
 #include <asm/page.h>
 
+struct seq_file;
+
 /*
  * Trace sequences are used to allow a function to call several other functions
  * to create a string of data to use (up to a max of PAGE_SIZE).
@@ -13,14 +15,16 @@
 
 struct trace_seq {
 	char			buffer[PAGE_SIZE];
-	struct seq_buf		seq;
+	struct printbuf		seq;
+	unsigned		readpos;
 	int			full;
 };
 
 static inline void
 trace_seq_init(struct trace_seq *s)
 {
-	seq_buf_init(&s->seq, s->buffer, PAGE_SIZE);
+	s->seq = PRINTBUF_EXTERN(s->buffer, PAGE_SIZE);
+	s->readpos = 0;
 	s->full = 0;
 }
 
@@ -39,7 +43,7 @@ trace_seq_init(struct trace_seq *s)
  */
 static inline int trace_seq_used(struct trace_seq *s)
 {
-	return seq_buf_used(&s->seq);
+	return printbuf_written(&s->seq);
 }
 
 /**
@@ -54,7 +58,7 @@ static inline int trace_seq_used(struct trace_seq *s)
 static inline char *
 trace_seq_buffer_ptr(struct trace_seq *s)
 {
-	return s->buffer + seq_buf_used(&s->seq);
+	return s->buffer + printbuf_written(&s->seq);
 }
 
 /**
@@ -66,7 +70,7 @@ trace_seq_buffer_ptr(struct trace_seq *s)
  */
 static inline bool trace_seq_has_overflowed(struct trace_seq *s)
 {
-	return s->full || seq_buf_has_overflowed(&s->seq);
+	return s->full || printbuf_overflowed(&s->seq);
 }
 
 /*
@@ -87,6 +91,7 @@ extern void trace_seq_putc(struct trace_seq *s, unsigned char c);
 extern void trace_seq_putmem(struct trace_seq *s, const void *mem, unsigned int len);
 extern void trace_seq_putmem_hex(struct trace_seq *s, const void *mem,
 				unsigned int len);
+struct path;
 extern int trace_seq_path(struct trace_seq *s, const struct path *path);
 
 extern void trace_seq_bitmask(struct trace_seq *s, const unsigned long *maskp,
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f4de111fa1..b815a914b5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1670,15 +1670,15 @@ static ssize_t trace_seq_to_buffer(struct trace_seq *s, void *buf, size_t cnt)
 {
 	int len;
 
-	if (trace_seq_used(s) <= s->seq.readpos)
+	if (trace_seq_used(s) <= s->readpos)
 		return -EBUSY;
 
-	len = trace_seq_used(s) - s->seq.readpos;
+	len = trace_seq_used(s) - s->readpos;
 	if (cnt > len)
 		cnt = len;
-	memcpy(buf, s->buffer + s->seq.readpos, cnt);
+	memcpy(buf, s->buffer + s->readpos, cnt);
 
-	s->seq.readpos += cnt;
+	s->readpos += cnt;
 	return cnt;
 }
 
@@ -3725,11 +3725,7 @@ static bool trace_safe_str(struct trace_iterator *iter, const char *str,
 
 static const char *show_buffer(struct trace_seq *s)
 {
-	struct seq_buf *seq = &s->seq;
-
-	seq_buf_terminate(seq);
-
-	return seq->buffer;
+	return printbuf_str(&s->seq);
 }
 
 static DEFINE_STATIC_KEY_FALSE(trace_no_verify);
@@ -6762,12 +6758,12 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
 	trace_access_lock(iter->cpu_file);
 	while (trace_find_next_entry_inc(iter) != NULL) {
 		enum print_line_t ret;
-		int save_len = iter->seq.seq.len;
+		int save_pos = iter->seq.seq.pos;
 
 		ret = print_trace_line(iter);
 		if (ret == TRACE_TYPE_PARTIAL_LINE) {
 			/* don't print partial lines */
-			iter->seq.seq.len = save_len;
+			iter->seq.seq.pos = save_pos;
 			break;
 		}
 		if (ret != TRACE_TYPE_NO_CONSUME)
@@ -6789,7 +6785,7 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
 
 	/* Now copy what we have to the user */
 	sret = trace_seq_to_user(&iter->seq, ubuf, cnt);
-	if (iter->seq.seq.readpos >= trace_seq_used(&iter->seq))
+	if (iter->seq.readpos >= trace_seq_used(&iter->seq))
 		trace_seq_init(&iter->seq);
 
 	/*
@@ -6815,16 +6811,15 @@ static size_t
 tracing_fill_pipe_page(size_t rem, struct trace_iterator *iter)
 {
 	size_t count;
-	int save_len;
 	int ret;
 
 	/* Seq buffer is page-sized, exactly what we need. */
 	for (;;) {
-		save_len = iter->seq.seq.len;
+		unsigned save_pos = iter->seq.seq.pos;
 		ret = print_trace_line(iter);
 
 		if (trace_seq_has_overflowed(&iter->seq)) {
-			iter->seq.seq.len = save_len;
+			iter->seq.seq.pos = save_pos;
 			break;
 		}
 
@@ -6834,14 +6829,14 @@ tracing_fill_pipe_page(size_t rem, struct trace_iterator *iter)
 		 * anyway to be safe.
 		 */
 		if (ret == TRACE_TYPE_PARTIAL_LINE) {
-			iter->seq.seq.len = save_len;
+			iter->seq.seq.pos = save_pos;
 			break;
 		}
 
-		count = trace_seq_used(&iter->seq) - save_len;
+		count = trace_seq_used(&iter->seq) - save_pos;
 		if (rem < count) {
 			rem = 0;
-			iter->seq.seq.len = save_len;
+			iter->seq.seq.pos = save_pos;
 			break;
 		}
 
@@ -9817,20 +9812,8 @@ static struct notifier_block trace_die_notifier = {
 void
 trace_printk_seq(struct trace_seq *s)
 {
-	/* Probably should print a warning here. */
-	if (s->seq.len >= TRACE_MAX_PRINT)
-		s->seq.len = TRACE_MAX_PRINT;
-
-	/*
-	 * More paranoid code. Although the buffer size is set to
-	 * PAGE_SIZE, and TRACE_MAX_PRINT is 1000, this is just
-	 * an extra layer of protection.
-	 */
-	if (WARN_ON_ONCE(s->seq.len >= s->seq.size))
-		s->seq.len = s->seq.size - 1;
-
 	/* should be zero ended, but we are paranoid. */
-	s->buffer[s->seq.len] = 0;
+	printbuf_nul_terminate(&s->seq);
 
 	printk(KERN_TRACE "%s", s->buffer);
 
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index e34e8182ee..eabeeb97b5 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -295,21 +295,19 @@ int dynevent_arg_add(struct dynevent_cmd *cmd,
 		     struct dynevent_arg *arg,
 		     dynevent_check_arg_fn_t check_arg)
 {
-	int ret = 0;
-
 	if (check_arg) {
-		ret = check_arg(arg);
+		int ret = check_arg(arg);
 		if (ret)
 			return ret;
 	}
 
-	ret = seq_buf_printf(&cmd->seq, " %s%c", arg->str, arg->separator);
-	if (ret) {
+	prt_printf(&cmd->seq, " %s%c", arg->str, arg->separator);
+	if (printbuf_overflowed(&cmd->seq)) {
 		pr_err("String is too long: %s%c\n", arg->str, arg->separator);
 		return -E2BIG;
 	}
 
-	return ret;
+	return 0;
 }
 
 /**
@@ -340,25 +338,23 @@ int dynevent_arg_pair_add(struct dynevent_cmd *cmd,
 			  struct dynevent_arg_pair *arg_pair,
 			  dynevent_check_arg_fn_t check_arg)
 {
-	int ret = 0;
-
 	if (check_arg) {
-		ret = check_arg(arg_pair);
+		int ret = check_arg(arg_pair);
 		if (ret)
 			return ret;
 	}
 
-	ret = seq_buf_printf(&cmd->seq, " %s%c%s%c", arg_pair->lhs,
-			     arg_pair->operator, arg_pair->rhs,
-			     arg_pair->separator);
-	if (ret) {
+	prt_printf(&cmd->seq, " %s%c%s%c", arg_pair->lhs,
+		   arg_pair->operator, arg_pair->rhs,
+		   arg_pair->separator);
+	if (printbuf_overflowed(&cmd->seq)) {
 		pr_err("field string is too long: %s%c%s%c\n", arg_pair->lhs,
 		       arg_pair->operator, arg_pair->rhs,
 		       arg_pair->separator);
 		return -E2BIG;
 	}
 
-	return ret;
+	return 0;
 }
 
 /**
@@ -373,15 +369,13 @@ int dynevent_arg_pair_add(struct dynevent_cmd *cmd,
  */
 int dynevent_str_add(struct dynevent_cmd *cmd, const char *str)
 {
-	int ret = 0;
-
-	ret = seq_buf_puts(&cmd->seq, str);
-	if (ret) {
+	prt_str(&cmd->seq, str);
+	if (printbuf_overflowed(&cmd->seq)) {
 		pr_err("String is too long: %s\n", str);
 		return -E2BIG;
 	}
 
-	return ret;
+	return 0;
 }
 
 /**
@@ -410,7 +404,7 @@ void dynevent_cmd_init(struct dynevent_cmd *cmd, char *buf, int maxlen,
 {
 	memset(cmd, '\0', sizeof(*cmd));
 
-	seq_buf_init(&cmd->seq, buf, maxlen);
+	cmd->seq = PRINTBUF_EXTERN(buf, maxlen);
 	cmd->type = type;
 	cmd->run_command = run_command;
 }
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index b458a9afa2..70cfd12410 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1059,7 +1059,7 @@ static void append_filter_err(struct trace_array *tr,
 				FILT_ERR_ERRNO, 0);
 	}
 	trace_seq_putc(s, 0);
-	buf = kmemdup_nul(s->buffer, s->seq.len, GFP_KERNEL);
+	buf = kstrdup(printbuf_str(&s->seq), GFP_KERNEL);
 	if (buf) {
 		kfree(filter->filter_string);
 		filter->filter_string = buf;
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 627e0e45f0..ddb2a2737b 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1512,7 +1512,7 @@ static int synth_event_run_command(struct dynevent_cmd *cmd)
 	struct synth_event *se;
 	int ret;
 
-	ret = create_or_delete_synth_event(cmd->seq.buffer);
+	ret = create_or_delete_synth_event(cmd->seq.buf);
 	if (ret)
 		return ret;
 
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 203204cadf..9f270fdde9 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -1022,9 +1022,9 @@ print_graph_comment(struct trace_seq *s, struct trace_entry *ent,
 		goto out;
 
 	/* Strip ending newline */
-	if (s->buffer[s->seq.len - 1] == '\n') {
-		s->buffer[s->seq.len - 1] = '\0';
-		s->seq.len--;
+	if (s->buffer[s->seq.pos - 1] == '\n') {
+		s->buffer[s->seq.pos - 1] = '\0';
+		s->seq.pos--;
 	}
 
 	trace_seq_puts(s, " */\n");
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 47cebef785..b97a912eed 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -915,7 +915,7 @@ static int create_or_delete_trace_kprobe(const char *raw_command)
 
 static int trace_kprobe_run_command(struct dynevent_cmd *cmd)
 {
-	return create_or_delete_trace_kprobe(cmd->seq.buffer);
+	return create_or_delete_trace_kprobe(printbuf_str(&cmd->seq));
 }
 
 /**
diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
index 9c90b3a7dc..48c08f29c3 100644
--- a/kernel/trace/trace_seq.c
+++ b/kernel/trace/trace_seq.c
@@ -25,11 +25,9 @@
  */
 #include <linux/uaccess.h>
 #include <linux/seq_file.h>
+#include <linux/string.h>
 #include <linux/trace_seq.h>
 
-/* How much buffer is left on the trace_seq? */
-#define TRACE_SEQ_BUF_LEFT(s) seq_buf_buffer_left(&(s)->seq)
-
 /*
  * trace_seq should work with being initialized with 0s.
  */
@@ -54,7 +52,7 @@ int trace_print_seq(struct seq_file *m, struct trace_seq *s)
 
 	__trace_seq_init(s);
 
-	ret = seq_buf_print_seq(m, &s->seq);
+	ret = seq_write(m, s->seq.buf, printbuf_written(&s->seq));
 
 	/*
 	 * Only reset this buffer if we successfully wrote to the
@@ -80,7 +78,7 @@ int trace_print_seq(struct seq_file *m, struct trace_seq *s)
  */
 void trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
 {
-	unsigned int save_len = s->seq.len;
+	unsigned int save_pos = s->seq.pos;
 	va_list ap;
 
 	if (s->full)
@@ -89,12 +87,12 @@ void trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
 	__trace_seq_init(s);
 
 	va_start(ap, fmt);
-	seq_buf_vprintf(&s->seq, fmt, ap);
+	prt_vprintf(&s->seq, fmt, ap);
 	va_end(ap);
 
 	/* If we can't write it all, don't bother writing anything */
-	if (unlikely(seq_buf_has_overflowed(&s->seq))) {
-		s->seq.len = save_len;
+	if (unlikely(printbuf_overflowed(&s->seq))) {
+		s->seq.pos = save_pos;
 		s->full = 1;
 	}
 }
@@ -111,17 +109,17 @@ EXPORT_SYMBOL_GPL(trace_seq_printf);
 void trace_seq_bitmask(struct trace_seq *s, const unsigned long *maskp,
 		      int nmaskbits)
 {
-	unsigned int save_len = s->seq.len;
+	unsigned int save_pos = s->seq.pos;
 
 	if (s->full)
 		return;
 
 	__trace_seq_init(s);
 
-	seq_buf_printf(&s->seq, "%*pb", nmaskbits, maskp);
+	prt_printf(&s->seq, "%*pb", nmaskbits, maskp);
 
-	if (unlikely(seq_buf_has_overflowed(&s->seq))) {
-		s->seq.len = save_len;
+	if (unlikely(printbuf_overflowed(&s->seq))) {
+		s->seq.pos = save_pos;
 		s->full = 1;
 	}
 }
@@ -140,18 +138,18 @@ EXPORT_SYMBOL_GPL(trace_seq_bitmask);
  */
 void trace_seq_vprintf(struct trace_seq *s, const char *fmt, va_list args)
 {
-	unsigned int save_len = s->seq.len;
+	unsigned int save_pos = s->seq.pos;
 
 	if (s->full)
 		return;
 
 	__trace_seq_init(s);
 
-	seq_buf_vprintf(&s->seq, fmt, args);
+	prt_vprintf(&s->seq, fmt, args);
 
 	/* If we can't write it all, don't bother writing anything */
-	if (unlikely(seq_buf_has_overflowed(&s->seq))) {
-		s->seq.len = save_len;
+	if (unlikely(printbuf_overflowed(&s->seq))) {
+		s->seq.pos = save_pos;
 		s->full = 1;
 	}
 }
@@ -174,18 +172,18 @@ EXPORT_SYMBOL_GPL(trace_seq_vprintf);
  */
 void trace_seq_bprintf(struct trace_seq *s, const char *fmt, const u32 *binary)
 {
-	unsigned int save_len = s->seq.len;
+	unsigned int save_pos = s->seq.pos;
 
 	if (s->full)
 		return;
 
 	__trace_seq_init(s);
 
-	seq_buf_bprintf(&s->seq, fmt, binary);
+	prt_bstrprintf(&s->seq, fmt, binary);
 
 	/* If we can't write it all, don't bother writing anything */
-	if (unlikely(seq_buf_has_overflowed(&s->seq))) {
-		s->seq.len = save_len;
+	if (unlikely(!printbuf_overflowed(&s->seq))) {
+		s->seq.pos = save_pos;
 		s->full = 1;
 		return;
 	}
@@ -211,12 +209,12 @@ void trace_seq_puts(struct trace_seq *s, const char *str)
 
 	__trace_seq_init(s);
 
-	if (len > TRACE_SEQ_BUF_LEFT(s)) {
+	if (len > printbuf_remaining(&s->seq)) {
 		s->full = 1;
 		return;
 	}
 
-	seq_buf_putmem(&s->seq, str, len);
+	prt_bytes(&s->seq, str, len);
 }
 EXPORT_SYMBOL_GPL(trace_seq_puts);
 
@@ -237,12 +235,12 @@ void trace_seq_putc(struct trace_seq *s, unsigned char c)
 
 	__trace_seq_init(s);
 
-	if (TRACE_SEQ_BUF_LEFT(s) < 1) {
+	if (!printbuf_remaining(&s->seq)) {
 		s->full = 1;
 		return;
 	}
 
-	seq_buf_putc(&s->seq, c);
+	prt_char(&s->seq, c);
 }
 EXPORT_SYMBOL_GPL(trace_seq_putc);
 
@@ -263,12 +261,12 @@ void trace_seq_putmem(struct trace_seq *s, const void *mem, unsigned int len)
 
 	__trace_seq_init(s);
 
-	if (len > TRACE_SEQ_BUF_LEFT(s)) {
+	if (len > printbuf_remaining(&s->seq)) {
 		s->full = 1;
 		return;
 	}
 
-	seq_buf_putmem(&s->seq, mem, len);
+	prt_bytes(&s->seq, mem, len);
 }
 EXPORT_SYMBOL_GPL(trace_seq_putmem);
 
@@ -285,24 +283,17 @@ EXPORT_SYMBOL_GPL(trace_seq_putmem);
 void trace_seq_putmem_hex(struct trace_seq *s, const void *mem,
 			 unsigned int len)
 {
-	unsigned int save_len = s->seq.len;
+	unsigned int save_pos = s->seq.pos;
 
 	if (s->full)
 		return;
 
 	__trace_seq_init(s);
 
-	/* Each byte is represented by two chars */
-	if (len * 2 > TRACE_SEQ_BUF_LEFT(s)) {
-		s->full = 1;
-		return;
-	}
+	prt_hex_bytes(&s->seq, mem, len, 8, ' ');
 
-	/* The added spaces can still cause an overflow */
-	seq_buf_putmem_hex(&s->seq, mem, len);
-
-	if (unlikely(seq_buf_has_overflowed(&s->seq))) {
-		s->seq.len = save_len;
+	if (unlikely(printbuf_overflowed(&s->seq))) {
+		s->seq.pos = save_pos;
 		s->full = 1;
 		return;
 	}
@@ -323,22 +314,22 @@ EXPORT_SYMBOL_GPL(trace_seq_putmem_hex);
  */
 int trace_seq_path(struct trace_seq *s, const struct path *path)
 {
-	unsigned int save_len = s->seq.len;
+	unsigned int save_pos = s->seq.pos;
 
 	if (s->full)
 		return 0;
 
 	__trace_seq_init(s);
 
-	if (TRACE_SEQ_BUF_LEFT(s) < 1) {
+	if (printbuf_remaining(&s->seq) < 1) {
 		s->full = 1;
 		return 0;
 	}
 
-	seq_buf_path(&s->seq, path, "\n");
+	prt_path(&s->seq, path, "\n");
 
-	if (unlikely(seq_buf_has_overflowed(&s->seq))) {
-		s->seq.len = save_len;
+	if (unlikely(printbuf_overflowed(&s->seq))) {
+		s->seq.pos = save_pos;
 		s->full = 1;
 		return 0;
 	}
@@ -369,8 +360,25 @@ EXPORT_SYMBOL_GPL(trace_seq_path);
  */
 int trace_seq_to_user(struct trace_seq *s, char __user *ubuf, int cnt)
 {
+	int ret, len;
+
 	__trace_seq_init(s);
-	return seq_buf_to_user(&s->seq, ubuf, cnt);
+
+	len = printbuf_written(&s->seq);
+	if (len <= s->readpos)
+		return -EBUSY;
+
+	len -= s->readpos;
+	if (cnt > len)
+		cnt = len;
+	ret = copy_to_user(ubuf, s->buffer + s->readpos, cnt);
+	if (ret == cnt)
+		return -EFAULT;
+
+	cnt -= ret;
+
+	s->readpos += cnt;
+	return cnt;
 }
 EXPORT_SYMBOL_GPL(trace_seq_to_user);
 
@@ -378,24 +386,19 @@ int trace_seq_hex_dump(struct trace_seq *s, const char *prefix_str,
 		       int prefix_type, int rowsize, int groupsize,
 		       const void *buf, size_t len, bool ascii)
 {
-	unsigned int save_len = s->seq.len;
+	unsigned int save_pos = s->seq.pos;
 
 	if (s->full)
 		return 0;
 
 	__trace_seq_init(s);
 
-	if (TRACE_SEQ_BUF_LEFT(s) < 1) {
-		s->full = 1;
-		return 0;
-	}
-
-	seq_buf_hex_dump(&(s->seq), prefix_str,
-		   prefix_type, rowsize, groupsize,
-		   buf, len, ascii);
+	prt_hex_dump(&s->seq, buf, len,
+		     prefix_str, prefix_type,
+		     rowsize, groupsize, ascii);
 
-	if (unlikely(seq_buf_has_overflowed(&s->seq))) {
-		s->seq.len = save_len;
+	if (unlikely(printbuf_overflowed(&s->seq))) {
+		s->seq.pos = save_pos;
 		s->full = 1;
 		return 0;
 	}
-- 
2.36.1

