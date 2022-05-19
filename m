Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336F352DC65
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbiESSID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243579AbiESSIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:08:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A87BA55C
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652983678; x=1684519678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6AIY7Q1SToLynckn2EKtYUXczuBZnfwVqiY4wT+/CjE=;
  b=UivAD+4XPL40DzmGUPEprgDzkdUvKpUBUcXtYbPrnM7KOn25syvVNerK
   QAoxgfqfDaaqbrTI6use6q+qq6Fm9RPi/qvSteAZza9UNzXxFCdfmRflS
   zAg/0MHn3IqhAzXYQcv7qEgv/sLrHIwn7L8by4RrT1kEoiQcXAWWiqxY+
   kfC7l9fJ4BX3hLGPobUMyhU3W8jSaE5UJhxokME/1X5Nzq8zAmFIOv6dS
   yFcls7njC5mkvRm2f0b3wp4380S2KtQL4XlyXeiOqIKfG2hJEhiO0Hd23
   zQiNIM5Sd8PNP+gtUpyKqNFPhhIqSKiy9ap1jCrHqeNU8ZYagdk62EYw+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="297616729"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="297616729"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 11:07:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="575755831"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 19 May 2022 11:07:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 5710C109; Thu, 19 May 2022 21:07:39 +0300 (EEST)
Date:   Thu, 19 May 2022 21:07:39 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     seanjc@google.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tdx: Handle load_unaligned_zeropad() page-cross to a
 shared page
Message-ID: <20220519180739.2xnq7mjpa6hzcbsn@black.fi.intel.com>
References: <20220517153021.11116-1-kirill.shutemov@linux.intel.com>
 <e73cb19e-7dab-2fc1-b947-fac70fd607d2@intel.com>
 <20220517174042.v6s7wm3u5j2ebaoq@black.fi.intel.com>
 <c761e774-8014-6fa9-cf21-e7cd8f7aca54@intel.com>
 <20220517201710.ixbpsaga5jzvokvy@black.fi.intel.com>
 <083519ab-752f-9815-7741-22b3fcc03322@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <083519ab-752f-9815-7741-22b3fcc03322@intel.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 03:16:42PM -0700, Dave Hansen wrote:
> See?  Now everybody that goes and writes a new #VE exception helper has
> a chance of actually getting this right.  As it stands, if someone adds
> one more of these, they'll probably get random behavior.  This way, they
> actually have to choose.  They _might_ even go looking at the SDM.

Okay. See below. Does it match what you had in mind?

If it is okay. I will do proper patches.

BTW, I found a bug in tdx_early_handle_ve(). It didn't update RIP.
I don't know how it happend. Maybe got lost on the way upstream.

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 9955b5a89df8..d2635ac52d9b 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -123,7 +123,7 @@ static u64 __cpuidle __halt(const bool irq_disabled, const bool do_sti)
 	return __tdx_hypercall(&args, do_sti ? TDX_HCALL_ISSUE_STI : 0);
 }
 
-static bool handle_halt(void)
+static int handle_halt(struct ve_info *ve)
 {
 	/*
 	 * Since non safe halt is mainly used in CPU offlining
@@ -134,9 +134,9 @@ static bool handle_halt(void)
 	const bool do_sti = false;
 
 	if (__halt(irq_disabled, do_sti))
-		return false;
+		return -EIO;
 
-	return true;
+	return ve->instr_len;
 }
 
 void __cpuidle tdx_safe_halt(void)
@@ -156,7 +156,7 @@ void __cpuidle tdx_safe_halt(void)
 		WARN_ONCE(1, "HLT instruction emulation failed\n");
 }
 
-static bool read_msr(struct pt_regs *regs)
+static int read_msr(struct pt_regs *regs, struct ve_info *ve)
 {
 	struct tdx_hypercall_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
@@ -170,14 +170,14 @@ static bool read_msr(struct pt_regs *regs)
 	 * (GHCI), section titled "TDG.VP.VMCALL<Instruction.RDMSR>".
 	 */
 	if (__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT))
-		return false;
+		return -EIO;
 
 	regs->ax = lower_32_bits(args.r11);
 	regs->dx = upper_32_bits(args.r11);
-	return true;
+	return ve->instr_len;
 }
 
-static bool write_msr(struct pt_regs *regs)
+static int write_msr(struct pt_regs *regs, struct ve_info *ve)
 {
 	struct tdx_hypercall_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
@@ -191,10 +191,13 @@ static bool write_msr(struct pt_regs *regs)
 	 * can be found in TDX Guest-Host-Communication Interface
 	 * (GHCI) section titled "TDG.VP.VMCALL<Instruction.WRMSR>".
 	 */
-	return !__tdx_hypercall(&args, 0);
+	if (__tdx_hypercall(&args, 0))
+		return -EIO;
+
+	return ve->instr_len;
 }
 
-static bool handle_cpuid(struct pt_regs *regs)
+static int handle_cpuid(struct pt_regs *regs, struct ve_info *ve)
 {
 	struct tdx_hypercall_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
@@ -212,7 +215,7 @@ static bool handle_cpuid(struct pt_regs *regs)
 	 */
 	if (regs->ax < 0x40000000 || regs->ax > 0x4FFFFFFF) {
 		regs->ax = regs->bx = regs->cx = regs->dx = 0;
-		return true;
+		return ve->instr_len;
 	}
 
 	/*
@@ -221,7 +224,7 @@ static bool handle_cpuid(struct pt_regs *regs)
 	 * (GHCI), section titled "VP.VMCALL<Instruction.CPUID>".
 	 */
 	if (__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT))
-		return false;
+		return -EIO;
 
 	/*
 	 * As per TDX GHCI CPUID ABI, r12-r15 registers contain contents of
@@ -233,7 +236,7 @@ static bool handle_cpuid(struct pt_regs *regs)
 	regs->cx = args.r14;
 	regs->dx = args.r15;
 
-	return true;
+	return ve->instr_len;
 }
 
 static bool mmio_read(int size, unsigned long addr, unsigned long *val)
@@ -259,7 +262,7 @@ static bool mmio_write(int size, unsigned long addr, unsigned long val)
 			       EPT_WRITE, addr, val);
 }
 
-static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
+static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 {
 	char buffer[MAX_INSN_SIZE];
 	unsigned long *reg, val;
@@ -270,7 +273,7 @@ static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 
 	/* Only in-kernel MMIO is supported */
 	if (WARN_ON_ONCE(user_mode(regs)))
-		return false;
+		return -EFAULT;
 
 	/*
 	 * load_unaligned_zeropad() relies on exception fixups in case of the
@@ -287,37 +290,37 @@ static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	 */
 	if (fixup_exception(regs, X86_TRAP_VE, 0, ve->gla)) {
 		/* regs->ip is adjusted by fixup_exception() */
-		ve->instr_len = 0;
-
-		return true;
+		return 0;
 	}
 
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
@@ -330,15 +333,15 @@ static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
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
@@ -360,13 +363,13 @@ static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
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
@@ -417,13 +420,14 @@ static bool handle_out(struct pt_regs *regs, int size, int port)
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
@@ -431,9 +435,13 @@ static bool handle_io(struct pt_regs *regs, u32 exit_qual)
 
 
 	if (in)
-		return handle_in(regs, size, port);
+		ret = handle_in(regs, size, port);
 	else
-		return handle_out(regs, size, port);
+		ret = handle_out(regs, size, port);
+	if (!ret)
+		return -EIO;
+
+	return ve->instr_len;
 }
 
 /*
@@ -443,13 +451,19 @@ static bool handle_io(struct pt_regs *regs, u32 exit_qual)
 __init bool tdx_early_handle_ve(struct pt_regs *regs)
 {
 	struct ve_info ve;
+	int ret;
 
 	tdx_get_ve_info(&ve);
 
 	if (ve.exit_reason != EXIT_REASON_IO_INSTRUCTION)
 		return false;
 
-	return handle_io(regs, ve.exit_qual);
+	ret = handle_io(regs, &ve);
+	if (ret < 0)
+		return false;
+
+	regs->ip += ret;
+	return true;
 }
 
 void tdx_get_ve_info(struct ve_info *ve)
@@ -483,53 +497,55 @@ void tdx_get_ve_info(struct ve_info *ve)
 }
 
 /* Handle the user initiated #VE */
-static bool virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
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
 
 /* Handle the kernel #VE */
-static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
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
+	int ret;
 
 	if (user_mode(regs))
 		ret = virt_exception_user(regs, ve);
 	else
 		ret = virt_exception_kernel(regs, ve);
 
+	if (ret < 0)
+		return false;
+
 	/* After successful #VE handling, move the IP */
-	if (ret)
-		regs->ip += ve->instr_len;
+	regs->ip += ret;
 
-	return ret;
+	return true;
 }
 
 static bool tdx_tlb_flush_required(bool private)
-- 
 Kirill A. Shutemov
