Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCBC58556E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbiG2TEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 15:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238650AbiG2TDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:03:44 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D209D88E29;
        Fri, 29 Jul 2022 12:03:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2B08E3190A2;
        Fri, 29 Jul 2022 15:03:01 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OtB2fgSjqc2M; Fri, 29 Jul 2022 15:03:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3A39D319023;
        Fri, 29 Jul 2022 15:02:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3A39D319023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1659121372;
        bh=GTblBPB6Z8Hr33bZ2XwCDwRC9BmLvYt9Eup9e+epf08=;
        h=From:To:Date:Message-Id;
        b=QNoob/j0qlJ2m63Ypw+GhGWfvL5vVuewdAaYFqRBIkrCeJjnY32B+yNdvzC5IxNZm
         50LXYb6SnsUXD0r76dwwrmd+qElKUcWBOqXB+tHA7QggH6p8M/GDzyuWSRwaFNbKWg
         xWFzrkdCtUW7f3dgapvrSMgbqJ9TbEb8IQTyH30Ir7TLDAQD/tgmr1XYLm4JnHEM/C
         yipQjzEHU6hAfy6P5ye9PejYMV5RsqD8SE89RdUJ9Q/+sGk/A//Hb9l0dtxo2/M5Qr
         NMUS5xI+xE34yo+SSOI6VACo9n+vzRa9N+I9rdVtE42QbTYmLY+B36eZnC4R7QNMEy
         4vqzqgTnSul2A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0MUj4-wnFCBI; Fri, 29 Jul 2022 15:02:52 -0400 (EDT)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id DFDB331908E;
        Fri, 29 Jul 2022 15:02:47 -0400 (EDT)
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
Subject: [PATCH v3 20/23] selftests/rseq: basic percpu ops vm_vcpu_id test
Date:   Fri, 29 Jul 2022 15:02:22 -0400
Message-Id: <20220729190225.12726-21-mathieu.desnoyers@efficios.com>
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

Build a new basic_percpu_ops_vm_vcpu_id_test to test the new
"vm_vcpu_id" rseq field.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/.gitignore       |  1 +
 tools/testing/selftests/rseq/Makefile         |  5 +-
 .../selftests/rseq/basic_percpu_ops_test.c    | 46 ++++++++++++++++---
 3 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/rseq/.gitignore b/tools/testing/selftests/rseq/.gitignore
index 5910888ebfe1..5a7e5acc628c 100644
--- a/tools/testing/selftests/rseq/.gitignore
+++ b/tools/testing/selftests/rseq/.gitignore
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 basic_percpu_ops_test
+basic_percpu_ops_vm_vcpu_id_test
 basic_test
 basic_rseq_op_test
 param_test
diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index 215e1067f037..4210c135e621 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -12,7 +12,7 @@ LDLIBS += -lpthread -ldl
 # still track changes to header files and depend on shared object.
 OVERRIDE_TARGETS = 1
 
-TEST_GEN_PROGS = basic_test basic_percpu_ops_test param_test \
+TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_vm_vcpu_id_test param_test \
 		param_test_benchmark param_test_compare_twice
 
 TEST_GEN_PROGS_EXTENDED = librseq.so
@@ -29,6 +29,9 @@ $(OUTPUT)/librseq.so: rseq.c rseq.h rseq-*.h
 $(OUTPUT)/%: %.c $(TEST_GEN_PROGS_EXTENDED) rseq.h rseq-*.h
 	$(CC) $(CFLAGS) $< $(LDLIBS) -lrseq -o $@
 
+$(OUTPUT)/basic_percpu_ops_vm_vcpu_id_test: basic_percpu_ops_test.c $(TEST_GEN_PROGS_EXTENDED) rseq.h rseq-*.h
+	$(CC) $(CFLAGS) -DBUILDOPT_RSEQ_PERCPU_VM_VCPU_ID $< $(LDLIBS) -lrseq -o $@
+
 $(OUTPUT)/param_test_benchmark: param_test.c $(TEST_GEN_PROGS_EXTENDED) \
 					rseq.h rseq-*.h
 	$(CC) $(CFLAGS) -DBENCHMARK $< $(LDLIBS) -lrseq -o $@
diff --git a/tools/testing/selftests/rseq/basic_percpu_ops_test.c b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
index 517756afc2a4..719ff9910e23 100644
--- a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
+++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
@@ -12,6 +12,32 @@
 #include "../kselftest.h"
 #include "rseq.h"
 
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
+#endif
+
 struct percpu_lock_entry {
 	intptr_t v;
 } __attribute__((aligned(128)));
@@ -51,9 +77,9 @@ int rseq_this_cpu_lock(struct percpu_lock *lock)
 	for (;;) {
 		int ret;
 
-		cpu = rseq_cpu_start();
-		ret = rseq_cmpeqv_storev(&lock->c[cpu].v,
-					 0, 1, cpu);
+		cpu = get_current_cpu_id();
+		ret = rseq_cmpeqv_storev(RSEQ_MO_RELAXED, RSEQ_PERCPU,
+					 &lock->c[cpu].v, 0, 1, cpu);
 		if (rseq_likely(!ret))
 			break;
 		/* Retry if comparison fails or rseq aborts. */
@@ -141,13 +167,14 @@ void this_cpu_list_push(struct percpu_list *list,
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
@@ -170,12 +197,13 @@ struct percpu_list_node *this_cpu_list_pop(struct percpu_list *list,
 		long offset;
 		int ret, cpu;
 
-		cpu = rseq_cpu_start();
+		cpu = get_current_cpu_id();
 		targetptr = (intptr_t *)&list->c[cpu].head;
 		expectnot = (intptr_t)NULL;
 		offset = offsetof(struct percpu_list_node, next);
 		load = (intptr_t *)&head;
-		ret = rseq_cmpnev_storeoffp_load(targetptr, expectnot,
+		ret = rseq_cmpnev_storeoffp_load(RSEQ_MO_RELAXED, RSEQ_PERCPU,
+						 targetptr, expectnot,
 						 offset, load, cpu);
 		if (rseq_likely(!ret)) {
 			if (_cpu)
@@ -295,6 +323,10 @@ int main(int argc, char **argv)
 			errno, strerror(errno));
 		goto error;
 	}
+	if (!rseq_validate_cpu_id()) {
+		fprintf(stderr, "Error: cpu id getter unavailable\n");
+		goto error;
+	}
 	printf("spinlock\n");
 	test_percpu_spinlock();
 	printf("percpu_list\n");
-- 
2.17.1

