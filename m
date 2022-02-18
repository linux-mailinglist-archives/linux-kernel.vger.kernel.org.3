Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25D54BC1A3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbiBRVQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:16:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239663AbiBRVQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:16:13 -0500
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDAB2569FA;
        Fri, 18 Feb 2022 13:15:53 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 300323BA92B;
        Fri, 18 Feb 2022 16:06:44 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gxHMX7oOs1gJ; Fri, 18 Feb 2022 16:06:43 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9FB843BA956;
        Fri, 18 Feb 2022 16:06:43 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9FB843BA956
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1645218403;
        bh=jCxgnH0UNMK3Owi2ll3NEMWJYgSQdasrufNioWW7/gE=;
        h=From:To:Date:Message-Id;
        b=N6yUry2cuukjTzNG3GP6YHRVGCkZTfHMwCN/eeYamC9oOLxJEiV08dhNUnKWRvNvX
         1PbqbkgoLwjqcWSPfzU1ihyOK80IFattyAaXDNc4fenUcoxGhpU52jUpB0yBBD/MCb
         /szseLusBFAaAKWGBIrRkhysTe6vy1/9Nts9Y7Tl0tCod0f3B4vvM4f4Zts42VSxXT
         kW2hbJXaO9rjSSBNOBlQq8Wf6vAs/VuwkyLz0KcU5UnsOtSB3AHUteharNicDgkoB1
         0p5YCaaDJYdnFE9axd8TYZDTDUa4/2v3pW3EPcWml9/Z6qqbCUeYlzAIdNCct1SILd
         +MJyXlqmw+F4g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hLVxdEubDYpf; Fri, 18 Feb 2022 16:06:43 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 388763BAB11;
        Fri, 18 Feb 2022 16:06:43 -0500 (EST)
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
Subject: [RFC PATCH v2 04/11] selftests/rseq: Use ELF auxiliary vector for extensible rseq
Date:   Fri, 18 Feb 2022 16:06:26 -0500
Message-Id: <20220218210633.23345-5-mathieu.desnoyers@efficios.com>
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

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/rseq-abi.h |  5 ++
 tools/testing/selftests/rseq/rseq.c     | 68 ++++++++++++++++++++++---
 tools/testing/selftests/rseq/rseq.h     | 15 ++++--
 3 files changed, 76 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-abi.h b/tools/testing/selftests/rseq/rseq-abi.h
index a8c44d9af71f..00ac846d85b0 100644
--- a/tools/testing/selftests/rseq/rseq-abi.h
+++ b/tools/testing/selftests/rseq/rseq-abi.h
@@ -146,6 +146,11 @@ struct rseq_abi {
 	 *     this thread.
 	 */
 	__u32 flags;
+
+	/*
+	 * Flexible array member at end of structure, after last feature field.
+	 */
+	char end[];
 } __attribute__((aligned(4 * sizeof(__u64))));
 
 #endif /* _RSEQ_ABI_H */
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 986b9458efb2..506f2b17aea6 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -28,6 +28,8 @@
 #include <limits.h>
 #include <dlfcn.h>
 #include <stddef.h>
+#include <sys/auxv.h>
+#include <linux/auxvec.h>
 
 #include "../kselftest.h"
 #include "rseq.h"
@@ -39,17 +41,35 @@ static const unsigned int *libc_rseq_flags_p;
 /* Offset from the thread pointer to the rseq area.  */
 ptrdiff_t rseq_offset;
 
-/* Size of the registered rseq area.  0 if the registration was
-   unsuccessful.  */
+/*
+ * Size of the registered rseq area.  0 if the registration was
+ * unsuccessful.
+ */
 unsigned int rseq_size = -1U;
 
-/* Flags used during rseq registration.  */
+/* Flags used during rseq registration. */
 unsigned int rseq_flags;
 
+/*
+ * rseq feature size supported by the kernel.  0 if the registration was
+ * unsuccessful.
+ */
+unsigned int rseq_feature_size = -1U;
+
 static int rseq_ownership;
+static int rseq_reg_success;	/* At least one rseq registration has succeeded. */
+
+/* Allocate a large area for the TLS. */
+#define RSEQ_THREAD_AREA_ALLOC_SIZE	1024
+
+/* Original struct rseq feature size is 20 bytes. */
+#define ORIG_RSEQ_FEATURE_SIZE		20
+
+/* Original struct rseq allocation size is 32 bytes. */
+#define ORIG_RSEQ_ALLOC_SIZE		32
 
 static
-__thread struct rseq_abi __rseq_abi __attribute__((tls_model("initial-exec"))) = {
+__thread struct rseq_abi __rseq_abi __attribute__((tls_model("initial-exec"), aligned(RSEQ_THREAD_AREA_ALLOC_SIZE))) = {
 	.cpu_id = RSEQ_ABI_CPU_ID_UNINITIALIZED,
 };
 
@@ -84,10 +104,18 @@ int rseq_register_current_thread(void)
 		/* Treat libc's ownership as a successful registration. */
 		return 0;
 	}
-	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq_abi), 0, RSEQ_SIG);
-	if (rc)
+	rc = sys_rseq(&__rseq_abi, rseq_size, 0, RSEQ_SIG);
+	if (rc) {
+		if (RSEQ_READ_ONCE(rseq_reg_success)) {
+			/* Incoherent success/failure within process. */
+			abort();
+		}
+		rseq_size = 0;
+		rseq_feature_size = 0;
 		return -1;
+	}
 	assert(rseq_current_cpu_raw() >= 0);
+	RSEQ_WRITE_ONCE(rseq_reg_success, 1);
 	return 0;
 }
 
@@ -99,12 +127,28 @@ int rseq_unregister_current_thread(void)
 		/* Treat libc's ownership as a successful unregistration. */
 		return 0;
 	}
-	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq_abi), RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
+	rc = sys_rseq(&__rseq_abi, rseq_size, RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
 	if (rc)
 		return -1;
 	return 0;
 }
 
+static
+unsigned int get_rseq_feature_size(void)
+{
+	unsigned long auxv_rseq_feature_size, auxv_rseq_align;
+
+	auxv_rseq_align = getauxval(AT_RSEQ_ALIGN);
+	assert(!auxv_rseq_align || auxv_rseq_align <= RSEQ_THREAD_AREA_ALLOC_SIZE);
+
+	auxv_rseq_feature_size = getauxval(AT_RSEQ_FEATURE_SIZE);
+	assert(!auxv_rseq_feature_size || auxv_rseq_feature_size <= RSEQ_THREAD_AREA_ALLOC_SIZE);
+	if (auxv_rseq_feature_size)
+		return auxv_rseq_feature_size;
+	else
+		return ORIG_RSEQ_FEATURE_SIZE;
+}
+
 static __attribute__((constructor))
 void rseq_init(void)
 {
@@ -116,14 +160,21 @@ void rseq_init(void)
 		rseq_offset = *libc_rseq_offset_p;
 		rseq_size = *libc_rseq_size_p;
 		rseq_flags = *libc_rseq_flags_p;
+		rseq_feature_size = get_rseq_feature_size();
+		if (rseq_feature_size > rseq_size)
+			rseq_feature_size = rseq_size;
 		return;
 	}
 	if (!rseq_available())
 		return;
 	rseq_ownership = 1;
 	rseq_offset = (void *)&__rseq_abi - rseq_thread_pointer();
-	rseq_size = sizeof(struct rseq_abi);
 	rseq_flags = 0;
+	rseq_feature_size = get_rseq_feature_size();
+	if (rseq_feature_size == ORIG_RSEQ_FEATURE_SIZE)
+		rseq_size = ORIG_RSEQ_ALLOC_SIZE;
+	else
+		rseq_size = RSEQ_THREAD_AREA_ALLOC_SIZE;
 }
 
 static __attribute__((destructor))
@@ -133,6 +184,7 @@ void rseq_exit(void)
 		return;
 	rseq_offset = 0;
 	rseq_size = -1U;
+	rseq_feature_size = -1U;
 	rseq_ownership = 0;
 }
 
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index 9d850b290c2e..e73db2e82a11 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -47,13 +47,20 @@
 
 #include "rseq-thread-pointer.h"
 
-/* Offset from the thread pointer to the rseq area.  */
+/* Offset from the thread pointer to the rseq area. */
 extern ptrdiff_t rseq_offset;
-/* Size of the registered rseq area.  0 if the registration was
-   unsuccessful.  */
+/*
+ * Size of the registered rseq area.  0 if the registration was
+ * unsuccessful.
+ */
 extern unsigned int rseq_size;
-/* Flags used during rseq registration.  */
+/* Flags used during rseq registration. */
 extern unsigned int rseq_flags;
+/*
+ * rseq feature size supported by the kernel.  0 if the registration was
+ * unsuccessful.
+ */
+extern unsigned int rseq_feature_size;
 
 static inline struct rseq_abi *rseq_get_abi(void)
 {
-- 
2.17.1

