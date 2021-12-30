Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9AD481EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 19:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241590AbhL3SCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 13:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236001AbhL3SCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 13:02:21 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3791FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 10:02:21 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 33EA51EC0354;
        Thu, 30 Dec 2021 19:02:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640887335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bi5eqR3iTwO+cVYztiLpIkRFM8Tu2pVJl0IA02mZXYM=;
        b=MaH3Ypy2W4T8N8fJD6O2deGqex4XQoflWdhFjVXfZSQX6P6gITDQ+t8QepXXbt52DXQWpI
        tVPc6IsXDXbcBipi8fz9PCf+rcmG75agxLI2cn0Yp/ah8b/SJpgBz0qTn9TxITw1YEjpD9
        w4UNdGqdtPdzMMxsjpsmfmboPVCAMZM=
Date:   Thu, 30 Dec 2021 19:02:21 +0100
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
Message-ID: <Yc30LewCB5u6lVpW@zn.tnic>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-5-kirill.shutemov@linux.intel.com>
 <YcTR5HnkHi7CjVyx@zn.tnic>
 <20211228233112.cpycmdv55edxhvbv@black.fi.intel.com>
 <YcxGrw6Ymqs8NPjY@zn.tnic>
 <20211230080500.cmc6x2nbykprlyy2@box.shutemov.name>
 <Yc2Ps9npROL3znOi@zn.tnic>
 <20211230154127.tf2rc4yu2v7uorv5@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211230154127.tf2rc4yu2v7uorv5@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 06:41:27PM +0300, Kirill A. Shutemov wrote:
> The updated commit message is below. Let me know if something is unclear.
> 
> ----------------------------8<-------------------------------------------
> 
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

virtualization exceptions

> generated on accesses to normal, TD-private memory that has been
> accepted.
> 
> Syscall entry code has a critical window where the kernel stack is not
> yet set up. Any exception in this window leads to hard to debug issues
> and can be exploited for privilege escalation. Exceptions in the NMI
> entry code also cause issues. IRET from the exception handle will

"Returning from the exception handler with IRET will... "

> re-enable NMIs and nested NMI will corrupt the NMI stack.
> 
> For these reasons, the kernel avoids #VEs during the syscall gap and
> the NMI entry code. Entry code paths do not access TD-shared memory,
> MMIO regions, use #VE triggering MSRs, instructions, or CPUID leaves
> that might generate #VE. VMM can remove memory from TD at any point,
> but access to unaccepted (or missing) private memory leads to VM
> termination, not to #VE.
> 
> Similarly, to page faults and breakpoints, #VEs are allowed in NMI

"Similarly to" - no comma.

> handlers once the kernel is ready to deal with nested NMIs.
> 
> During #VE delivery, all interrupts, including NMIs, are blocked until
> TDGETVEINFO is called. It prevents #VE nesting until the kernel reads
> the VE info.
> 
> If a guest kernel action which would normally cause a #VE occurs in
> the interrupt-disabled region before TDGETVEINFO, a #DF (fault
> exception) is delivered to the guest which will result in an oops.

That up to here can go over the #VE handler.

> Add basic infrastructure to handle any #VE which occurs in the kernel
> or userspace. Later patches will add handling for specific #VE
> scenarios.
> 
> For now, convert unhandled #VE's (everything, until later in this
> series) so that they appear just like a #GP by calling the
> ve_raise_fault() directly. The ve_raise_fault() function is similar
> to #GP handler and is responsible for sending SIGSEGV to userspace
> and CPU die and notifying debuggers and other die chain users.

Yap, better.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
