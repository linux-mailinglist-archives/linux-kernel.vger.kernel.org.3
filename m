Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E24A4BC1AD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239815AbiBRVQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:16:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239668AbiBRVQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:16:12 -0500
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D49023D5F9;
        Fri, 18 Feb 2022 13:15:53 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B85C53BA9C5;
        Fri, 18 Feb 2022 16:06:43 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id chI_aB2d2ptU; Fri, 18 Feb 2022 16:06:43 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3C14C3BAA92;
        Fri, 18 Feb 2022 16:06:43 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3C14C3BAA92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1645218403;
        bh=ehEiD5eN73JoYPbHr0aoW8W4nHv8359VE81+kSIwDoo=;
        h=From:To:Date:Message-Id;
        b=VDWkvVXwlpPMH+iGMjtjSvZddXZUvUm/PMOjulnVzpHEp+BpBlC3Vp8lSTcAgl4fy
         8rL1n7NItMQGP1lto1VpC+kuET9xKmWDCKpqEXRTvUooTL35+tB2/Opf0wtqYYviuH
         /YM5LYg98ZHcN33eR5SZxKJWQbCCUdEeYg7FJZ13FeuPoDZUMd8hs6WNwCHpdxz2Sw
         P6wRvJVkEcDsGoQR1kQx1W1YsSSom4Bg4nnbcrBiSHRpxaTWOyGoGhknY5BzJHc657
         i1C7wpzLTrkFh8Wy3D1tJJ8TGWT6pca/X16u5NDyalZMS6fJ3LvZHBjaErTPDQchMM
         OKPfIvD4L2JBQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LTHpwKlt6g2Y; Fri, 18 Feb 2022 16:06:43 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id AAB3A3BA778;
        Fri, 18 Feb 2022 16:06:42 -0500 (EST)
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
Subject: [RFC PATCH v2 02/11] rseq: Introduce extensible rseq ABI
Date:   Fri, 18 Feb 2022 16:06:24 -0500
Message-Id: <20220218210633.23345-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220218210633.23345-1-mathieu.desnoyers@efficios.com>
References: <20220218210633.23345-1-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the extensible rseq ABI, where the feature size supported by
the kernel and the required alignment are communicated to user-space
through ELF auxiliary vectors.

This allows user-space to call rseq registration with a rseq_len of
either 32 bytes for the original struct rseq size (which includes
padding), or larger.

If rseq_len is larger than 32 bytes, then it must be large enough to
contain the feature size communicated to user-space through ELF
auxiliary vectors.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/linux/sched.h |  4 ++++
 kernel/ptrace.c       |  2 +-
 kernel/rseq.c         | 33 +++++++++++++++++++++++++++------
 3 files changed, 32 insertions(+), 7 deletions(-)

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
index 97ac20b4f738..46dc5c2ce2b7 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -18,6 +18,9 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/rseq.h>
 
+/* The original rseq structure size (including padding) is 32 bytes. */
+#define ORIG_RSEQ_SIZE		32
+
 #define RSEQ_CS_PREEMPT_MIGRATE_FLAGS (RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE | \
 				       RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT)
 
@@ -86,10 +89,15 @@ static int rseq_update_cpu_id(struct task_struct *t)
 	u32 cpu_id = raw_smp_processor_id();
 	struct rseq __user *rseq = t->rseq;
 
-	if (!user_write_access_begin(rseq, sizeof(*rseq)))
+	if (!user_write_access_begin(rseq, t->rseq_len))
 		goto efault;
 	unsafe_put_user(cpu_id, &rseq->cpu_id_start, efault_end);
 	unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
+	/*
+	 * Additional feature fields added after ORIG_RSEQ_SIZE
+	 * need to be conditionally updated only if
+	 * t->rseq_len != ORIG_RSEQ_SIZE.
+	 */
 	user_write_access_end();
 	trace_rseq_update(t);
 	return 0;
@@ -116,6 +124,11 @@ static int rseq_reset_rseq_cpu_id(struct task_struct *t)
 	 */
 	if (put_user(cpu_id, &t->rseq->cpu_id))
 		return -EFAULT;
+	/*
+	 * Additional feature fields added after ORIG_RSEQ_SIZE
+	 * need to be conditionally reset only if
+	 * t->rseq_len != ORIG_RSEQ_SIZE.
+	 */
 	return 0;
 }
 
@@ -336,7 +349,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		/* Unregister rseq for current thread. */
 		if (current->rseq != rseq || !current->rseq)
 			return -EINVAL;
-		if (rseq_len != sizeof(*rseq))
+		if (rseq_len != current->rseq_len)
 			return -EINVAL;
 		if (current->rseq_sig != sig)
 			return -EPERM;
@@ -345,6 +358,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 			return ret;
 		current->rseq = NULL;
 		current->rseq_sig = 0;
+		current->rseq_len = 0;
 		return 0;
 	}
 
@@ -357,7 +371,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		 * the provided address differs from the prior
 		 * one.
 		 */
-		if (current->rseq != rseq || rseq_len != sizeof(*rseq))
+		if (current->rseq != rseq || rseq_len != current->rseq_len)
 			return -EINVAL;
 		if (current->rseq_sig != sig)
 			return -EPERM;
@@ -366,15 +380,22 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 	}
 
 	/*
-	 * If there was no rseq previously registered,
-	 * ensure the provided rseq is properly aligned and valid.
+	 * If there was no rseq previously registered, ensure the provided rseq
+	 * is properly aligned, as communcated to user-space through the ELF
+	 * auxiliary vector AT_RSEQ_ALIGN.
+	 *
+	 * In order to be valid, rseq_len is either the original rseq size, or
+	 * large enough to contain all supported fields, as communicated to
+	 * user-space through the ELF auxiliary vector AT_RSEQ_FEATURE_SIZE.
 	 */
 	if (!IS_ALIGNED((unsigned long)rseq, __alignof__(*rseq)) ||
-	    rseq_len != sizeof(*rseq))
+	    rseq_len < ORIG_RSEQ_SIZE ||
+	    (rseq_len != ORIG_RSEQ_SIZE && rseq_len < offsetof(struct rseq, end)))
 		return -EINVAL;
 	if (!access_ok(rseq, rseq_len))
 		return -EFAULT;
 	current->rseq = rseq;
+	current->rseq_len = rseq_len;
 	current->rseq_sig = sig;
 	/*
 	 * If rseq was previously inactive, and has just been
-- 
2.17.1

