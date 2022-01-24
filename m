Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C2D4982ED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243251AbiAXPDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:03:12 -0500
Received: from mga17.intel.com ([192.55.52.151]:63901 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239694AbiAXPC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:02:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643036548; x=1674572548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ny8hPu4sqyibLkN69362ey04CLPXYx99o5E/SzjH7Yk=;
  b=OzFHx6w5Oc3JkCrLOQyECwxcM281PFPHWEk9uZ8GqkzUAgZlGZscZOfK
   dT3purxiz9wvqOtT6Kj0RuGkmkzXt2s/4m0OQdqA+qUqPhxQo87LdBDmw
   9RJ8z0Wt50eJvSA7okWXeRm9PF4+3glgNjiQ/NQPBumOBxHbIj4ZPX2/W
   iimxa6Bz90nAyfJTjq1Vie8A9V6b/zDNTWoOWtE7PnP3elnE46z21Skiu
   PbvnL8qBNakoH6BIx0Tgv1cCPsLXam3UMBSwy6T9oOFpDqcYfhZCIpjVw
   io9KHhb5/nehd8qb8uI5xITipHPlVwziFnGIMzF5Cj3+O24aGkb5f+/CL
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="226734707"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="226734707"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:02:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="562680259"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 24 Jan 2022 07:02:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 1CBD8ACE; Mon, 24 Jan 2022 17:02:20 +0200 (EET)
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
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kai Huang <kai.huang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 16/29] x86/boot: Add a trampoline for booting APs via firmware handoff
Date:   Mon, 24 Jan 2022 18:02:02 +0300
Message-Id: <20220124150215.36893-17-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Historically, x86 platforms have booted secondary processors (APs)
using INIT followed by the start up IPI (SIPI) messages. In regular
VMs, this boot sequence is supported by the VMM emulation. But such a
wakeup model is fatal for secure VMs like TDX in which VMM is an
untrusted entity. To address this issue, a new wakeup model was added
in ACPI v6.4, in which firmware (like TDX virtual BIOS) will help boot
the APs. More details about this wakeup model can be found in ACPI
specification v6.4, the section titled "Multiprocessor Wakeup Structure".

Since the existing trampoline code requires processors to boot in real
mode with 16-bit addressing, it will not work for this wakeup model
(because it boots the AP in 64-bit mode). To handle it, extend the
trampoline code to support 64-bit mode firmware handoff. Also, extend
IDT and GDT pointers to support 64-bit mode hand off.

There is no TDX-specific detection for this new boot method. The kernel
will rely on it as the sole boot method whenever the new ACPI structure
is present.

The ACPI table parser for the MADT multiprocessor wake up structure and
the wakeup method that uses this structure will be added by the following
patch in this series.

Reported-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/apic.h              |  2 ++
 arch/x86/include/asm/realmode.h          |  1 +
 arch/x86/kernel/smpboot.c                | 12 ++++++--
 arch/x86/realmode/rm/header.S            |  1 +
 arch/x86/realmode/rm/trampoline_64.S     | 38 ++++++++++++++++++++++++
 arch/x86/realmode/rm/trampoline_common.S | 12 +++++++-
 6 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 48067af94678..35006e151774 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -328,6 +328,8 @@ struct apic {
 
 	/* wakeup_secondary_cpu */
 	int	(*wakeup_secondary_cpu)(int apicid, unsigned long start_eip);
+	/* wakeup secondary CPU using 64-bit wakeup point */
+	int	(*wakeup_secondary_cpu_64)(int apicid, unsigned long start_eip);
 
 	void	(*inquire_remote_apic)(int apicid);
 
diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index 331474b150f1..fd6f6e5b755a 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -25,6 +25,7 @@ struct real_mode_header {
 	u32	sev_es_trampoline_start;
 #endif
 #ifdef CONFIG_X86_64
+	u32	trampoline_start64;
 	u32	trampoline_pgd;
 #endif
 	/* ACPI S3 wakeup */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 617012f4619f..6269dd126dba 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1088,6 +1088,11 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 	unsigned long boot_error = 0;
 	unsigned long timeout;
 
+#ifdef CONFIG_X86_64
+	/* If 64-bit wakeup method exists, use the 64-bit mode trampoline IP */
+	if (apic->wakeup_secondary_cpu_64)
+		start_ip = real_mode_header->trampoline_start64;
+#endif
 	idle->thread.sp = (unsigned long)task_pt_regs(idle);
 	early_gdt_descr.address = (unsigned long)get_cpu_gdt_rw(cpu);
 	initial_code = (unsigned long)start_secondary;
@@ -1129,11 +1134,14 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 
 	/*
 	 * Wake up a CPU in difference cases:
-	 * - Use the method in the APIC driver if it's defined
+	 * - Use a method from the APIC driver if one defined, with wakeup
+	 *   straight to 64-bit mode preferred over wakeup to RM.
 	 * Otherwise,
 	 * - Use an INIT boot APIC message for APs or NMI for BSP.
 	 */
-	if (apic->wakeup_secondary_cpu)
+	if (apic->wakeup_secondary_cpu_64)
+		boot_error = apic->wakeup_secondary_cpu_64(apicid, start_ip);
+	else if (apic->wakeup_secondary_cpu)
 		boot_error = apic->wakeup_secondary_cpu(apicid, start_ip);
 	else
 		boot_error = wakeup_cpu_via_init_nmi(cpu, start_ip, apicid,
diff --git a/arch/x86/realmode/rm/header.S b/arch/x86/realmode/rm/header.S
index 8c1db5bf5d78..2eb62be6d256 100644
--- a/arch/x86/realmode/rm/header.S
+++ b/arch/x86/realmode/rm/header.S
@@ -24,6 +24,7 @@ SYM_DATA_START(real_mode_header)
 	.long	pa_sev_es_trampoline_start
 #endif
 #ifdef CONFIG_X86_64
+	.long	pa_trampoline_start64
 	.long	pa_trampoline_pgd;
 #endif
 	/* ACPI S3 wakeup */
diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index cc8391f86cdb..ae112a91592f 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -161,6 +161,19 @@ SYM_CODE_START(startup_32)
 	ljmpl	$__KERNEL_CS, $pa_startup_64
 SYM_CODE_END(startup_32)
 
+SYM_CODE_START(pa_trampoline_compat)
+	/*
+	 * In compatibility mode.  Prep ESP and DX for startup_32, then disable
+	 * paging and complete the switch to legacy 32-bit mode.
+	 */
+	movl	$rm_stack_end, %esp
+	movw	$__KERNEL_DS, %dx
+
+	movl	$X86_CR0_PE, %eax
+	movl	%eax, %cr0
+	ljmpl   $__KERNEL32_CS, $pa_startup_32
+SYM_CODE_END(pa_trampoline_compat)
+
 	.section ".text64","ax"
 	.code64
 	.balign 4
@@ -169,6 +182,20 @@ SYM_CODE_START(startup_64)
 	jmpq	*tr_start(%rip)
 SYM_CODE_END(startup_64)
 
+SYM_CODE_START(trampoline_start64)
+	/*
+	 * APs start here on a direct transfer from 64-bit BIOS with identity
+	 * mapped page tables.  Load the kernel's GDT in order to gear down to
+	 * 32-bit mode (to handle 4-level vs. 5-level paging), and to (re)load
+	 * segment registers.  Load the zero IDT so any fault triggers a
+	 * shutdown instead of jumping back into BIOS.
+	 */
+	lidt	tr_idt(%rip)
+	lgdt	tr_gdt64(%rip)
+
+	ljmpl	*tr_compat(%rip)
+SYM_CODE_END(trampoline_start64)
+
 	.section ".rodata","a"
 	# Duplicate the global descriptor table
 	# so the kernel can live anywhere
@@ -182,6 +209,17 @@ SYM_DATA_START(tr_gdt)
 	.quad	0x00cf93000000ffff	# __KERNEL_DS
 SYM_DATA_END_LABEL(tr_gdt, SYM_L_LOCAL, tr_gdt_end)
 
+SYM_DATA_START(tr_gdt64)
+	.short	tr_gdt_end - tr_gdt - 1	# gdt limit
+	.long	pa_tr_gdt
+	.long	0
+SYM_DATA_END(tr_gdt64)
+
+SYM_DATA_START(tr_compat)
+	.long	pa_trampoline_compat
+	.short	__KERNEL32_CS
+SYM_DATA_END(tr_compat)
+
 	.bss
 	.balign	PAGE_SIZE
 SYM_DATA(trampoline_pgd, .space PAGE_SIZE)
diff --git a/arch/x86/realmode/rm/trampoline_common.S b/arch/x86/realmode/rm/trampoline_common.S
index 5033e640f957..4331c32c47f8 100644
--- a/arch/x86/realmode/rm/trampoline_common.S
+++ b/arch/x86/realmode/rm/trampoline_common.S
@@ -1,4 +1,14 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 	.section ".rodata","a"
 	.balign	16
-SYM_DATA_LOCAL(tr_idt, .fill 1, 6, 0)
+
+/*
+ * When a bootloader hands off to the kernel in 32-bit mode an
+ * IDT with a 2-byte limit and 4-byte base is needed. When a boot
+ * loader hands off to a kernel 64-bit mode the base address
+ * extends to 8-bytes. Reserve enough space for either scenario.
+ */
+SYM_DATA_START_LOCAL(tr_idt)
+	.short  0
+	.quad   0
+SYM_DATA_END(tr_idt)
-- 
2.34.1

