Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45A6470BDF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 21:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344220AbhLJUfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 15:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344213AbhLJUfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 15:35:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F8FC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 12:31:30 -0800 (PST)
Date:   Fri, 10 Dec 2021 21:31:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639168288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=5EPlnYMzpExB+0lU6K1ksB1QMami8uvBEUfMAE2WmuY=;
        b=WeY1vvZy2Q9L3tzYhWzsoMeu4K6C5wGLaLbIlEJSFMN1SuIYj3iz9RRKMk0iFSGbyaXo/G
        gD/zsIXwCKQHsm+evuW1t3TX1AeZL9U70tK+rbEqafX8VmqFavkfGS1MY6arSya9zncU7R
        L15zRuaiGXL/HuS/bUfKZYWYJmO0gFqZsRek+jwHQoXVMVw477ulc7ZfUoUWylU1WjJnCr
        iSWs445XOP9MJggC++jvSca4/3rJtunLbrgRaXmvXAEliUva/QnV+pWvZGkegRl14w4yzn
        +Ud+VCjQXV5+mm+nKMyWv9tLHp/MbrgF7f0GkZ31QFpnq2aefNQr3LnLiQdxQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639168288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=5EPlnYMzpExB+0lU6K1ksB1QMami8uvBEUfMAE2WmuY=;
        b=/KLC006qXRA+hDJ38M8xWkT6+TqfNdI7ZFo+PsrzCR00iv9s34JpjnAokllr7How5+yRGi
        KcZdOpf+bB/EE7CQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] tracing: Account bottom half disabled sections.
Message-ID: <YbO5H+H3dwLoIVka@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disabling only bottom halves via local_bh_disable() disables also
preemption but this remains invisible to tracing. On a CONFIG_PREEMPT
kernel one might wonder why there is no scheduling happening despite the
N flag in the trace. The reason might be the a rcu_read_lock_bh()
section.

Add a 'b' to the tracing output if in task context with disabled bottom
halves.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/trace_events.h | 1 +
 kernel/trace/trace.c         | 6 ++++--
 kernel/trace/trace_output.c  | 3 +++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 2d167ac3452c5..a2af7e1156eac 100644
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
index 88de94da596b1..dca48d556ee5a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2601,6 +2601,8 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
 		trace_flags |= TRACE_FLAG_HARDIRQ;
 	if (in_serving_softirq())
 		trace_flags |= TRACE_FLAG_SOFTIRQ;
+	if (softirq_count() >> (SOFTIRQ_SHIFT + 1))
+		trace_flags |= TRACE_FLAG_BH_OFF;
 
 	if (tif_need_resched())
 		trace_flags |= TRACE_FLAG_NEED_RESCHED;
@@ -4185,7 +4187,7 @@ static void print_lat_help_header(struct seq_file *m)
 	seq_puts(m, "#                    _------=> CPU#            \n"
 		    "#                   / _-----=> irqs-off        \n"
 		    "#                  | / _----=> need-resched    \n"
-		    "#                  || / _---=> hardirq/softirq \n"
+		    "#                  || / _---=> hardirq/softirq/BH-disables\n"
 		    "#                  ||| / _--=> preempt-depth   \n"
 		    "#                  |||| / _-=> migrate-disable \n"
 		    "#                  ||||| /     delay           \n"
@@ -4226,7 +4228,7 @@ static void print_func_help_header_irq(struct array_buffer *buf, struct seq_file
 
 	seq_printf(m, "#                            %.*s  _-----=> irqs-off\n", prec, space);
 	seq_printf(m, "#                            %.*s / _----=> need-resched\n", prec, space);
-	seq_printf(m, "#                            %.*s| / _---=> hardirq/softirq\n", prec, space);
+	seq_printf(m, "#                            %.*s| / _---=> hardirq/softirq/BH-disabled\n", prec, space);
 	seq_printf(m, "#                            %.*s|| / _--=> preempt-depth\n", prec, space);
 	seq_printf(m, "#                            %.*s||| / _-=> migrate-disable\n", prec, space);
 	seq_printf(m, "#                            %.*s|||| /     delay\n", prec, space);
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 3547e7176ff79..6be644d35ec30 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -445,11 +445,13 @@ int trace_print_lat_fmt(struct trace_seq *s, struct trace_entry *entry)
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
 		(entry->flags & TRACE_FLAG_IRQS_OFF) ? 'd' :
@@ -478,6 +480,7 @@ int trace_print_lat_fmt(struct trace_seq *s, struct trace_entry *entry)
 		(hardirq && softirq) ? 'H' :
 		hardirq              ? 'h' :
 		softirq              ? 's' :
+		bh_off		     ? 'b' :
 		                       '.' ;
 
 	trace_seq_printf(s, "%c%c%c",
-- 
2.34.1

