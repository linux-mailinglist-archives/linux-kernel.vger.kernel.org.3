Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361434A66F1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 22:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiBAVWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 16:22:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41824 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiBAVWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 16:22:00 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643750518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lNXG9W7I6YvBwzpCdnjtr2EeRp7QC3L4xDYrni7x0Uo=;
        b=GPEQo+hBXmJ8nUzrc6LZ8SjS0yuyYbpKdV2xsCPFI4V5zSRidrR+GvAcZ5qWV8ezlyeNrW
        nVS3/vJBl7M6YmdjV9jUUS2bo+miqWcTV3zklNF+qWU/+kFISYgCtXu7rmAUlX5oA3DBUb
        gvfbIh/hUz6Aj0KTDXDXqhMswuDkjxD9ZeSojh7SBkCZ4LJUYrDVXlj/9Zr7vShJxsoYcf
        q/+eHbEFlCh7BVbSZzjGTq46dyt3pELFdpf8sj7bKpjKbcYBXmUMf87QNuRVs2QLTVAKXR
        UtxtE9CMZIBCKBW0IhQuC14ZX3CK0Y4eVEx7x9yYcxhzW6Pst6bbujhNcSF1cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643750518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lNXG9W7I6YvBwzpCdnjtr2EeRp7QC3L4xDYrni7x0Uo=;
        b=lPOdzGvbufPq+yLw0413wLB2JGnex0eREQ5ZwJlzrDK8cIrL9hwcj0aA90/C9yoC884zIm
        OzWceqXEvBGgcUAw==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        bp@alien8.de
Cc:     aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, david@redhat.com, hpa@zytor.com,
        jgross@suse.com, jmattson@google.com, joro@8bytes.org,
        jpoimboe@redhat.com, kirill.shutemov@linux.intel.com,
        knsathya@kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tony.luck@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, x86@kernel.org
Subject: Re: [PATCHv2.1 05/29] x86/tdx: Add HLT support for TDX guests
In-Reply-To: <20220129223021.29417-1-kirill.shutemov@linux.intel.com>
References: <YfVU01dBD36H0EIv@zn.tnic>
 <20220129223021.29417-1-kirill.shutemov@linux.intel.com>
Date:   Tue, 01 Feb 2022 22:21:58 +0100
Message-ID: <874k5iz3ih.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30 2022 at 01:30, Kirill A. Shutemov wrote:
> +/*
> + * Used in __tdx_hypercall() to determine whether to enable interrupts
> + * before issuing TDCALL for the EXIT_REASON_HLT case.
> + */
> +#define ENABLE_IRQS_BEFORE_HLT 0x01
> +
>  /*
>   * __tdx_module_call()  - Used by TDX guests to request services from
>   * the TDX module (does not include VMM services).
> @@ -230,6 +237,30 @@ SYM_FUNC_START(__tdx_hypercall)
>  
>  	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
>  
> +	/*
> +	 * For the idle loop STI needs to be called directly before
> +	 * the TDCALL that enters idle (EXIT_REASON_HLT case). STI
> +	 * instruction enables interrupts only one instruction later.
> +	 * If there is a window between STI and the instruction that
> +	 * emulates the HALT state, there is a chance for interrupts to
> +	 * happen in this window, which can delay the HLT operation
> +	 * indefinitely. Since this is the not the desired result,
> +	 * conditionally call STI before TDCALL.
> +	 *
> +	 * Since STI instruction is only required for the idle case
> +	 * (a special case of EXIT_REASON_HLT), use the r15 register
> +	 * value to identify it. Since the R15 register is not used
> +	 * by the VMM as per EXIT_REASON_HLT ABI, re-use it in
> +	 * software to identify the STI case.
> +	 */
> +	cmpl $EXIT_REASON_HLT, %r11d
> +	jne .Lskip_sti
> +	cmpl $ENABLE_IRQS_BEFORE_HLT, %r15d
> +	jne .Lskip_sti
> +	/* Set R15 register to 0, it is unused in EXIT_REASON_HLT case */
> +	xor %r15, %r15
> +	sti
> +.Lskip_sti:
>  	tdcall

This really can be simplified:

        cmpl	$EXIT_REASON_SAFE_HLT, %r11d
        jne	.Lnohalt
        movl	$EXIT_REASON_HLT, %r11d
        sti
.Lnohalt:
	tdcall

and the below becomes:

static bool tdx_halt(void)
{
	return !!__tdx_hypercall(EXIT_REASON_HLT, !!irqs_disabled(), 0, 0, 0, NULL);
}

void __cpuidle tdx_safe_halt(void)
{
        if (__tdx_hypercall(EXIT_REASON_SAFE_HLT, 0, 0, 0, 0, NULL)
        	WARN_ONCE(1, "HLT instruction emulation failed\n");
}

Hmm?

Thanks,

        tglx
