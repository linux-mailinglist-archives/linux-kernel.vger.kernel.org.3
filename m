Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859034C2B5D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbiBXMAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiBXL76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:59:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBFC4BB80;
        Thu, 24 Feb 2022 03:59:27 -0800 (PST)
Date:   Thu, 24 Feb 2022 11:59:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645703964;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UmBpWzy3lWgUZUhYW+ZYYUhZQC1W6qom86xrfEnbBR4=;
        b=JkngnYGKBksdbIWArqnRjC5pec6stmLjcySzAXobMeePv40P/LuHasYExeKVUOCzlAcymS
        x642h1DZbSvjKinYjSDlPAVl5RzFJpUwKDp8Fv8B4qzPdyvP/7U6SbPJNWPHkYwMH4Xe9T
        OX5rGLBcRxN1CEQfu3ajxuf4aSbwLP7gqyZqkz+WRFZIUzu8yMm6+8h6C9jt7PyDmkM7wL
        9Ch+37VF92tnN0O1fnmClstq9KRUOfSI9LQoDPdwK0MFGIy6xBz3/n41URS9D0PoCYSyaa
        OWq9D6/u9iN0DVvpCgXHH/m5ONqoPUbFsQY+QKXTVrp5Z/MDqKSkz0KrUnC+/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645703964;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UmBpWzy3lWgUZUhYW+ZYYUhZQC1W6qom86xrfEnbBR4=;
        b=mUgCUhUClMz4PeLPLAIOigYzFG+Mh2doQh5a8bNIwLCEw7NglhSXjrj4zc7qmIvZ/iXtIa
        EWQKbvofX+CKthCQ==
From:   "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] x86/mm/cpa: Generalize __set_memory_enc_pgtable()
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220223043528.2093214-1-brijesh.singh@amd.com>
References: <20220223043528.2093214-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164570396297.16921.7015409396964718964.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     1e8c5971c249893ac33ca983c32bafcf5d50c727
Gitweb:        https://git.kernel.org/tip/1e8c5971c249893ac33ca983c32bafcf5d50c727
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Tue, 22 Feb 2022 22:35:28 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Feb 2022 19:14:29 +01:00

x86/mm/cpa: Generalize __set_memory_enc_pgtable()

The kernel provides infrastructure to set or clear the encryption mask
from the pages for AMD SEV, but TDX requires few tweaks.

- TDX and SEV have different requirements to the cache and TLB
  flushing.

- TDX has own routine to notify VMM about page encryption status change.

Modify __set_memory_enc_pgtable() and make it flexible enough to cover
both AMD SEV and Intel TDX. The AMD-specific behavior is isolated in the
callbacks under x86_platform.guest. TDX will provide own version of said
callbacks.

  [ bp: Beat into submission. ]

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/r/20220223043528.2093214-1-brijesh.singh@amd.com
---
 arch/x86/include/asm/set_memory.h |  1 +-
 arch/x86/include/asm/x86_init.h   | 16 +++++++-
 arch/x86/kernel/x86_init.c        | 16 ++++++-
 arch/x86/mm/mem_encrypt_amd.c     | 72 ++++++++++++++++++++----------
 arch/x86/mm/pat/set_memory.c      | 20 ++++----
 5 files changed, 91 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index ff0f2d9..ce8dd21 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -84,7 +84,6 @@ int set_pages_rw(struct page *page, int numpages);
 int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
 bool kernel_page_present(struct page *page);
-void notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc);
 
 extern int kernel_set_to_readonly;
 
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 22b7412..e917045 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -142,6 +142,21 @@ struct x86_init_acpi {
 };
 
 /**
+ * struct x86_guest - Functions used by misc guest incarnations like SEV, TDX, etc.
+ *
+ * @enc_status_change_prepare	Notify HV before the encryption status of a range is changed
+ * @enc_status_change_finish	Notify HV after the encryption status of a range is changed
+ * @enc_tlb_flush_required	Returns true if a TLB flush is needed before changing page encryption status
+ * @enc_cache_flush_required	Returns true if a cache flush is needed before changing page encryption status
+ */
+struct x86_guest {
+	void (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
+	bool (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
+	bool (*enc_tlb_flush_required)(bool enc);
+	bool (*enc_cache_flush_required)(void);
+};
+
+/**
  * struct x86_init_ops - functions for platform specific setup
  *
  */
@@ -287,6 +302,7 @@ struct x86_platform_ops {
 	struct x86_legacy_features legacy;
 	void (*set_legacy_features)(void);
 	struct x86_hyper_runtime hyper;
+	struct x86_guest guest;
 };
 
 struct x86_apic_ops {
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 7d20c1d..e84ee5c 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -129,6 +129,11 @@ struct x86_cpuinit_ops x86_cpuinit = {
 
 static void default_nmi_init(void) { };
 
+static void enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { }
+static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return false; }
+static bool enc_tlb_flush_required_noop(bool enc) { return false; }
+static bool enc_cache_flush_required_noop(void) { return false; }
+
 struct x86_platform_ops x86_platform __ro_after_init = {
 	.calibrate_cpu			= native_calibrate_cpu_early,
 	.calibrate_tsc			= native_calibrate_tsc,
@@ -138,9 +143,16 @@ struct x86_platform_ops x86_platform __ro_after_init = {
 	.is_untracked_pat_range		= is_ISA_range,
 	.nmi_init			= default_nmi_init,
 	.get_nmi_reason			= default_get_nmi_reason,
-	.save_sched_clock_state 	= tsc_save_sched_clock_state,
-	.restore_sched_clock_state 	= tsc_restore_sched_clock_state,
+	.save_sched_clock_state		= tsc_save_sched_clock_state,
+	.restore_sched_clock_state	= tsc_restore_sched_clock_state,
 	.hyper.pin_vcpu			= x86_op_int_noop,
+
+	.guest = {
+		.enc_status_change_prepare = enc_status_change_prepare_noop,
+		.enc_status_change_finish  = enc_status_change_finish_noop,
+		.enc_tlb_flush_required	   = enc_tlb_flush_required_noop,
+		.enc_cache_flush_required  = enc_cache_flush_required_noop,
+	},
 };
 
 EXPORT_SYMBOL_GPL(x86_platform);
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 2b2d018..6169053 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -177,25 +177,6 @@ void __init sme_map_bootdata(char *real_mode_data)
 	__sme_early_map_unmap_mem(__va(cmdline_paddr), COMMAND_LINE_SIZE, true);
 }
 
-void __init sme_early_init(void)
-{
-	unsigned int i;
-
-	if (!sme_me_mask)
-		return;
-
-	early_pmd_flags = __sme_set(early_pmd_flags);
-
-	__supported_pte_mask = __sme_set(__supported_pte_mask);
-
-	/* Update the protection map with memory encryption mask */
-	for (i = 0; i < ARRAY_SIZE(protection_map); i++)
-		protection_map[i] = pgprot_encrypted(protection_map[i]);
-
-	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
-		swiotlb_force = SWIOTLB_FORCE;
-}
-
 void __init sev_setup_arch(void)
 {
 	phys_addr_t total_mem = memblock_phys_mem_size();
@@ -256,7 +237,17 @@ static unsigned long pg_level_to_pfn(int level, pte_t *kpte, pgprot_t *ret_prot)
 	return pfn;
 }
 
-void notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc)
+static bool amd_enc_tlb_flush_required(bool enc)
+{
+	return true;
+}
+
+static bool amd_enc_cache_flush_required(void)
+{
+	return !cpu_feature_enabled(X86_FEATURE_SME_COHERENT);
+}
+
+static void enc_dec_hypercall(unsigned long vaddr, int npages, bool enc)
 {
 #ifdef CONFIG_PARAVIRT
 	unsigned long sz = npages << PAGE_SHIFT;
@@ -287,6 +278,19 @@ void notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc)
 #endif
 }
 
+static void amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool enc)
+{
+}
+
+/* Return true unconditionally: return value doesn't matter for the SEV side */
+static bool amd_enc_status_change_finish(unsigned long vaddr, int npages, bool enc)
+{
+	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
+		enc_dec_hypercall(vaddr, npages, enc);
+
+	return true;
+}
+
 static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
 {
 	pgprot_t old_prot, new_prot;
@@ -392,7 +396,7 @@ static int __init early_set_memory_enc_dec(unsigned long vaddr,
 
 	ret = 0;
 
-	notify_range_enc_status_changed(start, PAGE_ALIGN(size) >> PAGE_SHIFT, enc);
+	early_set_mem_enc_dec_hypercall(start, PAGE_ALIGN(size) >> PAGE_SHIFT, enc);
 out:
 	__flush_tlb_all();
 	return ret;
@@ -410,7 +414,31 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
 
 void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages, bool enc)
 {
-	notify_range_enc_status_changed(vaddr, npages, enc);
+	enc_dec_hypercall(vaddr, npages, enc);
+}
+
+void __init sme_early_init(void)
+{
+	unsigned int i;
+
+	if (!sme_me_mask)
+		return;
+
+	early_pmd_flags = __sme_set(early_pmd_flags);
+
+	__supported_pte_mask = __sme_set(__supported_pte_mask);
+
+	/* Update the protection map with memory encryption mask */
+	for (i = 0; i < ARRAY_SIZE(protection_map); i++)
+		protection_map[i] = pgprot_encrypted(protection_map[i]);
+
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		swiotlb_force = SWIOTLB_FORCE;
+
+	x86_platform.guest.enc_status_change_prepare = amd_enc_status_change_prepare;
+	x86_platform.guest.enc_status_change_finish  = amd_enc_status_change_finish;
+	x86_platform.guest.enc_tlb_flush_required    = amd_enc_tlb_flush_required;
+	x86_platform.guest.enc_cache_flush_required  = amd_enc_cache_flush_required;
 }
 
 void __init mem_encrypt_free_decrypted_mem(void)
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 1441db6..3b75262 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2008,10 +2008,12 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	kmap_flush_unused();
 	vm_unmap_aliases();
 
-	/*
-	 * Before changing the encryption attribute, we need to flush caches.
-	 */
-	cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
+	/* Flush the caches as needed before changing the encryption attribute. */
+	if (x86_platform.guest.enc_tlb_flush_required(enc))
+		cpa_flush(&cpa, x86_platform.guest.enc_cache_flush_required());
+
+	/* Notify hypervisor that we are about to set/clr encryption attribute. */
+	x86_platform.guest.enc_status_change_prepare(addr, numpages, enc);
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
@@ -2024,11 +2026,11 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	 */
 	cpa_flush(&cpa, 0);
 
-	/*
-	 * Notify hypervisor that a given memory range is mapped encrypted
-	 * or decrypted.
-	 */
-	notify_range_enc_status_changed(addr, numpages, enc);
+	/* Notify hypervisor that we have successfully set/clr encryption attribute. */
+	if (!ret) {
+		if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
+			ret = -EIO;
+	}
 
 	return ret;
 }
