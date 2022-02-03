Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0F44A8C95
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 20:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353812AbiBCTjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 14:39:10 -0500
Received: from mail.efficios.com ([167.114.26.124]:53884 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351152AbiBCTjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 14:39:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 21E5F3922F0;
        Thu,  3 Feb 2022 14:39:03 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id V8qni8_NtTrb; Thu,  3 Feb 2022 14:39:02 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9CD46392554;
        Thu,  3 Feb 2022 14:39:02 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9CD46392554
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643917142;
        bh=NkCVjM+S9iEg/gRamTSXlL2ZBMGnYHhG/cpmn7pzdsM=;
        h=From:To:Date:Message-Id;
        b=MhDDK80RT36WG1XoAAwAKV0qp9r4pnYO/IKxmAT4yshXw70TYanYPZBXgMqHMcazy
         wVOEzuPbl9rl03/UA+lEV2j1xV2CQWotELHKjiN0yJINlQSp13fAfAh/7vcnxArEeK
         NYgk5myGEND+pZZoTnnfJ8ffTtGWTRe54gloKfZd7DtvK4hCPTfC1yvTyjI0wSVAlp
         AwVZ+n6jHGPpENlpRZYD7IEfD9OTLbC7VuO3b2WJ3pO5BBPekFzKUJYbRZ0wt9D6ya
         QobUTyyaW1Y8+6ooI3mYiLzMfeJOHlT+E+/NF+LzItRDj8pex4w5+f1ZKad+G0Exgy
         Gn9Iubqeqbkkg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6NLaHQ_j6_1f; Thu,  3 Feb 2022 14:39:02 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 534763925AC;
        Thu,  3 Feb 2022 14:39:02 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        libc-coord@lists.openwall.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 3/3] rseq: extend struct rseq with numa node id
Date:   Thu,  3 Feb 2022 14:38:53 -0500
Message-Id: <20220203193853.21511-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220203193853.21511-1-mathieu.desnoyers@efficios.com>
References: <20220203193853.21511-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the NUMA node id to struct rseq is a straightforward thing to do,
and a good way to figure out if anything in the user-space ecosystem
prevents extending struct rseq.

This NUMA node id field allows memory allocators such as tcmalloc to
take advantage of fast access to the current NUMA node id to perform
NUMA-aware memory allocation.

It can also be useful for implementing fast-paths for NUMA-aware
user-space mutexes.

It also allows implementing getcpu(2) purely in user-space.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/trace/events/rseq.h |  4 +++-
 include/uapi/linux/rseq.h   |  8 ++++++++
 kernel/rseq.c               | 19 +++++++++++++------
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/rseq.h b/include/trace/events/rseq.h
index a04a64bc1a00..6bd442697354 100644
--- a/include/trace/events/rseq.h
+++ b/include/trace/events/rseq.h
@@ -16,13 +16,15 @@ TRACE_EVENT(rseq_update,
 
 	TP_STRUCT__entry(
 		__field(s32, cpu_id)
+		__field(s32, node_id)
 	),
 
 	TP_fast_assign(
 		__entry->cpu_id = raw_smp_processor_id();
+		__entry->node_id = cpu_to_node(raw_smp_processor_id());
 	),
 
-	TP_printk("cpu_id=%d", __entry->cpu_id)
+	TP_printk("cpu_id=%d node_id=%d", __entry->cpu_id, __entry->node_id)
 );
 
 TRACE_EVENT(rseq_ip_fixup,
diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index 05d3c4cdeb40..1cb90a435c5c 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -131,6 +131,14 @@ struct rseq {
 	 */
 	__u32 flags;
 
+	/*
+	 * Restartable sequences node_id field. Updated by the kernel. Read by
+	 * user-space with single-copy atomicity semantics. This field should
+	 * only be read by the thread which registered this data structure.
+	 * Aligned on 32-bit. Contains the current NUMA node ID.
+	 */
+	__u32 node_id;
+
 	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 46dc5c2ce2b7..cb7d8a5afc82 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -84,15 +84,17 @@
  *   F1. <failure>
  */
 
-static int rseq_update_cpu_id(struct task_struct *t)
+static int rseq_update_cpu_node_id(struct task_struct *t)
 {
-	u32 cpu_id = raw_smp_processor_id();
 	struct rseq __user *rseq = t->rseq;
+	u32 cpu_id = raw_smp_processor_id();
+	u32 node_id = cpu_to_node(cpu_id);
 
 	if (!user_write_access_begin(rseq, t->rseq_len))
 		goto efault;
 	unsafe_put_user(cpu_id, &rseq->cpu_id_start, efault_end);
 	unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
+	unsafe_put_user(node_id, &rseq->node_id, efault_end);
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally updated only if
@@ -108,9 +110,9 @@ static int rseq_update_cpu_id(struct task_struct *t)
 	return -EFAULT;
 }
 
-static int rseq_reset_rseq_cpu_id(struct task_struct *t)
+static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 {
-	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED;
+	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0;
 
 	/*
 	 * Reset cpu_id_start to its initial state (0).
@@ -124,6 +126,11 @@ static int rseq_reset_rseq_cpu_id(struct task_struct *t)
 	 */
 	if (put_user(cpu_id, &t->rseq->cpu_id))
 		return -EFAULT;
+	/*
+	 * Reset node_id to its initial state (0).
+	 */
+	if (put_user(node_id, &t->rseq->node_id))
+		return -EFAULT;
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally reset only if
@@ -306,7 +313,7 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 		if (unlikely(ret < 0))
 			goto error;
 	}
-	if (unlikely(rseq_update_cpu_id(t)))
+	if (unlikely(rseq_update_cpu_node_id(t)))
 		goto error;
 	return;
 
@@ -353,7 +360,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 			return -EINVAL;
 		if (current->rseq_sig != sig)
 			return -EPERM;
-		ret = rseq_reset_rseq_cpu_id(current);
+		ret = rseq_reset_rseq_cpu_node_id(current);
 		if (ret)
 			return ret;
 		current->rseq = NULL;
-- 
2.17.1

