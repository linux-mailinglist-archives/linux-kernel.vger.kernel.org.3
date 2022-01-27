Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FEA49E96E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245017AbiA0R4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:56:16 -0500
Received: from mga02.intel.com ([134.134.136.20]:19415 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244846AbiA0RzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306125; x=1674842125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IgMfD3EDPqux6N7a9kZjEZreZVxB0l9Epm9jhn3105k=;
  b=YUdbiuUELgzJ9uEoxR5Z07p9EQeV19TmBQNS6bxIFnNJSgW6BoE1hpda
   Kf211LKBOozwxKyr1Iq/h8bH039vw6OzScZIBdt2D1AmSzTe3axNkfs4W
   FwOr3LD2Qa1PPifhdTvp2p+kRMqwnGpwXvszBf+ZlJNWmDnSDDEjA4Tpk
   iJvtKkCNTDONdyzm6Td0EjTvi3sIFg317hcPpDuOKgZcLfNNjdlrJYU4e
   hGfEsv+PSTREG1VtN/ojE+FZzmTLPp8uErT1DBnZLlbCR8i99H5f7vEBq
   8ECOOpwkz0ImnChIfGfY9Xt5qF9P8nSrIMOGfEyBNtbiicjEs6sY6cwbM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="234302436"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="234302436"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796130"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:10 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 23/44] entry: Add architecture auxiliary pt_regs save/restore calls
Date:   Thu, 27 Jan 2022 09:54:44 -0800
Message-Id: <20220127175505.851391-24-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Some architectures have auxiliary pt_regs space which is available to
store extra information on the stack.  For ease of implementation the
common C code was left to fill in the data when needed.

Define C calls for architectures to save and restore any auxiliary data
they may need and call those from the common entry code.

NOTE: Due to the split nature of the Xen exit code
irqentry_exit_cond_resched() requires an unbalanced call to
arch_restore_aux_pt_regs() regardless of the nature of the preemption
configuration.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
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
2.31.1

