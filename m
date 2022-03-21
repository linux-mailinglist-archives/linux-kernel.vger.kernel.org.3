Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9084E2AF9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349422AbiCUOju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbiCUOjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:39:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CE1344C9;
        Mon, 21 Mar 2022 07:38:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50DBCB8170A;
        Mon, 21 Mar 2022 14:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2FBC340F4;
        Mon, 21 Mar 2022 14:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647873494;
        bh=cCtAHT5UKVL8aNZM72wkDcaRFyzjzAlZ0g+t7UAD5Ow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W9umXzQxL1ePdrGTJ7Ps6vBoXRybuD1SaEQ2+xKIityTKhRJCSKLSIPkG0KHuGpvr
         u/bEwDS5PhlsYBHvEOwLVM77s7q7a3L4kjAQ0b0pA4nrXAfqqGzahvAGSc9sKDHb34
         0kmotv/e6gv3RqRvAjLHw6/mKT1vKl5YMjvFbjV0GbEtbnuFCvgB8VGI+isp8Dvibf
         of1+equrnSN3RkAi3bo//Vx2UQ4LQHuhmxk/hdV002U5Kb7JXmGM3KClfD1lSrLrZn
         hfjKh9rKmfDSWvQTzE/NWmPOXijnxMht5jf9S8eny8OYFy2lEjvU7C/Iat8FVw0qhH
         8vFRW8dcOwVRA==
Date:   Mon, 21 Mar 2022 14:38:03 +0000
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <20220321143802.GC11145@willie-the-truck>
References: <20220315141837.137118-1-david@redhat.com>
 <20220315141837.137118-5-david@redhat.com>
 <YjIr9f9qaz4xITVd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjIr9f9qaz4xITVd@arm.com>
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

On Wed, Mar 16, 2022 at 06:27:01PM +0000, Catalin Marinas wrote:
> On Tue, Mar 15, 2022 at 03:18:34PM +0100, David Hildenbrand wrote:
> > diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> > index b1e1b74d993c..62e0ebeed720 100644
> > --- a/arch/arm64/include/asm/pgtable-prot.h
> > +++ b/arch/arm64/include/asm/pgtable-prot.h
> > @@ -14,6 +14,7 @@
> >   * Software defined PTE bits definition.
> >   */
> >  #define PTE_WRITE		(PTE_DBM)		 /* same as DBM (51) */
> > +#define PTE_SWP_EXCLUSIVE	(_AT(pteval_t, 1) << 2)	 /* only for swp ptes */
> 
> I think we can use bit 1 here.
> 
> > @@ -909,12 +925,13 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
> >  /*
> >   * Encode and decode a swap entry:
> >   *	bits 0-1:	present (must be zero)
> > - *	bits 2-7:	swap type
> > + *	bits 2:		remember PG_anon_exclusive
> > + *	bits 3-7:	swap type
> >   *	bits 8-57:	swap offset
> >   *	bit  58:	PTE_PROT_NONE (must be zero)
> 
> I don't remember exactly why we reserved bits 0 and 1 when, from the
> hardware perspective, it's sufficient for bit 0 to be 0 and the whole
> pte becomes invalid. We use bit 1 as the 'table' bit (when 0 at pmd
> level, it's a huge page) but we shouldn't check for this on a swap
> entry.

I'm a little worried that when we're dealing with huge mappings at the
PMD level we might lose the ability to distinguish them from a pte-level
mapping with this new flag set if we use bit 1. A similar issue to this
was fixed a long time ago by 59911ca4325d ("ARM64: mm: Move PTE_PROT_NONE
bit") when we used to use bit 1 for PTE_PROT_NONE.

Is something like:

	pmd_to_swp_entry(swp_entry_to_pmd(pmd));

supposed to preserve the original pmd? I'm not sure that's guaranteed
after this change if bit 1 can be cleared in the process -- we could end
up with a pte, which the hardware would interpret as a table entry and
end up with really bad things happening.

Will
