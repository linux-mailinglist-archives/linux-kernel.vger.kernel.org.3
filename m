Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE37489E2C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbiAJRQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:16:23 -0500
Received: from mail.efficios.com ([167.114.26.124]:49764 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbiAJRQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:16:22 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 18BFE3C3DF7;
        Mon, 10 Jan 2022 12:16:21 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id boMv-Mp89bp3; Mon, 10 Jan 2022 12:16:19 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D168C3C42A3;
        Mon, 10 Jan 2022 12:16:19 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D168C3C42A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1641834979;
        bh=6eOMmh6drkuwfNYZcjGSX3XdkORvuilSa/OuJokj+n4=;
        h=From:To:Date:Message-Id;
        b=VaUXJBhXl6+z5GT0mG5UpqUpeLLfISw4px8NuMoPgIOw8OE1YH9n7lpPf2pXJquEb
         nRxRet30B1eoyEkBDmCCw6kz//VGtOX6+tH2cS1XvoPA8L41n1xbztQEwAO7u47nFe
         YH88TgWy0MvvE9MCPuN8Q6+IYqOfN6qNfe8WPhDUipNMc5TnDsLjtPzY5XI6DBYKwo
         zebwJlINwPHgoRTwjue9AbisnKvDjiGBHj8yTFUDMxFOUth3KhDM609oCdfqmfcY94
         YKe6u+0LT2yaisCo0l6q0zRFDRyrovU7h03RgJnfpYBg3u4TM/rYjY2BrwE+eZ8l71
         HCWvH+LVCdKcg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aIOiLTXpew6Z; Mon, 10 Jan 2022 12:16:19 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 5F2303C3D7B;
        Mon, 10 Jan 2022 12:16:19 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH v2 1/2] rseq: x86: implement abort-at-ip extension
Date:   Mon, 10 Jan 2022 12:16:10 -0500
Message-Id: <20220110171611.8351-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow rseq critical section abort handlers to optionally figure out at
which instruction pointer the rseq critical section was aborted.

This allows implementing rseq critical sections with loops containing
the commit instruction, for which having the commit as last instruction
of the sequence is not possible.  This is useful to implement adaptative
mutexes aware of preemption in user-space. (see [1])

This also allows implementing rseq critical sections with multiple
commit steps, and use the abort-at-ip information to figure out what
needs to be undone in the abort handler.

Introduce the RSEQ_FLAG_QUERY_ABORT_AT_IP rseq system call flag.  This
lets userspace query whether the kernel and architecture supports the
abort-at-ip rseq extension.

Only provide this information for rseq critical sections for which the
rseq_cs descriptor has the RSEQ_CS_FLAG_ABORT_AT_IP flag set.  Abort
handlers for critical sections with this flag set need to readjust the
stack pointer.  The abort-at-ip pointer is populated by the kernel on
the top of stack on abort.  For x86-32, the abort handler of an
abort-at-ip critical section needs to add 4 bytes to the stack pointer.
For x86-64, the abort hanler needs to add 136 bytes to the stack
pointer: 8 bytes to skip the abort-at-ip value, and 128 bytes to skip
the x86-64 redzone for leaf functions.

[1] https://github.com/compudj/rseq-test/blob/adapt-lock-abort-at-ip/test-rseq-adaptative-lock.c#L80

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
Changes since v1:
- Use top of stack to place abort-at-ip value rather than ecx/rcx
  register,
- Skip redzone on x86-64.
---
 arch/x86/include/asm/ptrace.h |  5 +++++
 arch/x86/kernel/ptrace.c      | 12 ++++++++++++
 include/uapi/linux/rseq.h     |  4 ++++
 kernel/rseq.c                 | 28 ++++++++++++++++++++++++++++
 4 files changed, 49 insertions(+)

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 703663175a5a..c96eb2448110 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -387,5 +387,10 @@ extern int do_set_thread_area(struct task_struct *p, int idx,
 # define do_set_thread_area_64(p, s, t)	(0)
 #endif
 
+#ifdef CONFIG_RSEQ
+# define RSEQ_ARCH_HAS_ABORT_AT_IP
+int rseq_abort_at_ip(struct pt_regs *regs, unsigned long ip);
+#endif
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_PTRACE_H */
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 6d2244c94799..561ed98d12ba 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -1368,3 +1368,15 @@ void user_single_step_report(struct pt_regs *regs)
 {
 	send_sigtrap(regs, 0, TRAP_BRKPT);
 }
+
+int rseq_abort_at_ip(struct pt_regs *regs, unsigned long ip)
+{
+	if (user_64bit_mode(regs)) {
+		/* Need to skip redzone for leaf functions. */
+		regs->sp -= sizeof(u64) + 128;
+		return put_user(ip, (u64 __user *)regs->sp);
+	} else {
+		regs->sp -= sizeof(u32);
+		return put_user(ip, (u32 __user *)regs->sp);
+	}
+}
diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index 9a402fdb60e9..3130232e6d0c 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -20,12 +20,14 @@ enum rseq_cpu_id_state {
 
 enum rseq_flags {
 	RSEQ_FLAG_UNREGISTER = (1 << 0),
+	RSEQ_FLAG_QUERY_ABORT_AT_IP = (1 << 1),
 };
 
 enum rseq_cs_flags_bit {
 	RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT	= 0,
 	RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT	= 1,
 	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT	= 2,
+	RSEQ_CS_FLAG_ABORT_AT_IP_BIT		= 3,
 };
 
 enum rseq_cs_flags {
@@ -35,6 +37,8 @@ enum rseq_cs_flags {
 		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT),
 	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE	=
 		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
+	RSEQ_CS_FLAG_ABORT_AT_IP		=
+		(1U << RSEQ_CS_FLAG_ABORT_AT_IP_BIT),
 };
 
 /*
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 6d45ac3dae7f..fb52f2d11b56 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -21,6 +21,13 @@
 #define RSEQ_CS_PREEMPT_MIGRATE_FLAGS (RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE | \
 				       RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT)
 
+#ifdef RSEQ_ARCH_HAS_ABORT_AT_IP
+static bool rseq_has_abort_at_ip(void) { return true; }
+#else
+static bool rseq_has_abort_at_ip(void) { return false; }
+static int rseq_abort_at_ip(struct pt_regs *regs, unsigned long ip) { return 0; }
+#endif
+
 /*
  *
  * Restartable sequences are a lightweight interface that allows
@@ -79,6 +86,16 @@
  *
  *       [abort_ip]
  *   F1. <failure>
+ *
+ * rseq critical sections defined with the RSEQ_CS_FLAG_ABORT_AT_IP flag
+ * have the following behavior on abort: when the stack grows down: the
+ * stack pointer is decremented to skip the redzone, and decremented of
+ * the pointer size.  The aborted address (abort-at-ip) is stored at
+ * this stack pointer location.  The user-space abort handler needs to
+ * pop the abort-at-ip address from the stack, and add the redzone size
+ * to the stack pointer.
+ *
+ * TODO: describe stack grows up.
  */
 
 static int rseq_update_cpu_id(struct task_struct *t)
@@ -261,6 +278,11 @@ static int rseq_ip_fixup(struct pt_regs *regs)
 	trace_rseq_ip_fixup(ip, rseq_cs.start_ip, rseq_cs.post_commit_offset,
 			    rseq_cs.abort_ip);
 	instruction_pointer_set(regs, (unsigned long)rseq_cs.abort_ip);
+	if (rseq_cs.flags & RSEQ_CS_FLAG_ABORT_AT_IP) {
+		ret = rseq_abort_at_ip(regs, ip);
+		if (ret)
+			return ret;
+	}
 	return 0;
 }
 
@@ -330,6 +352,12 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 {
 	int ret;
 
+	if (flags & RSEQ_FLAG_QUERY_ABORT_AT_IP) {
+		if (flags & ~RSEQ_FLAG_QUERY_ABORT_AT_IP)
+			return -EINVAL;
+		return rseq_has_abort_at_ip() ? 0 : -EINVAL;
+	}
+
 	if (flags & RSEQ_FLAG_UNREGISTER) {
 		if (flags & ~RSEQ_FLAG_UNREGISTER)
 			return -EINVAL;
-- 
2.17.1

