Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2319F46C6E3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242059AbhLGVsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:48:16 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:53866 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhLGVsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:48:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 11FB7CE1E7C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 21:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34CBC341E9;
        Tue,  7 Dec 2021 21:44:31 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1muiGF-000I0m-3e;
        Tue, 07 Dec 2021 16:44:31 -0500
Message-ID: <20211207214430.947502966@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 07 Dec 2021 16:44:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 11/13] tracing/uprobes: Use trace_event_buffer_reserve() helper
References: <20211207214406.148423650@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

To be consistent with kprobes and eprobes, use
trace_event_buffer_reserver() and trace_event_buffer_commit(). This will
ensure that any updates to trace events will also be implemented on uprobe
events.

Link: https://lkml.kernel.org/r/20211206162440.69fbf96c@gandalf.local.home

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_uprobe.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index f5f0039d31e5..a4d5c624fe79 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -949,8 +949,7 @@ static void __uprobe_trace_func(struct trace_uprobe *tu,
 				struct trace_event_file *trace_file)
 {
 	struct uprobe_trace_entry_head *entry;
-	struct trace_buffer *buffer;
-	struct ring_buffer_event *event;
+	struct trace_event_buffer fbuffer;
 	void *data;
 	int size, esize;
 	struct trace_event_call *call = trace_probe_event_call(&tu->tp);
@@ -965,12 +964,10 @@ static void __uprobe_trace_func(struct trace_uprobe *tu,
 
 	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
 	size = esize + tu->tp.size + dsize;
-	event = trace_event_buffer_lock_reserve(&buffer, trace_file,
-						call->event.type, size, 0);
-	if (!event)
+	entry = trace_event_buffer_reserve(&fbuffer, trace_file, size);
+	if (!entry)
 		return;
 
-	entry = ring_buffer_event_data(event);
 	if (is_ret_probe(tu)) {
 		entry->vaddr[0] = func;
 		entry->vaddr[1] = instruction_pointer(regs);
@@ -982,7 +979,7 @@ static void __uprobe_trace_func(struct trace_uprobe *tu,
 
 	memcpy(data, ucb->buf, tu->tp.size + dsize);
 
-	event_trigger_unlock_commit(trace_file, buffer, event, entry, 0);
+	trace_event_buffer_commit(&fbuffer);
 }
 
 /* uprobe handler */
-- 
2.33.0
