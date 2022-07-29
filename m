Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB7258556B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbiG2TEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 15:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238824AbiG2TDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:03:45 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BF68AB37;
        Fri, 29 Jul 2022 12:03:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 897C33190A9;
        Fri, 29 Jul 2022 15:03:02 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FjSsyCqPWGBL; Fri, 29 Jul 2022 15:03:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id AC257318E28;
        Fri, 29 Jul 2022 15:02:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com AC257318E28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1659121372;
        bh=GI5TUw70TsFggMy26+Gy48ykoT2fvjxXI2AaoplVknA=;
        h=From:To:Date:Message-Id;
        b=p99RvNp7adxUrvSbURY7tSPn34Iw1skMde3C1BfzXR8dlN6ewpUPzEvHIlXuhYgi3
         2wHdtazZG/+0JcwO7SikdE64FfOJ9TWYJBD7xvt+nq0CnkN7DyMyBF/+klaMBGBPQm
         tIQ7rc/DA9NsjtYcdRhbLPBThGPslXhE7m+FKgoMP/A3/XFTKTkzIZsONlwIobVvel
         +PlqCSjVKPsY8BV7hDIHn7hOnvlZFNz7YFzoOsLRMb3O3a41zSuwy5/QhygMsPcIor
         DRp7OPmY62vg6JNIuniG1BUvc30emx9JmYNtM6KQoUuoAu0cCRMqwBfDWVISG071zT
         +gUyOBft4B3Qw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dSlcnOIRj8i1; Fri, 29 Jul 2022 15:02:52 -0400 (EDT)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id D7471318C7C;
        Fri, 29 Jul 2022 15:02:48 -0400 (EDT)
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
Subject: [PATCH v3 23/23] selftests/rseq: Implement numa node id vs vm_vcpu_id invariant test
Date:   Fri, 29 Jul 2022 15:02:25 -0400
Message-Id: <20220729190225.12726-24-mathieu.desnoyers@efficios.com>
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

On all architectures except Power, the NUMA topology is never
reconfigured after a CPU has been associated with a NUMA node in the
system lifetime.

Even on Power, we can assume that NUMA topology reconfiguration happens
rarely, and therefore we do not expect it to happen while the NUMA test
is running.

This test validates that the mapping between a vm_vcpu_id and a numa
node id remains valid for the process lifetime. In other words, it
validates that if any thread within the process running on behalf of a
vm_vcpu_id N observes a NUMA node id M, all threads within this process
will always observe the same NUMA node id value when running on behalf
of that same vm_vcpu_id.

This characteristic is important for NUMA locality.

This test is skipped on architectures that do not implement
rseq_load_u32_u32.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/.gitignore       |   1 +
 tools/testing/selftests/rseq/Makefile         |   2 +-
 .../testing/selftests/rseq/basic_numa_test.c  | 117 ++++++++++++++++++
 3 files changed, 119 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rseq/basic_numa_test.c

diff --git a/tools/testing/selftests/rseq/.gitignore b/tools/testing/selftests/rseq/.gitignore
index db5c1a124c6c..9231abed69cc 100644
--- a/tools/testing/selftests/rseq/.gitignore
+++ b/tools/testing/selftests/rseq/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+basic_numa_test
 basic_percpu_ops_test
 basic_percpu_ops_vm_vcpu_id_test
 basic_test
diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index 3eec8e166385..4bf5b7202254 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -12,7 +12,7 @@ LDLIBS += -lpthread -ldl
 # still track changes to header files and depend on shared object.
 OVERRIDE_TARGETS = 1
 
-TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_vm_vcpu_id_test param_test \
+TEST_GEN_PROGS = basic_test basic_numa_test basic_percpu_ops_test basic_percpu_ops_vm_vcpu_id_test param_test \
 		param_test_benchmark param_test_compare_twice param_test_vm_vcpu_id \
 		param_test_vm_vcpu_id_benchmark param_test_vm_vcpu_id_compare_twice
 
diff --git a/tools/testing/selftests/rseq/basic_numa_test.c b/tools/testing/selftests/rseq/basic_numa_test.c
new file mode 100644
index 000000000000..45cb714b135c
--- /dev/null
+++ b/tools/testing/selftests/rseq/basic_numa_test.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * Basic rseq NUMA test. Validate that (vm_vcpu_id, numa_node_id) pairs are
+ * invariant. The only known scenario where this is untrue is on Power which
+ * can reconfigure the NUMA topology on CPU hotunplug/hotplug sequence.
+ */
+
+#define _GNU_SOURCE
+#include <assert.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/time.h>
+
+#include "rseq.h"
+
+#define NR_LOOPS	100000000
+#define NR_THREADS	16
+
+#ifdef RSEQ_ARCH_HAS_LOAD_U32_U32
+
+static
+int cpu_numa_id[CPU_SETSIZE];
+
+static
+void numa_id_init(void)
+{
+	int i;
+
+	for (i = 0; i < CPU_SETSIZE; i++)
+		cpu_numa_id[i] = -1;
+}
+
+static
+void *test_thread(void *arg)
+{
+	int i;
+
+	if (rseq_register_current_thread()) {
+		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+
+	for (i = 0; i < NR_LOOPS; i++) {
+		uint32_t vm_vcpu_id, node;
+		int cached_node_id;
+
+		while (rseq_load_u32_u32(RSEQ_MO_RELAXED, &vm_vcpu_id, &rseq_get_abi()->vm_vcpu_id,
+					 &node, &rseq_get_abi()->node_id) != 0) {
+			/* Retry. */
+		}
+		cached_node_id = RSEQ_READ_ONCE(cpu_numa_id[vm_vcpu_id]);
+		if (cached_node_id == -1) {
+			RSEQ_WRITE_ONCE(cpu_numa_id[vm_vcpu_id], node);
+		} else {
+			if (node != cached_node_id) {
+				fprintf(stderr, "Error: NUMA node id discrepancy: vm_vcpu_id %u cached node id %d node id %u.\n",
+					vm_vcpu_id, cached_node_id, node);
+				fprintf(stderr, "This is likely a kernel bug, or caused by a concurrent NUMA topology reconfiguration.\n");
+				abort();
+			}
+		}
+	}
+
+	if (rseq_unregister_current_thread()) {
+		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+	return NULL;
+}
+
+static
+int test_numa(void)
+{
+        pthread_t tid[NR_THREADS];
+        int err, i;
+        void *tret;
+
+	numa_id_init();
+
+	printf("testing rseq (vm_vcpu_id, numa_node_id) invariant, single thread\n");
+
+	(void) test_thread(NULL);
+
+	printf("testing rseq (vm_vcpu_id, numa_node_id) invariant, multi-threaded\n");
+
+        for (i = 0; i < NR_THREADS; i++) {
+                err = pthread_create(&tid[i], NULL, test_thread, NULL);
+                if (err != 0)
+                        abort();
+        }
+
+        for (i = 0; i < NR_THREADS; i++) {
+                err = pthread_join(tid[i], &tret);
+                if (err != 0)
+                        abort();
+        }
+
+	return 0;
+}
+#else
+static
+int test_numa(void)
+{
+	fprintf(stderr, "rseq_load_u32_u32 is not implemented on this architecture. "
+			"Skipping numa test.\n");
+	return 0;
+}
+#endif
+
+int main(int argc, char **argv)
+{
+	return test_numa();
+}
-- 
2.17.1

