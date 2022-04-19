Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71555507635
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355974AbiDSRLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355708AbiDSRKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:10:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6069C13FBC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388048; x=1681924048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4R0sbFwDC9eNw8IsKBweMZJr5Tuj6Z2ytY+njPqpWC4=;
  b=JWsqe3L+RRPax9le7xJAd7lgcJFcPleDCdr+90KUMt8f2s/C1XZRDmxg
   wisVzRfDy9Ui2JqEZgob0P60bh2RXyoXp8O6siQ7y14l5q8/fn7iewOoQ
   VD63FPDp4cratglSOUfScSikkWGrUPP/P0Sbn+8R6aLDwprrtz9j7xnKC
   FTMI/mDuxYFXQMIARkF+nDqunTg9dhYgwm4ysRHQP4SvBmvOuRRuofjDN
   I9/ZpdRqlgD48ks8LTs+RgoFmfFlXD4iJNUkGHrP9phD9zy9cZvoj71/7
   4r7gAg0humkou/WwaQE63f9O7cfmKQSFiJNS1Jnip2guDowQqE0tR+w6g
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="262677124"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="262677124"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:28 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="529397394"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:27 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 43/44] mm/pkeys: PKS testing, test pks_update_exception()
Date:   Tue, 19 Apr 2022 10:06:48 -0700
Message-Id: <20220419170649.1022246-44-ira.weiny@intel.com>
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
index c40035803e38..194c9dd9a211 100644
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

