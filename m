Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9164B3767
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 19:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiBLSc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 13:32:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiBLSc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:32:26 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A35D6007E;
        Sat, 12 Feb 2022 10:32:22 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id q204so15308898iod.8;
        Sat, 12 Feb 2022 10:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ZU/xBo4v5syghhPRoThoLn4tvhr/EqUMFObZCi2t6k=;
        b=Kd9daEZTG01vUunj9KpOq4Tlqe0AR4jwzTryhBoDOCJdLk42Frgjx5QOJZwOdTvdN+
         5w6brYZzwx55wGfNgrwE5v2ZviNe+FwzOcEXZPCCTgxQWcbXWgChRoh9HLPVEVDETjmk
         d9NsqcqbTXHDOtZwjLE4n7UUOIUFvneVQT9KKksB5OsjSpk+CJtKwm0ffErWL3d2MpWN
         On531QRK/Woo9hRSZ7uKcmAR96JfoYJd8xqRGQzqkPPWOgOCuepjsbD/2jefhJ/MmnQc
         IukF4P2PM+zgNqEx4bpvhAl9Kl8kSD/iYMM6o+K44UEiQElLwa5b9FHlYd9VVslmOe1J
         G1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ZU/xBo4v5syghhPRoThoLn4tvhr/EqUMFObZCi2t6k=;
        b=5XNTylL2/JaBwvZWdNDikJycYOa8m3ncQRkr4B/+LESzc6bi59LRu8bY8pdQ/ioAqG
         9ZLv/JPczqx0W7dnBEeKQAa7x2N1QtZajx+yOmu+bc+dyHNerN3uDqYllHDKC+9ozbFs
         qWpE9Z+5cU8InhNicm4/H96+/Q9x2M5e6V80BLL64tiyqNnSct31Go3+0N+CpRamoiLj
         eoTtfvv1q296tgbHOLYxLnKB3AA/6eEmWu+1vu1oTjUqq+Hla3pK9jFVvsNK5E4RWW1a
         LOCZGfxJ9zduFoMe+0ilYQW1R3LMw+3k/ZIZqrWP2Tse/Srf89BS4k1c4Tec+0JtLSUv
         8u/w==
X-Gm-Message-State: AOAM53222kuZ/i6i89ntilOVGSXOtOGRl/3armkI7oQuN1q1Zcb4TIx4
        5OhaQDWkKu2iKHqeHpujAHYoZVwpSXxG7LI+3eA=
X-Google-Smtp-Source: ABdhPJxhKfrcH+lK8uelMajrMeOApGW6jMfAwT6cR0dIvA+JEuKlkp7IRqBjao43DlOrigol+LGAzUNojko+nvrOueg=
X-Received: by 2002:a05:6638:4105:: with SMTP id ay5mr4155184jab.186.1644690741790;
 Sat, 12 Feb 2022 10:32:21 -0800 (PST)
MIME-Version: 1.0
References: <20220212130410.6901-1-ojeda@kernel.org> <20220212130410.6901-17-ojeda@kernel.org>
 <YgfBUhYdLXA46kOX@shell.armlinux.org.uk> <CANiq72nMhUH1s0HMeLb+hfp5=u3h20ryC4uqAgB1Znuq52e=Pw@mail.gmail.com>
 <Ygfd82QN/wmSmlHa@shell.armlinux.org.uk>
In-Reply-To: <Ygfd82QN/wmSmlHa@shell.armlinux.org.uk>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 12 Feb 2022 19:32:10 +0100
Message-ID: <CANiq72mdru-MyP_QoRSpKu1bhB8v5sZNs8mvGdWsJp7NfXE+bQ@mail.gmail.com>
Subject: Re: [PATCH v4 16/20] Kbuild: add Rust support
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 5:19 PM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> Right, so why made it dependent on CPU_32v6 || CPU_32v6K if ARMv7 is
> supported? What about CPU_32v7? What about CPU_32v7M?
>
> I think it would be saner to use the CPU_V6, CPU_V6K, CPU_V7 and maybe
> CPU_V7M here - even bettern to select "HAVE_RUST" from these symbols,
> since I'm sure you'd start to see the issue behind my "HAVE_RUST"
> suggestion as it means having four symbols just for 32-bit ARM on your
> dependency line.

To support arch variations properly we also have to configure the
compiler via filling a target spec on the fly, but so far we only have
a few static variations as an example. This is one of the missing
parts of the arch support. I will let you know when we have something
ready.

> Interestingly, it does not list arm-unknown-linux-gnueabihf, which
> is the "tuple" commonly used to build 32-bit ARM kernels.

I see it there (Tier 2).

> Probably because people incorrectly think it's required or some other
> minor reason. As I say:

In that case, we should remove them and warn about those instances,
assuming the preferred style is to not have it.

> so using the argument
> that there are "500+ instances" and therefore should be seen as
> correct is completely misguided.

I did not use any such argument.

> I mean, if we end up with, e.g. a filesystem coded in Rust, that
> filesystem will not be available on architectures that the kernel

As long as that filesystem is an optional feature (or as long as there
is a C version), it should be fine.

> supports until either (a) Rust gains support for that architecture

For this, it would be ideal if entities behind some of the
architectures could support LLVM & ClangBuiltLinux, or the GCC Rust
frontend, or the GCC backend for `rustc`.

For instance, Arm is supporting both LLVM and the Rust project.

> or (b) someone re-codes the filesystem in C - at which point, what
> is the point of having Rust in the kernel?

Having a C version of some system does not mean a Rust version would
not offer advantages. In fact, we are adding Rust precisely because we
believe it offers some advantages over C, for both end users and
maintainers.

(Please see the RFC [1], previous discussions, etc.)

[1] https://lore.kernel.org/lkml/20210414184604.23473-1-ojeda@kernel.org/

Cheers,
Miguel
