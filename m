Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0D149E977
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243302AbiA0R4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:56:37 -0500
Received: from mga02.intel.com ([134.134.136.20]:19415 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244817AbiA0Rzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306132; x=1674842132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K/5ZtoMtZQ5F0Ii5hg3nst9IQO9U2ZVIqR8hleWBK4E=;
  b=MENEZ2/KX3qJs2+oLfK48h7xEl0nRyHgmbnvwx/bB3PJkDvol0Y0pQu4
   whkaGePNYrJ0axRyxWlvoUYUcBvM5RyCXi3YCfbjQx5+tsTBcyS1H2ZTp
   iejfGlc5uuZif8oV98agMIhoyNNudD1vB8ORCg4YTlFXswW2L6YfXHlHY
   SaUCW+8rvigZpvqKo5Nzq+lNTplAwJgIgauYbdN3HsdszKniCN3TO9SCT
   howklAqCPve6chFSuZhkHHvIbHqlISi0FgdCJWw52TGjxHwn4j/gAhu3V
   EOHFoGAdxo6v96qSS73b4SdljvDJHY+rlms4DVOuU9lTt1FGNsLfe6BuP
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="234302442"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="234302442"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796148"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:11 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 27/44] mm/pkeys: Add PKS exception test
Date:   Thu, 27 Jan 2022 09:54:48 -0800
Message-Id: <20220127175505.851391-28-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

During an exception the interrupted threads PKRS value must be preserved
and the exception should get the default value for that Pkey.  Upon
return from exception the threads PKRS value should be restored.

Add a PKS test which forces a fault and checks the values saved as well
as tests the ability for code to change the Pkey value during the
exception.

Do this by changing the interrupted thread Pkey to read only prior to
the exception.  The default test Pkey is no access and therefore should
be seen during the exception.  They switch to read/write during the
exception.  Finally ensure that the read only value is restored when
the exception is completed.

	$ echo 4 > /sys/kernel/debug/x86/run_pks
	$ cat /sys/kernel/debug/x86/run_pks
	PASS

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Change for V8
	Split this test off from the testing patch and place it after
	the exception saving code.
---
 arch/x86/include/asm/pks.h |   3 +
 arch/x86/mm/pkeys.c        |   2 +-
 lib/pks/pks_test.c         | 145 +++++++++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pks.h b/arch/x86/include/asm/pks.h
index fc3c66f1bb04..065386c8bf37 100644
--- a/arch/x86/include/asm/pks.h
+++ b/arch/x86/include/asm/pks.h
@@ -24,9 +24,12 @@ static inline void pks_dump_fault_info(struct pt_regs *regs) { }
 #ifdef CONFIG_PKS_TEST
 
 bool pks_test_callback(struct pt_regs *regs);
+#define __static_or_pks_test
 
 #else /* !CONFIG_PKS_TEST */
 
+#define __static_or_pks_test static
+
 static inline bool pks_test_callback(struct pt_regs *regs)
 {
 	return false;
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index bdd700d5ad03..1da78580d6de 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -210,7 +210,7 @@ u32 pkey_update_pkval(u32 pkval, int pkey, u32 accessbits)
 
 #ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
 
-static DEFINE_PER_CPU(u32, pkrs_cache);
+__static_or_pks_test DEFINE_PER_CPU(u32, pkrs_cache);
 
 /*
  * pks_write_pkrs() - Write the pkrs of the current CPU
diff --git a/lib/pks/pks_test.c b/lib/pks/pks_test.c
index 77f872829300..008a1079579d 100644
--- a/lib/pks/pks_test.c
+++ b/lib/pks/pks_test.c
@@ -17,6 +17,8 @@
  * * 1  Allocate a single key and check all 3 permissions on a page.
  * * 2  'arm context' for context switch test
  * * 3  Check the context armed in '2' to ensure the MSR value was preserved
+ * * 4  Test that the exception thread PKRS remains independent of the
+ *      interrupted threads PKRS
  * * 8  Loop through all CPUs, report the msr, and check against the default.
  * * 9  Set up and fault on a PKS protected page.
  *
@@ -53,8 +55,11 @@
 #define RUN_SINGLE		1
 #define ARM_CTX_SWITCH		2
 #define CHECK_CTX_SWITCH	3
+#define RUN_EXCEPTION		4
 #define RUN_CRASH_TEST		9
 
+DECLARE_PER_CPU(u32, pkrs_cache);
+
 static struct dentry *pks_test_dentry;
 static bool crash_armed;
 
@@ -65,8 +70,71 @@ static int prev_fault_cnt;
 
 struct pks_test_ctx {
 	int pkey;
+	bool pass;
 	char data[64];
 };
+static struct pks_test_ctx *test_exception_ctx;
+
+static bool check_pkey_val(u32 pk_reg, int pkey, u32 expected)
+{
+	pk_reg = (pk_reg >> PKR_PKEY_SHIFT(pkey)) & PKEY_ACCESS_MASK;
+	return (pk_reg == expected);
+}
+
+/*
+ * Check if the register @pkey value matches @expected value
+ *
+ * Both the cached and actual MSR must match.
+ */
+static bool check_pkrs(int pkey, u32 expected)
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
+static void check_exception(u32 thread_pkrs)
+{
+	/* Check the thread saved state */
+	if (!check_pkey_val(thread_pkrs, test_armed_key, PKEY_DISABLE_WRITE)) {
+		pr_err("     FAIL: checking ept_regs->thread_pkrs\n");
+		test_exception_ctx->pass = false;
+	}
+
+	/* Check that the exception state has disabled access */
+	if (!check_pkrs(test_armed_key, PKEY_DISABLE_ACCESS)) {
+		pr_err("     FAIL: PKRS cache and MSR\n");
+		test_exception_ctx->pass = false;
+	}
+
+	/*
+	 * Ensure an update can occur during exception without affecting the
+	 * interrupted thread.  The interrupted thread is checked after
+	 * exception...
+	 */
+	pks_mk_readwrite(test_armed_key);
+	if (!check_pkrs(test_armed_key, 0)) {
+		pr_err("     FAIL: exception did not change register to 0\n");
+		test_exception_ctx->pass = false;
+	}
+	pks_mk_noaccess(test_armed_key);
+	if (!check_pkrs(test_armed_key, PKEY_DISABLE_ACCESS)) {
+		pr_err("     FAIL: exception did not change register to 0x%x\n",
+			PKEY_DISABLE_ACCESS);
+		test_exception_ctx->pass = false;
+	}
+}
 
 /*
  * pks_test_callback() is called by the fault handler to indicate it saw a PKey
@@ -82,6 +150,16 @@ bool pks_test_callback(struct pt_regs *regs)
 	bool armed = (test_armed_key != 0);
 	u32 pkrs = aux_pt_regs->pks_thread_pkrs;
 
+	if (test_exception_ctx) {
+		check_exception(pkrs);
+		/*
+		 * Stop this check directly within the exception because the
+		 * fault handler clean up code will call again while checking
+		 * the PMD entry and there is no need to check this again.
+		 */
+		test_exception_ctx = NULL;
+	}
+
 	if (armed) {
 		/* Enable read and write to stop faults */
 		aux_pt_regs->pks_thread_pkrs = pkey_update_pkval(pkrs,
@@ -240,6 +318,7 @@ static struct pks_test_ctx *alloc_ctx(u8 pkey)
 	}
 
 	ctx->pkey = pkey;
+	ctx->pass = true;
 	sprintf(ctx->data, "%s", "DEADBEEF");
 	return ctx;
 }
@@ -265,6 +344,69 @@ static bool run_single(void)
 	return rc;
 }
 
+static bool run_exception_test(void)
+{
+	void *ptr = NULL;
+	bool pass = true;
+	struct pks_test_ctx *ctx;
+
+	pr_info("     ***** BEGIN: exception checking\n");
+
+	ctx = alloc_ctx(PKS_KEY_TEST);
+	if (IS_ERR(ctx)) {
+		pr_err("     FAIL: no context\n");
+		pass = false;
+		goto result;
+	}
+	ctx->pass = true;
+
+	ptr = alloc_test_page(ctx->pkey);
+	if (!ptr) {
+		pr_err("     FAIL: no vmalloc page\n");
+		pass = false;
+		goto free_context;
+	}
+
+	pks_update_protection(ctx->pkey, PKEY_DISABLE_WRITE);
+
+	WRITE_ONCE(test_exception_ctx, ctx);
+	WRITE_ONCE(test_armed_key, ctx->pkey);
+
+	memcpy(ptr, ctx->data, 8);
+
+	if (!fault_caught()) {
+		pr_err("     FAIL: did not get an exception\n");
+		pass = false;
+	}
+
+	/*
+	 * NOTE The exception code has to enable access (b00) to keep the fault
+	 * from looping forever.  Therefore full access is seen here rather
+	 * than write disabled.
+	 *
+	 * Furthermore, check_exception() disabled access during the exception
+	 * so this is testing that the thread value was restored back to the
+	 * thread value.
+	 */
+	if (!check_pkrs(test_armed_key, 0)) {
+		pr_err("     FAIL: PKRS not restored\n");
+		pass = false;
+	}
+
+	if (!ctx->pass)
+		pass = false;
+
+	WRITE_ONCE(test_armed_key, 0);
+
+	vfree(ptr);
+free_context:
+	free_ctx(ctx);
+result:
+	pr_info("     ***** END: exception checking : %s\n",
+		 pass ? "PASS" : "FAIL");
+	return pass;
+}
+
 static void crash_it(void)
 {
 	struct pks_test_ctx *ctx;
@@ -427,6 +569,9 @@ static ssize_t pks_write_file(struct file *file, const char __user *user_buf,
 		/* After context switch MSR should be restored */
 		check_ctx_switch(file);
 		break;
+	case RUN_EXCEPTION:
+		last_test_pass = run_exception_test();
+		break;
 	default:
 		last_test_pass = false;
 		break;
-- 
2.31.1

