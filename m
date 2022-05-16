Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63EA528D79
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345194AbiEPSwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345164AbiEPSwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:52:18 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908693EB9B
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:52:07 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id v5so4113938qvs.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8cA9Kovm8Jr01bpU9KRE0kr4mbv4PyT2v2HMUgjUI4M=;
        b=F1Pq5QvV3Wa7mLAEpkRvOl1GkGnSIxfVWaPkowoFUBXwLzCPlGZ4gHX4aJ0OOSW+Cf
         7ACiOmy90Xm0AR7pvjdnh/isRvhR5bakSgn2nlof/xVeBd1dxkGiTU7OjRXtiBkrOfzf
         88P/eZB7BdEXIIZshrTj47f/vIzjegh5uxBB5GyPt1lcFU1GUyaFPtrylzigQiAexJFl
         eD21wCwNUgXta6uyITwxaeSAzj0jQiu6xThbEnQGU49xsUGrn7Imamu34HQ/RC3eFcvN
         dotaaokZcytC4RGwdgeLBKh3/mXOGpTzt2IRd/7cXYe74OtdamoLnDHE/ICtdBoVadT0
         gX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8cA9Kovm8Jr01bpU9KRE0kr4mbv4PyT2v2HMUgjUI4M=;
        b=p85QJh/drVUtQtYHtQjh+cOr6fHvzSSyLMVj7uqFmLSEq4qCLXMcNFSrNwy5yL4sWP
         d5z9UeoRnt/OMUOUDb3CLwaxsahX5LF9KxI+w1uMo17hVq0YqMDsy0VDuacVdYfL2SNp
         +2b7jwxL8uNP1VmZqtBLgDCr7V/eXIMFaN7TtN9f57zvEhdLt0EHbTm9hML2oN3jFeqe
         HRbCVlhUsUV1P18d/n6zoaRpTPC/wcYWImxcf4Nj4O6NHuO7T1w+IcKvGU6HnHuTto6T
         oAV0jdngmWASAzv8CtRqqzY9dkAsonwUQaY1p4aLJaEIf0kSdFMClKfsbErf6r0QO6tC
         CydA==
X-Gm-Message-State: AOAM532KxQl5LbtGT+O/rKmfnXqbNWwPNe9y9p1nnGuX3c6jPt0IDraF
        oyXPHQM8gxgcn7Z4yK8fefFLVw==
X-Google-Smtp-Source: ABdhPJyMkwL7thVF+Ptn9kKgXPn6abtalHKomGQAehIAKDbTVeTzzG711klX+La/JZq4Cb2HNWoz+Q==
X-Received: by 2002:a0c:fe12:0:b0:456:344a:8d58 with SMTP id x18-20020a0cfe12000000b00456344a8d58mr16598659qvr.45.1652727126481;
        Mon, 16 May 2022 11:52:06 -0700 (PDT)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id d4-20020a05622a15c400b002f3f062dbd5sm6979794qty.43.2022.05.16.11.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:52:05 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
X-Google-Original-From: Pasha Tatashin <tatashin@google.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, luto@kernel.org, peterz@infradead.org,
        logang@deltatee.com
Subject: [PATCH] x86: removed P*D_PAGE_MASK and P*D_PAGE_SIZE
Date:   Mon, 16 May 2022 18:52:02 +0000
Message-Id: <20220516185202.604654-1-tatashin@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pasha Tatashin <pasha.tatashin@soleen.com>

Other architectures and the common mm/ use P*D_MASK, and P*D_SIZE.
Remove the duplicated P*D_PAGE_MASK and P*D_PAGE_SIZE which are only
used in x86/*.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---

Applies against next-20220516 that contains:
mm: page_table_check: using PxD_SIZE instead of PxD_PAGE_SIZ

 arch/x86/include/asm/page_types.h  | 12 +++---------
 arch/x86/kernel/amd_gart_64.c      |  2 +-
 arch/x86/kernel/head64.c           |  2 +-
 arch/x86/mm/mem_encrypt_boot.S     |  4 ++--
 arch/x86/mm/mem_encrypt_identity.c | 18 +++++++++---------
 arch/x86/mm/pat/set_memory.c       |  6 +++---
 arch/x86/mm/pti.c                  |  2 +-
 7 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
index a506a411474d..86bd4311daf8 100644
--- a/arch/x86/include/asm/page_types.h
+++ b/arch/x86/include/asm/page_types.h
@@ -11,20 +11,14 @@
 #define PAGE_SIZE		(_AC(1,UL) << PAGE_SHIFT)
 #define PAGE_MASK		(~(PAGE_SIZE-1))
 
-#define PMD_PAGE_SIZE		(_AC(1, UL) << PMD_SHIFT)
-#define PMD_PAGE_MASK		(~(PMD_PAGE_SIZE-1))
-
-#define PUD_PAGE_SIZE		(_AC(1, UL) << PUD_SHIFT)
-#define PUD_PAGE_MASK		(~(PUD_PAGE_SIZE-1))
-
 #define __VIRTUAL_MASK		((1UL << __VIRTUAL_MASK_SHIFT) - 1)
 
-/* Cast *PAGE_MASK to a signed type so that it is sign-extended if
+/* Cast P*D_MASK to a signed type so that it is sign-extended if
    virtual addresses are 32-bits but physical addresses are larger
    (ie, 32-bit PAE). */
 #define PHYSICAL_PAGE_MASK	(((signed long)PAGE_MASK) & __PHYSICAL_MASK)
-#define PHYSICAL_PMD_PAGE_MASK	(((signed long)PMD_PAGE_MASK) & __PHYSICAL_MASK)
-#define PHYSICAL_PUD_PAGE_MASK	(((signed long)PUD_PAGE_MASK) & __PHYSICAL_MASK)
+#define PHYSICAL_PMD_PAGE_MASK	(((signed long)PMD_MASK) & __PHYSICAL_MASK)
+#define PHYSICAL_PUD_PAGE_MASK	(((signed long)PUD_MASK) & __PHYSICAL_MASK)
 
 #define HPAGE_SHIFT		PMD_SHIFT
 #define HPAGE_SIZE		(_AC(1,UL) << HPAGE_SHIFT)
diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index 194d54eed537..78f5f89d8401 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -504,7 +504,7 @@ static __init unsigned long check_iommu_size(unsigned long aper, u64 aper_size)
 	}
 
 	a = aper + iommu_size;
-	iommu_size -= round_up(a, PMD_PAGE_SIZE) - a;
+	iommu_size -= round_up(a, PMD_SIZE) - a;
 
 	if (iommu_size < 64*1024*1024) {
 		pr_warn("PCI-DMA: Warning: Small IOMMU %luMB."
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index bd4a34100ed0..fb2df18cc994 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -203,7 +203,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	load_delta = physaddr - (unsigned long)(_text - __START_KERNEL_map);
 
 	/* Is the address not 2M aligned? */
-	if (load_delta & ~PMD_PAGE_MASK)
+	if (load_delta & ~PMD_MASK)
 		for (;;);
 
 	/* Include the SME encryption mask in the fixup value */
diff --git a/arch/x86/mm/mem_encrypt_boot.S b/arch/x86/mm/mem_encrypt_boot.S
index 3d1dba05fce4..640131736a19 100644
--- a/arch/x86/mm/mem_encrypt_boot.S
+++ b/arch/x86/mm/mem_encrypt_boot.S
@@ -26,7 +26,7 @@ SYM_FUNC_START(sme_encrypt_execute)
 	 *   RCX - virtual address of the encryption workarea, including:
 	 *     - stack page (PAGE_SIZE)
 	 *     - encryption routine page (PAGE_SIZE)
-	 *     - intermediate copy buffer (PMD_PAGE_SIZE)
+	 *     - intermediate copy buffer (PMD_SIZE)
 	 *    R8 - physical address of the pagetables to use for encryption
 	 */
 
@@ -120,7 +120,7 @@ SYM_FUNC_START(__enc_copy)
 	wbinvd				/* Invalidate any cache entries */
 
 	/* Copy/encrypt up to 2MB at a time */
-	movq	$PMD_PAGE_SIZE, %r12
+	movq	$PMD_SIZE, %r12
 1:
 	cmpq	%r12, %r9
 	jnb	2f
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index f415498d3175..88cccd65029d 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -93,7 +93,7 @@ struct sme_populate_pgd_data {
  * section is 2MB aligned to allow for simple pagetable setup using only
  * PMD entries (see vmlinux.lds.S).
  */
-static char sme_workarea[2 * PMD_PAGE_SIZE] __section(".init.scratch");
+static char sme_workarea[2 * PMD_SIZE] __section(".init.scratch");
 
 static char sme_cmdline_arg[] __initdata = "mem_encrypt";
 static char sme_cmdline_on[]  __initdata = "on";
@@ -198,8 +198,8 @@ static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
 	while (ppd->vaddr < ppd->vaddr_end) {
 		sme_populate_pgd_large(ppd);
 
-		ppd->vaddr += PMD_PAGE_SIZE;
-		ppd->paddr += PMD_PAGE_SIZE;
+		ppd->vaddr += PMD_SIZE;
+		ppd->paddr += PMD_SIZE;
 	}
 }
 
@@ -225,11 +225,11 @@ static void __init __sme_map_range(struct sme_populate_pgd_data *ppd,
 	vaddr_end = ppd->vaddr_end;
 
 	/* If start is not 2MB aligned, create PTE entries */
-	ppd->vaddr_end = ALIGN(ppd->vaddr, PMD_PAGE_SIZE);
+	ppd->vaddr_end = ALIGN(ppd->vaddr, PMD_SIZE);
 	__sme_map_range_pte(ppd);
 
 	/* Create PMD entries */
-	ppd->vaddr_end = vaddr_end & PMD_PAGE_MASK;
+	ppd->vaddr_end = vaddr_end & PMD_MASK;
 	__sme_map_range_pmd(ppd);
 
 	/* If end is not 2MB aligned, create PTE entries */
@@ -325,7 +325,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 
 	/* Physical addresses gives us the identity mapped virtual addresses */
 	kernel_start = __pa_symbol(_text);
-	kernel_end = ALIGN(__pa_symbol(_end), PMD_PAGE_SIZE);
+	kernel_end = ALIGN(__pa_symbol(_end), PMD_SIZE);
 	kernel_len = kernel_end - kernel_start;
 
 	initrd_start = 0;
@@ -355,12 +355,12 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	 *   executable encryption area size:
 	 *     stack page (PAGE_SIZE)
 	 *     encryption routine page (PAGE_SIZE)
-	 *     intermediate copy buffer (PMD_PAGE_SIZE)
+	 *     intermediate copy buffer (PMD_SIZE)
 	 *   pagetable structures for the encryption of the kernel
 	 *   pagetable structures for workarea (in case not currently mapped)
 	 */
 	execute_start = workarea_start;
-	execute_end = execute_start + (PAGE_SIZE * 2) + PMD_PAGE_SIZE;
+	execute_end = execute_start + (PAGE_SIZE * 2) + PMD_SIZE;
 	execute_len = execute_end - execute_start;
 
 	/*
@@ -383,7 +383,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	 * before it is mapped.
 	 */
 	workarea_len = execute_len + pgtable_area_len;
-	workarea_end = ALIGN(workarea_start + workarea_len, PMD_PAGE_SIZE);
+	workarea_end = ALIGN(workarea_start + workarea_len, PMD_SIZE);
 
 	/*
 	 * Set the address to the start of where newly created pagetable
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 9200e619d8b7..011e1fcd03bc 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -703,11 +703,11 @@ phys_addr_t slow_virt_to_phys(void *__virt_addr)
 	switch (level) {
 	case PG_LEVEL_1G:
 		phys_addr = (phys_addr_t)pud_pfn(*(pud_t *)pte) << PAGE_SHIFT;
-		offset = virt_addr & ~PUD_PAGE_MASK;
+		offset = virt_addr & ~PUD_MASK;
 		break;
 	case PG_LEVEL_2M:
 		phys_addr = (phys_addr_t)pmd_pfn(*(pmd_t *)pte) << PAGE_SHIFT;
-		offset = virt_addr & ~PMD_PAGE_MASK;
+		offset = virt_addr & ~PMD_MASK;
 		break;
 	default:
 		phys_addr = (phys_addr_t)pte_pfn(*pte) << PAGE_SHIFT;
@@ -995,7 +995,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	case PG_LEVEL_1G:
 		ref_prot = pud_pgprot(*(pud_t *)kpte);
 		ref_pfn = pud_pfn(*(pud_t *)kpte);
-		pfninc = PMD_PAGE_SIZE >> PAGE_SHIFT;
+		pfninc = PMD_SIZE >> PAGE_SHIFT;
 		lpaddr = address & PUD_MASK;
 		lpinc = PMD_SIZE;
 		/*
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index ffe3b3a087fe..78414c6d1b5e 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -592,7 +592,7 @@ static void pti_set_kernel_image_nonglobal(void)
 	 * of the image.
 	 */
 	unsigned long start = PFN_ALIGN(_text);
-	unsigned long end = ALIGN((unsigned long)_end, PMD_PAGE_SIZE);
+	unsigned long end = ALIGN((unsigned long)_end, PMD_SIZE);
 
 	/*
 	 * This clears _PAGE_GLOBAL from the entire kernel image.
-- 
2.36.0.550.gb090851708-goog

