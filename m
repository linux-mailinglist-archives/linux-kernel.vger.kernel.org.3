Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF494A5E5F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 15:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239364AbiBAOeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 09:34:31 -0500
Received: from mail.efficios.com ([167.114.26.124]:42234 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiBAOea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:34:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6E26833DE80;
        Tue,  1 Feb 2022 09:34:29 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id dYR6_Yjr4udI; Tue,  1 Feb 2022 09:34:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7B5D033DB4A;
        Tue,  1 Feb 2022 09:34:28 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7B5D033DB4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643726068;
        bh=HolMuCdDVhBlIOxeLlp6H2mJoEcrIA0JFlAwQ5aaCJU=;
        h=From:To:Date:Message-Id;
        b=cSW53qK6H+b8Kod6ll4vQq5fz9eaQySJj5+BpvHB/k/vWSDkQCDzGEZi0bJTdNcy8
         uDLUA769TpHYpDSF4zzNVobPCf0aWaFltuoBZkWlCyZWgVlXbJbIBb4FWHwDqltkHK
         3pWWpjM1/5qvzl4SwYCtChUlJ3veAuOWv9/bcnfypDDz50ICKE1Bvs8dNNouUXrkeJ
         OL8C9Cilg/5F5lYmDDwfhEeV5JqPEYoo2Iimloz99i+Kg3IUerpOR9+HIQPd6qM/B3
         9Ak5sevl0h/YJT5t0cJO9ARQRVFsHFlxRDWBDcVKhzbaGky4i2mqGycx3Y/vouRYgG
         Bg2Ky49oUPR2Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YpphZWqOMWSV; Tue,  1 Feb 2022 09:34:28 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 070EE33DE00;
        Tue,  1 Feb 2022 09:34:28 -0500 (EST)
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
Subject: [RFC PATCH v2 1/2] rseq: extend struct rseq with numa node id
Date:   Tue,  1 Feb 2022 09:34:24 -0500
Message-Id: <20220201143425.19907-1-mathieu.desnoyers@efficios.com>
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

It can also be useful for implementing fast-paths for NUMA-aware
user-space mutexes.

It also allows implementing getcpu(2) purely in user-space.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/linux/sched.h       |  4 ++
 include/trace/events/rseq.h |  4 +-
 include/uapi/linux/rseq.h   | 24 +++++++++++
 kernel/ptrace.c             |  2 +-
 kernel/rseq.c               | 82 ++++++++++++++++++++++++++-----------
 5 files changed, 89 insertions(+), 27 deletions(-)

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
index 77ee207623a9..386c25b5bbdb 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -130,6 +130,30 @@ struct rseq {
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
+	 * Restartable sequences node_id field. Updated by the kernel. Read by
+	 * user-space with single-copy atomicity semantics. This field should
+	 * only be read by the thread which registered this data structure.
+	 * Aligned on 32-bit. Contains the current NUMA node ID.
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
index 97ac20b4f738..13f6d0419f31 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -81,15 +81,25 @@
  *   F1. <failure>
  */
 
-static int rseq_update_cpu_id(struct task_struct *t)
+static int rseq_update_cpu_node_id(struct task_struct *t)
 {
-	u32 cpu_id = raw_smp_processor_id();
 	struct rseq __user *rseq = t->rseq;
+	u32 cpu_id = raw_smp_processor_id();
+	u32 node_id = cpu_to_node(cpu_id);
 
-	if (!user_write_access_begin(rseq, sizeof(*rseq)))
+	if (!user_write_access_begin(rseq, t->rseq_len))
 		goto efault;
-	unsafe_put_user(cpu_id, &rseq->cpu_id_start, efault_end);
-	unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
+	switch (t->rseq_len) {
+	case offsetofend(struct rseq, node_id):
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
@@ -100,22 +110,35 @@ static int rseq_update_cpu_id(struct task_struct *t)
 	return -EFAULT;
 }
 
-static int rseq_reset_rseq_cpu_id(struct task_struct *t)
+static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 {
-	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED;
+	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0;
 
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
+		 * Reset node_id to its initial state (0).
+		 */
+		if (put_user(node_id, &t->rseq->node_id))
+			return -EFAULT;
+		fallthrough;
+	case offsetofend(struct rseq, padding1):
+		/*
+		 * Reset cpu_id_start to its initial state (0).
+		 */
+		if (put_user(cpu_id_start, &t->rseq->cpu_id_start))
+			return -EFAULT;
+		/*
+		 * Reset cpu_id to RSEQ_CPU_ID_UNINITIALIZED, so any user
+		 * coming in after unregistration can figure out that rseq
+		 * needs to be registered again.
+		 */
+		if (put_user(cpu_id, &t->rseq->cpu_id))
+			return -EFAULT;
+		break;
+	default:
+		return -EINVAL;
+	}
 	return 0;
 }
 
@@ -293,7 +316,7 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 		if (unlikely(ret < 0))
 			goto error;
 	}
-	if (unlikely(rseq_update_cpu_id(t)))
+	if (unlikely(rseq_update_cpu_node_id(t)))
 		goto error;
 	return;
 
@@ -336,15 +359,16 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
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
 
@@ -357,7 +381,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		 * the provided address differs from the prior
 		 * one.
 		 */
-		if (current->rseq != rseq || rseq_len != sizeof(*rseq))
+		if (current->rseq != rseq || rseq_len != current->rseq_len)
 			return -EINVAL;
 		if (current->rseq_sig != sig)
 			return -EPERM;
@@ -369,12 +393,20 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
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

