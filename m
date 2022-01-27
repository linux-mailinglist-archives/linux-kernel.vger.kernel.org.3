Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A0549E968
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244933AbiA0R4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:56:00 -0500
Received: from mga02.intel.com ([134.134.136.20]:19418 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244829AbiA0RzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306124; x=1674842124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XJw9MAUdxudZN0wWW0EtiDX6K6ENUNzmSElBKkroX8w=;
  b=edFXZ851E/Z2PnHTgY26jZjl2Yn27toUhBSBkoT0zEgOIqOts1+CAE7R
   guMbzLUBFqUccbjuHf/hqlGYX4T4+rLB3xrrmIXLEdojNEPmcgUnaNsp4
   A2Jw1rD7U75+PXdkVY4jOSVm+QF49F/GoE8GXSHFJF4ipf1I5eLYuCVxe
   LR2B34PaVrmK7tCal0bfMPiE7uY9QEpH/C9bceTSyNSjK8AcrsJZZI3Jc
   tqQu0Bpv9Gb22B7qb4neI+idS0OVP0Gi9AWFK0Jx/55rM+Uum9ctgUI7/
   wn3l+EYOEaIKvXNE0nzgMjVmiOPDI8MHGL6cDVb8bgu9G2OtWlAi5xsYs
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="234302435"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="234302435"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796124"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:10 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 22/44] entry: Pass pt_regs to irqentry_exit_cond_resched()
Date:   Thu, 27 Jan 2022 09:54:43 -0800
Message-Id: <20220127175505.851391-23-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Auxiliary pt_regs space needs to be manipulated by the generic
entry/exit code.

Unfortunately, the call to irqentry_exit_cond_resched() from
xen_pv_evtchn_do_upcall() bypasses the 'normal' irqentry_exit() call.

Normally the irqentry_exit() would take care of handling any auxiliary
pt_regs but because of this bypass irqentry_exit_cond_resched() is
required to handle it.

Add pt_regs to irqentry_exit_cond_resched() so that any auxiliary
pt_regs data can be handled.

Create an internal exit_cond_resched() call for irqentry_exit() to avoid
passing pt_regs because irqentry_exit() will directly handle any
auxiliary pt_regs data.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
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
2.31.1

