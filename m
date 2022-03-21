Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289D94E2CDF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348056AbiCUPx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350712AbiCUPxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:53:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554151777F0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647877939; x=1679413939;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XCjwSZNXSIVogZF+tpJYJ0HEnNWCfLTJaR9dHUvTQmc=;
  b=nu5IABiwJMa1rwi+AFuVR7HzjGxlOSkNvCWIjqthLLCd1pHpptCG40nt
   M/Lc4zHRiQ24ZHT5NpIIjesDciXHgoUsuLqYWjiEIFlDhq2Ut10h1/c75
   cqyfDfeKrNUXyMv/DjER1mHIVf81mJPFTrEZdAyjPvONOTeyHber6ePfs
   HO6awCw2kCjNVBNC9P2QxAS81MV5Kel/M8R33cJV4QJ4b5w46IGNzCv4P
   mmjGLHZnsLXS88bZgYHwYZYtjxMyPaDtxM1GXbb986YU5+uHRklVsuRrJ
   wYa/VcfRa3GhnszoM8A5iT+s/OMDE7E2zZzXj42LEIXMt9h/I2/NK7uNR
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="239741208"
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="239741208"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 08:52:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="514977890"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 21 Mar 2022 08:52:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 0D86418E; Mon, 21 Mar 2022 17:52:29 +0200 (EET)
Date:   Mon, 21 Mar 2022 18:52:29 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCHv7 02/30] x86/tdx: Provide common base for SEAMCALL and
 TDCALL C wrappers
Message-ID: <20220321155229.jrjht4vnxgrh2wq5@black.fi.intel.com>
References: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
 <20220318153048.51177-3-kirill.shutemov@linux.intel.com>
 <YjXtK4awY6utz3wE@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjXtK4awY6utz3wE@zn.tnic>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2022 at 03:48:11PM +0100, Borislav Petkov wrote:
> On Fri, Mar 18, 2022 at 06:30:20PM +0300, Kirill A. Shutemov wrote:
> > Secure Arbitration Mode (SEAM) is an extension of VMX architecture.  It
> > defines a new VMX root operation (SEAM VMX root) and a new VMX non-root
> > operation (SEAM VMX non-root) which are both isolated from the legacy
> > VMX operation where the host kernel runs.
> > 
> > A CPU-attested software module (called 'TDX module') runs in SEAM VMX
> > root to manage and protect VMs running in SEAM VMX non-root.  SEAM VMX
> > root is also used to host another CPU-attested software module (called
> > 'P-SEAMLDR') to load and update the TDX module.
> > 
> > Host kernel transits to either P-SEAMLDR or TDX module via the new
> > SEAMCALL instruction, which is essentially a VMExit from VMX root mode
> > to SEAM VMX root mode.  SEAMCALLs are leaf functions defined by
> > P-SEAMLDR and TDX module around the new SEAMCALL instruction.
> > 
> > A guest kernel can also communicate with TDX module via TDCALL
> > instruction.
> > 
> > TDCALLs and SEAMCALLs use an ABI different from the x86-64 system-v ABI.
> > RAX is used to carry both the SEAMCALL leaf function number (input) and
> > the completion status (output).  Additional GPRs (RCX, RDX, R8-R11) may
> > be further used as both input and output operands in individual leaf.
> > 
> > TDCALL and SEAMCALL share the same ABI and require the largely same
> > code to pass down arguments and retrieve results.
> > 
> > Define an assembly macro that can be used to implement C wrapper for
> > both TDCALL and SEAMCALL.
> > 
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> > TDCALL wrapper will be implemented using the macro later in the series.
> > SEAMCALL wrapper is out-of-scope for the series and will be implemented
> > as part of TDX host enabling.
> > ---
> >  arch/x86/include/asm/tdx.h      | 28 ++++++++++
> >  arch/x86/kernel/asm-offsets.c   |  9 ++++
> >  arch/x86/virt/vmx/tdx/tdxcall.S | 94 +++++++++++++++++++++++++++++++++
> >  3 files changed, 131 insertions(+)
> >  create mode 100644 arch/x86/virt/vmx/tdx/tdxcall.S
> 
> Instead of hurrying to send the set again two days after the v6 one -
> 
>   [ I frankly wonder why you're even in such a hurry - it seems people
>     believe that hammering out the patches constantly would somehow get them
>     upstreamed faster :-\ ]
> 
> - you should rather apply more diligence and take care of working in all
> the comments from last review:
> 
> https://lore.kernel.org/r/87lex9321l.ffs@tglx

My bad.

I clearly remember addressing these. But I lost it somehow, I donno.

Will send v7.1.

-- 
 Kirill A. Shutemov
