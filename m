Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A504F91D6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiDHJRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbiDHJMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:12:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B41208C1F;
        Fri,  8 Apr 2022 02:09:15 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:09:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408954;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tIryPXK4hXnFXwPHjp1ETODFKmVczIij0SI9t3dupNE=;
        b=dmxBUpcIy1XngegQxc1CXVPzBOGfiFDiKJrWsOLulxtx5JAecDSoGmbl7OlZavs6/CUSEc
        S9KK1IJjm/oJlIcDFH8AzFF9YT9N1KSouQX0iQGJCNnhH3zPGj16Tz/Y1Q9NwDXah0Xd+3
        NQ6v7dJHjivYmkTzcVivWVA0zcvlg8f7pyqcV9Ykpng3sIbB9jFyF/Dp+M85NsOtN6FL58
        1xACIdhu9xP82Hej2nmEFqCEDKgE4JHRBfAY0mXE9/TlbeOwrieOgGP/fMLOde4tLY+9ye
        3jYa0BtKbxyjr/wYZG84BsPGl6M+Mm5JYyDjAh817K/neLrBtblhTuzCqbHnBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408954;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tIryPXK4hXnFXwPHjp1ETODFKmVczIij0SI9t3dupNE=;
        b=BPXSwpnO/nY1qgLrDAkvCZ8CPNLY9MGgBh149WSkXFLnstihzm/DgfNSs/ScdSkCXKHqMn
        XtfZWlPN2mQVTOBQ==
From:   "tip-bot2 for Michael Roth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/compressed/64: Detect/setup SEV/SME features
 earlier during boot
Cc:     Michael Roth <michael.roth@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-8-brijesh.singh@amd.com>
References: <20220307213356.2797205-8-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940895338.389.8000288295741940886.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     ec1c66af3a30d45c2420da0974c01d3515dba26e
Gitweb:        https://git.kernel.org/tip/ec1c66af3a30d45c2420da0974c01d3515dba26e
Author:        Michael Roth <michael.roth@amd.com>
AuthorDate:    Wed, 09 Feb 2022 12:10:01 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 Apr 2022 13:02:21 +02:00

x86/compressed/64: Detect/setup SEV/SME features earlier during boot

With upcoming SEV-SNP support, SEV-related features need to be
initialized earlier during boot, at the same point the initial #VC
handler is set up, so that the SEV-SNP CPUID table can be utilized
during the initial feature checks. Also, SEV-SNP feature detection
will rely on EFI helper functions to scan the EFI config table for the
Confidential Computing blob, and so would need to be implemented at
least partially in C.

Currently set_sev_encryption_mask() is used to initialize the
sev_status and sme_me_mask globals that advertise what SEV/SME features
are available in a guest. Rename it to sev_enable() to better reflect
that (SME is only enabled in the case of SEV guests in the
boot/compressed kernel), and move it to just after the stage1 #VC
handler is set up so that it can be used to initialize SEV-SNP as well
in future patches.

While at it, re-implement it as C code so that all SEV feature
detection can be better consolidated with upcoming SEV-SNP feature
detection, which will also be in C.

The 32-bit entry path remains unchanged, as it never relied on the
set_sev_encryption_mask() initialization to begin with.

  [ bp: Massage commit message. ]

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-8-brijesh.singh@amd.com
---
 arch/x86/boot/compressed/head_64.S     | 37 ++++++++++++++-----------
 arch/x86/boot/compressed/mem_encrypt.S | 36 +------------------------
 arch/x86/boot/compressed/misc.h        |  4 +--
 arch/x86/boot/compressed/sev.c         | 36 ++++++++++++++++++++++++-
 4 files changed, 60 insertions(+), 53 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index dea9530..4cd6611 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -189,11 +189,11 @@ SYM_FUNC_START(startup_32)
 	subl	$32, %eax	/* Encryption bit is always above bit 31 */
 	bts	%eax, %edx	/* Set encryption mask for page tables */
 	/*
-	 * Mark SEV as active in sev_status so that startup32_check_sev_cbit()
-	 * will do a check. The sev_status memory will be fully initialized
-	 * with the contents of MSR_AMD_SEV_STATUS later in
-	 * set_sev_encryption_mask(). For now it is sufficient to know that SEV
-	 * is active.
+	 * Set MSR_AMD64_SEV_ENABLED_BIT in sev_status so that
+	 * startup32_check_sev_cbit() will do a check. sev_enable() will
+	 * initialize sev_status with all the bits reported by
+	 * MSR_AMD_SEV_STATUS later, but only MSR_AMD64_SEV_ENABLED_BIT
+	 * needs to be set for now.
 	 */
 	movl	$1, rva(sev_status)(%ebp)
 1:
@@ -447,6 +447,23 @@ SYM_CODE_START(startup_64)
 	call	load_stage1_idt
 	popq	%rsi
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	/*
+	 * Now that the stage1 interrupt handlers are set up, #VC exceptions from
+	 * CPUID instructions can be properly handled for SEV-ES guests.
+	 *
+	 * For SEV-SNP, the CPUID table also needs to be set up in advance of any
+	 * CPUID instructions being issued, so go ahead and do that now via
+	 * sev_enable(), which will also handle the rest of the SEV-related
+	 * detection/setup to ensure that has been done in advance of any dependent
+	 * code.
+	 */
+	pushq	%rsi
+	movq	%rsi, %rdi		/* real mode address */
+	call	sev_enable
+	popq	%rsi
+#endif
+
 	/*
 	 * paging_prepare() sets up the trampoline and checks if we need to
 	 * enable 5-level paging.
@@ -558,17 +575,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	shrq	$3, %rcx
 	rep	stosq
 
-/*
- * If running as an SEV guest, the encryption mask is required in the
- * page-table setup code below. When the guest also has SEV-ES enabled
- * set_sev_encryption_mask() will cause #VC exceptions, but the stage2
- * handler can't map its GHCB because the page-table is not set up yet.
- * So set up the encryption mask here while still on the stage1 #VC
- * handler. Then load stage2 IDT and switch to the kernel's own
- * page-table.
- */
 	pushq	%rsi
-	call	set_sev_encryption_mask
 	call	load_stage2_idt
 
 	/* Pass boot_params to initialize_identity_maps() */
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index a63424d..a73e4d7 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -187,42 +187,6 @@ SYM_CODE_END(startup32_vc_handler)
 	.code64
 
 #include "../../kernel/sev_verify_cbit.S"
-SYM_FUNC_START(set_sev_encryption_mask)
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-	push	%rbp
-	push	%rdx
-
-	movq	%rsp, %rbp		/* Save current stack pointer */
-
-	call	get_sev_encryption_bit	/* Get the encryption bit position */
-	testl	%eax, %eax
-	jz	.Lno_sev_mask
-
-	bts	%rax, sme_me_mask(%rip)	/* Create the encryption mask */
-
-	/*
-	 * Read MSR_AMD64_SEV again and store it to sev_status. Can't do this in
-	 * get_sev_encryption_bit() because this function is 32-bit code and
-	 * shared between 64-bit and 32-bit boot path.
-	 */
-	movl	$MSR_AMD64_SEV, %ecx	/* Read the SEV MSR */
-	rdmsr
-
-	/* Store MSR value in sev_status */
-	shlq	$32, %rdx
-	orq	%rdx, %rax
-	movq	%rax, sev_status(%rip)
-
-.Lno_sev_mask:
-	movq	%rbp, %rsp		/* Restore original stack pointer */
-
-	pop	%rdx
-	pop	%rbp
-#endif
-
-	xor	%rax, %rax
-	RET
-SYM_FUNC_END(set_sev_encryption_mask)
 
 	.data
 
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 16ed360..23e0e39 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -120,12 +120,12 @@ static inline void console_init(void)
 { }
 #endif
 
-void set_sev_encryption_mask(void);
-
 #ifdef CONFIG_AMD_MEM_ENCRYPT
+void sev_enable(struct boot_params *bp);
 void sev_es_shutdown_ghcb(void);
 extern bool sev_es_check_ghcb_fault(unsigned long address);
 #else
+static inline void sev_enable(struct boot_params *bp) { }
 static inline void sev_es_shutdown_ghcb(void) { }
 static inline bool sev_es_check_ghcb_fault(unsigned long address)
 {
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 4e82101..27ccd5a 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -201,3 +201,39 @@ finish:
 	else if (result != ES_RETRY)
 		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
 }
+
+void sev_enable(struct boot_params *bp)
+{
+	unsigned int eax, ebx, ecx, edx;
+	struct msr m;
+
+	/* Check for the SME/SEV support leaf */
+	eax = 0x80000000;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+	if (eax < 0x8000001f)
+		return;
+
+	/*
+	 * Check for the SME/SEV feature:
+	 *   CPUID Fn8000_001F[EAX]
+	 *   - Bit 0 - Secure Memory Encryption support
+	 *   - Bit 1 - Secure Encrypted Virtualization support
+	 *   CPUID Fn8000_001F[EBX]
+	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
+	 */
+	eax = 0x8000001f;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+	/* Check whether SEV is supported */
+	if (!(eax & BIT(1)))
+		return;
+
+	/* Set the SME mask if this is an SEV guest. */
+	boot_rdmsr(MSR_AMD64_SEV, &m);
+	sev_status = m.q;
+	if (!(sev_status & MSR_AMD64_SEV_ENABLED))
+		return;
+
+	sme_me_mask = BIT_ULL(ebx & 0x3f);
+}
