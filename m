Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57364FAE4E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 16:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbiDJOw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 10:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbiDJOwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 10:52:55 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6EF237FF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 07:50:44 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id p25so5710234pfn.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 07:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2FkD7lQO8tokeJCcV4E291TvzDxKaTjKO6gYJPs1B1A=;
        b=FRj7DsXXoEOeqEUbYv4qF1zHwL5NJIcWQuweoQ0lcjlgHrWJlIblassRshhI4uFSbk
         XziCWq+2kMdHt63z4dMpZJHljEndzFVXSJ/LUzp0k/xIZq5rce2Dsqw5gOmkISfEnrYp
         Cn+d6FfwQQgl7zky0kERjeZlN6oR2ZOX8G0bw6vc38NDZTuKhoosg3sROXuBwDf3tqjc
         C5IT1CjtDL8XRtyrYO1FhnCyh6svNGLFjoZnPqKVpMkK4jLzXolP3ETVA+VMKAUWx+ZO
         aOIi2w6adWisWiM20q0AVyhA8wgFWigz6zV392dmkYqGp033Le7gndrt4EO5P8xp0l47
         f/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2FkD7lQO8tokeJCcV4E291TvzDxKaTjKO6gYJPs1B1A=;
        b=qeGug/YfNsnWDQqWxeoRuxz5v8rF1+CYCVDTHqMhVJ7sFmlXy9nMeoLJUVbiKet5FE
         7IajezxeoS7g69qnSfr8lEB/oc/TFf0UsjgPs2oSibVON+OWPWpgv8dOSg6S/BlBZi2z
         bEFC9cH+vTv2HXlwfB5OR0LNH3z9nOc9bYvhcFcWCw5DJ4W4ZScaD2BKo3IKFupwLhG7
         XrXR/56aSMhRPlTVdOdhJgdQ+/o0mJOYvf6Ap3fKQ1NOBQUWpWTcpAwqNy6VOTuzCMHI
         tjvolMqk/V+npLMKRljo1XrQB9FqeExGeRMakvoWhPasfuESc3jf52TJNaLQJK5A2pTW
         Jtcw==
X-Gm-Message-State: AOAM533UsYksBuhCiXnFg2UTMC2xjXqmYdth8fxYpqfW5LU1ipmz9cef
        ycOKMM4Oc5viaQMmlO0vwdQ=
X-Google-Smtp-Source: ABdhPJzWgn2nniq1EmxPayz62WRRlh0X0+GcmmQ/ytP4//4VYTgbbx5wkKnGhHA6QICCg2InLaWBwQ==
X-Received: by 2002:a63:f34d:0:b0:399:5abe:b2e1 with SMTP id t13-20020a63f34d000000b003995abeb2e1mr23509778pgj.451.1649602243814;
        Sun, 10 Apr 2022 07:50:43 -0700 (PDT)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id s24-20020a63af58000000b003981789eadfsm26846652pgo.21.2022.04.10.07.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 07:50:42 -0700 (PDT)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [PATCH v2] tracing: Make tp_printk work on syscall tracepoints
Date:   Sun, 10 Apr 2022 22:50:25 +0800
Message-Id: <20220410145025.681144-1-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the tp_printk option has no effect on syscall tracepoint.
When adding the kernel option parameter tp_printk, then:

echo 1 > /sys/kernel/debug/tracing/events/syscalls/enable

When running any application, no trace information is printed on the
terminal.

Now added printk for syscall tracepoints.

Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
---

v2:
- Use trace_event_buffer_reserve() and trace_event_buffer_commit()
  instead of reimplementing logic.

- Modify the subject to start with a capital letter.

 kernel/trace/trace_syscalls.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index f755bde42fd0..b69e207012c9 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -154,7 +154,7 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 			goto end;
 
 		/* parameter types */
-		if (tr->trace_flags & TRACE_ITER_VERBOSE)
+		if (tr && tr->trace_flags & TRACE_ITER_VERBOSE)
 			trace_seq_printf(s, "%s ", entry->types[i]);
 
 		/* parameter values */
@@ -296,9 +296,7 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	struct trace_event_file *trace_file;
 	struct syscall_trace_enter *entry;
 	struct syscall_metadata *sys_data;
-	struct ring_buffer_event *event;
-	struct trace_buffer *buffer;
-	unsigned int trace_ctx;
+	struct trace_event_buffer fbuffer;
 	unsigned long args[6];
 	int syscall_nr;
 	int size;
@@ -321,20 +319,16 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 
 	size = sizeof(*entry) + sizeof(unsigned long) * sys_data->nb_args;
 
-	trace_ctx = tracing_gen_ctx();
-
-	event = trace_event_buffer_lock_reserve(&buffer, trace_file,
-			sys_data->enter_event->event.type, size, trace_ctx);
-	if (!event)
+	entry = trace_event_buffer_reserve(&fbuffer, trace_file, size);
+	if (!entry)
 		return;
 
-	entry = ring_buffer_event_data(event);
+	entry = ring_buffer_event_data(fbuffer.event);
 	entry->nr = syscall_nr;
 	syscall_get_arguments(current, regs, args);
 	memcpy(entry->args, args, sizeof(unsigned long) * sys_data->nb_args);
 
-	event_trigger_unlock_commit(trace_file, buffer, event, entry,
-				    trace_ctx);
+	trace_event_buffer_commit(&fbuffer);
 }
 
 static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
@@ -343,9 +337,7 @@ static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
 	struct trace_event_file *trace_file;
 	struct syscall_trace_exit *entry;
 	struct syscall_metadata *sys_data;
-	struct ring_buffer_event *event;
-	struct trace_buffer *buffer;
-	unsigned int trace_ctx;
+	struct trace_event_buffer fbuffer;
 	int syscall_nr;
 
 	syscall_nr = trace_get_syscall_nr(current, regs);
@@ -364,20 +356,15 @@ static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
 	if (!sys_data)
 		return;
 
-	trace_ctx = tracing_gen_ctx();
-
-	event = trace_event_buffer_lock_reserve(&buffer, trace_file,
-			sys_data->exit_event->event.type, sizeof(*entry),
-			trace_ctx);
-	if (!event)
+	entry = trace_event_buffer_reserve(&fbuffer, trace_file, sizeof(*entry));
+	if (!entry)
 		return;
 
-	entry = ring_buffer_event_data(event);
+	entry = ring_buffer_event_data(fbuffer.event);
 	entry->nr = syscall_nr;
 	entry->ret = syscall_get_return_value(current, regs);
 
-	event_trigger_unlock_commit(trace_file, buffer, event, entry,
-				    trace_ctx);
+	trace_event_buffer_commit(&fbuffer);
 }
 
 static int reg_event_syscall_enter(struct trace_event_file *file,
-- 
2.25.1

