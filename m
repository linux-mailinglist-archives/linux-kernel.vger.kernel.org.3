Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676514B3659
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 17:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237145AbiBLQTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 11:19:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiBLQTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 11:19:20 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0E4197;
        Sat, 12 Feb 2022 08:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5ps4Dpti6anPMML5DYvmxj3DVlK84HL9lrfnW5s1I7I=; b=diiOuL6v4zmcZFLQ7gZZaN9BB3
        oDxx5cZ30Fmaus1PFKW31N94BRa5pvI/DafyMb9VxVulw7aS/gMckVjYHQ7s7OAlMPCE4bju0hX9h
        +0QSM40rREXJOCDBrR7c09iOuvhD8ZQuCjYGZVhY8cH6Ura2HLhIE6F8e5vYXv7gflZ0F13Fpzxzb
        XVLT87dmvRb0/gKrvbW0sWa4oAK4TQwDrClnIfQFTSAWOlw5TzdIEduy8X+sHLA8uJ5gcpcID/FpB
        Ic0xkLP47aZfK0t7aYD9o2WLBAsMaBfxnD1ZljA3Xj9iHMxzFRDbqcc/oEEuW0b8IVnn61sBFAZwD
        fN6oGatg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57218)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nIv75-0008Hc-BQ; Sat, 12 Feb 2022 16:19:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nIv6x-0004fN-8O; Sat, 12 Feb 2022 16:18:59 +0000
Date:   Sat, 12 Feb 2022 16:18:59 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Douglas Su <d0u9.su@outlook.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Daniel Xu <dxu@dxuuu.xyz>, Miguel Cano <macanroj@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 16/20] Kbuild: add Rust support
Message-ID: <Ygfd82QN/wmSmlHa@shell.armlinux.org.uk>
References: <20220212130410.6901-1-ojeda@kernel.org>
 <20220212130410.6901-17-ojeda@kernel.org>
 <YgfBUhYdLXA46kOX@shell.armlinux.org.uk>
 <CANiq72nMhUH1s0HMeLb+hfp5=u3h20ryC4uqAgB1Znuq52e=Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72nMhUH1s0HMeLb+hfp5=u3h20ryC4uqAgB1Znuq52e=Pw@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 04:47:33PM +0100, Miguel Ojeda wrote:
> Hi Russell,
> 
> On Sat, Feb 12, 2022 at 3:17 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > Please don't use CPU_32v6* here.
> >
> > It probably makes more sense to add a symbol "HAVE_RUST" and have the
> > appropriate architecture Kconfig files select HAVE_RUST.
> 
> We can do it whatever way arch maintainers prefer, of course. Why
> would you prefer one over the other?

It would be cleaner, rather than the "depends" line getting longer
and longer over time - and if different architecture maintainers
change it, it will lead to conflicts.

> > Does Rust support Thumb on ARMv6 and ARMv7 architectures?
> 
> Yes, the main backend is LLVM. Some built-in targets and their support
> level are listed here, if you want to take a look:

Right, so why made it dependent on CPU_32v6 || CPU_32v6K if ARMv7 is
supported? What about CPU_32v7? What about CPU_32v7M?

I think it would be saner to use the CPU_V6, CPU_V6K, CPU_V7 and maybe
CPU_V7M here - even bettern to select "HAVE_RUST" from these symbols,
since I'm sure you'd start to see the issue behind my "HAVE_RUST"
suggestion as it means having four symbols just for 32-bit ARM on your
dependency line.

>     https://doc.rust-lang.org/nightly/rustc/platform-support.html

Interestingly, it does not list arm-unknown-linux-gnueabihf, which
is the "tuple" commonly used to build 32-bit ARM kernels. 

> > Please remove every utterance of "default n" from your patch; n is the
> > default default which default defaults to, so you don't need to specify
> > default n to make the option default to n. It will default to n purely
> > because n is the default when no default is specified.
> 
> Certainly. I am curious, though: is there a reason for most of the
> other 500+ instances in the kernel tree?

Probably because people incorrectly think it's required or some other
minor reason. As I say:

config FOO
	bool/tristate ...

always defaults to 'n' without needing "default n" to be specified.

Let's do some proper research on this. There are 19148 "config"
statements in the kernel tree, 521 "default n" and 4818 that
specify any kind of "default". That means there are about 14330
config statements that do not specify any kind of default.

So, there are about 27 times more config statements that specify no
default than those that specify "default n", so using the argument
that there are "500+ instances" and therefore should be seen as
correct is completely misguided.

> > As Rust doesn't support all the architectures that the kernel supports,
> > Rust must not be used for core infrastructure.
> 
> Yeah, although I am not sure I understand what you are getting at here.

I mean, if we end up with, e.g. a filesystem coded in Rust, that
filesystem will not be available on architectures that the kernel
supports until either (a) Rust gains support for that architecture
or (b) someone re-codes the filesystem in C - at which point, what
is the point of having Rust in the kernel?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
