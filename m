Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB224A9D36
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 17:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376683AbiBDQzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 11:55:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:55315 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376681AbiBDQzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 11:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643993732; x=1675529732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9ZEwokSiJzGe6/7Tg/mxgO3ihrklpPiE25JjBOkRkN4=;
  b=YALf4+rICk7ARmRVPeT5PIyQ90Aaagb86gUBug5DwU+ZxOpL5/l7qL/t
   FzkzP6cnoohvno4LZvMTpA1TfE22yanU1QeBSHdBia2kbAAzcNFv/9ZqZ
   5BxLk2fPAH31QiKVOiDKCZpjagA1djf+zO6WIFCWibB+n2MngDTq/xSKc
   B6BkSVNV9rOmxtwjHocjix9gdyWRyJdjy9SXRoXjWhJ55Ca8q5ukeHuIb
   LXR4oeC/tNAPjH1Qr0COhzRdmWN34fFIIAEbsjchuHDoSbdOAD+UiDz1D
   e54E7osF3YCzdWsmAEx99flhndIPSluLxpzn17K989o1xKulihQpEfsr2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="334794771"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="334794771"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 08:55:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="498530837"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 04 Feb 2022 08:55:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E8B9A18D; Fri,  4 Feb 2022 18:55:39 +0200 (EET)
Date:   Fri, 4 Feb 2022 19:55:39 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     bp@alien8.de, aarcange@redhat.com, ak@linux.intel.com,
        dan.j.williams@intel.com, dave.hansen@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tony.luck@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, x86@kernel.org
Subject: Re: [PATCHv2.1 05/29] x86/tdx: Add HLT support for TDX guests
Message-ID: <20220204165539.oqw7bj3ri4hzjiy6@black.fi.intel.com>
References: <YfVU01dBD36H0EIv@zn.tnic>
 <20220129223021.29417-1-kirill.shutemov@linux.intel.com>
 <874k5iz3ih.ffs@tglx>
 <20220202124830.yd4vkmy56j67tyz4@black.fi.intel.com>
 <875ypxur1n.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875ypxur1n.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 06:17:08PM +0100, Thomas Gleixner wrote:
> On Wed, Feb 02 2022 at 15:48, Kirill A. Shutemov wrote:
> 
> > On Tue, Feb 01, 2022 at 10:21:58PM +0100, Thomas Gleixner wrote:
> >> On Sun, Jan 30 2022 at 01:30, Kirill A. Shutemov wrote:
> >> This really can be simplified:
> >> 
> >>         cmpl	$EXIT_REASON_SAFE_HLT, %r11d
> >>         jne	.Lnohalt
> >>         movl	$EXIT_REASON_HLT, %r11d
> >>         sti
> >> .Lnohalt:
> >> 	tdcall
> >> 
> >> and the below becomes:
> >> 
> >> static bool tdx_halt(void)
> >> {
> >> 	return !!__tdx_hypercall(EXIT_REASON_HLT, !!irqs_disabled(), 0, 0, 0, NULL);
> >> }
> >> 
> >> void __cpuidle tdx_safe_halt(void)
> >> {
> >>         if (__tdx_hypercall(EXIT_REASON_SAFE_HLT, 0, 0, 0, 0, NULL)
> >>         	WARN_ONCE(1, "HLT instruction emulation failed\n");
> >> }
> >> 
> >> Hmm?
> >
> > EXIT_REASON_* are architectural, see SDM vol 3D, appendix C. There's no
> > EXIT_REASON_SAFE_HLT.
> >
> > Do you want to define a synthetic one? Like
> >
> > #define EXIT_REASON_SAFE_HLT	0x10000
> > ?
> 
> That was my idea, yes.
> 
> > Looks dubious to me, I donno. I worry about possible conflicts with the
> > spec in the future.
> 
> The spec should have a reserved space for such things :)
> 
> But you might think about having a in/out struct similar to the module
> call or just an array of u64.
> 
> and the signature would become:
> 
> __tdx_hypercall(u64 op, u64 flags, struct inout *args)
> __tdx_hypercall(u64 op, u64 flags, u64 *args)
> 
> and have flag bits:
> 
>     HCALL_ISSUE_STI
>     HCALL_HAS_OUTPUT
> 
> Hmm?

We have two distinct cases: standard hypercalls (defined in GHCI) and KVM
hypercalls. In the first case R10 is 0 (indicating standard TDVMCALL) and
R11 defines the operation. For KVM hypercalls R10 encodes the operation
(KVM hypercalls indexed from 1) and R11 is the first argument. So we
cannot get away with simple "RDI is op" interface.

And we need to return two values: RAX indicates if TDCALL itself was
successful and R10 is result of the hypercall. So we cannot easily get
away without output struct. HCALL_HAS_OUTPUT is not needed.

I would rather keep assembly side simple: shuffle values from the struct
to registers and back. C side is resposible for making sense of the
registers.

With all this in mind the __tdx_hypercall() will boil down to

u64 __tdx_hypercall(struct tdx_hypercall_args *args, u64 flags);

with the only flag HCALL_ISSUE_STI. Is it what you want to see?

I personally don't see why flag is better than synthetic argument as we
have now.

-- 
 Kirill A. Shutemov
