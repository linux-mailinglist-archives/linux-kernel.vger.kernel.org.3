Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343474D5043
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245017AbiCJRXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244637AbiCJRW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:22:26 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B15C199E2C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932880; x=1678468880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qwhD7MYd+5vjkJjSbQ7ZP+K6ASyttkvB2aN1EyDG9yc=;
  b=ZKnUboXumX6zRoBcCD/RdACHP9SQbk5t/287AzYMKdl2gnasPG1HS4/D
   6z3MoieGOzX3TqKVnIgpJZoifz7jRUabopaT5IYVTpcqiEMR9jaby1xdU
   pUCfvgWWYxOD8ER5FDuAliv7ziVcmFnbcq40ZgKCSHMSYEk5Jr8MzPUF7
   HMtB+T1SZwj2/uwdLKLrgBKbcnhUuAj7KIDPgDjLYhKSzMRv24RbGFkp1
   cNxwKUJdrKdTbb6ep+Ravh5uCSaFR8ZR/mdjgVSCh0jdGiHlWzVX1sLJn
   hxUHg3W+1uvaoyjjPsHneY3Vo+4qXfRxyxzFX3Ib8+loz6yFYDSlfTtBc
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="318536495"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="318536495"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:19 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="548091166"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:18 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 24/45] entry: Split up irqentry_exit_cond_resched()
Date:   Thu, 10 Mar 2022 09:19:58 -0800
Message-Id: <20220310172019.850939-25-ira.weiny@intel.com>
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

Auxiliary pt_regs space needs to be manipulated by the generic
entry/exit code.

Normally irqentry_exit() would take care of handling any auxiliary
pt_regs on exit.  Unfortunately, the call to
irqentry_exit_cond_resched() from xen_pv_evtchn_do_upcall() bypasses the
normal irqentry_exit() call.  Because of this bypass
irqentry_exit_cond_resched() will be required to handle any auxiliary
pt_regs exit handling.  However, this prevents irqentry_exit() from
being able to call irqentry_exit_cond_resched() and while maintaining
control of the auxiliary pt_regs.

Separate out the common functionality of irqentry_exit_cond_resched() so
that functionality can be used by irqentry_exit().  Add a pt_regs
parameter in anticipation of having irqentry_exit_cond_resched() handle
the auxiliary pt_regs separately from irqentry_exit().

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	Update commit message

Changes for V8
	New Patch
---
 arch/x86/entry/common.c      | 2 +-
 include/linux/entry-common.h | 3 ++-
 kernel/entry/common.c        | 9 +++++++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6c2826417b33..f1ba770d035d 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -309,7 +309,7 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 
 	inhcall = get_and_clear_inhcall();
 	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
-		irqentry_exit_cond_resched();
+		irqentry_exit_cond_resched(regs);
 		instrumentation_end();
 		restore_inhcall(inhcall);
 	} else {
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index ddaffc983e62..14fd329847e7 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -451,10 +451,11 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
 
 /**
  * irqentry_exit_cond_resched - Conditionally reschedule on return from interrupt
+ * @regs:	Pointer to pt_regs of interrupted context
  *
  * Conditional reschedule with additional sanity checks.
  */
-void irqentry_exit_cond_resched(void);
+void irqentry_exit_cond_resched(struct pt_regs *regs);
 
 void __irqentry_exit_cond_resched(void);
 #ifdef CONFIG_PREEMPT_DYNAMIC
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 490442a48332..f4210a7fc84d 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -395,7 +395,7 @@ void __irqentry_exit_cond_resched(void)
 DEFINE_STATIC_CALL(__irqentry_exit_cond_resched, __irqentry_exit_cond_resched);
 #endif
 
-void irqentry_exit_cond_resched(void)
+static void exit_cond_resched(void)
 {
 	if (IS_ENABLED(CONFIG_PREEMPTION)) {
 #ifdef CONFIG_PREEMPT_DYNAMIC
@@ -406,6 +406,11 @@ void irqentry_exit_cond_resched(void)
 	}
 }
 
+void irqentry_exit_cond_resched(struct pt_regs *regs)
+{
+	exit_cond_resched();
+}
+
 noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 {
 	lockdep_assert_irqs_disabled();
@@ -431,7 +436,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 		}
 
 		instrumentation_begin();
-		irqentry_exit_cond_resched();
+		exit_cond_resched();
 		/* Covers both tracing and lockdep */
 		trace_hardirqs_on();
 		instrumentation_end();
-- 
2.35.1

