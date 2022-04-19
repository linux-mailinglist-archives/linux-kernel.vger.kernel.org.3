Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20272507640
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355970AbiDSRLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355694AbiDSRKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:10:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6E612AF1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388047; x=1681924047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aCc6vZZks5fhxGxuEXFNNrEdo/tMegPVC4Stf9I/c9g=;
  b=J+pdC6c/2KsaO5ZoHsRDlELw0wyTKbwCvS1DgzCV3u6cuTwznko9rlDT
   ugh7g6Dn6GLJ9c/wZrvMnuiLDC1I2bQGIwCQbN2mPCLOce41UdL+sZI05
   hJNEIRTWOHQxOrRSCZy3PY29xCmWxUQX4sVU6zrixeh6gBHbFXfKJzl9p
   /F1oTtwspX1UjYkdjXDTtN25Ld3D5ORJLEo28QX2zJLlbd6gQqsN4iLJ2
   KKmXXY5t8DlHyKmImmuua41ut3VFbta6DQFDblC2nP7o5KzH5WTkg6ro4
   dxi/vyle1f3uqsRpL+sh+1QBR2HLwyxcZ1lC7NYJbum17aUKYs7+KiYDq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="326720652"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="326720652"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:25 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="530499070"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:25 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 41/44] mm/pkeys: PKS testing, test context switching
Date:   Tue, 19 Apr 2022 10:06:46 -0700
Message-Id: <20220419170649.1022246-42-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

PKS software must maintain the PKRS value during a context switch.  Test
this by running two processes simultaneously on the same CPU while using
different permissions for the same pkey.

Leverage test_pks to create two threads scheduled on the same cpu.

On the kernel side create two commands.  One to set up the pkey prior to
the context switch (arm context switch) and a second to check the pkey
after the context switch (check context switch).

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V10
	Fix CPU command line option

Changes for V9
	From Rick Edgecombe
		Ensure the parent/child threads don't cause each other
			to hang if one experiences a failure
	Adjust for the new test_pks user space component
	Adjust the debug output for '-d' option
	s/pks_mk_*/pks_set_*/
	Use new set_file_data() call

Changes for V8
	Split this off from the main testing patch
	Remove unneeded prints
---
 lib/pks/pks_test.c                     |  54 +++++++++
 tools/testing/selftests/x86/test_pks.c | 159 ++++++++++++++++++++++++-
 2 files changed, 208 insertions(+), 5 deletions(-)

diff --git a/lib/pks/pks_test.c b/lib/pks/pks_test.c
index dc309dd941be..86af2f61393d 100644
--- a/lib/pks/pks_test.c
+++ b/lib/pks/pks_test.c
@@ -38,12 +38,16 @@
 #include <linux/pks.h>
 #include <linux/pks-keys.h>
 
+#include <uapi/asm-generic/mman-common.h>
+
 #include <asm/ptrace.h>
 
 #define PKS_TEST_MEM_SIZE (PAGE_SIZE)
 
 #define CHECK_DEFAULTS		0
 #define RUN_SINGLE		1
+#define ARM_CTX_SWITCH		2
+#define CHECK_CTX_SWITCH	3
 #define RUN_CRASH_TEST		9
 
 static struct dentry *pks_test_dentry;
@@ -343,6 +347,48 @@ static void arm_or_run_crash_test(struct pks_session_data *sd)
 	crash_it(sd);
 }
 
+static void arm_ctx_switch(struct pks_session_data *sd)
+{
+	struct pks_test_ctx *ctx;
+
+	ctx = alloc_ctx(PKS_KEY_TEST);
+	if (IS_ERR(ctx)) {
+		pr_err("Failed to allocate a context\n");
+		sd->last_test_pass = false;
+		return;
+	}
+
+	set_ctx_data(sd, ctx);
+
+	/* Ensure a known state to test context switch */
+	pks_set_readwrite(ctx->pkey);
+}
+
+static void check_ctx_switch(struct pks_session_data *sd)
+{
+	struct pks_test_ctx *ctx = sd->ctx;
+	unsigned long reg_pkrs;
+	int access;
+
+	sd->last_test_pass = true;
+
+	if (!ctx) {
+		pr_err("No Context switch configured\n");
+		sd->last_test_pass = false;
+		return;
+	}
+
+	rdmsrl(MSR_IA32_PKRS, reg_pkrs);
+
+	access = (reg_pkrs >> PKR_PKEY_SHIFT(ctx->pkey)) &
+		  PKEY_ACCESS_MASK;
+	if (access != 0) {
+		pr_err("Context switch check failed: pkey %u: 0x%x reg: 0x%lx\n",
+			ctx->pkey, access, reg_pkrs);
+		sd->last_test_pass = false;
+	}
+}
+
 static ssize_t pks_read_file(struct file *file, char __user *user_buf,
 			     size_t count, loff_t *ppos)
 {
@@ -397,6 +443,14 @@ static ssize_t pks_write_file(struct file *file, const char __user *user_buf,
 		pr_debug("Single key\n");
 		sd->last_test_pass = run_single(file->private_data);
 		break;
+	case ARM_CTX_SWITCH:
+		pr_debug("Arming Context switch test\n");
+		arm_ctx_switch(file->private_data);
+		break;
+	case CHECK_CTX_SWITCH:
+		pr_debug("Checking Context switch test\n");
+		check_ctx_switch(file->private_data);
+		break;
 	default:
 		pr_debug("Unknown test\n");
 		sd->last_test_pass = false;
diff --git a/tools/testing/selftests/x86/test_pks.c b/tools/testing/selftests/x86/test_pks.c
index 2c10b6c50416..626421fa8ed8 100644
--- a/tools/testing/selftests/x86/test_pks.c
+++ b/tools/testing/selftests/x86/test_pks.c
@@ -17,6 +17,7 @@
  *	...
  */
 #define _GNU_SOURCE
+#include <sched.h>
 #include <unistd.h>
 #include <getopt.h>
 #include <stdio.h>
@@ -32,10 +33,13 @@
 /* Values from the kernel */
 #define CHECK_DEFAULTS		"0"
 #define RUN_SINGLE		"1"
+#define ARM_CTX_SWITCH		"2"
+#define CHECK_CTX_SWITCH	"3"
 #define RUN_CRASH_TEST		"9"
 
 time_t g_start_time;
 int g_debug;
+unsigned long g_cpu;
 
 #define PRINT_DEBUG(fmt, ...) \
 	do { \
@@ -47,6 +51,7 @@ int g_debug;
 	fprintf(stderr, "%s: " fmt, __func__, ##__VA_ARGS__)
 
 static int do_simple_test(const char *debugfs_str);
+static int do_context_switch(const char *debugfs_str);
 
 /*
  * The crash test is a special case which is not included in the run all
@@ -55,6 +60,7 @@ static int do_simple_test(const char *debugfs_str);
 enum {
 	TEST_DEFAULTS = 0,
 	TEST_SINGLE,
+	TEST_CTX_SWITCH,
 	MAX_TESTS,
 } tests;
 
@@ -67,7 +73,8 @@ struct test_item {
 	int (*test_fn)(const char *debugfs_str);
 } test_list[] = {
 	{ "check_defaults", CHECK_DEFAULTS, do_simple_test },
-	{ "single", RUN_SINGLE, do_simple_test }
+	{ "single", RUN_SINGLE, do_simple_test },
+	{ "context_switch", ARM_CTX_SWITCH, do_context_switch }
 };
 
 static char *get_test_name(int test_num)
@@ -101,6 +108,7 @@ static void print_help_and_exit(char *argv0)
 	printf("Usage: %s [-h,-d] [test]\n", argv0);
 	printf("	--help,-h   This help\n");
 	printf("	--debug,-d  Output kernel debug via dynamic debug if available\n");
+	printf("	--cpu,-c <cpu>  Use 'cpu' for context switch default 0\n");
 	printf("\n");
 	printf("        Run all PKS tests or the [test] specified.\n");
 	printf("\n");
@@ -116,6 +124,143 @@ static void print_help_and_exit(char *argv0)
 	printf("\n");
 }
 
+/*
+ * debugfs_str is ignored for this test.
+ */
+static int do_context_switch(const char *debugfs_str)
+{
+	int switch_done[2];
+	int setup_done[2];
+	cpu_set_t cpuset;
+	char result[32];
+	char done = 'P';
+	int rc = 0;
+	pid_t pid;
+	int fd;
+
+	if (g_cpu >= sysconf(_SC_NPROCESSORS_ONLN)) {
+		PRINT_ERROR("CPU %lu is invalid\n", g_cpu);
+		g_cpu = sysconf(_SC_NPROCESSORS_ONLN) - 1;
+		PRINT_ERROR("   running on max CPU: %lu\n", g_cpu);
+	}
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(g_cpu, &cpuset);
+	/*
+	 * Ensure the two processes run on the same CPU so that they go through
+	 * a context switch.
+	 */
+	sched_setaffinity(getpid(), sizeof(cpu_set_t), &cpuset);
+
+	if (pipe(setup_done)) {
+		PRINT_ERROR("ERROR: Failed to create pipe\n");
+		return -EIO;
+	}
+	if (pipe(switch_done)) {
+		PRINT_ERROR("ERROR: Failed to create pipe\n");
+		return -EIO;
+	}
+
+	fd = open(PKS_TEST_FILE, O_RDWR);
+	if (fd < 0) {
+		PRINT_DEBUG("Failed to open test file : %s\n", PKS_TEST_FILE);
+		return -ENOENT;
+	}
+
+	/* Avoid duplicated output after fork */
+	fflush(stderr);
+	fflush(stdout);
+
+	pid = fork();
+	if (pid == 0) {
+		char done = 'P';
+
+		g_cpu = sched_getcpu();
+		PRINT_DEBUG("Child: running on cpu %lu...\n", g_cpu);
+
+		/* Allocate and run test. */
+		write(fd, RUN_SINGLE, 1);
+
+		/* Arm for context switch test */
+		write(fd, ARM_CTX_SWITCH, 1);
+
+		PRINT_DEBUG("Child: Tell parent to go\n");
+		write(setup_done[1], &done, sizeof(done));
+
+		/* Context switch out... */
+		PRINT_DEBUG("Child: Waiting for parent...\n");
+		read(switch_done[0], &done, sizeof(done));
+
+		/* Check msr restored */
+		PRINT_DEBUG("Child: Checking result\n");
+		rc = write(fd, CHECK_CTX_SWITCH, 1);
+		if (rc < 0) {
+			if (errno == ENOENT) {
+				sprintf(result, "SKIP");
+				done = 'S';
+			} else {
+				sprintf(result, "FAIL");
+				done = 'F';
+			}
+			goto child_exit;
+		}
+
+		read(fd, result, 10);
+		if (strncmp(result, "PASS", 4))
+			done = 'F';
+
+child_exit:
+		PRINT_DEBUG("Child: Result (%c) %s\n", done, result);
+
+		/* Signal result */
+		write(setup_done[1], &done, sizeof(done));
+		close(fd);
+
+		exit(0);
+	}
+
+	PRINT_DEBUG("Parent: Waiting for child\n");
+	read(setup_done[0], &done, sizeof(done));
+	g_cpu = sched_getcpu();
+	PRINT_DEBUG("Parent: running on cpu %lu\n", g_cpu);
+
+	/* The parent needs a unique file context within the kernel */
+	close(fd);
+	fd = open(PKS_TEST_FILE, O_RDWR);
+	if (fd < 0) {
+		PRINT_ERROR("FATAL ERROR: cannot open %s\n", PKS_TEST_FILE);
+		PRINT_DEBUG("Parent: Signaling child 'fail'\n");
+		done = 'F';
+		write(switch_done[1], &done, sizeof(done));
+		return -ENOENT;
+	}
+
+	/* run test with the same pkey */
+	rc = write(fd, RUN_SINGLE, 1);
+
+	PRINT_DEBUG("Parent: Signaling child\n");
+	write(switch_done[1], &done, sizeof(done));
+
+	if (rc < 0) {
+		rc = -errno;
+		goto close_file;
+	}
+	rc = 0;
+
+	/* Wait for result */
+	read(setup_done[0], &done, sizeof(done));
+	if (done == 'S')
+		rc = -ENOENT;
+	if (done == 'F')
+		rc = -EFAULT;
+
+	PRINT_DEBUG("Parent: exiting with rc (%c) %d\n", done, rc);
+
+close_file:
+	close(fd);
+	return rc;
+}
+
 /*
  * Do a simple test of writing the debugfs value and reading back for 'PASS'
  */
@@ -307,14 +452,15 @@ int main(int argc, char *argv[])
 
 	while (1) {
 		static struct option long_options[] = {
-			{"help",	no_argument,	0,	'h' },
-			{"debug",	no_argument,	0,	'd' },
-			{0,		0,		0,	0 }
+			{"help",	no_argument,		0,	'h' },
+			{"debug",	no_argument,		0,	'd' },
+			{"cpu",		required_argument,	0,	'c' },
+			{0,		0,			0,	0 }
 		};
 		int option_index = 0;
 		int c;
 
-		c = getopt_long(argc, argv, "hd", long_options, &option_index);
+		c = getopt_long(argc, argv, "hdc:", long_options, &option_index);
 		if (c == -1)
 			break;
 
@@ -325,6 +471,9 @@ int main(int argc, char *argv[])
 		case 'd':
 			g_debug++;
 			break;
+		case 'c':
+			g_cpu = strtoul(optarg, NULL, 0);
+			break;
 		default:
 			print_help_and_exit(argv[0]);
 			exit(-1);
-- 
2.35.1

