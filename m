Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E7B4F5E8F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiDFMwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiDFMvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:51:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32DE58E58
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:54:30 -0700 (PDT)
Received: from kwepemi500001.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KYJDs0N84zgYR6;
        Wed,  6 Apr 2022 16:52:45 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500001.china.huawei.com (7.221.188.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Apr 2022 16:54:28 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 6 Apr 2022 16:54:27 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Tong Tiangen <tongtiangen@huawei.com>
Subject: [RFC PATCH -next V2 3/7] arm64: add support for machine check error safe
Date:   Wed, 6 Apr 2022 09:13:07 +0000
Message-ID: <20220406091311.3354723-4-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20220406091311.3354723-1-tongtiangen@huawei.com>
References: <20220406091311.3354723-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In arm64 kernel hardware memory errors process(do_sea()), if the errors
is consumed in the kernel, the current processing is panic. However,
it is not optimal. In some case, the page accessed in kernel is a user
page (such as copy_from_user/get_user), kill the user process and
isolate the user page with hardware memory errors is a better choice.

Consistent with PPC/x86, it is implemented by CONFIG_ARCH_HAS_COPY_MC.

This patch only enable machine error check framework, it add exception
fixup before kernel panic in do_sea() and only limit the consumption of
hardware memory errors in kernel mode triggered by user mode processes.
If fixup successful, there is no need to panic.

Also add _asm_extable_mc macro used for add extable entry to help
fixup.

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/asm-extable.h | 13 ++++++++++++
 arch/arm64/include/asm/esr.h         |  5 +++++
 arch/arm64/include/asm/extable.h     |  2 +-
 arch/arm64/kernel/probes/kprobes.c   |  2 +-
 arch/arm64/mm/extable.c              | 20 ++++++++++++++++++-
 arch/arm64/mm/fault.c                | 30 +++++++++++++++++++++++++++-
 include/linux/uaccess.h              |  8 ++++++++
 8 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d9325dd95eba..012e38309955 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -19,6 +19,7 @@ config ARM64
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_CACHE_LINE_SIZE
+	select ARCH_HAS_COPY_MC if ACPI_APEI_GHES
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE
diff --git a/arch/arm64/include/asm/asm-extable.h b/arch/arm64/include/asm/asm-extable.h
index c39f2437e08e..74d1db74fd86 100644
--- a/arch/arm64/include/asm/asm-extable.h
+++ b/arch/arm64/include/asm/asm-extable.h
@@ -8,6 +8,11 @@
 #define EX_TYPE_UACCESS_ERR_ZERO	3
 #define EX_TYPE_LOAD_UNALIGNED_ZEROPAD	4
 
+/* _MC indicates that can fixup from machine check errors */
+#define EX_TYPE_FIXUP_MC		5
+
+#define IS_EX_TYPE_MC(type) (type == EX_TYPE_FIXUP_MC)
+
 #ifdef __ASSEMBLY__
 
 #define __ASM_EXTABLE_RAW(insn, fixup, type, data)	\
@@ -27,6 +32,14 @@
 	__ASM_EXTABLE_RAW(\insn, \fixup, EX_TYPE_FIXUP, 0)
 	.endm
 
+/*
+ * Create an exception table entry for `insn`, which will branch to `fixup`
+ * when an unhandled fault(include sea fault) is taken.
+ */
+	.macro		_asm_extable_mc, insn, fixup
+	__ASM_EXTABLE_RAW(\insn, \fixup, EX_TYPE_FIXUP_MC, 0)
+	.endm
+
 /*
  * Create an exception table entry for `insn` if `fixup` is provided. Otherwise
  * do nothing.
diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index d52a0b269ee8..11fcfc002654 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -330,6 +330,11 @@
 #ifndef __ASSEMBLY__
 #include <asm/types.h>
 
+static inline bool esr_is_sea(u32 esr)
+{
+	return (esr & ESR_ELx_FSC) == ESR_ELx_FSC_EXTABT;
+}
+
 static inline bool esr_is_data_abort(u32 esr)
 {
 	const u32 ec = ESR_ELx_EC(esr);
diff --git a/arch/arm64/include/asm/extable.h b/arch/arm64/include/asm/extable.h
index 72b0e71cc3de..f7835b0f473b 100644
--- a/arch/arm64/include/asm/extable.h
+++ b/arch/arm64/include/asm/extable.h
@@ -45,5 +45,5 @@ bool ex_handler_bpf(const struct exception_table_entry *ex,
 }
 #endif /* !CONFIG_BPF_JIT */
 
-bool fixup_exception(struct pt_regs *regs);
+bool fixup_exception(struct pt_regs *regs, unsigned int esr);
 #endif
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index d9dfa82c1f18..16a069e8eec3 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -285,7 +285,7 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
 		 */
-		if (fixup_exception(regs))
+		if (fixup_exception(regs, fsr))
 			return 1;
 	}
 	return 0;
diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
index 489455309695..f1134c88e849 100644
--- a/arch/arm64/mm/extable.c
+++ b/arch/arm64/mm/extable.c
@@ -9,6 +9,7 @@
 
 #include <asm/asm-extable.h>
 #include <asm/ptrace.h>
+#include <asm/esr.h>
 
 static inline unsigned long
 get_ex_fixup(const struct exception_table_entry *ex)
@@ -23,6 +24,18 @@ static bool ex_handler_fixup(const struct exception_table_entry *ex,
 	return true;
 }
 
+static bool ex_handler_fixup_mc(const struct exception_table_entry *ex,
+				struct pt_regs *regs, unsigned int esr)
+{
+	if (esr_is_sea(esr))
+		regs->regs[0] = 0;
+	else
+		regs->regs[0] = 1;
+
+	regs->pc = get_ex_fixup(ex);
+	return true;
+}
+
 static bool ex_handler_uaccess_err_zero(const struct exception_table_entry *ex,
 					struct pt_regs *regs)
 {
@@ -63,7 +76,7 @@ ex_handler_load_unaligned_zeropad(const struct exception_table_entry *ex,
 	return true;
 }
 
-bool fixup_exception(struct pt_regs *regs)
+bool fixup_exception(struct pt_regs *regs, unsigned int esr)
 {
 	const struct exception_table_entry *ex;
 
@@ -71,9 +84,14 @@ bool fixup_exception(struct pt_regs *regs)
 	if (!ex)
 		return false;
 
+	if (esr_is_sea(esr) && !IS_EX_TYPE_MC(ex->type))
+		return false;
+
 	switch (ex->type) {
 	case EX_TYPE_FIXUP:
 		return ex_handler_fixup(ex, regs);
+	case EX_TYPE_FIXUP_MC:
+		return ex_handler_fixup_mc(ex, regs, esr);
 	case EX_TYPE_BPF:
 		return ex_handler_bpf(ex, regs);
 	case EX_TYPE_UACCESS_ERR_ZERO:
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 77341b160aca..ffdfab2fdd60 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -361,7 +361,7 @@ static void __do_kernel_fault(unsigned long addr, unsigned int esr,
 	 * Are we prepared to handle this kernel fault?
 	 * We are almost certainly not prepared to handle instruction faults.
 	 */
-	if (!is_el1_instruction_abort(esr) && fixup_exception(regs))
+	if (!is_el1_instruction_abort(esr) && fixup_exception(regs, esr))
 		return;
 
 	if (WARN_RATELIMIT(is_spurious_el1_translation_fault(addr, esr, regs),
@@ -695,6 +695,30 @@ static int do_bad(unsigned long far, unsigned int esr, struct pt_regs *regs)
 	return 1; /* "fault" */
 }
 
+static bool arm64_process_kernel_sea(unsigned long addr, unsigned int esr,
+				     struct pt_regs *regs, int sig, int code)
+{
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_COPY_MC))
+		return false;
+
+	if (user_mode(regs) || !current->mm)
+		return false;
+
+	if (apei_claim_sea(regs) < 0)
+		return false;
+
+	current->thread.fault_address = 0;
+	current->thread.fault_code = esr;
+
+	if (!fixup_exception(regs, esr))
+		return false;
+
+	arm64_force_sig_fault(sig, code, addr,
+		"Uncorrected hardware memory error in kernel-access\n");
+
+	return true;
+}
+
 static int do_sea(unsigned long far, unsigned int esr, struct pt_regs *regs)
 {
 	const struct fault_info *inf;
@@ -720,6 +744,10 @@ static int do_sea(unsigned long far, unsigned int esr, struct pt_regs *regs)
 		 */
 		siaddr  = untagged_addr(far);
 	}
+
+	if (arm64_process_kernel_sea(siaddr, esr, regs, inf->sig, inf->code))
+		return 0;
+
 	arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, esr);
 
 	return 0;
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 546179418ffa..dd952aeecdc1 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -174,6 +174,14 @@ copy_mc_to_kernel(void *dst, const void *src, size_t cnt)
 }
 #endif
 
+#ifndef copy_mc_to_user
+static inline unsigned long __must_check
+copy_mc_to_user(void *dst, const void *src, size_t cnt)
+{
+	return raw_copy_to_user(dst, src, cnt);
+}
+#endif
+
 static __always_inline void pagefault_disabled_inc(void)
 {
 	current->pagefault_disabled++;
-- 
2.18.0.huawei.25

