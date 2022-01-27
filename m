Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEFB49E958
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244765AbiA0RzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:55:17 -0500
Received: from mga02.intel.com ([134.134.136.20]:19415 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242936AbiA0RzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306110; x=1674842110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dB8erXX6YLCIrSk0eQ+TKYajzyzXOLeTrTFmLzkQS8I=;
  b=HLek6GcVTRAKKRQAZFGNHCiqaDLcIFopItpU86Eu+k4f24HfLVTCb/VS
   aALlaov4Y0sgb4fLpIYnOJju+4SR3Gls79V5Gl7XloKunXXHFmMFbp9CP
   O3lq1j+kELmLNmwLfXFqcHlbRjen2pvMR8e8bY7aMQeb+QKSfo8qgg6W3
   nwqLYnzzOIbk3u3fw6RweXEhiP+4FdctvHDaecfniZQRsRue/Hac+umvI
   AUJVh/YQcGJhxfMyesYO/BmL2p9c20dRUpcM9czmKjQhERXmVd3ZF5001
   3a5A2yWs2HGzFJFkJo+BLlk9I384FqxSrPNl+6ZOsXGPiULQy9C2OczUC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="234302423"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="234302423"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796088"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:09 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 13/44] mm/pkeys: Add initial PKS Test code
Date:   Thu, 27 Jan 2022 09:54:34 -0800
Message-Id: <20220127175505.851391-14-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The core PKS functionality provides an interface for kernel users to
reserve a key and set up a mapping with that key.

Define test code under CONFIG_PKS_TEST which allows the testing of the
enablement of PKS functionality, basic setting of a page with a pkey,
and ensures all defaults are set properly.

Assign a pkey to the test code.  While this test does waste a pkey value
this should not be a problem while there remains a very limited numbers
of potential pkey users.  If pkeys are exhausted in the future the test
can be made exclusive or shared with another user.

Operation is simple.  A test is requested by echo'ing the number of the
test into the debugfs file.  The result of the last test is reported by
reading the file.

	$ echo 0 > /sys/kernel/debug/x86/run_pks
	$ cat /sys/kernel/debug/x86/run_pks
	PASS

Two initial tests are created.  One to check that the default values
have been properly assigned and a second which purposely causes a fault.

Add documentation.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V8
	Ensure that unknown tests are flagged as failures.
	Split out the various tests into their own patches which test
		the functionality as the series goes.
	Move this basic test forward in the series

Changes for V7
	Add testing for pks_abandon_protections()
	Adjust pkrs_init_value
	Adjust for new defines
	Clean up comments
        Adjust test for static allocation of pkeys
        Use lookup_address() instead of follow_pte()
		follow_pte only works on IO and raw PFN mappings, use
		lookup_address() instead.  lookup_address() is
		constrained to architectures which support it.
---
 Documentation/core-api/protection-keys.rst |   8 +
 include/linux/pks-keys.h                   |   3 +-
 lib/Kconfig.debug                          |  12 ++
 lib/Makefile                               |   3 +
 lib/pks/Makefile                           |   3 +
 lib/pks/pks_test.c                         | 214 +++++++++++++++++++++
 6 files changed, 242 insertions(+), 1 deletion(-)
 create mode 100644 lib/pks/Makefile
 create mode 100644 lib/pks/pks_test.c

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index 794b7dedc544..234122e56a92 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -155,3 +155,11 @@ text:
 	affected by PKRU register will not execute (even transiently)
 	until all prior executions of WRPKRU have completed execution
 	and updated the PKRU register.
+
+Testing
+-------
+
+Example code can be found in lib/pks/pks_test.c
+
+.. kernel-doc:: lib/pks/pks_test.c
+        :doc: PKS_TEST
diff --git a/include/linux/pks-keys.h b/include/linux/pks-keys.h
index 05fe4a1cf888..69a0be979515 100644
--- a/include/linux/pks-keys.h
+++ b/include/linux/pks-keys.h
@@ -42,10 +42,11 @@
  */
 enum pks_pkey_consumers {
 	PKS_KEY_DEFAULT		= 0, /* Must be 0 for default PTE values */
+	PKS_KEY_TEST		= 1,
 };
 
 #define PKS_INIT_VALUE (PKR_RW_KEY(PKS_KEY_DEFAULT)		| \
-			PKR_AD_KEY(1)	| \
+			PKR_AD_KEY(PKS_KEY_TEST)	| \
 			PKR_AD_KEY(2)	| PKR_AD_KEY(3)		| \
 			PKR_AD_KEY(4)	| PKR_AD_KEY(5)		| \
 			PKR_AD_KEY(6)	| PKR_AD_KEY(7)		| \
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 14b89aa37c5c..5cab2100c133 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2685,6 +2685,18 @@ config HYPERV_TESTING
 	help
 	  Select this option to enable Hyper-V vmbus testing.
 
+config PKS_TEST
+	bool "PKey (S)upervisor testing"
+	depends on ARCH_HAS_SUPERVISOR_PKEYS
+	select ARCH_ENABLE_SUPERVISOR_PKEYS
+	help
+	  Select this option to enable testing of PKS core software and
+	  hardware.
+
+	  Answer N if you don't know what supervisor keys are.
+
+	  If unsure, say N.
+
 endmenu # "Kernel Testing and Coverage"
 
 source "Documentation/Kconfig"
diff --git a/lib/Makefile b/lib/Makefile
index 300f569c626b..038a93c89714 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -398,3 +398,6 @@ $(obj)/$(TEST_FORTIFY_LOG): $(addprefix $(obj)/, $(TEST_FORTIFY_LOGS)) FORCE
 ifeq ($(CONFIG_FORTIFY_SOURCE),y)
 $(obj)/string.o: $(obj)/$(TEST_FORTIFY_LOG)
 endif
+
+# PKS test
+obj-y += pks/
diff --git a/lib/pks/Makefile b/lib/pks/Makefile
new file mode 100644
index 000000000000..9daccba4f7c4
--- /dev/null
+++ b/lib/pks/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_PKS_TEST) += pks_test.o
diff --git a/lib/pks/pks_test.c b/lib/pks/pks_test.c
new file mode 100644
index 000000000000..159576dda47c
--- /dev/null
+++ b/lib/pks/pks_test.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright(c) 2021 Intel Corporation. All rights reserved.
+ */
+
+/**
+ * DOC: PKS_TEST
+ *
+ * If CONFIG_PKS_TEST is enabled a debugfs file is created to initiate in
+ * kernel testing.  These can be triggered by:
+ *
+ * $ echo X > /sys/kernel/debug/x86/run_pks
+ *
+ * where X is:
+ *
+ * * 0  Loop through all CPUs, report the msr, and check against the default.
+ * * 9  Set up and fault on a PKS protected page.
+ *
+ * NOTE: 9 will fault on purpose.  Therefore, it requires the option to be
+ * specified 2 times in a row to ensure the intent to run it.
+ *
+ * $ cat /sys/kernel/debug/x86/run_pks
+ *
+ * Will print the result of the last test.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/debugfs.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/pkeys.h>
+
+#define PKS_TEST_MEM_SIZE (PAGE_SIZE)
+
+#define CHECK_DEFAULTS		0
+#define RUN_CRASH_TEST		9
+
+static struct dentry *pks_test_dentry;
+static bool crash_armed;
+
+static bool last_test_pass;
+
+struct pks_test_ctx {
+	int pkey;
+	char data[64];
+};
+
+static void *alloc_test_page(int pkey)
+{
+	return __vmalloc_node_range(PKS_TEST_MEM_SIZE, 1, VMALLOC_START, VMALLOC_END,
+				    GFP_KERNEL, PAGE_KERNEL_PKEY(pkey), 0,
+				    NUMA_NO_NODE, __builtin_return_address(0));
+}
+
+static struct pks_test_ctx *alloc_ctx(u8 pkey)
+{
+	struct pks_test_ctx *ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+
+	if (!ctx) {
+		pr_err("Failed to allocate memory for test context\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ctx->pkey = pkey;
+	sprintf(ctx->data, "%s", "DEADBEEF");
+	return ctx;
+}
+
+static void free_ctx(struct pks_test_ctx *ctx)
+{
+	kfree(ctx);
+}
+
+static void crash_it(void)
+{
+	struct pks_test_ctx *ctx;
+	void *ptr;
+
+	pr_warn("     ***** BEGIN: Unhandled fault test *****\n");
+
+	ctx = alloc_ctx(PKS_KEY_TEST);
+	if (IS_ERR(ctx)) {
+		pr_err("Failed to allocate context???\n");
+		return;
+	}
+
+	ptr = alloc_test_page(ctx->pkey);
+	if (!ptr) {
+		pr_err("Failed to vmalloc page???\n");
+		return;
+	}
+
+	/* This purposely faults */
+	memcpy(ptr, ctx->data, 8);
+
+	/* Should never get here if so the test failed */
+	last_test_pass = false;
+
+	vfree(ptr);
+	free_ctx(ctx);
+}
+
+static void check_pkey_settings(void *data)
+{
+	unsigned long long msr = 0;
+	unsigned int cpu = smp_processor_id();
+
+	rdmsrl(MSR_IA32_PKRS, msr);
+	if (msr != PKS_INIT_VALUE) {
+		pr_err("cpu %d value incorrect : 0x%llx expected 0x%x\n",
+			cpu, msr, PKS_INIT_VALUE);
+		last_test_pass = false;
+	}
+}
+
+static void arm_or_run_crash_test(void)
+{
+	/*
+	 * WARNING: Test "9" will crash.
+	 *
+	 * Arm the test and print a warning.  A second "9" will run the test.
+	 */
+	if (!crash_armed) {
+		pr_warn("CAUTION: The crash test will cause an oops.\n");
+		pr_warn("         Specify 9 a second time to run\n");
+		pr_warn("         run any other test to clear\n");
+		crash_armed = true;
+		return;
+	}
+
+	crash_it();
+	crash_armed = false;
+}
+
+static ssize_t pks_read_file(struct file *file, char __user *user_buf,
+			     size_t count, loff_t *ppos)
+{
+	char buf[64];
+	unsigned int len;
+
+	len = sprintf(buf, "%s\n", last_test_pass ? "PASS" : "FAIL");
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static ssize_t pks_write_file(struct file *file, const char __user *user_buf,
+			      size_t count, loff_t *ppos)
+{
+	int rc;
+	long option;
+	char buf[2];
+
+	if (copy_from_user(buf, user_buf, 1)) {
+		last_test_pass = false;
+		return -EFAULT;
+	}
+	buf[1] = '\0';
+
+	rc = kstrtol(buf, 0, &option);
+	if (rc) {
+		last_test_pass = false;
+		return count;
+	}
+
+	last_test_pass = true;
+
+	switch (option) {
+	case RUN_CRASH_TEST:
+		arm_or_run_crash_test();
+		goto skip_arm_clearing;
+	case CHECK_DEFAULTS:
+		on_each_cpu(check_pkey_settings, NULL, 1);
+		break;
+	default:
+		last_test_pass = false;
+		break;
+	}
+
+	/* Clear arming on any test run */
+	crash_armed = false;
+
+skip_arm_clearing:
+	return count;
+}
+
+static int pks_release_file(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static const struct file_operations fops_init_pks = {
+	.read = pks_read_file,
+	.write = pks_write_file,
+	.llseek = default_llseek,
+	.release = pks_release_file,
+};
+
+static int __init pks_test_init(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_PKS))
+		pks_test_dentry = debugfs_create_file("run_pks", 0600, arch_debugfs_dir,
+						      NULL, &fops_init_pks);
+
+	return 0;
+}
+late_initcall(pks_test_init);
+
+static void __exit pks_test_exit(void)
+{
+	debugfs_remove(pks_test_dentry);
+	pr_info("test exit\n");
+}
-- 
2.31.1

