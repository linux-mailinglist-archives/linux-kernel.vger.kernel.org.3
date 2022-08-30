Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAFC5A58BD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 03:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiH3BCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 21:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiH3BBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 21:01:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CD1A027E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 18:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661821298; x=1693357298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=paLLfnuCD3vCLKnZtUsd0mpWPekiZ/gq8Xe6lyMWCSA=;
  b=EZur8Cd9BcROwVmaDDK6nkqClPGoYJIKEvLugCsRCHJUFpChvfBOdt/v
   jplAEb1JCqevju46jGhX6VX9bvJblqlIbX3RbZcR7IvV3loEYL+jwplDH
   yJLxIzDv6d5baBgdBcxD6YodZtXMODbcYtyUTzLBs92ijSgsKfv+7ENKN
   96issaMF7TVaoejKjfXDn57uc+XuBM3lcjWTHFH5B+0KVIBB0GKp/Rl4d
   lSaG76Db4EYUqcOIFMJHhcUaZ/cSoRl+CFLVz93LIosFr/7oAcDpZZS+a
   CDaW4r2C/pl9OAuVRw6ecSeZ/mhfa0+oQJkZvsPpmZadgFfkkiYhJOWGF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="359008858"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="359008858"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 18:01:37 -0700
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="787305244"
Received: from fpalamon-mobl.amr.corp.intel.com (HELO box.shutemov.name) ([10.252.54.23])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 18:01:33 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id B1E3C10428A; Tue, 30 Aug 2022 04:01:24 +0300 (+03)
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
Subject: [PATCHv8 09/11] selftests/x86/lam: Add mmap and SYSCALL test cases for linear-address masking
Date:   Tue, 30 Aug 2022 04:01:02 +0300
Message-Id: <20220830010104.1282-10-kirill.shutemov@linux.intel.com>
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

Add mmap and SYSCALL test cases.

SYSCALL test cases:

 - LAM supports set metadata in high bits 62:57 (LAM_U57) of a user pointer, pass
   the pointer to SYSCALL, SYSCALL can dereference the pointer and return correct
   result.

 - Disable LAM, pass a pointer with metadata in high bits to SYSCALL,
   SYSCALL returns -1 (EFAULT).

MMAP test cases:

 - Enable LAM_U57, MMAP with low address (below bits 47), set metadata
   in high bits of the address, dereference the address should be
   allowed.

 - Enable LAM_U57, MMAP with high address (above bits 47), set metadata
   in high bits of the address, dereference the address should be
   allowed.

Signed-off-by: Weihong Zhang <weihong.zhang@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/testing/selftests/x86/lam.c | 135 +++++++++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 900a3a0fb709..b88e007ee0a3 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -7,6 +7,7 @@
 #include <signal.h>
 #include <setjmp.h>
 #include <sys/mman.h>
+#include <sys/utsname.h>
 #include <sys/wait.h>
 #include <inttypes.h>
 
@@ -29,11 +30,18 @@
 /* Specified test function bits */
 #define FUNC_MALLOC             0x1
 #define FUNC_BITS               0x2
+#define FUNC_MMAP               0x4
+#define FUNC_SYSCALL            0x8
 
-#define TEST_MASK               0x3
+#define TEST_MASK               0xf
+
+#define LOW_ADDR                (0x1UL << 30)
+#define HIGH_ADDR               (0x3UL << 48)
 
 #define MALLOC_LEN              32
 
+#define PAGE_SIZE               (4 << 10)
+
 struct testcases {
 	unsigned int later;
 	int expected; /* 2: SIGSEGV Error; 1: other errors */
@@ -49,6 +57,7 @@ jmp_buf segv_env;
 static void segv_handler(int sig)
 {
 	ksft_print_msg("Get segmentation fault(%d).", sig);
+
 	siglongjmp(segv_env, 1);
 }
 
@@ -61,6 +70,16 @@ static inline int cpu_has_lam(void)
 	return (cpuinfo[0] & (1 << 26));
 }
 
+/* Check 5-level page table feature in CPUID.(EAX=07H, ECX=00H):ECX.[bit 16] */
+static inline int cpu_has_la57(void)
+{
+	unsigned int cpuinfo[4];
+
+	__cpuid_count(0x7, 0, cpuinfo[0], cpuinfo[1], cpuinfo[2], cpuinfo[3]);
+
+	return (cpuinfo[2] & (1 << 16));
+}
+
 /*
  * Set tagged address and read back untag mask.
  * check if the untagged mask is expected.
@@ -213,6 +232,68 @@ static int handle_malloc(struct testcases *test)
 	return ret;
 }
 
+static int handle_mmap(struct testcases *test)
+{
+	void *ptr;
+	unsigned int flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED;
+	int ret = 0;
+
+	if (test->later == 0 && test->lam != 0)
+		if (set_lam(test->lam) != 0)
+			return 1;
+
+	ptr = mmap((void *)test->addr, PAGE_SIZE, PROT_READ | PROT_WRITE,
+		   flags, -1, 0);
+	if (ptr == MAP_FAILED) {
+		if (test->addr == HIGH_ADDR)
+			if (!cpu_has_la57())
+				return 3; /* unsupport LA57 */
+		return 1;
+	}
+
+	if (test->later != 0 && test->lam != 0)
+		if (set_lam(test->lam) != 0)
+			ret = 1;
+
+	if (ret == 0) {
+		if (sigsetjmp(segv_env, 1) == 0) {
+			signal(SIGSEGV, segv_handler);
+			ret = handle_lam_test(ptr, test->lam);
+		} else {
+			ret = 2;
+		}
+	}
+
+	munmap(ptr, PAGE_SIZE);
+	return ret;
+}
+
+static int handle_syscall(struct testcases *test)
+{
+	struct utsname unme, *pu;
+	int ret = 0;
+
+	if (test->later == 0 && test->lam != 0)
+		if (set_lam(test->lam) != 0)
+			return 1;
+
+	if (sigsetjmp(segv_env, 1) == 0) {
+		signal(SIGSEGV, segv_handler);
+		pu = (struct utsname *)set_metadata((uint64_t)&unme, test->lam);
+		ret = uname(pu);
+		if (ret < 0)
+			ret = 1;
+	} else {
+		ret = 2;
+	}
+
+	if (test->later != 0 && test->lam != 0)
+		if (set_lam(test->lam) != -1 && ret == 0)
+			ret = 1;
+
+	return ret;
+}
+
 static int fork_test(struct testcases *test)
 {
 	int ret, child_ret;
@@ -268,7 +349,6 @@ static struct testcases malloc_cases[] = {
 	},
 };
 
-
 static struct testcases bits_cases[] = {
 	{
 		.test_func = handle_max_bits,
@@ -276,11 +356,54 @@ static struct testcases bits_cases[] = {
 	},
 };
 
+static struct testcases syscall_cases[] = {
+	{
+		.later = 0,
+		.lam = LAM_U57_BITS,
+		.test_func = handle_syscall,
+		.msg = "SYSCALL: LAM_U57. syscall with metadata\n",
+	},
+	{
+		.later = 1,
+		.expected = 1,
+		.lam = LAM_U57_BITS,
+		.test_func = handle_syscall,
+		.msg = "SYSCALL:[Negative] Disable LAM. Dereferencing pointer with metadata.\n",
+	},
+};
+
+static struct testcases mmap_cases[] = {
+	{
+		.later = 1,
+		.expected = 0,
+		.lam = LAM_U57_BITS,
+		.addr = HIGH_ADDR,
+		.test_func = handle_mmap,
+		.msg = "MMAP: First mmap high address, then set LAM_U57.\n",
+	},
+	{
+		.later = 0,
+		.expected = 0,
+		.lam = LAM_U57_BITS,
+		.addr = HIGH_ADDR,
+		.test_func = handle_mmap,
+		.msg = "MMAP: First LAM_U57, then High address.\n",
+	},
+	{
+		.later = 0,
+		.expected = 0,
+		.lam = LAM_U57_BITS,
+		.addr = LOW_ADDR,
+		.test_func = handle_mmap,
+		.msg = "MMAP: First LAM_U57, then Low address.\n",
+	},
+};
+
 static void cmd_help(void)
 {
 	printf("usage: lam [-h] [-t test list]\n");
 	printf("\t-t test list: run tests specified in the test list, default:0x%x\n", TEST_MASK);
-	printf("\t\t0x1:malloc; 0x2:max_bits;\n");
+	printf("\t\t0x1:malloc; 0x2:max_bits; 0x4:mmap; 0x8:syscall.\n");
 	printf("\t-h: help\n");
 }
 
@@ -320,6 +443,12 @@ int main(int argc, char **argv)
 	if (tests & FUNC_BITS)
 		run_test(bits_cases, ARRAY_SIZE(bits_cases));
 
+	if (tests & FUNC_MMAP)
+		run_test(mmap_cases, ARRAY_SIZE(mmap_cases));
+
+	if (tests & FUNC_SYSCALL)
+		run_test(syscall_cases, ARRAY_SIZE(syscall_cases));
+
 	ksft_set_plan(tests_cnt);
 
 	return ksft_exit_pass();
-- 
2.35.1

