Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071A54A6720
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 22:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbiBAViI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 16:38:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41944 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiBAViH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 16:38:07 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643751486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G1LxckeTVB2vMoGxab5Ja8WoF2V2W5GSADlv8IPeXW8=;
        b=YBNeovTxvzYJwo04kW/WWVu0oMQtWL5zDdHrdUnYOFxZzJ5iFs3MhHRjuxrgalf4CXlFjH
        HI0fwTiSKwv6fx1+5m/csDBENaWQfXBb4V17KQemvDAKO39mGlrJmhkvOwXrWxPNDW1KdE
        +VkUkWZnV7R6g4S/0qjvWD3wLYqQDiD13ERPbMBl1XYST+zX0kPXTVMNBC1gyQZq7Unn9M
        09VmoRxwiFI1SleTop05MwOpMR7uXcZCZ7jYIM8gDPFx7YtlRQFV3wklRakZ89pWiK8dGm
        /fLNs+9sbsV9h4CMAMh9kIG23wjRHQ0IPzwiB73NAX6zyaoDAg8NhIaj3a+clg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643751486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G1LxckeTVB2vMoGxab5Ja8WoF2V2W5GSADlv8IPeXW8=;
        b=ik5GgfEYI5Bs06dK4yNms/elzRll2T+oGl4eQYG2WtVjVWU2gDhlnFuixetmY7zX1vt3TX
        /DWoOGhTpreMelAQ==
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 06/29] x86/tdx: Add MSR support for TDX guests
In-Reply-To: <20220124150215.36893-7-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-7-kirill.shutemov@linux.intel.com>
Date:   Tue, 01 Feb 2022 22:38:05 +0100
Message-ID: <871r0mz2rm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2022 at 18:01, Kirill A. Shutemov wrote:
> +static bool tdx_read_msr(unsigned int msr, u64 *val)
> +{
> +	struct tdx_hypercall_output out;
> +
> +	/*
> +	 * Emulate the MSR read via hypercall. More info about ABI
> +	 * can be found in TDX Guest-Host-Communication Interface
> +	 * (GHCI), sec titled "TDG.VP.VMCALL<Instruction.RDMSR>".
> +	 */
> +	if (_tdx_hypercall(EXIT_REASON_MSR_READ, msr, 0, 0, 0, &out))
> +		return false;
> +
> +	*val = out.r11;
> +
> +	return true;
> +}
> +
> +static bool tdx_write_msr(unsigned int msr, unsigned int low,
> +			       unsigned int high)
> +{
> +	u64 ret;
> +
> +	/*
> +	 * Emulate the MSR write via hypercall. More info about ABI
> +	 * can be found in TDX Guest-Host-Communication Interface
> +	 * (GHCI) sec titled "TDG.VP.VMCALL<Instruction.WRMSR>".
> +	 */
> +	ret = _tdx_hypercall(EXIT_REASON_MSR_WRITE, msr, (u64)high << 32 | low,
> +			     0, 0, NULL);
> +
> +	return ret ? false : true;
> +}
> +
>  bool tdx_get_ve_info(struct ve_info *ve)
>  {
>  	struct tdx_module_output out;
> @@ -132,11 +165,22 @@ static bool tdx_virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
>  static bool tdx_virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
>  {
>  	bool ret = false;
> +	u64 val;
>  
>  	switch (ve->exit_reason) {
>  	case EXIT_REASON_HLT:
>  		ret = tdx_halt();
>  		break;
> +	case EXIT_REASON_MSR_READ:
> +		ret = tdx_read_msr(regs->cx, &val);
> +		if (ret) {
> +			regs->ax = lower_32_bits(val);
> +			regs->dx = upper_32_bits(val);
> +		}
> +		break;

Why here?

static bool tdx_read_msr(struct pt_regs *regs)
{
	struct tdx_hypercall_output out;

	/*
	 * Emulate the MSR read via hypercall. More info about ABI
	 * can be found in TDX Guest-Host-Communication Interface
	 * (GHCI), sec titled "TDG.VP.VMCALL<Instruction.RDMSR>".
	 */
	if (_tdx_hypercall(EXIT_REASON_MSR_READ, regs->cx, 0, 0, 0, &out))
		return false;

	regs->ax = lower_32_bits(out.r11);
	regs->dx = upper_32_bits(out.r11);
	return true;
}

and

static bool tdx_read_msr(struct pt_regs *regs)
{
	/*
	 * Emulate the MSR write via hypercall. More info about ABI
	 * can be found in TDX Guest-Host-Communication Interface
	 * (GHCI) sec titled "TDG.VP.VMCALL<Instruction.WRMSR>".
	 */
	return !!_tdx_hypercall(EXIT_REASON_MSR_WRITE, regs->cx,
        			(u64)regs->dx << 32 | regs->ax,
			     	0, 0, NULL);
}

Also the switch case can be simplified as the only action after 'break;'
is 'return ret':

	switch (ve->exit_reason) {
	case EXIT_REASON_HLT:
		return tdx_halt();
	case EXIT_REASON_MSR_READ:
		return tdx_read_msr(regs);
	case EXIT_REASON_MSR_WRITE:
		return tdx_write_msr(regs);
        default:
                ....

Hmm?

Thanks,

        tglx
