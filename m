Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3664DD901
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 12:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbiCRLeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 07:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiCRLef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:34:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89F4F5A;
        Fri, 18 Mar 2022 04:33:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C3759CE26C2;
        Fri, 18 Mar 2022 11:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81840C340E8;
        Fri, 18 Mar 2022 11:33:04 +0000 (UTC)
Date:   Fri, 18 Mar 2022 11:33:00 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v1 4/7] arm64/pgtable: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Message-ID: <YjRt7DqDFJRZA7Gt@arm.com>
References: <20220315141837.137118-1-david@redhat.com>
 <20220315141837.137118-5-david@redhat.com>
 <YjIr9f9qaz4xITVd@arm.com>
 <c3d39666-52ae-42ba-eaa2-7a0ca489f766@redhat.com>
 <YjN2qsXkmlEUTg4u@arm.com>
 <8989a07b-3a5b-0c81-983f-b35403d19579@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8989a07b-3a5b-0c81-983f-b35403d19579@redhat.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 10:59:10AM +0100, David Hildenbrand wrote:
> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> index b1e1b74d993c..fd6ddf14c190 100644
> --- a/arch/arm64/include/asm/pgtable-prot.h
> +++ b/arch/arm64/include/asm/pgtable-prot.h
> @@ -14,6 +14,7 @@
>   * Software defined PTE bits definition.
>   */
>  #define PTE_WRITE		(PTE_DBM)		 /* same as DBM (51) */
> +#define PTE_SWP_EXCLUSIVE	(PTE_TABLE_BIT)		 /* only for swp ptes */
>  #define PTE_DIRTY		(_AT(pteval_t, 1) << 55)
>  #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
>  #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 94e147e5456c..c78994073cd0 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -402,6 +402,22 @@ static inline pgprot_t mk_pmd_sect_prot(pgprot_t prot)
>  	return __pgprot((pgprot_val(prot) & ~PMD_TABLE_BIT) | PMD_TYPE_SECT);
>  }
>  
> +#define __HAVE_ARCH_PTE_SWP_EXCLUSIVE
> +static inline pte_t pte_swp_mkexclusive(pte_t pte)
> +{
> +	return set_pte_bit(pte, __pgprot(PTE_SWP_EXCLUSIVE));
> +}
> +
> +static inline int pte_swp_exclusive(pte_t pte)
> +{
> +	return pte_val(pte) & PTE_SWP_EXCLUSIVE;
> +}
> +
> +static inline pte_t pte_swp_clear_exclusive(pte_t pte)
> +{
> +	return clear_pte_bit(pte, __pgprot(PTE_SWP_EXCLUSIVE));
> +}
> +
>  #ifdef CONFIG_NUMA_BALANCING
>  /*
>   * See the comment in include/linux/pgtable.h
> @@ -908,7 +924,8 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>  
>  /*
>   * Encode and decode a swap entry:
> - *	bits 0-1:	present (must be zero)
> + *	bits 0:		present (must be zero)
> + *	bits 1:		remember PG_anon_exclusive

It looks fine to me.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
