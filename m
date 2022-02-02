Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DF74A7103
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 13:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344204AbiBBMsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 07:48:24 -0500
Received: from mga12.intel.com ([192.55.52.136]:53562 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231931AbiBBMsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 07:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643806103; x=1675342103;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z9scS5BxylB3N87FIWShz2HnyBV68el7ZbEKipTas7k=;
  b=Sc7meuzOQpSGtB6PDk0oRaCxquSmsSrEw+aL6vCOzx5BsEn7FeXnmigY
   ilOdCKSSgNhBGCNNfazsF2aPtiyA4RzxzyycXLg69EJkNQJHcjwhYte3h
   UetVfK6EiG+9KlmT/A//v37OQSNNLrfdlhpWRKyGIFPsNA6XDITImJrwJ
   JEDlJQd0IKPlJNCopDudAFy2+7S1X5QPVI79E3pvih8KPq7qvUBeCxWfW
   vd3zEkDpz1PxzVXILfaRqEpXWDOZDMjT9+I281i6FedfRMYEl+Dbu7TG9
   Y07HCrAUyvHbK8HgLfwR2UHw7eh8CbpzA36A9l5aZ7reSmkfQW1ve0muL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="227875153"
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="227875153"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 04:48:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="523482167"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 02 Feb 2022 04:48:16 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id CC2273B7; Wed,  2 Feb 2022 14:48:30 +0200 (EET)
Date:   Wed, 2 Feb 2022 15:48:30 +0300
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
Message-ID: <20220202124830.yd4vkmy56j67tyz4@black.fi.intel.com>
References: <YfVU01dBD36H0EIv@zn.tnic>
 <20220129223021.29417-1-kirill.shutemov@linux.intel.com>
 <874k5iz3ih.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874k5iz3ih.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 10:21:58PM +0100, Thomas Gleixner wrote:
> On Sun, Jan 30 2022 at 01:30, Kirill A. Shutemov wrote:
> > +/*
> > + * Used in __tdx_hypercall() to determine whether to enable interrupts
> > + * before issuing TDCALL for the EXIT_REASON_HLT case.
> > + */
> > +#define ENABLE_IRQS_BEFORE_HLT 0x01
> > +
> >  /*
> >   * __tdx_module_call()  - Used by TDX guests to request services from
> >   * the TDX module (does not include VMM services).
> > @@ -230,6 +237,30 @@ SYM_FUNC_START(__tdx_hypercall)
> >  
> >  	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
> >  
> > +	/*
> > +	 * For the idle loop STI needs to be called directly before
> > +	 * the TDCALL that enters idle (EXIT_REASON_HLT case). STI
> > +	 * instruction enables interrupts only one instruction later.
> > +	 * If there is a window between STI and the instruction that
> > +	 * emulates the HALT state, there is a chance for interrupts to
> > +	 * happen in this window, which can delay the HLT operation
> > +	 * indefinitely. Since this is the not the desired result,
> > +	 * conditionally call STI before TDCALL.
> > +	 *
> > +	 * Since STI instruction is only required for the idle case
> > +	 * (a special case of EXIT_REASON_HLT), use the r15 register
> > +	 * value to identify it. Since the R15 register is not used
> > +	 * by the VMM as per EXIT_REASON_HLT ABI, re-use it in
> > +	 * software to identify the STI case.
> > +	 */
> > +	cmpl $EXIT_REASON_HLT, %r11d
> > +	jne .Lskip_sti
> > +	cmpl $ENABLE_IRQS_BEFORE_HLT, %r15d
> > +	jne .Lskip_sti
> > +	/* Set R15 register to 0, it is unused in EXIT_REASON_HLT case */
> > +	xor %r15, %r15
> > +	sti
> > +.Lskip_sti:
> >  	tdcall
> 
> This really can be simplified:
> 
>         cmpl	$EXIT_REASON_SAFE_HLT, %r11d
>         jne	.Lnohalt
>         movl	$EXIT_REASON_HLT, %r11d
>         sti
> .Lnohalt:
> 	tdcall
> 
> and the below becomes:
> 
> static bool tdx_halt(void)
> {
> 	return !!__tdx_hypercall(EXIT_REASON_HLT, !!irqs_disabled(), 0, 0, 0, NULL);
> }
> 
> void __cpuidle tdx_safe_halt(void)
> {
>         if (__tdx_hypercall(EXIT_REASON_SAFE_HLT, 0, 0, 0, 0, NULL)
>         	WARN_ONCE(1, "HLT instruction emulation failed\n");
> }
> 
> Hmm?

EXIT_REASON_* are architectural, see SDM vol 3D, appendix C. There's no
EXIT_REASON_SAFE_HLT.

Do you want to define a synthetic one? Like

#define EXIT_REASON_SAFE_HLT	0x10000

?

Looks dubious to me, I donno. I worry about possible conflicts with the
spec in the future.

-- 
 Kirill A. Shutemov
