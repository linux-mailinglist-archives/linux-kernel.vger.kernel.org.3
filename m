Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AC654D49A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348203AbiFOWc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347100AbiFOWcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:32:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D91C1276E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655332371; x=1686868371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FSttXoXMmjuzh1EBVUYzozkJheq6d3nKXqZ4C/BQbFI=;
  b=WtLohGU1G6RPWxUVSANRi4YNmK41VNoKkoIY6RV13NGfS4DDyp3DxsV7
   AxwamQpK5inftL+YSsDKv7qy8gb0pQYiS+TjgSJRTAFf6B4mD2EBNK7Y+
   2AUXcVhmr5kPDsIglnSz5nug3Yeoh6XHhvct0BuaD492DVUlY+CL/gpYY
   9r+GT1dTP4KWW5mc4K9cqr10FeQwQcvzjKyLUBC4VtRCLuXOgyiYIAvfC
   eFRIerAt8FAJuZhADtHywvLH7eY7vEDEFZn1kXLhoPvHhSM8es9rf/qT6
   tBYuriV4QrPv2nfhqfEIVSF35DYlH3NcOP3ZWnelaIVIITPkrlIhw+CL7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="279172386"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="279172386"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 15:32:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="911890164"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jun 2022 15:32:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 0EB6B109; Thu, 16 Jun 2022 01:32:51 +0300 (EEST)
Date:   Thu, 16 Jun 2022 01:32:51 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCHv4 3/3] x86/tdx: Handle load_unaligned_zeropad()
 page-cross to a shared page
Message-ID: <20220615223251.bm4q24pnwkv37w2q@black.fi.intel.com>
References: <20220614120135.14812-1-kirill.shutemov@linux.intel.com>
 <20220614120135.14812-4-kirill.shutemov@linux.intel.com>
 <2a6e0dbb-89e3-9735-de20-132992d699b4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a6e0dbb-89e3-9735-de20-132992d699b4@intel.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 11:12:35AM -0700, Dave Hansen wrote:
> On 6/14/22 05:01, Kirill A. Shutemov wrote:
> > load_unaligned_zeropad() can lead to unwanted loads across page boundaries.
> > The unwanted loads are typically harmless. But, they might be made to
> > totally unrelated or even unmapped memory. load_unaligned_zeropad()
> > relies on exception fixup (#PF, #GP and now #VE) to recover from these
> > unwanted loads.
> > 
> > In TDX guests, the second page can be shared page and VMM may configure
> > it to trigger #VE.
> > 
> > Kernel assumes that #VE on a shared page is MMIO access and tries to
> > decode instruction to handle it. In case of load_unaligned_zeropad() it
> > may result in confusion as it is not MMIO access.
> > 
> > Fix it by detecting split page MMIO accesses and fail them.
> > load_unaligned_zeropad() will recover using exception fixups.
> > 
> > The issue was discovered by analysis. It was not triggered during the
> > testing.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/coco/tdx/tdx.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> > index 7d6d484a6d28..3bcaf2170ede 100644
> > --- a/arch/x86/coco/tdx/tdx.c
> > +++ b/arch/x86/coco/tdx/tdx.c
> > @@ -333,8 +333,8 @@ static bool mmio_write(int size, unsigned long addr, unsigned long val)
> >  
> >  static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> >  {
> > +	unsigned long *reg, val, vaddr;
> >  	char buffer[MAX_INSN_SIZE];
> > -	unsigned long *reg, val;
> >  	struct insn insn = {};
> >  	enum mmio_type mmio;
> >  	int size, extend_size;
> > @@ -360,6 +360,19 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> >  			return -EINVAL;
> >  	}
> >  
> > +	/*
> > +	 * Reject EPT violation #VEs that split pages.
> > +	 *
> > +	 * MMIO accesses suppose to be naturally aligned and therefore never
> > +	 * cross a page boundary. Seeing split page accesses indicates a bug
> > +	 * or load_unaligned_zeropad() that steps into unmapped shared page.
> 
> Isn't this "unmapped" thing a rather superfluous implementation detail?
> 
> For the guest, it just needs to know that it *CAN* #VE on access to MMIO
> and that it needs to be prepared.  The fact that MMIO is implemented
> with TDX shared memory *AND* that "unmapped shared pages" can cause
> #VE's seems like too much detail.

Okay, fair enough.

> Also, is this all precise?  Are literal unmapped shared pages the *ONLY*
> thing that a hypervisor can do do case a #VE?  What about, say, reserved
> bits being set in a shared EPT entry?

Right, it is analogous to page fault. So, yes, it can be triggered for
a number of reasons, not only unmapped.

> I was thinking a comment like this might be better:
> 
> >         /*
> >          * Reject EPT violation #VEs that split pages.
> >          *
> >          * MMIO accesses are supposed to be naturally aligned and therefore
> >          * never cross page boundaries. Seeing split page accesses indicates
> >          * a bug or a load_unaligned_zeropad() that stepped into an MMIO page.
> >          *
> >          * load_unaligned_zeropad() will recover using exception fixups.
> >          */

Looks good, thanks.

-- 
 Kirill A. Shutemov
