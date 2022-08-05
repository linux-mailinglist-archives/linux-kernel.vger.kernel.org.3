Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B1D58AEED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241290AbiHERar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241224AbiHERae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:30:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B7AE090
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 10:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659720624; x=1691256624;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sRHTxQHs2LaOvIhv67s67Ysp5FgHFBpgDInzTG4TkTA=;
  b=AAfix122dcw8RKDOGoJe/RXu5j8L1hHmLzYd8603ATJVi/zC2MFlm48+
   h5PWoJNw8jfpOPf+5onaOhvBFj8ZBXUwWg1oB+dvjc4JTHqkxrXhq5SqF
   V7gJUistp0leuFH3hII8MH26COjoEvFl9GvpXcNqgZEE1MaDOrDZjYUZT
   kFVpQlW9ZVCIuU7z/WAjbzzqx898Gfp5+VgMnl6BLz1Ux8+PDnPJULjgG
   tqLKCuaIFhIrh0emMdXanjq7QX+7A98ZZdlUyRS/ZVH4x5qvVWx/f/vvH
   V1rw8B8JNZnhjL0GJXBhWeV/9I0pXh2OBewBTTFCZln5B8YUs9aLg92D6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="316144777"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="316144777"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 10:30:24 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="730067989"
Received: from amecham-mobl.amr.corp.intel.com (HELO localhost) ([10.255.0.242])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 10:30:22 -0700
From:   ira.weiny@intel.com
To:     Rik van Riel <riel@surriel.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 2/5] entry: Add calls for save/restore auxiliary pt_regs
Date:   Fri,  5 Aug 2022 10:30:06 -0700
Message-Id: <20220805173009.3128098-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220805173009.3128098-1-ira.weiny@intel.com>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Some architectures have auxiliary pt_regs space available to store
information on the stack during exceptions.  This information is easier
to obtain and store within C code rather than in arch specific assembly.

Define empty calls to architecture specific save and restore auxiliary
pt_regs functions.  Call these functions on generic entry/exit.

NOTE: Due to the split nature of the Xen exit code
irqentry_exit_cond_resched() requires an unbalanced call to
arch_restore_aux_pt_regs().

Cc: Rik van Riel <riel@surriel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Forward ported from PKS series
	https://lore.kernel.org/lkml/20220419170649.1022246-20-ira.weiny@intel.com/
---
 include/linux/entry-common.h |  8 ++++++++
 kernel/entry/common.c        | 16 ++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 976cce7cf803..1c09ba64ad28 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -79,6 +79,14 @@ static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs);
 static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs) {}
 #endif
 
+#ifndef arch_save_aux_pt_regs
+static inline void arch_save_aux_pt_regs(struct pt_regs *regs) { }
+#endif
+
+#ifndef arch_restore_aux_pt_regs
+static inline void arch_restore_aux_pt_regs(struct pt_regs *regs) { }
+#endif
+
 /**
  * enter_from_user_mode - Establish state when coming from user mode
  *
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 8c0f334c4b75..a70a0f314aee 100644
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
2.35.3

