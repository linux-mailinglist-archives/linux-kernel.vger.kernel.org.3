Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542E04745E0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbhLNPEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:04:44 -0500
Received: from mga05.intel.com ([192.55.52.43]:40274 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235196AbhLNPDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:03:25 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="325270459"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="325270459"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 07:03:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="519249923"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 14 Dec 2021 07:03:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 7B53981E; Tue, 14 Dec 2021 17:03:09 +0200 (EET)
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
Subject: [PATCH 08/26] x86/tdx: Handle in-kernel MMIO
Date:   Tue, 14 Dec 2021 18:02:46 +0300
Message-Id: <20211214150304.62613-9-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In non-TDX VMs, MMIO is implemented by providing the guest a mapping
which will cause a VMEXIT on access and then the VMM emulating the
instruction that caused the VMEXIT. That's not possible in TDX guests
because it requires exposing guest register and memory state to
potentially malicious VMM.

In TDX the MMIO regions are instead configured to trigger a #VE
exception in the guest. The guest #VE handler then emulates the MMIO
instruction inside the guest and converts them into a controlled
hypercall to the host.

MMIO addresses can be used with any CPU instruction that accesses the
memory. This patch, however, covers only MMIO accesses done via io.h
helpers, such as 'readl()' or 'writeq()'.

MMIO access via other means (like structure overlays) may result in
MMIO_DECODE_FAILED and an oops.

AMD SEV has the same limitations to MMIO handling.

=== Potential alternative approaches ===

== Paravirtualizing all MMIO ==

An alternative to letting MMIO induce a #VE exception is to avoid
the #VE in the first place. Similar to the port I/O case, it is
theoretically possible to paravirtualize MMIO accesses.

Like the exception-based approach offered by this patch, a fully
paravirtualized approach would be limited to MMIO users that leverage
common infrastructure like the io.h macros.

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
makes virtio eminently easy to patch. Future patches will implement this
idea, removing the bulk of MMIO #VEs.

Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/tdx.c | 110 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index e1c757d1720c..b04802b4b69e 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -7,6 +7,8 @@
 #include <linux/cpufeature.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
+#include <asm/insn.h>
+#include <asm/insn-eval.h>
 
 /* TDX Module Call Leaf IDs */
 #define TDX_GET_VEINFO			3
@@ -155,6 +157,108 @@ static bool tdx_handle_cpuid(struct pt_regs *regs)
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
+	u8 sign_byte;
+	bool err;
+
+	if (copy_from_kernel_nofault(buffer, (void *)regs->ip, MAX_INSN_SIZE))
+		return -EFAULT;
+
+	insn_init(&insn, buffer, MAX_INSN_SIZE, 1);
+	insn_get_length(&insn);
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
+	case MMIO_READ_SIGN_EXTEND:
+		err = tdx_mmio_read(size, ve->gpa, &val);
+		if (err)
+			break;
+
+		if (size == 1)
+			sign_byte = (val & 0x80) ? 0xff : 0x00;
+		else
+			sign_byte = (val & 0x8000) ? 0xff : 0x00;
+
+		/* Sign extend based on operand size */
+		memset(reg, sign_byte, insn.opnd_bytes);
+		memcpy(reg, &val, size);
+		break;
+	case MMIO_MOVS:
+	case MMIO_DECODE_FAILED:
+		return -EFAULT;
+	}
+
+	if (err)
+		return -EFAULT;
+	return insn.length;
+}
+
 bool tdx_get_ve_info(struct ve_info *ve)
 {
 	struct tdx_module_output out;
@@ -228,6 +332,12 @@ static bool tdx_virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
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
2.32.0

