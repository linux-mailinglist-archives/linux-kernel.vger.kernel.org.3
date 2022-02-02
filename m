Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890234A6BE7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 07:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245024AbiBBGxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 01:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244790AbiBBGwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 01:52:39 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1C2C061762
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 22:22:23 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D381A1EC04D3;
        Wed,  2 Feb 2022 07:22:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643782938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+yWMCdKjUAP7NDfIK/YUGlNwkHassb0AYsOAb+HOldU=;
        b=ZWI7UGbFaRsqZ3Kb58DFXl1OEXLWUDPJxuWZMdrnDCQhpa+bjCOyjgKW1WbtZz/MHYILic
        IhVekRG7D0/Md9nmwkLEu6er6LagFIrqDZbsCWs5RWjNBN531JomWRYGi5Stf6HzxmNh5/
        0n0AUGxsgL4ZI1CICQcPxS2wC6qEv/A=
Date:   Wed, 2 Feb 2022 07:22:13 +0100
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
Subject: Re: [PATCHv2 13/29] x86/tdx: Add port I/O emulation
Message-ID: <YfojFe6Rh0ETLc28@zn.tnic>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-14-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220124150215.36893-14-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 06:01:59PM +0300, Kirill A. Shutemov wrote:
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index 8e630eeb765d..e73af22a4c11 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -13,6 +13,12 @@
>  /* TDX module Call Leaf IDs */
>  #define TDX_GET_VEINFO			3
>  
> +/* See Exit Qualification for I/O Instructions in VMX documentation */
> +#define VE_IS_IO_IN(exit_qual)		(((exit_qual) & 8) ? 1 : 0)
> +#define VE_GET_IO_SIZE(exit_qual)	(((exit_qual) & 7) + 1)
> +#define VE_GET_PORT_NUM(exit_qual)	((exit_qual) >> 16)
> +#define VE_IS_IO_STRING(exit_qual)	((exit_qual) & 16 ? 1 : 0)

Use BIT() and masks here. For example:

#define VE_IS_IO_STRING(e)	((e) & BIT(4))

You don't need the ternary ?: either as you're using them all in a
boolean context.

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

"section"

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

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
