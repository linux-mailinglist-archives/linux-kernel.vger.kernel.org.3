Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A896C4D5057
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbiCJRYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244892AbiCJRW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:22:57 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C773019BE5A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932898; x=1678468898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0slWJ+5xiaJpaEwCrss1KFKuknXVe7imrmVwQKVj/tA=;
  b=HswqgHrCcRO16y5b+vHu6upC5VKOm2NIMTMKJmOQ66XyQ+HreB/pQXdO
   d39V0ISxgPM791EUPXsoZpHEqJtqDzpC2k264+/0Bo2WpJIpJJvDyfVus
   hz1yw50LqXTuykt/CDW3Lm9SP+BL085r2FQF5vk/jmJ5ZxOD8h7fd64ld
   DhM9BDdrwGOnjQyWOjiBGv0IRFR/Ilfx8OGhM/UC8frAliNVn+JFXI3oM
   bsMz8G7Uf+bDGiNTwnwrbW/JcxeEG3kZeGckr2elUsoMpROM7+2MGTI8L
   Q+0oFIxZt2bJhH8h63gY+N+W+tSbxHD7PI2T7d9F3GzqkW9mr+VceH528
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="235918685"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="235918685"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:28 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="578874653"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:27 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 28/45] x86/fault: Print PKS MSR on fault
Date:   Thu, 10 Mar 2022 09:20:02 -0800
Message-Id: <20220310172019.850939-29-ira.weiny@intel.com>
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
index 53de044e5654..38be69d15431 100644
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
@@ -369,7 +397,7 @@ void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 	oops_exit();
 
 	/* Executive summary in case the oops scrolled away */
-	__show_regs(&exec_summary_regs, SHOW_REGS_ALL, KERN_DEFAULT);
+	__show_regs(retrieve_exec_summary(), SHOW_REGS_ALL, KERN_DEFAULT);
 
 	if (!signr)
 		return;
@@ -396,7 +424,7 @@ static void __die_header(const char *str, struct pt_regs *regs, long err)
 
 	/* Save the regs of the first oops for the executive summary later. */
 	if (!die_counter)
-		exec_summary_regs = *regs;
+		save_exec_summary(regs);
 
 	if (IS_ENABLED(CONFIG_PREEMPTION))
 		pr = IS_ENABLED(CONFIG_PREEMPT_RT) ? " PREEMPT_RT" : " PREEMPT";
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index e703cc451128..68d998ea3571 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -140,6 +140,7 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
 
 	if (cpu_feature_enabled(X86_FEATURE_OSPKE))
 		printk("%sPKRU: %08x\n", log_lvl, read_pkru());
+	pks_show_regs(regs, log_lvl);
 }
 
 void release_thread(struct task_struct *dead_task)
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 29885dfb0980..7c8e4ea9f022 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -378,6 +378,17 @@ void pks_restore_pt_regs(struct pt_regs *regs)
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

