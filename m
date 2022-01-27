Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B9149E964
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245023AbiA0Rzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:55:51 -0500
Received: from mga02.intel.com ([134.134.136.20]:19415 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244602AbiA0RzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306116; x=1674842116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uQtrsvC9NzylIZ7djxR+FBTAoptzaOW13uIB28zSQiQ=;
  b=kfrCOt4/Aw+Eda/6n+Af8AR7QBedxzgXe8BhIWe8Q6UbjM8gtTcF6qGm
   VDPwieLTNPoipmXB8CkNfwwJIeVWOhbTJLsxgHdrZF6HddfPSSmkaviER
   szKhms885M85HCgp6olviPdOJUXUB2LEDp8p4rtGzgkIXsF7FGb25B7o0
   GoDlU4m4HThCD1N1IkDYzuRh2xsb0REVXMqmSL3x86lEhhLIhU6EWOcrJ
   Mng+iJkRT0brl2978cuX0xS4gMp2NRZ+Fw9qrOZItfx3eZj9A0bK3cJrE
   hqyLgHWVRjuBtpdPg8lDqVCMChkjTPqd5zDZcpQOZZrYn2gOu1Ces7EF1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="234302431"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="234302431"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796117"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:10 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 20/44] mm/pkeys: Add PKS test for context switching
Date:   Thu, 27 Jan 2022 09:54:41 -0800
Message-Id: <20220127175505.851391-21-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

PKS software must maintain the PKRS value for each thread in the system.
It must then restore this value whenever a thread is scheduled in.

Create a user space test to test this.  The test runs 2 processes
simultaneously on the same CPU.  One sets up a known PKS value for the
test pkey and sleeps while the other runs through all the protections
using the same pkey.  The first process is then allowed to run and it
checks that its PKRS value was properly restored.

On the kernel side 2 additional commands are added.  One is a mechanism
to arm a context and the other checks that context.  The kernel
maintains this context while the char device remains open.  The context
is cleaned up with the fd is closed.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V8
	Split this off from the main testing patch
	Remove unneeded prints
---
 lib/pks/pks_test.c                     |  74 +++++++++++
 tools/testing/selftests/x86/Makefile   |   2 +-
 tools/testing/selftests/x86/test_pks.c | 168 +++++++++++++++++++++++++
 3 files changed, 243 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/test_pks.c

diff --git a/lib/pks/pks_test.c b/lib/pks/pks_test.c
index fad9b996562a..933f1bed4820 100644
--- a/lib/pks/pks_test.c
+++ b/lib/pks/pks_test.c
@@ -15,6 +15,8 @@
  *
  * * 0  Loop through all CPUs, report the msr, and check against the default.
  * * 1  Allocate a single key and check all 3 permissions on a page.
+ * * 2  'arm context' for context switch test
+ * * 3  Check the context armed in '2' to ensure the MSR value was preserved
  * * 8  Loop through all CPUs, report the msr, and check against the default.
  * * 9  Set up and fault on a PKS protected page.
  *
@@ -24,6 +26,11 @@
  * $ cat /sys/kernel/debug/x86/run_pks
  *
  * Will print the result of the last test.
+ *
+ * To automate context switch testing a user space program is provided in:
+ *
+ *	.../tools/testing/selftests/x86/test_pks.c
+ *
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -33,6 +40,9 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/pkeys.h>
+#include <uapi/asm-generic/mman-common.h>
+
+#include <asm/pks.h>
 
 #include <asm/pks.h>
 
@@ -40,6 +50,8 @@
 
 #define CHECK_DEFAULTS		0
 #define RUN_SINGLE		1
+#define ARM_CTX_SWITCH		2
+#define CHECK_CTX_SWITCH	3
 #define RUN_CRASH_TEST		9
 
 static struct dentry *pks_test_dentry;
@@ -309,6 +321,55 @@ static void arm_or_run_crash_test(void)
 	crash_armed = false;
 }
 
+static void arm_ctx_switch(struct file *file)
+{
+	struct pks_test_ctx *ctx;
+
+	ctx = alloc_ctx(PKS_KEY_TEST);
+	if (IS_ERR(ctx)) {
+		pr_err("Failed to allocate a context\n");
+		last_test_pass = false;
+		return;
+	}
+
+	/* Store context for later checks */
+	if (file->private_data) {
+		pr_warn("Context already armed\n");
+		free_ctx(file->private_data);
+	}
+	file->private_data = ctx;
+
+	/* Ensure a known state to test context switch */
+	pks_mk_readwrite(ctx->pkey);
+}
+
+static void check_ctx_switch(struct file *file)
+{
+	struct pks_test_ctx *ctx;
+	unsigned long reg_pkrs;
+	int access;
+
+	last_test_pass = true;
+
+	if (!file->private_data) {
+		pr_err("No Context switch configured\n");
+		last_test_pass = false;
+		return;
+	}
+
+	ctx = file->private_data;
+
+	rdmsrl(MSR_IA32_PKRS, reg_pkrs);
+
+	access = (reg_pkrs >> PKR_PKEY_SHIFT(ctx->pkey)) &
+		  PKEY_ACCESS_MASK;
+	if (access != 0) {
+		last_test_pass = false;
+		pr_err("Context switch check failed: pkey %d: 0x%x reg: 0x%lx\n",
+			ctx->pkey, access, reg_pkrs);
+	}
+}
+
 static ssize_t pks_read_file(struct file *file, char __user *user_buf,
 			     size_t count, loff_t *ppos)
 {
@@ -351,6 +412,14 @@ static ssize_t pks_write_file(struct file *file, const char __user *user_buf,
 	case RUN_SINGLE:
 		last_test_pass = run_single();
 		break;
+	case ARM_CTX_SWITCH:
+		/* start of context switch test */
+		arm_ctx_switch(file);
+		break;
+	case CHECK_CTX_SWITCH:
+		/* After context switch MSR should be restored */
+		check_ctx_switch(file);
+		break;
 	default:
 		last_test_pass = false;
 		break;
@@ -365,6 +434,11 @@ static ssize_t pks_write_file(struct file *file, const char __user *user_buf,
 
 static int pks_release_file(struct inode *inode, struct file *file)
 {
+	struct pks_test_ctx *ctx = file->private_data;
+
+	if (ctx)
+		free_ctx(ctx);
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 8a1f62ab3c8e..e08670596c14 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -13,7 +13,7 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
 			test_vsyscall mov_ss_trap \
-			syscall_arg_fault fsgsbase_restore sigaltstack
+			syscall_arg_fault fsgsbase_restore sigaltstack test_pks
 TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
diff --git a/tools/testing/selftests/x86/test_pks.c b/tools/testing/selftests/x86/test_pks.c
new file mode 100644
index 000000000000..9a24a4a61f28
--- /dev/null
+++ b/tools/testing/selftests/x86/test_pks.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright(c) 2021 Intel Corporation. All rights reserved.
+ *
+ * User space tool to test PKS operations.  Accesses test code through
+ * <debugfs>/x86/run_pks when CONFIG_PKS_TEST is enabled.
+ */
+
+#define _GNU_SOURCE
+#include <sched.h>
+#include <stdlib.h>
+#include <getopt.h>
+#include <unistd.h>
+#include <assert.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <string.h>
+#include <stdbool.h>
+
+#define PKS_TEST_FILE "/sys/kernel/debug/x86/run_pks"
+
+#define RUN_SINGLE		"1"
+#define ARM_CTX_SWITCH		"2"
+#define CHECK_CTX_SWITCH	"3"
+
+void print_help_and_exit(char *argv0)
+{
+	printf("Usage: %s [-h] <cpu>\n", argv0);
+	printf("	--help,-h  This help\n");
+	printf("\n");
+	printf("	Run a context switch test on <cpu> (Default: 0)\n");
+}
+
+int check_context_switch(int cpu)
+{
+	int switch_done[2];
+	int setup_done[2];
+	cpu_set_t cpuset;
+	char result[32];
+	int rc = 0;
+	pid_t pid;
+	int fd;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(cpu, &cpuset);
+	/*
+	 * Ensure the two processes run on the same CPU so that they go through
+	 * a context switch.
+	 */
+	sched_setaffinity(getpid(), sizeof(cpu_set_t), &cpuset);
+
+	if (pipe(setup_done)) {
+		printf("ERROR: Failed to create pipe\n");
+		return -1;
+	}
+	if (pipe(switch_done)) {
+		printf("ERROR: Failed to create pipe\n");
+		return -1;
+	}
+
+	pid = fork();
+	if (pid == 0) {
+		char done = 'y';
+
+		fd = open(PKS_TEST_FILE, O_RDWR);
+		if (fd < 0) {
+			printf("ERROR: cannot open %s\n", PKS_TEST_FILE);
+			return -1;
+		}
+
+		cpu = sched_getcpu();
+		printf("Child running on cpu %d...\n", cpu);
+
+		/* Allocate and run test. */
+		write(fd, RUN_SINGLE, 1);
+
+		/* Arm for context switch test */
+		write(fd, ARM_CTX_SWITCH, 1);
+
+		printf("   tell parent to go\n");
+		write(setup_done[1], &done, sizeof(done));
+
+		/* Context switch out... */
+		printf("   Waiting for parent...\n");
+		read(switch_done[0], &done, sizeof(done));
+
+		/* Check msr restored */
+		printf("Checking result\n");
+		write(fd, CHECK_CTX_SWITCH, 1);
+
+		read(fd, result, 10);
+		printf("   #PF, context switch, pkey allocation and free tests: %s\n", result);
+		if (!strncmp(result, "PASS", 10)) {
+			rc = -1;
+			done = 'F';
+		}
+
+		/* Signal result */
+		write(setup_done[1], &done, sizeof(done));
+	} else {
+		char done = 'y';
+
+		read(setup_done[0], &done, sizeof(done));
+		cpu = sched_getcpu();
+		printf("Parent running on cpu %d\n", cpu);
+
+		fd = open(PKS_TEST_FILE, O_RDWR);
+		if (fd < 0) {
+			printf("ERROR: cannot open %s\n", PKS_TEST_FILE);
+			return -1;
+		}
+
+		/* run test with the same pkey */
+		write(fd, RUN_SINGLE, 1);
+
+		printf("   Signaling child.\n");
+		write(switch_done[1], &done, sizeof(done));
+
+		/* Wait for result */
+		read(setup_done[0], &done, sizeof(done));
+		if (done == 'F')
+			rc = -1;
+	}
+
+	close(fd);
+
+	return rc;
+}
+
+int main(int argc, char *argv[])
+{
+	int cpu = 0;
+	int rc;
+	int c;
+
+	while (1) {
+		int option_index = 0;
+		static struct option long_options[] = {
+			{"help",	no_argument,	0,	'h' },
+			{0,		0,		0,	0 }
+		};
+
+		c = getopt_long(argc, argv, "h", long_options, &option_index);
+		if (c == -1)
+			break;
+
+		switch (c) {
+		case 'h':
+			print_help_and_exit(argv[0]);
+			break;
+		}
+	}
+
+	if (optind < argc)
+		cpu = strtoul(argv[optind], NULL, 0);
+
+	if (cpu >= sysconf(_SC_NPROCESSORS_ONLN)) {
+		printf("CPU %d is invalid\n", cpu);
+		cpu = sysconf(_SC_NPROCESSORS_ONLN) - 1;
+		printf("   running on max CPU: %d\n", cpu);
+	}
+
+	rc = check_context_switch(cpu);
+
+	return rc;
+}
-- 
2.31.1

