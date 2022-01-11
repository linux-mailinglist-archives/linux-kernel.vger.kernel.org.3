Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E8848B3F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344588AbiAKRbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:31:37 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45336 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344293AbiAKRbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:31:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E87BCB81C3E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2C4C36B02;
        Tue, 11 Jan 2022 17:31:15 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1n7KzK-00328E-MF;
        Tue, 11 Jan 2022 12:31:14 -0500
Message-ID: <20220111173114.518398374@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 11 Jan 2022 12:30:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [for-next][PATCH 07/31] tracing: Account bottom half disabled sections.
References: <20220111173030.999527342@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Disabling only bottom halves via local_bh_disable() disables also
preemption but this remains invisible to tracing. On a CONFIG_PREEMPT
kernel one might wonder why there is no scheduling happening despite the
N flag in the trace. The reason might be the a rcu_read_lock_bh()
section.

Add a 'b' to the tracing output if in task context with disabled bottom
halves.

Link: https://lkml.kernel.org/r/YbcbtdtC/bjCKo57@linutronix.de

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/trace_events.h | 1 +
 kernel/trace/trace.c         | 6 ++++--
 kernel/trace/trace_output.c  | 4 ++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 3900404aa063..70c069aef02c 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -172,6 +172,7 @@ enum trace_flag_type {
 	TRACE_FLAG_SOFTIRQ		= 0x10,
 	TRACE_FLAG_PREEMPT_RESCHED	= 0x20,
 	TRACE_FLAG_NMI			= 0x40,
+	TRACE_FLAG_BH_OFF		= 0x80,
 };
 
 #ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 547d82628c2e..a73d78dcda2c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2603,6 +2603,8 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
 		trace_flags |= TRACE_FLAG_HARDIRQ;
 	if (in_serving_softirq())
 		trace_flags |= TRACE_FLAG_SOFTIRQ;
+	if (softirq_count() >> (SOFTIRQ_SHIFT + 1))
+		trace_flags |= TRACE_FLAG_BH_OFF;
 
 	if (tif_need_resched())
 		trace_flags |= TRACE_FLAG_NEED_RESCHED;
@@ -4190,7 +4192,7 @@ unsigned long trace_total_entries(struct trace_array *tr)
 static void print_lat_help_header(struct seq_file *m)
 {
 	seq_puts(m, "#                    _------=> CPU#            \n"
-		    "#                   / _-----=> irqs-off        \n"
+		    "#                   / _-----=> irqs-off/BH-disabled\n"
 		    "#                  | / _----=> need-resched    \n"
 		    "#                  || / _---=> hardirq/softirq \n"
 		    "#                  ||| / _--=> preempt-depth   \n"
@@ -4231,7 +4233,7 @@ static void print_func_help_header_irq(struct array_buffer *buf, struct seq_file
 
 	print_event_info(buf, m);
 
-	seq_printf(m, "#                            %.*s  _-----=> irqs-off\n", prec, space);
+	seq_printf(m, "#                            %.*s  _-----=> irqs-off/BH-disabled\n", prec, space);
 	seq_printf(m, "#                            %.*s / _----=> need-resched\n", prec, space);
 	seq_printf(m, "#                            %.*s| / _---=> hardirq/softirq\n", prec, space);
 	seq_printf(m, "#                            %.*s|| / _--=> preempt-depth\n", prec, space);
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 3547e7176ff7..8aa493d25c73 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -445,14 +445,18 @@ int trace_print_lat_fmt(struct trace_seq *s, struct trace_entry *entry)
 	char irqs_off;
 	int hardirq;
 	int softirq;
+	int bh_off;
 	int nmi;
 
 	nmi = entry->flags & TRACE_FLAG_NMI;
 	hardirq = entry->flags & TRACE_FLAG_HARDIRQ;
 	softirq = entry->flags & TRACE_FLAG_SOFTIRQ;
+	bh_off = entry->flags & TRACE_FLAG_BH_OFF;
 
 	irqs_off =
+		(entry->flags & TRACE_FLAG_IRQS_OFF && bh_off) ? 'D' :
 		(entry->flags & TRACE_FLAG_IRQS_OFF) ? 'd' :
+		bh_off ? 'b' :
 		(entry->flags & TRACE_FLAG_IRQS_NOSUPPORT) ? 'X' :
 		'.';
 
-- 
2.33.0
