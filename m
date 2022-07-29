Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C681658556D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238772AbiG2TEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 15:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238822AbiG2TDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:03:45 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0D58AB32;
        Fri, 29 Jul 2022 12:03:04 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E0435319191;
        Fri, 29 Jul 2022 15:03:01 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DorXpzbBMxQj; Fri, 29 Jul 2022 15:03:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6D123319092;
        Fri, 29 Jul 2022 15:02:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6D123319092
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1659121372;
        bh=XkmpOarcdJW1UW2Vu6h+4fz3fAgi3/rWuEJNTRHvayQ=;
        h=From:To:Date:Message-Id;
        b=QhF102CjUXNx3m/H3L8r7iEc0HrbQqGbQ+JCw8fXskzUp6EDvaSPTESpRtxsVg4Ep
         rpUSqGlU4KqmZGYcHFf1SXmEytndIiUxch5kMuHM4KPERGWpDy333XKe3GxUF/DwZ6
         ZdkMOMgxV7PubMcFIW5fKUXD/qudDgzL49QQpfWd+VF/F+rbTZ7VLDvKJ0kjFT9VYN
         fTG1FwUgOwEpU32eo5S20lGUCEQ1NCVmEVFCujTorjVmTSBk9QLN7agjO7XJmgDA/C
         GsZrgIplhABY1ykTbPBAD1+lftT1bYZagnxMEMBJr8XGi2pE2yZNScoGJf1KHpvuSX
         5LabHpQ2lvxbQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id m5TRdSfxwDs8; Fri, 29 Jul 2022 15:02:52 -0400 (EDT)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 4058A318A7D;
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
Subject: [PATCH v3 21/23] selftests/rseq: parametrized vm_vcpu_id test
Date:   Fri, 29 Jul 2022 15:02:23 -0400
Message-Id: <20220729190225.12726-22-mathieu.desnoyers@efficios.com>
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

Adapt to the rseq.h API changes introduced by commits
"selftests/rseq: <arch>: Template memory ordering and percpu access mode".

Build a new param_test_vm_vcpu_id, param_test_vm_vcpu_id_benchmark, and
param_test_vm_vcpu_id_compare_twice executables to test the new
"vm_vcpu_id" rseq field.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/.gitignore       |   3 +
 tools/testing/selftests/rseq/Makefile         |  15 +-
 tools/testing/selftests/rseq/param_test.c     | 148 ++++++++++++------
 .../testing/selftests/rseq/run_param_test.sh  |   5 +
 4 files changed, 122 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/rseq/.gitignore b/tools/testing/selftests/rseq/.gitignore
index 5a7e5acc628c..db5c1a124c6c 100644
--- a/tools/testing/selftests/rseq/.gitignore
+++ b/tools/testing/selftests/rseq/.gitignore
@@ -6,3 +6,6 @@ basic_rseq_op_test
 param_test
 param_test_benchmark
 param_test_compare_twice
+param_test_vm_vcpu_id
+param_test_vm_vcpu_id_benchmark
+param_test_vm_vcpu_id_compare_twice
diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index 4210c135e621..3eec8e166385 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -13,7 +13,8 @@ LDLIBS += -lpthread -ldl
 OVERRIDE_TARGETS = 1
 
 TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_vm_vcpu_id_test param_test \
-		param_test_benchmark param_test_compare_twice
+		param_test_benchmark param_test_compare_twice param_test_vm_vcpu_id \
+		param_test_vm_vcpu_id_benchmark param_test_vm_vcpu_id_compare_twice
 
 TEST_GEN_PROGS_EXTENDED = librseq.so
 
@@ -39,3 +40,15 @@ $(OUTPUT)/param_test_benchmark: param_test.c $(TEST_GEN_PROGS_EXTENDED) \
 $(OUTPUT)/param_test_compare_twice: param_test.c $(TEST_GEN_PROGS_EXTENDED) \
 					rseq.h rseq-*.h
 	$(CC) $(CFLAGS) -DRSEQ_COMPARE_TWICE $< $(LDLIBS) -lrseq -o $@
+
+$(OUTPUT)/param_test_vm_vcpu_id: param_test.c $(TEST_GEN_PROGS_EXTENDED) \
+					rseq.h rseq-*.h
+	$(CC) $(CFLAGS) -DBUILDOPT_RSEQ_PERCPU_VM_VCPU_ID $< $(LDLIBS) -lrseq -o $@
+
+$(OUTPUT)/param_test_vm_vcpu_id_benchmark: param_test.c $(TEST_GEN_PROGS_EXTENDED) \
+					rseq.h rseq-*.h
+	$(CC) $(CFLAGS) -DBUILDOPT_RSEQ_PERCPU_VM_VCPU_ID -DBENCHMARK $< $(LDLIBS) -lrseq -o $@
+
+$(OUTPUT)/param_test_vm_vcpu_id_compare_twice: param_test.c $(TEST_GEN_PROGS_EXTENDED) \
+					rseq.h rseq-*.h
+	$(CC) $(CFLAGS) -DBUILDOPT_RSEQ_PERCPU_VM_VCPU_ID -DRSEQ_COMPARE_TWICE $< $(LDLIBS) -lrseq -o $@
diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index 9869369a8607..f3687a90ec0c 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -16,6 +16,7 @@
 #include <signal.h>
 #include <errno.h>
 #include <stddef.h>
+#include <stdbool.h>
 
 static inline pid_t rseq_gettid(void)
 {
@@ -36,7 +37,7 @@ static int opt_modulo, verbose;
 
 static int opt_yield, opt_signal, opt_sleep,
 		opt_disable_rseq, opt_threads = 200,
-		opt_disable_mod = 0, opt_test = 's', opt_mb = 0;
+		opt_disable_mod = 0, opt_test = 's';
 
 static long long opt_reps = 5000;
 
@@ -264,6 +265,63 @@ unsigned int yield_mod_cnt, nr_abort;
 
 #include "rseq.h"
 
+static enum rseq_mo opt_mo = RSEQ_MO_RELAXED;
+
+#ifdef RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
+#define TEST_MEMBARRIER
+
+static int sys_membarrier(int cmd, int flags, int cpu_id)
+{
+	return syscall(__NR_membarrier, cmd, flags, cpu_id);
+}
+#endif
+
+#ifdef BUILDOPT_RSEQ_PERCPU_VM_VCPU_ID
+# define RSEQ_PERCPU	RSEQ_PERCPU_VM_VCPU_ID
+static
+int get_current_cpu_id(void)
+{
+	return rseq_current_vm_vcpu_id();
+}
+static
+bool rseq_validate_cpu_id(void)
+{
+	return rseq_vm_vcpu_id_available();
+}
+# ifdef TEST_MEMBARRIER
+/*
+ * Membarrier does not currently support targeting a vm_vcpu_id, so
+ * issue the barrier on all cpus.
+ */
+static
+int rseq_membarrier_expedited(int cpu)
+{
+	return sys_membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
+			      0, 0);
+}
+# endif /* TEST_MEMBARRIER */
+#else
+# define RSEQ_PERCPU	RSEQ_PERCPU_CPU_ID
+static
+int get_current_cpu_id(void)
+{
+	return rseq_cpu_start();
+}
+static
+bool rseq_validate_cpu_id(void)
+{
+	return rseq_current_cpu_raw() >= 0;
+}
+# ifdef TEST_MEMBARRIER
+static
+int rseq_membarrier_expedited(int cpu)
+{
+	return sys_membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
+			      MEMBARRIER_CMD_FLAG_CPU, cpu);
+}
+# endif /* TEST_MEMBARRIER */
+#endif
+
 struct percpu_lock_entry {
 	intptr_t v;
 } __attribute__((aligned(128)));
@@ -351,8 +409,9 @@ static int rseq_this_cpu_lock(struct percpu_lock *lock)
 	for (;;) {
 		int ret;
 
-		cpu = rseq_cpu_start();
-		ret = rseq_cmpeqv_storev(&lock->c[cpu].v,
+		cpu = get_current_cpu_id();
+		ret = rseq_cmpeqv_storev(RSEQ_MO_RELAXED, RSEQ_PERCPU,
+					 &lock->c[cpu].v,
 					 0, 1, cpu);
 		if (rseq_likely(!ret))
 			break;
@@ -469,8 +528,9 @@ void *test_percpu_inc_thread(void *arg)
 		do {
 			int cpu;
 
-			cpu = rseq_cpu_start();
-			ret = rseq_addv(&data->c[cpu].count, 1, cpu);
+			cpu = get_current_cpu_id();
+			ret = rseq_addv(RSEQ_MO_RELAXED, RSEQ_PERCPU,
+					&data->c[cpu].count, 1, cpu);
 		} while (rseq_unlikely(ret));
 #ifndef BENCHMARK
 		if (i != 0 && !(i % (reps / 10)))
@@ -539,13 +599,14 @@ void this_cpu_list_push(struct percpu_list *list,
 		intptr_t *targetptr, newval, expect;
 		int ret;
 
-		cpu = rseq_cpu_start();
+		cpu = get_current_cpu_id();
 		/* Load list->c[cpu].head with single-copy atomicity. */
 		expect = (intptr_t)RSEQ_READ_ONCE(list->c[cpu].head);
 		newval = (intptr_t)node;
 		targetptr = (intptr_t *)&list->c[cpu].head;
 		node->next = (struct percpu_list_node *)expect;
-		ret = rseq_cmpeqv_storev(targetptr, expect, newval, cpu);
+		ret = rseq_cmpeqv_storev(RSEQ_MO_RELAXED, RSEQ_PERCPU,
+					 targetptr, expect, newval, cpu);
 		if (rseq_likely(!ret))
 			break;
 		/* Retry if comparison fails or rseq aborts. */
@@ -571,13 +632,14 @@ struct percpu_list_node *this_cpu_list_pop(struct percpu_list *list,
 		long offset;
 		int ret;
 
-		cpu = rseq_cpu_start();
+		cpu = get_current_cpu_id();
 		targetptr = (intptr_t *)&list->c[cpu].head;
 		expectnot = (intptr_t)NULL;
 		offset = offsetof(struct percpu_list_node, next);
 		load = (intptr_t *)&head;
-		ret = rseq_cmpnev_storeoffp_load(targetptr, expectnot,
-						   offset, load, cpu);
+		ret = rseq_cmpnev_storeoffp_load(RSEQ_MO_RELAXED, RSEQ_PERCPU,
+						 targetptr, expectnot,
+						 offset, load, cpu);
 		if (rseq_likely(!ret)) {
 			node = head;
 			break;
@@ -715,7 +777,7 @@ bool this_cpu_buffer_push(struct percpu_buffer *buffer,
 		intptr_t offset;
 		int ret;
 
-		cpu = rseq_cpu_start();
+		cpu = get_current_cpu_id();
 		offset = RSEQ_READ_ONCE(buffer->c[cpu].offset);
 		if (offset == buffer->c[cpu].buflen)
 			break;
@@ -723,14 +785,9 @@ bool this_cpu_buffer_push(struct percpu_buffer *buffer,
 		targetptr_spec = (intptr_t *)&buffer->c[cpu].array[offset];
 		newval_final = offset + 1;
 		targetptr_final = &buffer->c[cpu].offset;
-		if (opt_mb)
-			ret = rseq_cmpeqv_trystorev_storev_release(
-				targetptr_final, offset, targetptr_spec,
-				newval_spec, newval_final, cpu);
-		else
-			ret = rseq_cmpeqv_trystorev_storev(targetptr_final,
-				offset, targetptr_spec, newval_spec,
-				newval_final, cpu);
+		ret = rseq_cmpeqv_trystorev_storev(opt_mo, RSEQ_PERCPU,
+			targetptr_final, offset, targetptr_spec,
+			newval_spec, newval_final, cpu);
 		if (rseq_likely(!ret)) {
 			result = true;
 			break;
@@ -753,7 +810,7 @@ struct percpu_buffer_node *this_cpu_buffer_pop(struct percpu_buffer *buffer,
 		intptr_t offset;
 		int ret;
 
-		cpu = rseq_cpu_start();
+		cpu = get_current_cpu_id();
 		/* Load offset with single-copy atomicity. */
 		offset = RSEQ_READ_ONCE(buffer->c[cpu].offset);
 		if (offset == 0) {
@@ -763,7 +820,8 @@ struct percpu_buffer_node *this_cpu_buffer_pop(struct percpu_buffer *buffer,
 		head = RSEQ_READ_ONCE(buffer->c[cpu].array[offset - 1]);
 		newval = offset - 1;
 		targetptr = (intptr_t *)&buffer->c[cpu].offset;
-		ret = rseq_cmpeqv_cmpeqv_storev(targetptr, offset,
+		ret = rseq_cmpeqv_cmpeqv_storev(RSEQ_MO_RELAXED, RSEQ_PERCPU,
+			targetptr, offset,
 			(intptr_t *)&buffer->c[cpu].array[offset - 1],
 			(intptr_t)head, newval, cpu);
 		if (rseq_likely(!ret))
@@ -920,7 +978,7 @@ bool this_cpu_memcpy_buffer_push(struct percpu_memcpy_buffer *buffer,
 		size_t copylen;
 		int ret;
 
-		cpu = rseq_cpu_start();
+		cpu = get_current_cpu_id();
 		/* Load offset with single-copy atomicity. */
 		offset = RSEQ_READ_ONCE(buffer->c[cpu].offset);
 		if (offset == buffer->c[cpu].buflen)
@@ -931,15 +989,11 @@ bool this_cpu_memcpy_buffer_push(struct percpu_memcpy_buffer *buffer,
 		copylen = sizeof(item);
 		newval_final = offset + 1;
 		targetptr_final = &buffer->c[cpu].offset;
-		if (opt_mb)
-			ret = rseq_cmpeqv_trymemcpy_storev_release(
-				targetptr_final, offset,
-				destptr, srcptr, copylen,
-				newval_final, cpu);
-		else
-			ret = rseq_cmpeqv_trymemcpy_storev(targetptr_final,
-				offset, destptr, srcptr, copylen,
-				newval_final, cpu);
+		ret = rseq_cmpeqv_trymemcpy_storev(
+			opt_mo, RSEQ_PERCPU,
+			targetptr_final, offset,
+			destptr, srcptr, copylen,
+			newval_final, cpu);
 		if (rseq_likely(!ret)) {
 			result = true;
 			break;
@@ -964,7 +1018,7 @@ bool this_cpu_memcpy_buffer_pop(struct percpu_memcpy_buffer *buffer,
 		size_t copylen;
 		int ret;
 
-		cpu = rseq_cpu_start();
+		cpu = get_current_cpu_id();
 		/* Load offset with single-copy atomicity. */
 		offset = RSEQ_READ_ONCE(buffer->c[cpu].offset);
 		if (offset == 0)
@@ -975,8 +1029,8 @@ bool this_cpu_memcpy_buffer_pop(struct percpu_memcpy_buffer *buffer,
 		copylen = sizeof(*item);
 		newval_final = offset - 1;
 		targetptr_final = &buffer->c[cpu].offset;
-		ret = rseq_cmpeqv_trymemcpy_storev(targetptr_final,
-			offset, destptr, srcptr, copylen,
+		ret = rseq_cmpeqv_trymemcpy_storev(RSEQ_MO_RELAXED, RSEQ_PERCPU,
+			targetptr_final, offset, destptr, srcptr, copylen,
 			newval_final, cpu);
 		if (rseq_likely(!ret)) {
 			result = true;
@@ -1151,7 +1205,7 @@ static int set_signal_handler(void)
 }
 
 /* Test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU membarrier command. */
-#ifdef RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
+#ifdef TEST_MEMBARRIER
 struct test_membarrier_thread_args {
 	int stop;
 	intptr_t percpu_list_ptr;
@@ -1178,9 +1232,10 @@ void *test_membarrier_worker_thread(void *arg)
 		int ret;
 
 		do {
-			int cpu = rseq_cpu_start();
+			int cpu = get_current_cpu_id();
 
-			ret = rseq_offset_deref_addv(&args->percpu_list_ptr,
+			ret = rseq_offset_deref_addv(RSEQ_MO_RELAXED, RSEQ_PERCPU,
+				&args->percpu_list_ptr,
 				sizeof(struct percpu_list_entry) * cpu, 1, cpu);
 		} while (rseq_unlikely(ret));
 	}
@@ -1217,11 +1272,6 @@ void test_membarrier_free_percpu_list(struct percpu_list *list)
 		free(list->c[i].head);
 }
 
-static int sys_membarrier(int cmd, int flags, int cpu_id)
-{
-	return syscall(__NR_membarrier, cmd, flags, cpu_id);
-}
-
 /*
  * The manager thread swaps per-cpu lists that worker threads see,
  * and validates that there are no unexpected modifications.
@@ -1260,8 +1310,7 @@ void *test_membarrier_manager_thread(void *arg)
 
 		/* Make list_b "active". */
 		atomic_store(&args->percpu_list_ptr, (intptr_t)&list_b);
-		if (sys_membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
-					MEMBARRIER_CMD_FLAG_CPU, cpu_a) &&
+		if (rseq_membarrier_expedited(cpu_a) &&
 				errno != ENXIO /* missing CPU */) {
 			perror("sys_membarrier");
 			abort();
@@ -1284,8 +1333,7 @@ void *test_membarrier_manager_thread(void *arg)
 
 		/* Make list_a "active". */
 		atomic_store(&args->percpu_list_ptr, (intptr_t)&list_a);
-		if (sys_membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
-					MEMBARRIER_CMD_FLAG_CPU, cpu_b) &&
+		if (rseq_membarrier_expedited(cpu_b) &&
 				errno != ENXIO /* missing CPU*/) {
 			perror("sys_membarrier");
 			abort();
@@ -1356,7 +1404,7 @@ void test_membarrier(void)
 		abort();
 	}
 }
-#else /* RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV */
+#else /* TEST_MEMBARRIER */
 void test_membarrier(void)
 {
 	fprintf(stderr, "rseq_offset_deref_addv is not implemented on this architecture. "
@@ -1513,7 +1561,7 @@ int main(int argc, char **argv)
 			verbose = 1;
 			break;
 		case 'M':
-			opt_mb = 1;
+			opt_mo = RSEQ_MO_RELEASE;
 			break;
 		default:
 			show_usage(argc, argv);
@@ -1533,6 +1581,10 @@ int main(int argc, char **argv)
 
 	if (!opt_disable_rseq && rseq_register_current_thread())
 		goto error;
+	if (!opt_disable_rseq && !rseq_validate_cpu_id()) {
+		fprintf(stderr, "Error: cpu id getter unavailable\n");
+		goto error;
+	}
 	switch (opt_test) {
 	case 's':
 		printf_verbose("spinlock\n");
diff --git a/tools/testing/selftests/rseq/run_param_test.sh b/tools/testing/selftests/rseq/run_param_test.sh
index f51bc83c9e41..11b5424e8b78 100755
--- a/tools/testing/selftests/rseq/run_param_test.sh
+++ b/tools/testing/selftests/rseq/run_param_test.sh
@@ -42,6 +42,11 @@ function do_tests()
 		./param_test ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
 		echo "Running compare-twice test ${TEST_NAME[$i]}"
 		./param_test_compare_twice ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
+
+		echo "Running vm vcpu_id test ${TEST_NAME[$i]}"
+		./param_test_vm_vcpu_id ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
+		echo "Running vm vcpu_id compare-twice test ${TEST_NAME[$i]}"
+		./param_test_vm_vcpu_id_compare_twice ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
 		let "i++"
 	done
 }
-- 
2.17.1

