Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF3F49E981
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiA0R5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:57:12 -0500
Received: from mga02.intel.com ([134.134.136.20]:19450 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244952AbiA0Rzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306140; x=1674842140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nFif/WsK5jLMynqNca82ezzZaEZ8rp9PXHlxBPSpvCs=;
  b=gtxZp12x3dOduT82sQyWwAHAg+b+LHL9f1ze/VvwQwA2MemMmKkLfojQ
   zZzTKexanFnwYlMYo58ndo/ITt1BBCxABHmXRrQ7+SIcisI+oBIDvnx3V
   G1Q3OehmpVm8Nary88TTGJ3RVWzrR6iJO5/6ejbrGiZiI99yvtgvitVwc
   kZMUEmx+B7TlEH1cObSGGNOtpuD/5R2xuDMPchV6E/0ITtAurofcZ+v5n
   BEnqCSuIlGHFaKXddJ2Ut9numBvcwPQdKkWNp9y2PFTdhKHlfoAHfdX1w
   9VQR4pcfAExAnxyHqM7N6fY/qFPJ3J6bnzXzn1vhu1FUKZONXVoLH+qWC
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="234302447"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="234302447"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796158"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:12 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 30/44] mm/pkeys: Test setting a PKS key in a custom fault callback
Date:   Thu, 27 Jan 2022 09:54:51 -0800
Message-Id: <20220127175505.851391-31-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

A common use case for the custom fault callbacks will be for the
callback to warn of the violation and relax the permissions rather than
crash the kernel.

An example of this is for non-security use cases which may want to relax
the permissions and flag the invalid access rather than strictly crash
the kernel.  In this case the user defines a callback which detects this
condition, reports the error, and allows for continued operation by
handling the fault through the pks_update_exception().

Add a test which does this.

	$ echo 5 > /sys/kernel/debug/x86/run_pks
	$ cat /sys/kernel/debug/x86/run_pks
	PASS

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V8
	New test developed just to double check for regressions while
	reworking the code.
---
 arch/x86/include/asm/pks.h |  2 ++
 arch/x86/mm/pkeys.c        |  6 +++-
 lib/pks/pks_test.c         | 74 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pks.h b/arch/x86/include/asm/pks.h
index 55541bb64d08..e09934c540e2 100644
--- a/arch/x86/include/asm/pks.h
+++ b/arch/x86/include/asm/pks.h
@@ -34,6 +34,8 @@ static inline bool pks_handle_key_fault(struct pt_regs *regs,
 
 bool pks_test_callback(struct pt_regs *regs);
 #define __static_or_pks_test
+bool pks_test_fault_callback(struct pt_regs *regs, unsigned long address,
+			     bool write);
 
 #else /* !CONFIG_PKS_TEST */
 
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 531cf6c74ad7..f30ac8215785 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -239,7 +239,11 @@ __static_or_pks_test DEFINE_PER_CPU(u32, pkrs_cache);
  *	#endif
  *	};
  */
-static const pks_key_callback pks_key_callbacks[PKS_KEY_NR_CONSUMERS] = { 0 };
+static const pks_key_callback pks_key_callbacks[PKS_KEY_NR_CONSUMERS] = {
+#ifdef CONFIG_PKS_TEST
+	[PKS_KEY_TEST]		= pks_test_fault_callback,
+#endif
+};
 
 static bool pks_call_fault_callback(struct pt_regs *regs, unsigned long address,
 				    bool write, u16 key)
diff --git a/lib/pks/pks_test.c b/lib/pks/pks_test.c
index 008a1079579d..1528df0bb283 100644
--- a/lib/pks/pks_test.c
+++ b/lib/pks/pks_test.c
@@ -19,6 +19,7 @@
  * * 3  Check the context armed in '2' to ensure the MSR value was preserved
  * * 4  Test that the exception thread PKRS remains independent of the
  *      interrupted threads PKRS
+ * * 5  Test setting a key to RD/WR in a fault callback to abandon a key
  * * 8  Loop through all CPUs, report the msr, and check against the default.
  * * 9  Set up and fault on a PKS protected page.
  *
@@ -56,6 +57,7 @@
 #define ARM_CTX_SWITCH		2
 #define CHECK_CTX_SWITCH	3
 #define RUN_EXCEPTION		4
+#define RUN_FAULT_ABANDON	5
 #define RUN_CRASH_TEST		9
 
 DECLARE_PER_CPU(u32, pkrs_cache);
@@ -519,6 +521,75 @@ static void check_ctx_switch(struct file *file)
 	}
 }
 
+struct {
+	struct pks_test_ctx *ctx;
+	void *test_page;
+	bool armed;
+	bool callback_seen;
+} fault_callback_ctx;
+
+bool pks_test_fault_callback(struct pt_regs *regs, unsigned long address,
+			     bool write)
+{
+	if (!fault_callback_ctx.armed)
+		return false;
+
+	fault_callback_ctx.armed = false;
+	fault_callback_ctx.callback_seen = true;
+
+	pks_update_exception(regs, fault_callback_ctx.ctx->pkey, 0);
+
+	return true;
+}
+
+static bool run_fault_clear_test(void)
+{
+	struct pks_test_ctx *ctx;
+	void *test_page;
+	bool rc = true;
+
+	ctx = alloc_ctx(PKS_KEY_TEST);
+	if (IS_ERR(ctx))
+		return false;
+
+	test_page = alloc_test_page(ctx->pkey);
+	if (!test_page) {
+		pr_err("Failed to vmalloc page???\n");
+		free_ctx(ctx);
+		return false;
+	}
+
+	test_armed_key = PKS_KEY_TEST;
+	fault_callback_ctx.ctx = ctx;
+	fault_callback_ctx.test_page = test_page;
+	fault_callback_ctx.armed = true;
+	fault_callback_ctx.callback_seen = false;
+
+	pks_mk_noaccess(test_armed_key);
+
+	/* fault */
+	memcpy(test_page, ctx->data, 8);
+
+	if (!fault_callback_ctx.callback_seen) {
+		pr_err("Failed to see the callback\n");
+		rc = false;
+		goto done;
+	}
+
+	/* no fault */
+	fault_callback_ctx.callback_seen = false;
+	memcpy(test_page, ctx->data, 8);
+
+	if (fault_caught() || fault_callback_ctx.callback_seen) {
+		pr_err("The key failed to be set RD/WR in the callback\n");
+		return false;
+	}
+
+done:
+	free_ctx(ctx);
+	return rc;
+}
+
 static ssize_t pks_read_file(struct file *file, char __user *user_buf,
 			     size_t count, loff_t *ppos)
 {
@@ -572,6 +643,9 @@ static ssize_t pks_write_file(struct file *file, const char __user *user_buf,
 	case RUN_EXCEPTION:
 		last_test_pass = run_exception_test();
 		break;
+	case RUN_FAULT_ABANDON:
+		last_test_pass = run_fault_clear_test();
+		break;
 	default:
 		last_test_pass = false;
 		break;
-- 
2.31.1

