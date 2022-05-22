Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991C75304B9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 18:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbiEVQfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 12:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiEVQfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 12:35:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B1429823
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 09:35:35 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24MFGeKh031254;
        Sun, 22 May 2022 16:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=oavnhgFXpICRXOj5SssFSdwzG9/KGGQK/KfKW84UNwI=;
 b=mYcqMYoHw9R+uOHPm+3rd8epfPc2EUfnH9/kaTl34bolNcNp4r2CBYcFKlJKfhdZ1kCS
 4MJPjJ8R15Wc6Vmbo5pqoUiySHUd6qttBMeMyq5bwjs3vKDDpx9pzJF3mkN/9Zg0cQGO
 iMrexNCgnZaItu6f+sH01zb1LN8jh1uAYWUh7M2/dpHfWHBFFi9/m1fghc1CvhX1fGlU
 TGWEHVaHvrpQN3EeF1LcyXNfXTdSlEIFP54d5gSwx+2j5wS+AgS7uGtVwJmuScUB3a7b
 jfInKAzWDK3o9rBuHeFAB/79/3EllKUmKJU1efDFQup3GlGaa9YCg0RcnEQDJJODjup4 FA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g79e7u88c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 May 2022 16:34:45 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24MGWVZ9013422;
        Sun, 22 May 2022 16:34:45 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g79e7u87y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 May 2022 16:34:44 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24MGP5mc012297;
        Sun, 22 May 2022 16:34:42 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3g6qq99mrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 May 2022 16:34:42 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24MGYeHV43647316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 May 2022 16:34:40 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECFA942041;
        Sun, 22 May 2022 16:34:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D74B64203F;
        Sun, 22 May 2022 16:34:38 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.68.192])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 22 May 2022 16:34:38 +0000 (GMT)
Date:   Sun, 22 May 2022 19:34:37 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, logang@deltatee.com
Subject: Re: [PATCH] x86: removed P*D_PAGE_MASK and P*D_PAGE_SIZE
Message-ID: <YopmHXcHw/STtSY0@linux.ibm.com>
References: <20220516185202.604654-1-tatashin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516185202.604654-1-tatashin@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QPeL2ZGexYvS82jdWUHa2I-6Rt0xiyqQ
X-Proofpoint-ORIG-GUID: lM_vm0puptICyHeYajL3XMWGMuzzb4ha
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-22_09,2022-05-20_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205220101
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 06:52:02PM +0000, Pasha Tatashin wrote:
> From: Pasha Tatashin <pasha.tatashin@soleen.com>
> 
> Other architectures and the common mm/ use P*D_MASK, and P*D_SIZE.
> Remove the duplicated P*D_PAGE_MASK and P*D_PAGE_SIZE which are only
> used in x86/*.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
> 
> Applies against next-20220516 that contains:
> mm: page_table_check: using PxD_SIZE instead of PxD_PAGE_SIZ
> 
>  arch/x86/include/asm/page_types.h  | 12 +++---------
>  arch/x86/kernel/amd_gart_64.c      |  2 +-
>  arch/x86/kernel/head64.c           |  2 +-
>  arch/x86/mm/mem_encrypt_boot.S     |  4 ++--
>  arch/x86/mm/mem_encrypt_identity.c | 18 +++++++++---------
>  arch/x86/mm/pat/set_memory.c       |  6 +++---
>  arch/x86/mm/pti.c                  |  2 +-
>  7 files changed, 20 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
> index a506a411474d..86bd4311daf8 100644
> --- a/arch/x86/include/asm/page_types.h
> +++ b/arch/x86/include/asm/page_types.h
> @@ -11,20 +11,14 @@
>  #define PAGE_SIZE		(_AC(1,UL) << PAGE_SHIFT)
>  #define PAGE_MASK		(~(PAGE_SIZE-1))
>  
> -#define PMD_PAGE_SIZE		(_AC(1, UL) << PMD_SHIFT)
> -#define PMD_PAGE_MASK		(~(PMD_PAGE_SIZE-1))
> -
> -#define PUD_PAGE_SIZE		(_AC(1, UL) << PUD_SHIFT)
> -#define PUD_PAGE_MASK		(~(PUD_PAGE_SIZE-1))
> -
>  #define __VIRTUAL_MASK		((1UL << __VIRTUAL_MASK_SHIFT) - 1)
>  
> -/* Cast *PAGE_MASK to a signed type so that it is sign-extended if
> +/* Cast P*D_MASK to a signed type so that it is sign-extended if
>     virtual addresses are 32-bits but physical addresses are larger
>     (ie, 32-bit PAE). */
>  #define PHYSICAL_PAGE_MASK	(((signed long)PAGE_MASK) & __PHYSICAL_MASK)
> -#define PHYSICAL_PMD_PAGE_MASK	(((signed long)PMD_PAGE_MASK) & __PHYSICAL_MASK)
> -#define PHYSICAL_PUD_PAGE_MASK	(((signed long)PUD_PAGE_MASK) & __PHYSICAL_MASK)
> +#define PHYSICAL_PMD_PAGE_MASK	(((signed long)PMD_MASK) & __PHYSICAL_MASK)
> +#define PHYSICAL_PUD_PAGE_MASK	(((signed long)PUD_MASK) & __PHYSICAL_MASK)
>  
>  #define HPAGE_SHIFT		PMD_SHIFT
>  #define HPAGE_SIZE		(_AC(1,UL) << HPAGE_SHIFT)
> diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
> index 194d54eed537..78f5f89d8401 100644
> --- a/arch/x86/kernel/amd_gart_64.c
> +++ b/arch/x86/kernel/amd_gart_64.c
> @@ -504,7 +504,7 @@ static __init unsigned long check_iommu_size(unsigned long aper, u64 aper_size)
>  	}
>  
>  	a = aper + iommu_size;
> -	iommu_size -= round_up(a, PMD_PAGE_SIZE) - a;
> +	iommu_size -= round_up(a, PMD_SIZE) - a;
>  
>  	if (iommu_size < 64*1024*1024) {
>  		pr_warn("PCI-DMA: Warning: Small IOMMU %luMB."
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index bd4a34100ed0..fb2df18cc994 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -203,7 +203,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
>  	load_delta = physaddr - (unsigned long)(_text - __START_KERNEL_map);
>  
>  	/* Is the address not 2M aligned? */
> -	if (load_delta & ~PMD_PAGE_MASK)
> +	if (load_delta & ~PMD_MASK)
>  		for (;;);
>  
>  	/* Include the SME encryption mask in the fixup value */
> diff --git a/arch/x86/mm/mem_encrypt_boot.S b/arch/x86/mm/mem_encrypt_boot.S
> index 3d1dba05fce4..640131736a19 100644
> --- a/arch/x86/mm/mem_encrypt_boot.S
> +++ b/arch/x86/mm/mem_encrypt_boot.S
> @@ -26,7 +26,7 @@ SYM_FUNC_START(sme_encrypt_execute)
>  	 *   RCX - virtual address of the encryption workarea, including:
>  	 *     - stack page (PAGE_SIZE)
>  	 *     - encryption routine page (PAGE_SIZE)
> -	 *     - intermediate copy buffer (PMD_PAGE_SIZE)
> +	 *     - intermediate copy buffer (PMD_SIZE)
>  	 *    R8 - physical address of the pagetables to use for encryption
>  	 */
>  
> @@ -120,7 +120,7 @@ SYM_FUNC_START(__enc_copy)
>  	wbinvd				/* Invalidate any cache entries */
>  
>  	/* Copy/encrypt up to 2MB at a time */
> -	movq	$PMD_PAGE_SIZE, %r12
> +	movq	$PMD_SIZE, %r12
>  1:
>  	cmpq	%r12, %r9
>  	jnb	2f
> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index f415498d3175..88cccd65029d 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -93,7 +93,7 @@ struct sme_populate_pgd_data {
>   * section is 2MB aligned to allow for simple pagetable setup using only
>   * PMD entries (see vmlinux.lds.S).
>   */
> -static char sme_workarea[2 * PMD_PAGE_SIZE] __section(".init.scratch");
> +static char sme_workarea[2 * PMD_SIZE] __section(".init.scratch");
>  
>  static char sme_cmdline_arg[] __initdata = "mem_encrypt";
>  static char sme_cmdline_on[]  __initdata = "on";
> @@ -198,8 +198,8 @@ static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
>  	while (ppd->vaddr < ppd->vaddr_end) {
>  		sme_populate_pgd_large(ppd);
>  
> -		ppd->vaddr += PMD_PAGE_SIZE;
> -		ppd->paddr += PMD_PAGE_SIZE;
> +		ppd->vaddr += PMD_SIZE;
> +		ppd->paddr += PMD_SIZE;
>  	}
>  }
>  
> @@ -225,11 +225,11 @@ static void __init __sme_map_range(struct sme_populate_pgd_data *ppd,
>  	vaddr_end = ppd->vaddr_end;
>  
>  	/* If start is not 2MB aligned, create PTE entries */
> -	ppd->vaddr_end = ALIGN(ppd->vaddr, PMD_PAGE_SIZE);
> +	ppd->vaddr_end = ALIGN(ppd->vaddr, PMD_SIZE);
>  	__sme_map_range_pte(ppd);
>  
>  	/* Create PMD entries */
> -	ppd->vaddr_end = vaddr_end & PMD_PAGE_MASK;
> +	ppd->vaddr_end = vaddr_end & PMD_MASK;
>  	__sme_map_range_pmd(ppd);
>  
>  	/* If end is not 2MB aligned, create PTE entries */
> @@ -325,7 +325,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
>  
>  	/* Physical addresses gives us the identity mapped virtual addresses */
>  	kernel_start = __pa_symbol(_text);
> -	kernel_end = ALIGN(__pa_symbol(_end), PMD_PAGE_SIZE);
> +	kernel_end = ALIGN(__pa_symbol(_end), PMD_SIZE);
>  	kernel_len = kernel_end - kernel_start;
>  
>  	initrd_start = 0;
> @@ -355,12 +355,12 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
>  	 *   executable encryption area size:
>  	 *     stack page (PAGE_SIZE)
>  	 *     encryption routine page (PAGE_SIZE)
> -	 *     intermediate copy buffer (PMD_PAGE_SIZE)
> +	 *     intermediate copy buffer (PMD_SIZE)
>  	 *   pagetable structures for the encryption of the kernel
>  	 *   pagetable structures for workarea (in case not currently mapped)
>  	 */
>  	execute_start = workarea_start;
> -	execute_end = execute_start + (PAGE_SIZE * 2) + PMD_PAGE_SIZE;
> +	execute_end = execute_start + (PAGE_SIZE * 2) + PMD_SIZE;
>  	execute_len = execute_end - execute_start;
>  
>  	/*
> @@ -383,7 +383,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
>  	 * before it is mapped.
>  	 */
>  	workarea_len = execute_len + pgtable_area_len;
> -	workarea_end = ALIGN(workarea_start + workarea_len, PMD_PAGE_SIZE);
> +	workarea_end = ALIGN(workarea_start + workarea_len, PMD_SIZE);
>  
>  	/*
>  	 * Set the address to the start of where newly created pagetable
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 9200e619d8b7..011e1fcd03bc 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -703,11 +703,11 @@ phys_addr_t slow_virt_to_phys(void *__virt_addr)
>  	switch (level) {
>  	case PG_LEVEL_1G:
>  		phys_addr = (phys_addr_t)pud_pfn(*(pud_t *)pte) << PAGE_SHIFT;
> -		offset = virt_addr & ~PUD_PAGE_MASK;
> +		offset = virt_addr & ~PUD_MASK;
>  		break;
>  	case PG_LEVEL_2M:
>  		phys_addr = (phys_addr_t)pmd_pfn(*(pmd_t *)pte) << PAGE_SHIFT;
> -		offset = virt_addr & ~PMD_PAGE_MASK;
> +		offset = virt_addr & ~PMD_MASK;
>  		break;
>  	default:
>  		phys_addr = (phys_addr_t)pte_pfn(*pte) << PAGE_SHIFT;
> @@ -995,7 +995,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
>  	case PG_LEVEL_1G:
>  		ref_prot = pud_pgprot(*(pud_t *)kpte);
>  		ref_pfn = pud_pfn(*(pud_t *)kpte);
> -		pfninc = PMD_PAGE_SIZE >> PAGE_SHIFT;
> +		pfninc = PMD_SIZE >> PAGE_SHIFT;
>  		lpaddr = address & PUD_MASK;
>  		lpinc = PMD_SIZE;
>  		/*
> diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
> index ffe3b3a087fe..78414c6d1b5e 100644
> --- a/arch/x86/mm/pti.c
> +++ b/arch/x86/mm/pti.c
> @@ -592,7 +592,7 @@ static void pti_set_kernel_image_nonglobal(void)
>  	 * of the image.
>  	 */
>  	unsigned long start = PFN_ALIGN(_text);
> -	unsigned long end = ALIGN((unsigned long)_end, PMD_PAGE_SIZE);
> +	unsigned long end = ALIGN((unsigned long)_end, PMD_SIZE);
>  
>  	/*
>  	 * This clears _PAGE_GLOBAL from the entire kernel image.
> -- 
> 2.36.0.550.gb090851708-goog
> 
> 

-- 
Sincerely yours,
Mike.
