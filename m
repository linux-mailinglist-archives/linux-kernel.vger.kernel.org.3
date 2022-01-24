Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9084982D4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240327AbiAXPCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:02:35 -0500
Received: from mga14.intel.com ([192.55.52.115]:43409 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239154AbiAXPCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:02:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643036541; x=1674572541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YHy4p1HIVc+vzZYrEdBeLSslF/unh4oDHdSwuZYIthU=;
  b=CT8qzOvFdUqIFEf6BmR43zSefKaP2czld+0dGVhbGPWuTtipFGfB5i3C
   H+IsXO9PeiwnsH7QWKvj+hizzHiO0q9oE4OoL4kSaxkMgwZFNehfetxgl
   T/IAvLQ5XuX6UnT49FLfXplc7prqDFIoH6F24RAZIWgWclcnpdDb3sbqz
   PK60BDb1oU+c7i9C5G2ZQE60A1c2hnhsYSGJWNrDs6NkN70X4DD+QKRVJ
   YRrAM2TuRf3yr55L422BGiSLdVSqmkcYMsOx99IHd7a0eLmLHqUXGvTFL
   jaqauJWEQsLfc30nS9v2Q3b8nHNIqKcFwJ1NyRemz6iw1h7df8FMQULYk
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="246280270"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="246280270"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:02:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="596810264"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jan 2022 07:02:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id AF4CC557; Mon, 24 Jan 2022 17:02:19 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 08/29] x86/tdx: Handle in-kernel MMIO
Date:   Mon, 24 Jan 2022 18:01:54 +0300
Message-Id: <20220124150215.36893-9-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In TDX the MMIO regions are instead configured to trigger a #VE
exception in the guest. The guest #VE handler then emulates the MMIO
instruction inside the guest and converts it into a controlled hypercall
to the host.

MMIO addresses can be used with any CPU instruction that accesses
memory. This patch, however, covers only MMIO accesses done via io.h
helpers, such as 'readl()' or 'writeq()'.

readX()/writeX() helpers limit the range of instructions which can trigger
MMIO. It makes MMIO instruction emulation feasible. Raw access to MMIO
region allows compiler to generate whatever instruction it wants.
Supporting all possible instructions is a task of a different scope

MMIO access with anything other than helpers from io.h may result in
MMIO_DECODE_FAILED and an oops.

AMD SEV has the same limitations to MMIO handling.

=== Potential alternative approaches ===

== Paravirtualizing all MMIO ==

An alternative to letting MMIO induce a #VE exception is to avoid
the #VE in the first place. Similar to the port I/O case, it is
theoretically possible to paravirtualize MMIO accesses.

Like the exception-based approach offered here, a fully paravirtualized
approach would be limited to MMIO users that leverage common
infrastructure like the io.h macros.

However, any paravirtual approach would be patching approximately
120k call sites. With a conservative overhead estimation of 5 bytes per
call site (CALL instruction), it leads to bloating code by 600k.

Many drivers will never be used in the TDX environment and the bloat
cannot be justified.

== Patching TDX drivers ==

Rather than touching the entire kernel, it might also be possible to
just go after drivers that use MMIO in TDX guests.  Right now, that's
limited only to virtio and some x86-specific drivers.

All virtio MMIO appears to be done through a single function, which
makes virtio eminently easy to patch. This will be implemented in the
future, removing the bulk of MMIO #VEs.

Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/tdx.c | 114 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index f213c67b4ecc..8e630eeb765d 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -7,6 +7,8 @@
 #include <linux/cpufeature.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
+#include <asm/insn.h>
+#include <asm/insn-eval.h>
 
 /* TDX module Call Leaf IDs */
 #define TDX_GET_VEINFO			3
@@ -149,6 +151,112 @@ static bool tdx_handle_cpuid(struct pt_regs *regs)
 	return true;
 }
 
+static bool tdx_mmio(int size, bool write, unsigned long addr,
+		     unsigned long *val)
+{
+	struct tdx_hypercall_output out;
+	u64 err;
+
+	err = _tdx_hypercall(EXIT_REASON_EPT_VIOLATION, size, write,
+			     addr, *val, &out);
+	if (err)
+		return true;
+
+	*val = out.r11;
+	return false;
+}
+
+static bool tdx_mmio_read(int size, unsigned long addr, unsigned long *val)
+{
+	return tdx_mmio(size, false, addr, val);
+}
+
+static bool tdx_mmio_write(int size, unsigned long addr, unsigned long *val)
+{
+	return tdx_mmio(size, true, addr, val);
+}
+
+static int tdx_handle_mmio(struct pt_regs *regs, struct ve_info *ve)
+{
+	char buffer[MAX_INSN_SIZE];
+	unsigned long *reg, val = 0;
+	struct insn insn = {};
+	enum mmio_type mmio;
+	int size;
+	bool err;
+
+	if (copy_from_kernel_nofault(buffer, (void *)regs->ip, MAX_INSN_SIZE))
+		return -EFAULT;
+
+	if (insn_decode(&insn, buffer, MAX_INSN_SIZE, INSN_MODE_64))
+		return -EFAULT;
+
+	mmio = insn_decode_mmio(&insn, &size);
+	if (WARN_ON_ONCE(mmio == MMIO_DECODE_FAILED))
+		return -EFAULT;
+
+	if (mmio != MMIO_WRITE_IMM && mmio != MMIO_MOVS) {
+		reg = insn_get_modrm_reg_ptr(&insn, regs);
+		if (!reg)
+			return -EFAULT;
+	}
+
+	switch (mmio) {
+	case MMIO_WRITE:
+		memcpy(&val, reg, size);
+		err = tdx_mmio_write(size, ve->gpa, &val);
+		break;
+	case MMIO_WRITE_IMM:
+		val = insn.immediate.value;
+		err = tdx_mmio_write(size, ve->gpa, &val);
+		break;
+	case MMIO_READ:
+		err = tdx_mmio_read(size, ve->gpa, &val);
+		if (err)
+			break;
+		/* Zero-extend for 32-bit operation */
+		if (size == 4)
+			*reg = 0;
+		memcpy(reg, &val, size);
+		break;
+	case MMIO_READ_ZERO_EXTEND:
+		err = tdx_mmio_read(size, ve->gpa, &val);
+		if (err)
+			break;
+
+		/* Zero extend based on operand size */
+		memset(reg, 0, insn.opnd_bytes);
+		memcpy(reg, &val, size);
+		break;
+	case MMIO_READ_SIGN_EXTEND: {
+		u8 sign_byte = 0, msb = 7;
+
+		err = tdx_mmio_read(size, ve->gpa, &val);
+		if (err)
+			break;
+
+		if (size > 1)
+			msb = 15;
+
+		if (val & BIT(msb))
+			sign_byte = -1;
+
+		/* Sign extend based on operand size */
+		memset(reg, sign_byte, insn.opnd_bytes);
+		memcpy(reg, &val, size);
+		break;
+	}
+	case MMIO_MOVS:
+	case MMIO_DECODE_FAILED:
+		return -EFAULT;
+	}
+
+	if (err)
+		return -EFAULT;
+
+	return insn.length;
+}
+
 bool tdx_get_ve_info(struct ve_info *ve)
 {
 	struct tdx_module_output out;
@@ -219,6 +327,12 @@ static bool tdx_virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
 	case EXIT_REASON_CPUID:
 		ret = tdx_handle_cpuid(regs);
 		break;
+	case EXIT_REASON_EPT_VIOLATION:
+		ve->instr_len = tdx_handle_mmio(regs, ve);
+		ret = ve->instr_len > 0;
+		if (!ret)
+			pr_warn_once("MMIO failed\n");
+		break;
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		break;
-- 
2.34.1

