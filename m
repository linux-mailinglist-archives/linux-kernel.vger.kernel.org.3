Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED9D5AF369
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 20:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiIFSOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 14:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIFSOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 14:14:42 -0400
X-Greylist: delayed 112 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Sep 2022 11:14:39 PDT
Received: from condef-05.nifty.com (condef-05.nifty.com [202.248.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263EF10FFC;
        Tue,  6 Sep 2022 11:14:37 -0700 (PDT)
Received: from conssluserg-02.nifty.com ([10.126.8.81])by condef-05.nifty.com with ESMTP id 286I9XYv018478;
        Wed, 7 Sep 2022 03:09:33 +0900
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 286I9DXU016423;
        Wed, 7 Sep 2022 03:09:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 286I9DXU016423
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662487754;
        bh=XoFOHD9hbfQLitaVdmtOBiY1QAcAg6OYZ0EoW2xUSHA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WMwxm1JUj1lG/kQzHh5Sz9awcHy9K1v98hp/4lyt1vUyP0UKVJCW4L0GauxmCQxbn
         GNRZj6DH3bzCtYVVklQW8MxvU8AHPdvvOrTwwEysvpcuV0laa0wlxtCnMgckbeeDnX
         bNcNpGZZp+cXOJ3I7ovTfX/P2NDLbtOxCFda980oiasxRY11+0tJveu5oXVDgyqudx
         niQ0wTph0WLrfqw8iFiDglpoD7EAJzPg+AigwdRA+KFtgauqP+n6xP/MNnd2MzQ5EJ
         j4v+GbYloXECi+hLObeNR3kxf00FKMiyspWsHOeKAtoW437H+tsxoUe0+d0IIwSVcY
         hi8kVGESaB8VA==
X-Nifty-SrcIP: [209.85.160.43]
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1279948d93dso10350444fac.10;
        Tue, 06 Sep 2022 11:09:13 -0700 (PDT)
X-Gm-Message-State: ACgBeo0Ri2tsOAV4Wx2jcGjBYD+VK65Hcqhrka+srB5uAP6fLR95jIsZ
        SCitBHBQ3yhSLlgecEoslTRmETTGOsNrue7dP/E=
X-Google-Smtp-Source: AA6agR67hGgf/nFls5Uj5NNQqrAJqhoj1q8j3XR+NtYCIBRN/6y6H7r8K0+yijxj8XiOimNwtU619t+k+s5yxf+KSSk=
X-Received: by 2002:a05:6870:f626:b0:10d:a798:f3aa with SMTP id
 ek38-20020a056870f62600b0010da798f3aamr12376388oab.194.1662487752576; Tue, 06
 Sep 2022 11:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220802015052.10452-1-ojeda@kernel.org> <20220802015052.10452-28-ojeda@kernel.org>
In-Reply-To: <20220802015052.10452-28-ojeda@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 7 Sep 2022 03:08:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNARTX+2Z=pnGbbUepxskE+KZ1f5YsfQukJ88ijPBQt9_GA@mail.gmail.com>
Message-ID: <CAK7LNARTX+2Z=pnGbbUepxskE+KZ1f5YsfQukJ88ijPBQt9_GA@mail.gmail.com>
Subject: Re: [PATCH v8 27/31] Kbuild: add Rust support
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
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
        David Gow <davidgow@google.com>,
        Tiago Lam <tiagolam@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>,
        linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 10:53 AM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> Having all the new files in place, we now enable Rust support
> in the build system, including `Kconfig` entries related to Rust,
> the Rust configuration printer, the target specification
> generation script, the version detection script and a few
> other bits.
>
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Finn Behrens <me@kloenk.de>
> Signed-off-by: Finn Behrens <me@kloenk.de>
> Co-developed-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> Signed-off-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Co-developed-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Co-developed-by: Sven Van Asbroeck <thesven73@gmail.com>
> Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Co-developed-by: Boris-Chengbiao Zhou <bobo1239@web.de>
> Signed-off-by: Boris-Chengbiao Zhou <bobo1239@web.de>
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Co-developed-by: Douglas Su <d0u9.su@outlook.com>
> Signed-off-by: Douglas Su <d0u9.su@outlook.com>
> Co-developed-by: Dariusz Sosnowski <dsosnowski@dsosnowski.pl>
> Signed-off-by: Dariusz Sosnowski <dsosnowski@dsosnowski.pl>
> Co-developed-by: Antonio Terceiro <antonio.terceiro@linaro.org>
> Signed-off-by: Antonio Terceiro <antonio.terceiro@linaro.org>
> Co-developed-by: Daniel Xu <dxu@dxuuu.xyz>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> Co-developed-by: Miguel Cano <macanroj@gmail.com>
> Signed-off-by: Miguel Cano <macanroj@gmail.com>
> Co-developed-by: David Gow <davidgow@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> Co-developed-by: Tiago Lam <tiagolam@gmail.com>
> Signed-off-by: Tiago Lam <tiagolam@gmail.com>
> Co-developed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> Signed-off-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> Co-developed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  .gitignore                                   |   6 +
>  .rustfmt.toml                                |  12 +
>  Makefile                                     | 172 +++++++-
>  arch/Kconfig                                 |   6 +
>  arch/arm/Kconfig                             |   1 +
>  arch/arm64/Kconfig                           |   1 +
>  arch/powerpc/Kconfig                         |   1 +
>  arch/riscv/Kconfig                           |   1 +
>  arch/riscv/Makefile                          |   5 +
>  arch/um/Kconfig                              |   1 +
>  arch/x86/Kconfig                             |   1 +
>  arch/x86/Makefile                            |  10 +
>  include/linux/compiler_types.h               |   6 +-
>  init/Kconfig                                 |  46 +-
>  lib/Kconfig.debug                            |  82 ++++
>  rust/.gitignore                              |  10 +
>  rust/Makefile                                | 415 +++++++++++++++++++
>  rust/bindgen_parameters                      |  21 +
>  scripts/.gitignore                           |   1 +
>  scripts/Kconfig.include                      |   6 +-
>  scripts/Makefile                             |   3 +
>  scripts/Makefile.build                       |  60 +++
>  scripts/Makefile.debug                       |  10 +
>  scripts/Makefile.host                        |  34 +-
>  scripts/Makefile.lib                         |  12 +
>  scripts/Makefile.modfinal                    |   8 +-
>  scripts/cc-version.sh                        |  12 +-
>  scripts/generate_rust_target.rs              | 232 +++++++++++
>  scripts/is_rust_module.sh                    |  16 +
>  scripts/kconfig/confdata.c                   |  75 ++++
>  scripts/min-tool-version.sh                  |   6 +
>  scripts/rust-is-available-bindgen-libclang.h |   2 +
>  scripts/rust-is-available.sh                 | 160 +++++++
>  33 files changed, 1408 insertions(+), 26 deletions(-)
>  create mode 100644 .rustfmt.toml
>  create mode 100644 rust/.gitignore
>  create mode 100644 rust/Makefile
>  create mode 100644 rust/bindgen_parameters
>  create mode 100644 scripts/generate_rust_target.rs
>  create mode 100755 scripts/is_rust_module.sh
>  create mode 100644 scripts/rust-is-available-bindgen-libclang.h
>  create mode 100755 scripts/rust-is-available.sh
>






> @@ -151,7 +162,8 @@ config WERROR
>         default COMPILE_TEST
>         help
>           A kernel build should not cause any compiler warnings, and this
> -         enables the '-Werror' flag to enforce that rule by default.
> +         enables the '-Werror' (for C) and '-Dwarnings' (for Rust) flags
> +         to enforce that rule by default.
>
>           However, if you have a new (or very old) compiler with odd and
>           unusual warnings, or you have some architecture with problems,
> @@ -1898,6 +1910,38 @@ config PROFILING
>           Say Y here to enable the extended profiling support mechanisms =
used
>           by profilers.
>
> +config RUST
> +       bool "Rust support"
> +       depends on HAVE_RUST
> +       depends on RUST_IS_AVAILABLE
> +       depends on !MODVERSIONS
> +       depends on !GCC_PLUGINS
> +       depends on !RANDSTRUCT
> +       depends on !DEBUG_INFO_BTF
> +       select CONSTRUCTORS
> +       help
> +         Enables Rust support in the kernel.
> +
> +         This allows other Rust-related options, like drivers written in=
 Rust,
> +         to be selected.
> +
> +         It is also required to be able to load external kernel modules
> +         written in Rust.
> +
> +         See Documentation/rust/ for more information.
> +
> +         If unsure, say N.
> +
> +config RUSTC_VERSION_TEXT
> +       string
> +       depends on RUST
> +       default $(shell,command -v $(RUSTC) >/dev/null 2>&1 && $(RUSTC) -=
-version || echo n)
> +
> +config BINDGEN_VERSION_TEXT
> +       string
> +       depends on RUST
> +       default $(shell,command -v $(BINDGEN) >/dev/null 2>&1 && $(BINDGE=
N) --version || echo n)
> +



Where are these config options used?


I grep'ed but no hit.


masahiro@zoe:~/ref/linux-next$ git grep RUSTC_VERSION_TEXT
init/Kconfig:config RUSTC_VERSION_TEXT
masahiro@zoe:~/ref/linux-next$ git grep BINDGEN_VERSION_TEXT
init/Kconfig:config BINDGEN_VERSION_TEXT



> --
> 2.37.1
>


--
Best Regards
Masahiro Yamada
