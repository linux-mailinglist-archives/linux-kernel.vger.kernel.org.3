Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27C84CA80B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243024AbiCBO33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242929AbiCBO27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:28:59 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E5B4833D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646231291; x=1677767291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ydqlGqsWDwIGOZhaqJRyD9QZjFpWI/gZ/DnHr9ieMw0=;
  b=V/Hm8ypWnPrhBKbe7imKh7WfR1WWtKVFonAJRd++W7tzWp0Vjg6xlG8w
   SWBL9Ba8L8QQXCJq4wj9ctX+gvpSRkbCybGWfYcAWBJq9VFuVKJ/+mv/3
   dpr/eJ8sQ/bBp63K4mjgyBcDRFvyvd6JxACQvdouy+9dkr9U7fz5gjtdo
   uuLqVqE/JWdiHs///qMGbAe5tmUk2pJieRU/6K1VJDquae43yIlzFFRJo
   YbFOafvjpC5CLmv0wbPJXkMIfm7EqTrC6/UrpK5OYWcZsuGw2iqxdGs5m
   GgAvmXmVZhfA28HCShRz/TR78VxHoopCsoYzimHjXXscVEB5WET4v98p3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253141101"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="253141101"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 06:28:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="709524780"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 02 Mar 2022 06:28:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 5B1C136B; Wed,  2 Mar 2022 16:28:12 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv5 11/30] x86/tdx: Handle in-kernel MMIO
Date:   Wed,  2 Mar 2022 17:27:47 +0300
Message-Id: <20220302142806.51844-12-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

  - Memory is encrypted a TD-private key. The CPU disallows software
    other than the TDX module and TDs from making memory accesses using
    the private key.

In TDX the MMIO regions are instead configured by VMM to trigger a #VE
exception in the guest.

Add #VE handling that emulates the MMIO instruction inside the guest and
converts it into a controlled hypercall to the host.

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

MMIO accesses are performed without the io.h helpers are at the mercy of
the compiler.  Compilers can and will generate a much more broad set of
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
just go after drivers that use MMIO in TDX guests.  Right now, that's
limited only to virtio and some x86-specific drivers.

All virtio MMIO appears to be done through a single function, which
makes virtio eminently easy to patch.

This approach will be adopted in the future, removing the bulk of
MMIO #VEs. The #VE-based MMIO will remain serving non-virtio use cases.

Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx.c | 114 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
index d00b367f8052..e6163e7e3247 100644
--- a/arch/x86/coco/tdx.c
+++ b/arch/x86/coco/tdx.c
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
@@ -200,6 +206,112 @@ static bool handle_cpuid(struct pt_regs *regs)
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
+		/* Unknown insn_decode_mmio() decode value? */
+		BUG();
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
+		BUG();
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
@@ -247,6 +359,8 @@ static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
 		return write_msr(regs);
 	case EXIT_REASON_CPUID:
 		return handle_cpuid(regs);
+	case EXIT_REASON_EPT_VIOLATION:
+		return handle_mmio(regs, ve);
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		return false;
-- 
2.34.1

