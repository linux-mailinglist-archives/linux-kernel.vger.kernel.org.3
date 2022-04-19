Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEE650762A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356008AbiDSRMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355661AbiDSRKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:10:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399937663
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388044; x=1681924044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LCHZGnGKt9Sx5ZOeUlrpSXA3eXrL5puBLzySFcE/4X8=;
  b=dJSGmT5XgzZuwBxSXfEGbN/Cx5H3QW4HwBqm0q+DY/mHoLoMGAhw8Fea
   M8YgSlyooNq6qw2KjnfRmC9ixITVKnBBsFItKaZ8o++k3SXBYK4hLkUij
   rKM5bTZkCFlqXsqlYquIp2rnP8mBJebuIS/kZBqthJEkUr6d1i8Z/DShn
   7smyVeAR/9/i78RBlbzu9uJCsyW1M87ZXdyBfsjdi9j4/qdUZohK6IVfW
   DAJVbQvCCsF+BgITc3mRCyHigMzk5ti7dNVa2uAIijYGSe7GiVtmZRpUb
   HmhO5XtxNVoQey4Mwd1xPmfShz8X3Ops0QpxY4WvQpSLg3itCvLO6e9YM
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="261420897"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="261420897"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="554813711"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:22 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 38/44] x86/selftests: Add test_pks
Date:   Tue, 19 Apr 2022 10:06:43 -0700
Message-Id: <20220419170649.1022246-39-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The PKS kernel tests are clumsy to run using debugfs directly.  It is
much nicer to have a user space application trigger the execution of
those tests.

Create test_pks as a selftest.

Output is as follows.

$ ./test_pks_64 -h
Usage: ./test_pks_64 [-h,-d] [test]
	--help,-h   This help
	--debug,-d  Output kernel debug via dynamic debug if available

        Run all PKS tests or the [test] specified.

	[test] can be one of:
	       'check_defaults'
	       'create_fault' (Not included in run all)

$ ./test_pks_64
[RUN]	check_defaults
[OK]

Suggested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9:
	New Patch
---
 Documentation/core-api/protection-keys.rst |   3 +
 tools/testing/selftests/x86/Makefile       |   2 +-
 tools/testing/selftests/x86/test_pks.c     | 353 +++++++++++++++++++++
 3 files changed, 357 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/test_pks.c

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index 361c6b7e1b93..d492ec194e2a 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -175,3 +175,6 @@ Testing
 
 .. kernel-doc:: lib/pks/pks_test.c
         :doc: PKS_TEST
+
+.. kernel-doc:: tools/testing/selftests/x86/test_pks.c
+        :doc: PKS_TEST_USER
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 0388c4d60af0..f24252d2cbfb 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -13,7 +13,7 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh "$(CC)" trivial_program.c -no-pie)
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
index 000000000000..df5bde9bfdbe
--- /dev/null
+++ b/tools/testing/selftests/x86/test_pks.c
@@ -0,0 +1,353 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright(c) 2022 Intel Corporation. All rights reserved.
+ */
+
+/**
+ * DOC: PKS_TEST_USER
+ *
+ * To assist in executing the tests 'test_pks' can be built from the
+ * tools/testing directory.  See the help output for details.
+ *
+ * .. code-block:: sh
+ *
+ *	$ cd tools/testing/selftests/x86
+ *	$ make test_pks
+ *	$ ./test_pks_64 -h
+ *	...
+ */
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <getopt.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <string.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <time.h>
+
+#define DYN_DBG_CNT_FILE "/sys/kernel/debug/dynamic_debug/control"
+#define PKS_TEST_FILE "/sys/kernel/debug/x86/run_pks"
+
+/* Values from the kernel */
+#define CHECK_DEFAULTS		"0"
+#define RUN_CRASH_TEST		"9"
+
+time_t g_start_time;
+int g_debug;
+
+#define PRINT_DEBUG(fmt, ...) \
+	do { \
+		if (g_debug) \
+			printf("%s: " fmt, __func__, ##__VA_ARGS__); \
+	} while (0)
+
+#define PRINT_ERROR(fmt, ...) \
+	fprintf(stderr, "%s: " fmt, __func__, ##__VA_ARGS__)
+
+static int do_simple_test(const char *debugfs_str);
+
+/*
+ * The crash test is a special case which is not included in the run all
+ * option.  Do not add it here.
+ */
+enum {
+	TEST_DEFAULTS = 0,
+	MAX_TESTS,
+} tests;
+
+/* Special */
+#define CREATE_FAULT_TEST_NAME "create_fault"
+
+struct test_item {
+	char *name;
+	const char *debugfs_str;
+	int (*test_fn)(const char *debugfs_str);
+} test_list[] = {
+	{ "check_defaults", CHECK_DEFAULTS, do_simple_test }
+};
+
+static char *get_test_name(int test_num)
+{
+	if (test_num > MAX_TESTS)
+		return "<UNKNOWN>";
+	/* Special: not in run all */
+	if (test_num == MAX_TESTS)
+		return CREATE_FAULT_TEST_NAME;
+	return test_list[test_num].name;
+}
+
+static int get_test_num(char *test_name)
+{
+	int i;
+
+	/* Special: not in run all */
+	if (strcmp(test_name, CREATE_FAULT_TEST_NAME) == 0)
+		return MAX_TESTS;
+
+	for (i = 0; i < MAX_TESTS; i++)
+		if (strcmp(test_name, test_list[i].name) == 0)
+			return i;
+	return -1;
+}
+
+static void print_help_and_exit(char *argv0)
+{
+	int i;
+
+	printf("Usage: %s [-h,-d] [test]\n", argv0);
+	printf("	--help,-h   This help\n");
+	printf("	--debug,-d  Output kernel debug via dynamic debug if available\n");
+	printf("\n");
+	printf("        Run all PKS tests or the [test] specified.\n");
+	printf("\n");
+	printf("	[test] can be one of:\n");
+
+	for (i = 0; i < MAX_TESTS; i++)
+		printf("	       '%s'\n", get_test_name(i));
+
+	/* Special: not in run all */
+	printf("	       '%s' (Not included in run all)\n",
+		CREATE_FAULT_TEST_NAME);
+
+	printf("\n");
+}
+
+/*
+ * Do a simple test of writing the debugfs value and reading back for 'PASS'
+ */
+static int do_simple_test(const char *debugfs_str)
+{
+	char str[16];
+	int fd, rc = 0;
+
+	fd = open(PKS_TEST_FILE, O_RDWR);
+	if (fd < 0) {
+		PRINT_DEBUG("Failed to open test file : %s\n", PKS_TEST_FILE);
+		return -ENOENT;
+	}
+
+	rc = write(fd, debugfs_str, strlen(debugfs_str));
+	if (rc < 0) {
+		rc = -errno;
+		goto close_file;
+	}
+
+	rc = read(fd, str, 16);
+	if (rc < 0)
+		goto close_file;
+
+	str[15] = '\0';
+
+	if (strncmp(str, "PASS", 4)) {
+		PRINT_ERROR("result: %s\n", str);
+		rc = -EFAULT;
+		goto close_file;
+	}
+
+	rc = 0;
+
+close_file:
+	close(fd);
+	return rc;
+}
+
+/*
+ * This test is special in that it requires the option to be written 2 times.
+ * In addition because it creates a fault it is not included in the run all
+ * test suite.
+ */
+static int create_fault(void)
+{
+	char str[16];
+	int fd, rc = 0;
+
+	fd = open(PKS_TEST_FILE, O_RDWR);
+	if (fd < 0) {
+		PRINT_DEBUG("Failed to open test file : %s\n", PKS_TEST_FILE);
+		return -ENOENT;
+	}
+
+	rc = write(fd, "9", 1);
+	if (rc < 0) {
+		rc = -errno;
+		goto close_file;
+	}
+
+	rc = write(fd, "9", 1);
+	if (rc < 0)
+		goto close_file;
+
+	rc = read(fd, str, 16);
+	if (rc < 0)
+		goto close_file;
+
+	str[15] = '\0';
+
+	if (strncmp(str, "PASS", 4)) {
+		PRINT_ERROR("result: %s\n", str);
+		rc = -EFAULT;
+		goto close_file;
+	}
+
+	rc = 0;
+
+close_file:
+	close(fd);
+	return rc;
+}
+
+static int run_one(int test_num)
+{
+	int ret;
+
+	printf("[RUN]\t%s\n", get_test_name(test_num));
+
+	if (test_num == MAX_TESTS)
+		/* Special: not in run all */
+		ret = create_fault();
+	else
+		ret = test_list[test_num].test_fn(test_list[test_num].debugfs_str);
+
+	if (ret == -ENOENT) {
+		printf("[SKIP] Test not supported\n");
+		return 0;
+	} else if (ret) {
+		printf("[FAIL]\n");
+		return 1;
+	}
+
+	printf("[OK]\n");
+	return 0;
+}
+
+static int run_all(void)
+{
+	int i, rc = 0;
+
+	for (i = 0; i < MAX_TESTS; i++) {
+		int ret = run_one(i);
+
+		/* sticky fail */
+		if (ret)
+			rc = ret;
+	}
+
+	return rc;
+}
+
+#define STR_LEN 256
+
+/* Debug output in the kernel is through dynamic debug */
+static void setup_debug(void)
+{
+	char str[STR_LEN];
+	int fd, rc;
+
+	g_start_time = time(NULL);
+
+	fd = open(DYN_DBG_CNT_FILE, O_RDWR);
+	if (fd < 0) {
+		PRINT_ERROR("Dynamic debug not available: Failed to open: %s\n",
+			DYN_DBG_CNT_FILE);
+		return;
+	}
+
+	snprintf(str, STR_LEN, "file pks_test.c +pflm");
+
+	rc = write(fd, str, strlen(str));
+	if (rc != strlen(str))
+		PRINT_ERROR("ERROR: Failed to set up dynamic debug...\n");
+
+	close(fd);
+}
+
+static void print_debug(void)
+{
+	char str[STR_LEN];
+	struct tm *tm;
+	int fd, rc;
+
+	fd = open(DYN_DBG_CNT_FILE, O_RDWR);
+	if (fd < 0)
+		return;
+
+	snprintf(str, STR_LEN, "file pks_test.c -p");
+
+	rc = write(fd, str, strlen(str));
+	if (rc != strlen(str))
+		PRINT_ERROR("ERROR: Failed to turn off dynamic debug...\n");
+
+	close(fd);
+
+	/*
+	 * dmesg is not accurate with time stamps so back up the start time a
+	 * bit to ensure all the output from this run is dumped.
+	 */
+	g_start_time -= 5;
+	tm = localtime(&g_start_time);
+
+	snprintf(str, STR_LEN,
+		 "dmesg -H --since '%d-%d-%d %d:%d:%d' | grep pks_test",
+		 tm->tm_year + 1900, tm->tm_mon + 1, tm->tm_mday,
+		 tm->tm_hour, tm->tm_min, tm->tm_sec);
+	system(str);
+	printf("\tDebug output command (approximate start time):\n\t\t%s\n",
+		str);
+}
+
+int main(int argc, char *argv[])
+{
+	int flag_all = 1;
+	int test_num = 0;
+	int rc;
+
+	while (1) {
+		static struct option long_options[] = {
+			{"help",	no_argument,	0,	'h' },
+			{"debug",	no_argument,	0,	'd' },
+			{0,		0,		0,	0 }
+		};
+		int option_index = 0;
+		int c;
+
+		c = getopt_long(argc, argv, "hd", long_options, &option_index);
+		if (c == -1)
+			break;
+
+		switch (c) {
+		case 'h':
+			print_help_and_exit(argv[0]);
+			return 0;
+		case 'd':
+			g_debug++;
+			break;
+		default:
+			print_help_and_exit(argv[0]);
+			exit(-1);
+		}
+	}
+
+	if (optind < argc) {
+		test_num = get_test_num(argv[optind]);
+		if (test_num < 0) {
+			printf("[RUN]\t'%s'\n[SKIP]\tInvalid test\n", argv[optind]);
+			return 1;
+		}
+
+		flag_all = 0;
+	}
+
+	if (g_debug)
+		setup_debug();
+
+	if (flag_all)
+		rc = run_all();
+	else
+		rc = run_one(test_num);
+
+	if (g_debug)
+		print_debug();
+
+	return rc;
+}
-- 
2.35.1

