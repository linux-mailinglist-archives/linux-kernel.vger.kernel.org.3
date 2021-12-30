Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3F1481B84
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 11:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbhL3Kxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 05:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238762AbhL3Kxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 05:53:43 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E75BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 02:53:43 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6EDC01EC04D6;
        Thu, 30 Dec 2021 11:53:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640861617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cH/IwfAuOcFK4mkzTPhoKGd0X5YnfVD+UFut2GSRnN4=;
        b=iWJINpu2SOI7Ac5QGCVcgB+FfbYaA7RWYM3/vYLzaelmNFWl3DrFyP4Tqm83k0O6G95/LY
        5QqYdfUsiAHoJ+IqaWbO13t/PVulnIeUqaDVOTWvMBvo4qu5+AwNVJG33433s0VSRVIMFj
        j2OlmMiPCymEIQsN10pyuZQ72Ax7zbg=
Date:   Thu, 30 Dec 2021 11:53:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
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
Message-ID: <Yc2Ps9npROL3znOi@zn.tnic>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-5-kirill.shutemov@linux.intel.com>
 <YcTR5HnkHi7CjVyx@zn.tnic>
 <20211228233112.cpycmdv55edxhvbv@black.fi.intel.com>
 <YcxGrw6Ymqs8NPjY@zn.tnic>
 <20211230080500.cmc6x2nbykprlyy2@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211230080500.cmc6x2nbykprlyy2@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 11:05:00AM +0300, Kirill A. Shutemov wrote:
> Hm. Two sentance above the one you quoted describes (maybe badly? I donno)
> why #VE doesn't happen in entry paths. Maybe it's not clear it covers NMI
> entry path too.
> 
> What if I replace the paragraph with these two:
> 
> 	Kernel avoids #VEs during syscall gap and NMI entry code.

because? Explain why here.

>	Entry code
> 	paths do not access TD-shared memory, MMIO regions, use #VE triggering
> 	MSRs, instructions, or CPUID leaves that might generate #VE. Similarly,
> 	to page faults and breakpoints, #VEs are allowed in NMI handlers once
> 	kernel is ready to deal with nested NMIs.
> 
> 	During #VE delivery, all interrupts, including NMIs, are blocked until
> 	TDGETVEINFO is called. It prevents #VE nesting until kernel reads the VE
> 	info.

This alludes somewhat to the why above.

Now, I hear that TDX doesn't generate #VE anymore for the case where the
HV might have unmapped/made non-private the page which contains the NMI
entry code.

Explain that here too pls.

And then stick that text over exc_virtualization_exception() so that it
is clear what's going on and that it can be easily found.

And then you still need to deal with

"(and should eventually be a panic, as it is expected panic_on_oops is
set to 1 for TDX guests)."

You can say what is expected to be done by the TDX guest owner in some
how-to doc but if those expectations are not met, then the guest should
simply die. Not we expect this and hope that users will do it, but
actually enforce it.

> Commit message already has this:
> 
> 	Add basic infrastructure to handle any #VE which occurs in the kernel
> 	or userspace. Later patches will add handling for specific #VE
> 	scenarios.
> 
> I'm not sure what need to be changed.

That:

+ * Return True on success and False on failure.
+ */
+static bool tdx_virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
+{
+       pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
+       return false;

Kill the wrong comment.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
