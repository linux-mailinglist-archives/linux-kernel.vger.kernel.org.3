Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B3E5A58BF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 03:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiH3BCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 21:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiH3BBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 21:01:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D13A0325
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 18:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661821297; x=1693357297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zPu33O1T6sljBPKjIPbbTHJ1NfVpNGPZfq20bC8/1jM=;
  b=FuIaE3jLGXwOWZFfqSekrlzQi+3UWi2K7mfGxTk5A6npXbvDSA/58i4b
   2eqvp0qlPpx8cYogqUAsaunUhwE23WrmgQKXVu2YoGTZVkpJGO6YnwR40
   +vL9vWdabEiIMP+yiWrUSijgdLAdXUsEsM0MAspreYtMdR1NR0kAxbZum
   wk/+0yIxaDLGLkMJvAAGxMgPsAGw0x20WxbdcIjlDsFbQAzE1isM377yC
   JEs/xRlGZRJAW/m3xu9vXXfBJfyyYdeSi2qn1kctS5uJLhdFb8XabUN2p
   NfWWlk6Qu9AjOjY4Dj9DdnZ4Dby3bEcAes/S6yVvB8tqT7jd3RAe/Nxjh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="381342296"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="381342296"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 18:01:37 -0700
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="641155109"
Received: from fpalamon-mobl.amr.corp.intel.com (HELO box.shutemov.name) ([10.252.54.23])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 18:01:33 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id A7FD01041E2; Tue, 30 Aug 2022 04:01:24 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Weihong Zhang <weihong.zhang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv8 08/11] selftests/x86/lam: Add malloc and tag-bits test cases for linear-address masking
Date:   Tue, 30 Aug 2022 04:01:01 +0300
Message-Id: <20220830010104.1282-9-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weihong Zhang <weihong.zhang@intel.com>

LAM is supported only in 64-bit mode and applies only addresses used for data
accesses. In 64-bit mode, linear address have 64 bits. LAM is applied to 64-bit
linear address and allow software to use high bits for metadata.
LAM supports configurations that differ regarding which pointer bits are masked
and can be used for metadata.

LAM includes following mode:

 - LAM_U57, pointer bits in positions 62:57 are masked (LAM width 6),
   allows bits 62:57 of a user pointer to be used as metadata.

There are some arch_prctls:
ARCH_ENABLE_TAGGED_ADDR: enable LAM mode, mask high bits of a user pointer.
ARCH_GET_UNTAG_MASK: get current untagged mask.
ARCH_GET_MAX_TAG_BITS: the maximum tag bits user can request. zero if LAM
is not supported.

The LAM mode is for pre-process, a process has only one chance to set LAM mode.
But there is no API to disable LAM mode. So all of test cases are run under
child process.

Functions of this test:

MALLOC

 - LAM_U57 masks bits 57:62 of a user pointer. Process on user space
   can dereference such pointers.

 - Disable LAM, dereference a pointer with metadata above 48 bit or 57 bit
   lead to trigger SIGSEGV.

TAG_BITS

 - Max tag bits of LAM_U57 is 6.

Signed-off-by: Weihong Zhang <weihong.zhang@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/testing/selftests/x86/Makefile |   2 +-
 tools/testing/selftests/x86/lam.c    | 326 +++++++++++++++++++++++++++
 2 files changed, 327 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/lam.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 0388c4d60af0..c1a16a9d4f2f 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -18,7 +18,7 @@ TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
 TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
-			corrupt_xstate_header amx
+			corrupt_xstate_header amx lam
 # Some selftests require 32bit support enabled also on 64bit systems
 TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
 
diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
new file mode 100644
index 000000000000..900a3a0fb709
--- /dev/null
+++ b/tools/testing/selftests/x86/lam.c
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/syscall.h>
+#include <time.h>
+#include <signal.h>
+#include <setjmp.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <inttypes.h>
+
+#include "../kselftest.h"
+
+#ifndef __x86_64__
+# error This test is 64-bit only
+#endif
+
+/* LAM modes, these definitions were copied from kernel code */
+#define LAM_NONE                0
+#define LAM_U57_BITS            6
+
+#define LAM_U57_MASK            (0x3fULL << 57)
+/* arch prctl for LAM */
+#define ARCH_GET_UNTAG_MASK     0x4001
+#define ARCH_ENABLE_TAGGED_ADDR 0x4002
+#define ARCH_GET_MAX_TAG_BITS   0x4003
+
+/* Specified test function bits */
+#define FUNC_MALLOC             0x1
+#define FUNC_BITS               0x2
+
+#define TEST_MASK               0x3
+
+#define MALLOC_LEN              32
+
+struct testcases {
+	unsigned int later;
+	int expected; /* 2: SIGSEGV Error; 1: other errors */
+	unsigned long lam;
+	uint64_t addr;
+	int (*test_func)(struct testcases *test);
+	const char *msg;
+};
+
+int tests_cnt;
+jmp_buf segv_env;
+
+static void segv_handler(int sig)
+{
+	ksft_print_msg("Get segmentation fault(%d).", sig);
+	siglongjmp(segv_env, 1);
+}
+
+static inline int cpu_has_lam(void)
+{
+	unsigned int cpuinfo[4];
+
+	__cpuid_count(0x7, 1, cpuinfo[0], cpuinfo[1], cpuinfo[2], cpuinfo[3]);
+
+	return (cpuinfo[0] & (1 << 26));
+}
+
+/*
+ * Set tagged address and read back untag mask.
+ * check if the untagged mask is expected.
+ *
+ * @return:
+ * 0: Set LAM mode successfully
+ * others: failed to set LAM
+ */
+static int set_lam(unsigned long lam)
+{
+	int ret = 0;
+	uint64_t ptr = 0;
+
+	if (lam != LAM_U57_BITS && lam != LAM_NONE)
+		return -1;
+
+	/* Skip check return */
+	syscall(SYS_arch_prctl, ARCH_ENABLE_TAGGED_ADDR, lam);
+
+	/* Get untagged mask */
+	syscall(SYS_arch_prctl, ARCH_GET_UNTAG_MASK, &ptr);
+
+	/* Check mask returned is expected */
+	if (lam == LAM_U57_BITS)
+		ret = (ptr != ~(LAM_U57_MASK));
+	else if (lam == LAM_NONE)
+		ret = (ptr != -1ULL);
+
+	return ret;
+}
+
+static unsigned long get_default_tag_bits(void)
+{
+	pid_t pid;
+	int lam = LAM_NONE;
+	int ret = 0;
+
+	pid = fork();
+	if (pid < 0) {
+		perror("Fork failed.");
+	} else if (pid == 0) {
+		/* Set LAM mode in child process */
+		if (set_lam(LAM_U57_BITS) == 0)
+			lam = LAM_U57_BITS;
+		else
+			lam = LAM_NONE;
+		exit(lam);
+	} else {
+		wait(&ret);
+		lam = WEXITSTATUS(ret);
+	}
+
+	return lam;
+}
+
+/* According to LAM mode, set metadata in high bits */
+static uint64_t set_metadata(uint64_t src, unsigned long lam)
+{
+	uint64_t metadata;
+
+	srand(time(NULL));
+	/* Get a random value as metadata */
+	metadata = rand();
+
+	switch (lam) {
+	case LAM_U57_BITS: /* Set metadata in bits 62:57 */
+		metadata = (src & ~(LAM_U57_MASK)) | ((metadata & 0x3f) << 57);
+		break;
+	default:
+		metadata = src;
+		break;
+	}
+
+	return metadata;
+}
+
+/*
+ * Set metadata in user pointer, compare new pointer with original pointer.
+ * both pointers should point to the same address.
+ *
+ * @return:
+ * 0: value on the pointer with metadate and value on original are same
+ * 1: not same.
+ */
+static int handle_lam_test(void *src, unsigned int lam)
+{
+	char *ptr;
+
+	strcpy((char *)src, "USER POINTER");
+
+	ptr = (char *)set_metadata((uint64_t)src, lam);
+	if (src == ptr)
+		return 0;
+
+	/* Copy a string into the pointer with metadata */
+	strcpy((char *)ptr, "METADATA POINTER");
+
+	return (!!strcmp((char *)src, (char *)ptr));
+}
+
+
+int handle_max_bits(struct testcases *test)
+{
+	unsigned long exp_bits = get_default_tag_bits();
+	unsigned long bits = 0;
+
+	if (exp_bits != LAM_NONE)
+		exp_bits = LAM_U57_BITS;
+
+	/* Get LAM max tag bits */
+	if (syscall(SYS_arch_prctl, ARCH_GET_MAX_TAG_BITS, &bits) == -1)
+		return 1;
+
+	return (exp_bits != bits);
+}
+
+/*
+ * Test lam feature through dereference pointer get from malloc.
+ * @return 0: Pass test. 1: Get failure during test 2: Get SIGSEGV
+ */
+static int handle_malloc(struct testcases *test)
+{
+	char *ptr = NULL;
+	int ret = 0;
+
+	if (test->later == 0 && test->lam != 0)
+		if (set_lam(test->lam) == -1)
+			return 1;
+
+	ptr = (char *)malloc(MALLOC_LEN);
+	if (ptr == NULL) {
+		perror("malloc() failure\n");
+		return 1;
+	}
+
+	/* Set signal handler */
+	if (sigsetjmp(segv_env, 1) == 0) {
+		signal(SIGSEGV, segv_handler);
+		ret = handle_lam_test(ptr, test->lam);
+	} else {
+		ret = 2;
+	}
+
+	if (test->later != 0 && test->lam != 0)
+		if (set_lam(test->lam) == -1 && ret == 0)
+			ret = 1;
+
+	free(ptr);
+
+	return ret;
+}
+
+static int fork_test(struct testcases *test)
+{
+	int ret, child_ret;
+	pid_t pid;
+
+	pid = fork();
+	if (pid < 0) {
+		perror("Fork failed.");
+		ret = 1;
+	} else if (pid == 0) {
+		ret = test->test_func(test);
+		exit(ret);
+	} else {
+		wait(&child_ret);
+		ret = WEXITSTATUS(child_ret);
+	}
+
+	return ret;
+}
+
+static void run_test(struct testcases *test, int count)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < count; i++) {
+		struct testcases *t = test + i;
+
+		/* fork a process to run test case */
+		ret = fork_test(t);
+		if (ret != 0)
+			ret = (t->expected == ret);
+		else
+			ret = !(t->expected);
+
+		tests_cnt++;
+		ksft_test_result(ret, t->msg);
+	}
+}
+
+static struct testcases malloc_cases[] = {
+	{
+		.later = 0,
+		.lam = LAM_U57_BITS,
+		.test_func = handle_malloc,
+		.msg = "MALLOC: LAM_U57. Dereferencing pointer with metadata\n",
+	},
+	{
+		.later = 1,
+		.expected = 2,
+		.lam = LAM_U57_BITS,
+		.test_func = handle_malloc,
+		.msg = "MALLOC:[Negative] Disable LAM. Dereferencing pointer with metadata.\n",
+	},
+};
+
+
+static struct testcases bits_cases[] = {
+	{
+		.test_func = handle_max_bits,
+		.msg = "BITS: Check default tag bits\n",
+	},
+};
+
+static void cmd_help(void)
+{
+	printf("usage: lam [-h] [-t test list]\n");
+	printf("\t-t test list: run tests specified in the test list, default:0x%x\n", TEST_MASK);
+	printf("\t\t0x1:malloc; 0x2:max_bits;\n");
+	printf("\t-h: help\n");
+}
+
+int main(int argc, char **argv)
+{
+	int c = 0;
+	unsigned int tests = TEST_MASK;
+
+	tests_cnt = 0;
+
+	if (!cpu_has_lam()) {
+		ksft_print_msg("Unsupported LAM feature!\n");
+		return -1;
+	}
+
+	while ((c = getopt(argc, argv, "ht:")) != -1) {
+		switch (c) {
+		case 't':
+			tests = strtoul(optarg, NULL, 16);
+			if (!(tests & TEST_MASK)) {
+				ksft_print_msg("Invalid argument!\n");
+				return -1;
+			}
+			break;
+		case 'h':
+			cmd_help();
+			return 0;
+		default:
+			ksft_print_msg("Invalid argument\n");
+			return -1;
+		}
+	}
+
+	if (tests & FUNC_MALLOC)
+		run_test(malloc_cases, ARRAY_SIZE(malloc_cases));
+
+	if (tests & FUNC_BITS)
+		run_test(bits_cases, ARRAY_SIZE(bits_cases));
+
+	ksft_set_plan(tests_cnt);
+
+	return ksft_exit_pass();
+}
-- 
2.35.1

