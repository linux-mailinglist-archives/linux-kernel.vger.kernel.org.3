Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E654B554D9A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358448AbiFVOjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbiFVOjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:39:04 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E311E3C480
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:39:03 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25MEBaAw021333;
        Wed, 22 Jun 2022 14:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=pdIbSbRnwj1MiJ5v62MY+pZBJMj80RAZYdI8cDDKfgc=;
 b=fo77gKGHc5Ox7ZatUlVacvCu4HByExvztkunv5pfLGWJC6Hmw6gWAD7hGfUCOsKhgLtH
 S+LQcu9lDNfRtNwRxIrKoEl6ML/Mlv9SjNibUU+QSZk0/a8UrVfSo7x3wJoVEMeNF7+O
 CAY7SyohiFtMZeim70ohdjhRODZrfounw683f1ghSF3Q4phsvKVXLTMG5MQeE14chzmH
 QuWQXqvRX3lsfSE17ayqtlZ1Ku4/1jrtnmvVhwFUEj8Oqo0zQUaoPvyVMx7BZAuJXCXh
 NiIQXj1BCKs/2Rb4VvYhzFDFjVZnqN2D0UjB0eXTbQky3kb1nitxOEg0b3XzeLy5A7k3 uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gv4mhrt9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 14:38:40 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25MENme8011917;
        Wed, 22 Jun 2022 14:38:39 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gv4mhrt8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 14:38:39 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25MEa84M000309;
        Wed, 22 Jun 2022 14:38:37 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3gs6b95snp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 14:38:37 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25MEcZBY17170914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 14:38:35 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1254F42045;
        Wed, 22 Jun 2022 14:38:35 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5BDD42042;
        Wed, 22 Jun 2022 14:38:33 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.80.189])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 22 Jun 2022 14:38:33 +0000 (GMT)
Date:   Wed, 22 Jun 2022 09:38:30 -0500
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/3] mm: Add PUD level pagetable account
Message-ID: <YrMpZlQHMuCy06/m@linux.ibm.com>
References: <cover.1655887440.git.baolin.wang@linux.alibaba.com>
 <f7b2a6f6f5dfecbcac07fa3e187f10860c3a39ee.1655887440.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7b2a6f6f5dfecbcac07fa3e187f10860c3a39ee.1655887440.git.baolin.wang@linux.alibaba.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PLcB6ocE7H_Z-boI_GOvV7z9BmzZmXwu
X-Proofpoint-ORIG-GUID: HPbS5w8hfVhzFUMDAgVN4sF6fg3AIDX_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-22_04,2022-06-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=884 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206220074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 04:58:53PM +0800, Baolin Wang wrote:
> Now the PUD level ptes are always protected by mm->page_table_lock,
> which means no split pagetable lock needed. So the generic PUD level
> pagetable pages allocation will not call pgtable_pte_page_ctor/dtor(),
> that means we will miss to account PUD level pagetable pages.
> 
> Adding pagetable account by calling pgtable_set_and_inc() or
> pgtable_clear_and_dec() when allocating or freeing PUD level pagetable
> pages to help to get an accurate pagetable accounting.
> 
> Moreover this patch will also mark the PUD level pagetable with PG_table
> flag, which will help to do sanity validation in unpoison_memory() and
> get more accurate pagetable accounting by /proc/kpageflags interface.
> 
> Meanwhile converting the architectures with using generic PUD pagatable
> allocation to add corresponding pgtable_set_and_inc() or pgtable_clear_and_dec()
> to account PUD level pagetable.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  arch/arm64/include/asm/tlb.h         |  5 ++++-
>  arch/loongarch/include/asm/pgalloc.h | 11 ++++++++---
>  arch/mips/include/asm/pgalloc.h      | 11 ++++++++---
>  arch/s390/include/asm/tlb.h          |  1 +
>  arch/x86/mm/pgtable.c                |  5 ++++-
>  include/asm-generic/pgalloc.h        | 12 ++++++++++--
>  6 files changed, 35 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
> index c995d1f..47e0623 100644
> --- a/arch/arm64/include/asm/tlb.h
> +++ b/arch/arm64/include/asm/tlb.h
> @@ -94,7 +94,10 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
>  static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
>  				  unsigned long addr)
>  {
> -	tlb_remove_table(tlb, virt_to_page(pudp));
> +	struct page *page = virt_to_page(pudp);
> +
> +	pgtable_clear_and_dec(page);
> +	tlb_remove_table(tlb, page);
>  }
>  #endif
>  
> diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
> index b0a57b2..50a896f 100644
> --- a/arch/loongarch/include/asm/pgalloc.h
> +++ b/arch/loongarch/include/asm/pgalloc.h
> @@ -89,10 +89,15 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
>  static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
>  {
>  	pud_t *pud;
> +	struct page *pg;

	struct page *page;

looks better IMO.

> +
> +	pg = alloc_pages(GFP_KERNEL & ~__GFP_HIGHMEM, PUD_ORDER);
> +	if (!pg)
> +		return NULL;
>  
> -	pud = (pud_t *) __get_free_pages(GFP_KERNEL, PUD_ORDER);
> -	if (pud)
> -		pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
> +	pgtable_set_and_inc(pg);
> +	pud = (pud_t *)page_address(pg);

I don't think __get_free_pages() should be replaced with alloc_pages()
here, just call pgtable_set_and_inc() with virt_to_page(pud). 

The same applies for the cases below.

> +	pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
>  	return pud;
>  }
>  
> diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
> index 867e9c3..0950f5f 100644
> --- a/arch/mips/include/asm/pgalloc.h
> +++ b/arch/mips/include/asm/pgalloc.h
> @@ -89,11 +89,16 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
>  
>  static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
>  {
> +	struct page *pg;
>  	pud_t *pud;
>  
> -	pud = (pud_t *) __get_free_pages(GFP_KERNEL, PUD_ORDER);
> -	if (pud)
> -		pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
> +	pg = alloc_pages(GFP_KERNEL & ~__GFP_HIGHMEM, PUD_ORDER);
> +	if (!pg)
> +		return NULL;
> +
> +	pgtable_set_and_inc(pg);
> +	pud = (pud_t *)page_address(pg);
> +	pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
>  	return pud;
>  }
>  
> diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
> index fe6407f..45f9541 100644
> --- a/arch/s390/include/asm/tlb.h
> +++ b/arch/s390/include/asm/tlb.h
> @@ -125,6 +125,7 @@ static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
>  {
>  	if (mm_pud_folded(tlb->mm))
>  		return;
> +	pgtable_clear_and_dec(virt_to_page(pud));
>  	tlb->mm->context.flush_mm = 1;
>  	tlb->freed_tables = 1;
>  	tlb->cleared_p4ds = 1;
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index a932d77..a8ab3f9 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -76,8 +76,11 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
>  #if CONFIG_PGTABLE_LEVELS > 3
>  void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
>  {
> +	struct page *page = virt_to_page(pud);
> +
> +	pgtable_clear_and_dec(page);
>  	paravirt_release_pud(__pa(pud) >> PAGE_SHIFT);
> -	paravirt_tlb_remove_table(tlb, virt_to_page(pud));
> +	paravirt_tlb_remove_table(tlb, page);
>  }
>  
>  #if CONFIG_PGTABLE_LEVELS > 4
> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
> index 977bea1..328a714 100644
> --- a/include/asm-generic/pgalloc.h
> +++ b/include/asm-generic/pgalloc.h
> @@ -149,11 +149,16 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
>  
>  static inline pud_t *__pud_alloc_one(struct mm_struct *mm, unsigned long addr)
>  {
> +	struct page *page;
>  	gfp_t gfp = GFP_PGTABLE_USER;
>  
>  	if (mm == &init_mm)
>  		gfp = GFP_PGTABLE_KERNEL;
> -	return (pud_t *)get_zeroed_page(gfp);
> +	page = alloc_pages((gfp | __GFP_ZERO) & ~__GFP_HIGHMEM, 0);
> +	if (!page)
> +		return NULL;
> +	pgtable_set_and_inc(page);
> +	return (pud_t *)page_address(page);
>  }
>  
>  #ifndef __HAVE_ARCH_PUD_ALLOC_ONE
> @@ -174,8 +179,11 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
>  
>  static inline void __pud_free(struct mm_struct *mm, pud_t *pud)
>  {
> +	struct page *page = virt_to_page(pud);
> +
>  	BUG_ON((unsigned long)pud & (PAGE_SIZE-1));
> -	free_page((unsigned long)pud);
> +	pgtable_clear_and_dec(page);
> +	__free_page(page);
>  }
>  
>  #ifndef __HAVE_ARCH_PUD_FREE
> -- 
> 1.8.3.1
> 

-- 
Sincerely yours,
Mike.
