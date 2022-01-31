Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39EC04A50A5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347806AbiAaUzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:55:52 -0500
Received: from mail.efficios.com ([167.114.26.124]:38776 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239450AbiAaUzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:55:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D5BDB2DEDA7;
        Mon, 31 Jan 2022 15:55:48 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1U_MHm3CTTsx; Mon, 31 Jan 2022 15:55:48 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E12A62DED22;
        Mon, 31 Jan 2022 15:55:47 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E12A62DED22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643662547;
        bh=G77yNuMSKgOQeKloS+BdXG8VKCF0SxQ94r5eYUhsr80=;
        h=From:To:Date:Message-Id;
        b=HdblOsYtpO1rdDjRRIkqnsQV9tAEo2Gc4JmOf7dZG/Bj4i/HkkqS28wXgcgfxx7NL
         n4mu1q4Qc40wlTDyrv9u2+DDlGaVS9SW7ojkYju4bBbvcMd6xsR/qjhceMGyUavLTF
         dqRaQ2JpHb+HZ3HEon5BHrHpYRP/5HMzV0l8+y72Q1k9YNmxb7geL2zyHkAI0+4zLC
         822UzevWz+wOOnMLr5YXKD0W4HdU2stFXzeEV367hZiZGtqmU5CHv0xJPy+905agJi
         ZZrC/jWk+9+bId6r3Hw5X2jVX4lj7Ph5fpB8WVOtSsGynAdlU47Zq7JN25kuu/Iqgj
         Ik0CmE+ojgdcg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FFcEGRNmT4NW; Mon, 31 Jan 2022 15:55:47 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 683142DEDA6;
        Mon, 31 Jan 2022 15:55:47 -0500 (EST)
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 1/2] rseq: extend struct rseq with numa node id
Date:   Mon, 31 Jan 2022 15:55:30 -0500
Message-Id: <20220131205531.17873-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the NUMA node id to struct rseq is a straightforward thing to do,
and a good way to figure out if anything in the user-space ecosystem
prevents extending struct rseq.

This NUMA node id field allows memory allocators such as tcmalloc to
take advantage of fast access to the current NUMA node id to perform
NUMA-aware memory allocation.

It is also useful for implementing NUMA-aware user-space mutexes.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/linux/sched.h       |  4 ++
 include/trace/events/rseq.h |  4 +-
 include/uapi/linux/rseq.h   | 54 ++++++++++++++++++++--
 kernel/ptrace.c             |  2 +-
 kernel/rseq.c               | 91 +++++++++++++++++++++++++++----------
 5 files changed, 124 insertions(+), 31 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 508b91d57470..838c9e0b4cae 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1291,6 +1291,7 @@ struct task_struct {
 
 #ifdef CONFIG_RSEQ
 	struct rseq __user *rseq;
+	u32 rseq_len;
 	u32 rseq_sig;
 	/*
 	 * RmW on rseq_event_mask must be performed atomically
@@ -2260,10 +2261,12 @@ static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
 {
 	if (clone_flags & CLONE_VM) {
 		t->rseq = NULL;
+		t->rseq_len = 0;
 		t->rseq_sig = 0;
 		t->rseq_event_mask = 0;
 	} else {
 		t->rseq = current->rseq;
+		t->rseq_len = current->rseq_len;
 		t->rseq_sig = current->rseq_sig;
 		t->rseq_event_mask = current->rseq_event_mask;
 	}
@@ -2272,6 +2275,7 @@ static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
 static inline void rseq_execve(struct task_struct *t)
 {
 	t->rseq = NULL;
+	t->rseq_len = 0;
 	t->rseq_sig = 0;
 	t->rseq_event_mask = 0;
 }
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
index 77ee207623a9..006373a15ebe 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -13,9 +13,9 @@
 #include <linux/types.h>
 #include <asm/byteorder.h>
 
-enum rseq_cpu_id_state {
-	RSEQ_CPU_ID_UNINITIALIZED		= -1,
-	RSEQ_CPU_ID_REGISTRATION_FAILED		= -2,
+enum rseq_id_state {
+	RSEQ_ID_UNINITIALIZED			= -1,
+	RSEQ_ID_REGISTRATION_FAILED		= -2,
 };
 
 enum rseq_flags {
@@ -78,7 +78,7 @@ struct rseq {
 	 * Read by user-space with single-copy atomicity semantics. This
 	 * field should only be read by the thread which registered this
 	 * data structure. Aligned on 32-bit. Values
-	 * RSEQ_CPU_ID_UNINITIALIZED and RSEQ_CPU_ID_REGISTRATION_FAILED
+	 * RSEQ_ID_UNINITIALIZED and RSEQ_ID_REGISTRATION_FAILED
 	 * have a special semantic: the former means "rseq uninitialized",
 	 * and latter means "rseq initialization failed". This value is
 	 * meant to be read within rseq critical sections and compared
@@ -130,6 +130,52 @@ struct rseq {
 	 *     this thread.
 	 */
 	__u32 flags;
+
+	__u32 padding1[3];
+
+	/*
+	 * This is the end of the original rseq ABI.
+	 * This is a valid end of rseq ABI for the purpose of rseq registration
+	 * rseq_len.
+	 * The original rseq ABI use "sizeof(struct rseq)" on registration,
+	 * thus requiring the padding above.
+	 */
+
+	/*
+	 * Restartable sequences node_id_start field. Updated by the
+	 * kernel. Read by user-space with single-copy atomicity
+	 * semantics. This field should only be read by the thread which
+	 * registered this data structure. Aligned on 32-bit. Always
+	 * contains a value in the range of possible NUMA node IDs, although the
+	 * value may not be the actual current NUMA node ID (e.g. if rseq is not
+	 * initialized). This NUMA node ID number value should always be compared
+	 * against the value of the node_id field before performing a rseq
+	 * commit or returning a value read from a data structure indexed using
+	 * the node_id_start value.
+	 */
+	__u32 node_id_start;
+
+	/*
+	 * Restartable sequences node_id field. Updated by the kernel.
+	 * Read by user-space with single-copy atomicity semantics. This
+	 * field should only be read by the thread which registered this
+	 * data structure. Aligned on 32-bit. Values
+	 * RSEQ_ID_UNINITIALIZED and RSEQ_ID_REGISTRATION_FAILED
+	 * have a special semantic: the former means "rseq uninitialized",
+	 * and latter means "rseq initialization failed". This value is
+	 * meant to be read within rseq critical sections and compared
+	 * with the node_id_start value previously read, before performing
+	 * the commit instruction, or read and compared with the
+	 * node_id_start value before returning a value loaded from a data
+	 * structure indexed using the node_id_start value.
+	 */
+	__u32 node_id;
+
+	/*
+	 * This is a valid end of rseq ABI for the purpose of rseq registration
+	 * rseq_len. Use the offset immediately after the node_id field as
+	 * rseq_len.
+	 */
 } __attribute__((aligned(4 * sizeof(__u64))));
 
 #endif /* _UAPI_LINUX_RSEQ_H */
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index eea265082e97..f5edde5b7805 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -800,7 +800,7 @@ static long ptrace_get_rseq_configuration(struct task_struct *task,
 {
 	struct ptrace_rseq_configuration conf = {
 		.rseq_abi_pointer = (u64)(uintptr_t)task->rseq,
-		.rseq_abi_size = sizeof(*task->rseq),
+		.rseq_abi_size = task->rseq_len,
 		.signature = task->rseq_sig,
 		.flags = 0,
 	};
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 97ac20b4f738..2381a8a1b90d 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -81,15 +81,27 @@
  *   F1. <failure>
  */
 
-static int rseq_update_cpu_id(struct task_struct *t)
+static int rseq_update_cpu_node_id(struct task_struct *t)
 {
-	u32 cpu_id = raw_smp_processor_id();
 	struct rseq __user *rseq = t->rseq;
+	u32 cpu_id = raw_smp_processor_id();
+	u32 node_id;
 
-	if (!user_write_access_begin(rseq, sizeof(*rseq)))
+	if (!user_write_access_begin(rseq, t->rseq_len))
 		goto efault;
-	unsafe_put_user(cpu_id, &rseq->cpu_id_start, efault_end);
-	unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
+	switch (t->rseq_len) {
+	case offsetofend(struct rseq, node_id):
+		node_id = cpu_to_node(cpu_id);
+		unsafe_put_user(node_id, &rseq->node_id_start, efault_end);
+		unsafe_put_user(node_id, &rseq->node_id, efault_end);
+		fallthrough;
+	case offsetofend(struct rseq, padding1):
+		unsafe_put_user(cpu_id, &rseq->cpu_id_start, efault_end);
+		unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
+		break;
+	default:
+		goto efault_end;
+	}
 	user_write_access_end();
 	trace_rseq_update(t);
 	return 0;
@@ -100,22 +112,42 @@ static int rseq_update_cpu_id(struct task_struct *t)
 	return -EFAULT;
 }
 
-static int rseq_reset_rseq_cpu_id(struct task_struct *t)
+static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 {
-	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED;
+	u32 id_start = 0, id = RSEQ_ID_UNINITIALIZED;
 
-	/*
-	 * Reset cpu_id_start to its initial state (0).
-	 */
-	if (put_user(cpu_id_start, &t->rseq->cpu_id_start))
-		return -EFAULT;
-	/*
-	 * Reset cpu_id to RSEQ_CPU_ID_UNINITIALIZED, so any user coming
-	 * in after unregistration can figure out that rseq needs to be
-	 * registered again.
-	 */
-	if (put_user(cpu_id, &t->rseq->cpu_id))
-		return -EFAULT;
+	switch (t->rseq_len) {
+	case offsetofend(struct rseq, node_id):
+		/*
+		 * Reset node_id_start to its initial state (0).
+		 */
+		if (put_user(id_start, &t->rseq->node_id_start))
+			return -EFAULT;
+		/*
+		 * Reset node_id to RSEQ_ID_UNINITIALIZED, so any user coming in after
+		 * unregistration can figure out that rseq needs to be registered
+		 * again.
+		 */
+		if (put_user(id, &t->rseq->node_id))
+			return -EFAULT;
+		fallthrough;
+	case offsetofend(struct rseq, padding1):
+		/*
+		 * Reset cpu_id_start to its initial state (0).
+		 */
+		if (put_user(id_start, &t->rseq->cpu_id_start))
+			return -EFAULT;
+		/*
+		 * Reset cpu_id to RSEQ_ID_UNINITIALIZED, so any user coming in after
+		 * unregistration can figure out that rseq needs to be registered
+		 * again.
+		 */
+		if (put_user(id, &t->rseq->cpu_id))
+			return -EFAULT;
+		break;
+	default:
+		return -EINVAL;
+	}
 	return 0;
 }
 
@@ -293,7 +325,7 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 		if (unlikely(ret < 0))
 			goto error;
 	}
-	if (unlikely(rseq_update_cpu_id(t)))
+	if (unlikely(rseq_update_cpu_node_id(t)))
 		goto error;
 	return;
 
@@ -336,15 +368,16 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		/* Unregister rseq for current thread. */
 		if (current->rseq != rseq || !current->rseq)
 			return -EINVAL;
-		if (rseq_len != sizeof(*rseq))
+		if (rseq_len != current->rseq_len)
 			return -EINVAL;
 		if (current->rseq_sig != sig)
 			return -EPERM;
-		ret = rseq_reset_rseq_cpu_id(current);
+		ret = rseq_reset_rseq_cpu_node_id(current);
 		if (ret)
 			return ret;
 		current->rseq = NULL;
 		current->rseq_sig = 0;
+		current->rseq_len = 0;
 		return 0;
 	}
 
@@ -357,7 +390,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		 * the provided address differs from the prior
 		 * one.
 		 */
-		if (current->rseq != rseq || rseq_len != sizeof(*rseq))
+		if (current->rseq != rseq || rseq_len != current->rseq_len)
 			return -EINVAL;
 		if (current->rseq_sig != sig)
 			return -EPERM;
@@ -369,12 +402,20 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 	 * If there was no rseq previously registered,
 	 * ensure the provided rseq is properly aligned and valid.
 	 */
-	if (!IS_ALIGNED((unsigned long)rseq, __alignof__(*rseq)) ||
-	    rseq_len != sizeof(*rseq))
+	if (!IS_ALIGNED((unsigned long)rseq, __alignof__(*rseq)))
 		return -EINVAL;
+	switch (rseq_len) {
+	case offsetofend(struct rseq, node_id):
+		fallthrough;
+	case offsetofend(struct rseq, padding1):
+		break;
+	default:
+		return -EINVAL;
+	}
 	if (!access_ok(rseq, rseq_len))
 		return -EFAULT;
 	current->rseq = rseq;
+	current->rseq_len = rseq_len;
 	current->rseq_sig = sig;
 	/*
 	 * If rseq was previously inactive, and has just been
-- 
2.17.1

