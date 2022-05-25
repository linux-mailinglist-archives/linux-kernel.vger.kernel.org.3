Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304E253466C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 00:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344504AbiEYWZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 18:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235218AbiEYWZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 18:25:44 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94206BA9A0
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 15:25:42 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q1so16332896ljb.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 15:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y4JE5dVY5pJ4L5p/4sGg1xocj3NSEFAKSZJJs4bfl50=;
        b=fAMfron/HjbN7nd+bsG3ASO/nK1WjlcoVqa4+QdtPam6ciW/bwdYCmk9ujS4Abe4VJ
         w2sueG/5d5jh11UgLmuXnMAdarDjSChSdXdKrhg3y7F8Pjptb4ff8WlByIdiSkfEbGFm
         PkRmC+09uBSPSsg344wCJdI8n7v1Yt+vr7kQ9DePitEy6ui34PJ0AU8C5jZKRsffEDfP
         ug3LM0AmYwwUZHhVNWlMxQzBz79rShyO1d1dkhvX1r4lmvgXBfWQm+lShZOQXq9rxarC
         SWsS9kfyfYspj/5U44fShRnUcSFmlbceeiOtALpaquQdvDHDNyVkshBPqlQYpF3P0oqm
         UHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y4JE5dVY5pJ4L5p/4sGg1xocj3NSEFAKSZJJs4bfl50=;
        b=3G5sJhnsj23Tt1bqda6KKEk8865TF+VKQXlhJ9RiKf+SFDpZZPIWqtNmvkhg9ITh9L
         e3SKycoxCBATqrBI4bjYNIjIOF1ojP+mPn3gYSSwdR7hj8K7JZ6DesulXdjViJhpk6/z
         OTELInC6QuWdlYsNKEzuGaRlnrYbGrf+47p95ho9odD666tKsu6I/4QIeLIYCCGLb+9m
         K4np2z5Fp8gg0gvPvjyZSjDIJzdvtQswCxpIEWUeFI/gWUCCdktc4B0SnUP+Os4CQycG
         m6AGaEz9hbux+5jVgKvMiP3q/6LefM3hF13Cv8I+xofM0j+s+qe2/Hlb2laOw6UUGA4N
         yL+w==
X-Gm-Message-State: AOAM5328QQ3EXWpmBxi7NjosNTRtjApwlDvdD13aBwYOc+Zjc+c77kZe
        4nk/gtOX82GwXr0s8XckFmgPNWcXEBJq8VHoNFwEUA==
X-Google-Smtp-Source: ABdhPJyyMkDOBVLKOsbECK6J7ZWww0BuYU20TDN6fYXnxk8xptFKTQXny9GfJRyE8hkAsArQFcu6jZmKOkIJSKODNlQ=
X-Received: by 2002:a2e:98c3:0:b0:253:e0e1:20 with SMTP id s3-20020a2e98c3000000b00253e0e10020mr14949440ljj.26.1653517540546;
 Wed, 25 May 2022 15:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220523020209.11810-1-ojeda@kernel.org> <20220523020209.11810-22-ojeda@kernel.org>
In-Reply-To: <20220523020209.11810-22-ojeda@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 25 May 2022 15:25:28 -0700
Message-ID: <CAKwvOdn+9qORm8UpDGnPXxiK7B7P_TW5CtXv1+8qkv7UvQr3hQ@mail.gmail.com>
Subject: Re: [PATCH v7 21/25] Kbuild: add Rust support
To:     Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
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
        Michal Marek <michal.lkml@markovi.net>,
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
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kbuild@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 7:04 PM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> --- a/Makefile
> +++ b/Makefile
> @@ -120,6 +120,15 @@ endif
>
>  export KBUILD_CHECKSRC
>
> +# Enable "clippy" (a linter) as part of the Rust compilation.
> +#
> +# Use 'make CLIPPY=1' to enable it.
> +ifeq ("$(origin CLIPPY)", "command line")
> +  KBUILD_CLIPPY := $(CLIPPY)
> +endif

Is there a reason to not just turn clippy on always? Might be nicer to
start off with good practices by default. :^)

> @@ -1494,7 +1588,8 @@ MRPROPER_FILES += include/config include/generated          \
>                   certs/signing_key.pem \
>                   certs/x509.genkey \
>                   vmlinux-gdb.py \
> -                 *.spec
> +                 *.spec \
> +                 rust/target.json rust/libmacros.so
>
>  # clean - Delete most, but leave enough to build external modules
>  #
> @@ -1519,6 +1614,9 @@ $(mrproper-dirs):
>
>  mrproper: clean $(mrproper-dirs)
>         $(call cmd,rmfiles)
> +       @find . $(RCS_FIND_IGNORE) \
> +               \( -name '*.rmeta' \) \
> +               -type f -print | xargs rm -f

Are there *.rmeta directories that we _don't_ want to remove via `make
mrproper`? I'm curious why *.rmeta isn't just part of MRPROPER_FILES?

>
>  # distclean
>  #
> @@ -1606,6 +1704,23 @@ help:
>         @echo  '  kselftest-merge   - Merge all the config dependencies of'
>         @echo  '                      kselftest to existing .config.'
>         @echo  ''
> +       @echo  'Rust targets:'
> +       @echo  '  rustavailable   - Checks whether the Rust toolchain is'
> +       @echo  '                    available and, if not, explains why.'
> +       @echo  '  rustfmt         - Reformat all the Rust code in the kernel'
> +       @echo  '  rustfmtcheck    - Checks if all the Rust code in the kernel'
> +       @echo  '                    is formatted, printing a diff otherwise.'
> +       @echo  '  rustdoc         - Generate Rust documentation'
> +       @echo  '                    (requires kernel .config)'
> +       @echo  '  rusttest        - Runs the Rust tests'
> +       @echo  '                    (requires kernel .config; downloads external repos)'
> +       @echo  '  rust-analyzer   - Generate rust-project.json rust-analyzer support file'
> +       @echo  '                    (requires kernel .config)'
> +       @echo  '  dir/file.[os]   - Build specified target only'
> +       @echo  '  dir/file.i      - Build macro expanded source, similar to C preprocessing'
> +       @echo  '                    (run with RUSTFMT=n to skip reformatting if needed)'
> +       @echo  '  dir/file.ll     - Build the LLVM assembly file'

I don't think we need to repeat dir/* here again for rust. The
existing targets listed above (outside this hunk) make sense in both
contexts.

Does rustc really use .i as a conventional suffix for macro expanded
sources? (The C compiler might use the -x flag to override the guess
it would make based on the file extension; I'm curious if rustc can
ingest .i files or will it warn?)

> diff --git a/init/Kconfig b/init/Kconfig
> index ddcbefe535e9..3457cf596588 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> +config RUSTC_VERSION_TEXT
> +       string
> +       depends on RUST
> +       default $(shell,command -v $(RUSTC) >/dev/null 2>&1 && $(RUSTC) --version || echo n)
> +
> +config BINDGEN_VERSION_TEXT
> +       string
> +       depends on RUST
> +       default $(shell,command -v $(BINDGEN) >/dev/null 2>&1 && $(BINDGEN) --version || echo n)

Are these two kconfigs used anywhere?

> diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
> index 0496efd6e117..83e850321eb6 100644
> --- a/scripts/Kconfig.include
> +++ b/scripts/Kconfig.include
> @@ -36,12 +36,12 @@ ld-option = $(success,$(LD) -v $(1))
>  as-instr = $(success,printf "%b\n" "$(1)" | $(CC) $(CLANG_FLAGS) -c -x assembler -o /dev/null -)
>
>  # check if $(CC) and $(LD) exist
> -$(error-if,$(failure,command -v $(CC)),compiler '$(CC)' not found)
> +$(error-if,$(failure,command -v $(CC)),C compiler '$(CC)' not found)

Not that it's important to do so, but a couple hunks s/compiler/C
compiler/. Those _could_ probably get submitted ahead of this, but not
important to do so.

> diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
> index 9f39b0130551..fe87389d52c0 100644
> --- a/scripts/Makefile.debug
> +++ b/scripts/Makefile.debug
> @@ -1,4 +1,5 @@
>  DEBUG_CFLAGS   :=
> +DEBUG_RUSTFLAGS        :=
>
>  ifdef CONFIG_DEBUG_INFO_SPLIT
>  DEBUG_CFLAGS   += -gsplit-dwarf
> @@ -10,6 +11,12 @@ ifndef CONFIG_AS_IS_LLVM
>  KBUILD_AFLAGS  += -Wa,-gdwarf-2
>  endif
>
> +ifdef CONFIG_DEBUG_INFO_REDUCED
> +DEBUG_RUSTFLAGS += -Cdebuginfo=1
> +else
> +DEBUG_RUSTFLAGS += -Cdebuginfo=2
> +endif
> +

How does enabling or disabling debug info work for rustc? I may have
missed it, but I was surprised to see no additional flags getting
passed to rustc based on CONFIG_DEBUG info.

> diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_target.rs
> new file mode 100644
> index 000000000000..c146a3407183
> --- /dev/null
> +++ b/scripts/generate_rust_target.rs

Ah, that explains the host rust build infra.  Bravo! Hard coding the
target files was my major concern last I looked at the series. I'm
very happy to see it be generated properly from .config!

I haven't actually reviewed this yet, but it makes me significantly
more confident in the series to see this approach added. Good job
whoever wrote this.

> diff --git a/scripts/is_rust_module.sh b/scripts/is_rust_module.sh
> new file mode 100755
> index 000000000000..277a64d07f22
> --- /dev/null
> +++ b/scripts/is_rust_module.sh
> @@ -0,0 +1,13 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# is_rust_module.sh module.ko
> +#
> +# Returns `0` if `module.ko` is a Rust module, `1` otherwise.
> +
> +set -e
> +
> +# Using the `16_` prefix ensures other symbols with the same substring
> +# are not picked up (even if it would be unlikely). The last part is
> +# used just in case LLVM decides to use the `.` suffix.
> +${NM} "$*" | grep -qE '^[0-9a-fA-F]+ r _R[^[:space:]]+16___IS_RUST_MODULE[^[:space:]]*$'

Does `$(READELF) -p .comment foo.o` print anything about which
compiler was used? That seems less brittle IMO.

---

Modulo the RUST_OPT_LEVEL_SIMILAR_AS_CHOSEN_FOR_C which I'm not a fan
of, this is looking good to me. Masahiro, what are your thoughts on
the build system support?
-- 
Thanks,
~Nick Desaulniers
