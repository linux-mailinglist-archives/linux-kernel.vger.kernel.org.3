Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A25561E01
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 16:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbiF3OeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 10:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbiF3Ods (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 10:33:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589CE10576
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 07:18:14 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UEBuQt024828;
        Thu, 30 Jun 2022 14:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=I6hTOrQDUqoiXN1ljlMKHmHP6+GQgjsGFvsXptYeIVs=;
 b=EDed1QYSpedE9fv9FPcwymzqMovpw3LL2PSxEXhjFjNlTOMh9X7zaE3XDmKcrQ1thvr3
 9B0fXVFb3YXuTNNvycrVPC7GoNAp9eHoMB9fVx+Tt+4ROKyXV/jVfr033L4ACJbpCDe8
 EjZNU02nw+1J79+rpgd+eWVj85plvvCNZgpdA38pAPA+w1mow9WE8dw/QNrD/ChcbTgN
 AREgmexCItDirhcWSglllKkI6JNzvW8/Ve7mIgkEo3/zV0lqym/iaTaJH/s3AMsZsL3Q
 JETZ346mCxJIZJVsGHCJZiE/l9fMuZ8f6qcaEfVJXlSXZJ94GPvGedBpxAgYf7DW/l3Y Dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1dck86a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 14:18:06 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25UECur4027654;
        Thu, 30 Jun 2022 14:18:05 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1dck8693-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 14:18:05 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25UE6TtQ028844;
        Thu, 30 Jun 2022 14:18:03 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3gwt0966b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 14:18:02 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25UEI07s17563934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 14:18:00 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA4C3A404D;
        Thu, 30 Jun 2022 14:18:00 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13B6AA4057;
        Thu, 30 Jun 2022 14:18:00 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.154.93])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 30 Jun 2022 14:17:59 +0000 (GMT)
Date:   Thu, 30 Jun 2022 17:17:58 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/3] mm: Add PUD level pagetable account
Message-ID: <Yr2wlqQkpsffTvd/@linux.ibm.com>
References: <cover.1656586863.git.baolin.wang@linux.alibaba.com>
 <6a6a768634b9ce8537154264e35e6a66a79b6ca8.1656586863.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a6a768634b9ce8537154264e35e6a66a79b6ca8.1656586863.git.baolin.wang@linux.alibaba.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WVcIpKJfo2lDqFX4ucVQD1cBEfJRye34
X-Proofpoint-ORIG-GUID: WIoOlTbzpBxEhG5HF2nuYn8VeiiLESgY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_09,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxlogscore=939 clxscore=1015 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206300056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 07:11:15PM +0800, Baolin Wang wrote:
> Now the PUD level ptes are always protected by mm->page_table_lock,
> which means no split pagetable lock needed. So the generic PUD level
> pagetable pages allocation will not call pgtable_pte_page_ctor/dtor(),
> that means we will miss to account PUD level pagetable pages.
> 
> Adding pagetable account by calling pgtable_page_inc() or
> pgtable_page_dec() when allocating or freeing PUD level pagetable
> pages to help to get an accurate pagetable accounting.
> 
> Moreover this patch will also mark the PUD level pagetable with PG_table
> flag, which will help to do sanity validation in unpoison_memory() and
> get more accurate pagetable accounting by /proc/kpageflags interface.
> 
> Meanwhile converting the architectures with using generic PUD pagatable
> allocation to add corresponding pgtable_page_inc() or pgtable_page_dec()
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
> index c995d1f..1772df9 100644
> --- a/arch/arm64/include/asm/tlb.h
> +++ b/arch/arm64/include/asm/tlb.h
> @@ -94,7 +94,10 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
>  static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
>  				  unsigned long addr)
>  {
> -	tlb_remove_table(tlb, virt_to_page(pudp));
> +	struct page *page = virt_to_page(pudp);
> +
> +	pgtable_page_dec(page);

Using pgtable_pud_page_ctor() and pgtable_pud_page_dtor() would be
consistent with what we currently have for PTEs and PMDs.

This applies to all the additions of pgtable_page_dec() and
pgtable_page_inc().

> +	tlb_remove_table(tlb, page);
>  }
>  #endif
>  
> diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
> index b0a57b2..19bfe14 100644
> --- a/arch/loongarch/include/asm/pgalloc.h
> +++ b/arch/loongarch/include/asm/pgalloc.h
> @@ -89,10 +89,15 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
>  static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
>  {
>  	pud_t *pud;
> +	struct page *page;
>  
> -	pud = (pud_t *) __get_free_pages(GFP_KERNEL, PUD_ORDER);
> -	if (pud)
> -		pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
> +	page = alloc_pages(GFP_KERNEL, PUD_ORDER);
> +	if (!page)
> +		return NULL;
> +
> +	pgtable_page_inc(page);
> +	pud = (pud_t *)page_address(page);
> +	pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
>  	return pud;
>  }
>  
> diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
> index 867e9c3..990f614 100644
> --- a/arch/mips/include/asm/pgalloc.h
> +++ b/arch/mips/include/asm/pgalloc.h
> @@ -89,11 +89,16 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
>  
>  static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
>  {
> +	struct page *page;
>  	pud_t *pud;
>  
> -	pud = (pud_t *) __get_free_pages(GFP_KERNEL, PUD_ORDER);
> -	if (pud)
> -		pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
> +	page = alloc_pages(GFP_KERNEL, PUD_ORDER);
> +	if (!page)
> +		return NULL;
> +
> +	pgtable_page_inc(page);
> +	pud = (pud_t *)page_address(page);
> +	pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
>  	return pud;
>  }
>  
> diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
> index fe6407f..744e2d7 100644
> --- a/arch/s390/include/asm/tlb.h
> +++ b/arch/s390/include/asm/tlb.h
> @@ -125,6 +125,7 @@ static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
>  {
>  	if (mm_pud_folded(tlb->mm))
>  		return;
> +	pgtable_page_dec(virt_to_page(pud));
>  	tlb->mm->context.flush_mm = 1;
>  	tlb->freed_tables = 1;
>  	tlb->cleared_p4ds = 1;
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index a932d77..5e46e31 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -76,8 +76,11 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
>  #if CONFIG_PGTABLE_LEVELS > 3
>  void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
>  {
> +	struct page *page = virt_to_page(pud);
> +
> +	pgtable_page_dec(page);
>  	paravirt_release_pud(__pa(pud) >> PAGE_SHIFT);
> -	paravirt_tlb_remove_table(tlb, virt_to_page(pud));
> +	paravirt_tlb_remove_table(tlb, page);
>  }
>  
>  #if CONFIG_PGTABLE_LEVELS > 4
> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
> index 977bea1..11350f7 100644
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
> +	page = alloc_pages(gfp, 0);
> +	if (!page)
> +		return NULL;
> +	pgtable_page_inc(page);
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
> +	pgtable_page_dec(page);
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
