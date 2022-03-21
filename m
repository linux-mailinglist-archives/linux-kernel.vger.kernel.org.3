Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2944E2F49
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350134AbiCURps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbiCURpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:45:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012493AA5B;
        Mon, 21 Mar 2022 10:44:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 142D4B818D2;
        Mon, 21 Mar 2022 17:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FE8C340E8;
        Mon, 21 Mar 2022 17:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647884656;
        bh=Cc93Sj0aRgEOWTPpRj8NNqcOtJCr+4R/IS5e+PnVDpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U3fE9mvncxRxT9MkMJyY0wRxVjZfmImW2AWeVMS26K1N5AtfUrZ1VUSp/QbiO/uIR
         BFbccvvfaSmWp/4TrOWv/MhNpySrnD3IQq3wzid7KyDktnTbLdSYaFOJLcRZtN4o7N
         aDSP6nZ92OrCdbiQk8QH4DJ9LgjlQ5L1sJF3iyIWFCD3ZQtx29z+angBTrsQGIj6Kn
         DdRfhByEDboFK2Cl786MKfWBivB0FL5zKRy23ALcA8DH4ljl0HYRhoHyjFQ4aXHahG
         qSstj/taGkUf/aMOjalkyn48fWLmLB6kIOwvf2k/g0exuPW+jZpFfMOn1uJibIorNR
         UkF9q9okXpjRg==
Date:   Mon, 21 Mar 2022 17:44:05 +0000
From:   Will Deacon <will@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org,
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
Message-ID: <20220321174404.GA11389@willie-the-truck>
References: <20220315141837.137118-1-david@redhat.com>
 <20220315141837.137118-5-david@redhat.com>
 <YjIr9f9qaz4xITVd@arm.com>
 <20220321143802.GC11145@willie-the-truck>
 <ea570f92-f896-7f9b-91c4-ad0a025bb340@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea570f92-f896-7f9b-91c4-ad0a025bb340@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 04:07:48PM +0100, David Hildenbrand wrote:
> On 21.03.22 15:38, Will Deacon wrote:
> > On Wed, Mar 16, 2022 at 06:27:01PM +0000, Catalin Marinas wrote:
> >> On Tue, Mar 15, 2022 at 03:18:34PM +0100, David Hildenbrand wrote:
> >>> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> >>> index b1e1b74d993c..62e0ebeed720 100644
> >>> --- a/arch/arm64/include/asm/pgtable-prot.h
> >>> +++ b/arch/arm64/include/asm/pgtable-prot.h
> >>> @@ -14,6 +14,7 @@
> >>>   * Software defined PTE bits definition.
> >>>   */
> >>>  #define PTE_WRITE		(PTE_DBM)		 /* same as DBM (51) */
> >>> +#define PTE_SWP_EXCLUSIVE	(_AT(pteval_t, 1) << 2)	 /* only for swp ptes */
> >>
> >> I think we can use bit 1 here.
> >>
> >>> @@ -909,12 +925,13 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
> >>>  /*
> >>>   * Encode and decode a swap entry:
> >>>   *	bits 0-1:	present (must be zero)
> >>> - *	bits 2-7:	swap type
> >>> + *	bits 2:		remember PG_anon_exclusive
> >>> + *	bits 3-7:	swap type
> >>>   *	bits 8-57:	swap offset
> >>>   *	bit  58:	PTE_PROT_NONE (must be zero)
> >>
> >> I don't remember exactly why we reserved bits 0 and 1 when, from the
> >> hardware perspective, it's sufficient for bit 0 to be 0 and the whole
> >> pte becomes invalid. We use bit 1 as the 'table' bit (when 0 at pmd
> >> level, it's a huge page) but we shouldn't check for this on a swap
> >> entry.
> > 
> > I'm a little worried that when we're dealing with huge mappings at the
> > PMD level we might lose the ability to distinguish them from a pte-level
> > mapping with this new flag set if we use bit 1. A similar issue to this
> > was fixed a long time ago by 59911ca4325d ("ARM64: mm: Move PTE_PROT_NONE
> > bit") when we used to use bit 1 for PTE_PROT_NONE.
> > 
> > Is something like:
> > 
> > 	pmd_to_swp_entry(swp_entry_to_pmd(pmd));
> 
> Note that __HAVE_ARCH_PTE_SWP_EXCLUSIVE currently only applies to actual
> swap entries, not non-swap entries (migration, hwpoison, ...). So it
> really only applies to PTEs -- PMDs are not applicable.

Right, thanks for the clarification.

> So the example you gave cannot possibly have that bit set. From what I
> understand, it should be fine. But I have no real preference: I can also
> just stick to the original patch, whatever you prefer.

I think I'd prefer to stay on the safe side and stick with bit 2 as you
originally proposed. If we need to support crazy numbers of swapfiles
in future then we can revisit the idea of allocating bit 1.

Thanks, and sorry for the trouble.

Will
