Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8603446A193
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239732AbhLFQng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239222AbhLFQne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:43:34 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC4AC0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 08:40:05 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so11238944pju.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 08:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YZGwgQr9TnHSsdDrZ5O2tR1cNzcd9zE3EQ/xZk4GMoE=;
        b=pps9LsdHCr/+0G93zCgdY6KFzzavFCEtsMBdBBPVQ2MCsrQOm22c+4Y/nbd0h4ypsh
         e0O8ECzGQcWOxIOjJO27y+kHGpu116DX4nNyFa6IAr6DGRkhGG6kcwN3VACy0fnxaV5u
         xkWVGHZojBZtyeIv8Ng2309i5u2/oaSqBglOrhxI2llqrEguLegZ3lLKCuRuuOAgktUZ
         LvBCwdIg3kqNOSinr3tp3Ne6GmpfiCMmeYZRyjPcKvQrA0aBIXguzK8HVqpa94ixBU8Q
         WXSk+JUUfHleNTBc6ZZtgMezcDU4RXVeOIY+rAXi4gOn4cPDuPaM3oKAAhm1it9fG2ww
         BS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZGwgQr9TnHSsdDrZ5O2tR1cNzcd9zE3EQ/xZk4GMoE=;
        b=NH8IGDkNhM0n/9pPalzkYEXI4VNPAft+BD1lDRlNqlQyhHMGK5ZUi6uxCCl3OokqHs
         RfJGuMnhjVh0e8NQU/abBSwgI8RqQH4YAPpM9/tg0oWogV1Jw5zt73EqJletdRWh/JwS
         IsApuQvwJlwZVh0wJybFNOGvV8Ut5qSUmXBOB7V+Qof9OjiMVTPROhW8zLvlqSRPBZGq
         7Y8y+vEKeoj7hKxuiXLisjJN8Gl//0b96tmSeeivfeN2zdDTggom3PN3briRp8hBgmQL
         sXG5pp0OXUyLBLfSvkL8ulLJ1pIy3VrS7+d5gf7eya8Tk4A/N9exZegtvhRTpfNJxs0c
         JVag==
X-Gm-Message-State: AOAM532Q1V6fnb2Gtv/TRqV2U5cz8wdRhNpmb2WUUMJ9ofefaCSVE9+q
        aM3ctmArk+N2DD4J+Elzj+IpaWPOlYa0UBpBJX1cSw==
X-Google-Smtp-Source: ABdhPJxGtcQevov5D/XI/psX3kLHSsRbDJt2oL/VfWvEC8u/+Tfeehru/r8gsZyIjb2JjirHQpRbHk5qOUMpxtRqWiw=
X-Received: by 2002:a17:90b:1e49:: with SMTP id pi9mr38600776pjb.220.1638808804583;
 Mon, 06 Dec 2021 08:40:04 -0800 (PST)
MIME-Version: 1.0
References: <YZPbQVwWOJCrAH78@zn.tnic> <20211119040330.4013045-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <87pmqpjcef.ffs@tglx> <20211202222109.pcsgm2jska3obvmx@black.fi.intel.com>
 <87lf126010.ffs@tglx> <20211203234915.jw6kdd2qnfrionch@black.fi.intel.com>
 <2519e6b6-4f74-e2f8-c428-0fceb0e16472@intel.com> <20211204005427.ccinxlwwab3jsuct@black.fi.intel.com>
 <5bc40889-445d-5cac-3396-d39d53ee92c7@intel.com>
In-Reply-To: <5bc40889-445d-5cac-3396-d39d53ee92c7@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 6 Dec 2021 08:39:53 -0800
Message-ID: <CAPcyv4gHK=-gxxYexV8jtycPGE15yDWe7jYutbcqKc-1Zhmx8Q@mail.gmail.com>
Subject: Re: [PATCH v2] x86: Skip WBINVD instruction for VM guest
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 7:35 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 12/3/21 4:54 PM, Kirill A. Shutemov wrote:
> > On Fri, Dec 03, 2021 at 04:20:34PM -0800, Dave Hansen wrote:
> >>> TDX doesn't support these S- and C-states. TDX is only supports S0 and S5.
> >>
> >> This makes me a bit nervous.  Is this "the first TDX implementation
> >> supports..." or "the TDX architecture *prohibits* supporting S1 (or
> >> whatever"?
> >
> > TDX Virtual Firmware Design Guide only states that "ACPI S3 (not supported
> > by TDX guests)".
> >
> > Kernel reports in dmesg "ACPI: PM: (supports S0 S5)".
>
> Those describe the current firmware implementation, not a guarantee
> provided by the TDX architecture forever.
>
> > But I don't see how any state beyond S0 and S5 make sense in TDX context.
> > Do you?
>
> Do existing (non-TDX) VMs use anything other than S0 and S5?  If so, I'd
> say yes.
>
> >> I really think we need some kind of architecture guarantee.  Without
> >> that, we risk breaking things if someone at our employer simply changes
> >> their mind.
> >
> > Guarantees are hard.
> >
> > If somebody change their mind we will get unexpected #VE and crash.
> > I think it is acceptable way to handle unexpected change in confidential
> > computing environment.
>
> Architectural guarantees are quite easy, actually.  They're just a
> contract that two parties agree to.  In this case, the contract would be
> that TDX firmware *PROMISES* not to enumerate support for additional
> sleep states over what the implementation does today.  If future
> firmware breaks that promise (and the kernel crashes) we get to come
> after them with torches and pitchforks to fix the firmware.
>
> The contract let's us do things in the OS like:
>
>         WARN_ON(sleep_states[ACPI_STATE_S3]);
>
> We also don't need *formal* documentation of such things.  We really
> just need to have a chat.
>
> It would be perfectly sufficient if we go bug Intel's TDX architecture
> folks and say, "Hey, Linux is going to crash if you ever implement any
> actual sleep states.  The current implementation is fine here, but is it
> OK if future implementations are restricted from doing this?"
>
> But, the trick is that we need a contract.  A contract requires a
> "meeting of the minds" first.

The WBINVD requirement in sleep states is about getting cache contents
out to to power preserved domain before the CPU turns off. The bare
metal host handles that requirement. The conversation that needs to be
had is with the ACPI specification committee to clarify that virtual
machines have no responsibility to flush caches. We can do that as a
Code First proposal to the ACPI Specification Working Group.
