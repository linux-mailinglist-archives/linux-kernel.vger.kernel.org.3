Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B934A6854
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 00:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242625AbiBAXBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 18:01:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42574 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242497AbiBAXBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 18:01:25 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643756484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=luGILULRWQE8g3VRzF/kDww6TLG+nwgjqQ72esFquiE=;
        b=YurbniWZkoLt+4pSRrHz+14sfo1+5VU9RX/OjGpugpXHNolrL4MkhV/t2TTBkzsIki08P6
        L3yAyIof2gL7lU72ltVYpNbpIy6VSZ7f/KXGkMfpnIJtfda9KM7EzRvQiAfe+9fgaQVWoX
        n02AGg6fptoSSb48zVcFPJBAvQmyUWYuxGJFit0pfIjaO3Qaj0QIJ0Ni2AlTGMcZd8y/TL
        u4P1kMM8EtcOipUE9OvjEjpSHNLaVzbE4HcpUoH0qD4+4y6ji/8Jl3lKTg/j4FR/2FM8Ai
        XSbdpCAnzyNqGaOoDo+jIQ5n66nTZZHBe1vp7JJ0z4g7d9ZzaeR4g38g6A9KAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643756484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=luGILULRWQE8g3VRzF/kDww6TLG+nwgjqQ72esFquiE=;
        b=QIvhpZDAQrHMo+SDp29ScoE+LK2lcjvI7OsIHzsA80ZLzAdjCLqSxI+EjAwoDThY5pSWsf
        dzG8Ye9LKmgWOFCQ==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 13/29] x86/tdx: Add port I/O emulation
In-Reply-To: <20220124150215.36893-14-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-14-kirill.shutemov@linux.intel.com>
Date:   Wed, 02 Feb 2022 00:01:23 +0100
Message-ID: <878ruuxkcc.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2022 at 18:01, Kirill A. Shutemov wrote:
>  static bool intel_cc_platform_has(enum cc_attr attr)
>  {
> +	if (attr == CC_ATTR_GUEST_UNROLL_STRING_IO)
> +		return true;
> +

switch (attr) perhaps as there are more coming, right?

>  	return false;
>  }

> +/*
> + * Emulate I/O using hypercall.
> + *
> + * Assumes the IO instruction was using ax, which is enforced
> + * by the standard io.h macros.
> + *
> + * Return True on success or False on failure.
> + */
> +static bool tdx_handle_io(struct pt_regs *regs, u32 exit_qual)
> +{
> +	struct tdx_hypercall_output out;
> +	int size, port, ret;
> +	u64 mask;
> +	bool in;
> +
> +	if (VE_IS_IO_STRING(exit_qual))
> +		return false;
> +
> +	in   = VE_IS_IO_IN(exit_qual);
> +	size = VE_GET_IO_SIZE(exit_qual);
> +	port = VE_GET_PORT_NUM(exit_qual);
> +	mask = GENMASK(BITS_PER_BYTE * size, 0);
> +
> +	/*
> +	 * Emulate the I/O read/write via hypercall. More info about
> +	 * ABI can be found in TDX Guest-Host-Communication Interface
> +	 * (GHCI) sec titled "TDG.VP.VMCALL<Instruction.IO>".
> +	 */
> +	ret = _tdx_hypercall(EXIT_REASON_IO_INSTRUCTION, size, !in, port,
> +			     in ? 0 : regs->ax, &out);
> +	if (!in)
> +		return !ret;
> +
> +	regs->ax &= ~mask;
> +	regs->ax |= ret ? UINT_MAX : out.r11 & mask;
> +
> +	return !ret;
> +}
> +
>  bool tdx_get_ve_info(struct ve_info *ve)
>  {
>  	struct tdx_module_output out;
> @@ -333,6 +378,9 @@ static bool tdx_virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
>  		if (!ret)
>  			pr_warn_once("MMIO failed\n");
>  		break;
> +	case EXIT_REASON_IO_INSTRUCTION:
> +		ret = tdx_handle_io(regs, ve->exit_qual);

                return ...

Other than that LGTM.

Thanks,

        tglx
