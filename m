Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4485494123
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbiASTqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 14:46:37 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54836 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230233AbiASTqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:46:36 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 840D51EC04EC;
        Wed, 19 Jan 2022 20:46:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642621591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dsPEM5aEnSJRJ8gMnU+NAZrbVimVsgRGR+O2Gb2WDZk=;
        b=LWSaHbC1/2oS+M2awBLDUO+nBNzqxgUY2fz/gKliq/DinD98YI81upER14RdTcKSSTTTQb
        09zQuGhRrWTdmRNSIu5y2K/H4q3CkcHMYxaeoqp3Z9JFK5kmqbs7zbK3t0BXqcj1ZPXKEm
        yo1Tsd/MOzHft2Lm7x4tp9JV9NlXCq8=
Date:   Wed, 19 Jan 2022 20:46:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, dave.hansen@intel.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/26] x86/tdx: Support TDX guest port I/O at
 decompression time
Message-ID: <YehqkKNgQ65uUOe6@zn.tnic>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-11-kirill.shutemov@linux.intel.com>
 <YeAuehoOEjUH3vZ3@zn.tnic>
 <20220115010155.ss2hnyotw4a3nljf@black.fi.intel.com>
 <YeK7AJXGN5GVGkRV@zn.tnic>
 <20220117143920.3umnnlx7dl27cm5z@box.shutemov.name>
 <YeW2U9vH65NcLHtY@zn.tnic>
 <20220119115326.rw2aj3ho2mct4xxv@box.shutemov.name>
 <YegTjdltOFBIDlf2@zn.tnic>
 <20220119154925.mzri4zaz3o477e3k@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220119154925.mzri4zaz3o477e3k@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 06:49:25PM +0300, Kirill A. Shutemov wrote:
> const struct port_io_ops default_pio_ops = {
> 	.inb = inb,
> 	.inw = inw,
> 	.inl = inl,
> 	.outb = outb,
> 	.outw = outw,
> 	.outl = outl,
> };
> 
> make pio_ops a pointer and assign it here:
> 
> 	pio_ops = &default_pio_ops;
> 
> But it leads to an issue on linking:
> 
> ld.lld: error: Unexpected run-time relocations (.rela) detected!

So the above generates absolute relocations of type R_X86_64_64

Relocation section '.rela.data.rel.local' at offset 0x5c18 contains 6 entries:
  Offset          Info           Type           Sym. Value    Sym. Name + Addend
000000000000  000200000001 R_X86_64_64       0000000000000000 .text + 10
000000000008  000200000001 R_X86_64_64       0000000000000000 .text + 30
000000000010  000200000001 R_X86_64_64       0000000000000000 .text + 50
000000000018  000200000001 R_X86_64_64       0000000000000000 .text + 0
000000000020  000200000001 R_X86_64_64       0000000000000000 .text + 20
000000000028  000200000001 R_X86_64_64       0000000000000000 .text + 40

and the linker doesn't like them probably because of the mcmodel we use
but I need to talk to toolchain folks first to make sense of what's
going on...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
