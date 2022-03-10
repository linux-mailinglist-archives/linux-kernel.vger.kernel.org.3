Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00ED34D503D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbiCJRYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244831AbiCJRW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:22:56 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB3919ABDE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932895; x=1678468895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QlTkIgIhiIzc3uQSiVUkyB0V8d07IE5gyCKmkeHVRFM=;
  b=Mr8s8Y/Eg2pVS0g/oNui3a13qUXBB0SDJDLCEAZySqygFzv904IbcXYm
   9VGKsp4deQ/dXiHv2pskCGJFDiGNspdFA026ho6rA1tK5ft2SwJtKKnMO
   lPckFwku9utSPg5xaB6x0zNwtmec45qScqnzGlm+lIG9QQlC5WOzXVflf
   3oV83W+zfjLRPwSl77rW5//F9N4JDowvagOWhQ9MfrWXAUytS8bfSZFbK
   UGwgpbCiiFfsEJdeWbFIRaGwcF8zodSvntFwjqhXN810/aF0Z83LoyoOH
   OX+Szux3HZZ/mb9JL7Iw6yRwRG9wRdDiDWzXWRH5+rV3eXzppTmPeLHez
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="255260134"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="255260134"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:35 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="644525779"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:34 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 31/45] mm/pkeys: PKS testing, test pks_update_exception()
Date:   Thu, 10 Mar 2022 09:20:05 -0800
Message-Id: <20220310172019.850939-32-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310172019.850939-1-ira.weiny@intel.com>
References: <20220310172019.850939-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

A common use case for the custom fault callbacks will be for the
callback to warn of the violation and relax the permissions rather than
crash the kernel.  pks_update_exception() was added for this purpose.

Add a test which uses pks_update_exception() to clear the pkey
permissions.  Verify that the permissions are changed in the interrupted
thread.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	Update the commit message
	Clean up test name
	Add test_pks support
	s/pks_mk_*/pks_set_*/
	Simplify the use of globals for the faults
	From Rick Edgecombe
		Use WRITE_ONCE to protect against races with the fault
		handler
		s/RUN_FAULT_ABANDON/RUN_FAULT_CALLBACK

Changes for V8
	New test developed just to double check for regressions while
	reworking the code.
---
 lib/pks/pks_test.c                     | 60 ++++++++++++++++++++++++++
 tools/testing/selftests/x86/test_pks.c |  5 ++-
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/lib/pks/pks_test.c b/lib/pks/pks_test.c
index 762f4a19cb7d..a9cd2a49abfa 100644
--- a/lib/pks/pks_test.c
+++ b/lib/pks/pks_test.c
@@ -49,6 +49,7 @@
 #define ARM_CTX_SWITCH		2
 #define CHECK_CTX_SWITCH	3
 #define RUN_EXCEPTION		4
+#define RUN_EXCEPTION_UPDATE	5
 #define RUN_CRASH_TEST		9
 
 DECLARE_PER_CPU(u32, pkrs_cache);
@@ -64,6 +65,7 @@ struct pks_test_ctx {
 	void *test_page;
 	bool fault_seen;
 	bool validate_exp_handling;
+	bool validate_update_exp;
 };
 
 static bool check_pkey_val(u32 pk_reg, u8 pkey, u32 expected)
@@ -164,6 +166,16 @@ static void validate_exception(struct pks_test_ctx *ctx, u32 thread_pkrs)
 	}
 }
 
+static bool handle_update_exception(struct pt_regs *regs, struct pks_test_ctx *ctx)
+{
+	pr_debug("Updating pkey %d during exception\n", ctx->pkey);
+
+	ctx->fault_seen = true;
+	pks_update_exception(regs, ctx->pkey, 0);
+
+	return true;
+}
+
 /* Global data protected by test_run_lock */
 struct pks_test_ctx *g_ctx_under_test;
 
@@ -190,6 +202,9 @@ bool pks_test_fault_callback(struct pt_regs *regs, unsigned long address,
 	if (!g_ctx_under_test)
 		return false;
 
+	if (g_ctx_under_test->validate_update_exp)
+		return handle_update_exception(regs, g_ctx_under_test);
+
 	if (g_ctx_under_test->validate_exp_handling) {
 		validate_exception(g_ctx_under_test, pkrs);
 		/*
@@ -518,6 +533,47 @@ static void check_ctx_switch(struct pks_session_data *sd)
 	}
 }
 
+static bool run_exception_update(struct pks_session_data *sd)
+{
+	struct pks_test_ctx *ctx;
+
+	ctx = alloc_ctx(PKS_KEY_TEST);
+	if (IS_ERR(ctx))
+		return false;
+
+	set_ctx_data(sd, ctx);
+
+	ctx->fault_seen = false;
+	ctx->validate_update_exp = true;
+	pks_set_noaccess(ctx->pkey);
+
+	set_context_for_fault(ctx);
+
+	/* fault */
+	memcpy(ctx->test_page, ctx->data, 8);
+
+	if (!ctx->fault_seen) {
+		pr_err("Failed to see the callback\n");
+		return false;
+	}
+
+	ctx->fault_seen = false;
+	ctx->validate_update_exp = false;
+
+	set_context_for_fault(ctx);
+
+	/* no fault */
+	memcpy(ctx->test_page, ctx->data, 8);
+
+	if (ctx->fault_seen) {
+		pr_err("Pkey %d failed to be set RD/WR in the callback\n",
+			ctx->pkey);
+		return false;
+	}
+
+	return true;
+}
+
 static ssize_t pks_read_file(struct file *file, char __user *user_buf,
 			     size_t count, loff_t *ppos)
 {
@@ -584,6 +640,10 @@ static ssize_t pks_write_file(struct file *file, const char __user *user_buf,
 		pr_debug("Exception checking\n");
 		sd->last_test_pass = run_exception_test(file->private_data);
 		break;
+	case RUN_EXCEPTION_UPDATE:
+		pr_debug("Fault clear test\n");
+		sd->last_test_pass = run_exception_update(file->private_data);
+		break;
 	default:
 		pr_debug("Unknown test\n");
 		sd->last_test_pass = false;
diff --git a/tools/testing/selftests/x86/test_pks.c b/tools/testing/selftests/x86/test_pks.c
index 817df7a14923..243347e48228 100644
--- a/tools/testing/selftests/x86/test_pks.c
+++ b/tools/testing/selftests/x86/test_pks.c
@@ -36,6 +36,7 @@
 #define ARM_CTX_SWITCH		"2"
 #define CHECK_CTX_SWITCH	"3"
 #define RUN_EXCEPTION		"4"
+#define RUN_EXCEPTION_UPDATE	"5"
 #define RUN_CRASH_TEST		"9"
 
 time_t g_start_time;
@@ -63,6 +64,7 @@ enum {
 	TEST_SINGLE,
 	TEST_CTX_SWITCH,
 	TEST_EXCEPTION,
+	TEST_FAULT_CALLBACK,
 	MAX_TESTS,
 } tests;
 
@@ -77,7 +79,8 @@ struct test_item {
 	{ "check_defaults", CHECK_DEFAULTS, do_simple_test },
 	{ "single", RUN_SINGLE, do_simple_test },
 	{ "context_switch", ARM_CTX_SWITCH, do_context_switch },
-	{ "exception", RUN_EXCEPTION, do_simple_test }
+	{ "exception", RUN_EXCEPTION, do_simple_test },
+	{ "exception_update", RUN_EXCEPTION_UPDATE, do_simple_test }
 };
 
 static char *get_test_name(int test_num)
-- 
2.35.1

