Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EF558AEF2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241349AbiHERbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241318AbiHERah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:30:37 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A051DA45
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 10:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659720630; x=1691256630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iUggmBbv/Gb/pP6+Y41ZS7OmaZpg2F4gACjroqSJRII=;
  b=Dwf8tOHyzbEVprbqAc9GRqWsYyOXda4W7shOayppfpqjLZYrT6ojQ0MH
   qKuVwoa8rGH+hEYVL9gV5vPA6LgYi8GPmzKVNYGZIQ0FQhUNiADH1VUCc
   wCXO7f6B5IYnXNd4cOQeDqq2V3yRsxwAQbYD24vHRk1Mua7wJzh2xLu4S
   9hlfEEgaQ1vSErUCiB5finiUBy3pnwSkri94qckClO8fU8wQMS225IkAf
   Vo7BPpZxjInrXxH651zKd7Sb4VqAvw9FhdclyMeNpKV4MFNG5VVjGKgdd
   eFyAaok4nJ9QGjNG+K1c/i3PBTLzHMEyeyCQT6IRgbgiYM8t2k1vNttwC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="316144805"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="316144805"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 10:30:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="636565369"
Received: from amecham-mobl.amr.corp.intel.com (HELO localhost) ([10.255.0.242])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 10:30:28 -0700
From:   ira.weiny@intel.com
To:     Rik van Riel <riel@surriel.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 5/5] x86/entry: Store CPU info on exception entry
Date:   Fri,  5 Aug 2022 10:30:09 -0700
Message-Id: <20220805173009.3128098-6-ira.weiny@intel.com>
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

The CPU information of an exception is useful in determining where bad
CPUs are in a large data center.

Define arch_{save|restore}_auxiliary_pt_regs() and set
ARCH_HAS_PTREGS_AUXILIARY default to yes.

Store the CPU on exception entry and use it later.

Cc: Rik van Riel <riel@surriel.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/x86/Kconfig                    |  2 +-
 arch/x86/include/asm/entry-common.h | 12 ++++++++++++
 arch/x86/include/asm/ptrace.h       |  1 +
 arch/x86/mm/fault.c                 |  4 ++--
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b35f6a472e09..707650a6ecb2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1876,7 +1876,7 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
 
 config ARCH_HAS_PTREGS_AUXILIARY
 	depends on X86_64
-	bool
+	def_bool y
 
 choice
 	prompt "TSX enable mode"
diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 674ed46d3ced..eb145106929a 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -95,4 +95,16 @@ static __always_inline void arch_exit_to_user_mode(void)
 }
 #define arch_exit_to_user_mode arch_exit_to_user_mode
 
+#ifdef CONFIG_ARCH_HAS_PTREGS_AUXILIARY
+
+static inline void arch_save_aux_pt_regs(struct pt_regs *regs)
+{
+	struct pt_regs_auxiliary *aux_pt_regs = &to_extended_pt_regs(regs)->aux;
+
+	aux_pt_regs->cpu = raw_smp_processor_id();
+}
+#define arch_save_aux_pt_regs arch_save_aux_pt_regs
+
+#endif
+
 #endif
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 5a9c85893459..b403b469996f 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -97,6 +97,7 @@ struct pt_regs {
  * ARCH_HAS_PTREGS_AUXILIARY.  Failure to do so will result in a build failure.
  */
 struct pt_regs_auxiliary {
+	int cpu;
 };
 
 struct pt_regs_extended {
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 82cf23975aa1..5df99fe49494 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -768,9 +768,9 @@ static inline void
 show_signal_msg(struct pt_regs *regs, unsigned long error_code,
 		unsigned long address, struct task_struct *tsk)
 {
+	struct pt_regs_auxiliary *aux_pt_regs = &to_extended_pt_regs(regs)->aux;
 	const char *loglvl = task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG;
-	/* This is a racy snapshot, but it's better than nothing. */
-	int cpu = raw_smp_processor_id();
+	int cpu = aux_pt_regs->cpu;
 
 	if (!unhandled_signal(tsk, SIGSEGV))
 		return;
-- 
2.35.3

