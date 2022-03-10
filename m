Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506D54D5046
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244873AbiCJRY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245008AbiCJRXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:23:00 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E34919CCE8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932907; x=1678468907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wDzy7/RxYYla9YQcCGWvWwhXgP+kSYMWIjEIrYoEqH4=;
  b=JBgHT1ygOpimoYGEBoEaZaLErJWIYwqrHaTbkj09FHYYV2qCcm0GQWOj
   nfnDkWAeL6XVlSNlQ/9aKRHkZ0gL/0tCxjGz4gOfaxpmaNBe8GQVupE3z
   dfdw5dyW1agJ+Q7QsDIs9s1yP35o1OQOeUqKq9qvrb52gWmywaWyfnH84
   dZ/pp8e5jMNJeq0FOK6QTK6b3IYVkWdVFAMNIutVzwuOE5y651Tgsxlg8
   YQUR0RsgV1JBjHLICFbwcyyP527AzWQEqA2TQ6bbGSKE7F76y98Bl8JSi
   KBf/2kNoiK+06scGjOuKeASvNzuBwmooap/MKvGHvTPVuCn1lkZMec66C
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="255505014"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="255505014"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:21 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="688732500"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:21 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 25/45] entry: Add calls for save/restore auxiliary pt_regs
Date:   Thu, 10 Mar 2022 09:19:59 -0800
Message-Id: <20220310172019.850939-26-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310172019.850939-1-ira.weiny@intel.com>
References: <20220310172019.850939-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Some architectures have auxiliary pt_regs space which is available to
store extra information on the stack.  For ease of implementation the
common C code was left to fill in the data when needed.

Add calls to the architecture save and restore auxiliary pt_regs
functions.  Define empty calls for any architecture which does not have
auxiliary pt_regs.

NOTE: Due to the split nature of the Xen exit code
irqentry_exit_cond_resched() requires an unbalanced call to
arch_restore_aux_pt_regs() regardless of the nature of the preemption
configuration.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	Update commit message

Changes for V8
	New patch which introduces a generic auxiliary pt_register save
		restore.
---
 include/linux/entry-common.h |  7 +++++++
 kernel/entry/common.c        | 16 ++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 14fd329847e7..b243f1cfd491 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -99,6 +99,13 @@ static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs
 }
 #endif
 
+#ifndef CONFIG_ARCH_HAS_PTREGS_AUXILIARY
+
+static inline void arch_save_aux_pt_regs(struct pt_regs *regs) { }
+static inline void arch_restore_aux_pt_regs(struct pt_regs *regs) { }
+
+#endif
+
 /**
  * enter_from_user_mode - Establish state when coming from user mode
  *
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index f4210a7fc84d..c778e9783361 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -323,7 +323,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
-		return ret;
+		goto aux_save;
 	}
 
 	/*
@@ -362,7 +362,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 		instrumentation_end();
 
 		ret.exit_rcu = true;
-		return ret;
+		goto aux_save;
 	}
 
 	/*
@@ -377,6 +377,11 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	trace_hardirqs_off_finish();
 	instrumentation_end();
 
+aux_save:
+	instrumentation_begin();
+	arch_save_aux_pt_regs(regs);
+	instrumentation_end();
+
 	return ret;
 }
 
@@ -408,6 +413,7 @@ static void exit_cond_resched(void)
 
 void irqentry_exit_cond_resched(struct pt_regs *regs)
 {
+	arch_restore_aux_pt_regs(regs);
 	exit_cond_resched();
 }
 
@@ -415,6 +421,10 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 {
 	lockdep_assert_irqs_disabled();
 
+	instrumentation_begin();
+	arch_restore_aux_pt_regs(regs);
+	instrumentation_end();
+
 	/* Check whether this returns to user mode */
 	if (user_mode(regs)) {
 		irqentry_exit_to_user_mode(regs);
@@ -464,6 +474,7 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
 	instrumentation_begin();
 	trace_hardirqs_off_finish();
 	ftrace_nmi_enter();
+	arch_save_aux_pt_regs(regs);
 	instrumentation_end();
 
 	return irq_state;
@@ -472,6 +483,7 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
 void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state)
 {
 	instrumentation_begin();
+	arch_restore_aux_pt_regs(regs);
 	ftrace_nmi_exit();
 	if (irq_state.lockdep) {
 		trace_hardirqs_on_prepare();
-- 
2.35.1

