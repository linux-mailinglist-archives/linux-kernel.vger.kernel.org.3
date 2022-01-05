Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D9E485135
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbiAEKiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbiAEKiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:38:10 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588DDC061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 02:38:10 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C5B1A1EC03AD;
        Wed,  5 Jan 2022 11:37:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1641379076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Vff7iMTLGsselRP/thbSRHLq1b+srdSUf9Q+TkKzZJw=;
        b=p6tuX195O3Ly0UMB/4KN4hb1PYtbrrgrU0g9cj/TKRZQN5NJZXc1pSJHuJ/UIx7sqZDrQF
        63PTLHaWOlDxIrQvHbDipAMWWS3hrgqRavOjR8EakCBoAlbmzDaj6QljV8byEutjO+VwuM
        jpoXhNqKE7ebs5h6WFLDp+iVzXK210A=
Date:   Wed, 5 Jan 2022 11:37:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/26] x86/tdx: Handle in-kernel MMIO
Message-ID: <YdV1BpMiAUGrwASv@zn.tnic>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-9-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211214150304.62613-9-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 06:02:46PM +0300, Kirill A. Shutemov wrote:
> In non-TDX VMs, MMIO is implemented by providing the guest a mapping
> which will cause a VMEXIT on access and then the VMM emulating the
> instruction that caused the VMEXIT. That's not possible in TDX guests
> because it requires exposing guest register and memory state to
> potentially malicious VMM.

What does that mean exactly? Aren't TDX registers encrypted just like
SEV-ES ones? If so, they can't really be exposed...

> In TDX the MMIO regions are instead configured to trigger a #VE
> exception in the guest. The guest #VE handler then emulates the MMIO
> instruction inside the guest and converts them into a controlled

s/them/it/

> hypercall to the host.
> 
> MMIO addresses can be used with any CPU instruction that accesses the

s/the //

> memory. This patch, however, covers only MMIO accesses done via io.h

"Here are covered only the MMIO accesses ... "

> helpers, such as 'readl()' or 'writeq()'.
> 
> MMIO access via other means (like structure overlays) may result in
> MMIO_DECODE_FAILED and an oops.

Why? They won't cause a EXIT_REASON_EPT_VIOLATION #VE or?

> AMD SEV has the same limitations to MMIO handling.

See, the other guy is no better here. :-P

> === Potential alternative approaches ===
> 
> == Paravirtualizing all MMIO ==
> 
> An alternative to letting MMIO induce a #VE exception is to avoid
> the #VE in the first place. Similar to the port I/O case, it is
> theoretically possible to paravirtualize MMIO accesses.
> 
> Like the exception-based approach offered by this patch, a fully

"... offered here, a fully ..."

> paravirtualized approach would be limited to MMIO users that leverage
> common infrastructure like the io.h macros.
> 
> However, any paravirtual approach would be patching approximately
> 120k call sites. With a conservative overhead estimation of 5 bytes per
> call site (CALL instruction), it leads to bloating code by 600k.
> 
> Many drivers will never be used in the TDX environment and the bloat
> cannot be justified.

I like the conservative approach here.
 
> == Patching TDX drivers ==
> 
> Rather than touching the entire kernel, it might also be possible to
> just go after drivers that use MMIO in TDX guests.  Right now, that's
> limited only to virtio and some x86-specific drivers.
> 
> All virtio MMIO appears to be done through a single function, which
> makes virtio eminently easy to patch. Future patches will implement this
> idea,

"This will be implemented in the future, ... "

> +static int tdx_handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> +{
> +	char buffer[MAX_INSN_SIZE];
> +	unsigned long *reg, val = 0;
> +	struct insn insn = {};
> +	enum mmio_type mmio;
> +	int size;
> +	u8 sign_byte;
> +	bool err;
> +
> +	if (copy_from_kernel_nofault(buffer, (void *)regs->ip, MAX_INSN_SIZE))
> +		return -EFAULT;
> +
> +	insn_init(&insn, buffer, MAX_INSN_SIZE, 1);
> +	insn_get_length(&insn);

There is insn_decode() - see how it is used and use it here pls.

> +	case MMIO_READ_SIGN_EXTEND:
> +		err = tdx_mmio_read(size, ve->gpa, &val);
> +		if (err)
> +			break;
> +
> +		if (size == 1)
> +			sign_byte = (val & 0x80) ? 0xff : 0x00;
> +		else
> +			sign_byte = (val & 0x8000) ? 0xff : 0x00;
> +
> +		/* Sign extend based on operand size */
> +		memset(reg, sign_byte, insn.opnd_bytes);
> +		memcpy(reg, &val, size);
> +		break;

You can simplify this a bit:

        case MMIO_READ_SIGN_EXTEND: {
                u8 sign_byte = 0, msb = 7;

                err = tdx_mmio_read(size, ve->gpa, &val);
                if (err)
                        break;

                if (size > 1)
                        msb = 15;

                if (val & BIT(msb))
                        sign_byte = -1;

                /* Sign extend based on operand size */
                memset(reg, sign_byte, insn.opnd_bytes);
                memcpy(reg, &val, size);
                break;
        }



> +	case MMIO_MOVS:
> +	case MMIO_DECODE_FAILED:
> +		return -EFAULT;
> +	}
> +
> +	if (err)
> +		return -EFAULT;


<---- newline here.

> +	return insn.length;
> +}
> +

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
