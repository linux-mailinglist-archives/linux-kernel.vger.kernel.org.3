Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639BC59288A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240954AbiHOEPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240434AbiHOEPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:15:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABE31402F
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 21:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660536912; x=1692072912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pFEmrndyS4U/nV5J9Y9zEWLJbyzb9Y8r4SpnzcrYa1c=;
  b=kVOPo4z/TMt+gf3Ia4AJQPYwSFz9UHdxLks3tbbYVMRymLs+oo4F+W7H
   Lr6KUee/V6KLiHoRX3aO1LrwlfyN3A4BH4n0fDGZd7lcak8TCB/jwExD9
   2FtRFa8wgWEaDD1dHmg9e7PgpqW2pAg2NkjCzWXw7UlFDssQTAOeQehiB
   jdwVXGa3Frb7zEuLHmNVziKJ/jvuNUz9kGZ9pEvqf/DLhoSZs6dyHY6lr
   489/JMV5JAHnmsAORjmZBiO2yCfD3T/6l2/8zrDK//sAbNYKvu5Etkj1w
   d3QuInF6/6FT4BPG94XSJ/L5yB43gPy3gIUbs+Hsa723T5C9A2IQyfLdP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="317867216"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="317867216"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 21:15:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="732818295"
Received: from dmalka-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.42.26])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 21:15:07 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 866D2104A6E; Mon, 15 Aug 2022 07:18:04 +0300 (+03)
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
Subject: [PATCHv6 09/11] selftests/x86/lam: Add mmap and SYSCALL test cases for linear-address masking
Date:   Mon, 15 Aug 2022 07:18:01 +0300
Message-Id: <20220815041803.17954-10-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815041803.17954-1-kirill.shutemov@linux.intel.com>
References: <20220815041803.17954-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
---
 tools/testing/selftests/x86/lam.c | 135 +++++++++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 4c6c6dbf7db6..e9e92ab7fea8 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -7,6 +7,7 @@
 #include <signal.h>
 #include <setjmp.h>
 #include <sys/mman.h>
+#include <sys/utsname.h>
 #include <sys/wait.h>
 #include <inttypes.h>
 
@@ -27,11 +28,18 @@
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
@@ -47,6 +55,7 @@ jmp_buf segv_env;
 static void segv_handler(int sig)
 {
 	ksft_print_msg("Get segmentation fault(%d).", sig);
+
 	siglongjmp(segv_env, 1);
 }
 
@@ -59,6 +68,16 @@ static inline int cpu_has_lam(void)
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
@@ -204,6 +223,68 @@ static int handle_malloc(struct testcases *test)
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
+		pu = (struct utsname *)get_metadata((uint64_t)&unme, test->lam);
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
@@ -259,7 +340,6 @@ static struct testcases malloc_cases[] = {
 	},
 };
 
-
 static struct testcases bits_cases[] = {
 	{
 		.test_func = handle_max_bits,
@@ -267,11 +347,54 @@ static struct testcases bits_cases[] = {
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
+		.msg = "SYSCALL:[Negtive] Disable LAM. Dereferencing pointer with metadata.\n",
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
 
@@ -311,6 +434,12 @@ int main(int argc, char **argv)
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

