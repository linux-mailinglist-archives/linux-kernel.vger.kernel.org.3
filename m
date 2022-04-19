Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AEE507636
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356024AbiDSRMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355238AbiDSRKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:10:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9138E62CE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388042; x=1681924042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IFTAlozldUjZoDWs9NBVHctgmL+SsILD5QZm6e6W4wE=;
  b=Zce4VXTmkMI8Sps3ASzjSaXBAxSJsHFVK4WzLQ1vXmQI/+xaNK4txYdD
   +yHP1gk2iomr808jmEMC86Ygcu0Xw3lhlQsiu1HU0bqUBKFHf9iZg9aC6
   fisdOXPdcrOcyfH8kUC/1j230Y7a8RZBbhVlaMtnVKdGvePNHTZaC6L1l
   LYMAxnmrc91lOetlb2GBCMMAmTL3+RzyVpGNNJ11XSmiNkr3G5NqaBRAS
   awB117HmWLwX83EnSA0slXFooW8Yn+gYJ9XZwcJgkv1ZWKeh/phPrSjAC
   lGn5TvGVyTITsUvCnDRPNlyNQLAqn/P1GcO5QDmZ8ZS0iE/Wdq/vFo87E
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="261420887"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="261420887"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:22 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="702255172"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:22 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 37/44] mm/pkeys: PKS testing, add initial test code
Date:   Tue, 19 Apr 2022 10:06:42 -0700
Message-Id: <20220419170649.1022246-38-ira.weiny@intel.com>
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

Define a PKS consumer for testing.

Two initial tests are created.  One to check that the default values
have been properly assigned and a second which purposely causes a fault.

Add documentation.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V10
	Organize the test patches together and at the end of the larger
	series
	Change the key allocation based on the PMEM use case being added
	first.

Changes for V9
	Simplify the commit message
	Simplify documentation in favor of using test_pks
	Complete re-arch of test code...
	Return -ENOENT for unknown tests
	Adjust the key allocation
	Reduce the globals used during fault detection
	Introduce a session structure to track information as long as the
		debugfs file remains open.
	Use pr_debug() for internal debug output.
	Document how to run tests from debugfs with trace_printk()
		output.
	Feedback from Rick Edgecombe
		Change pkey type to u8
		remove pks_test_exit
		set file data within the crash test to be cleaned up on
			file close
		Resolve when memory barriers are needed
	From Dave Hansen
		Place a lock around the execution of tests so that only
			a single thread execute at a time.

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
 Documentation/core-api/protection-keys.rst |   6 +
 include/linux/pks-keys.h                   |   9 +-
 lib/Kconfig.debug                          |  12 +
 lib/Makefile                               |   3 +
 lib/pks/Makefile                           |   3 +
 lib/pks/pks_test.c                         | 301 +++++++++++++++++++++
 6 files changed, 332 insertions(+), 2 deletions(-)
 create mode 100644 lib/pks/Makefile
 create mode 100644 lib/pks/pks_test.c

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index 47bcb38fff4f..361c6b7e1b93 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -169,3 +169,9 @@ WRMSR(MSR_IA32_PKRS) is an exception.  It is not a serializing instruction and
 instead maintains ordering properties similar to WRPKRU.  Thus it is safe to
 immediately use a mapping when the pks_set*() functions returns.  Check the
 latest SDM for details.
+
+Testing
+-------
+
+.. kernel-doc:: lib/pks/pks_test.c
+        :doc: PKS_TEST
diff --git a/include/linux/pks-keys.h b/include/linux/pks-keys.h
index 4e63c8061e55..380bc999cbe3 100644
--- a/include/linux/pks-keys.h
+++ b/include/linux/pks-keys.h
@@ -62,12 +62,16 @@
 #define PKS_KEY_DEFAULT		0
 #define PKS_KEY_PGMAP_PROTECTION \
 		PKS_NEW_KEY(PKS_KEY_DEFAULT, CONFIG_DEVMAP_ACCESS_PROTECTION)
-#define PKS_KEY_MAX		PKS_NEW_KEY(PKS_KEY_PGMAP_PROTECTION, 1)
+#define PKS_KEY_TEST		PKS_NEW_KEY(PKS_KEY_PGMAP_PROTECTION, \
+					    CONFIG_PKS_TEST)
+#define PKS_KEY_MAX		PKS_NEW_KEY(PKS_KEY_TEST, 1)
 
 /* PKS_KEY_DEFAULT_INIT must be RW */
 #define PKS_KEY_DEFAULT_INIT	PKS_DECLARE_INIT_VALUE(PKS_KEY_DEFAULT, RW, 1)
 #define PKS_KEY_PGMAP_INIT	PKS_DECLARE_INIT_VALUE(PKS_KEY_PGMAP_PROTECTION, \
 					AD, CONFIG_DEVMAP_ACCESS_PROTECTION)
+#define PKS_KEY_TEST_INIT	PKS_DECLARE_INIT_VALUE(PKS_KEY_TEST, AD, \
+						       CONFIG_PKS_TEST)
 
 #define PKS_ALL_AD_MASK \
 	GENMASK(PKS_NUM_PKEYS * PKR_BITS_PER_PKEY, \
@@ -75,7 +79,8 @@
 
 #define PKS_INIT_VALUE ((PKS_ALL_AD & PKS_ALL_AD_MASK) | \
 			PKS_KEY_DEFAULT_INIT | \
-			PKS_KEY_PGMAP_INIT \
+			PKS_KEY_PGMAP_INIT | \
+			PKS_KEY_TEST_INIT \
 			)
 
 #endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 075cd25363ac..7ac43b78c7bb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2758,6 +2758,18 @@ config HYPERV_TESTING
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
index 6b9ffc1bd1ee..67f88d92aa00 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -402,3 +402,6 @@ $(obj)/$(TEST_FORTIFY_LOG): $(addprefix $(obj)/, $(TEST_FORTIFY_LOGS)) FORCE
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
index 000000000000..2fc92aaa54e8
--- /dev/null
+++ b/lib/pks/pks_test.c
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright(c) 2022 Intel Corporation. All rights reserved.
+ */
+
+/**
+ * DOC: PKS_TEST
+ *
+ * When CONFIG_PKS_TEST is enabled a debugfs file is created to facilitate in
+ * kernel testing.  Tests can be triggered by writing a test number to
+ * /sys/kernel/debug/x86/run_pks
+ *
+ * Results and debug output can be seen through dynamic debug.
+ *
+ * Example:
+ *
+ * .. code-block:: sh
+ *
+ *	# Enable kernel debug
+ *	echo "file pks_test.c +pflm" > /sys/kernel/debug/dynamic_debug/control
+ *
+ *	# Run test
+ *	echo 0 > /sys/kernel/debug/x86/run_pks
+ *
+ *	# Turn off kernel debug
+ *	echo "file pks_test.c -p" > /sys/kernel/debug/dynamic_debug/control
+ *
+ *	# view kernel debugging output
+ *	dmesg -H | grep pks_test
+ */
+
+#include <linux/debugfs.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/pks-keys.h>
+
+#define PKS_TEST_MEM_SIZE (PAGE_SIZE)
+
+#define CHECK_DEFAULTS		0
+#define RUN_CRASH_TEST		9
+
+static struct dentry *pks_test_dentry;
+
+DEFINE_MUTEX(test_run_lock);
+
+struct pks_test_ctx {
+	u8 pkey;
+	char data[64];
+	void *test_page;
+};
+
+static void debug_context(const char *label, struct pks_test_ctx *ctx)
+{
+	pr_debug("%s [%d] %s <-> %p\n",
+		     label,
+		     ctx->pkey,
+		     ctx->data,
+		     ctx->test_page);
+}
+
+struct pks_session_data {
+	struct pks_test_ctx *ctx;
+	bool need_unlock;
+	bool crash_armed;
+	bool last_test_pass;
+};
+
+static void debug_session(const char *label, struct pks_session_data *sd)
+{
+	pr_debug("%s ctx %p; unlock %d; crash %d; last test %s\n",
+		     label,
+		     sd->ctx,
+		     sd->need_unlock,
+		     sd->crash_armed,
+		     sd->last_test_pass ? "PASS" : "FAIL");
+
+}
+
+static void debug_result(const char *label, int test_num,
+			 struct pks_session_data *sd)
+{
+	pr_debug("%s [%d]: %s\n",
+		     label, test_num,
+		     sd->last_test_pass ? "PASS" : "FAIL");
+}
+
+static void *alloc_test_page(u8 pkey)
+{
+	return __vmalloc_node_range(PKS_TEST_MEM_SIZE, 1, VMALLOC_START,
+				    VMALLOC_END, GFP_KERNEL,
+				    PAGE_KERNEL_PKEY(pkey), 0,
+				    NUMA_NO_NODE, __builtin_return_address(0));
+}
+
+static void free_ctx(struct pks_test_ctx *ctx)
+{
+	if (!ctx)
+		return;
+
+	vfree(ctx->test_page);
+	kfree(ctx);
+}
+
+static struct pks_test_ctx *alloc_ctx(u8 pkey)
+{
+	struct pks_test_ctx *ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ctx->pkey = pkey;
+	sprintf(ctx->data, "%s", "DEADBEEF");
+
+	ctx->test_page = alloc_test_page(ctx->pkey);
+	if (!ctx->test_page) {
+		pr_debug("Test page allocation failed\n");
+		kfree(ctx);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	debug_context("Context allocated", ctx);
+	return ctx;
+}
+
+static void set_ctx_data(struct pks_session_data *sd, struct pks_test_ctx *ctx)
+{
+	if (sd->ctx) {
+		pr_debug("Context data already set\n");
+		free_ctx(sd->ctx);
+	}
+	pr_debug("Setting context data; %p\n", ctx);
+	sd->ctx = ctx;
+}
+
+static void crash_it(struct pks_session_data *sd)
+{
+	struct pks_test_ctx *ctx;
+
+	ctx = alloc_ctx(PKS_KEY_TEST);
+	if (IS_ERR(ctx)) {
+		pr_err("Failed to allocate context???\n");
+		sd->last_test_pass = false;
+		return;
+	}
+	set_ctx_data(sd, ctx);
+
+	pr_debug("Purposely faulting...\n");
+	memcpy(ctx->test_page, ctx->data, 8);
+
+	pr_err("ERROR: Should never get here...\n");
+	sd->last_test_pass = false;
+}
+
+static void check_pkey_settings(void *data)
+{
+	struct pks_session_data *sd = data;
+	unsigned long long msr = 0;
+	unsigned int cpu = smp_processor_id();
+
+	rdmsrl(MSR_IA32_PKRS, msr);
+	pr_debug("cpu %d 0x%llx\n", cpu, msr);
+	if (msr != PKS_INIT_VALUE) {
+		pr_err("cpu %d value incorrect : 0x%llx expected 0x%lx\n",
+			cpu, msr, PKS_INIT_VALUE);
+		sd->last_test_pass = false;
+	}
+}
+
+static void arm_or_run_crash_test(struct pks_session_data *sd)
+{
+
+	/*
+	 * WARNING: Test "9" will crash.
+	 * Arm the test.
+	 * A second "9" will run the test.
+	 */
+	if (!sd->crash_armed) {
+		pr_debug("Arming crash test\n");
+		sd->crash_armed = true;
+		return;
+	}
+
+	sd->crash_armed = false;
+	crash_it(sd);
+}
+
+static ssize_t pks_read_file(struct file *file, char __user *user_buf,
+			     size_t count, loff_t *ppos)
+{
+	struct pks_session_data *sd = file->private_data;
+	char buf[64];
+	unsigned int len;
+
+	len = sprintf(buf, "%s\n", sd->last_test_pass ? "PASS" : "FAIL");
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static ssize_t pks_write_file(struct file *file, const char __user *user_buf,
+			      size_t count, loff_t *ppos)
+{
+	struct pks_session_data *sd = file->private_data;
+	long test_num;
+	char buf[2];
+
+	pr_debug("Begin...\n");
+	sd->last_test_pass = false;
+
+	if (copy_from_user(buf, user_buf, 1))
+		return -EFAULT;
+	buf[1] = '\0';
+
+	if (kstrtol(buf, 0, &test_num))
+		return -EINVAL;
+
+	if (mutex_lock_interruptible(&test_run_lock))
+		return -EBUSY;
+
+	sd->need_unlock = true;
+	sd->last_test_pass = true;
+
+	switch (test_num) {
+	case RUN_CRASH_TEST:
+		pr_debug("crash test\n");
+		arm_or_run_crash_test(file->private_data);
+		goto unlock_test;
+	case CHECK_DEFAULTS:
+		pr_debug("check defaults test: 0x%lx\n", PKS_INIT_VALUE);
+		on_each_cpu(check_pkey_settings, file->private_data, 1);
+		break;
+	default:
+		pr_debug("Unknown test\n");
+		sd->last_test_pass = false;
+		count = -ENOENT;
+		break;
+	}
+
+	/* Clear arming on any test run */
+	pr_debug("Clearing crash test arm\n");
+	sd->crash_armed = false;
+
+unlock_test:
+	/*
+	 * Normal exit; clear up the locking flag
+	 */
+	sd->need_unlock = false;
+	mutex_unlock(&test_run_lock);
+	debug_result("Test complete", test_num, sd);
+	return count;
+}
+
+static int pks_open_file(struct inode *inode, struct file *file)
+{
+	struct pks_session_data *sd = kzalloc(sizeof(*sd), GFP_KERNEL);
+
+	if (!sd)
+		return -ENOMEM;
+
+	debug_session("Allocated session", sd);
+	file->private_data = sd;
+
+	return 0;
+}
+
+static int pks_release_file(struct inode *inode, struct file *file)
+{
+	struct pks_session_data *sd = file->private_data;
+
+	debug_session("Freeing session", sd);
+
+	/*
+	 * Some tests may fault and not return through the normal write
+	 * syscall.  The crash test is specifically designed to do this.  Clean
+	 * up the run lock when the file is closed if the write syscall does
+	 * not exit normally.
+	 */
+	if (sd->need_unlock)
+		mutex_unlock(&test_run_lock);
+	free_ctx(sd->ctx);
+	kfree(sd);
+	return 0;
+}
+
+static const struct file_operations fops_init_pks = {
+	.read = pks_read_file,
+	.write = pks_write_file,
+	.llseek = default_llseek,
+	.open = pks_open_file,
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
-- 
2.35.1

