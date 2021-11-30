Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC92C462AAD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 03:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237727AbhK3Cqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 21:46:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49112 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbhK3Cql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 21:46:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48E7FB816CB
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 02:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7524EC56749;
        Tue, 30 Nov 2021 02:43:20 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mrt71-000RVC-Jg;
        Mon, 29 Nov 2021 21:43:19 -0500
Message-ID: <20211130024319.439953082@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 29 Nov 2021 21:39:50 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 5/5] tracing/uprobes: Use trace_event_buffer_reserve() helper
References: <20211130023945.789683928@goodmis.org>
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

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_uprobe.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index f5f0039d31e5..177717c4e74a 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -949,8 +949,8 @@ static void __uprobe_trace_func(struct trace_uprobe *tu,
 				struct trace_event_file *trace_file)
 {
 	struct uprobe_trace_entry_head *entry;
+	struct trace_event_buffer fbuffer;
 	struct trace_buffer *buffer;
-	struct ring_buffer_event *event;
 	void *data;
 	int size, esize;
 	struct trace_event_call *call = trace_probe_event_call(&tu->tp);
@@ -965,12 +965,10 @@ static void __uprobe_trace_func(struct trace_uprobe *tu,
 
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
@@ -982,7 +980,7 @@ static void __uprobe_trace_func(struct trace_uprobe *tu,
 
 	memcpy(data, ucb->buf, tu->tp.size + dsize);
 
-	event_trigger_unlock_commit(trace_file, buffer, event, entry, 0);
+	trace_event_buffer_commit(&fbuffer);
 }
 
 /* uprobe handler */
-- 
2.33.0
