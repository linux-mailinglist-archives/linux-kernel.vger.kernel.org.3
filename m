Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C15507634
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355934AbiDSRME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355689AbiDSRKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:10:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C499412098
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388045; x=1681924045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mOKOV2YxIJIuB8zswaSjIpr/sNoXiSTqH1rRmIWqFac=;
  b=NwwG19Zfgr1cSc4Hu8Shh/6ltwCI22yMX2hh/FhGXH7MXV7D63ZLyDA9
   BY3QKMfIQ19HbkMBMgLxmDypKSkeUIoGmglNTvbgJ2VGF5YENeHLULiJ2
   zqRlUWwsK+TQht6i0PFfnUxzjUYV5Gp3GAAvS4fmwcWlbyS5zDJLVpm3W
   FNl80gCJ22i09mXli2DZeaEU0iNCTnpip2jX2ECFWBjHa79faL0AKbkKU
   sx6utcCLUIdw2HtT8zqPQOYuoE6uABFqqQw+D903AFnL5CG+jkIBQd8yS
   DmdQQU8VSl0dOCJX58AmIFfL+vK75BJnYepVzDKslos3EFr2siyQU9i1N
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="326720646"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="326720646"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:25 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="625733486"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:24 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 40/44] mm/pkeys: PKS testing, add pks_set_*() tests
Date:   Tue, 19 Apr 2022 10:06:45 -0700
Message-Id: <20220419170649.1022246-41-ira.weiny@intel.com>
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

Test that the pks_set_*() functions operate as intended.

First, verify that the pkey was properly set in the PTE.

Second, use the fault callback mechanism to detect if a fault occurred
when expected and if so clear the fault.

The test iterates each of the following test cases.

	PKS_TEST_NO_ACCESS,	WRITE,	FAULT_EXPECTED
	PKS_TEST_NO_ACCESS,	READ,	FAULT_EXPECTED

	PKS_TEST_RDWR,		WRITE,	NO_FAULT_EXPECTED
	PKS_TEST_RDWR,		READ,	NO_FAULT_EXPECTED

Add documentation.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V10
	Test patches moved together in the series which required the
	exception handling modification to be squashed in this test.

Changes for V9
	Update commit message
	Clarify use of global state for faults to be used by all tests
	Add test to test_pks user app
	Remove an incorrect comment in the kdoc
	Change pkey type to u8
	From Dave Hansen
		s/pks_mk*/pks_set*/
	From Rick Edgecombe
		Use standard fault callback instead of the custom PKS
		test one

Changes for V8
	Remove readonly test, as that patch is not needed for PMEM
	Split this off into a patch which follows the pks_mk_*()
		patches.  Thus allowing for a better view of how the
		test works compared to the functionality added with
		those patches.
	Remove unneeded prints
---
 lib/pks/pks_test.c                     | 168 ++++++++++++++++++++++++-
 tools/testing/selftests/x86/test_pks.c |   5 +-
 2 files changed, 169 insertions(+), 4 deletions(-)

diff --git a/lib/pks/pks_test.c b/lib/pks/pks_test.c
index 37f2cd7d0f56..dc309dd941be 100644
--- a/lib/pks/pks_test.c
+++ b/lib/pks/pks_test.c
@@ -33,11 +33,17 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/pgtable.h>
+#include <linux/pkeys.h>
+#include <linux/pks.h>
 #include <linux/pks-keys.h>
 
+#include <asm/ptrace.h>
+
 #define PKS_TEST_MEM_SIZE (PAGE_SIZE)
 
 #define CHECK_DEFAULTS		0
+#define RUN_SINGLE		1
 #define RUN_CRASH_TEST		9
 
 static struct dentry *pks_test_dentry;
@@ -48,6 +54,7 @@ struct pks_test_ctx {
 	u8 pkey;
 	char data[64];
 	void *test_page;
+	bool fault_seen;
 };
 
 static void debug_context(const char *label, struct pks_test_ctx *ctx)
@@ -85,10 +92,107 @@ static void debug_result(const char *label, int test_num,
 		     sd->last_test_pass ? "PASS" : "FAIL");
 }
 
+/* Global data protected by test_run_lock */
+struct pks_test_ctx *g_ctx_under_test;
+
+/*
+ * Call set_context_for_fault() after the context has been set up and prior to
+ * the expected fault.
+ */
+static void set_context_for_fault(struct pks_test_ctx *ctx)
+{
+	g_ctx_under_test = ctx;
+	/* Ensure the state of the global context is correct prior to a fault */
+	barrier();
+}
+
 bool pks_test_fault_callback(struct pt_regs *regs, unsigned long address,
 			     bool write)
 {
-	return false;
+	struct pt_regs_extended *ept_regs = to_extended_pt_regs(regs);
+	struct pt_regs_auxiliary *aux_pt_regs = &ept_regs->aux;
+	u32 pkrs = aux_pt_regs->pkrs;
+
+	pr_debug("PKS Fault callback: ctx %p\n", g_ctx_under_test);
+
+	if (!g_ctx_under_test)
+		return false;
+
+	aux_pt_regs->pkrs = pkey_update_pkval(pkrs, g_ctx_under_test->pkey, 0);
+	g_ctx_under_test->fault_seen = true;
+	return true;
+}
+
+enum pks_access_mode {
+	PKS_TEST_NO_ACCESS,
+	PKS_TEST_RDWR,
+};
+
+#define PKS_WRITE true
+#define PKS_READ false
+#define PKS_FAULT_EXPECTED true
+#define PKS_NO_FAULT_EXPECTED false
+
+static char *get_mode_str(enum pks_access_mode mode)
+{
+	switch (mode) {
+	case PKS_TEST_NO_ACCESS:
+		return "No Access";
+	case PKS_TEST_RDWR:
+		return "Read Write";
+	}
+
+	return "";
+}
+
+struct pks_access_test {
+	enum pks_access_mode mode;
+	bool write;
+	bool fault;
+};
+
+static struct pks_access_test pkey_test_ary[] = {
+	{ PKS_TEST_NO_ACCESS,     PKS_WRITE,  PKS_FAULT_EXPECTED },
+	{ PKS_TEST_NO_ACCESS,     PKS_READ,   PKS_FAULT_EXPECTED },
+
+	{ PKS_TEST_RDWR,          PKS_WRITE,  PKS_NO_FAULT_EXPECTED },
+	{ PKS_TEST_RDWR,          PKS_READ,   PKS_NO_FAULT_EXPECTED },
+};
+
+static bool run_access_test(struct pks_test_ctx *ctx,
+			   struct pks_access_test *test,
+			   void *ptr)
+{
+	switch (test->mode) {
+	case PKS_TEST_NO_ACCESS:
+		pks_set_noaccess(ctx->pkey);
+		break;
+	case PKS_TEST_RDWR:
+		pks_set_readwrite(ctx->pkey);
+		break;
+	default:
+		pr_debug("BUG in test, invalid mode\n");
+		return false;
+	}
+
+	ctx->fault_seen = false;
+	set_context_for_fault(ctx);
+
+	if (test->write)
+		memcpy(ptr, ctx->data, 8);
+	else
+		memcpy(ctx->data, ptr, 8);
+
+	if (test->fault != ctx->fault_seen) {
+		pr_err("pkey test FAILED: mode %s; write %s; fault %s != %s\n",
+			get_mode_str(test->mode),
+			test->write ? "TRUE" : "FALSE",
+			test->fault ? "YES" : "NO",
+			ctx->fault_seen ? "YES" : "NO");
+		return false;
+	}
+
+	return true;
 }
 
 static void *alloc_test_page(u8 pkey)
@@ -108,6 +212,37 @@ static void free_ctx(struct pks_test_ctx *ctx)
 	kfree(ctx);
 }
 
+static bool test_ctx(struct pks_test_ctx *ctx)
+{
+	bool rc = true;
+	int i;
+	u8 pkey;
+	void *ptr = ctx->test_page;
+	pte_t *ptep = NULL;
+	unsigned int level;
+
+	ptep = lookup_address((unsigned long)ptr, &level);
+	if (!ptep) {
+		pr_err("Failed to lookup address???\n");
+		return false;
+	}
+
+	pkey = pte_flags_pkey(ptep->pte);
+	if (pkey != ctx->pkey) {
+		pr_err("invalid pkey found: %u, test_pkey: %u\n",
+			pkey, ctx->pkey);
+		return false;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(pkey_test_ary); i++) {
+		/* sticky fail */
+		if (!run_access_test(ctx, &pkey_test_ary[i], ptr))
+			rc = false;
+	}
+
+	return rc;
+}
+
 static struct pks_test_ctx *alloc_ctx(u8 pkey)
 {
 	struct pks_test_ctx *ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
@@ -139,6 +274,23 @@ static void set_ctx_data(struct pks_session_data *sd, struct pks_test_ctx *ctx)
 	sd->ctx = ctx;
 }
 
+static bool run_single(struct pks_session_data *sd)
+{
+	struct pks_test_ctx *ctx;
+	bool rc;
+
+	ctx = alloc_ctx(PKS_KEY_TEST);
+	if (IS_ERR(ctx))
+		return false;
+
+	set_ctx_data(sd, ctx);
+
+	rc = test_ctx(ctx);
+	pks_set_noaccess(ctx->pkey);
+
+	return rc;
+}
+
 static void crash_it(struct pks_session_data *sd)
 {
 	struct pks_test_ctx *ctx;
@@ -203,6 +355,12 @@ static ssize_t pks_read_file(struct file *file, char __user *user_buf,
 	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
 }
 
+static void cleanup_test(void)
+{
+	g_ctx_under_test = NULL;
+	mutex_unlock(&test_run_lock);
+}
+
 static ssize_t pks_write_file(struct file *file, const char __user *user_buf,
 			      size_t count, loff_t *ppos)
 {
@@ -235,6 +393,10 @@ static ssize_t pks_write_file(struct file *file, const char __user *user_buf,
 		pr_debug("check defaults test: 0x%lx\n", PKS_INIT_VALUE);
 		on_each_cpu(check_pkey_settings, file->private_data, 1);
 		break;
+	case RUN_SINGLE:
+		pr_debug("Single key\n");
+		sd->last_test_pass = run_single(file->private_data);
+		break;
 	default:
 		pr_debug("Unknown test\n");
 		sd->last_test_pass = false;
@@ -251,7 +413,7 @@ static ssize_t pks_write_file(struct file *file, const char __user *user_buf,
 	 * Normal exit; clear up the locking flag
 	 */
 	sd->need_unlock = false;
-	mutex_unlock(&test_run_lock);
+	cleanup_test();
 	debug_result("Test complete", test_num, sd);
 	return count;
 }
@@ -282,7 +444,7 @@ static int pks_release_file(struct inode *inode, struct file *file)
 	 * not exit normally.
 	 */
 	if (sd->need_unlock)
-		mutex_unlock(&test_run_lock);
+		cleanup_test();
 	free_ctx(sd->ctx);
 	kfree(sd);
 	return 0;
diff --git a/tools/testing/selftests/x86/test_pks.c b/tools/testing/selftests/x86/test_pks.c
index df5bde9bfdbe..2c10b6c50416 100644
--- a/tools/testing/selftests/x86/test_pks.c
+++ b/tools/testing/selftests/x86/test_pks.c
@@ -31,6 +31,7 @@
 
 /* Values from the kernel */
 #define CHECK_DEFAULTS		"0"
+#define RUN_SINGLE		"1"
 #define RUN_CRASH_TEST		"9"
 
 time_t g_start_time;
@@ -53,6 +54,7 @@ static int do_simple_test(const char *debugfs_str);
  */
 enum {
 	TEST_DEFAULTS = 0,
+	TEST_SINGLE,
 	MAX_TESTS,
 } tests;
 
@@ -64,7 +66,8 @@ struct test_item {
 	const char *debugfs_str;
 	int (*test_fn)(const char *debugfs_str);
 } test_list[] = {
-	{ "check_defaults", CHECK_DEFAULTS, do_simple_test }
+	{ "check_defaults", CHECK_DEFAULTS, do_simple_test },
+	{ "single", RUN_SINGLE, do_simple_test }
 };
 
 static char *get_test_name(int test_num)
-- 
2.35.1

