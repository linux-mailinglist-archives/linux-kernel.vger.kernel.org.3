Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC218466E03
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 00:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377629AbhLBXwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 18:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377625AbhLBXwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 18:52:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46156C06174A;
        Thu,  2 Dec 2021 15:48:47 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638488924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5q90D0mcSKeapelm6wFaiR6ZRDLoVIIybSkt7RG4TXA=;
        b=HVFKNgAmw8BpXnSaXm6dFdAPqCkbeylbedN2Db6encPLZZF1WTUOFc1hT7OTNqRFBqi2ja
        HuNDUMebJkw5CbR9kQItS/7RPMxCEs38lmlsFaadF+nTukDGTmFmWiJ7UCYBWEpkSgKIPS
        zj9Xj6SIGep3Nku7VpeyDZM4WXKM023cucgvW62ErLO9pBqg6OZELI5GuYAykzx9vspRD0
        A78XvX6dPZV0CMK2uZCjuFfKnzvspHuSuRi4on/cAMWxr7pR3z4JIU/kFD+TtLtZIsWygY
        08S+SGsDaP45NBmhfg4mrGIx0li34VB0ezuuONNVnRCADlIz2QfWJuBiNhch1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638488924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5q90D0mcSKeapelm6wFaiR6ZRDLoVIIybSkt7RG4TXA=;
        b=BZTi2VWIYlscz72ONISvig/5FIrXyD1ipJCY35f2BaYWpU95nt3gG+RtzTboK/uGCDqJpa
        lZJIY7ORK2FjuJDw==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2] x86: Skip WBINVD instruction for VM guest
In-Reply-To: <20211202222109.pcsgm2jska3obvmx@black.fi.intel.com>
References: <YZPbQVwWOJCrAH78@zn.tnic>
 <20211119040330.4013045-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <87pmqpjcef.ffs@tglx> <20211202222109.pcsgm2jska3obvmx@black.fi.intel.com>
Date:   Fri, 03 Dec 2021 00:48:43 +0100
Message-ID: <87lf126010.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill,

On Fri, Dec 03 2021 at 01:21, Kirill A. Shutemov wrote:
> On Thu, Nov 25, 2021 at 01:40:24AM +0100, Thomas Gleixner wrote:
>> Kuppuswamy,
>> Either that or you provide patches with arguments which are based on
>> proper analysis and not on 'appears to' observations.
>
> I think the right solution to the WBINVD would be to add a #VE handler
> that does nothing. We don't have a reasonable way to handle it from within
> the guest. We can call the VMM in hope that it would handle it, but VMM is
> untrusted and it can ignore the request.
>
> Dave suggested that we need to do code audit to make sure that there's no
> user inside TDX guest environment that relies on WBINVD to work correctly.
>
> Below is full call tree of WBINVD. It is substantially larger than I
> anticipated from initial grep.
>
> Conclusions:
>
>   - Most of callers are in ACPI code on changing S-states. Ignoring cache
>     flush for S-state change on virtual machine should be safe.
>
>   - The only WBINVD I was able to trigger is on poweroff from ACPI code.
>     Reboot also should trigger it, but for some reason I don't see it.
>
>   - Few caller in CPU offline code. TDX does not allowed to offline CPU as
>     we cannot bring it back -- we don't have SIPI. And even if offline
>     works for vCPU it should be safe to ignore WBINVD there.
>
>   - NVDIMMs are not supported inside TDX. If it will change we would need
>     to deal with cache flushing for this case. Hopefully, we would be able
>     to avoid WBINVD.
>
>   - Cache QoS and MTRR use WBINVD. They are disabled in TDX, but it is
>     controlled by VMM if the feature is advertised. We would need to
>     filter CPUID/MSRs to make sure VMM would not mess with them.
>
> Is it good enough justification for do-nothing #VE WBINVD handler?

first of all thank you very much for this very profound analysis.

This is really what I was asking for and you probably went even a step
deeper than that. Very appreciated.

What we should do instead of doing a wholesale let's ignore WBINVD is to
have a separate function/macro:

 ACPI_FLUSH_CPU_CACHE_PHYS()

and invoke that from the functions which are considered to be safe.

That would default to ACPI_FLUSH_CPU_CACHE() for other architecures
obviously.

Then you can rightfully do:

#define ACPI_FLUSH_CPU_CACHE_PHYS()     \
        if (!cpu_feature_enabled(XXX))	\
        	wbinvd();               \              
                
where $XXX might be FEATURE_TDX_GUEST for paranoia sake and then
extended to X86_FEATURE_HYPERVISOR if everyone agrees.

Then you have the #VE handler which just acts on any other wbinvd
invocation via warn, panic, whatever, no?

Thanks,

        tglx

