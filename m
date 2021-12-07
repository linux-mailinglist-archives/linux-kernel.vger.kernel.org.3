Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE15046C6E1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242024AbhLGVsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241980AbhLGVsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:48:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AE2C061748
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 13:44:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E0546CE1E7A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 21:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B398DC341E8;
        Tue,  7 Dec 2021 21:44:31 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1muiGE-000I0D-Tx;
        Tue, 07 Dec 2021 16:44:30 -0500
Message-ID: <20211207214430.760852438@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 07 Dec 2021 16:44:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 10/13] tracing/kprobes: Do not open code event reserve logic
References: <20211207214406.148423650@goodmis.org>
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

Link: https://lkml.kernel.org/r/20211130024319.257430762@goodmis.org

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
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
