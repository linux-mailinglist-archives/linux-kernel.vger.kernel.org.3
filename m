Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5F158F5F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 04:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbiHKCtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiHKCtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:49:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BCC88DEB
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 19:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660186149; x=1691722149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lH7D5nKGGmBjcycxHQUZmmg8Xl72TStupxWDAHhrpCA=;
  b=AIAudzuRB8hX2wPKTYDki8iKrXX0SyHhk2YOkqVY+yzOgU3n0jRq7Ais
   m8hB1iyYqwBCp9lkE32ZsWQs+HhnHrQ2uB9h87rOAN/gYhfh2HygSZlk9
   uKcvRqZQZKHShj4sy+NUN0l6xsN2xAnD7tIM6GdsWvgumWJVQdl0Cm6uE
   DUZZHuEM7bonJFqeX3QpjdqQqb+6szv2rTBWBL8kSIi8+aSOg361PawaA
   jfrJzeufqjgcx6dMI+XZ7kDoUJGCEsar/+Y51yqJrFqTQ9udFIVgF63DI
   AjwAx0SSqJRsq8DVkda1Dj9lnDByLCTUfA0ldKuL16EM6A9lzyfd3CIYx
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="291242718"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="291242718"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 19:49:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="608777333"
Received: from zjoseph-mobl3.amr.corp.intel.com (HELO localhost) ([10.209.123.207])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 19:49:08 -0700
From:   ira.weiny@intel.com
To:     Rik van Riel <riel@surriel.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/3] x86/mm: Store CPU info on exception entry
Date:   Wed, 10 Aug 2022 19:49:03 -0700
Message-Id: <20220811024903.178925-4-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220811024903.178925-1-ira.weiny@intel.com>
References: <20220811024903.178925-1-ira.weiny@intel.com>
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

x86 has auxiliary pt_regs space available to store information on the
stack during exceptions.  This information is easier to obtain and store
within C code.

The CPU information of a page fault is useful in determining where bad
CPUs are in a large data center.

Store the CPU on page fault entry and use it later.

Cc: Rik van Riel <riel@surriel.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC:
	New patch combining 2 and 5 from original series and modified.
	Boris/Thomas - eliminate generic calls to save the cpu and call
	only from exc_page_fault
---
 arch/x86/Kconfig              |  2 +-
 arch/x86/include/asm/ptrace.h |  1 +
 arch/x86/mm/fault.c           | 12 ++++++++++--
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5a0b6ee49cb4..e4a04406be2c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1874,7 +1874,7 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
 
 config ARCH_HAS_PTREGS_AUXILIARY
 	depends on X86_64
-	bool
+	def_bool y
 
 choice
 	prompt "TSX enable mode"
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
index dbc6a2e08a96..0aa420cd7874 100644
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
@@ -1507,6 +1507,13 @@ handle_page_fault(struct pt_regs *regs, unsigned long error_code,
 	}
 }
 
+noinstr static void aux_pt_regs_save_cpu(struct pt_regs *regs)
+{
+	struct pt_regs_auxiliary *aux_pt_regs = &to_extended_pt_regs(regs)->aux;
+
+	aux_pt_regs->cpu = raw_smp_processor_id();
+}
+
 DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 {
 	unsigned long address = read_cr2();
@@ -1550,6 +1557,7 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 	 */
 	state = irqentry_enter(regs);
 
+	aux_pt_regs_save_cpu(regs);
 	instrumentation_begin();
 	handle_page_fault(regs, error_code, address);
 	instrumentation_end();
-- 
2.35.3

