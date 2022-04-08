Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A55C4F91BD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbiDHJPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbiDHJMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:12:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5693F1E8178;
        Fri,  8 Apr 2022 02:09:06 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:09:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5+kS7gqY1mEw8SV5EGeDcJsEJspGCgs9JPjHrBdHDjw=;
        b=bRfq3OPVeG1WDV/4cUwVTZn8uu6kmMBL2D5ISdi+NUQy1SVfJBXk0HI+uRDiq16hLZGcui
        +9zC8FRbe0rtfUeuqcbfdqvmroQlcYye41NEOG4pULOTeCmfkAv7/DK+bxFGmmxQ/hutkj
        jlkwCMVB2O2WGEft2eXLYcj05C4xBoAIrpQ+hsD2IMIcNIEwlRzQnXaeMm2GYTF3bx27N8
        CloXa8Ei3maTmvUdNUFuRuxfYq8q5S1+LM+tUoxqE/w48SvGZtuItdMFPfqkjkDCsX5FWl
        AASuFN5K4U42L6p8eUh0zO/ZpRLvec2dwmrDTesjuUonPwIidqBIIYKr96p5jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5+kS7gqY1mEw8SV5EGeDcJsEJspGCgs9JPjHrBdHDjw=;
        b=to1wvBGa5OErnde80VzQ5QbEFpCPOw6s6PgCaM+BWePm31R1BOznfCK4XIoE3EzWAPAPsT
        DVYu2tkR0B3+w0DQ==
From:   "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Add helper for validating pages in early enc
 attribute changes
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Venu Busireddy <venu.busireddy@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-19-brijesh.singh@amd.com>
References: <20220307213356.2797205-19-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940894388.389.4516366060082741445.tip-bot2@tip-bot2>
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

Commit-ID:     5e5ccff60a2977142d39b987a8b90e422d9fc634
Gitweb:        https://git.kernel.org/tip/5e5ccff60a2977142d39b987a8b90e422d9fc634
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Wed, 09 Feb 2022 12:10:12 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 Apr 2022 13:22:54 +02:00

x86/sev: Add helper for validating pages in early enc attribute changes

early_set_memory_{encrypted,decrypted}() are used for changing the page
state from decrypted (shared) to encrypted (private) and vice versa.

When SEV-SNP is active, the page state transition needs to go through
additional steps.

If the page is transitioned from shared to private, then perform the
following after the encryption attribute is set in the page table:

1. Issue the page state change VMGEXIT to add the page as a private
   in the RMP table.
2. Validate the page after its successfully added in the RMP table.

To maintain the security guarantees, if the page is transitioned from
private to shared, then perform the following before clearing the
encryption attribute from the page table.

1. Invalidate the page.
2. Issue the page state change VMGEXIT to make the page shared in the
   RMP table.

early_set_memory_{encrypted,decrypted}() can be called before the GHCB
is setup so use the SNP page state MSR protocol VMGEXIT defined in the
GHCB specification to request the page state change in the RMP table.

While at it, add a helper snp_prep_memory() which will be used in
probe_roms(), in a later patch.

  [ bp: Massage commit message. ]

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
Link: https://lore.kernel.org/r/20220307213356.2797205-19-brijesh.singh@amd.com
---
 arch/x86/include/asm/sev.h    |  10 +++-
 arch/x86/kernel/sev.c         |  99 +++++++++++++++++++++++++++++++++-
 arch/x86/mm/mem_encrypt_amd.c |  58 +++++++++++++++++--
 3 files changed, 163 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 48df027..f65d257 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -123,6 +123,11 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
 	return rc;
 }
 void setup_ghcb(void);
+void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
+					 unsigned int npages);
+void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
+					unsigned int npages);
+void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -132,6 +137,11 @@ static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
 static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
 static inline void setup_ghcb(void) { }
+static inline void __init
+early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned int npages) { }
+static inline void __init
+early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned int npages) { }
+static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op) { }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 39c8746..e3fca86 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -556,6 +556,105 @@ static u64 get_jump_table_addr(void)
 	return ret;
 }
 
+static void pvalidate_pages(unsigned long vaddr, unsigned int npages, bool validate)
+{
+	unsigned long vaddr_end;
+	int rc;
+
+	vaddr = vaddr & PAGE_MASK;
+	vaddr_end = vaddr + (npages << PAGE_SHIFT);
+
+	while (vaddr < vaddr_end) {
+		rc = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
+		if (WARN(rc, "Failed to validate address 0x%lx ret %d", vaddr, rc))
+			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+
+		vaddr = vaddr + PAGE_SIZE;
+	}
+}
+
+static void __init early_set_pages_state(unsigned long paddr, unsigned int npages, enum psc_op op)
+{
+	unsigned long paddr_end;
+	u64 val;
+
+	paddr = paddr & PAGE_MASK;
+	paddr_end = paddr + (npages << PAGE_SHIFT);
+
+	while (paddr < paddr_end) {
+		/*
+		 * Use the MSR protocol because this function can be called before
+		 * the GHCB is established.
+		 */
+		sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
+		VMGEXIT();
+
+		val = sev_es_rd_ghcb_msr();
+
+		if (WARN(GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP,
+			 "Wrong PSC response code: 0x%x\n",
+			 (unsigned int)GHCB_RESP_CODE(val)))
+			goto e_term;
+
+		if (WARN(GHCB_MSR_PSC_RESP_VAL(val),
+			 "Failed to change page state to '%s' paddr 0x%lx error 0x%llx\n",
+			 op == SNP_PAGE_STATE_PRIVATE ? "private" : "shared",
+			 paddr, GHCB_MSR_PSC_RESP_VAL(val)))
+			goto e_term;
+
+		paddr = paddr + PAGE_SIZE;
+	}
+
+	return;
+
+e_term:
+	sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
+}
+
+void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
+					 unsigned int npages)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	 /*
+	  * Ask the hypervisor to mark the memory pages as private in the RMP
+	  * table.
+	  */
+	early_set_pages_state(paddr, npages, SNP_PAGE_STATE_PRIVATE);
+
+	/* Validate the memory pages after they've been added in the RMP table. */
+	pvalidate_pages(vaddr, npages, true);
+}
+
+void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
+					unsigned int npages)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	/* Invalidate the memory pages before they are marked shared in the RMP table. */
+	pvalidate_pages(vaddr, npages, false);
+
+	 /* Ask hypervisor to mark the memory pages shared in the RMP table. */
+	early_set_pages_state(paddr, npages, SNP_PAGE_STATE_SHARED);
+}
+
+void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op)
+{
+	unsigned long vaddr, npages;
+
+	vaddr = (unsigned long)__va(paddr);
+	npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
+
+	if (op == SNP_PAGE_STATE_PRIVATE)
+		early_snp_set_memory_private(vaddr, paddr, npages);
+	else if (op == SNP_PAGE_STATE_SHARED)
+		early_snp_set_memory_shared(vaddr, paddr, npages);
+	else
+		WARN(1, "invalid memory op %d\n", op);
+}
+
 int sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
 {
 	u16 startup_cs, startup_ip;
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 6169053..8539dd6 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -31,6 +31,7 @@
 #include <asm/processor-flags.h>
 #include <asm/msr.h>
 #include <asm/cmdline.h>
+#include <asm/sev.h>
 
 #include "mm_internal.h"
 
@@ -48,6 +49,36 @@ EXPORT_SYMBOL(sme_me_mask);
 static char sme_early_buffer[PAGE_SIZE] __initdata __aligned(PAGE_SIZE);
 
 /*
+ * SNP-specific routine which needs to additionally change the page state from
+ * private to shared before copying the data from the source to destination and
+ * restore after the copy.
+ */
+static inline void __init snp_memcpy(void *dst, void *src, size_t sz,
+				     unsigned long paddr, bool decrypt)
+{
+	unsigned long npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
+
+	if (decrypt) {
+		/*
+		 * @paddr needs to be accessed decrypted, mark the page shared in
+		 * the RMP table before copying it.
+		 */
+		early_snp_set_memory_shared((unsigned long)__va(paddr), paddr, npages);
+
+		memcpy(dst, src, sz);
+
+		/* Restore the page state after the memcpy. */
+		early_snp_set_memory_private((unsigned long)__va(paddr), paddr, npages);
+	} else {
+		/*
+		 * @paddr need to be accessed encrypted, no need for the page state
+		 * change.
+		 */
+		memcpy(dst, src, sz);
+	}
+}
+
+/*
  * This routine does not change the underlying encryption setting of the
  * page(s) that map this memory. It assumes that eventually the memory is
  * meant to be accessed as either encrypted or decrypted but the contents
@@ -95,8 +126,13 @@ static void __init __sme_early_enc_dec(resource_size_t paddr,
 		 * Use a temporary buffer, of cache-line multiple size, to
 		 * avoid data corruption as documented in the APM.
 		 */
-		memcpy(sme_early_buffer, src, len);
-		memcpy(dst, sme_early_buffer, len);
+		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
+			snp_memcpy(sme_early_buffer, src, len, paddr, enc);
+			snp_memcpy(dst, sme_early_buffer, len, paddr, !enc);
+		} else {
+			memcpy(sme_early_buffer, src, len);
+			memcpy(dst, sme_early_buffer, len);
+		}
 
 		early_memunmap(dst, len);
 		early_memunmap(src, len);
@@ -322,14 +358,28 @@ static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
 	clflush_cache_range(__va(pa), size);
 
 	/* Encrypt/decrypt the contents in-place */
-	if (enc)
+	if (enc) {
 		sme_early_encrypt(pa, size);
-	else
+	} else {
 		sme_early_decrypt(pa, size);
 
+		/*
+		 * ON SNP, the page state in the RMP table must happen
+		 * before the page table updates.
+		 */
+		early_snp_set_memory_shared((unsigned long)__va(pa), pa, 1);
+	}
+
 	/* Change the page encryption mask. */
 	new_pte = pfn_pte(pfn, new_prot);
 	set_pte_atomic(kpte, new_pte);
+
+	/*
+	 * If page is set encrypted in the page table, then update the RMP table to
+	 * add this page as private.
+	 */
+	if (enc)
+		early_snp_set_memory_private((unsigned long)__va(pa), pa, 1);
 }
 
 static int __init early_set_memory_enc_dec(unsigned long vaddr,
