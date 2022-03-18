Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59214DDFB5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 18:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbiCRRTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 13:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbiCRRTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 13:19:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9512F25
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 10:18:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58D79619C6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 17:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BEDC340E8;
        Fri, 18 Mar 2022 17:18:20 +0000 (UTC)
Date:   Fri, 18 Mar 2022 17:18:16 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH -next 3/4] arm64: mm: add support for page table check
Message-ID: <YjS+2FVpq8D4Gx0S@arm.com>
References: <20220317141203.3646253-1-tongtiangen@huawei.com>
 <20220317141203.3646253-4-tongtiangen@huawei.com>
 <YjOFNEvj7EfBasCI@arm.com>
 <cb91532b-c0cd-034c-2f93-4f76fabf5fc1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb91532b-c0cd-034c-2f93-4f76fabf5fc1@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 11:58:22AM +0800, Tong Tiangen wrote:
> 在 2022/3/18 3:00, Catalin Marinas 写道:
> > On Thu, Mar 17, 2022 at 02:12:02PM +0000, Tong Tiangen wrote:
> > > @@ -628,6 +647,25 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
> > >   #define pud_leaf(pud)		pud_sect(pud)
> > >   #define pud_valid(pud)		pte_valid(pud_pte(pud))
> > > +#ifdef CONFIG_PAGE_TABLE_CHECK
> > > +static inline bool pte_user_accessible_page(pte_t pte)
> > > +{
> > > +	return (pte_val(pte) & PTE_VALID) && (pte_val(pte) & PTE_USER);
> > > +}
[...]
> > Do we care about PROT_NONE mappings here? They have the valid bit
> > cleared but pte_present() is true.
> > 
> 
> PTC will not check this special type(PROT_NONE) of page.

PROT_NONE is just a permission but since we don't have independent read
and write bits in the pte, we implement it as an invalid pte (bit 0
cleared). The other content of the pte is fine, so pte_pfn() should
still work. PTC could as well check this, I don't think it hurts.

> > > +static inline bool pmd_user_accessible_page(pmd_t pmd)
> > > +{
> > > +	return pmd_leaf(pmd) && (pmd_val(pmd) & PTE_VALID) &&
> > > +		(pmd_val(pmd) & PTE_USER);
> > > +}
> > 
> > pmd_leaf() implies valid, so you can skip it if that's the aim.
> 
> PTC only checks whether the memory block corresponding to the pmd_leaf type
> can access, for !pmd_leaf, PTC checks at the pte level. So i think this is
> necessary.

My point is that the (pmd_val(pmd) & PTE_VALID) check is superfluous
since that's covered by pmd_leaf() already.

-- 
Catalin
