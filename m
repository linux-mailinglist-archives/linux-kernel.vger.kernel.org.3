Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06786554DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357658AbiFVOpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359008AbiFVOo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:44:59 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7BD32EF3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:44:58 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25ME17w2022747;
        Wed, 22 Jun 2022 14:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=KcdRw3jHECLn6Ja+zzL/KO5AFIoIqhijGNWNoK3w2kE=;
 b=DN4akBKBkR+JXBgvBBe4MFYR6b3vJv64kpNPCEJpaD35tTMIjLrFS+gLG6Qv2b3j8kIc
 IOjsdUt9cCIXPo40Wwr124Nd+M2RsVhB6ufjUrtOnrsfnuzvQyrUo6w06gYJ2b4hLjpH
 LNECWhRS/VBnJOl3zS5l1+RcEH8gJldiQwZlqg8psrYKOW/+vH4/qcyA94fEYgr1JOWN
 BGGSHW7fc0jtC1G+iXhjXxYRF2GX5T0f8+xg5UFrJVeuxHehbmDbWOeGqHvRf+3/wcqe
 FKU2yOF9MjMpfUdQnVxILqlXwyn3zM2VDja4hYHQBx4QuuhqoDmybZ/bnANwdQD+9M2G qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gv4fqs9yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 14:44:37 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25ME1PEV023383;
        Wed, 22 Jun 2022 14:44:37 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gv4fqs9xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 14:44:37 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25MEZ2FY025249;
        Wed, 22 Jun 2022 14:44:35 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3gs5yhnte8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 14:44:35 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25MEiX7p21823770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 14:44:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F97EA4051;
        Wed, 22 Jun 2022 14:44:33 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A73FA404D;
        Wed, 22 Jun 2022 14:44:32 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.80.189])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 22 Jun 2022 14:44:31 +0000 (GMT)
Date:   Wed, 22 Jun 2022 09:44:29 -0500
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/3] mm: Add kernel PTE level pagetable pages
 account
Message-ID: <YrMqzWvc9x5HWm5v@linux.ibm.com>
References: <cover.1655887440.git.baolin.wang@linux.alibaba.com>
 <7882bbf467440f9a3ebe41d96ba5b6f384081bb7.1655887440.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7882bbf467440f9a3ebe41d96ba5b6f384081bb7.1655887440.git.baolin.wang@linux.alibaba.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YvciyFbpBTrApP-NTN2QL39zgrbVH3rH
X-Proofpoint-ORIG-GUID: wqZgU3LuTvycAH--92Tkgk2hWQwUUNSm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-22_04,2022-06-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206220074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 04:58:54PM +0800, Baolin Wang wrote:
> Now the kernel PTE level ptes are always protected by mm->page_table_lock
> instead of split pagetable lock, so the kernel PTE level pagetable pages
> are not accounted. Especially the vmalloc()/vmap() can consume lots of
> kernel pagetable, so to get an accurate pagetable accounting, calling new
> helpers pgtable_set_and_inc()/pgtable_clear_and_dec() when allocating or
> freeing a kernel PTE level pagetable page.

This patch only adds accounting to the page tables allocated after boot,
please mention this in the changelog.
 
> Meanwhile converting architectures to use corresponding generic PTE pagetable
> allocation and freeing functions.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> ---
>  arch/csky/include/asm/pgalloc.h |  2 +-
>  arch/microblaze/mm/pgtable.c    |  2 +-
>  arch/openrisc/mm/ioremap.c      |  2 +-
>  arch/x86/mm/pgtable.c           |  5 ++++-
>  include/asm-generic/pgalloc.h   | 14 ++++++++++++--
>  5 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
> index bbbd069..2443226 100644
> --- a/arch/csky/include/asm/pgalloc.h
> +++ b/arch/csky/include/asm/pgalloc.h
> @@ -29,7 +29,7 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>  	pte_t *pte;
>  	unsigned long i;
>  
> -	pte = (pte_t *) __get_free_page(GFP_KERNEL);
> +	pte = __pte_alloc_one_kernel(mm);
>  	if (!pte)
>  		return NULL;
>  
> diff --git a/arch/microblaze/mm/pgtable.c b/arch/microblaze/mm/pgtable.c
> index 9f73265..e96dd1b 100644
> --- a/arch/microblaze/mm/pgtable.c
> +++ b/arch/microblaze/mm/pgtable.c
> @@ -245,7 +245,7 @@ unsigned long iopa(unsigned long addr)
>  __ref pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>  {
>  	if (mem_init_done)
> -		return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> +		return __pte_alloc_one_kernel(mm);
>  	else
>  		return memblock_alloc_try_nid(PAGE_SIZE, PAGE_SIZE,
>  					      MEMBLOCK_LOW_LIMIT,
> diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
> index daae13a..3453acc 100644
> --- a/arch/openrisc/mm/ioremap.c
> +++ b/arch/openrisc/mm/ioremap.c
> @@ -118,7 +118,7 @@ pte_t __ref *pte_alloc_one_kernel(struct mm_struct *mm)
>  	pte_t *pte;
>  
>  	if (likely(mem_init_done)) {
> -		pte = (pte_t *)get_zeroed_page(GFP_KERNEL);
> +		pte = __pte_alloc_one_kernel(mm);
>  	} else {
>  		pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>  		if (!pte)
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index a8ab3f9..fc2b9ef 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -851,6 +851,7 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
>  int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
>  {
>  	pte_t *pte;
> +	struct page *page;
>  
>  	pte = (pte_t *)pmd_page_vaddr(*pmd);
>  	pmd_clear(pmd);
> @@ -858,7 +859,9 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
>  	/* INVLPG to clear all paging-structure caches */
>  	flush_tlb_kernel_range(addr, addr + PAGE_SIZE-1);
>  
> -	free_page((unsigned long)pte);
> +	page = virt_to_page(pte);
> +	pgtable_clear_and_dec(page);
> +	__free_page(page);
>  
>  	return 1;
>  }
> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
> index 328a714..2e20e9e 100644
> --- a/include/asm-generic/pgalloc.h
> +++ b/include/asm-generic/pgalloc.h
> @@ -18,7 +18,14 @@
>   */
>  static inline pte_t *__pte_alloc_one_kernel(struct mm_struct *mm)
>  {
> -	return (pte_t *)__get_free_page(GFP_PGTABLE_KERNEL);
> +	struct page *page;
> +	gfp_t gfp = GFP_PGTABLE_KERNEL;
> +
> +	page = alloc_pages(gfp & ~__GFP_HIGHMEM, 0);
> +	if (!page)
> +		return NULL;
> +	pgtable_set_and_inc(page);
> +	return (pte_t *)page_address(page);

{
	pte_t *pte = (pte_t *)__get_free_page(GFP_PGTABLE_KERNEL);

	if (pte)
		pgtable_set_and_inc(virt_to_page(pte));

	return pte;
}

looks simpler, doesn't it?

>  }
>  
>  #ifndef __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
> @@ -41,7 +48,10 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   */
>  static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>  {
> -	free_page((unsigned long)pte);
> +	struct page *page = virt_to_page(pte);
> +
> +	pgtable_clear_and_dec(page);
> +	__free_page(page);
>  }
>  
>  /**
> -- 
> 1.8.3.1
> 

-- 
Sincerely yours,
Mike.
