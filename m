Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5874B377D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 19:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiBLS5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 13:57:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiBLS5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:57:19 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F0F6007A;
        Sat, 12 Feb 2022 10:57:15 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id y84so15462593iof.0;
        Sat, 12 Feb 2022 10:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PW5bHK7lbz8mAfQVLbpabS9JQmvxuuP5i13vS9JUmWQ=;
        b=n5D8bwCKZRUGpl68+OwDfJK+AQroTXijhLf+Ev2Dbodadyb6WRz6/fX9TzoLv5JY44
         vKXzGhsqvNG0b1NNUEa1R2yJntFRgZVvW8w2wrpRBfSWda7h6ZxvPtJrBrf7yYHVOrwG
         vAfadKq2gwnHNR05HepbxldrYBHyblxQyutjIhO/hkKuz8jVpizo184RCyuaFwUdEEMB
         gDMdiJYy6LOQ+V5N1zvv/KQitEvAl4D/B6TT8xoaot76ok9JaRjP2+PcQoyjgjVx3f6a
         lXTyQk2kypAbwHMmpvW3hdXfwbXpl8GXVhdG++7HxqqIr3Iu7+Tp6uJUOhRFTYsDQXUJ
         gPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PW5bHK7lbz8mAfQVLbpabS9JQmvxuuP5i13vS9JUmWQ=;
        b=ifwJDKTuDW61XfQ4Zj/fUYTgvSwgDFYp8LdRjp2HkMr3YKISmpmqUKnqnpTpMLuCez
         tn/11jwSk/upfauLB53HtS3WH870IeH8KVRk5yu67uOhcS8zjUDKOQcfWGJhdzNH0MU2
         cdT+x5HT4NGKxfS1s+TxhzYd44CLBKgouq7dzAfpRRUCwPo7JKtb7KcA5xB1yU7kd2nd
         XUnrvSHQTkELu3eNtR6WOgcYL12l0lOH8QcIMqcG00kgIc/xiJoJI8ubavwcHAskPZnr
         uIvyo2tPxl2OLASHokVSkunCpn5kYKBmGV3mEa9ZU4eonY5SoYS1S2Or4binrNCkmLQe
         uz9g==
X-Gm-Message-State: AOAM531monzUkjtiQqsqJkSuJyqkLrXAuPqQ10lUtj5riqQXkBiUBOEv
        ro0b/Bntkhj+jrPh8G9xM0yDOkBYIB5p/jhsb0g=
X-Google-Smtp-Source: ABdhPJzk7Y0eW6BAf4q+QY2CyD1I+LhA8kHRLDkHhRJc6kXcI3wPehj/4lCy3W2LRh5ctFx5JYUIvMk52bxjHJ2CH2Q=
X-Received: by 2002:a5d:941a:: with SMTP id v26mr3564701ion.64.1644692234068;
 Sat, 12 Feb 2022 10:57:14 -0800 (PST)
MIME-Version: 1.0
References: <20220212130410.6901-17-ojeda@kernel.org> <0396e38b-f681-a035-b6ea-21127fdf5615@physik.fu-berlin.de>
In-Reply-To: <0396e38b-f681-a035-b6ea-21127fdf5615@physik.fu-berlin.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 12 Feb 2022 19:57:02 +0100
Message-ID: <CANiq72=U3A-5LfbOThPoex9PfFg+UsHuMY33nbtLH=aK=odh0Q@mail.gmail.com>
Subject: Re: [PATCH v4 16/20] Kbuild: add Rust support
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Douglas Su <d0u9.su@outlook.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Daniel Xu <dxu@dxuuu.xyz>, Gary Guo <gary@garyguo.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        =?UTF-8?B?TWlndWVsIENhw7Fv?= <macanroj@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Finn Behrens <me@kloenk.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Paul Mackerras <paulus@samba.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Will Deacon <will@kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
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

Hi John Paul,

On Sat, Feb 12, 2022 at 7:27 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Is there any particular reason why this list excludes MIPS*, i386, big-endian
> PowerPC and SPARC targets which are already supported by the Rust programming
> language?

The variations we have so far were intended to showcase the Rust
support in several major architectures, rather than cover everything.
But as long as LLVM (& the kernel, i.e. ClangBuiltLinux) supports the
target (and as long there are no compiler/toolchain issues), you
should be able to try it.

> Are the arch/$ARCH/rust/target.json files everything that's needed for supporting
> the other targets?

Mostly -- there is also `rust/kernel/c_types.rs` and you may need to
tweak `rust/compiler_builtins.rs`, but not much more.

Note that for the target spec files, the short-term plan is to
generate dynamically the target spec file according to what the
architecture requests, instead of using these static files. Longer
term, we need a Rust-stable way to setup custom targets from upstream
`rustc` (though it is not clear yet how it will look, e.g. it could be
via command-line flags).

Cheers,
Miguel
