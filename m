Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40014507631
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356146AbiDSRNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355648AbiDSRJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:09:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DF1BC2E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388030; x=1681924030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8vcs5ki3Ih9PXx6ZkRzoktwKq0Lv/OaVdzmdmV9hSGs=;
  b=j0DCvUreKiiTsgTPf2kQiXjjqygzxfZJ4jAe8Cv8zBXWj8Ht9utRxNPX
   cpHr7a/Cyfw/oydzaZJXjwl9F/wg28JLKwfqmV2oNslHCqkOiVvMJ2+Ly
   LlhhfucHehvhsRQuCA3L7X06uHWwxOjugqNouwzDKewMp/cFOzrdQHWNW
   LGh8gogQ0sfvvkOzkrqVkyuMt9PkcBxu7u88rDGd/pSaYHSMJ/UIJZ2J5
   kaa2UgzZFSbgCq6EOaDpSUiJYxdWsJy/9VZUVxhlV3J19mWdDeCYoDj+V
   CFiTJoW/EuJoGEzOVXPVujCu02HGUib2ALcqUTyBUnDwRrgQC5ttf8/oW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="350267605"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="350267605"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="510207175"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:08 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 22/44] x86/fault: Print PKS MSR on fault
Date:   Tue, 19 Apr 2022 10:06:27 -0700
Message-Id: <20220419170649.1022246-23-ira.weiny@intel.com>
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

If a PKS fault occurs it will be easier to debug if the PKS MSR value at
the time of the fault is known.

Add pks_show_regs() to __show_regs() to show the PKRS MSR on fault if
enabled.

An 'executive summary' of the pt_regs are saved in __die_header() which
ensures that the first registers are saved in the event of multiple
faults.  Teach this code about the extended pt_registers such that the
PKS code can get to the original pkrs value as well.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	From Dave Hansen
		Move this output to __show_regs() next to the PKRU
			register dump

Changes for V8
	Split this into it's own patch.
---
 arch/x86/include/asm/pks.h   |  3 +++
 arch/x86/kernel/dumpstack.c  | 32 ++++++++++++++++++++++++++++++--
 arch/x86/kernel/process_64.c |  1 +
 arch/x86/mm/pkeys.c          | 11 +++++++++++
 4 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pks.h b/arch/x86/include/asm/pks.h
index b69e03a141fe..de67d5b5a2af 100644
--- a/arch/x86/include/asm/pks.h
+++ b/arch/x86/include/asm/pks.h
@@ -8,6 +8,7 @@ void pks_setup(void);
 void x86_pkrs_load(struct thread_struct *thread);
 void pks_save_pt_regs(struct pt_regs *regs);
 void pks_restore_pt_regs(struct pt_regs *regs);
+void pks_show_regs(struct pt_regs *regs, const char *log_lvl);
 
 bool pks_handle_key_fault(struct pt_regs *regs, unsigned long hw_error_code,
 			  unsigned long address);
@@ -18,6 +19,8 @@ static inline void pks_setup(void) { }
 static inline void x86_pkrs_load(struct thread_struct *thread) { }
 static inline void pks_save_pt_regs(struct pt_regs *regs) { }
 static inline void pks_restore_pt_regs(struct pt_regs *regs) { }
+static inline void pks_show_regs(struct pt_regs *regs,
+				 const char *log_lvl) { }
 
 static inline bool pks_handle_key_fault(struct pt_regs *regs,
 					unsigned long hw_error_code,
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index afae4dd77495..5fae75113def 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -27,8 +27,36 @@ int panic_on_unrecovered_nmi;
 int panic_on_io_nmi;
 static int die_counter;
 
+#ifdef CONFIG_ARCH_HAS_PTREGS_AUXILIARY
+
+static struct pt_regs_extended exec_summary_regs;
+
+static void save_exec_summary(struct pt_regs *regs)
+{
+	exec_summary_regs = *(to_extended_pt_regs(regs));
+}
+
+static struct pt_regs *retrieve_exec_summary(void)
+{
+	return &exec_summary_regs.pt_regs;
+}
+
+#else /* !CONFIG_ARCH_HAS_PTREGS_AUXILIARY */
+
 static struct pt_regs exec_summary_regs;
 
+static void save_exec_summary(struct pt_regs *regs)
+{
+	exec_summary_regs = *regs;
+}
+
+static struct pt_regs *retrieve_exec_summary(void)
+{
+	return &exec_summary_regs;
+}
+
+#endif /* CONFIG_ARCH_HAS_PTREGS_AUXILIARY */
+
 bool noinstr in_task_stack(unsigned long *stack, struct task_struct *task,
 			   struct stack_info *info)
 {
@@ -363,7 +391,7 @@ void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 	oops_exit();
 
 	/* Executive summary in case the oops scrolled away */
-	__show_regs(&exec_summary_regs, SHOW_REGS_ALL, KERN_DEFAULT);
+	__show_regs(retrieve_exec_summary(), SHOW_REGS_ALL, KERN_DEFAULT);
 
 	if (!signr)
 		return;
@@ -390,7 +418,7 @@ static void __die_header(const char *str, struct pt_regs *regs, long err)
 
 	/* Save the regs of the first oops for the executive summary later. */
 	if (!die_counter)
-		exec_summary_regs = *regs;
+		save_exec_summary(regs);
 
 	if (IS_ENABLED(CONFIG_PREEMPTION))
 		pr = IS_ENABLED(CONFIG_PREEMPT_RT) ? " PREEMPT_RT" : " PREEMPT";
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 5cfa1f8c8465..cd8f362a83c4 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -140,6 +140,7 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
 
 	if (cpu_feature_enabled(X86_FEATURE_OSPKE))
 		printk("%sPKRU: %08x\n", log_lvl, read_pkru());
+	pks_show_regs(regs, log_lvl);
 }
 
 void release_thread(struct task_struct *dead_task)
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index dd02e76d0359..a993c9b23815 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -374,6 +374,17 @@ void pks_restore_pt_regs(struct pt_regs *regs)
 	pks_write_pkrs(current->thread.pkrs);
 }
 
+void pks_show_regs(struct pt_regs *regs, const char *log_lvl)
+{
+	struct pt_regs_auxiliary *aux_pt_regs;
+
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return;
+
+	aux_pt_regs = &to_extended_pt_regs(regs)->aux;
+	printk("%sPKRS: 0x%x\n", log_lvl, aux_pt_regs->pkrs);
+}
+
 /*
  * PKS is independent of PKU and either or both may be supported on a CPU.
  *
-- 
2.35.1

