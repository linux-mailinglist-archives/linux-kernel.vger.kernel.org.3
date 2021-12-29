Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEFF481206
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 12:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbhL2L3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 06:29:55 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48492 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231327AbhL2L3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 06:29:54 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EA69F1EC04D1;
        Wed, 29 Dec 2021 12:29:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640777389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wZkbR9/7c36JkRQGSnSHRGZAzbdMlzBjAJXFGjZWu3w=;
        b=Zg/x1hv23QyoPaB/M+Idt/9gnNqabSQdtHbEgB2Yt+mg9DtuNnMQ4q2qFq1Gy44AxlkqkH
        cq4GDMy2BbSSRvpTbeqMwP24NVItw2jutBw+4af/gVaNs5uTHWaDmNCwoI9nmNXyPerF/D
        YcheNjIdbMd61MoLPrSYFcqMURQrsP4=
Date:   Wed, 29 Dec 2021 12:29:51 +0100
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
Message-ID: <YcxGrw6Ymqs8NPjY@zn.tnic>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-5-kirill.shutemov@linux.intel.com>
 <YcTR5HnkHi7CjVyx@zn.tnic>
 <20211228233112.cpycmdv55edxhvbv@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211228233112.cpycmdv55edxhvbv@black.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 02:31:12AM +0300, Kirill A. Shutemov wrote:
> On Thu, Dec 23, 2021 at 08:45:40PM +0100, Borislav Petkov wrote:
> > What happens if the NMI handler triggers a #VE after all? Or where is it
> > enforced that TDX guests should set panic_on_oops?
> 
> Kernel will handle the #VE normally inside NMI handler. (We tested it once
> again, just in case.)
> 
> The critical part is that #VE must not be triggered in NMI entry code,
> before kernel is ready to handle nested NMIs.

Well, I can't read that in the commit message, maybe it needs expanding
on that aspect?

What I read is:

"Interrupts, including NMIs, are blocked by the hardware starting with
#VE delivery until TDGETVEINFO is called."

but this simply means that *if* you get a #VE anywhere, NMIs are masked
until TDGETVEINFO.

If you get a #VE during the NMI entry code, then you're toast...

> #VE cannot possibly happen there: no #VE-inducing instructions, code and
> data are in guest private memory.

Right, that. So we cannot get a #VE there.

> VMM can remove private memory from under us, but access to unaccepted (or
> missing) private memory leads to VM termination, not to #VE.

And that can't trigger a #VE either.

So I'm confused...

It sounds like you wanna say: no #VEs should happen during the NMI entry
code because of <raisins> and in order to prevent those, we don't use
insns causing #VE, etc. And private pages removed by the VM will simply
terminate the guest.

So what's up?

> tdx_virt_exception_user()/tdx_virt_exception_kernel() will be populated by
> following patches. The patch adds generic infrastructure for #VE handling.

Yeah, you either need to state that somewhere or keep changing those
functions as they evolve in the patchset. As it is, it just confuses
reviewers.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
