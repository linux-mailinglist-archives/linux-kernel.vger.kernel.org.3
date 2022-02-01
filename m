Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE3D4A63D6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbiBASbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbiBASbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:31:02 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3B7C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 10:31:01 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 60A7C1EC0513;
        Tue,  1 Feb 2022 19:30:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643740256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SelJnsO3AI+ddNI4mpxmGVzS4kYycs/voWIlYXQsR6c=;
        b=MkB9SXbeyDNgeqM0WeSGqg8Xv9ksewonLwTSCjuAT5FuM8zjbys8kwBL+IIQwoAk44NsWg
        Re0J289D0PTENYTO30XUnlqrGmsJKvZKNkibHmOtxLaOwvIFVuOPMxRMqbnPZQtDCdqALD
        CTWsRxSY0ELzQVIfT1Hs6Bu1jmcV7Pk=
Date:   Tue, 1 Feb 2022 19:30:52 +0100
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
Subject: Re: [PATCHv2 09/29] x86/tdx: Detect TDX at early kernel
 decompression time
Message-ID: <Yfl8XKSq5uhHbfiu@zn.tnic>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-10-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220124150215.36893-10-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 06:01:55PM +0300, Kirill A. Shutemov wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> The early decompression code does port I/O for its console output. But,
> handling the decompression-time port I/O demands a different approach
> from normal runtime because the IDT required to support #VE based port
> I/O emulation is not yet set up. Paravirtualizing I/O calls during
> the decompression step is acceptable because the decompression code size is
> small enough and hence patching it will not bloat the image size a lot.
> 
> To support port I/O in decompression code, TDX must be detected before
> the decompression code might do port I/O. Add support to detect for
> TDX guest support before console_init() in the extract_kernel().

s/Add support to detect for TDX guest support before console_init() in the extract_kernel()./Detect whether the kernel runs in a TDX guest./

Simple.

> Detecting it above the console_init() is early enough for patching
> port I/O.

No need for that sentence - there's already a comment above the call
below.

> 
> Add an early_is_tdx_guest() interface to get the cached TDX guest

s/get/query/

> status in the decompression code.

...

> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index a4339cb2d247..d8373d766672 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -370,6 +370,14 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>  	lines = boot_params->screen_info.orig_video_lines;
>  	cols = boot_params->screen_info.orig_video_cols;
>  
> +	/*
> +	 * Detect TDX guest environment.
> +	 *
> +	 * It has to be done before console_init() in order to use
> +	 * paravirtualized port I/O oprations if needed.

Unknown word [oprations] in comment.
Suggestions: ['orations', 'operations', 'op rations', 'op-rations', 'preparations', 'reparations', 'inspirations', 'operation']

> +	 */
> +	early_tdx_detect();
> +
>  	console_init();
>  
>  	/*

...

> diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> new file mode 100644
> index 000000000000..12bede46d048
> --- /dev/null
> +++ b/arch/x86/include/asm/shared/tdx.h
> @@ -0,0 +1,7 @@
> +#ifndef _ASM_X86_SHARED_TDX_H
> +#define _ASM_X86_SHARED_TDX_H

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#232: FILE: arch/x86/include/asm/shared/tdx.h:1:
+#ifndef _ASM_X86_SHARED_TDX_H

Why isn't checkpatch part of your patch creation workflow?

> +
> +#define TDX_CPUID_LEAF_ID	0x21
> +#define TDX_IDENT		"IntelTDX    "
> +
> +#endif
	  ^
	 /* _ASM_X86_SHARED_TDX_H */

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
