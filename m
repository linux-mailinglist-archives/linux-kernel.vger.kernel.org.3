Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC2555F274
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 02:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiF2Aew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 20:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiF2Aeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 20:34:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D96B2FE71
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 17:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656462890; x=1687998890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gu2ji86KwLEp3cWwdUufrgM6jQM+uMNiTRLYjZQ+/Ho=;
  b=Y0/5bg+vWuvG/VHatUNqKiYkI0uPghuMGcIYyv5fAv3jwegE58LJDhPt
   nvebq8jMx2DFH4J4/NmpxzTVegxF9By+L4ShcPph4LQe6zw221q6OVf/x
   UsWY99Kk1Bt5WEHl4nnh4ocKK+2HiFkuAvEmeyv7y4ORT51BNTFM451yY
   fR1clzN5iUkZm4LuJ1+rntLUZ7yUNtdHVlEuC/Wm4rciBk4v1/vp1qE2O
   FF7wBTR0EHhHeSlGeV3qd1WzOOFjrRhAr2D/hDq8sHw9rz2kFX+KhBAMQ
   gYxETna0rVMnQTqLHACSNfvuGXQKXXC5Zkl5CsE5Nhq69eRO1+gmCrHk4
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="282977919"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="282977919"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 17:34:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="647145078"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jun 2022 17:34:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 3B9CACE; Wed, 29 Jun 2022 03:34:52 +0300 (EEST)
Date:   Wed, 29 Jun 2022 03:34:52 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 4/8] x86/mm: Handle LAM on context switch
Message-ID: <20220629003452.37yojljbcl7jjgu5@black.fi.intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-5-kirill.shutemov@linux.intel.com>
 <9efc4129-e82b-740f-3d6d-67f1468879bb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9efc4129-e82b-740f-3d6d-67f1468879bb@kernel.org>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 04:33:21PM -0700, Andy Lutomirski wrote:
> On 6/10/22 07:35, Kirill A. Shutemov wrote:
> > Linear Address Masking mode for userspace pointers encoded in CR3 bits.
> > The mode is selected per-thread. Add new thread features indicate that the
> > thread has Linear Address Masking enabled.
> > 
> > switch_mm_irqs_off() now respects these flags and constructs CR3
> > accordingly.
> > 
> > The active LAM mode gets recorded in the tlb_state.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >   arch/x86/include/asm/mmu.h         |  1 +
> >   arch/x86/include/asm/mmu_context.h | 24 ++++++++++++
> >   arch/x86/include/asm/tlbflush.h    |  3 ++
> >   arch/x86/mm/tlb.c                  | 62 ++++++++++++++++++++++--------
> >   4 files changed, 75 insertions(+), 15 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
> > index 5d7494631ea9..d150e92163b6 100644
> > --- a/arch/x86/include/asm/mmu.h
> > +++ b/arch/x86/include/asm/mmu.h
> > @@ -40,6 +40,7 @@ typedef struct {
> >   #ifdef CONFIG_X86_64
> >   	unsigned short flags;
> > +	u64 lam_cr3_mask;
> >   #endif
> >   	struct mutex lock;
> > diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> > index b8d40ddeab00..e6eac047c728 100644
> > --- a/arch/x86/include/asm/mmu_context.h
> > +++ b/arch/x86/include/asm/mmu_context.h
> > @@ -91,6 +91,29 @@ static inline void switch_ldt(struct mm_struct *prev, struct mm_struct *next)
> >   }
> >   #endif
> > +#ifdef CONFIG_X86_64
> > +static inline u64 mm_cr3_lam_mask(struct mm_struct *mm)
> > +{
> > +	return mm->context.lam_cr3_mask;
> > +}
> > +
> > +static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
> > +{
> > +	mm->context.lam_cr3_mask = oldmm->context.lam_cr3_mask;
> > +}
> > +
> > +#else
> > +
> > +static inline u64 mm_cr3_lam_mask(struct mm_struct *mm)
> > +{
> > +	return 0;
> > +}
> > +
> > +static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
> > +{
> > +}
> > +#endif
> 
> Do we really need the ifdeffery here?  I see no real harm in having the
> field exist on 32-bit -- we don't care much about performance for 32-bit
> kernels.

The waste doesn't feel right to me. I would rather keep it.

But sure I can do this if needed.

> > -	if (real_prev == next) {
> > +	if (real_prev == next && prev_lam == new_lam) {
> >   		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
> >   			   next->context.ctx_id);
> 
> This looks wrong to me.  If we change threads within the same mm but lam
> changes (which is certainly possible by a race if nothing else) then this
> will go down the "we really are changing mms" path, not the "we're not
> changing but we might need to flush something" path.

If LAM gets enabled we must write CR3 with the new LAM mode. Without the
change real_prev == next case will not do this for !was_lazy case.

Note that currently enabling LAM is done by setting LAM mode in the mmu
context and doing switch_mm(current->mm, current->mm, current), so it is
very important case.

-- 
 Kirill A. Shutemov
