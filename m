Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B811C507627
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356010AbiDSRMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355695AbiDSRKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:10:20 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86FC140F1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388049; x=1681924049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IUJvmUts7zoezDYr8j9Vo1UZam84ShRJ8gR0jPI62nQ=;
  b=Grn+tzGldlDzTKxNFqE4C/jSvWLyNkUCnahtaEhs5r+6tIryCo8emEHt
   ee9xPdlL2zTEC3MYT5M6KmFjGp2/0IIp/yrs4U+iQEmwjr53MMB+SjHCq
   NXI/ei0GNNGWPAI5fcJ4mQXCuaM81PVHBPJDs/OwPC/29MU70Il75LwDz
   dredc9DStJqQL71KrvwceeuAwNeceCNhsNlXf7uawdUFnMKz7gi006Mmb
   nb2m69XycC/BLlM00jl18Y9RQLT3+mzdArzF/bq6slUDbY2J6sCcU8pnp
   ERT1wDkwy+7a83FslX+4JEFAgm/jQPzcsJSU3MPUI+plFmhCa3XEWlitG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="324261565"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="324261565"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:29 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="554813731"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:28 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 44/44] mm/pkeys: PKS testing, add test for all keys
Date:   Tue, 19 Apr 2022 10:06:49 -0700
Message-Id: <20220419170649.1022246-45-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

To help test hardware and qemu it is necessary to be able to run through
all the available pkeys and run the access checks.  However, running
this test will conflict with normal PKS consumers.

Make a test, which is mutually exclusive from all other PKS consumers,
that loops through all the pkeys and tests the various access modes.

Update the documentation.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	Update commit message
	Create ENABLE_PKS_CONSUMER Kconfig to make this test mutually
		exclusive with any other pks consumer

Changes for V8
	Split this off from the large testing patch
	Remove debugging version
---
 Documentation/core-api/protection-keys.rst | 12 +++----
 arch/x86/mm/pkeys.c                        | 10 ++++++
 include/linux/pks-keys.h                   |  5 +++
 lib/Kconfig.debug                          | 21 +++++++++++
 lib/pks/pks_test.c                         | 41 +++++++++++++++++++++-
 mm/Kconfig                                 |  9 +++++
 tools/testing/selftests/x86/test_pks.c     |  5 ++-
 7 files changed, 95 insertions(+), 8 deletions(-)

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index d492ec194e2a..36621cbc2cc6 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -117,20 +117,20 @@ Kconfig
 -------
 
 Kernel users intending to use PKS support should depend on
-ARCH_HAS_SUPERVISOR_PKEYS, and select ARCH_ENABLE_SUPERVISOR_PKEYS to turn on
-this support within the core.  For example:
+ARCH_HAS_SUPERVISOR_PKEYS, and select ARCH_ENABLE_PKS_CONSUMER to turn on this
+support within the core.  For example:
 
 .. code-block:: c
 
         config MY_NEW_FEATURE
                 depends on ARCH_HAS_SUPERVISOR_PKEYS
-                select ARCH_ENABLE_SUPERVISOR_PKEYS
+                select ARCH_ENABLE_PKS_CONSUMER
 
 This will make "MY_NEW_FEATURE" unavailable unless the architecture sets
 ARCH_HAS_SUPERVISOR_PKEYS.  It also makes it possible for multiple independent
-features to "select ARCH_ENABLE_SUPERVISOR_PKEYS".  If no features enable PKS
-by selecting ARCH_ENABLE_SUPERVISOR_PKEYS, PKS support will not be compiled
-into the kernel.
+features to "select ARCH_ENABLE_PKS_CONSUMER".  If no features enable PKS by
+selecting ARCH_ENABLE_PKS_CONSUMER, PKS support will not be compiled into the
+kernel.
 
 PKS Key Allocation
 ------------------
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index ee5eff6bdbf3..74ba51b9853b 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -244,6 +244,8 @@ __static_or_pks_test DEFINE_PER_CPU(u32, pkrs_cache);
  *	#endif
  *	};
  */
+#ifndef CONFIG_PKS_TEST_ALL_KEYS
+
 static const pks_key_callback pks_key_callbacks[PKS_KEY_MAX] = {
 #ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
 	[PKS_KEY_PGMAP_PROTECTION]   = pgmap_pks_fault_callback,
@@ -253,6 +255,14 @@ static const pks_key_callback pks_key_callbacks[PKS_KEY_MAX] = {
 #endif
 };
 
+#else /* CONFIG_PKS_TEST_ALL_KEYS */
+
+static const pks_key_callback pks_key_callbacks[PKS_KEY_MAX] = {
+	[1 ... (PKS_KEY_MAX-1)]	= pks_test_fault_callback,
+};
+
+#endif
+
 static bool pks_call_fault_callback(struct pt_regs *regs, unsigned long address,
 				    bool write, u16 key)
 {
diff --git a/include/linux/pks-keys.h b/include/linux/pks-keys.h
index 380bc999cbe3..aef1cb3c0f7f 100644
--- a/include/linux/pks-keys.h
+++ b/include/linux/pks-keys.h
@@ -66,6 +66,11 @@
 					    CONFIG_PKS_TEST)
 #define PKS_KEY_MAX		PKS_NEW_KEY(PKS_KEY_TEST, 1)
 
+#ifdef CONFIG_PKS_TEST_ALL_KEYS
+#undef PKS_KEY_MAX
+#define PKS_KEY_MAX PKS_NUM_PKEYS
+#endif
+
 /* PKS_KEY_DEFAULT_INIT must be RW */
 #define PKS_KEY_DEFAULT_INIT	PKS_DECLARE_INIT_VALUE(PKS_KEY_DEFAULT, RW, 1)
 #define PKS_KEY_PGMAP_INIT	PKS_DECLARE_INIT_VALUE(PKS_KEY_PGMAP_PROTECTION, \
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7ac43b78c7bb..57a76c096ea7 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2758,6 +2758,12 @@ config HYPERV_TESTING
 	help
 	  Select this option to enable Hyper-V vmbus testing.
 
+# PKS_TEST is a special PKS consumer and therefore sets
+# ARCH_ENABLE_SUPERVISOR_PKEYS directly rather than through
+# ARCH_ENABLE_PKS_CONSUMER
+#
+# This allows PKS_TEST_ALL_KEYS to remain mutially exclusive to any real PKS
+# consumer
 config PKS_TEST
 	bool "PKey (S)upervisor testing"
 	depends on ARCH_HAS_SUPERVISOR_PKEYS
@@ -2770,6 +2776,21 @@ config PKS_TEST
 
 	  If unsure, say N.
 
+config PKS_TEST_ALL_KEYS
+	bool "PKS test all keys"
+	depends on (PKS_TEST && !ARCH_ENABLE_PKS_CONSUMER)
+	help
+	  Select this option to enable testing of all the PKS keys available in
+	  the architecture.  This option is mutually exclusive with PKS
+	  consumers other than PKS_TEST.  This is because it will consume all
+	  PKS keys for testing purposes.
+
+	  Answer N if you don't know what supervisor keys are or want to have
+	  supervisor keys available for other consumers.
+
+	  If unsure, say N.
+
+
 endmenu # "Kernel Testing and Coverage"
 
 source "Documentation/Kconfig"
diff --git a/lib/pks/pks_test.c b/lib/pks/pks_test.c
index a9cd2a49abfa..e38a487c7065 100644
--- a/lib/pks/pks_test.c
+++ b/lib/pks/pks_test.c
@@ -50,12 +50,12 @@
 #define CHECK_CTX_SWITCH	3
 #define RUN_EXCEPTION		4
 #define RUN_EXCEPTION_UPDATE	5
+#define RUN_ALL_KEYS		6
 #define RUN_CRASH_TEST		9
 
 DECLARE_PER_CPU(u32, pkrs_cache);
 
 static struct dentry *pks_test_dentry;
-
 DEFINE_MUTEX(test_run_lock);
 
 struct pks_test_ctx {
@@ -439,6 +439,39 @@ static bool run_exception_test(struct pks_session_data *sd)
 	return pass;
 }
 
+#ifdef CONFIG_PKS_TEST_ALL_KEYS
+
+static bool run_all_keys(void)
+{
+	struct pks_test_ctx *ctx[PKS_NUM_PKEYS];
+	static char name[PKS_NUM_PKEYS][64];
+	int i;
+	bool rc = true;
+
+	for (i = 1; i < PKS_NUM_PKEYS; i++) {
+		sprintf(name[i], "pks ctx %d", i);
+		ctx[i] = alloc_ctx(i);
+	}
+
+	for (i = 1; i < PKS_NUM_PKEYS; i++) {
+		pr_debug("Running pkey '%d'\n", i);
+		if (!IS_ERR(ctx[i])) {
+			/* sticky fail */
+			if (!test_ctx(ctx[i]))
+				rc = false;
+		}
+	}
+
+	for (i = 1; i < PKS_NUM_PKEYS; i++) {
+		if (!IS_ERR(ctx[i]))
+			free_ctx(ctx[i]);
+	}
+
+	return rc;
+}
+
+#endif
+
 static void crash_it(struct pks_session_data *sd)
 {
 	struct pks_test_ctx *ctx;
@@ -644,6 +677,12 @@ static ssize_t pks_write_file(struct file *file, const char __user *user_buf,
 		pr_debug("Fault clear test\n");
 		sd->last_test_pass = run_exception_update(file->private_data);
 		break;
+#ifdef CONFIG_PKS_TEST_ALL_KEYS
+	case RUN_ALL_KEYS:
+		pr_debug("Run all\n");
+		sd->last_test_pass = run_all_keys();
+		goto unlock_test;
+#endif
 	default:
 		pr_debug("Unknown test\n");
 		sd->last_test_pass = false;
diff --git a/mm/Kconfig b/mm/Kconfig
index 616baee3f62d..a25217f2729d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -842,6 +842,15 @@ config ARCH_HAS_PKEYS
 	bool
 config ARCH_HAS_SUPERVISOR_PKEYS
 	bool
+
+config ARCH_ENABLE_PKS_CONSUMER
+	select ARCH_ENABLE_SUPERVISOR_PKEYS
+	bool
+
+# WARNING Do not set ARCH_ENABLE_SUPERVISOR_PKEYS directly use
+# ARCH_ENABLE_PKS_CONSUMER instead.
+#
+# See the PKey (S)upervisor testing (PKS_TEST) config option for details.
 config ARCH_ENABLE_SUPERVISOR_PKEYS
 	bool
 
diff --git a/tools/testing/selftests/x86/test_pks.c b/tools/testing/selftests/x86/test_pks.c
index 194c9dd9a211..8ffe4596de1f 100644
--- a/tools/testing/selftests/x86/test_pks.c
+++ b/tools/testing/selftests/x86/test_pks.c
@@ -37,6 +37,7 @@
 #define CHECK_CTX_SWITCH	"3"
 #define RUN_EXCEPTION		"4"
 #define RUN_EXCEPTION_UPDATE	"5"
+#define RUN_ALL_KEYS		"6"
 #define RUN_CRASH_TEST		"9"
 
 time_t g_start_time;
@@ -65,6 +66,7 @@ enum {
 	TEST_CTX_SWITCH,
 	TEST_EXCEPTION,
 	TEST_FAULT_CALLBACK,
+	TEST_ALL,
 	MAX_TESTS,
 } tests;
 
@@ -80,7 +82,8 @@ struct test_item {
 	{ "single", RUN_SINGLE, do_simple_test },
 	{ "context_switch", ARM_CTX_SWITCH, do_context_switch },
 	{ "exception", RUN_EXCEPTION, do_simple_test },
-	{ "exception_update", RUN_EXCEPTION_UPDATE, do_simple_test }
+	{ "exception_update", RUN_EXCEPTION_UPDATE, do_simple_test },
+	{ "run_all", RUN_ALL_KEYS, do_simple_test }
 };
 
 static char *get_test_name(int test_num)
-- 
2.35.1

