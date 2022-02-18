Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E2A4BBD51
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiBRQTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:19:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237748AbiBRQSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:18:10 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7772B522C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645201070; x=1676737070;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nADhV0lVzgeE1XCdwSRouFO3nFpiweiQ2noYmHhR8jI=;
  b=LRdSNpC83d9OCv9wSvV4aa/sYNJzu1wlZ77QFJmxUGcemVzjaDPsYjsz
   e3aMM+VN3zTWi7Oxds78oXgCFrZ8RsZtnIMykgOmuwAJoBkmqskOJrjvZ
   ubtoPRHq3uGn4YkK0ERezEZbzYIxb3wYkh6OJEdee6ftd2XYlzTHCN7Lr
   +3Res8VGDZ93FXsMQVvuEvxFXqO8D22uhvDWCSIqRPg90H3yjzItH7oN2
   pAztlh2dPwHdnw37qcsCuw26ttvzazncmES4rQq987ijlBMw0K1WC9W6y
   71GMjInvf6lemyQb/cz1cRmAPc/+UooKgwZNpnDdI9ynxkn1xfO+3ElND
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="251098348"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="251098348"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 08:17:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="637782187"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 18 Feb 2022 08:17:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 64942EC2; Fri, 18 Feb 2022 18:17:23 +0200 (EET)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCHv3 27/32] x86/mm/cpa: Generailize __set_memory_enc_pgtable()
Date:   Fri, 18 Feb 2022 19:17:13 +0300
Message-Id: <20220218161718.67148-28-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TDX steals a bit from the physical address and uses it to indicate
whether the page is private to the guest (bit set 0) or unprotected
and shared with the VMM (bit set 1).

AMD SEV uses a similar scheme, repurposing a bit from the physical address
to indicate encrypted or decrypted pages.

The kernel already has the infrastructure to deal with encrypted/decrypted
pages for AMD SEV, but TDX requires few tweaks:

 - TDX and SEV have different requirements to the cache and tlb
   flushing.

 - TDX has own routine to notify VMM about page encryption status change.

Modify __set_memory_enc_pgtable() and make it flexible enough to cover
both AMD SEV and Intel TDX. The AMD-specific behaviour is isolated in
callback under x86_platform.cc. TDX will provide own version of the
callbacks.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/set_memory.h |  1 -
 arch/x86/include/asm/x86_init.h   |  7 ++++
 arch/x86/mm/mem_encrypt_amd.c     | 65 ++++++++++++++++++++-----------
 arch/x86/mm/pat/set_memory.c      | 10 ++---
 4 files changed, 54 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index ff0f2d90338a..ce8dd215f5b3 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -84,7 +84,6 @@ int set_pages_rw(struct page *page, int numpages);
 int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
 bool kernel_page_present(struct page *page);
-void notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc);
 
 extern int kernel_set_to_readonly;
 
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 22b7412c08f6..d38c253cc222 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -251,6 +251,12 @@ struct x86_hyper_runtime {
 	bool (*sev_es_hcall_finish)(struct ghcb *ghcb, struct pt_regs *regs);
 };
 
+struct x86_cc_runtime {
+	int (*enc_status_changed)(unsigned long vaddr, int numpages, bool enc);
+	bool (*enc_tlb_flush_required)(bool enc);
+	bool (*enc_cache_flush_required)(void);
+};
+
 /**
  * struct x86_platform_ops - platform specific runtime functions
  * @calibrate_cpu:		calibrate CPU
@@ -287,6 +293,7 @@ struct x86_platform_ops {
 	struct x86_legacy_features legacy;
 	void (*set_legacy_features)(void);
 	struct x86_hyper_runtime hyper;
+	const struct x86_cc_runtime *cc;
 };
 
 struct x86_apic_ops {
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 2b2d018ea345..3fe746be8d90 100644
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
@@ -256,7 +237,7 @@ static unsigned long pg_level_to_pfn(int level, pte_t *kpte, pgprot_t *ret_prot)
 	return pfn;
 }
 
-void notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc)
+static int amd_enc_status_changed(unsigned long vaddr, int npages, bool enc)
 {
 #ifdef CONFIG_PARAVIRT
 	unsigned long sz = npages << PAGE_SHIFT;
@@ -270,7 +251,7 @@ void notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc)
 		kpte = lookup_address(vaddr, &level);
 		if (!kpte || pte_none(*kpte)) {
 			WARN_ONCE(1, "kpte lookup for vaddr\n");
-			return;
+			return 0;
 		}
 
 		pfn = pg_level_to_pfn(level, kpte, NULL);
@@ -285,6 +266,44 @@ void notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc)
 		vaddr = (vaddr & pmask) + psize;
 	}
 #endif
+	return 0;
+}
+
+static bool amd_enc_tlb_flush_required(bool enc)
+{
+	return true;
+}
+
+static bool amd_enc_cache_flush_required(void)
+{
+	return this_cpu_has(X86_FEATURE_SME_COHERENT);
+}
+
+static const struct x86_cc_runtime amd_cc_runtime = {
+	.enc_status_changed = amd_enc_status_changed,
+	.enc_tlb_flush_required = amd_enc_tlb_flush_required,
+	.enc_cache_flush_required = amd_enc_cache_flush_required,
+};
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
+	x86_platform.cc = &amd_cc_runtime;
 }
 
 static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
@@ -392,7 +411,7 @@ static int __init early_set_memory_enc_dec(unsigned long vaddr,
 
 	ret = 0;
 
-	notify_range_enc_status_changed(start, PAGE_ALIGN(size) >> PAGE_SHIFT, enc);
+	x86_platform.cc->enc_status_changed(start, PAGE_ALIGN(size) >> PAGE_SHIFT, enc);
 out:
 	__flush_tlb_all();
 	return ret;
@@ -410,7 +429,7 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
 
 void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages, bool enc)
 {
-	notify_range_enc_status_changed(vaddr, npages, enc);
+	x86_platform.cc->enc_status_changed(vaddr, npages, enc);
 }
 
 void __init mem_encrypt_free_decrypted_mem(void)
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index e79366b8a9da..65a27dec095f 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2007,10 +2007,9 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	kmap_flush_unused();
 	vm_unmap_aliases();
 
-	/*
-	 * Before changing the encryption attribute, we need to flush caches.
-	 */
-	cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
+	/* Flush caches as needed before changing the encryption attribute. */
+	if (x86_platform.cc->enc_tlb_flush_required(enc))
+		cpa_flush(&cpa, x86_platform.cc->enc_cache_flush_required());
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
@@ -2027,7 +2026,8 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	 * Notify hypervisor that a given memory range is mapped encrypted
 	 * or decrypted.
 	 */
-	notify_range_enc_status_changed(addr, numpages, enc);
+	if (!ret)
+		ret = x86_platform.cc->enc_status_changed(addr, numpages, enc);
 
 	return ret;
 }
-- 
2.34.1

