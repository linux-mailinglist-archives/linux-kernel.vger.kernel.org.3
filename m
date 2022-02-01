Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F1A4A64FC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242402AbiBAT01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:26:27 -0500
Received: from mail.efficios.com ([167.114.26.124]:53316 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242307AbiBAT0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:26:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4D45533F96E;
        Tue,  1 Feb 2022 14:26:24 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VrV2YAhxAGfy; Tue,  1 Feb 2022 14:26:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id EE50133F86C;
        Tue,  1 Feb 2022 14:26:23 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com EE50133F86C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643743583;
        bh=rEcaRT8dIno2/eBG6LV6mWsx2wF4F5Y+L7Tkkj+balg=;
        h=From:To:Date:Message-Id;
        b=oTBovS2zWHStxJT2hoDmis1LZCdTC2aa3YLR1d4qTeFpkFNQopz1zQ/zXTECCAcGg
         cRnMg8q2y4hrx/uoZqaP2MLNRCbAr9F/47I/Vk6F3i3Xq4kjBJkZi2BVc9+vVhxJWw
         PVB9sQdQBGkN2eKOOpHJJ2L6XtBdtbRGEsfszqknTFsK1yA5G2ZwUFqTUe2LFS3KOT
         2r7PAW5HiMtumbWo9ufZjDDRLGJMTsZvmslDnF69tHuINfdDKAMwINdUkLBNVe0Yye
         REDIpAfVvrP6rtLi98fwykrkrH0MpOVQ/lmGis1JW1rfC2bELXWMW0/3P2GlUFPkfD
         M3VDGJ7D5v+yA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kOYVXgk4cM8O; Tue,  1 Feb 2022 14:26:23 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id C703F33FA40;
        Tue,  1 Feb 2022 14:26:22 -0500 (EST)
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
Subject: [RFC PATCH 2/3] rseq: extend struct rseq with per thread group vcpu id
Date:   Tue,  1 Feb 2022 14:25:39 -0500
Message-Id: <20220201192540.10439-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220201192540.10439-1-mathieu.desnoyers@efficios.com>
References: <20220201192540.10439-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a thread group has fewer threads than cores, or is limited to run on
few cores concurrently through sched affinity or cgroup cpusets, the
virtual cpu ids will be values close to 0, thus allowing efficient use
of user-space memory for per-cpu data structures.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/uapi/linux/rseq.h | 15 +++++++++++++++
 kernel/rseq.c             | 16 +++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index 386c25b5bbdb..d687ac79e62c 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -154,6 +154,21 @@ struct rseq {
 	 * rseq_len. Use the offset immediately after the node_id field as
 	 * rseq_len.
 	 */
+
+	/*
+	 * Restartable sequences tg_vcpu_id field. Updated by the kernel. Read by
+	 * user-space with single-copy atomicity semantics. This field should
+	 * only be read by the thread which registered this data structure.
+	 * Aligned on 32-bit. Contains the current thread's virtual CPU ID
+	 * (allocated uniquely within thread group).
+	 */
+	__u32 tg_vcpu_id;
+
+	/*
+	 * This is a valid end of rseq ABI for the purpose of rseq registration
+	 * rseq_len. Use the offset immediately after the tg_vcpu_id field as
+	 * rseq_len.
+	 */
 } __attribute__((aligned(4 * sizeof(__u64))));
 
 #endif /* _UAPI_LINUX_RSEQ_H */
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 13f6d0419f31..37b43735a400 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -86,10 +86,14 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
 	struct rseq __user *rseq = t->rseq;
 	u32 cpu_id = raw_smp_processor_id();
 	u32 node_id = cpu_to_node(cpu_id);
+	u32 tg_vcpu_id = task_tg_vcpu_id(t);
 
 	if (!user_write_access_begin(rseq, t->rseq_len))
 		goto efault;
 	switch (t->rseq_len) {
+	case offsetofend(struct rseq, tg_vcpu_id):
+		unsafe_put_user(tg_vcpu_id, &rseq->tg_vcpu_id, efault_end);
+		fallthrough;
 	case offsetofend(struct rseq, node_id):
 		unsafe_put_user(node_id, &rseq->node_id, efault_end);
 		fallthrough;
@@ -112,9 +116,17 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
 
 static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 {
-	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0;
+	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0,
+	    tg_vcpu_id = 0;
 
 	switch (t->rseq_len) {
+	case offsetofend(struct rseq, tg_vcpu_id):
+		/*
+		 * Reset tg_vcpu_id to its initial state (0).
+		 */
+		if (put_user(tg_vcpu_id, &t->rseq->tg_vcpu_id))
+			return -EFAULT;
+		fallthrough;
 	case offsetofend(struct rseq, node_id):
 		/*
 		 * Reset node_id to its initial state (0).
@@ -396,6 +408,8 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 	if (!IS_ALIGNED((unsigned long)rseq, __alignof__(*rseq)))
 		return -EINVAL;
 	switch (rseq_len) {
+	case offsetofend(struct rseq, tg_vcpu_id):
+		fallthrough;
 	case offsetofend(struct rseq, node_id):
 		fallthrough;
 	case offsetofend(struct rseq, padding1):
-- 
2.17.1

