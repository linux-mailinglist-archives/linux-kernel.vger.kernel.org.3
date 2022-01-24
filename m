Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C8F49A06D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1843978AbiAXXHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:07:15 -0500
Received: from mga01.intel.com ([192.55.52.88]:43067 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1584285AbiAXWUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643062836; x=1674598836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KTx3QBS/bCeJLJyH0VTSsPA6HKtWhrWvddCv03rGT8E=;
  b=Oo2+BdFCv2wbmzsE8EfQXdAbPE4ExNChj0VsiYrEZiOeVRG3XqOP54ni
   zDHFJpchv4GZngv4VfUXbgiqwk9kaCU67/zhjYzrblnDjaOGKgDKRJCSq
   HrS+FLWyz4GQiO/Tzik6n5kZNX3C96g9Fs8dufty2oVehIQRLVych9xyT
   LK5hvP5GHn9dpvh+8OFBHUTIgnOq8AUrlNPhoXBjAfHGxatofDlQhSQFN
   5vNzO9fZH+MfcM89D5veGB4XI/lyvxnTqMs55Vls/az9GojXqML9D9vUh
   +cQfKtBtJ8clVWvKeJP6pJaITD/mQVapwbHFSSOVCHG0kE1rh/0p+j5X0
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="270600511"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="270600511"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 14:08:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="520121337"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 24 Jan 2022 14:08:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id BE110178; Tue, 25 Jan 2022 00:08:21 +0200 (EET)
Date:   Tue, 25 Jan 2022 01:08:21 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, knsathya@kernel.org, pbonzini@redhat.com,
        sdeep@vmware.com, seanjc@google.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 08/29] x86/tdx: Handle in-kernel MMIO
Message-ID: <20220124220821.4bgf6i3qfhj6mrht@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-9-kirill.shutemov@linux.intel.com>
 <20220124193008.gfaq5ppegx5nfomd@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124193008.gfaq5ppegx5nfomd@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 11:30:08AM -0800, Josh Poimboeuf wrote:
> On Mon, Jan 24, 2022 at 06:01:54PM +0300, Kirill A. Shutemov wrote:
> > +static bool tdx_mmio(int size, bool write, unsigned long addr,
> > +		     unsigned long *val)
> > +{
> > +	struct tdx_hypercall_output out;
> > +	u64 err;
> > +
> > +	err = _tdx_hypercall(EXIT_REASON_EPT_VIOLATION, size, write,
> > +			     addr, *val, &out);
> > +	if (err)
> > +		return true;
> > +
> > +	*val = out.r11;
> > +	return false;
> > +}
> > +
> > +static bool tdx_mmio_read(int size, unsigned long addr, unsigned long *val)
> > +{
> > +	return tdx_mmio(size, false, addr, val);
> > +}
> > +
> > +static bool tdx_mmio_write(int size, unsigned long addr, unsigned long *val)
> > +{
> > +	return tdx_mmio(size, true, addr, val);
> > +}
> > +
> > +static int tdx_handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> > +{
> > +	char buffer[MAX_INSN_SIZE];
> > +	unsigned long *reg, val = 0;
> > +	struct insn insn = {};
> > +	enum mmio_type mmio;
> > +	int size;
> > +	bool err;
> > +
> > +	if (copy_from_kernel_nofault(buffer, (void *)regs->ip, MAX_INSN_SIZE))
> > +		return -EFAULT;
> > +
> > +	if (insn_decode(&insn, buffer, MAX_INSN_SIZE, INSN_MODE_64))
> > +		return -EFAULT;
> > +
> > +	mmio = insn_decode_mmio(&insn, &size);
> > +	if (WARN_ON_ONCE(mmio == MMIO_DECODE_FAILED))
> > +		return -EFAULT;
> > +
> > +	if (mmio != MMIO_WRITE_IMM && mmio != MMIO_MOVS) {
> > +		reg = insn_get_modrm_reg_ptr(&insn, regs);
> > +		if (!reg)
> > +			return -EFAULT;
> > +	}
> > +
> > +	switch (mmio) {
> > +	case MMIO_WRITE:
> > +		memcpy(&val, reg, size);
> > +		err = tdx_mmio_write(size, ve->gpa, &val);
> > +		break;
> 
> The return code conventions are still all mismatched and confusing:
> 
> - Most tdx_handle_*() handlers return bool (success == true)
> 
> - tdx_handle_mmio() returns int (success > 0)

Right, all tdx_handle_* are consistent: success > 0.

> - tdx_mmio*() helpers return bool (success == false)

And what is wrong with that? Why do you mix functions that called in
different contexts and expect them to have matching semantics?

> I still don't see any benefit in arbitrarily mixing three different
> return conventions, none of which matches the typical kernel style for
> returning errors, unless the goal is to confuse the reader and invite
> bugs.

Okay, we have an disagreement here.

I picked a way to communicate function result as I see best fits the
situation. It is a judgement call.

I will adjust code if maintainers see it differently from me. But until
then I don't see anything wrong here.

> There is precedent in traps.c for some handle_*() functions to return
> bool (success == true), so if the goal is to align with that
> semi-convention, that's ok.  But at the very least, please do it
> consistently:
> 
>   - change tdx_mmio*() to return true on success;
> 
>   - change tdx_handle_mmio() to return bool, with 'len' passed as an
>     argument.

Hard no.

Returning a value via passed argument is the last resort for cases when
more than one value has to be returned. In this case the function is
perfectly capable to communicate result via single return value.

I don't see a reason to complicate the code to satisfy some "typical
kernel style".

> Or, even better, just change them all to return 0 on success like 99+%
> of error-returning kernel functions.

Citation needed. 99+% looks like an overstatement to me.

-- 
 Kirill A. Shutemov
