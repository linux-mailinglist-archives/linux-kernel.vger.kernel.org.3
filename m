Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D12A4A6802
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 23:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241095AbiBAWak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 17:30:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42262 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239690AbiBAWai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:30:38 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643754637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GEXH3veYOIscC4Uo0x90ee2dJ30rhMyMmH2TzdhxjAU=;
        b=N1lTGmY3QLRvHiv2mkxpQYL/FbuWwwdLnVWskFodAh03xe3h+EELok4AT+aM0/5KhPEroo
        mkYRH3CTcDyFPIeeQL/9WQF6AwU8EEu+K4mFhF33PYiEzP4DoQmIrxyHTl/i1eWckC03G0
        LTmXjNiwIeNGrSgzj1XVZ2k7isQlbJRSQP0b4ywGFgyQ1l/jS5D62aW9Q0PvO1EQqzJS0n
        MYH6Drgi43TjUl+HON7692U5SP6hTT59IU8e8c+0yoGRDYYUjrm21BAZaxAO3WvweE0YWt
        Y7MO9z7a5DCbMWx4iKFuwJcvLDwfNhXOkMeMRNLUntJQnHIoNNgZXxi7C2BDjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643754637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GEXH3veYOIscC4Uo0x90ee2dJ30rhMyMmH2TzdhxjAU=;
        b=91CqsQJaUu80h1rMuT/FIMUIR/cqN1iEjJpj+us23JHZ+XgOVTgkSXNmonkGHWqbrGH8gh
        lbuB/+QuCKUy8zCA==
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
Subject: Re: [PATCHv2 08/29] x86/tdx: Handle in-kernel MMIO
In-Reply-To: <20220124150215.36893-9-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-9-kirill.shutemov@linux.intel.com>
Date:   Tue, 01 Feb 2022 23:30:36 +0100
Message-ID: <87tudixlrn.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2022 at 18:01, Kirill A. Shutemov wrote:
>  
> +static bool tdx_mmio(int size, bool write, unsigned long addr,
> +		     unsigned long *val)
> +{
> +	struct tdx_hypercall_output out;
> +	u64 err;
> +
> +	err = _tdx_hypercall(EXIT_REASON_EPT_VIOLATION, size, write,
> +			     addr, *val, &out);

What's the purpose of storing *val as an argument for reads?

> +	if (err)
> +		return true;
> +
> +	*val = out.r11;
> +	return false;

Why is this writing back unconditionally for writes?

> +
>  bool tdx_get_ve_info(struct ve_info *ve)
>  {
>  	struct tdx_module_output out;
> @@ -219,6 +327,12 @@ static bool tdx_virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
>  	case EXIT_REASON_CPUID:
>  		ret = tdx_handle_cpuid(regs);
>  		break;
> +	case EXIT_REASON_EPT_VIOLATION:
> +		ve->instr_len = tdx_handle_mmio(regs, ve);
> +		ret = ve->instr_len > 0;

I agree with Josh here. This is just wrong. Why returning the instr_len
as an error/success indicator? That's just a horrible idea simply
because the "error value" which is <= 0 is converted to a boolean return
value.

So what's wrong with doing the obvious here

	case EXIT_REASON_EPT_VIOLATION:
		return tdx_handle_mmio(regs, ve);

and have the handler function set ve->instr_length?

Also instead of having this not really helpful tdx_mmio() helper just
implement read and write seperately:

static bool tdx_mmio_read(int size, unsigned long addr, unsigned long *val)
{
	struct tdx_hypercall_output out;

	if (_tdx_hypercall(EXIT_REASON_EPT_VIOLATION, size, EPT_READ,
	   		   addr, 0, &out)
		return false;

	*val = out.r11;
	return true;
}

static bool tdx_mmio_write(int size, unsigned long addr, unsigned long val)
{
	return !!_tdx_hypercall(EXIT_REASON_EPT_VIOLATION, size, EPT_WRITE,
	   		   addr, val, NULL);
}

The return value is consistent with all the other handling functions
here, they return a boolean True for success. Which makes the main
handler consistent with the rest.

static bool tdx_handle_mmio(struct pt_regs *regs, struct ve_info *ve)
{
	char buffer[MAX_INSN_SIZE];
	unsigned long *reg, val;
	struct insn insn = {};
	int size, extend_size;
	enum mmio_type mmio;
        u8 extend_val = 0;
	bool ret;

	if (copy_from_kernel_nofault(buffer, (void *)regs->ip, MAX_INSN_SIZE))
		return false;

	if (insn_decode(&insn, buffer, MAX_INSN_SIZE, INSN_MODE_64))
		return false;

	mmio = insn_decode_mmio(&insn, &size);
	if (WARN_ON_ONCE(mmio == MMIO_DECODE_FAILED))
		return false;

	if (mmio != MMIO_WRITE_IMM && mmio != MMIO_MOVS) {
		reg = insn_get_modrm_reg_ptr(&insn, regs);
		if (!reg)
			return false;
	}

        ve->instr_length = insn.length;

	switch (mmio) {
	case MMIO_WRITE:
		memcpy(&val, reg, size);
                return tdx_mmio_write(size, ve->gpa, val);
	case MMIO_WRITE_IMM:
		val = insn.immediate.value;
                return tdx_mmio_write(size, ve->gpa, val);
	case MMIO_READ:
	case MMIO_READ_ZERO_EXTEND:
	case MMIO_READ_SIGN_EXTEND:
        	break;
	case MMIO_MOVS:
	case MMIO_DECODE_FAILED:
		return false;
	}

        /* Handle reads */
	if (!tdx_mmio_read(size, ve->gpa, &val))
		return false;

	switch (mmio) {
	case MMIO_READ:
		/* Zero-extend for 32-bit operation */
		extend_size = size == 4 ? sizeof(*reg) : 0;
                break;
	case MMIO_READ_ZERO_EXTEND:
		/* Zero extend based on operand size */
		extend_size = insn.opnd_bytes;
                break;
	case MMIO_READ_SIGN_EXTEND:
		/* Sign extend based on operand size */
		extend_size = insn.opnd_bytes;
                if (size == 1 && val & BIT(7))
                	extend_val = 0xFF;
                else if (size > 1 && val & BIT(15))
                	extend_val = 0xFF;
		break;
	default:
        	BUG();
	}

        if (extend_size)
		memset(reg, extend_val, extend_size);
        memcpy(reg, &val, size);
	return true;
}

Hmm?

Thanks,

        tglx
