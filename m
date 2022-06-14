Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE1554AFC3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355669AbiFNMBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352550AbiFNMBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:01:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613B54756E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 05:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655208097; x=1686744097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+A2WQIeWLfKFt9l6xnCfBVKA+KRbh7RBvbegb5TlLdQ=;
  b=Nr3uEs0hDEIfDranu7k06SzBHUekkSQN5lfaUrRU3nmGioMaZPwbrcKp
   ooMCcNa2C05S3cCrsit0wvrvV10hKAkCIzqeOtrZq0jCToWCu6UzwS9ac
   LWNWs3zCsrRSGTlDOax8x3MRWobliYo1cfLQjBSeqDU4RfKQ0gaGox1Z4
   fZZLEC+XyCYnfQKeDVjAE8X+pEXMWvrH3PkIrY9jTe7OKXOjCwfLkBUMJ
   FTzddYrbNMsNhCrUjER21uLlFP38UdElRCEZgzRdG3i7RxUPMdZ4xJBA0
   OTscSWuAsAyxsc8IftsOdoA/a8j9vs/R7w6bRVVwlC7DPemjk3EpSTv/f
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="340260405"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="340260405"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 05:01:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="673838347"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jun 2022 05:01:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 07094506; Tue, 14 Jun 2022 15:01:37 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 2/3] x86/tdx: Clarify RIP adjustments in #VE handler
Date:   Tue, 14 Jun 2022 15:01:34 +0300
Message-Id: <20220614120135.14812-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220614120135.14812-1-kirill.shutemov@linux.intel.com>
References: <20220614120135.14812-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After successful #VE handling, tdx_handle_virt_exception() has to move
RIP to the next instruction. The handler needs to know the length of the
instruction.

If the #VE happened due to instruction execution, GET_VEINFO TDX module
call provides info on the instruction in R10, including its length.

For #VE due to EPT violation, info in R10 is not usable and kernel has
to decode instruction manually to find out its length.

Restructure the code to make it explicit that the instruction length
depends on the type of #VE. Handler of an exit reason returns
instruction length on success or -errno on failure.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 178 +++++++++++++++++++++++++++-------------
 1 file changed, 123 insertions(+), 55 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index faae53f8d559..7d6d484a6d28 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -124,6 +124,51 @@ static u64 get_cc_mask(void)
 	return BIT_ULL(gpa_width - 1);
 }
 
+/*
+ * TDX module spec states that #VE may be injected by the Intel TDX module in
+ * several cases:
+ *
+ *  - Emulation of the architectural #VE injection on EPT violation;
+ *
+ *  - As a result of guest TD execution of a disallowed instruction,
+ *    a disallowed MSR access, or CPUID virtualization;
+ *
+ *  - A notification to the guest TD about anomalous behavior;
+ *
+ * The last one is opt-in and is not used by the kernel.
+ *
+ * Intel Software Developer's Manual describes cases when instruction length
+ * field can be used in section "Information for VM Exits Due to Instruction
+ * Execution".
+ *
+ * For TDX, it ultimately means GET_VEINFO provides reliable instruction length
+ * information if #VE occurred due to instruction execution, but not for EPT
+ * violations.
+ */
+static int ve_instr_len(struct ve_info *ve)
+{
+	switch (ve->exit_reason) {
+	case EXIT_REASON_HLT:
+	case EXIT_REASON_MSR_READ:
+	case EXIT_REASON_MSR_WRITE:
+	case EXIT_REASON_CPUID:
+	case EXIT_REASON_IO_INSTRUCTION:
+		/* It is safe to use ve->instr_len for #VE due instructions */
+		return ve->instr_len;
+	case EXIT_REASON_EPT_VIOLATION:
+		/*
+		 * For EPT violations, ve->insn_len is not defined. For those,
+		 * the kernel must decode instructions manually and should not
+		 * be using this function.
+		 */
+		WARN_ONCE(1, "ve->instr_len is not defined for EPT violations");
+		return 0;
+	default:
+		WARN_ONCE(1, "Unexpected #VE-type: %lld\n", ve->exit_reason);
+		return ve->instr_len;
+	}
+}
+
 static u64 __cpuidle __halt(const bool irq_disabled, const bool do_sti)
 {
 	struct tdx_hypercall_args args = {
@@ -147,7 +192,7 @@ static u64 __cpuidle __halt(const bool irq_disabled, const bool do_sti)
 	return __tdx_hypercall(&args, do_sti ? TDX_HCALL_ISSUE_STI : 0);
 }
 
-static bool handle_halt(void)
+static int handle_halt(struct ve_info *ve)
 {
 	/*
 	 * Since non safe halt is mainly used in CPU offlining
@@ -158,9 +203,9 @@ static bool handle_halt(void)
 	const bool do_sti = false;
 
 	if (__halt(irq_disabled, do_sti))
-		return false;
+		return -EIO;
 
-	return true;
+	return ve_instr_len(ve);
 }
 
 void __cpuidle tdx_safe_halt(void)
@@ -180,7 +225,7 @@ void __cpuidle tdx_safe_halt(void)
 		WARN_ONCE(1, "HLT instruction emulation failed\n");
 }
 
-static bool read_msr(struct pt_regs *regs)
+static int read_msr(struct pt_regs *regs, struct ve_info *ve)
 {
 	struct tdx_hypercall_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
@@ -194,14 +239,14 @@ static bool read_msr(struct pt_regs *regs)
 	 * (GHCI), section titled "TDG.VP.VMCALL<Instruction.RDMSR>".
 	 */
 	if (__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT))
-		return false;
+		return -EIO;
 
 	regs->ax = lower_32_bits(args.r11);
 	regs->dx = upper_32_bits(args.r11);
-	return true;
+	return ve_instr_len(ve);
 }
 
-static bool write_msr(struct pt_regs *regs)
+static int write_msr(struct pt_regs *regs, struct ve_info *ve)
 {
 	struct tdx_hypercall_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
@@ -215,10 +260,13 @@ static bool write_msr(struct pt_regs *regs)
 	 * can be found in TDX Guest-Host-Communication Interface
 	 * (GHCI) section titled "TDG.VP.VMCALL<Instruction.WRMSR>".
 	 */
-	return !__tdx_hypercall(&args, 0);
+	if (__tdx_hypercall(&args, 0))
+		return -EIO;
+
+	return ve_instr_len(ve);
 }
 
-static bool handle_cpuid(struct pt_regs *regs)
+static int handle_cpuid(struct pt_regs *regs, struct ve_info *ve)
 {
 	struct tdx_hypercall_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
@@ -236,7 +284,7 @@ static bool handle_cpuid(struct pt_regs *regs)
 	 */
 	if (regs->ax < 0x40000000 || regs->ax > 0x4FFFFFFF) {
 		regs->ax = regs->bx = regs->cx = regs->dx = 0;
-		return true;
+		return ve_instr_len(ve);
 	}
 
 	/*
@@ -245,7 +293,7 @@ static bool handle_cpuid(struct pt_regs *regs)
 	 * (GHCI), section titled "VP.VMCALL<Instruction.CPUID>".
 	 */
 	if (__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT))
-		return false;
+		return -EIO;
 
 	/*
 	 * As per TDX GHCI CPUID ABI, r12-r15 registers contain contents of
@@ -257,7 +305,7 @@ static bool handle_cpuid(struct pt_regs *regs)
 	regs->cx = args.r14;
 	regs->dx = args.r15;
 
-	return true;
+	return ve_instr_len(ve);
 }
 
 static bool mmio_read(int size, unsigned long addr, unsigned long *val)
@@ -283,7 +331,7 @@ static bool mmio_write(int size, unsigned long addr, unsigned long val)
 			       EPT_WRITE, addr, val);
 }
 
-static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
+static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 {
 	char buffer[MAX_INSN_SIZE];
 	unsigned long *reg, val;
@@ -294,34 +342,36 @@ static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 
 	/* Only in-kernel MMIO is supported */
 	if (WARN_ON_ONCE(user_mode(regs)))
-		return false;
+		return -EFAULT;
 
 	if (copy_from_kernel_nofault(buffer, (void *)regs->ip, MAX_INSN_SIZE))
-		return false;
+		return -EFAULT;
 
 	if (insn_decode(&insn, buffer, MAX_INSN_SIZE, INSN_MODE_64))
-		return false;
+		return -EINVAL;
 
 	mmio = insn_decode_mmio(&insn, &size);
 	if (WARN_ON_ONCE(mmio == MMIO_DECODE_FAILED))
-		return false;
+		return -EINVAL;
 
 	if (mmio != MMIO_WRITE_IMM && mmio != MMIO_MOVS) {
 		reg = insn_get_modrm_reg_ptr(&insn, regs);
 		if (!reg)
-			return false;
+			return -EINVAL;
 	}
 
-	ve->instr_len = insn.length;
-
 	/* Handle writes first */
 	switch (mmio) {
 	case MMIO_WRITE:
 		memcpy(&val, reg, size);
-		return mmio_write(size, ve->gpa, val);
+		if (!mmio_write(size, ve->gpa, val))
+			return -EIO;
+		return insn.length;
 	case MMIO_WRITE_IMM:
 		val = insn.immediate.value;
-		return mmio_write(size, ve->gpa, val);
+		if (!mmio_write(size, ve->gpa, val))
+			return -EIO;
+		return insn.length;
 	case MMIO_READ:
 	case MMIO_READ_ZERO_EXTEND:
 	case MMIO_READ_SIGN_EXTEND:
@@ -334,15 +384,15 @@ static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 		 * decoded or handled properly. It was likely not using io.h
 		 * helpers or accessed MMIO accidentally.
 		 */
-		return false;
+		return -EINVAL;
 	default:
 		WARN_ONCE(1, "Unknown insn_decode_mmio() decode value?");
-		return false;
+		return -EINVAL;
 	}
 
 	/* Handle reads */
 	if (!mmio_read(size, ve->gpa, &val))
-		return false;
+		return -EIO;
 
 	switch (mmio) {
 	case MMIO_READ:
@@ -364,13 +414,13 @@ static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	default:
 		/* All other cases has to be covered with the first switch() */
 		WARN_ON_ONCE(1);
-		return false;
+		return -EINVAL;
 	}
 
 	if (extend_size)
 		memset(reg, extend_val, extend_size);
 	memcpy(reg, &val, size);
-	return true;
+	return insn.length;
 }
 
 static bool handle_in(struct pt_regs *regs, int size, int port)
@@ -421,13 +471,14 @@ static bool handle_out(struct pt_regs *regs, int size, int port)
  *
  * Return True on success or False on failure.
  */
-static bool handle_io(struct pt_regs *regs, u32 exit_qual)
+static int handle_io(struct pt_regs *regs, struct ve_info *ve)
 {
+	u32 exit_qual = ve->exit_qual;
 	int size, port;
-	bool in;
+	bool in, ret;
 
 	if (VE_IS_IO_STRING(exit_qual))
-		return false;
+		return -EIO;
 
 	in   = VE_IS_IO_IN(exit_qual);
 	size = VE_GET_IO_SIZE(exit_qual);
@@ -435,9 +486,13 @@ static bool handle_io(struct pt_regs *regs, u32 exit_qual)
 
 
 	if (in)
-		return handle_in(regs, size, port);
+		ret = handle_in(regs, size, port);
 	else
-		return handle_out(regs, size, port);
+		ret = handle_out(regs, size, port);
+	if (!ret)
+		return -EIO;
+
+	return ve_instr_len(ve);
 }
 
 /*
@@ -447,17 +502,19 @@ static bool handle_io(struct pt_regs *regs, u32 exit_qual)
 __init bool tdx_early_handle_ve(struct pt_regs *regs)
 {
 	struct ve_info ve;
-	bool ret;
+	int insn_len;
 
 	tdx_get_ve_info(&ve);
 
 	if (ve.exit_reason != EXIT_REASON_IO_INSTRUCTION)
 		return false;
 
-	ret = handle_io(regs, ve.exit_qual);
-	if (ret)
-		regs->ip += ve.instr_len;
-	return ret;
+	insn_len = handle_io(regs, &ve);
+	if (insn_len < 0)
+		return false;
+
+	regs->ip += insn_len;
+	return true;
 }
 
 void tdx_get_ve_info(struct ve_info *ve)
@@ -490,54 +547,65 @@ void tdx_get_ve_info(struct ve_info *ve)
 	ve->instr_info  = upper_32_bits(out.r10);
 }
 
-/* Handle the user initiated #VE */
-static bool virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
+/*
+ * Handle the user initiated #VE.
+ *
+ * On success, returns the number of bytes RIP should be incremented (>=0)
+ * or -errno on error.
+ */
+static int virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
 {
 	switch (ve->exit_reason) {
 	case EXIT_REASON_CPUID:
-		return handle_cpuid(regs);
+		return handle_cpuid(regs, ve);
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
-		return false;
+		return -EIO;
 	}
 }
 
-/* Handle the kernel #VE */
-static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
+/*
+ * Handle the kernel #VE.
+ *
+ * On success, returns the number of bytes RIP should be incremented (>=0)
+ * or -errno on error.
+ */
+static int virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
 {
 	switch (ve->exit_reason) {
 	case EXIT_REASON_HLT:
-		return handle_halt();
+		return handle_halt(ve);
 	case EXIT_REASON_MSR_READ:
-		return read_msr(regs);
+		return read_msr(regs, ve);
 	case EXIT_REASON_MSR_WRITE:
-		return write_msr(regs);
+		return write_msr(regs, ve);
 	case EXIT_REASON_CPUID:
-		return handle_cpuid(regs);
+		return handle_cpuid(regs, ve);
 	case EXIT_REASON_EPT_VIOLATION:
 		return handle_mmio(regs, ve);
 	case EXIT_REASON_IO_INSTRUCTION:
-		return handle_io(regs, ve->exit_qual);
+		return handle_io(regs, ve);
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
-		return false;
+		return -EIO;
 	}
 }
 
 bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve)
 {
-	bool ret;
+	int insn_len;
 
 	if (user_mode(regs))
-		ret = virt_exception_user(regs, ve);
+		insn_len = virt_exception_user(regs, ve);
 	else
-		ret = virt_exception_kernel(regs, ve);
+		insn_len = virt_exception_kernel(regs, ve);
+	if (insn_len < 0)
+		return false;
 
 	/* After successful #VE handling, move the IP */
-	if (ret)
-		regs->ip += ve->instr_len;
+	regs->ip += insn_len;
 
-	return ret;
+	return true;
 }
 
 static bool tdx_tlb_flush_required(bool private)
-- 
2.35.1

