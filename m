Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A074E4B5B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 04:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241458AbiCWDTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 23:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiCWDTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 23:19:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2245FF3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 20:18:06 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KNYSy4LW2zcbLk;
        Wed, 23 Mar 2022 11:17:54 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 23 Mar 2022 11:18:02 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Mar 2022 11:18:02 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tong Tiangen <tongtiangen@huawei.com>
Subject: [RFC PATCH -next] arm64: ras: add uce kernel recovery support
Date:   Wed, 23 Mar 2022 03:37:05 +0000
Message-ID: <20220323033705.3966643-1-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

uce means uncorrectable memory error.

In the sea fault handling process of the kernel, if it is judged that the
RAS error is consumed in the kernel, the current processing is kernel panic
. However, it is not optimal. In some case, the page accessed in kernel is
a user page (such as copy_from_user/get_user), in this case, kill the user
process and isolate the user page with hardware error is a better choice.

This feature provides the option. We implement it to add new extable type
(XXX_UCE_RECOVERY), these new types indicates they can be fixup from
uncorrectable memory error and it is fixuped in do_sea(). If the exception
is fixuped correctly, the kernel can avoid panic.

In copy_from_user, record the exception reason to regs->regs[0] at
ex_handler_fixup_uce_recovery() which is used to check sea fault triggered.

In get_user, the processing of EX_TYPE_UACCESS_ERR_ZERO and
EX_TYPE_UACCESS_ERR_ZERO_UCE_RECOVERY is same and both return -EFAULT.

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/arm64/Kconfig                   | 10 ++++++++
 arch/arm64/include/asm/asm-extable.h | 35 ++++++++++++++++++++++++----
 arch/arm64/include/asm/asm-uaccess.h | 16 +++++++++++++
 arch/arm64/include/asm/esr.h         |  5 ++++
 arch/arm64/include/asm/extable.h     |  2 +-
 arch/arm64/include/asm/uaccess.h     |  2 +-
 arch/arm64/kernel/probes/kprobes.c   |  2 +-
 arch/arm64/lib/copy_from_user.S      | 11 +++++----
 arch/arm64/mm/extable.c              | 21 ++++++++++++++++-
 arch/arm64/mm/fault.c                | 30 +++++++++++++++++++++++-
 10 files changed, 119 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 962c84952c98..39f828c5b931 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1681,6 +1681,16 @@ config ARM64_CNP
 	  at runtime, and does not affect PEs that do not implement
 	  this feature.
 
+config ARM64_UCE_KERNEL_RECOVERY
+	bool "Enable support for uncorrectable memory error(uce) kernel recovery"
+	default y
+	depends on ACPI_APEI_SEA
+	help
+	  With ARM v8.2 RAS Extension, SEA are usually triggered when memory
+	  error are consumed. In some cases, if the error address is in a
+	  user page there is a chance to recover. we can isolate this page
+	  and killing process instead of die.
+
 endmenu
 
 menu "ARMv8.3 architectural features"
diff --git a/arch/arm64/include/asm/asm-extable.h b/arch/arm64/include/asm/asm-extable.h
index c39f2437e08e..9debab58c2b2 100644
--- a/arch/arm64/include/asm/asm-extable.h
+++ b/arch/arm64/include/asm/asm-extable.h
@@ -2,11 +2,19 @@
 #ifndef __ASM_ASM_EXTABLE_H
 #define __ASM_ASM_EXTABLE_H
 
-#define EX_TYPE_NONE			0
-#define EX_TYPE_FIXUP			1
-#define EX_TYPE_BPF			2
-#define EX_TYPE_UACCESS_ERR_ZERO	3
-#define EX_TYPE_LOAD_UNALIGNED_ZEROPAD	4
+#define EX_TYPE_NONE				0
+#define EX_TYPE_FIXUP				1
+#define EX_TYPE_BPF				2
+#define EX_TYPE_UACCESS_ERR_ZERO		3
+#define EX_TYPE_LOAD_UNALIGNED_ZEROPAD		4
+
+/* _UCE_RECOVERY indicates that can fixup from unrecoverable memory errors */
+#define EX_TYPE_FIXUP_UCE_RECOVERY		5
+#define EX_TYPE_UACCESS_ERR_ZERO_UCE_RECOVERY	6
+
+#define IS_EX_TYPE_UCE_RECOVERY(type)				\
+	(type == EX_TYPE_FIXUP_UCE_RECOVERY ||			\
+	 type == EX_TYPE_UACCESS_ERR_ZERO_UCE_RECOVERY)
 
 #ifdef __ASSEMBLY__
 
@@ -27,6 +35,14 @@
 	__ASM_EXTABLE_RAW(\insn, \fixup, EX_TYPE_FIXUP, 0)
 	.endm
 
+/*
+ * Create an exception table entry for `insn`, which will branch to `fixup`
+ * when an unhandled fault(include sea fault) is taken.
+ */
+	.macro		_asm_extable_uce_recovery, insn, fixup
+	__ASM_EXTABLE_RAW(\insn, \fixup, EX_TYPE_FIXUP_UCE_RECOVERY, 0)
+	.endm
+
 /*
  * Create an exception table entry for `insn` if `fixup` is provided. Otherwise
  * do nothing.
@@ -64,6 +80,15 @@
 #define EX_DATA_REG(reg, gpr)						\
 	"((.L__gpr_num_" #gpr ") << " __stringify(EX_DATA_REG_##reg##_SHIFT) ")"
 
+#define _ASM_EXTABLE_UACCESS_ERR_ZERO_UCE_RECOVERY(insn, fixup, err, zero)		\
+	__DEFINE_ASM_GPR_NUMS								\
+	__ASM_EXTABLE_RAW(#insn, #fixup,						\
+			  __stringify(EX_TYPE_UACCESS_ERR_ZERO_UCE_RECOVERY),		\
+			  "("								\
+			    EX_DATA_REG(ERR, err) " | "					\
+			    EX_DATA_REG(ZERO, zero)					\
+			  ")")
+
 #define _ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, err, zero)		\
 	__DEFINE_ASM_GPR_NUMS						\
 	__ASM_EXTABLE_RAW(#insn, #fixup, 				\
diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
index 0557af834e03..36692ec1fdbb 100644
--- a/arch/arm64/include/asm/asm-uaccess.h
+++ b/arch/arm64/include/asm/asm-uaccess.h
@@ -92,4 +92,20 @@ alternative_else_nop_endif
 
 		_asm_extable	8888b,\l;
 	.endm
+
+	.macro user_ldp_uce_recovery l, reg1, reg2, addr, post_inc
+8888:		ldtr	\reg1, [\addr];
+8889:		ldtr	\reg2, [\addr, #8];
+		add	\addr, \addr, \post_inc;
+
+		_asm_extable_uce_recovery	8888b, \l;
+		_asm_extable_uce_recovery	8889b, \l;
+	.endm
+
+	.macro user_ldst_uce_recovery l, inst, reg, addr, post_inc
+8888:		\inst		\reg, [\addr];
+		add		\addr, \addr, \post_inc;
+
+		_asm_extable_uce_recovery	8888b, \l;
+	.endm
 #endif
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
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index e8dce0cc5eaa..a229f86e6542 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -236,7 +236,7 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	asm volatile(							\
 	"1:	" load "	" reg "1, [%2]\n"			\
 	"2:\n"								\
-	_ASM_EXTABLE_UACCESS_ERR_ZERO(1b, 2b, %w0, %w1)			\
+	_ASM_EXTABLE_UACCESS_ERR_ZERO_UCE_RECOVERY(1b, 2b, %w0, %w1)	\
 	: "+r" (err), "=&r" (x)						\
 	: "r" (addr))
 
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
diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index 34e317907524..f16104c63dde 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -21,7 +21,7 @@
  */
 
 	.macro ldrb1 reg, ptr, val
-	user_ldst 9998f, ldtrb, \reg, \ptr, \val
+	user_ldst_uce_recovery 9998f, ldtrb, \reg, \ptr, \val
 	.endm
 
 	.macro strb1 reg, ptr, val
@@ -29,7 +29,7 @@
 	.endm
 
 	.macro ldrh1 reg, ptr, val
-	user_ldst 9997f, ldtrh, \reg, \ptr, \val
+	user_ldst_uce_recovery 9997f, ldtrh, \reg, \ptr, \val
 	.endm
 
 	.macro strh1 reg, ptr, val
@@ -37,7 +37,7 @@
 	.endm
 
 	.macro ldr1 reg, ptr, val
-	user_ldst 9997f, ldtr, \reg, \ptr, \val
+	user_ldst_uce_recovery 9997f, ldtr, \reg, \ptr, \val
 	.endm
 
 	.macro str1 reg, ptr, val
@@ -45,7 +45,7 @@
 	.endm
 
 	.macro ldp1 reg1, reg2, ptr, val
-	user_ldp 9997f, \reg1, \reg2, \ptr, \val
+	user_ldp_uce_recovery 9997f, \reg1, \reg2, \ptr, \val
 	.endm
 
 	.macro stp1 reg1, reg2, ptr, val
@@ -62,7 +62,8 @@ SYM_FUNC_START(__arch_copy_from_user)
 	ret
 
 	// Exception fixups
-9997:	cmp	dst, dstin
+9997:	cbz	x0, 9998f
+	cmp	dst, dstin
 	b.ne	9998f
 	// Before being absolutely sure we couldn't copy anything, try harder
 USER(9998f, ldtrb tmp1w, [srcin])
diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
index 489455309695..b6b76e839b4b 100644
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
 
+static bool ex_handler_fixup_uce_recovery(const struct exception_table_entry *ex,
+					  struct pt_regs *regs, unsigned int esr)
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
 
@@ -71,12 +84,18 @@ bool fixup_exception(struct pt_regs *regs)
 	if (!ex)
 		return false;
 
+	if (esr_is_sea(esr) && !IS_EX_TYPE_UCE_RECOVERY(ex->type))
+		return false;
+
 	switch (ex->type) {
 	case EX_TYPE_FIXUP:
 		return ex_handler_fixup(ex, regs);
+	case EX_TYPE_FIXUP_UCE_RECOVERY:
+		return ex_handler_fixup_uce_recovery(ex, regs, esr);
 	case EX_TYPE_BPF:
 		return ex_handler_bpf(ex, regs);
 	case EX_TYPE_UACCESS_ERR_ZERO:
+	case EX_TYPE_UACCESS_ERR_ZERO_UCE_RECOVERY:
 		return ex_handler_uaccess_err_zero(ex, regs);
 	case EX_TYPE_LOAD_UNALIGNED_ZEROPAD:
 		return ex_handler_load_unaligned_zeropad(ex, regs);
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 77341b160aca..47c447554d2a 100644
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
+	if (!IS_ENABLED(CONFIG_ARM64_UCE_KERNEL_RECOVERY))
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
-- 
2.18.0.huawei.25

