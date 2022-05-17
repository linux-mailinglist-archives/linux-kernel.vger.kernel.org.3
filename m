Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA7152A97B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 19:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351575AbiEQRlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 13:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351550AbiEQRkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 13:40:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1068FE0
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 10:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652809245; x=1684345245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+C363D2f4ARqD1nu+m9rjffoqaPnSfI4xOAqk8WxIjY=;
  b=EVo6YZeBuFAls22XolpgKsuDhYpLHd7ZbNjZ8RJXac/Wr7QoDQ6fldib
   NKQDe7BmUU4Yn+ZVzLOc2LB2suSBQZjNV06r76Y1KWobR+F1llNCyW0Nl
   a4B7PaNoCh/BE2qpg0DMWAxUVn85iA3asz4tnvzE8l8EPpiB6sxuUFh6e
   +MX1xx0zcu99DNVLYJrBCIuvZWmnyagGaUO6lgm/Oi4YfMWjd4VWK4rQg
   pA8bwKwCUSEmthL3Ri8SxE+B+lhnXvGCGqgDta9ejt8GN7VVwgOcKmZaV
   T1BBs8YQa6j1DK1bQ3/FV1ZukunzmR9voiWB1IdbJVtZ1agYAf2O3XoDg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="271389077"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="271389077"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 10:40:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="817002026"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 17 May 2022 10:40:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 2A264CE; Tue, 17 May 2022 20:40:42 +0300 (EEST)
Date:   Tue, 17 May 2022 20:40:42 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        seanjc@google.com, thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tdx: Handle load_unaligned_zeropad() page-cross to a
 shared page
Message-ID: <20220517174042.v6s7wm3u5j2ebaoq@black.fi.intel.com>
References: <20220517153021.11116-1-kirill.shutemov@linux.intel.com>
 <e73cb19e-7dab-2fc1-b947-fac70fd607d2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e73cb19e-7dab-2fc1-b947-fac70fd607d2@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 09:36:03AM -0700, Dave Hansen wrote:
> On 5/17/22 08:30, Kirill A. Shutemov wrote:
> > load_unaligned_zeropad() can lead to unwanted loads across page boundaries.
> > The unwanted loads are typically harmless. But, they might be made to
> > totally unrelated or even unmapped memory. load_unaligned_zeropad()
> > relies on exception fixup (#PF, #GP and now #VE) to recover from these
> > unwanted loads.
> > 
> > In TDX guest the second page can be shared page and VMM may configure it
> > to trigger #VE.
> > 
> > Kernel assumes that #VE on a shared page is MMIO access and tries to
> > decode instruction to handle it. In case of load_unaligned_zeropad() it
> > may result in confusion as it is not MMIO access.
> > 
> > Check fixup table before trying to handle MMIO.
> 
> Is this a theoretical problem or was it found in practice?

No, it was found based on analysis.

The problem was found in practice for private pages (see the patch in the
unaccepted memory support patchset), but not for shared.

For shared I had to do some tricks to get it triggered. Shared pages that
configured to trigger MMIO normally comes from ioremap() and they are not
mapped next to normally allocated pages. I had to force this situation.

But there are normally allocated pages that we make shared, like SWIOTLB
buffer. These pages usually do not trigger #VE, but malicious host can
configure them to trigged it at any point.

Even after I forced the situation, insn_decode_mmio() worked fine as
load_unaligned_zeropad() uses a flavour of MOV that insn_decode_mmio() can
decode. But it gets situation worse: we ask host to handle MMIO for the
address in private page and it allows host to override the part of the
word that comes from the private pages. :/

> > diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> > index 03deb4d6920d..5fbdda2f2b86 100644
> > --- a/arch/x86/coco/tdx/tdx.c
> > +++ b/arch/x86/coco/tdx/tdx.c
> > @@ -11,6 +11,8 @@
> >  #include <asm/insn.h>
> >  #include <asm/insn-eval.h>
> >  #include <asm/pgtable.h>
> > +#include <asm/trapnr.h>
> > +#include <asm/extable.h>
> >  
> >  /* TDX module Call Leaf IDs */
> >  #define TDX_GET_INFO			1
> > @@ -296,6 +298,26 @@ static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> >  	if (WARN_ON_ONCE(user_mode(regs)))
> >  		return false;
> >  
> > +	/*
> > +	 * load_unaligned_zeropad() relies on exception fixups in case of the
> > +	 * word being a page-crosser and the second page is not accessible.
> > +	 *
> > +	 * In TDX guest the second page can be shared page and VMM may
> 
> 	In TDX guests,
> 
> > +	 * configure it to trigger #VE.
> > +	 *
> > +	 * Kernel assumes that #VE on a shared page is MMIO access and tries to
> > +	 * decode instruction to handle it. In case of load_unaligned_zeropad()
> > +	 * it may result in confusion as it is not MMIO access.
> > +	 *
> > +	 * Check fixup table before trying to handle MMIO.
> > +	 */
> > +	if (fixup_exception(regs, X86_TRAP_VE, 0, ve->gla)) {
> > +		/* regs->ip is adjusted by fixup_exception() */
> > +		ve->instr_len = 0;
> > +
> > +		return true;
> > +	}
> 
> This 've->instr_len = ' stuff is just a hack.
> 
> ve_info is a software structure.  Why not just add a:
> 
> 	bool ip_adjusted;
> 
> which defaults to false, then we have:
> 
> 	/*
> 	 * Adjust RIP if the exception was handled
> 	 * but RIP was not adjusted.
> 	 */
> 	if (!ret && !ve_info->ip_adjusted)
> 		regs->ip += ve_info->instr_len;
> 
> One other oddity I just stumbled upon:
> 
> static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> {
> ...
>         ve->instr_len = insn.length;
> 
> Why does that need to override 've->instr_len'?  What was wrong with the
> gunk in r10 that came out of TDX_GET_VEINFO?

TDX module doesn't decode MMIO instruction and does not provide valid size
of it. We had to do it manually, based on decoding.

Given that we had to adjust IP in handle_mmio() anyway, do you still think
"ve->instr_len = 0;" is wrong? I dislike ip_adjusted more.

-- 
 Kirill A. Shutemov
