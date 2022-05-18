Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D131352C160
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241115AbiERR2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241081AbiERR2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:28:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B60A0D0C
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652894928; x=1684430928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kpb7BRUtuQc+iJCuUBD1Lroyy3qbPng6bV/1KdEa27o=;
  b=brv+AGKmhbYnY3r+qLWbhog61Sj/IuwffptSrxZ2po70yBmY8fHc0Jtf
   VV5pmuGmRlhLxSINtqBLClJfTRoa2Bud5jxNWvkoO3LTtj6kkeQ0k76ll
   1mb2ddhvNdFkQOVR8sSyQ7nxL3Ct9SR9KSHVqUt63XI/6gwlIePpVX7qb
   cHik3O6sRX5nT+6jZwdWI9gluDvF8gTe5BrzecEBMwAYY+O/u/+Pl7iRT
   +yvTHVA8U+7uRUdmhK8e65dp9qPKRmKvrgMw2K0Hj5ybepIy5qlpOskBd
   jAa9KXtJXSStbdP5DhtGXXHDmH/FoiVYJJo5CBS5iuObdfYmlGVOyRmWB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="251686963"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="251686963"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 10:08:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="817538239"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 18 May 2022 10:08:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 6DDA3109; Wed, 18 May 2022 20:08:15 +0300 (EEST)
Date:   Wed, 18 May 2022 20:08:15 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Bharata B Rao <bharata@amd.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 08/10] x86/mm: Make LAM_U48 and mappings above 47-bits
 mutually exclusive
Message-ID: <20220518170815.4ivbuw7d6vmzh3u7@black.fi.intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-10-kirill.shutemov@linux.intel.com>
 <e6664140-934a-915d-9d16-f14500ec275e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6664140-934a-915d-9d16-f14500ec275e@amd.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 02:13:06PM +0530, Bharata B Rao wrote:
> On 5/11/2022 7:57 AM, Kirill A. Shutemov wrote:
> > LAM_U48 steals bits above 47-bit for tags and makes it impossible for
> > userspace to use full address space on 5-level paging machine.
> > 
> > Make these features mutually exclusive: whichever gets enabled first
> > blocks the othe one.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/include/asm/elf.h         |  3 ++-
> >  arch/x86/include/asm/mmu_context.h | 13 +++++++++++++
> >  arch/x86/kernel/sys_x86_64.c       |  5 +++--
> >  arch/x86/mm/hugetlbpage.c          |  6 ++++--
> >  arch/x86/mm/mmap.c                 |  9 ++++++++-
> >  5 files changed, 30 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> > index 29fea180a665..53b96b0c8cc3 100644
> > --- a/arch/x86/include/asm/elf.h
> > +++ b/arch/x86/include/asm/elf.h
> > @@ -328,7 +328,8 @@ static inline int mmap_is_ia32(void)
> >  extern unsigned long task_size_32bit(void);
> >  extern unsigned long task_size_64bit(int full_addr_space);
> >  extern unsigned long get_mmap_base(int is_legacy);
> > -extern bool mmap_address_hint_valid(unsigned long addr, unsigned long len);
> > +extern bool mmap_address_hint_valid(struct mm_struct *mm,
> > +				    unsigned long addr, unsigned long len);
> >  extern unsigned long get_sigframe_size(void);
> >  
> >  #ifdef CONFIG_X86_32
> > diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> > index 27516046117a..c8a6d80dfec3 100644
> > --- a/arch/x86/include/asm/mmu_context.h
> > +++ b/arch/x86/include/asm/mmu_context.h
> > @@ -218,6 +218,19 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
> >  
> >  unsigned long __get_current_cr3_fast(void);
> >  
> > +#ifdef CONFIG_X86_5LEVEL
> > +static inline bool full_va_allowed(struct mm_struct *mm)
> > +{
> > +	/* LAM_U48 steals VA bits abouve 47-bit for tags */
> > +	return mm->context.lam != LAM_U48;
> > +}
> > +#else
> 
> This is called from X86 common code but appears to be LAM-specific.
> What would mm->context.lam contain if X86_FEATURE_LAM isn't set?

0. So full_va_allowed() will always return true.

-- 
 Kirill A. Shutemov
