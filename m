Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EC950A83D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391464AbiDUSnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391446AbiDUSn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:43:29 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B85E46647
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 11:40:38 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id hf18so3957361qtb.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 11:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=d5+6z3N9ccPmeyj2XQRklBhpCzbqmaBZKIjsjsJTE0g=;
        b=QW/FdGAej/rEG8GMf3mP1u66F1oulEBPoeJucLHxFajgHuWpxPejbS8TPkSnxW2Fn7
         25EJTfOmGC8H9gRRtTtcjio1jgIc38tgTjco6QyOeYr/FM2qTWAe/Fmqfbr4zTF/o1aq
         woODn4NxwiXz+8Um7osTgSgH22+PCaYZnGoI+kQev6bbj4Z2bGL5KD3gJcswApMAbEXH
         +m83kPg2gD9daNzlBZZFFm+RPWP8TyuuWglVOQlmfcK7oAbBJ7FYdV500E8u7fPl8qAK
         uVMC9MO+OE2GdeuFYkxXqneH4MX9Ed6TDYfZsNqUtJdPjn2Mb1kDEUXKXcKjlsYjMWqh
         0C9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=d5+6z3N9ccPmeyj2XQRklBhpCzbqmaBZKIjsjsJTE0g=;
        b=3aHO6JyaOw+emauQzyWA9jheEACvmSIn/KnVyuqn1+nEPeuciL0WOLcMsMc7yb58/A
         x86XrLBx4V/NZw7U6IOS7OtrtejTmNyY9N89iAfy9jat3aRud1R4E4wrzhuE3TDQ4jGN
         +3hz7Nv5Z4mRRiZatuqiGGE7xnTikzv9xqhGVMNpjW1PTx+VNsZMvLEviliTqNPK6hF2
         ClD7wdpzcQ7qWtH0ax3omu3cn/6z+UoyXplbb33DhzYDvcHFnksFrQMaFQKA8CmoZ405
         06xfquBiXwWlYbRPWOZrvCInSzg3kGWsO/pBqjjJh8HAiS++BCbgVnG9LFewliAem3+8
         4Mew==
X-Gm-Message-State: AOAM531cuFq9XT6F6WngjkZLY4rw8i/ii+/Rf+b3v7SD+VGuj74PmeR6
        SSyd9RcrlTes2COzFKTXJr0zmw==
X-Google-Smtp-Source: ABdhPJxHcipaB1ycdaUdYmR73pygkTYtd6GYAYsEXw61LkfZOuHdLGpt1+gpY2UMBD6iv/m2BdSm1w==
X-Received: by 2002:a05:622a:386:b0:2f3:3f27:c832 with SMTP id j6-20020a05622a038600b002f33f27c832mr651610qtx.504.1650566437596;
        Thu, 21 Apr 2022 11:40:37 -0700 (PDT)
Received: from [100.115.92.211] ([71.161.202.189])
        by smtp.gmail.com with ESMTPSA id v3-20020a05622a188300b002f201623acasm3892383qtc.50.2022.04.21.11.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 11:40:37 -0700 (PDT)
Message-ID: <bbd67c4e-6adf-dc1f-7104-427e3e598d9a@soleen.com>
Date:   Thu, 21 Apr 2022 14:40:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v5 1/5] mm: page_table_check: using PxD_SIZE instead
 of PxD_PAGE_SIZE
Content-Language: en-US
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     Tong Tiangen <tongtiangen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm <linux-mm@kvack.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-riscv@lists.infradead.org, Guohanjun <guohanjun@huawei.com>
References: <20220421082042.1167967-1-tongtiangen@huawei.com>
 <20220421082042.1167967-2-tongtiangen@huawei.com>
 <CA+CK2bCWRL_vXW1BUhxb-zLiywXTCQdaa+9feEwQytYW=K46-g@mail.gmail.com>
In-Reply-To: <CA+CK2bCWRL_vXW1BUhxb-zLiywXTCQdaa+9feEwQytYW=K46-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/22 11:28, Pasha Tatashin wrote:
> On Thu, Apr 21, 2022 at 4:02 AM Tong Tiangen <tongtiangen@huawei.com> wrote:
>>
>> Macro PUD_SIZE/PMD_SIZE is more general in various architectures. Using
>> PUD_SIZE/PMD_SIZE instead of PUD_PAGE_SIZE/PMD_PAGE_SIZE can better
>> support page table check in architectures other than x86 and it is no
>> functional impact on x86.
>>
>> Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> 
> Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>


To avoid similar problems in the future, please also include the following patch after the current series:

----------------8<-------------[ cut here ]------------------
From cccef7ba2433f8e97d1948f85e3bfb2ef5d32a0a Mon Sep 17 00:00:00 2001
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 21 Apr 2022 18:04:43 +0000
Subject: [PATCH] x86: removed P*D_PAGE_MASK and P*D_PAGE_SIZE

Other architectures and the common mm/ use P*D_MASK, and P*D_SIZE.
Remove the duplicated P*D_PAGE_MASK and P*D_PAGE_SIZE which are only
used in x86/*.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
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
index ed837383de5c..02579ea02351 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -506,7 +506,7 @@ static __init unsigned long check_iommu_size(unsigned long aper, u64 aper_size)
 	}
 
 	a = aper + iommu_size;
-	iommu_size -= round_up(a, PMD_PAGE_SIZE) - a;
+	iommu_size -= round_up(a, PMD_SIZE) - a;
 
 	if (iommu_size < 64*1024*1024) {
 		pr_warn("PCI-DMA: Warning: Small IOMMU %luMB."
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 4f5ecbbaae77..f11ca415e97c 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -189,7 +189,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	load_delta = physaddr - (unsigned long)(_text - __START_KERNEL_map);
 
 	/* Is the address not 2M aligned? */
-	if (load_delta & ~PMD_PAGE_MASK)
+	if (load_delta & ~PMD_MASK)
 		for (;;);
 
 	/* Activate Secure Memory Encryption (SME) if supported and enabled */
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
index b43bc24d2bb6..357039a38547 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -92,7 +92,7 @@ struct sme_populate_pgd_data {
  * section is 2MB aligned to allow for simple pagetable setup using only
  * PMD entries (see vmlinux.lds.S).
  */
-static char sme_workarea[2 * PMD_PAGE_SIZE] __section(".init.scratch");
+static char sme_workarea[2 * PMD_SIZE] __section(".init.scratch");
 
 static char sme_cmdline_arg[] __initdata = "mem_encrypt";
 static char sme_cmdline_on[]  __initdata = "on";
@@ -197,8 +197,8 @@ static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
 	while (ppd->vaddr < ppd->vaddr_end) {
 		sme_populate_pgd_large(ppd);
 
-		ppd->vaddr += PMD_PAGE_SIZE;
-		ppd->paddr += PMD_PAGE_SIZE;
+		ppd->vaddr += PMD_SIZE;
+		ppd->paddr += PMD_SIZE;
 	}
 }
 
@@ -224,11 +224,11 @@ static void __init __sme_map_range(struct sme_populate_pgd_data *ppd,
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
@@ -324,7 +324,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 
 	/* Physical addresses gives us the identity mapped virtual addresses */
 	kernel_start = __pa_symbol(_text);
-	kernel_end = ALIGN(__pa_symbol(_end), PMD_PAGE_SIZE);
+	kernel_end = ALIGN(__pa_symbol(_end), PMD_SIZE);
 	kernel_len = kernel_end - kernel_start;
 
 	initrd_start = 0;
@@ -354,12 +354,12 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
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
@@ -382,7 +382,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	 * before it is mapped.
 	 */
 	workarea_len = execute_len + pgtable_area_len;
-	workarea_end = ALIGN(workarea_start + workarea_len, PMD_PAGE_SIZE);
+	workarea_end = ALIGN(workarea_start + workarea_len, PMD_SIZE);
 
 	/*
 	 * Set the address to the start of where newly created pagetable
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index abf5ed76e4b7..8016d93c1288 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -714,11 +714,11 @@ phys_addr_t slow_virt_to_phys(void *__virt_addr)
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
@@ -1006,7 +1006,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	case PG_LEVEL_1G:
 		ref_prot = pud_pgprot(*(pud_t *)kpte);
 		ref_pfn = pud_pfn(*(pud_t *)kpte);
-		pfninc = PMD_PAGE_SIZE >> PAGE_SHIFT;
+		pfninc = PMD_SIZE >> PAGE_SHIFT;
 		lpaddr = address & PUD_MASK;
 		lpinc = PMD_SIZE;
 		/*
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 5d5c7bb50ce9..a28c8d57273a 100644
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
2.36.0.rc2.479.g8af0fa9b8e-goog
