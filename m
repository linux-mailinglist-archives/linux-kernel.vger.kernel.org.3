Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830BE4A8C94
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 20:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353788AbiBCTjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 14:39:05 -0500
Received: from mail.efficios.com ([167.114.26.124]:53806 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346461AbiBCTjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 14:39:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8C288392552;
        Thu,  3 Feb 2022 14:39:02 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nkHqmIsvE4lW; Thu,  3 Feb 2022 14:39:02 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 20E603923B7;
        Thu,  3 Feb 2022 14:39:02 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 20E603923B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643917142;
        bh=BioWaSozmqqbtmvJnfrlpWvhCFvnAXGhaRyjzgR7bfg=;
        h=From:To:Date:Message-Id;
        b=SdFEHycYEa+7Z+NvBVlJriTZEZCOLwAI/dARqBJOqu8OQVxuxI57nfQQFvSQqjvCw
         igf57TiKyM5ClrmmJnSqYObALWB+meoH8Ah9dAhDCKiLjOcp+pw4OLOkSSskHJDRjG
         U4gmLy2CniAb8rhEPjTTosPc+63pMlvLBpYdHomm9ESFY4MugkbmQGqJkAt3xeAb6C
         t30aifEdvnAsPv77LVwhbxVYofNRhvlVQf+jsJFCEAKkafUNE2UkPYdiy18iuE3sFR
         bAHBrJRRRHmyRYl6FJIgYOT+B9Ga6u0KRWOJP+bCA/2H4aj7x9d2ihLV8wymWrRTlQ
         vfXIatugqgwXQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6JglWsGeGj90; Thu,  3 Feb 2022 14:39:02 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 993B7392172;
        Thu,  3 Feb 2022 14:39:01 -0500 (EST)
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
Subject: [RFC PATCH 1/3] rseq: Introduce feature size and alignment ELF auxiliary vector entries
Date:   Thu,  3 Feb 2022 14:38:51 -0500
Message-Id: <20220203193853.21511-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the rseq feature size supported by the kernel as well as the
required allocation alignment for the rseq per-thread area to user-space
through ELF auxiliary vector entries.

This is part of the extensible rseq ABI.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 fs/binfmt_elf.c             | 5 +++++
 include/uapi/linux/auxvec.h | 2 ++
 include/uapi/linux/rseq.h   | 5 +++++
 3 files changed, 12 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 605017eb9349..77776582e76d 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -46,6 +46,7 @@
 #include <linux/cred.h>
 #include <linux/dax.h>
 #include <linux/uaccess.h>
+#include <linux/rseq.h>
 #include <asm/param.h>
 #include <asm/page.h>
 
@@ -286,6 +287,10 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	if (bprm->have_execfd) {
 		NEW_AUX_ENT(AT_EXECFD, bprm->execfd);
 	}
+#ifdef CONFIG_RSEQ
+	NEW_AUX_ENT(AT_RSEQ_FEATURE_SIZE, offsetof(struct rseq, end));
+	NEW_AUX_ENT(AT_RSEQ_ALIGN, __alignof__(struct rseq));
+#endif
 #undef NEW_AUX_ENT
 	/* AT_NULL is zero; clear the rest too */
 	memset(elf_info, 0, (char *)mm->saved_auxv +
diff --git a/include/uapi/linux/auxvec.h b/include/uapi/linux/auxvec.h
index c7e502bf5a6f..6991c4b8ab18 100644
--- a/include/uapi/linux/auxvec.h
+++ b/include/uapi/linux/auxvec.h
@@ -30,6 +30,8 @@
 				 * differ from AT_PLATFORM. */
 #define AT_RANDOM 25	/* address of 16 random bytes */
 #define AT_HWCAP2 26	/* extension of AT_HWCAP */
+#define AT_RSEQ_FEATURE_SIZE	27	/* rseq supported feature size */
+#define AT_RSEQ_ALIGN		28	/* rseq allocation alignment */
 
 #define AT_EXECFN  31	/* filename of program */
 
diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index 77ee207623a9..05d3c4cdeb40 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -130,6 +130,11 @@ struct rseq {
 	 *     this thread.
 	 */
 	__u32 flags;
+
+	/*
+	 * Flexible array member at end of structure, after last feature field.
+	 */
+	char end[];
 } __attribute__((aligned(4 * sizeof(__u64))));
 
 #endif /* _UAPI_LINUX_RSEQ_H */
-- 
2.17.1

