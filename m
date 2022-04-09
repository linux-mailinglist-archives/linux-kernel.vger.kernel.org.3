Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0096D4FA156
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbiDIBbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240331AbiDIBaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:30:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E9610FAC5;
        Fri,  8 Apr 2022 18:27:37 -0700 (PDT)
Date:   Sat, 09 Apr 2022 01:27:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649467655;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i/tCn0IIS/yQBlCuILUh+bl9b9cO7RV3ASdaBc/cPiw=;
        b=CZ8+ISgpI4nDm8nagWxfuEpN/88PS0SDgOb4ECdg6bCKWJLmbVAmPCjNw4hK5MxN5ADoVl
        jHgjy6FAZPWj/6WQ7iI3ULV/C9sz0+cLcszZuJ5b1yAQ5Vv/rfDSYE3enY2lh6L14e0mAt
        6EslQzn8z84MfQC7ZOKIYxvKWvoRZREB4T3p5Vjfq2wDHaYByqFaMYmhi7DUkL8btqGyop
        N9IQBl3jWT5xDpUaYQVB9KyFF+Fift2VUxHMY0p9iLiHNxdAas0Km1kcBbok2wiILjPBt3
        g2CfKyRNvfbncO+txnhJ49WVlCqROQtLizw1u0CDZodynWRO1nN0qROr5npxHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649467655;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i/tCn0IIS/yQBlCuILUh+bl9b9cO7RV3ASdaBc/cPiw=;
        b=nSkBy412l1lCUol+LOt/SW6GwqaunYKY1tNy0wBVw4ooS7x95L7U0RpU98aSGxm8S/0fOb
        ETo9ZCPaFaOn8gAw==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Handle in-kernel MMIO
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405232939.73860-12-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-12-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164946765464.4207.3715751176055921036.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PHOTO_EDITING_DIRECT,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     31d58c4e557d46fa7f8557714250fb6f89c941ae
Gitweb:        https://git.kernel.org/tip/31d58c4e557d46fa7f8557714250fb6f89c941ae
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 06 Apr 2022 02:29:20 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Apr 2022 08:27:51 -07:00

x86/tdx: Handle in-kernel MMIO

In non-TDX VMs, MMIO is implemented by providing the guest a mapping
which will cause a VMEXIT on access and then the VMM emulating the
instruction that caused the VMEXIT. That's not possible for TDX VM.

To emulate an instruction an emulator needs two things:

  - R/W access to the register file to read/modify instruction arguments
    and see RIP of the faulted instruction.

  - Read access to memory where instruction is placed to see what to
    emulate. In this case it is guest kernel text.

Both of them are not available to VMM in TDX environment:

  - Register file is never exposed to VMM. When a TD exits to the module,
    it saves registers into the state-save area allocated for that TD.
    The module then scrubs these registers before returning execution
    control to the VMM, to help prevent leakage of TD state.

  - TDX does not allow guests to execute from shared memory. All executed
    instructions are in TD-private memory. Being private to the TD, VMMs
    have no way to access TD-private memory and no way to read the
    instruction to decode and emulate it.

In TDX the MMIO regions are instead configured by VMM to trigger a #VE
exception in the guest.

Add #VE handling that emulates the MMIO instruction inside the guest and
converts it into a controlled hypercall to the host.

This approach is bad for performance. But, it has (virtually) no impact
on the size of the kernel image and will work for a wide variety of
drivers. This allows TDX deployments to use arbitrary devices and device
drivers, including virtio. TDX customers have asked for the capability
to use random devices in their deployments.

In other words, even if all of the work was done to paravirtualize all
x86 MMIO users and virtio, this approach would still be needed. There
is essentially no way to get rid of this code.

This approach is functional for all in-kernel MMIO users current and
future and does so with a minimal amount of code and kernel image bloat.

MMIO addresses can be used with any CPU instruction that accesses
memory. Address only MMIO accesses done via io.h helpers, such as
'readl()' or 'writeq()'.

Any CPU instruction that accesses memory can also be used to access
MMIO.  However, by convention, MMIO access are typically performed via
io.h helpers such as 'readl()' or 'writeq()'.

The io.h helpers intentionally use a limited set of instructions when
accessing MMIO.  This known, limited set of instructions makes MMIO
instruction decoding and emulation feasible in KVM hosts and SEV guests
today.

MMIO accesses performed without the io.h helpers are at the mercy of the
compiler.  Compilers can and will generate a much more broad set of
instructions which can not practically be decoded and emulated.  TDX
guests will oops if they encounter one of these decoding failures.

This means that TDX guests *must* use the io.h helpers to access MMIO.

This requirement is not new.  Both KVM hosts and AMD SEV guests have the
same limitations on MMIO access.

=== Potential alternative approaches ===

== Paravirtualizing all MMIO ==

An alternative to letting MMIO induce a #VE exception is to avoid
the #VE in the first place. Similar to the port I/O case, it is
theoretically possible to paravirtualize MMIO accesses.

Like the exception-based approach offered here, a fully paravirtualized
approach would be limited to MMIO users that leverage common
infrastructure like the io.h macros.

However, any paravirtual approach would be patching approximately 120k
call sites. Any paravirtual approach would need to replace a bare memory
access instruction with (at least) a function call. With a conservative
overhead estimation of 5 bytes per call site (CALL instruction),
it leads to bloating code by 600k.

Many drivers will never be used in the TDX environment and the bloat
cannot be justified.

== Patching TDX drivers ==

Rather than touching the entire kernel, it might also be possible to
just go after drivers that use MMIO in TDX guests *and* are performance
critical to justify the effrort. Right now, that's limited only to virtio.

All virtio MMIO appears to be done through a single function, which
makes virtio eminently easy to patch.

This approach will be adopted in the future, removing the bulk of
MMIO #VEs. The #VE-based MMIO will remain serving non-virtio use cases.

Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20220405232939.73860-12-kirill.shutemov@linux.intel.com
---
 arch/x86/coco/tdx/tdx.c | 121 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 121 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 50c3b97..ab10bc7 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -8,11 +8,17 @@
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
+#include <asm/insn.h>
+#include <asm/insn-eval.h>
 
 /* TDX module Call Leaf IDs */
 #define TDX_GET_INFO			1
 #define TDX_GET_VEINFO			3
 
+/* MMIO direction */
+#define EPT_READ	0
+#define EPT_WRITE	1
+
 /*
  * Wrapper for standard use of __tdx_hypercall with no output aside from
  * return code.
@@ -222,6 +228,119 @@ static bool handle_cpuid(struct pt_regs *regs)
 	return true;
 }
 
+static bool mmio_read(int size, unsigned long addr, unsigned long *val)
+{
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = hcall_func(EXIT_REASON_EPT_VIOLATION),
+		.r12 = size,
+		.r13 = EPT_READ,
+		.r14 = addr,
+		.r15 = *val,
+	};
+
+	if (__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT))
+		return false;
+	*val = args.r11;
+	return true;
+}
+
+static bool mmio_write(int size, unsigned long addr, unsigned long val)
+{
+	return !_tdx_hypercall(hcall_func(EXIT_REASON_EPT_VIOLATION), size,
+			       EPT_WRITE, addr, val);
+}
+
+static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
+{
+	char buffer[MAX_INSN_SIZE];
+	unsigned long *reg, val;
+	struct insn insn = {};
+	enum mmio_type mmio;
+	int size, extend_size;
+	u8 extend_val = 0;
+
+	/* Only in-kernel MMIO is supported */
+	if (WARN_ON_ONCE(user_mode(regs)))
+		return false;
+
+	if (copy_from_kernel_nofault(buffer, (void *)regs->ip, MAX_INSN_SIZE))
+		return false;
+
+	if (insn_decode(&insn, buffer, MAX_INSN_SIZE, INSN_MODE_64))
+		return false;
+
+	mmio = insn_decode_mmio(&insn, &size);
+	if (WARN_ON_ONCE(mmio == MMIO_DECODE_FAILED))
+		return false;
+
+	if (mmio != MMIO_WRITE_IMM && mmio != MMIO_MOVS) {
+		reg = insn_get_modrm_reg_ptr(&insn, regs);
+		if (!reg)
+			return false;
+	}
+
+	ve->instr_len = insn.length;
+
+	/* Handle writes first */
+	switch (mmio) {
+	case MMIO_WRITE:
+		memcpy(&val, reg, size);
+		return mmio_write(size, ve->gpa, val);
+	case MMIO_WRITE_IMM:
+		val = insn.immediate.value;
+		return mmio_write(size, ve->gpa, val);
+	case MMIO_READ:
+	case MMIO_READ_ZERO_EXTEND:
+	case MMIO_READ_SIGN_EXTEND:
+		/* Reads are handled below */
+		break;
+	case MMIO_MOVS:
+	case MMIO_DECODE_FAILED:
+		/*
+		 * MMIO was accessed with an instruction that could not be
+		 * decoded or handled properly. It was likely not using io.h
+		 * helpers or accessed MMIO accidentally.
+		 */
+		return false;
+	default:
+		WARN_ONCE(1, "Unknown insn_decode_mmio() decode value?");
+		return false;
+	}
+
+	/* Handle reads */
+	if (!mmio_read(size, ve->gpa, &val))
+		return false;
+
+	switch (mmio) {
+	case MMIO_READ:
+		/* Zero-extend for 32-bit operation */
+		extend_size = size == 4 ? sizeof(*reg) : 0;
+		break;
+	case MMIO_READ_ZERO_EXTEND:
+		/* Zero extend based on operand size */
+		extend_size = insn.opnd_bytes;
+		break;
+	case MMIO_READ_SIGN_EXTEND:
+		/* Sign extend based on operand size */
+		extend_size = insn.opnd_bytes;
+		if (size == 1 && val & BIT(7))
+			extend_val = 0xFF;
+		else if (size > 1 && val & BIT(15))
+			extend_val = 0xFF;
+		break;
+	default:
+		/* All other cases has to be covered with the first switch() */
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	if (extend_size)
+		memset(reg, extend_val, extend_size);
+	memcpy(reg, &val, size);
+	return true;
+}
+
 void tdx_get_ve_info(struct ve_info *ve)
 {
 	struct tdx_module_output out;
@@ -276,6 +395,8 @@ static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
 		return write_msr(regs);
 	case EXIT_REASON_CPUID:
 		return handle_cpuid(regs);
+	case EXIT_REASON_EPT_VIOLATION:
+		return handle_mmio(regs, ve);
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		return false;
