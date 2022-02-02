Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134704A713D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344173AbiBBNGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:06:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:37984 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbiBBNGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:06:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643807169; x=1675343169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=68aFLvgc9OSad5z3Pdpw/01FyNt3GoVy64K5S+1Fk68=;
  b=AING72eODD4EiHKY1zhViddoXFXB6I61vxn5DOeZcc7IiNNzeY9DPEke
   K54AW4PanJA3WjqbfArDbs1IDi846jIguZjcMWo74Cb4DYop89tqVAFhs
   f6Sm9yqOmFnWucpks3eNwpH4qPvi+rhVKBZiqwReRvuCAgFGtqIuqLlMU
   dwHwQ/mdePMkD1COH10dqgU91BnM5itiF23GSo/+3dzI26yL3rvEB6eh0
   0H2j+32hVSH+zCkRlxud6wa7vFKwCLBGqOGDPRsVo3Y0QP+nYVS56LqGC
   FZQPbeh/Bl8YL5aYipWm7yNzC0O9Oid/IoS3ue8Y7JzrHSdj4Gl399HaX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="248129907"
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="248129907"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 05:06:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="480097987"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 02 Feb 2022 05:06:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id C01E03B7; Wed,  2 Feb 2022 15:06:16 +0200 (EET)
Date:   Wed, 2 Feb 2022 16:06:16 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 06/29] x86/tdx: Add MSR support for TDX guests
Message-ID: <20220202130616.xknv5y5s4xavuzmi@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-7-kirill.shutemov@linux.intel.com>
 <871r0mz2rm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871r0mz2rm.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 10:38:05PM +0100, Thomas Gleixner wrote:
> On Mon, Jan 24 2022 at 18:01, Kirill A. Shutemov wrote:
> > +static bool tdx_read_msr(unsigned int msr, u64 *val)
> > +{
> > +	struct tdx_hypercall_output out;
> > +
> > +	/*
> > +	 * Emulate the MSR read via hypercall. More info about ABI
> > +	 * can be found in TDX Guest-Host-Communication Interface
> > +	 * (GHCI), sec titled "TDG.VP.VMCALL<Instruction.RDMSR>".
> > +	 */
> > +	if (_tdx_hypercall(EXIT_REASON_MSR_READ, msr, 0, 0, 0, &out))
> > +		return false;
> > +
> > +	*val = out.r11;
> > +
> > +	return true;
> > +}
> > +
> > +static bool tdx_write_msr(unsigned int msr, unsigned int low,
> > +			       unsigned int high)
> > +{
> > +	u64 ret;
> > +
> > +	/*
> > +	 * Emulate the MSR write via hypercall. More info about ABI
> > +	 * can be found in TDX Guest-Host-Communication Interface
> > +	 * (GHCI) sec titled "TDG.VP.VMCALL<Instruction.WRMSR>".
> > +	 */
> > +	ret = _tdx_hypercall(EXIT_REASON_MSR_WRITE, msr, (u64)high << 32 | low,
> > +			     0, 0, NULL);
> > +
> > +	return ret ? false : true;
> > +}
> > +
> >  bool tdx_get_ve_info(struct ve_info *ve)
> >  {
> >  	struct tdx_module_output out;
> > @@ -132,11 +165,22 @@ static bool tdx_virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
> >  static bool tdx_virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
> >  {
> >  	bool ret = false;
> > +	u64 val;
> >  
> >  	switch (ve->exit_reason) {
> >  	case EXIT_REASON_HLT:
> >  		ret = tdx_halt();
> >  		break;
> > +	case EXIT_REASON_MSR_READ:
> > +		ret = tdx_read_msr(regs->cx, &val);
> > +		if (ret) {
> > +			regs->ax = lower_32_bits(val);
> > +			regs->dx = upper_32_bits(val);
> > +		}
> > +		break;
> 
> Why here?
> 
> static bool tdx_read_msr(struct pt_regs *regs)
> {
> 	struct tdx_hypercall_output out;
> 
> 	/*
> 	 * Emulate the MSR read via hypercall. More info about ABI
> 	 * can be found in TDX Guest-Host-Communication Interface
> 	 * (GHCI), sec titled "TDG.VP.VMCALL<Instruction.RDMSR>".
> 	 */
> 	if (_tdx_hypercall(EXIT_REASON_MSR_READ, regs->cx, 0, 0, 0, &out))
> 		return false;
> 
> 	regs->ax = lower_32_bits(out.r11);
> 	regs->dx = upper_32_bits(out.r11);
> 	return true;
> }
> 
> and
> 
> static bool tdx_read_msr(struct pt_regs *regs)
> {
> 	/*
> 	 * Emulate the MSR write via hypercall. More info about ABI
> 	 * can be found in TDX Guest-Host-Communication Interface
> 	 * (GHCI) sec titled "TDG.VP.VMCALL<Instruction.WRMSR>".
> 	 */
> 	return !!_tdx_hypercall(EXIT_REASON_MSR_WRITE, regs->cx,
>         			(u64)regs->dx << 32 | regs->ax,
> 			     	0, 0, NULL);
> }
> 
> Also the switch case can be simplified as the only action after 'break;'
> is 'return ret':
> 
> 	switch (ve->exit_reason) {
> 	case EXIT_REASON_HLT:
> 		return tdx_halt();
> 	case EXIT_REASON_MSR_READ:
> 		return tdx_read_msr(regs);
> 	case EXIT_REASON_MSR_WRITE:
> 		return tdx_write_msr(regs);
>         default:
>                 ....
> 
> Hmm?

No problem with this approach on read side.

On the write side there's one important optimization (outside of the
initial TDX enabling):

https://github.com/intel/tdx/commit/2cea8becaa5a287c93266c01fc7f2a4ed53c509d

It will require rework, maybe use separate __tdx_hypercall() for the
paravirt call implementation.

-- 
 Kirill A. Shutemov
