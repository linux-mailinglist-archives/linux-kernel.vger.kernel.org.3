Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0966153D85D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240649AbiFDTdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240417AbiFDTb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:31:56 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889314EA35
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:31:40 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id k6so5324321qkf.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WhmR3C90uYEYjp+kde23224eyviGHODVOPVLy3FkAts=;
        b=ZMcUhMN7PneEKzI04lW2BjU5GOLJjh0roCOHZq1FgI2ryEjJbBv4eH25CQYvuncy5G
         epsEkLAC7F3uNcPghWYiFOnX3ZAGMwidDUT7vCC02DlnsdW3pZuLKEAsZ3SQGSPxUbbg
         yNZ9qmVC6D4oDAWUoxBP0y3qCqEoOxdLsGzXTo2UeF+oIp7F4LnL1Pr62cgoqNXLLxJ4
         X+GmUq1CsaiF0OT2Fgc0st4pes091sNm21nT+GbenydBiVHbfS8/sDYLsCiVC4LjgTzL
         Eka+B1GiNQaGU5ETIrYj8676L5DkIOBbrBfdmWj0tT6aHBE2jDLAU4818ksUIvUTTVld
         F6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WhmR3C90uYEYjp+kde23224eyviGHODVOPVLy3FkAts=;
        b=zar3+24oC/5LtuYMN45tQXvznpu4FiY/HwjLVaW1aOL9/TosWvUIp2wUqKanWR7JST
         reAeTApyF3pl6+PKdu1Gne4xtQ3YysHAzjzC/myTUKugaupXr43+GC6pbOePGI/3h/Zs
         G4n9G2rRrtjZzCbyMi54V9GC2ty9q0pTpkUq3LuHNfjQCk9FwOJejka1uxAct3w4yE4D
         3J2AQKvgTrTkXaOEodmhtmI3hxb7jl3doH5KaYYayaYTda/nBQjORLRRDF95zBpLihlb
         iGjloQ8urebaqjLOfPGAh6L+MF/fx0jWkifMUAzPNufWqn+PK1yzTrMKs4M2RFZvkAgc
         iJ1Q==
X-Gm-Message-State: AOAM5328560bNY/HFvPK6XFppBd4BlsPlL1T4uaK8dvF6qz6JCrnTLWb
        uVz/6ymuMn2Q3pGGTFs23XE9jSnpc+OB
X-Google-Smtp-Source: ABdhPJxsxFuCB+s6AKSRP2OLKx9N+iHZroV70wD9thxWrlwupwWUDtvOePsgCQQtDodEN10w+csWYQ==
X-Received: by 2002:a05:620a:2158:b0:6a6:191:7099 with SMTP id m24-20020a05620a215800b006a601917099mr10660604qkm.519.1654371099328;
        Sat, 04 Jun 2022 12:31:39 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:31:38 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org
Subject: [PATCH v3 32/33] tracing: Convert to printbuf
Date:   Sat,  4 Jun 2022 15:30:41 -0400
Message-Id: <20220604193042.1674951-33-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220604193042.1674951-1-kent.overstreet@gmail.com>
References: <20220604193042.1674951-1-kent.overstreet@gmail.com>
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
 include/linux/trace_seq.h            |  14 ++--
 kernel/trace/trace.c                 |  45 ++++-------
 kernel/trace/trace_dynevent.c        |  34 ++++----
 kernel/trace/trace_events_filter.c   |   2 +-
 kernel/trace/trace_events_synth.c    |   2 +-
 kernel/trace/trace_functions_graph.c |   6 +-
 kernel/trace/trace_kprobe.c          |   2 +-
 kernel/trace/trace_seq.c             | 111 ++++++++++++++-------------
 9 files changed, 100 insertions(+), 118 deletions(-)

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
index 5a2c650d9e..0aeb9760cb 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_TRACE_SEQ_H
 #define _LINUX_TRACE_SEQ_H
 
-#include <linux/seq_buf.h>
+#include <linux/printbuf.h>
 
 #include <asm/page.h>
 
@@ -13,14 +13,16 @@
 
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
 
@@ -39,7 +41,7 @@ trace_seq_init(struct trace_seq *s)
  */
 static inline int trace_seq_used(struct trace_seq *s)
 {
-	return seq_buf_used(&s->seq);
+	return printbuf_written(&s->seq);
 }
 
 /**
@@ -54,7 +56,7 @@ static inline int trace_seq_used(struct trace_seq *s)
 static inline char *
 trace_seq_buffer_ptr(struct trace_seq *s)
 {
-	return s->buffer + seq_buf_used(&s->seq);
+	return s->buffer + printbuf_written(&s->seq);
 }
 
 /**
@@ -66,7 +68,7 @@ trace_seq_buffer_ptr(struct trace_seq *s)
  */
 static inline bool trace_seq_has_overflowed(struct trace_seq *s)
 {
-	return s->full || seq_buf_has_overflowed(&s->seq);
+	return s->full || printbuf_overflowed(&s->seq);
 }
 
 /*
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
index 9c90b3a7dc..240eaad3e5 100644
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
+	prt_hex_bytes(out, mem, len, 8, ' ');
 
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
2.36.0

