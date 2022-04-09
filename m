Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCB24FA11E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240408AbiDIBa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240268AbiDIB3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:29:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8DD107AB9;
        Fri,  8 Apr 2022 18:27:28 -0700 (PDT)
Date:   Sat, 09 Apr 2022 01:27:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649467647;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Quwr4eD1qwR/WzLg+NmQlvlOYzEm46ljs1pnMfB2pw=;
        b=yRnz4HQW7rm7X7Ag/hgVBsoVSJ16pvqM/rJRokYebjb9Q7UQQr/6qPboFXSTc3Opx/wS7Y
        BoR4nWRvEh35Rtf65j21tb724N25fEiau7uo4n4qQAhuOT8vo+hFIgWC3HwclVMXa2ZZ/C
        evljm3AgxZynXjLv/TKpycpop2Xsx0ZBkV2cVwNvglo3yLmsvFNWnhHVhad2HUhQ+zif/Q
        abAJKkswLSBIFw1bclwfckxoVywvLlSK5lunew7Rq++suwF9FuDxj8CA0invhK+6h7xsvI
        ofmK+pqIpZDR5CDxNI2PHVZAE4n8hPoq9I61scj6KgH5/BZbq6DG/pxV4E3LIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649467647;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Quwr4eD1qwR/WzLg+NmQlvlOYzEm46ljs1pnMfB2pw=;
        b=l5IHqHbNjY27YWMO5C222f5igRiUrw1KKbgYml44MZqXqaid4kSn5dNCQODn2cMvQHkJaC
        keKH+TT0vqXTfWAw==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/boot: Add a trampoline for booting APs via
 firmware handoff
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405232939.73860-21-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-21-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164946764643.4207.6472120157833891449.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     ff2e64684f153a61f6ae553e860af4b6ef2f4ca5
Gitweb:        https://git.kernel.org/tip/ff2e64684f153a61f6ae553e860af4b6ef2f4ca5
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Wed, 06 Apr 2022 02:29:29 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Apr 2022 08:27:52 -07:00

x86/boot: Add a trampoline for booting APs via firmware handoff

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

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20220405232939.73860-21-kirill.shutemov@linux.intel.com
---
 arch/x86/include/asm/apic.h              |  2 +-
 arch/x86/include/asm/realmode.h          |  1 +-
 arch/x86/kernel/smpboot.c                | 12 +++++--
 arch/x86/realmode/rm/header.S            |  1 +-
 arch/x86/realmode/rm/trampoline_64.S     | 38 +++++++++++++++++++++++-
 arch/x86/realmode/rm/trampoline_common.S | 12 ++++++-
 6 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 48067af..35006e1 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -328,6 +328,8 @@ struct apic {
 
 	/* wakeup_secondary_cpu */
 	int	(*wakeup_secondary_cpu)(int apicid, unsigned long start_eip);
+	/* wakeup secondary CPU using 64-bit wakeup point */
+	int	(*wakeup_secondary_cpu_64)(int apicid, unsigned long start_eip);
 
 	void	(*inquire_remote_apic)(int apicid);
 
diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index 331474b..fd6f6e5 100644
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
index 2ef1477..870cc5d 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1082,6 +1082,11 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
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
@@ -1123,11 +1128,14 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 
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
index 8c1db5b..2eb62be 100644
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
index cc8391f..ae112a9 100644
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
index 5033e64..4331c32 100644
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
