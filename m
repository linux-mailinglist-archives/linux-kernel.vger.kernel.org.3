Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE2B481DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239034AbhL3PlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhL3PlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:41:16 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7214C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:41:15 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id o12so55331161lfk.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5yloS7rSwkTECVbYQowLjBgomSbGlwmJqy4i1hH8YmM=;
        b=58BtMlgIMMjeqpE5muZGJ34GPobTxV9veOVjqA5tSaAM9eahSaS/SDxCsSL2v8UkMb
         RFCUhGaY2II1+YXvxj11w3tWDDI1MheCYiYmn4qEYev4EbXYG8yq/HgNkklweSgrbpCI
         /SvlSaAmz9mSBBHHv+GrGqnKx25ZVj06sfOchXOzcMoBCLzZuOkkwSH1cVrhbUgVT7SQ
         MKVMpqlBA6d4hQ1/jBaoSPCliN2VWBhj3DHpQGY1r3+/pU7DQwm71sIaMJNhlv3QDpVl
         5uSt5S7uBSFxNFLZOD5ueDD96/5PJieq7/1oZllYcZouPHWQQtI2zNyWJ4FShSZoY3xd
         edoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5yloS7rSwkTECVbYQowLjBgomSbGlwmJqy4i1hH8YmM=;
        b=30wEHrbgKVBzOA/p3W9b1CTJCZ6F6M3C7KwSrAsMHarD2HQnzvRonWrgpktUfqtu/k
         U8r1CMAMkzwRppcxr+vZvx84guGnI4UanIsKrDkHh/Xrja5fdsRflPTV8NuboVEiSfxI
         VzdO9aThBpyvS5SgoqYM+9e0bTeg0mxHM/gOpHRELLe2L0cfJcz4OJX7sSXmJJqlL9Zc
         YJzgJwO/Sf6UnywQCMfeBS54tyZDZmBdRREbNI5wJ0L7xHU2cTo7FiOcgc65UmM3+vGL
         vg19yCRXo/jByXVG/gXvGR3OEhw8AlFpN2BKbwsPLzkXH9aR+jJVNIv7xaNJD702oapR
         2q0g==
X-Gm-Message-State: AOAM533hXpBoPBlKhmNsewIx4YzHRzi/FFuds0GJkAExxJpk0NqVcg8M
        qWRnVk096a1uiEVM4vDMjNvozQ==
X-Google-Smtp-Source: ABdhPJwhe2WvcoXkAw8rcsW73CYVK4NPpYq5Z96qy8HUerjq5ho/3hLoymlv1luPt+vAo+KXZdqkzw==
X-Received: by 2002:a19:501a:: with SMTP id e26mr5655655lfb.15.1640878873869;
        Thu, 30 Dec 2021 07:41:13 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id l7sm1989700lfg.89.2021.12.30.07.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 07:41:13 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 66FD4103C43; Thu, 30 Dec 2021 18:41:27 +0300 (+03)
Date:   Thu, 30 Dec 2021 18:41:27 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
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
Message-ID: <20211230154127.tf2rc4yu2v7uorv5@box.shutemov.name>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-5-kirill.shutemov@linux.intel.com>
 <YcTR5HnkHi7CjVyx@zn.tnic>
 <20211228233112.cpycmdv55edxhvbv@black.fi.intel.com>
 <YcxGrw6Ymqs8NPjY@zn.tnic>
 <20211230080500.cmc6x2nbykprlyy2@box.shutemov.name>
 <Yc2Ps9npROL3znOi@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yc2Ps9npROL3znOi@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 11:53:39AM +0100, Borislav Petkov wrote:
> On Thu, Dec 30, 2021 at 11:05:00AM +0300, Kirill A. Shutemov wrote:
> > Hm. Two sentance above the one you quoted describes (maybe badly? I donno)
> > why #VE doesn't happen in entry paths. Maybe it's not clear it covers NMI
> > entry path too.
> > 
> > What if I replace the paragraph with these two:
> > 
> > 	Kernel avoids #VEs during syscall gap and NMI entry code.
> 
> because? Explain why here.

Okay.

> 
> >	Entry code
> > 	paths do not access TD-shared memory, MMIO regions, use #VE triggering
> > 	MSRs, instructions, or CPUID leaves that might generate #VE. Similarly,
> > 	to page faults and breakpoints, #VEs are allowed in NMI handlers once
> > 	kernel is ready to deal with nested NMIs.
> > 
> > 	During #VE delivery, all interrupts, including NMIs, are blocked until
> > 	TDGETVEINFO is called. It prevents #VE nesting until kernel reads the VE
> > 	info.
> 
> This alludes somewhat to the why above.

It addresses the apparent issue with nested #VEs. I consider it to be
separate from the issue of exceptions in the entry code.

> Now, I hear that TDX doesn't generate #VE anymore for the case where the
> HV might have unmapped/made non-private the page which contains the NMI
> entry code.
> 
> Explain that here too pls.

Okay.

> And then stick that text over exc_virtualization_exception() so that it
> is clear what's going on and that it can be easily found.

Will do.

> 
> And then you still need to deal with
> 
> "(and should eventually be a panic, as it is expected panic_on_oops is
> set to 1 for TDX guests)."

I will drop this. Forcing panic_on_oops is out of scope for the patch.

The updated commit message is below. Let me know if something is unclear.

----------------------------8<-------------------------------------------

Virtualization Exceptions (#VE) are delivered to TDX guests due to
specific guest actions which may happen in either user space or the
kernel:

 * Specific instructions (WBINVD, for example)
 * Specific MSR accesses
 * Specific CPUID leaf accesses
 * Access to unmapped pages (EPT violation)

In the settings that Linux will run in, virtual exceptions are never
generated on accesses to normal, TD-private memory that has been
accepted.

Syscall entry code has a critical window where the kernel stack is not
yet set up. Any exception in this window leads to hard to debug issues
and can be exploited for privilege escalation. Exceptions in the NMI
entry code also cause issues. IRET from the exception handle will
re-enable NMIs and nested NMI will corrupt the NMI stack.

For these reasons, the kernel avoids #VEs during the syscall gap and
the NMI entry code. Entry code paths do not access TD-shared memory,
MMIO regions, use #VE triggering MSRs, instructions, or CPUID leaves
that might generate #VE. VMM can remove memory from TD at any point,
but access to unaccepted (or missing) private memory leads to VM
termination, not to #VE.

Similarly, to page faults and breakpoints, #VEs are allowed in NMI
handlers once the kernel is ready to deal with nested NMIs.

During #VE delivery, all interrupts, including NMIs, are blocked until
TDGETVEINFO is called. It prevents #VE nesting until the kernel reads
the VE info.

If a guest kernel action which would normally cause a #VE occurs in
the interrupt-disabled region before TDGETVEINFO, a #DF (fault
exception) is delivered to the guest which will result in an oops.

Add basic infrastructure to handle any #VE which occurs in the kernel
or userspace. Later patches will add handling for specific #VE
scenarios.

For now, convert unhandled #VE's (everything, until later in this
series) so that they appear just like a #GP by calling the
ve_raise_fault() directly. The ve_raise_fault() function is similar
to #GP handler and is responsible for sending SIGSEGV to userspace
and CPU die and notifying debuggers and other die chain users.

-- 
 Kirill A. Shutemov
