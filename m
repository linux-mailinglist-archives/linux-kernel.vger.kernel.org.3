Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE7B52F35F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352999AbiETSnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbiETSnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:43:40 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8425468E
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653072219; x=1684608219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K2pmBkR7HaYgM5K8jO0luWcfEyX30jduvESLhKA1EPY=;
  b=lscPWBI4NJWA3siXxUZPt4zuDP+oerDBtdk237NL6iucveAfLW9GPdcY
   db8rlYuUmfcBZgtqMMLnBu1+yfCboT+HUADmJZby5dhs/O8mQOI32vM80
   73pYbaDcAxmWE8xO2uWYuaXfI3OR3OCgMTYKtZE61rOTNzojSm+2XCuhD
   GyXLZhK0x52UTCgKjKjrSiskbbZ5SzYYzTlZOS/iWUIdcAEncwfrhOfpt
   ujDf/k8cbYgA8bRYBZGSLmKWZV/eBeY2jpyRtXVuxm7SkfSp2RD9npmlE
   8eStWsiMO7md4GXvbrvCkf7EX/kbOFJT51pBjT9jumOOdE1UaHkJnpahs
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="333324966"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="333324966"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 11:43:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="607143113"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 20 May 2022 11:43:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id ABBC2109; Fri, 20 May 2022 21:43:35 +0300 (EEST)
Date:   Fri, 20 May 2022 21:43:35 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCHv2 3/3] x86/tdx: Handle load_unaligned_zeropad()
 page-cross to a shared page
Message-ID: <20220520184335.oygw2q3rov2go45b@black.fi.intel.com>
References: <20220520031316.47722-1-kirill.shutemov@linux.intel.com>
 <20220520031316.47722-4-kirill.shutemov@linux.intel.com>
 <YofUMlc3ORYZ8if7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YofUMlc3ORYZ8if7@google.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 05:47:30PM +0000, Sean Christopherson wrote:
> On Fri, May 20, 2022, Kirill A. Shutemov wrote:
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
> > Check fixup table before trying to handle MMIO.
> > 
> > The issue was discovered by analysis. It was not triggered during the
> > testing.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/coco/tdx/tdx.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> > index 010dc229096a..1a1c8a92cfa5 100644
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
> > @@ -299,6 +301,24 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> >  	if (WARN_ON_ONCE(user_mode(regs)))
> >  		return -EFAULT;
> >  
> > +	/*
> > +	 * load_unaligned_zeropad() relies on exception fixups in case of the
> > +	 * word being a page-crosser and the second page is not accessible.
> > +	 *
> > +	 * In TDX guests, the second page can be shared page and VMM may
> > +	 * configure it to trigger #VE.
> > +	 *
> > +	 * Kernel assumes that #VE on a shared page is MMIO access and tries to
> > +	 * decode instruction to handle it. In case of load_unaligned_zeropad()
> > +	 * it may result in confusion as it is not MMIO access.
> 
> The guest kernel can't know that it's not "MMIO", e.g. nothing prevents the host
> from manually serving accesses to some chunk of shared memory instead of backing
> the shared chunk with host DRAM.

It would require the guest to access shared memory only with instructions
that we can deal with. I don't think we have such guarantee.

> > +	 *
> > +	 * Check fixup table before trying to handle MMIO.
> 
> This ordering is wrong, fixup should be done if and only if the instruction truly
> "faults".  E.g. if there's an MMIO access lurking in the kernel that is wrapped in
> exception fixup, then this will break that usage and provide garbage data on a read
> and drop any write.

When I tried to trigger the bug, the #VE actually succeed, because
load_unaligned_zeropad() uses instruction we can decode. But due
misalignment, the part of that came from non-shared page got overwritten
with data that came from VMM.

I guess we can try to detect misaligned accesses and handle them
correctly. But it gets complicated and easer to screw up.

Do we ever use exception fixups for MMIO accesses to justify the
complication?

-- 
 Kirill A. Shutemov
