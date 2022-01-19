Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C464939F0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 12:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354348AbiASLwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 06:52:21 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57178 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241852AbiASLwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 06:52:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0468A6160B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 11:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2160C004E1;
        Wed, 19 Jan 2022 11:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642593139;
        bh=QfpuL80/duahPHOR1KalTLy06DYEW34Je3XdZ5Xf75o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m20X0mJ3MzAXLJNXcmWwhF/O7iTUjdtfIexfjhZORLToSTg97fm/4gM9W6iaJgCeK
         LDE/VvkdorLX7OPmUYCHGd3iKRDjEBlEAY51Mjrnj75VWOSjRPbgHbDK099v510ybO
         i68wLNd1mS+hqMXQIKZyTtGLrBtmVYVgrOougnyK5KWeXCiM1YqF7+rfOyxiID29p+
         KyGnJZFjKCTbNwPDlmuHFFOzU3MSLGpfF1Kjf1CKGFiSDMafyPeyHobNAcCXSTWE6r
         Sykn4NY72ExihyXhecuVSwaJbwbTciTKlU2coZTaPjAn9IUSdFe7ru4In6WdKyec3k
         WRmakSOBFkXcA==
Date:   Wed, 19 Jan 2022 19:44:35 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        hpa@zytor.com, Eric Biederman <ebiederm@xmission.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kexec@lists.infradead.org,
        Alexandre ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v2 0/5] kexec: use IS_ENABLED(CONFIG_KEXEC_CORE) instead
 of #ifdef
Message-ID: <Yef5oz/XiZT/Pxfy@xhacker>
References: <20211206160514.2000-1-jszhang@kernel.org>
 <20220116133847.GE2388@MiWiFi-R3L-srv>
 <YebK70Sx4w8zLfj/@xhacker>
 <20220119080859.GB4977@MiWiFi-R3L-srv>
 <CA+zEjCvqYAWaWW9hVbHqYm_GbV-BaiOM4c77WHnxDNh+SRDUuw@mail.gmail.com>
 <20220119093322.GC4977@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220119093322.GC4977@MiWiFi-R3L-srv>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 05:33:22PM +0800, Baoquan He wrote:
> On 01/19/22 at 09:52am, Alexandre Ghiti wrote:
> > Hi Baoquan,
> > 
> > On Wed, Jan 19, 2022 at 9:11 AM Baoquan He <bhe@redhat.com> wrote:
> > >
> > > On 01/18/22 at 10:13pm, Jisheng Zhang wrote:
> > > > On Sun, Jan 16, 2022 at 09:38:47PM +0800, Baoquan He wrote:
> > > > > Hi Jisheng,
> > > >
> > > > Hi Baoquan,
> > > >
> > > > >
> > > > > On 12/07/21 at 12:05am, Jisheng Zhang wrote:
> > > > > > Replace the conditional compilation using "#ifdef CONFIG_KEXEC_CORE"
> > > > > > by a check for "IS_ENABLED(CONFIG_KEXEC_CORE)", to simplify the code
> > > > > > and increase compile coverage.
> > > > >
> > > > > I go through this patchset, You mention the benefits it brings are
> > > > > 1) simplity the code;
> > > > > 2) increase compile coverage;
> > > > >
> > > > > For benefit 1), it mainly removes the dummy function in x86, arm and
> > > > > arm64, right?
> > > >
> > > > Another benefit: remove those #ifdef #else #endif usage. Recently, I
> > > > fixed a bug due to lots of "#ifdefs":
> > > > http://lists.infradead.org/pipermail/linux-riscv/2021-December/010607.html
> > >
> > > Glad to know the fix. While, sometime the ifdeffery is necessary. I am
> > > sorry about the one in riscv and you have fixed, it's truly a bug . But,
> > > the increasing compile coverage at below you tried to make, it may cause
> > > issue. Please see below my comment.
> > >
> > > >
> > > > >
> > > > > For benefit 2), increasing compile coverage, could you tell more how it
> > > > > achieves and why it matters? What if people disables CONFIG_KEXEC_CORE in
> > > > > purpose? Please forgive my poor compiling knowledge.
> > > >
> > > > Just my humble opinion, let's compare the code::
> > > >
> > > > #ifdef CONFIG_KEXEC_CORE
> > > >
> > > > code block A;
> > > >
> > > > #endif
> > > >
> > > > If KEXEC_CORE is disabled, code block A won't be compiled at all, the
> > > > preprocessor will remove code block A;
> > > >
> > > > If we convert the code to:
> > > >
> > > > if (IS_ENABLED(CONFIG_KEXEC_CORE)) {
> > > >       code block A;
> > > > }
> > > >
> > > > Even if KEXEC_CORE is disabled, code block A is still compiled.
> > >
> > > This is what I am worried about. Before, if CONFIG_KEXEC_CORE is
> > > unset, those relevant codes are not compiled in. I can't see what
> > > benefit is brought in if compiled in the unneeded code block. Do I miss
> > > anything?
> > >
> > 
> > This is explained in Documentation/process/coding-style.rst "21)
> > Conditional Compilation".
> 
> Thanks for the pointer, Alex.
> 
> I read that part, while my confusion isn't gone. With the current code,
> CONFIG_KEXEC_CORE is set,
>   - reserve_crashkernel_low() and reserve_crashkernel() compiled in.

Although the code block will be compiled, but the code block will be
optimized out.

> CONFIG_KEXEC_CORE is unset,
>   - reserve_crashkernel_low() and reserve_crashkernel() compiled out. 
> 
> After this patch applied, does it have the same effect as the old code?

I compared the .o, and can confirm they acchieve the same effect.

> 
> arch/x86/kernel/setup.c:
> 
> before
> ======
> #ifdef CONFIG_KEXEC_CORE
> static int __init reserve_crashkernel_low(void)
> {
> 	......
> }
> static void __init reserve_crashkernel(void)
> {
> 	......
> }
> #else
> static void __init reserve_crashkernel(void)
> {
> }
> #endif
> 
> after
> =======
> static int __init reserve_crashkernel_low(void)
> {
> 	......
> }
> static void __init reserve_crashkernel(void)
> {
> 	......
> 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
>                 return;
> 	......
> }
> 
