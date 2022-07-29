Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E01585552
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238738AbiG2TDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 15:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238597AbiG2TC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:02:57 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FD188E29;
        Fri, 29 Jul 2022 12:02:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 055D431901A;
        Fri, 29 Jul 2022 15:02:49 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uCippXD8KXZi; Fri, 29 Jul 2022 15:02:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 35903318E98;
        Fri, 29 Jul 2022 15:02:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 35903318E98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1659121365;
        bh=SlksVcAEQwHXv/2n1z59vggbF/JR7rR40IRrV+e+NmA=;
        h=From:To:Date:Message-Id;
        b=dom/woOiwwNfE+wiiNMkWguctUUrw2JryzhuC7UabwX1Tw1LbQRRc3xehozmHcJvs
         xwqFcp8epyeqhH107olHOwiMsyC+DH8Dm8jKJMspgHs9KkdFjAF0+8ohR68j7GwwAF
         TtsveO+8pvg6X4qIN5htU+ZsFQlJv7MOUh08Ac2LBOX4ft9xjI7hyCsi/erlJ0WBr1
         aJcwmLZT2QIeiubqVO6RkjXmVTDHnXtYW8UG0no7fBYbwzveVjaXnCRiDRQIFRnJoH
         gO9GxbMMVPqIXNNenl11ThtU3OC9sReD4cyvUXJEorzT7WluUA61B30cNLjk6TTxUM
         pUfOpPLBUobBw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id V-BhCphR6MiV; Fri, 29 Jul 2022 15:02:45 -0400 (EDT)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id E4E0A318E1A;
        Fri, 29 Jul 2022 15:02:43 -0400 (EDT)
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
Subject: [PATCH v3 10/23] rseq: extend struct rseq with per memory space vcpu id
Date:   Fri, 29 Jul 2022 15:02:12 -0400
Message-Id: <20220729190225.12726-11-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220729190225.12726-1-mathieu.desnoyers@efficios.com>
References: <20220729190225.12726-1-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a memory space has fewer threads than cores, or is limited to run on
few cores concurrently through sched affinity or cgroup cpusets, the
virtual cpu ids will be values close to 0, thus allowing efficient use
of user-space memory for per-cpu data structures.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/uapi/linux/rseq.h |  9 +++++++++
 kernel/rseq.c             | 10 +++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index 1cb90a435c5c..77a136586ac6 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -139,6 +139,15 @@ struct rseq {
 	 */
 	__u32 node_id;
 
+	/*
+	 * Restartable sequences vm_vcpu_id field. Updated by the kernel. Read by
+	 * user-space with single-copy atomicity semantics. This field should
+	 * only be read by the thread which registered this data structure.
+	 * Aligned on 32-bit. Contains the current thread's virtual CPU ID
+	 * (allocated uniquely within a memory space).
+	 */
+	__u32 vm_vcpu_id;
+
 	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
diff --git a/kernel/rseq.c b/kernel/rseq.c
index cb7d8a5afc82..1b00339c341b 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -89,12 +89,14 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
 	struct rseq __user *rseq = t->rseq;
 	u32 cpu_id = raw_smp_processor_id();
 	u32 node_id = cpu_to_node(cpu_id);
+	u32 vm_vcpu_id = task_mm_vcpu_id(t);
 
 	if (!user_write_access_begin(rseq, t->rseq_len))
 		goto efault;
 	unsafe_put_user(cpu_id, &rseq->cpu_id_start, efault_end);
 	unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
 	unsafe_put_user(node_id, &rseq->node_id, efault_end);
+	unsafe_put_user(vm_vcpu_id, &rseq->vm_vcpu_id, efault_end);
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally updated only if
@@ -112,7 +114,8 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
 
 static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 {
-	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0;
+	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0,
+	    vm_vcpu_id = 0;
 
 	/*
 	 * Reset cpu_id_start to its initial state (0).
@@ -131,6 +134,11 @@ static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 	 */
 	if (put_user(node_id, &t->rseq->node_id))
 		return -EFAULT;
+	/*
+	 * Reset vm_vcpu_id to its initial state (0).
+	 */
+	if (put_user(vm_vcpu_id, &t->rseq->vm_vcpu_id))
+		return -EFAULT;
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally reset only if
-- 
2.17.1

