Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF403507633
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355882AbiDSRKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355612AbiDSRJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:09:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8141138
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388027; x=1681924027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OvMcHVtcJvbvw4mAw0A77nXekx1g9G9EavzzKuKHygk=;
  b=Xq2FZQgRlEaUq802TILiJZkv3LWUVXlGahX/6kNiur3gGsQJMo6jHfYZ
   U1jgJaPN17hbukbFPWVXM3Gn+kpJL1KfoCpMNyE87H+q8W3dc/9EK8sXi
   EV3uL9E70blmmRV4mVgFUmKZwyLLSX3w/CTlFKowklaR+/VSQHwWnok+h
   N7HeXfjhBQcQo4a61+bgufgx6zhX4X8QOOi/L7hz+s4Lh9+PY+7fhF3RJ
   bXna2kf9y0kpl4z04UEZrqky6ZqaZrXnRJcGiorZKdF2jJVrkckYHTLfz
   BH+yxkxumA1Zi46nRR+sonXhmM88jqWbhOp2PWila7aAn9No7LxY+KBw1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="263991849"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="263991849"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="861588499"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:06 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 19/44] entry: Add calls for save/restore auxiliary pt_regs
Date:   Tue, 19 Apr 2022 10:06:24 -0700
Message-Id: <20220419170649.1022246-20-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
arch_restore_aux_pt_regs().

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
index f35086d2a258..15b35ca937f2 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -79,6 +79,13 @@ static __always_inline void arch_check_user_regs(struct pt_regs *regs);
 static __always_inline void arch_check_user_regs(struct pt_regs *regs) {}
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
index 8f73b54bfa56..9a02b517c7e7 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -317,7 +317,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
-		return ret;
+		goto aux_save;
 	}
 
 	/*
@@ -356,7 +356,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 		instrumentation_end();
 
 		ret.exit_rcu = true;
-		return ret;
+		goto aux_save;
 	}
 
 	/*
@@ -371,6 +371,11 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	trace_hardirqs_off_finish();
 	instrumentation_end();
 
+aux_save:
+	instrumentation_begin();
+	arch_save_aux_pt_regs(regs);
+	instrumentation_end();
+
 	return ret;
 }
 
@@ -401,6 +406,7 @@ void dynamic_irqentry_exit_cond_resched(void)
 
 void irqentry_exit_cond_resched(struct pt_regs *regs)
 {
+	arch_restore_aux_pt_regs(regs);
 	irqentry_exit_cond_resched_internal();
 }
 
@@ -408,6 +414,10 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 {
 	lockdep_assert_irqs_disabled();
 
+	instrumentation_begin();
+	arch_restore_aux_pt_regs(regs);
+	instrumentation_end();
+
 	/* Check whether this returns to user mode */
 	if (user_mode(regs)) {
 		irqentry_exit_to_user_mode(regs);
@@ -459,6 +469,7 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
 	instrumentation_begin();
 	trace_hardirqs_off_finish();
 	ftrace_nmi_enter();
+	arch_save_aux_pt_regs(regs);
 	instrumentation_end();
 
 	return irq_state;
@@ -467,6 +478,7 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
 void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state)
 {
 	instrumentation_begin();
+	arch_restore_aux_pt_regs(regs);
 	ftrace_nmi_exit();
 	if (irq_state.lockdep) {
 		trace_hardirqs_on_prepare();
-- 
2.35.1

