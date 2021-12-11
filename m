Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080E147148F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 16:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhLKPyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 10:54:22 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:60356 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhLKPyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 10:54:21 -0500
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 1BBFrqFX005993;
        Sun, 12 Dec 2021 00:53:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 1BBFrqFX005993
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639238033;
        bh=OnB0zpwoAwMurjphUAtp8uU+9+JVaMiWORrcysltMaU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gI1mVLvBeXe/apHOHAlBFQKKIUgRxiEWdChVxDGJ4fsI3kuoC/PoDWNKkwQ8+l50n
         c56iYP9/3ByVZ+196VpisY+ULB2bhl//FFVjMc2YXSxNxgIcp11bJp/p7DG1YdkOAL
         KdBiI361kZcne82dy7u3JzuuY0xZVFZ5NeFIdF+OHT1uckpOSRdQ3f/8hTDamTbODX
         Z3FSxvIZXS0959YTasnF39B00jRaA9Apn7JguB4yMwEFSChIny8fLFabMnoRyqz/Hv
         nrudVqFcJewfqslEKj+iCnyqRz7uhnky2qbwaC//NXuA9b/cyfLRnQd4/dNq53Zg2r
         45qQLPFzt18/w==
X-Nifty-SrcIP: [209.85.215.175]
Received: by mail-pg1-f175.google.com with SMTP id s137so10601195pgs.5;
        Sat, 11 Dec 2021 07:53:53 -0800 (PST)
X-Gm-Message-State: AOAM532SG/1Z3Q+EcjODiwM/ZZSUX5zpbutxdnK8XjO6J9cmn+GECOcZ
        YrU3AxElk9RSD/UIQfNnPSGIQ773h5re2zbn1Pg=
X-Google-Smtp-Source: ABdhPJwA6pNPRGX5iwZZGN4tY0x/xzcZIrvvAqHfsVMVystJJYLcl9ZLHrzpACGiX8GG/s/ed1fgSYNEPYYNKm8NGt8=
X-Received: by 2002:a65:50c6:: with SMTP id s6mr45363550pgp.352.1639238032202;
 Sat, 11 Dec 2021 07:53:52 -0800 (PST)
MIME-Version: 1.0
References: <20211206140313.5653-1-ojeda@kernel.org> <20211206140313.5653-16-ojeda@kernel.org>
In-Reply-To: <20211206140313.5653-16-ojeda@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 12 Dec 2021 00:53:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS+eiL-kcdnNyyCUNWjV5qGxrw4PM-oJFfw=o1fbhc2qw@mail.gmail.com>
Message-ID: <CAK7LNAS+eiL-kcdnNyyCUNWjV5qGxrw4PM-oJFfw=o1fbhc2qw@mail.gmail.com>
Subject: Re: [PATCH 15/19] Kbuild: add Rust support
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 11:06 PM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> Having all the new files in place, we now enable Rust support
> in the build system, including `Kconfig` entries related to Rust,
> the Rust configuration printer, the target definition files,
> the version detection script and a few other bits.
>
> In the future, we will likely want to generate the target files
> on the fly via a script.
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
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  .gitignore                    |   5 +
>  .rustfmt.toml                 |  12 ++
>  Makefile                      | 146 +++++++++++++-
>  arch/arm/rust/target.json     |  27 +++
>  arch/arm64/rust/target.json   |  34 ++++
>  arch/powerpc/rust/target.json |  29 +++
>  arch/riscv/Makefile           |   1 +
>  arch/riscv/rust/rv32ima.json  |  36 ++++
>  arch/riscv/rust/rv32imac.json |  36 ++++
>  arch/riscv/rust/rv64ima.json  |  36 ++++
>  arch/riscv/rust/rv64imac.json |  36 ++++
>  arch/x86/rust/target.json     |  36 ++++
>  init/Kconfig                  |  31 ++-
>  lib/Kconfig.debug             | 144 ++++++++++++++
>  rust/.gitignore               |   7 +
>  rust/Makefile                 | 353 ++++++++++++++++++++++++++++++++++
>  rust/bindgen_parameters       |  13 ++
>  scripts/Makefile.build        |  22 +++
>  scripts/Makefile.debug        |  10 +
>  scripts/Makefile.lib          |  12 ++
>  scripts/Makefile.modfinal     |   8 +-
>  scripts/is_rust_module.sh     |  19 ++
>  scripts/kconfig/confdata.c    |  75 ++++++++
>  scripts/rust-version.sh       |  31 +++
>  24 files changed, 1147 insertions(+), 12 deletions(-)
>  create mode 100644 .rustfmt.toml
>  create mode 100644 arch/arm/rust/target.json
>  create mode 100644 arch/arm64/rust/target.json
>  create mode 100644 arch/powerpc/rust/target.json
>  create mode 100644 arch/riscv/rust/rv32ima.json
>  create mode 100644 arch/riscv/rust/rv32imac.json
>  create mode 100644 arch/riscv/rust/rv64ima.json
>  create mode 100644 arch/riscv/rust/rv64imac.json
>  create mode 100644 arch/x86/rust/target.json
>  create mode 100644 rust/.gitignore
>  create mode 100644 rust/Makefile
>  create mode 100644 rust/bindgen_parameters
>  create mode 100755 scripts/is_rust_module.sh
>  create mode 100755 scripts/rust-version.sh
>
> diff --git a/.gitignore b/.gitignore
> index 7afd412dadd2..48c68948f476 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -37,6 +37,7 @@
>  *.o
>  *.o.*
>  *.patch
> +*.rmeta
>  *.s
>  *.so
>  *.so.dbg
> @@ -96,6 +97,7 @@ modules.order
>  !.gitattributes
>  !.gitignore
>  !.mailmap
> +!.rustfmt.toml
>
>  #
>  # Generated include files
> @@ -161,3 +163,6 @@ x509.genkey
>
>  # Documentation toolchain
>  sphinx_*/
> +
> +# Rust analyzer configuration
> +/rust-project.json
> diff --git a/.rustfmt.toml b/.rustfmt.toml
> new file mode 100644
> index 000000000000..3de5cc497465
> --- /dev/null
> +++ b/.rustfmt.toml
> @@ -0,0 +1,12 @@
> +edition = "2021"
> +newline_style = "Unix"
> +
> +# Unstable options that help catching some mistakes in formatting and that we may want to enable
> +# when they become stable.
> +#
> +# They are kept here since they are useful to run from time to time.
> +#format_code_in_doc_comments = true
> +#reorder_impl_items = true
> +#comment_width = 100
> +#wrap_comments = true
> +#normalize_comments = true
> diff --git a/Makefile b/Makefile
> index 0a6ecc8bb2d2..0f20ca9bd723 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -120,6 +120,13 @@ endif
>
>  export KBUILD_CHECKSRC
>
> +# Enable "clippy" (a linter) as part of the Rust compilation.
> +#
> +# Use 'make CLIPPY=1' to enable it.
> +ifeq ("$(origin CLIPPY)", "command line")
> +  KBUILD_CLIPPY := $(CLIPPY)
> +endif

Do you really want to support CLIPPY=1
in addition to KBUILD_CLIPPY=1 ?

(Refer to C=  V=  M=  O=, which checks $(origin ) )



>
>  KBUILD_LDFLAGS_MODULE += --build-id=sha1
>  LDFLAGS_vmlinux += --build-id=sha1
> @@ -1095,6 +1163,11 @@ ifeq ($(KBUILD_EXTMOD),)
>  core-y                 += kernel/ certs/ mm/ fs/ ipc/ security/ crypto/
>  core-$(CONFIG_BLOCK)   += block/
>
> +# Keep this one as an `ifdef` block since its `Makefile` runs `rustc`.
> +ifdef CONFIG_RUST
> +core-y                 += rust/
> +endif



Is there any reason why
you did not write like

  core-$(CONFIG_RUST)  += rust/

?








> diff --git a/rust/.gitignore b/rust/.gitignore
> new file mode 100644
> index 000000000000..168cb26a31b9
> --- /dev/null
> +++ b/rust/.gitignore
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +bindings_generated.rs
> +bindings_helpers_generated.rs
> +exports_*_generated.h
> +doc/
> +test/
> diff --git a/rust/Makefile b/rust/Makefile
> new file mode 100644
> index 000000000000..2d08314e7031
> --- /dev/null
> +++ b/rust/Makefile
> @@ -0,0 +1,353 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_RUST) += core.o compiler_builtins.o helpers.o
> +extra-$(CONFIG_RUST) += exports_core_generated.h
> +
> +extra-$(CONFIG_RUST) += libmacros.so
> +
> +extra-$(CONFIG_RUST) += bindings_generated.rs bindings_helpers_generated.rs
> +obj-$(CONFIG_RUST) += alloc.o kernel.o
> +extra-$(CONFIG_RUST) += exports_alloc_generated.h exports_kernel_generated.h
> +
> +ifdef CONFIG_RUST_BUILD_ASSERT_DENY
> +extra-$(CONFIG_RUST) += build_error.o
> +else
> +obj-$(CONFIG_RUST) += build_error.o
> +endif


extra-y does nothing for 'make modules'.
Is this your expected behavior?

(commit d0e628cd817f3)





> +$(objtree)/rust/build_error.o: $(srctree)/rust/build_error.rs \
> +    $(objtree)/rust/compiler_builtins.o FORCE
> +       $(call if_changed_dep,rustc_library)
> +
> +# ICE on `--extern macros`: https://github.com/rust-lang/rust/issues/56935
> +$(objtree)/rust/kernel.o: private rustc_target_flags = --extern alloc \
> +    --extern build_error \
> +    --extern macros=$(objtree)/rust/libmacros.so
> +$(objtree)/rust/kernel.o: $(srctree)/rust/kernel/lib.rs $(objtree)/rust/alloc.o \
> +    $(objtree)/rust/build_error.o \
> +    $(objtree)/rust/libmacros.so $(objtree)/rust/bindings_generated.rs \
> +    $(objtree)/rust/bindings_helpers_generated.rs FORCE
> +       $(call if_changed_dep,rustc_library)
> +
> +# Targets that need to expand twice
> +.SECONDEXPANSION:

Why is .SECONDEXPANSION: needed ?





-- 
Best Regards
Masahiro Yamada
