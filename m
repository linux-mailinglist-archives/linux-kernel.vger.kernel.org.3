Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9F74A6FEF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbiBBL11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbiBBL1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:27:25 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CE4C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 03:27:25 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C23C1EC0513;
        Wed,  2 Feb 2022 12:27:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643801239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6U0VnmNfGDUReCoshGyJhk0zAJfFhYADT+EeJhXO21s=;
        b=rJwpIZCtK06pLBa7yV8YFPpJNZ41vZkAFYf2zIpkCOWoV0PXia5fbYcJo56kbfEDUi1h/W
        4u8oFtpCuE3wScUH54AQBsAc3iArAn2tqNudTx3iUTyw4pWT+r5jZqpEZ4Vyw2FYfKlM9D
        Y33Twp5PfhNo4FuHRJTZB1NtE0vRjuA=
Date:   Wed, 2 Feb 2022 12:27:15 +0100
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
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCHv2 16/29] x86/boot: Add a trampoline for booting APs via
 firmware handoff
Message-ID: <Yfpqk0amEbcyte+w@zn.tnic>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-17-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220124150215.36893-17-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 06:02:02PM +0300, Kirill A. Shutemov wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Historically, x86 platforms have booted secondary processors (APs)
> using INIT followed by the start up IPI (SIPI) messages. In regular
> VMs, this boot sequence is supported by the VMM emulation. But such a
> wakeup model is fatal for secure VMs like TDX in which VMM is an
> untrusted entity. To address this issue, a new wakeup model was added
> in ACPI v6.4, in which firmware (like TDX virtual BIOS) will help boot
> the APs. More details about this wakeup model can be found in ACPI
> specification v6.4, the section titled "Multiprocessor Wakeup Structure".
> 
> Since the existing trampoline code requires processors to boot in real
> mode with 16-bit addressing, it will not work for this wakeup model
> (because it boots the AP in 64-bit mode). To handle it, extend the
> trampoline code to support 64-bit mode firmware handoff. Also, extend
> IDT and GDT pointers to support 64-bit mode hand off.
> 
> There is no TDX-specific detection for this new boot method. The kernel
> will rely on it as the sole boot method whenever the new ACPI structure
> is present.
> 
> The ACPI table parser for the MADT multiprocessor wake up structure and
> the wakeup method that uses this structure will be added by the following
> patch in this series.
> 
> Reported-by: Kai Huang <kai.huang@intel.com>

I wonder what that Reported-by tag means here for this is a feature
patch, not a bug fix or so...

> diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
> index 331474b150f1..fd6f6e5b755a 100644
> --- a/arch/x86/include/asm/realmode.h
> +++ b/arch/x86/include/asm/realmode.h
> @@ -25,6 +25,7 @@ struct real_mode_header {
>  	u32	sev_es_trampoline_start;
>  #endif
>  #ifdef CONFIG_X86_64
> +	u32	trampoline_start64;
>  	u32	trampoline_pgd;
>  #endif

Hmm, so there's trampoline_start, sev_es_trampoline_start and
trampoline_start64. If those are mutually exclusive, can we merge them
all into a single trampoline_start?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
