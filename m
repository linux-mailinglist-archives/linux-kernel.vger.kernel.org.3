Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F18A472A41
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbhLMKfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbhLMKfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:35:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E40C08E857
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 02:08:56 -0800 (PST)
Date:   Mon, 13 Dec 2021 11:08:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639390135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XaXdr5ZWdr10AhuPnIf/lbNihptCfanKMNKhs551A28=;
        b=SV7m6MniIPaioBum9eYilmWyx2ULBbokWfMCOwheg0jbD4wANZm0bEYM8+vAA9P0Hb28ih
        bCF7OYQzKOPXhoQyyisE1JYNKxTfr6xOS9RkcVFpMJZb4jSy2DfLO7/ok5AYI6ocpoBbv1
        Zin4N8NGpouZ493eVULmyZT/l4nKnW6HXW3oRaKJ7ty7VfOeQf5dQS4J8NILc7KZLlPZtQ
        pS2qpA2Fyx7KAxQCCQG1FKk81za0dU2NnZh8dexbSxmlSGMQMt8DiJygh5Lz5mj7eR092n
        l0SowiYJTw04bc/D1MhhmhwgPs5tZay6SKnZlu9vok/TCwuX062A2LlIGFbNWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639390135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XaXdr5ZWdr10AhuPnIf/lbNihptCfanKMNKhs551A28=;
        b=sM6WJm7mm/HBoN0AnuS0TC3b7vcrKno11zDVQVNzTTxhhrAkb42H37TBeuo7FrDwXhvi0w
        OhoidyDZYZRyZ3Dg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] tracing: Account bottom half disabled sections.
Message-ID: <YbcbtdtC/bjCKo57@linutronix.de>
References: <YbO5H+H3dwLoIVka@linutronix.de>
 <20211210203240.43a8e7eb@gandalf.local.home>
 <YbcSLmrm0HmCJzvJ@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YbcSLmrm0HmCJzvJ@linutronix.de>
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
v1=E2=80=A6v2:
 - Move output to the IRQ-off section.

 include/linux/trace_events.h | 1 +
 kernel/trace/trace.c         | 6 ++++--
 kernel/trace/trace_output.c  | 4 ++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 2d167ac3452c5..a2af7e1156eac 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -172,6 +172,7 @@ enum trace_flag_type {
 	TRACE_FLAG_SOFTIRQ		=3D 0x10,
 	TRACE_FLAG_PREEMPT_RESCHED	=3D 0x20,
 	TRACE_FLAG_NMI			=3D 0x40,
+	TRACE_FLAG_BH_OFF		=3D 0x80,
 };
=20
 #ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 88de94da596b1..c3618dd7ecb4b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2601,6 +2601,8 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int ir=
qs_status)
 		trace_flags |=3D TRACE_FLAG_HARDIRQ;
 	if (in_serving_softirq())
 		trace_flags |=3D TRACE_FLAG_SOFTIRQ;
+	if (softirq_count() >> (SOFTIRQ_SHIFT + 1))
+		trace_flags |=3D TRACE_FLAG_BH_OFF;
=20
 	if (tif_need_resched())
 		trace_flags |=3D TRACE_FLAG_NEED_RESCHED;
@@ -4183,7 +4185,7 @@ unsigned long trace_total_entries(struct trace_array =
*tr)
 static void print_lat_help_header(struct seq_file *m)
 {
 	seq_puts(m, "#                    _------=3D> CPU#            \n"
-		    "#                   / _-----=3D> irqs-off        \n"
+		    "#                   / _-----=3D> irqs-off/BH-disabled\n"
 		    "#                  | / _----=3D> need-resched    \n"
 		    "#                  || / _---=3D> hardirq/softirq \n"
 		    "#                  ||| / _--=3D> preempt-depth   \n"
@@ -4224,7 +4226,7 @@ static void print_func_help_header_irq(struct array_b=
uffer *buf, struct seq_file
=20
 	print_event_info(buf, m);
=20
-	seq_printf(m, "#                            %.*s  _-----=3D> irqs-off\n",=
 prec, space);
+	seq_printf(m, "#                            %.*s  _-----=3D> irqs-off/BH-=
disabled\n", prec, space);
 	seq_printf(m, "#                            %.*s / _----=3D> need-resched=
\n", prec, space);
 	seq_printf(m, "#                            %.*s| / _---=3D> hardirq/soft=
irq\n", prec, space);
 	seq_printf(m, "#                            %.*s|| / _--=3D> preempt-dept=
h\n", prec, space);
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 3547e7176ff79..8aa493d25c73e 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -445,14 +445,18 @@ int trace_print_lat_fmt(struct trace_seq *s, struct t=
race_entry *entry)
 	char irqs_off;
 	int hardirq;
 	int softirq;
+	int bh_off;
 	int nmi;
=20
 	nmi =3D entry->flags & TRACE_FLAG_NMI;
 	hardirq =3D entry->flags & TRACE_FLAG_HARDIRQ;
 	softirq =3D entry->flags & TRACE_FLAG_SOFTIRQ;
+	bh_off =3D entry->flags & TRACE_FLAG_BH_OFF;
=20
 	irqs_off =3D
+		(entry->flags & TRACE_FLAG_IRQS_OFF && bh_off) ? 'D' :
 		(entry->flags & TRACE_FLAG_IRQS_OFF) ? 'd' :
+		bh_off ? 'b' :
 		(entry->flags & TRACE_FLAG_IRQS_NOSUPPORT) ? 'X' :
 		'.';
=20
--=20
2.34.1

