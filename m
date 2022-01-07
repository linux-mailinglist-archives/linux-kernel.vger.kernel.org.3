Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DAE487AE5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 18:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348428AbiAGRDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 12:03:14 -0500
Received: from mail.efficios.com ([167.114.26.124]:35026 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348391AbiAGRDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 12:03:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id AD4E437A19F;
        Fri,  7 Jan 2022 12:03:10 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bOQmj1UfwrDU; Fri,  7 Jan 2022 12:03:10 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id DA44B379E7B;
        Fri,  7 Jan 2022 12:03:09 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com DA44B379E7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1641574989;
        bh=K+nxIILxOBXRPK8sQ8bAJe5ia11pU0WXQ+j7Fs6Nfcw=;
        h=From:To:Date:Message-Id;
        b=aVANYaEvG181lL205TYrxL51kIXOq5NbU2dwNu7Dj1jIUPmJcUgMHt6fT4Kod4VpU
         v2473lkMLkqN5O3Ha1p8ZLBnj7tvdGbAxv1+rLeBkAGKd8V0aYJdHPUMDVz3ObhDcp
         /orenxs86FvM805aJTDFnseKbD4vXlw2DvZgr9cf6yduKq0jTrPsLIBAnJoAMInoAT
         9nXSbx5SCYwQyfyCRifY4rmDtQMhQqWUlWLMjNLLgF0oE1QFzyAD8Ceskg74Ys/Qic
         vr6aXKbg3LAutHtlANaRHyt6c5OOXnk3tQZA7I2ZCqRN7aNfivtZazN4uZcPXqjmAt
         dAxHeC/CiH6lg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EafJTTreUIo3; Fri,  7 Jan 2022 12:03:09 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 7B3B8379DFD;
        Fri,  7 Jan 2022 12:03:09 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, carlos@redhat.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH] rseq: x86: implement abort-at-ip extension
Date:   Fri,  7 Jan 2022 12:03:02 -0500
Message-Id: <20220107170302.8325-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow rseq critical section abort handlers to optionally figure out at
which instruction pointer the rseq critical section was aborted.

This allows implementing rseq critical sections containing loops, in
which case the commit side-effect cannot be the last instruction. This
is useful to implement adaptative mutexes aware of preemption in
user-space. (see [1])

This also allows implementing rseq critical sections with multiple
commit steps, and use the abort-at-ip information to figure out what
needs to be undone in the abort handler.

Introduce the RSEQ_FLAG_QUERY_ABORT_AT_IP rseq system call flag. This
lets userspace query whether the kernel and architecture supports the
abort-at-ip rseq extension.

Only provide this information for rseq critical sections for which the
rseq_cs descriptor has the RSEQ_CS_FLAG_ABORT_AT_IP flag set. Those
critical sections need to expect those ecx/rcx registers to be
clobbered on abort.

For x86-32, provide the abort-at-ip information in the %ecx register.
For x86-64, provide the abort-at-ip information in the %rcx register.

[1] https://github.com/compudj/rseq-test/blob/adapt-lock-abort-at-ip/test-rseq-adaptative-lock.c#L80

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 arch/x86/include/asm/ptrace.h | 12 ++++++++++++
 include/uapi/linux/rseq.h     |  4 ++++
 kernel/rseq.c                 | 15 +++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index b94f615600d5..0a50e7f14c64 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -387,5 +387,17 @@ extern int do_set_thread_area(struct task_struct *p, int idx,
 # define do_set_thread_area_64(p, s, t)	(0)
 #endif
 
+#ifdef CONFIG_RSEQ
+
+#define RSEQ_ARCH_HAS_ABORT_AT_IP
+
+/* Use ecx/rcx as placeholder for abort-at ip. */
+static inline void rseq_abort_at_ip(struct pt_regs *regs, unsigned long ip)
+{
+	regs->cx = ip;
+}
+
+#endif
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_PTRACE_H */
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
index 6d45ac3dae7f..6612136412c8 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -21,6 +21,13 @@
 #define RSEQ_CS_PREEMPT_MIGRATE_FLAGS (RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE | \
 				       RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT)
 
+#ifdef RSEQ_ARCH_HAS_ABORT_AT_IP
+static bool rseq_has_abort_at_ip(void) { return true; }
+#else
+static bool rseq_has_abort_at_ip(void) { return false; }
+static void rseq_abort_at_ip(struct pt_regs *regs, unsigned long ip) { }
+#endif
+
 /*
  *
  * Restartable sequences are a lightweight interface that allows
@@ -261,6 +268,8 @@ static int rseq_ip_fixup(struct pt_regs *regs)
 	trace_rseq_ip_fixup(ip, rseq_cs.start_ip, rseq_cs.post_commit_offset,
 			    rseq_cs.abort_ip);
 	instruction_pointer_set(regs, (unsigned long)rseq_cs.abort_ip);
+	if (rseq_cs.flags & RSEQ_CS_FLAG_ABORT_AT_IP)
+		rseq_abort_at_ip(regs, ip);
 	return 0;
 }
 
@@ -330,6 +339,12 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
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

