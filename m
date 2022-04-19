Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E779507643
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355984AbiDSRML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355698AbiDSRKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:10:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABE313CC2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388047; x=1681924047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZSLyLZxH6D8Mp+7onzwQckyZ3t/ShnheZ0rUHeiHQM8=;
  b=YqOveCABQR9PtwJZ1UQSPICZJn5COQOguPnacOL+Nz/m2ZIK/W6EuLTx
   UPrS1VScvti3ELypTF3MPQRkfo6ErLEI6NymqOlQBUPPO1pH7q26scZWN
   FbCVv0xaR/AQ93TjiJrn6v3U2QpYFIc0YbRjdCKYnzbRCys1tm4vClyHc
   zUAVH8ozoHE5dh5KgnLP/QTpPrVn7drxbX3C+CNoPRluwybNjkiN17S9E
   Bj80YjT9YJoVMfuerUdle/2KtcbuFBGJQ75Z0fWL4/Y/r0UIkP1MggHls
   xJlEV0IJ1R84miJ2FKljk6ANZxdfOT7pJkbunujsDpmZ0Ai23AkMuAMPr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="262677119"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="262677119"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:27 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="727145629"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:26 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 42/44] mm/pkeys: PKS testing, Add exception test
Date:   Tue, 19 Apr 2022 10:06:47 -0700
Message-Id: <20220419170649.1022246-43-ira.weiny@intel.com>
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

During an exception the interrupted threads PKRS value is preserved
and the exception receives the default value for that pkey.  Upon
return from exception the threads PKRS value is restored.

Add a PKS test which forces a fault to check that this works as
intended.  Check that both the thread as well as the exception PKRS
state is correct at the beginning, during, and after the exception.

Add the test to the test_pks app.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Change for V9
	Add test to test_pks
	Clean up the globals shared with the fault handler
	Use the PKS Test specific fault callback
	s/pks_mk*/pks_set*/
	Change pkey type to u8
	From Dave Hansen
		use pkey

Change for V8
	Split this test off from the testing patch and place it after
	the exception saving code.
---
 arch/x86/mm/pkeys.c                    |   2 +-
 include/linux/pks.h                    |   6 ++
 lib/pks/pks_test.c                     | 133 +++++++++++++++++++++++++
 tools/testing/selftests/x86/test_pks.c |   5 +-
 4 files changed, 144 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 9e0948766427..ee5eff6bdbf3 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -216,7 +216,7 @@ u32 pkey_update_pkval(u32 pkval, u8 pkey, u32 accessbits)
 
 #ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
 
-static DEFINE_PER_CPU(u32, pkrs_cache);
+__static_or_pks_test DEFINE_PER_CPU(u32, pkrs_cache);
 
 /**
  * DOC: DEFINE_PKS_FAULT_CALLBACK
diff --git a/include/linux/pks.h b/include/linux/pks.h
index fd0ed09dd143..163c75992a8a 100644
--- a/include/linux/pks.h
+++ b/include/linux/pks.h
@@ -59,9 +59,15 @@ static inline void pks_update_exception(struct pt_regs *regs,
 
 #ifdef CONFIG_PKS_TEST
 
+#define __static_or_pks_test
+
 bool pks_test_fault_callback(struct pt_regs *regs, unsigned long address,
 			     bool write);
 
+#else /* !CONFIG_PKS_TEST */
+
+#define __static_or_pks_test static
+
 #endif /* CONFIG_PKS_TEST */
 
 #endif /* _LINUX_PKS_H */
diff --git a/lib/pks/pks_test.c b/lib/pks/pks_test.c
index 86af2f61393d..762f4a19cb7d 100644
--- a/lib/pks/pks_test.c
+++ b/lib/pks/pks_test.c
@@ -48,19 +48,30 @@
 #define RUN_SINGLE		1
 #define ARM_CTX_SWITCH		2
 #define CHECK_CTX_SWITCH	3
+#define RUN_EXCEPTION		4
 #define RUN_CRASH_TEST		9
 
+DECLARE_PER_CPU(u32, pkrs_cache);
+
 static struct dentry *pks_test_dentry;
 
 DEFINE_MUTEX(test_run_lock);
 
 struct pks_test_ctx {
 	u8 pkey;
+	bool pass;
 	char data[64];
 	void *test_page;
 	bool fault_seen;
+	bool validate_exp_handling;
 };
 
+static bool check_pkey_val(u32 pk_reg, u8 pkey, u32 expected)
+{
+	pk_reg = (pk_reg >> PKR_PKEY_SHIFT(pkey)) & PKEY_ACCESS_MASK;
+	return (pk_reg == expected);
+}
+
 static void debug_context(const char *label, struct pks_test_ctx *ctx)
 {
 	pr_debug("%s [%d] %s <-> %p\n",
@@ -96,6 +107,63 @@ static void debug_result(const char *label, int test_num,
 		     sd->last_test_pass ? "PASS" : "FAIL");
 }
 
+/*
+ * Check if the register @pkey value matches @expected value
+ *
+ * Both the cached and actual MSR must match.
+ */
+static bool check_pkrs(u8 pkey, u8 expected)
+{
+	bool ret = true;
+	u64 pkrs;
+	u32 *tmp_cache;
+
+	tmp_cache = get_cpu_ptr(&pkrs_cache);
+	if (!check_pkey_val(*tmp_cache, pkey, expected))
+		ret = false;
+	put_cpu_ptr(tmp_cache);
+
+	rdmsrl(MSR_IA32_PKRS, pkrs);
+	if (!check_pkey_val(pkrs, pkey, expected))
+		ret = false;
+
+	return ret;
+}
+
+static void validate_exception(struct pks_test_ctx *ctx, u32 thread_pkrs)
+{
+	u8 pkey = ctx->pkey;
+
+	/* Check that the thread state was saved */
+	if (!check_pkey_val(thread_pkrs, pkey, PKEY_DISABLE_WRITE)) {
+		pr_err("     FAIL: checking aux_pt_regs->thread_pkrs\n");
+		ctx->pass = false;
+	}
+
+	/* Check that the exception received the default of disabled access */
+	if (!check_pkrs(pkey, PKEY_DISABLE_ACCESS)) {
+		pr_err("     FAIL: PKRS cache and MSR\n");
+		ctx->pass = false;
+	}
+
+	/*
+	 * Ensure an update can occur during exception without affecting the
+	 * interrupted thread.  The interrupted thread is verified after the
+	 * exception returns.
+	 */
+	pks_set_readwrite(pkey);
+	if (!check_pkrs(pkey, 0)) {
+		pr_err("     FAIL: exception did not change register to 0\n");
+		ctx->pass = false;
+	}
+	pks_set_noaccess(pkey);
+	if (!check_pkrs(pkey, PKEY_DISABLE_ACCESS)) {
+		pr_err("     FAIL: exception did not change register to 0x%x\n",
+			PKEY_DISABLE_ACCESS);
+		ctx->pass = false;
+	}
+}
+
 /* Global data protected by test_run_lock */
 struct pks_test_ctx *g_ctx_under_test;
 
@@ -122,6 +190,16 @@ bool pks_test_fault_callback(struct pt_regs *regs, unsigned long address,
 	if (!g_ctx_under_test)
 		return false;
 
+	if (g_ctx_under_test->validate_exp_handling) {
+		validate_exception(g_ctx_under_test, pkrs);
+		/*
+		 * Stop this check directly within the exception because the
+		 * fault handler clean up code will call again while checking
+		 * the PMD entry and there is no need to check this again.
+		 */
+		g_ctx_under_test->validate_exp_handling = false;
+	}
+
 	aux_pt_regs->pkrs = pkey_update_pkval(pkrs, g_ctx_under_test->pkey, 0);
 	g_ctx_under_test->fault_seen = true;
 	return true;
@@ -255,6 +333,7 @@ static struct pks_test_ctx *alloc_ctx(u8 pkey)
 		return ERR_PTR(-ENOMEM);
 
 	ctx->pkey = pkey;
+	ctx->pass = true;
 	sprintf(ctx->data, "%s", "DEADBEEF");
 
 	ctx->test_page = alloc_test_page(ctx->pkey);
@@ -295,6 +374,56 @@ static bool run_single(struct pks_session_data *sd)
 	return rc;
 }
 
+static bool run_exception_test(struct pks_session_data *sd)
+{
+	bool pass = true;
+	struct pks_test_ctx *ctx;
+
+	ctx = alloc_ctx(PKS_KEY_TEST);
+	if (IS_ERR(ctx)) {
+		pr_debug("     FAIL: no context\n");
+		return false;
+	}
+
+	set_ctx_data(sd, ctx);
+
+	/*
+	 * Set the thread pkey value to something other than the default of
+	 * access disable but something which still causes a fault, disable
+	 * writes.
+	 */
+	pks_update_protection(ctx->pkey, PKEY_DISABLE_WRITE);
+
+	ctx->validate_exp_handling = true;
+	set_context_for_fault(ctx);
+
+	memcpy(ctx->test_page, ctx->data, 8);
+
+	if (!ctx->fault_seen) {
+		pr_err("     FAIL: did not get an exception\n");
+		pass = false;
+	}
+
+	/*
+	 * The exception code has to enable access to keep the fault from
+	 * looping forever.  Therefore full access is seen here rather than
+	 * write disabled.
+	 *
+	 * However, this does verify that the exception state was independent
+	 * of the interrupted threads state because validate_exception()
+	 * disabled access during the exception.
+	 */
+	if (!check_pkrs(ctx->pkey, 0)) {
+		pr_err("     FAIL: PKRS not restored\n");
+		pass = false;
+	}
+
+	if (!ctx->pass)
+		pass = false;
+
+	return pass;
+}
+
 static void crash_it(struct pks_session_data *sd)
 {
 	struct pks_test_ctx *ctx;
@@ -451,6 +580,10 @@ static ssize_t pks_write_file(struct file *file, const char __user *user_buf,
 		pr_debug("Checking Context switch test\n");
 		check_ctx_switch(file->private_data);
 		break;
+	case RUN_EXCEPTION:
+		pr_debug("Exception checking\n");
+		sd->last_test_pass = run_exception_test(file->private_data);
+		break;
 	default:
 		pr_debug("Unknown test\n");
 		sd->last_test_pass = false;
diff --git a/tools/testing/selftests/x86/test_pks.c b/tools/testing/selftests/x86/test_pks.c
index 626421fa8ed8..c40035803e38 100644
--- a/tools/testing/selftests/x86/test_pks.c
+++ b/tools/testing/selftests/x86/test_pks.c
@@ -35,6 +35,7 @@
 #define RUN_SINGLE		"1"
 #define ARM_CTX_SWITCH		"2"
 #define CHECK_CTX_SWITCH	"3"
+#define RUN_EXCEPTION		"4"
 #define RUN_CRASH_TEST		"9"
 
 time_t g_start_time;
@@ -61,6 +62,7 @@ enum {
 	TEST_DEFAULTS = 0,
 	TEST_SINGLE,
 	TEST_CTX_SWITCH,
+	TEST_EXCEPTION,
 	MAX_TESTS,
 } tests;
 
@@ -74,7 +76,8 @@ struct test_item {
 } test_list[] = {
 	{ "check_defaults", CHECK_DEFAULTS, do_simple_test },
 	{ "single", RUN_SINGLE, do_simple_test },
-	{ "context_switch", ARM_CTX_SWITCH, do_context_switch }
+	{ "context_switch", ARM_CTX_SWITCH, do_context_switch },
+	{ "exception", RUN_EXCEPTION, do_simple_test }
 };
 
 static char *get_test_name(int test_num)
-- 
2.35.1

