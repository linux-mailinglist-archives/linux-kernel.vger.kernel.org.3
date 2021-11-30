Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B927462AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 03:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbhK3Cqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 21:46:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49108 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhK3Cqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 21:46:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 870ABB816CA
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 02:43:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4772EC53FD4;
        Tue, 30 Nov 2021 02:43:20 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mrt71-000RUe-Da;
        Mon, 29 Nov 2021 21:43:19 -0500
Message-ID: <20211130024319.257430762@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 29 Nov 2021 21:39:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 4/5] tracing/kprobes: Do not open code event reserve logic
References: <20211130023945.789683928@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

As kprobe events use trace_event_buffer_commit() to commit the event to
the ftrace ring buffer, for consistency, it should use
trace_event_buffer_reserve() to allocate it, as the two functions are
related.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 33272a7b6912..d10c01948e68 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1383,17 +1383,11 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
 
-	fbuffer.trace_ctx = tracing_gen_ctx();
-	fbuffer.trace_file = trace_file;
-
 	dsize = __get_data_size(&tk->tp, regs);
 
-	fbuffer.event =
-		trace_event_buffer_lock_reserve(&fbuffer.buffer, trace_file,
-					call->event.type,
-					sizeof(*entry) + tk->tp.size + dsize,
-					fbuffer.trace_ctx);
-	if (!fbuffer.event)
+	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
+					   sizeof(*entry) + tk->tp.size + dsize);
+	if (!entry)
 		return;
 
 	fbuffer.regs = regs;
@@ -1430,16 +1424,11 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
 
-	fbuffer.trace_ctx = tracing_gen_ctx();
-	fbuffer.trace_file = trace_file;
-
 	dsize = __get_data_size(&tk->tp, regs);
-	fbuffer.event =
-		trace_event_buffer_lock_reserve(&fbuffer.buffer, trace_file,
-					call->event.type,
-					sizeof(*entry) + tk->tp.size + dsize,
-					fbuffer.trace_ctx);
-	if (!fbuffer.event)
+
+	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
+					   sizeof(*entry) + tk->tp.size + dsize);
+	if (!entry)
 		return;
 
 	fbuffer.regs = regs;
-- 
2.33.0
