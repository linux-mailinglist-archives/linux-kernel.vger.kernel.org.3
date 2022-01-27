Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB9849E961
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244934AbiA0Rzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:55:38 -0500
Received: from mga02.intel.com ([134.134.136.20]:19418 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244595AbiA0RzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306116; x=1674842116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VICanE3l/b6iqPaX50y8ZrxI7HlwV5bcXzfijwPRQ+0=;
  b=nkaehdo6cmmhiXDcfzoQxfMFne9yU3XidQsbX1vZk+Y1bJ0m+0AuqkH4
   21iJU7q1jisEsuUF/vggxI+b3hh9zLO4p5hqI5XIVJevuIMbWTNxwKMlW
   3StAHWF6bhY+lvelDxKxCmXCxZpdkuze5s9+DFyUmH+qjGclM5+22tC0c
   fwna/I11Rf+1QmvFvF1V0IkC/ECZU5OshgoMr3aidWdJUzks1oN5Cipyy
   EHC2Ezl4TMAAX6onw8lqYZ/RCyCpvIzq/TFfPnQYUeRSkMVcw5iUYhhIA
   xZySRySjohMJNVT2YPaRE9B1eA+UyVGZyEcAesyExnjsdFQZVMXnTJjY1
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="234302430"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="234302430"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796111"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:10 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 19/44] mm/pkeys: PKS Testing, add pks_mk_*() tests
Date:   Thu, 27 Jan 2022 09:54:40 -0800
Message-Id: <20220127175505.851391-20-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Create a test which runs through both read and writes on each of the 2
modes a PKS pkey can be set to, no access and read write.

First fill out pks_test_callback() to track fault count and make the
test key read write to ensure the fault does not trigger again.

Second verify that the pkey was properly set in the PTE.

Then add the test itself which iterates each of the test cases.

	PKS_TEST_NO_ACCESS,	WRITE,	FAULT_EXPECTED
	PKS_TEST_NO_ACCESS,	READ,	FAULT_EXPECTED

	PKS_TEST_RDWR,		WRITE,	NO_FAULT_EXPECTED
	PKS_TEST_RDWR,		READ,	NO_FAULT_EXPECTED

Finally add pks_mk_noaccess() at the end of the test and in the crash
test to ensure that the pkey value is reset to the default at the
appropriate times.

Add documentation.

Operation from user space is simple:

	$ echo 1 > /sys/kernel/debug/x86/run_pks
	$ cat /sys/kernel/debug/x86/run_pks
	PASS

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V8
	Remove readonly test, as that patch is not needed for PMEM
	Split this off into a patch which follows the pks_mk_*()
		patches.  Thus allowing for a better view of how the
		test works compared to the functionality added with
		those patches.
	Remove unneeded prints
---
 lib/pks/pks_test.c | 168 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 167 insertions(+), 1 deletion(-)

diff --git a/lib/pks/pks_test.c b/lib/pks/pks_test.c
index d84ab6e7a09c..fad9b996562a 100644
--- a/lib/pks/pks_test.c
+++ b/lib/pks/pks_test.c
@@ -14,6 +14,8 @@
  * where X is:
  *
  * * 0  Loop through all CPUs, report the msr, and check against the default.
+ * * 1  Allocate a single key and check all 3 permissions on a page.
+ * * 8  Loop through all CPUs, report the msr, and check against the default.
  * * 9  Set up and fault on a PKS protected page.
  *
  * NOTE: 9 will fault on purpose.  Therefore, it requires the option to be
@@ -32,15 +34,21 @@
 #include <linux/vmalloc.h>
 #include <linux/pkeys.h>
 
+#include <asm/pks.h>
+
 #define PKS_TEST_MEM_SIZE (PAGE_SIZE)
 
 #define CHECK_DEFAULTS		0
+#define RUN_SINGLE		1
 #define RUN_CRASH_TEST		9
 
 static struct dentry *pks_test_dentry;
 static bool crash_armed;
 
 static bool last_test_pass;
+static int test_armed_key;
+static int fault_cnt;
+static int prev_fault_cnt;
 
 struct pks_test_ctx {
 	int pkey;
@@ -56,7 +64,102 @@ struct pks_test_ctx {
  */
 bool pks_test_callback(void)
 {
-	return false;
+	bool armed = (test_armed_key != 0);
+
+	if (armed) {
+		pks_mk_readwrite(test_armed_key);
+		fault_cnt++;
+	}
+
+	return armed;
+}
+
+static bool fault_caught(void)
+{
+	bool ret = (fault_cnt != prev_fault_cnt);
+
+	prev_fault_cnt = fault_cnt;
+	return ret;
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
+	default:
+		pr_err("BUG in test invalid mode\n");
+		break;
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
+	bool fault;
+
+	switch (test->mode) {
+	case PKS_TEST_NO_ACCESS:
+		pks_mk_noaccess(ctx->pkey);
+		break;
+	case PKS_TEST_RDWR:
+		pks_mk_readwrite(ctx->pkey);
+		break;
+	default:
+		pr_err("BUG in test invalid mode\n");
+		return false;
+	}
+
+	WRITE_ONCE(test_armed_key, ctx->pkey);
+
+	if (test->write)
+		memcpy(ptr, ctx->data, 8);
+	else
+		memcpy(ctx->data, ptr, 8);
+
+	fault = fault_caught();
+
+	WRITE_ONCE(test_armed_key, 0);
+
+	if (test->fault != fault) {
+		pr_err("pkey test FAILED: mode %s; write %s; fault %s != %s\n",
+			get_mode_str(test->mode),
+			test->write ? "TRUE" : "FALSE",
+			test->fault ? "YES" : "NO",
+			fault ? "YES" : "NO");
+		return false;
+	}
+
+	return true;
 }
 
 static void *alloc_test_page(int pkey)
@@ -66,6 +169,48 @@ static void *alloc_test_page(int pkey)
 				    NUMA_NO_NODE, __builtin_return_address(0));
 }
 
+static bool test_ctx(struct pks_test_ctx *ctx)
+{
+	bool rc = true;
+	int i;
+	u8 pkey;
+	void *ptr = NULL;
+	pte_t *ptep = NULL;
+	unsigned int level;
+
+	ptr = alloc_test_page(ctx->pkey);
+	if (!ptr) {
+		pr_err("Failed to vmalloc page???\n");
+		return false;
+	}
+
+	ptep = lookup_address((unsigned long)ptr, &level);
+	if (!ptep) {
+		pr_err("Failed to lookup address???\n");
+		rc = false;
+		goto done;
+	}
+
+	pkey = pte_flags_pkey(ptep->pte);
+	if (pkey != ctx->pkey) {
+		pr_err("invalid pkey found: %u, test_pkey: %u\n",
+			pkey, ctx->pkey);
+		rc = false;
+		goto done;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(pkey_test_ary); i++) {
+		/* sticky fail */
+		if (!run_access_test(ctx, &pkey_test_ary[i], ptr))
+			rc = false;
+	}
+
+done:
+	vfree(ptr);
+
+	return rc;
+}
+
 static struct pks_test_ctx *alloc_ctx(u8 pkey)
 {
 	struct pks_test_ctx *ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
@@ -85,6 +230,22 @@ static void free_ctx(struct pks_test_ctx *ctx)
 	kfree(ctx);
 }
 
+static bool run_single(void)
+{
+	struct pks_test_ctx *ctx;
+	bool rc;
+
+	ctx = alloc_ctx(PKS_KEY_TEST);
+	if (IS_ERR(ctx))
+		return false;
+
+	rc = test_ctx(ctx);
+	pks_mk_noaccess(ctx->pkey);
+	free_ctx(ctx);
+
+	return rc;
+}
+
 static void crash_it(void)
 {
 	struct pks_test_ctx *ctx;
@@ -104,6 +265,8 @@ static void crash_it(void)
 		return;
 	}
 
+	pks_mk_noaccess(ctx->pkey);
+
 	/* This purposely faults */
 	memcpy(ptr, ctx->data, 8);
 
@@ -185,6 +348,9 @@ static ssize_t pks_write_file(struct file *file, const char __user *user_buf,
 	case CHECK_DEFAULTS:
 		on_each_cpu(check_pkey_settings, NULL, 1);
 		break;
+	case RUN_SINGLE:
+		last_test_pass = run_single();
+		break;
 	default:
 		last_test_pass = false;
 		break;
-- 
2.31.1

