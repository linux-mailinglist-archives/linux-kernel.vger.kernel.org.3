Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B19447E877
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 20:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350138AbhLWTpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 14:45:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56898 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244856AbhLWTpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 14:45:43 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 96A771EC052C;
        Thu, 23 Dec 2021 20:45:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640288738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GIRBlL+iiTgH3dproQOBfea9NGLTBWmifcVI0uoj7Hw=;
        b=eI0VnDr5E3I3aFabWxYfx/M21f7MFwsFH2L24MFvjt5L3ni1vs5W/73BHwFouPS3p9kMvx
        w9ltHAn8NMKmKlB5uU7HDs069v1ox1kosW4gfheSldWXKQ4TR8+FzVZCqqpfxLENDUW0BO
        oesuOmi9psOoEbvMpN7xReVuzXT286U=
Date:   Thu, 23 Dec 2021 20:45:40 +0100
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
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH 04/26] x86/traps: Add #VE support for TDX guest
Message-ID: <YcTR5HnkHi7CjVyx@zn.tnic>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-5-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211214150304.62613-5-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 06:02:42PM +0300, Kirill A. Shutemov wrote:
> Virtualization Exceptions (#VE) are delivered to TDX guests due to
> specific guest actions which may happen in either user space or the
> kernel:
> 
>  * Specific instructions (WBINVD, for example)
>  * Specific MSR accesses
>  * Specific CPUID leaf accesses
>  * Access to unmapped pages (EPT violation)
> 
> In the settings that Linux will run in, virtual exceptions are never
> generated on accesses to normal, TD-private memory that has been
> accepted.
> 
> The #VE handler implementation is simplified by the fact that entry
> paths do not trigger #VE and that the handler may not be interrupted.
> Specifically, the implementation assumes that the entry paths do not
> access TD-shared memory, MMIO regions, use #VE triggering MSRs,
> instructions, or CPUID leaves that might generate #VE. Interrupts,
> including NMIs, are blocked by the hardware starting with #VE delivery
> until TDGETVEINFO is called. All of this combined  eliminates the
> chance of a #VE during the syscall gap, or paranoid entry paths.
> 
> After TDGETVEINFO, #VE could happen in theory (e.g. through an NMI),
> but it is expected not to happen because TDX expects NMIs not to
> trigger #VEs. Another case where #VE could happen is if the #VE
> exception panics, but in this case, since the platform is already in
> a panic state, nested #VE is not a concern.
> 
> If a guest kernel action which would normally cause a #VE occurs in
> the interrupt-disabled region before TDGETVEINFO, a #DF (fault
> exception) is delivered to the guest which will result in an oops
> (and should eventually be a panic, as it is expected panic_on_oops is
> set to 1 for TDX guests).

So until here there are a lot of expectations and assumptions. What
happens if those are violated?

What happens if the NMI handler triggers a #VE after all? Or where is it
enforced that TDX guests should set panic_on_oops?

It all reads really weird, like the TDX guest is a big bird which simply
sticks its head in the sand in the face of danger...

...

> +/*
> + * Handle the user initiated #VE.
> + *
> + * For example, executing the CPUID instruction from the user

"... from userspace... " no "the"

> + * space is a valid case and hence the resulting #VE had to

s/had/has/

> + * be handled.
> + *
> + * For dis-allowed or invalid #VE just return failure.
> + *
> + * Return True on success and False on failure.

You lost me here - function returns false unconditionally. And that
bla about CPUID from user being a valid case doesn't really look like
one when I look at the code. Especially since ve_raise_fault() sends a
SIGSEGV for user #VEs.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
