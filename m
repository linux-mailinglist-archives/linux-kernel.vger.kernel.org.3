Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8921E493B29
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 14:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354863AbiASNfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 08:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbiASNfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 08:35:21 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B827C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 05:35:21 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B91271EC01A9;
        Wed, 19 Jan 2022 14:35:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642599315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BNGvzXGl/y0GbmZJgEe+t3c2zavYEGr3Ohli9ZTv3qU=;
        b=PGQe7g9+fK2wO3nnqpEKLhnjgfeB0YDXKsYHahlQeGjJ6uQm4UCjAdlxYcl1t+P2Du8LNv
        SVebiSGevl/ZLy0iARZZV8WwBUHIWcTh9yNINLJ6raSCHUNcStrh9Ci0D0oM1/2BaAr/YP
        qHrNjF9pkciv86/QNNJ/7EKnLcfOjX8=
Date:   Wed, 19 Jan 2022 14:35:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, dave.hansen@intel.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, pbonzini@redhat.com, sdeep@vmware.com,
        seanjc@google.com, tony.luck@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/26] x86/tdx: Support TDX guest port I/O at
 decompression time
Message-ID: <YegTjdltOFBIDlf2@zn.tnic>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-11-kirill.shutemov@linux.intel.com>
 <YeAuehoOEjUH3vZ3@zn.tnic>
 <20220115010155.ss2hnyotw4a3nljf@black.fi.intel.com>
 <YeK7AJXGN5GVGkRV@zn.tnic>
 <20220117143920.3umnnlx7dl27cm5z@box.shutemov.name>
 <YeW2U9vH65NcLHtY@zn.tnic>
 <20220119115326.rw2aj3ho2mct4xxv@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220119115326.rw2aj3ho2mct4xxv@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raise hpa and tglx to To: for the general direction.

Full mail is at

https://lore.kernel.org/r/20220119115326.rw2aj3ho2mct4xxv@box.shutemov.name

On Wed, Jan 19, 2022 at 02:53:26PM +0300, Kirill A. Shutemov wrote:
> Could you take a look if the diff below is the right direction?
> 
> If yes, I will prepare a proper patches. My plan is 3 patches: introduce
> <asm/shared/io.h>, add 'struct port_io_ops' for early boot, hook up
> alternative 'struct port_io_ops' for TDX.

Makes sense.

> diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
> index 34c9dbb6a47d..27ce7cef13aa 100644
> --- a/arch/x86/boot/boot.h
> +++ b/arch/x86/boot/boot.h
> @@ -18,11 +18,14 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +#undef CONFIG_PARAVIRT

Yeah, this is the stuff I'd like to avoid in boot/. Can we get rid of
any ifdeffery in the shared/ namespace?

I see this slow_down_io()-enforced CONFIG_PARAVIRT ifdeffery and that
should not be there but in the ...asm/io.h kernel proper header. In the
shared header we should have only basic functions which are shared by
all.

For the same reason I don't think the shared header should have those
if (cc_platform_has... branches but just the basic bits with the asm
wrappers.

Hmmm.

> diff --git a/arch/x86/boot/compressed/io.h b/arch/x86/boot/compressed/io.h
> new file mode 100644
> index 000000000000..e69de29bb2d1

That one's empty.

> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index d8373d766672..48de56f2219d 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -15,9 +15,12 @@
>  #include "misc.h"
>  #include "error.h"
>  #include "pgtable.h"
> +#include "tdx.h"
> +#include "io.h"
>  #include "../string.h"
>  #include "../voffset.h"
>  #include <asm/bootparam_utils.h>
> +#include <asm/shared/io.h>
>  
>  /*
>   * WARNING!!
> @@ -47,6 +50,8 @@ void *memmove(void *dest, const void *src, size_t n);
>   */
>  struct boot_params *boot_params;
>  
> +struct port_io_ops port_io_ops;

call that pio_ops to differ from the struct name.

> +
>  memptr free_mem_ptr;
>  memptr free_mem_end_ptr;
>  
> @@ -103,10 +108,12 @@ static void serial_putchar(int ch)
>  {
>  	unsigned timeout = 0xffff;
>  
> -	while ((inb(early_serial_base + LSR) & XMTRDY) == 0 && --timeout)
> +	while ((port_io_ops.inb(early_serial_base + LSR) & XMTRDY) == 0 &&
> +	       --timeout) {
>  		cpu_relax();
> +	}
>  
> -	outb(ch, early_serial_base + TXR);
> +	port_io_ops.outb(ch, early_serial_base + TXR);
>  }
>  
>  void __putstr(const char *s)
> @@ -152,10 +159,10 @@ void __putstr(const char *s)
>  	boot_params->screen_info.orig_y = y;
>  
>  	pos = (x + cols * y) * 2;	/* Update cursor position */
> -	outb(14, vidport);
> -	outb(0xff & (pos >> 9), vidport+1);
> -	outb(15, vidport);
> -	outb(0xff & (pos >> 1), vidport+1);
> +	port_io_ops.outb(14, vidport);
> +	port_io_ops.outb(0xff & (pos >> 9), vidport+1);
> +	port_io_ops.outb(15, vidport);
> +	port_io_ops.outb(0xff & (pos >> 1), vidport+1);
>  }
>  
>  void __puthex(unsigned long value)
> @@ -370,6 +377,15 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>  	lines = boot_params->screen_info.orig_video_lines;
>  	cols = boot_params->screen_info.orig_video_cols;
>  
> +	port_io_ops = (const struct port_io_ops){
> +		.inb = inb,
> +		.inw = inw,
> +		.inl = inl,
> +		.outb = outb,
> +		.outw = outw,
> +		.outl = outl,
> +	};

Why here and not statically defined above?

> +
>  	/*
>  	 * Detect TDX guest environment.
>  	 *
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 6502adf71a2f..74951befb240 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -19,26 +19,23 @@
>  /* cpu_feature_enabled() cannot be used this early */
>  #define USE_EARLY_PGTABLE_L5
>  
> -/*
> - * Redefine __in/__out macros via tdx.h before including
> - * linux/io.h.
> - */
> -#include "tdx.h"
> -
>  #include <linux/linkage.h>
>  #include <linux/screen_info.h>
>  #include <linux/elf.h>
> -#include <linux/io.h>
>  #include <asm/page.h>
>  #include <asm/boot.h>
>  #include <asm/bootparam.h>
>  #include <asm/desc_defs.h>
>  
> +/* Avoid pulling outb()/inb() from <asm/io.h> */
> +#define _ACPI_IO_H_
> +

This too. I think those shared headers should contain the basic
functionality which all stages share and can include without ifdeffery.

If they have to change that functionality, they will have to define
their own io.h header, extend it there by using the basic one and then
use it.

This way we'll always have the common, shared stuff in, well, a shared
header.

IMNSVHO.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
