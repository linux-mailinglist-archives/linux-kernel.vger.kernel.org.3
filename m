Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA7F46C7AA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242289AbhLGWsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237927AbhLGWst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:48:49 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F17C061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 14:45:18 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id e11so792838ljo.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 14:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FfinXtX3pmHa/EUUC93k09Uk+YA+ByZT/QN2YQh9LnM=;
        b=SX0898V2BkLrf2j5XUD1me/vuYO6CEp1PtmpC/3pxyZZCA8eTR1ACIhiHcmQpcQ/kn
         A0aacoNS1mXyUX3+jxmT1ZHOSVcFQk/uk2UUEIuGU4GwNyq9Nb0ix8rK9Z8saVWzwxt+
         1bkK9QFxr7TKVMAQyy6bbJl72f1A80MrgD2RFHknUDceGn/ihLZSfahKU9qkDR7ydLM9
         tJ4Y8CUaYyj/cD6jlsrTjCEH4Az8S2I4qx93wbCI53on5SueyxV0wU56txOcziQMuy8b
         RrzUpYAgUtpyHXn85iSiWySQU2onqFDswQuOzgior1CCjyh9bFlA2kvg8n9JAC99v1FP
         GHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FfinXtX3pmHa/EUUC93k09Uk+YA+ByZT/QN2YQh9LnM=;
        b=TmzBlijZ4zMv++wkF6xGI2Yc6SyOUt+NgvGnknwPK1bxpgrMnGHI0SvZvwFDRvyyNZ
         7cJcLimxOzLxG/eU9vMwOJpUROQMc2b7anHsBRsFiU5Gb6S7ynD1/hHpaAgT5T5X0kEf
         1iPEkJvFVnqI8NvBlRurtGvFh4/s5mI6B2TvnkWpoR0x9FTY2o4kTQSt2PrtcE5Qnh54
         b5GwD6SHhgjcsDqvoBBXW4xYNfjLHkp5skXMeO4hQxiOi7vxrhjoXCH6U0VoupDfV+Sk
         sKt1YNVOK3p4thqv2PKqfMjoQh4m246HfyLLRS9flUwMBoiSMo/uCALzQSO1Jr6nASUy
         bOuQ==
X-Gm-Message-State: AOAM530FGX7uerNrVgrx9UqRYA/4RoTvPY08D7r/rKFNwi33OrvlMlIB
        jWwpZvr7jrAHHygImiD1pEKvZ78eZHKapKNk5skceA==
X-Google-Smtp-Source: ABdhPJw/BIP/oWPstMBy7rbYPjebc0W77X1H8PNj6OtRLBN9a/B58hVNurQf+Lwi2uctgQemyeOhgGHLeSLRlAP4D8E=
X-Received: by 2002:a05:651c:292:: with SMTP id b18mr46269530ljo.220.1638917115681;
 Tue, 07 Dec 2021 14:45:15 -0800 (PST)
MIME-Version: 1.0
References: <20211206140313.5653-1-ojeda@kernel.org> <20211206140313.5653-16-ojeda@kernel.org>
In-Reply-To: <20211206140313.5653-16-ojeda@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 7 Dec 2021 14:45:03 -0800
Message-ID: <CAKwvOd=7QTUH69+ZbT7e8einvgcosTbDkyohmPaUBv6_y8RfrQ@mail.gmail.com>
Subject: Re: [PATCH 15/19] Kbuild: add Rust support
To:     Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alex Gaynor <alex.gaynor@gmail.com>,
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

"(/.On Mon, Dec 6, 2021 at 6:07 AM Miguel Ojeda <ojeda@kernel.org> wrote:
>

... snip ...

Miguel and team,
I'm happy to see progress here! Just some quick notes after a first pass.

Testing this series applied on mainline, I see:
$ make LLVM=1 -j72 defconfig
$ grep RUST .config
CONFIG_HAS_RUST=y
CONFIG_RUSTC_VERSION=14000
# CONFIG_RUST is not set
...
$ make LLVM=1 -j72 menuconfig
# enable CONFIG_RUST
$ make LLVM=1
...
  CALL    scripts/checksyscalls.sh
error: @path is unstable - use -Z unstable-options to enable its use

error: @path is unstable - use -Z unstable-options to enable its use
$ rustc --version
rustc 1.40.0 (73528e339 2019-12-16)

Can we update some Kconfig checks to fix that?

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
> +

KBUILD_CLIPPY isn't used until ...

>  # Use make M=dir or set the environment variable KBUILD_EXTMOD to specify the
>  # directory of external module to build. Setting M= takes precedence.
>  ifeq ("$(origin M)", "command line")
> @@ -267,7 +274,7 @@ no-dot-config-targets := $(clean-targets) \
>                          cscope gtags TAGS tags help% %docs check% coccicheck \
>                          $(version_h) headers headers_% archheaders archscripts \
>                          %asm-generic kernelversion %src-pkg dt_binding_check \
> -                        outputmakefile
> +                        outputmakefile rustfmt rustfmtcheck
>  # Installation targets should not require compiler. Unfortunately, vdso_install
>  # is an exception where build artifacts may be updated. This must be fixed.
>  no-compiler-targets := $(no-dot-config-targets) install dtbs_install \
> @@ -461,6 +468,12 @@ OBJDUMP            = $(CROSS_COMPILE)objdump
>  READELF                = $(CROSS_COMPILE)readelf
>  STRIP          = $(CROSS_COMPILE)strip
>  endif
> +RUSTC          = rustc
> +RUSTDOC                = rustdoc
> +RUSTFMT                = rustfmt
> +CLIPPY_DRIVER  = clippy-driver
> +BINDGEN                = bindgen
> +CARGO          = cargo
>  PAHOLE         = pahole
>  RESOLVE_BTFIDS = $(objtree)/tools/bpf/resolve_btfids/resolve_btfids
>  LEX            = flex
> @@ -486,9 +499,11 @@ CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
>                   -Wbitwise -Wno-return-void -Wno-unknown-attribute $(CF)
>  NOSTDINC_FLAGS :=
>  CFLAGS_MODULE   =
> +RUSTFLAGS_MODULE =
>  AFLAGS_MODULE   =
>  LDFLAGS_MODULE  =
>  CFLAGS_KERNEL  =
> +RUSTFLAGS_KERNEL =
>  AFLAGS_KERNEL  =
>  LDFLAGS_vmlinux =
>
> @@ -517,15 +532,46 @@ KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
>                    -Werror=return-type -Wno-format-security \
>                    -std=gnu89
>  KBUILD_CPPFLAGS := -D__KERNEL__
> +KBUILD_RUST_TARGET := $(srctree)/arch/$(SRCARCH)/rust/target.json
> +KBUILD_RUSTFLAGS := --emit=dep-info,obj,metadata --edition=2021 \
> +                    -Cpanic=abort -Cembed-bitcode=n -Clto=n -Crpath=n \
> +                    -Cforce-unwind-tables=n -Ccodegen-units=1 \
> +                    -Zbinary_dep_depinfo=y -Zsymbol-mangling-version=v0 \
> +                    -Dunsafe_op_in_unsafe_fn -Drust_2018_idioms \
> +                    -Dunreachable_pub -Dnon_ascii_idents \
> +                    -Wmissing_docs \
> +                    -Drustdoc::missing_crate_level_docs \
> +                    -Dclippy::correctness -Dclippy::style -Dclippy::suspicious \
> +                    -Dclippy::complexity -Dclippy::perf -Dclippy::float_arithmetic \
> +                    -Dclippy::let_unit_value -Dclippy::mut_mut \
> +                    -Dclippy::needless_bitwise_bool -Dclippy::needless_continue \
> +                    -Wclippy::dbg_macro

Consider putting clippy specific flags in their own variable, and/or
just adding them to KBUILD_RUSTFLAGS only when clippy is actually
being used.

>  KBUILD_AFLAGS_KERNEL :=
>  KBUILD_CFLAGS_KERNEL :=
> +KBUILD_RUSTFLAGS_KERNEL :=
>  KBUILD_AFLAGS_MODULE  := -DMODULE
>  KBUILD_CFLAGS_MODULE  := -DMODULE
> +KBUILD_RUSTFLAGS_MODULE := --cfg MODULE
>  KBUILD_LDFLAGS_MODULE :=
>  KBUILD_LDFLAGS :=
>  CLANG_FLAGS :=
>
> +ifeq ($(KBUILD_CLIPPY),1)
> +       RUSTC_OR_CLIPPY_QUIET := CLIPPY
> +       RUSTC_OR_CLIPPY = $(CLIPPY_DRIVER)
> +else
> +       RUSTC_OR_CLIPPY_QUIET := RUSTC
> +       RUSTC_OR_CLIPPY = $(RUSTC)
> +endif

... here. Should we sink the check for origin CLIPPY? Can we also
match how we check for LLVM=1 rather than checking the variables
origin?  Especially since KBUILD_CLIPPY isn't exported, it seems it's
not used outside of this file, IIUC?

> +
> +ifdef RUST_LIB_SRC
> +       export RUST_LIB_SRC
> +endif
> +
> +export RUSTC_BOOTSTRAP := 1

Is this used in a different patch in the series? ^

> +
>  export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE LD CC
> +export RUSTC RUSTDOC RUSTFMT RUSTC_OR_CLIPPY_QUIET RUSTC_OR_CLIPPY BINDGEN CARGO
>  export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX YACC AWK INSTALLKERNEL
>  export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
>  export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
> @@ -533,9 +579,10 @@ export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS LDFLAGS_MODULE
>
>  export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS KBUILD_LDFLAGS
>  export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
> +export KBUILD_RUST_TARGET KBUILD_RUSTFLAGS RUSTFLAGS_KERNEL RUSTFLAGS_MODULE
>  export KBUILD_AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
> -export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_LDFLAGS_MODULE
> -export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL
> +export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_RUSTFLAGS_MODULE KBUILD_LDFLAGS_MODULE
> +export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL KBUILD_RUSTFLAGS_KERNEL
>  export PAHOLE_FLAGS
>
>  # Files to ignore in find ... statements
> @@ -727,7 +774,7 @@ $(KCONFIG_CONFIG):
>  #
>  # Do not use $(call cmd,...) here. That would suppress prompts from syncconfig,
>  # so you cannot notice that Kconfig is waiting for the user input.
> -%/config/auto.conf %/config/auto.conf.cmd %/generated/autoconf.h: $(KCONFIG_CONFIG)
> +%/config/auto.conf %/config/auto.conf.cmd %/generated/autoconf.h %/generated/rustc_cfg: $(KCONFIG_CONFIG)
>         $(Q)$(kecho) "  SYNC    $@"
>         $(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
>  else # !may-sync-config
> @@ -756,11 +803,27 @@ KBUILD_CFLAGS     += $(call cc-disable-warning, address-of-packed-member)
>
>  ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
>  KBUILD_CFLAGS += -O2
> +KBUILD_RUSTFLAGS_OPT_LEVEL_MAP := 2
>  else ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3
>  KBUILD_CFLAGS += -O3
> +KBUILD_RUSTFLAGS_OPT_LEVEL_MAP := 3
>  else ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
>  KBUILD_CFLAGS += -Os
> -endif
> +KBUILD_RUSTFLAGS_OPT_LEVEL_MAP := z

If z and s are distinct opt levels, then rustc should really be using
s rather than z.  IME, z has created larger images than s due to LLVM
aggressively emitting libcalls, regardless of the cost of call setup.
See also commit a75bb4eb9e56 ("Revert "kbuild: use -Oz instead of -Os
when using clang")

> +endif
> +
> +# Always set `debug-assertions` and `overflow-checks` because their default
> +# depends on `opt-level` and `debug-assertions`, respectively.
> +KBUILD_RUSTFLAGS += -Cdebug-assertions=$(if $(CONFIG_RUST_DEBUG_ASSERTIONS),y,n)
> +KBUILD_RUSTFLAGS += -Coverflow-checks=$(if $(CONFIG_RUST_OVERFLOW_CHECKS),y,n)
> +KBUILD_RUSTFLAGS += -Copt-level=$\
> +       $(if $(CONFIG_RUST_OPT_LEVEL_SIMILAR_AS_CHOSEN_FOR_C),$(KBUILD_RUSTFLAGS_OPT_LEVEL_MAP))$\
> +       $(if $(CONFIG_RUST_OPT_LEVEL_0),0)$\
> +       $(if $(CONFIG_RUST_OPT_LEVEL_1),1)$\
> +       $(if $(CONFIG_RUST_OPT_LEVEL_2),2)$\
> +       $(if $(CONFIG_RUST_OPT_LEVEL_3),3)$\
> +       $(if $(CONFIG_RUST_OPT_LEVEL_S),s)$\
> +       $(if $(CONFIG_RUST_OPT_LEVEL_Z),z)

I'm still not a fan of this separate configurability for optimization
level differing from C.

>
>  # Tell gcc to never replace conditional load with a non-conditional one
>  ifdef CONFIG_CC_IS_GCC
> @@ -791,6 +854,9 @@ KBUILD_CFLAGS += $(stackp-flags-y)
>  KBUILD_CFLAGS-$(CONFIG_WERROR) += -Werror
>  KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
>
> +KBUILD_RUSTFLAGS-$(CONFIG_WERROR) += -Dwarnings
> +KBUILD_RUSTFLAGS += $(KBUILD_RUSTFLAGS-y)
> +
>  ifdef CONFIG_CC_IS_CLANG
>  KBUILD_CPPFLAGS += -Qunused-arguments
>  # The kernel builds with '-std=gnu89' so use of GNU extensions is acceptable.
> @@ -812,6 +878,7 @@ KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
>
>  ifdef CONFIG_FRAME_POINTER
>  KBUILD_CFLAGS  += -fno-omit-frame-pointer -fno-optimize-sibling-calls
> +KBUILD_RUSTFLAGS += -Cforce-frame-pointers=y
>  else
>  # Some targets (ARM with Thumb2, for example), can't be built with frame
>  # pointers.  For those, we don't have FUNCTION_TRACER automatically
> @@ -1022,10 +1089,11 @@ include $(addprefix $(srctree)/, $(include-y))
>  # Do not add $(call cc-option,...) below this line. When you build the kernel
>  # from the clean source tree, the GCC plugins do not exist at this point.
>
> -# Add user supplied CPPFLAGS, AFLAGS and CFLAGS as the last assignments
> +# Add user supplied CPPFLAGS, AFLAGS, CFLAGS and RUSTFLAGS as the last assignments
>  KBUILD_CPPFLAGS += $(KCPPFLAGS)
>  KBUILD_AFLAGS   += $(KAFLAGS)
>  KBUILD_CFLAGS   += $(KCFLAGS)
> +KBUILD_RUSTFLAGS += $(KRUSTFLAGS)
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
> +
>  vmlinux-dirs   := $(patsubst %/,%,$(filter %/, \
>                      $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
>                      $(libs-y) $(libs-m)))
> @@ -1195,6 +1268,9 @@ archprepare: outputmakefile archheaders archscripts scripts include/config/kerne
>  prepare0: archprepare
>         $(Q)$(MAKE) $(build)=scripts/mod
>         $(Q)$(MAKE) $(build)=.
> +ifdef CONFIG_RUST
> +       $(Q)$(MAKE) $(build)=rust
> +endif
>
>  # All the preparing..
>  prepare: prepare0
> @@ -1495,7 +1571,7 @@ endif # CONFIG_MODULES
>  # Directories & files removed with 'make clean'
>  CLEAN_FILES += include/ksym vmlinux.symvers modules-only.symvers \
>                modules.builtin modules.builtin.modinfo modules.nsdeps \
> -              compile_commands.json .thinlto-cache
> +              compile_commands.json .thinlto-cache rust/test rust/doc
>
>  # Directories & files removed with 'make mrproper'
>  MRPROPER_FILES += include/config include/generated          \
> @@ -1506,7 +1582,8 @@ MRPROPER_FILES += include/config include/generated          \
>                   certs/signing_key.pem certs/signing_key.x509 \
>                   certs/x509.genkey \
>                   vmlinux-gdb.py \
> -                 *.spec
> +                 *.spec \
> +                 rust/*_generated.h rust/*_generated.rs rust/libmacros.so
>
>  # clean - Delete most, but leave enough to build external modules
>  #
> @@ -1618,6 +1695,17 @@ help:
>         @echo  '  kselftest-merge   - Merge all the config dependencies of'
>         @echo  '                      kselftest to existing .config.'
>         @echo  ''
> +       @echo  'Rust targets:'
> +       @echo  '  rustfmt         - Reformat all the Rust code in the kernel'
> +       @echo  '  rustfmtcheck    - Checks if all the Rust code in the kernel'
> +       @echo  '                    is formatted, printing a diff otherwise.'
> +       @echo  '  rustdoc         - Generate Rust documentation'
> +       @echo  '                    (requires kernel .config)'
> +       @echo  '  rusttest        - Runs the Rust tests'
> +       @echo  '                    (requires kernel .config; downloads external repos)'
> +       @echo  '  rust-analyzer   - Generate rust-project.json rust-analyzer support file'
> +       @echo  '                    (requires kernel .config)'
> +       @echo  ''
>         @$(if $(dtstree), \
>                 echo 'Devicetree:'; \
>                 echo '* dtbs             - Build device tree blobs for enabled boards'; \
> @@ -1689,6 +1777,47 @@ PHONY += $(DOC_TARGETS)
>  $(DOC_TARGETS):
>         $(Q)$(MAKE) $(build)=Documentation $@
>
> +
> +# Rust targets
> +# ---------------------------------------------------------------------------
> +
> +# Documentation target
> +#
> +# Using the singular to avoid running afoul of `no-dot-config-targets`.
> +PHONY += rustdoc
> +rustdoc: prepare0
> +       $(Q)$(MAKE) $(build)=rust $@
> +
> +# Testing target
> +PHONY += rusttest
> +rusttest: prepare0
> +       $(Q)$(MAKE) $(build)=rust $@
> +
> +# Formatting targets
> +PHONY += rustfmt rustfmtcheck
> +
> +# We skip `rust/alloc` since we want to minimize the diff w.r.t. upstream.
> +#
> +# We match using absolute paths since `find` does not resolve them
> +# when matching, which is a problem when e.g. `srctree` is `..`.
> +# We `grep` afterwards in order to remove the directory entry itself.
> +rustfmt:
> +       $(Q)find $(abs_srctree) -type f -name '*.rs' \
> +               -o -path $(abs_srctree)/rust/alloc -prune \
> +               -o -path $(abs_objtree)/rust/test -prune \
> +               | grep -Fv $(abs_srctree)/rust/alloc \
> +               | grep -Fv $(abs_objtree)/rust/test \
> +               | grep -Fv generated \
> +               | xargs $(RUSTFMT) $(rustfmt_flags)
> +
> +rustfmtcheck: rustfmt_flags = --check
> +rustfmtcheck: rustfmt
> +
> +# IDE support targets
> +PHONY += rust-analyzer
> +rust-analyzer: prepare0
> +       $(Q)$(MAKE) $(build)=rust $@
> +
>  # Misc
>  # ---------------------------------------------------------------------------
>
> @@ -1856,6 +1985,7 @@ clean: $(clean-dirs)
>         $(call cmd,rmfiles)
>         @find $(if $(KBUILD_EXTMOD), $(KBUILD_EXTMOD), .) $(RCS_FIND_IGNORE) \
>                 \( -name '*.[aios]' -o -name '*.ko' -o -name '.*.cmd' \
> +               -o -name '*.rmeta' \
>                 -o -name '*.ko.*' \
>                 -o -name '*.dtb' -o -name '*.dtbo' -o -name '*.dtb.S' -o -name '*.dt.yaml' \
>                 -o -name '*.dwo' -o -name '*.lst' \
> diff --git a/arch/arm/rust/target.json b/arch/arm/rust/target.json
> new file mode 100644
> index 000000000000..3f845b8221dc
> --- /dev/null
> +++ b/arch/arm/rust/target.json
> @@ -0,0 +1,27 @@
> +{
> +  "arch": "arm",
> +  "crt-static-respected": true,
> +  "data-layout": "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64",
> +  "dynamic-linking": true,
> +  "env": "gnu",
> +  "executables": true,
> +  "features": "+strict-align,+v6",
> +  "function-sections": false,
> +  "has-elf-tls": true,
> +  "has-rpath": true,
> +  "linker-is-gnu": true,
> +  "llvm-target": "arm-unknown-linux-gnueabi",
> +  "max-atomic-width": 64,
> +  "os": "linux",
> +  "position-independent-executables": true,
> +  "pre-link-args": {
> +    "gcc": [
> +      "-Wl,--as-needed",
> +      "-Wl,-z,noexecstack"
> +    ]
> +  },
> +  "relocation-model": "static",
> +  "target-family": "unix",
> +  "target-mcount": "\u0001__gnu_mcount_nc",
> +  "target-pointer-width": "32"
> +}

oh boy. I wonder which configs change the above values? ;) Can rustc
still override these via command line flags?

> diff --git a/arch/arm64/rust/target.json b/arch/arm64/rust/target.json
> new file mode 100644
> index 000000000000..09a264df26c7
> --- /dev/null
> +++ b/arch/arm64/rust/target.json
> @@ -0,0 +1,34 @@
> +{
> +  "arch": "aarch64",
> +  "data-layout": "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128",
> +  "disable-redzone": true,
> +  "emit-debug-gdb-scripts": false,
> +  "env": "gnu",
> +  "features": "+strict-align,+neon,+fp-armv8",
> +  "frame-pointer": "always",
> +  "function-sections": false,
> +  "linker-flavor": "gcc",
> +  "linker-is-gnu": true,
> +  "llvm-target": "aarch64-unknown-none",
> +  "max-atomic-width": 128,
> +  "needs-plt": true,
> +  "os": "none",
> +  "panic-strategy": "abort",
> +  "position-independent-executables": true,
> +  "pre-link-args": {
> +    "gcc": [
> +      "-Wl,--as-needed",
> +      "-Wl,-z,noexecstack",
> +      "-m64"
> +    ]
> +  },
> +  "relocation-model": "static",
> +  "relro-level": "full",
> +  "stack-probes": {
> +    "kind": "none"
> +  },
> +  "target-c-int-width": "32",
> +  "target-endian": "little",
> +  "target-pointer-width": "64",
> +  "vendor": ""
> +}
> diff --git a/arch/powerpc/rust/target.json b/arch/powerpc/rust/target.json
> new file mode 100644
> index 000000000000..2420c8e6a520
> --- /dev/null
> +++ b/arch/powerpc/rust/target.json
> @@ -0,0 +1,29 @@
> +{
> +  "arch": "powerpc64",
> +  "code-model": "large",
> +  "cpu": "ppc64le",
> +  "data-layout": "e-m:e-i64:64-n32:64",
> +  "env": "gnu",
> +  "features": "-altivec,-vsx,-hard-float",
> +  "function-sections": false,
> +  "linker-flavor": "gcc",
> +  "linker-is-gnu": true,
> +  "llvm-target": "powerpc64le-elf",
> +  "max-atomic-width": 64,
> +  "os": "none",
> +  "panic-strategy": "abort",
> +  "position-independent-executables": true,
> +  "pre-link-args": {
> +    "gcc": [
> +      "-Wl,--as-needed",
> +      "-Wl,-z,noexecstack",
> +      "-m64"
> +    ]
> +  },
> +  "relocation-model": "static",
> +  "relro-level": "full",
> +  "target-family": "unix",
> +  "target-mcount": "_mcount",
> +  "target-endian": "little",
> +  "target-pointer-width": "64"
> +}
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 8a107ed18b0d..0487db1e54c6 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -52,6 +52,7 @@ riscv-march-$(CONFIG_FPU)             := $(riscv-march-y)fd
>  riscv-march-$(CONFIG_RISCV_ISA_C)      := $(riscv-march-y)c
>  KBUILD_CFLAGS += -march=$(subst fd,,$(riscv-march-y))
>  KBUILD_AFLAGS += -march=$(riscv-march-y)
> +KBUILD_RUST_TARGET := $(srctree)/arch/riscv/rust/$(subst fd,,$(riscv-march-y)).json
>
>  KBUILD_CFLAGS += -mno-save-restore
>  KBUILD_CFLAGS += -DCONFIG_PAGE_OFFSET=$(CONFIG_PAGE_OFFSET)
> diff --git a/arch/riscv/rust/rv32ima.json b/arch/riscv/rust/rv32ima.json
> new file mode 100644
> index 000000000000..bcdda88c1604
> --- /dev/null
> +++ b/arch/riscv/rust/rv32ima.json
> @@ -0,0 +1,36 @@
> +{
> +  "arch": "riscv32",
> +  "code-model": "medium",
> +  "cpu": "generic-rv32",
> +  "data-layout": "e-m:e-p:32:32-i64:64-n32-S128",
> +  "disable-redzone": true,
> +  "emit-debug-gdb-scripts": false,
> +  "env": "gnu",
> +  "features": "+m,+a",
> +  "frame-pointer": "always",
> +  "function-sections": false,
> +  "linker-flavor": "gcc",
> +  "linker-is-gnu": true,
> +  "llvm-target": "riscv32",
> +  "max-atomic-width": 32,
> +  "needs-plt": true,
> +  "os": "none",
> +  "panic-strategy": "abort",
> +  "position-independent-executables": true,
> +  "pre-link-args": {
> +    "gcc": [
> +      "-Wl,--as-needed",
> +      "-Wl,-z,noexecstack",
> +      "-m32"
> +    ]
> +  },
> +  "relocation-model": "static",
> +  "relro-level": "full",
> +  "stack-probes": {
> +    "kind": "none"
> +  },
> +  "target-c-int-width": "32",
> +  "target-endian": "little",
> +  "target-pointer-width": "32",
> +  "vendor": ""
> +}
> diff --git a/arch/riscv/rust/rv32imac.json b/arch/riscv/rust/rv32imac.json
> new file mode 100644
> index 000000000000..45873c10a5c3
> --- /dev/null
> +++ b/arch/riscv/rust/rv32imac.json
> @@ -0,0 +1,36 @@
> +{
> +  "arch": "riscv32",
> +  "code-model": "medium",
> +  "cpu": "generic-rv32",
> +  "data-layout": "e-m:e-p:32:32-i64:64-n32-S128",
> +  "disable-redzone": true,
> +  "emit-debug-gdb-scripts": false,
> +  "env": "gnu",
> +  "features": "+m,+a,+c",
> +  "frame-pointer": "always",
> +  "function-sections": false,
> +  "linker-flavor": "gcc",
> +  "linker-is-gnu": true,
> +  "llvm-target": "riscv32",
> +  "max-atomic-width": 32,
> +  "needs-plt": true,
> +  "os": "none",
> +  "panic-strategy": "abort",
> +  "position-independent-executables": true,
> +  "pre-link-args": {
> +    "gcc": [
> +      "-Wl,--as-needed",
> +      "-Wl,-z,noexecstack",
> +      "-m32"
> +    ]
> +  },
> +  "relocation-model": "static",
> +  "relro-level": "full",
> +  "stack-probes": {
> +    "kind": "none"
> +  },
> +  "target-c-int-width": "32",
> +  "target-endian": "little",
> +  "target-pointer-width": "32",
> +  "vendor": ""
> +}
> diff --git a/arch/riscv/rust/rv64ima.json b/arch/riscv/rust/rv64ima.json
> new file mode 100644
> index 000000000000..853d758c5461
> --- /dev/null
> +++ b/arch/riscv/rust/rv64ima.json
> @@ -0,0 +1,36 @@
> +{
> +  "arch": "riscv64",
> +  "code-model": "medium",
> +  "cpu": "generic-rv64",
> +  "data-layout": "e-m:e-p:64:64-i64:64-i128:128-n64-S128",
> +  "disable-redzone": true,
> +  "emit-debug-gdb-scripts": false,
> +  "env": "gnu",
> +  "features": "+m,+a",
> +  "frame-pointer": "always",
> +  "function-sections": false,
> +  "linker-flavor": "gcc",
> +  "linker-is-gnu": true,
> +  "llvm-target": "riscv64",
> +  "max-atomic-width": 64,
> +  "needs-plt": true,
> +  "os": "none",
> +  "panic-strategy": "abort",
> +  "position-independent-executables": true,
> +  "pre-link-args": {
> +    "gcc": [
> +      "-Wl,--as-needed",
> +      "-Wl,-z,noexecstack",
> +      "-m64"
> +    ]
> +  },
> +  "relocation-model": "static",
> +  "relro-level": "full",
> +  "stack-probes": {
> +    "kind": "none"
> +  },
> +  "target-c-int-width": "32",
> +  "target-endian": "little",
> +  "target-pointer-width": "64",
> +  "vendor": ""
> +}
> diff --git a/arch/riscv/rust/rv64imac.json b/arch/riscv/rust/rv64imac.json
> new file mode 100644
> index 000000000000..ce50ee8e8c93
> --- /dev/null
> +++ b/arch/riscv/rust/rv64imac.json
> @@ -0,0 +1,36 @@
> +{
> +  "arch": "riscv64",
> +  "code-model": "medium",
> +  "cpu": "generic-rv64",
> +  "data-layout": "e-m:e-p:64:64-i64:64-i128:128-n64-S128",
> +  "disable-redzone": true,
> +  "emit-debug-gdb-scripts": false,
> +  "env": "gnu",
> +  "features": "+m,+a,+c",
> +  "frame-pointer": "always",
> +  "function-sections": false,
> +  "linker-flavor": "gcc",
> +  "linker-is-gnu": true,
> +  "llvm-target": "riscv64",
> +  "max-atomic-width": 64,
> +  "needs-plt": true,
> +  "os": "none",
> +  "panic-strategy": "abort",
> +  "position-independent-executables": true,
> +  "pre-link-args": {
> +    "gcc": [
> +      "-Wl,--as-needed",
> +      "-Wl,-z,noexecstack",
> +      "-m64"
> +    ]
> +  },
> +  "relocation-model": "static",
> +  "relro-level": "full",
> +  "stack-probes": {
> +    "kind": "none"
> +  },
> +  "target-c-int-width": "32",
> +  "target-endian": "little",
> +  "target-pointer-width": "64",
> +  "vendor": ""
> +}
> diff --git a/arch/x86/rust/target.json b/arch/x86/rust/target.json
> new file mode 100644
> index 000000000000..379cf39e8941
> --- /dev/null
> +++ b/arch/x86/rust/target.json
> @@ -0,0 +1,36 @@
> +{
> +  "arch": "x86_64",
> +  "code-model": "kernel",
> +  "cpu": "x86-64",
> +  "data-layout": "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128",
> +  "disable-redzone": true,
> +  "emit-debug-gdb-scripts": false,
> +  "env": "gnu",
> +  "features": "-mmx,-sse,-sse2,-sse3,-ssse3,-sse4.1,-sse4.2,-3dnow,-3dnowa,-avx,-avx2,+soft-float",
> +  "frame-pointer": "always",
> +  "function-sections": false,
> +  "linker-flavor": "gcc",
> +  "linker-is-gnu": true,
> +  "llvm-target": "x86_64-elf",
> +  "max-atomic-width": 64,
> +  "needs-plt": true,
> +  "os": "none",
> +  "panic-strategy": "abort",
> +  "position-independent-executables": true,
> +  "pre-link-args": {
> +    "gcc": [
> +      "-Wl,--as-needed",
> +      "-Wl,-z,noexecstack",
> +      "-m64"
> +    ]
> +  },
> +  "relocation-model": "static",
> +  "relro-level": "full",
> +  "stack-probes": {
> +    "kind": "none"
> +  },
> +  "target-c-int-width": "32",
> +  "target-endian": "little",
> +  "target-pointer-width": "64",
> +  "vendor": "unknown"
> +}
> diff --git a/init/Kconfig b/init/Kconfig
> index 4b7bac10c72d..03d3c21e28a3 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -60,6 +60,15 @@ config LLD_VERSION
>         default $(ld-version) if LD_IS_LLD
>         default 0
>
> +config HAS_RUST
> +       depends on ARM64 || CPU_32v6 || CPU_32v6K || (PPC64 && CPU_LITTLE_ENDIAN) || X86_64 || RISCV
> +       def_bool $(success,$(RUSTC) --version)
> +
> +config RUSTC_VERSION
> +       depends on HAS_RUST
> +       int
> +       default $(shell,$(srctree)/scripts/rust-version.sh $(RUSTC))
> +
>  config CC_CAN_LINK
>         bool
>         default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m64-flag)) if 64BIT
> @@ -142,7 +151,8 @@ config WERROR
>         default COMPILE_TEST
>         help
>           A kernel build should not cause any compiler warnings, and this
> -         enables the '-Werror' flag to enforce that rule by default.
> +         enables the '-Werror' (for C) and '-Dwarnings' (for Rust) flags
> +         to enforce that rule by default.
>
>           However, if you have a new (or very old) compiler with odd and
>           unusual warnings, or you have some architecture with problems,
> @@ -2044,6 +2054,25 @@ config PROFILING
>           Say Y here to enable the extended profiling support mechanisms used
>           by profilers.
>
> +config RUST
> +       bool "Rust support"
> +       depends on HAS_RUST
> +       depends on !COMPILE_TEST
> +       depends on !MODVERSIONS
> +       default n
> +       help
> +         Enables Rust support in the kernel.
> +
> +         This allows other Rust-related options, like drivers written in Rust,
> +         to be selected.
> +
> +         It is also required to be able to load external kernel modules
> +         written in Rust.
> +
> +         See Documentation/rust/ for more information.
> +
> +         If unsure, say N.
> +
>  #
>  # Place an empty function call at each tracepoint site. Can be
>  # dynamically changed for a probe function.
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 5c12bde10996..361379695f18 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2650,6 +2650,150 @@ config HYPERV_TESTING
>
>  endmenu # "Kernel Testing and Coverage"
>
> +menu "Rust hacking"
> +
> +config RUST_DEBUG_ASSERTIONS
> +       bool "Debug assertions"
> +       default n
> +       depends on RUST
> +       help
> +         Enables rustc's `-Cdebug-assertions` codegen option.
> +
> +         This flag lets you turn `cfg(debug_assertions)` conditional
> +         compilation on or off. This can be used to enable extra debugging
> +         code in development but not in production. For example, it controls
> +         the behavior of the standard library's `debug_assert!` macro.
> +
> +         Note that this will apply to all Rust code, including `core`.
> +
> +         If unsure, say N.
> +
> +config RUST_OVERFLOW_CHECKS
> +       bool "Overflow checks"
> +       default y

So this is like turning on -fsanitize=signed-integer-overflow and
-fsanitize=unsigned-integer-overflow by default?

> +       depends on RUST
> +       help
> +         Enables rustc's `-Coverflow-checks` codegen option.
> +
> +         This flag allows you to control the behavior of runtime integer
> +         overflow. When overflow-checks are enabled, a panic will occur
> +         on overflow.

A rust panic or a kernel panic?

> +
> +         Note that this will apply to all Rust code, including `core`.
> +
> +         If unsure, say Y.
> +
> +choice
> +       prompt "Optimization level"
> +       default RUST_OPT_LEVEL_SIMILAR_AS_CHOSEN_FOR_C
> +       depends on RUST
> +       help
> +         Controls rustc's `-Copt-level` codegen option.
> +
> +         This flag controls the optimization level.
> +
> +         If unsure, say "Similar as chosen for C".
> +
> +config RUST_OPT_LEVEL_SIMILAR_AS_CHOSEN_FOR_C
> +       bool "Similar as chosen for C"
> +       help
> +         This choice will pick a similar optimization level as chosen in
> +         the "Compiler optimization level" for C:
> +
> +             -O2 is currently mapped to -Copt-level=2
> +             -O3 is currently mapped to -Copt-level=3
> +             -Os is currently mapped to -Copt-level=z
> +
> +         The mapping may change over time to follow the intended semantics
> +         of the choice for C as sensibly as possible.
> +
> +         This is the default.

This should really be the only option here. I still don't see the
point of allowing wacky combinations of configs where we differ from C
code.  The more combinations will just frustrate randconfig builds.

> +
> +config RUST_OPT_LEVEL_0
> +       bool "No optimizations (-Copt-level=0)"
> +       help
> +         Not recommended for most purposes. It may come in handy for debugging
> +         suspected optimizer bugs, unexpected undefined behavior, etc.
> +
> +         Note that this level will *not* enable debug assertions nor overflow
> +         checks on its own (like it happens when interacting with rustc
> +         directly). Use the corresponding configuration options to control
> +         that instead, orthogonally.
> +
> +         Note this level may cause excessive stack usage, which can lead to stack
> +         overflow and subsequent crashes.
> +
> +config RUST_OPT_LEVEL_1
> +       bool "Basic optimizations (-Copt-level=1)"
> +       help
> +         Useful for debugging without getting too lost, but without
> +         the overhead and boilerplate of no optimizations at all.
> +
> +         Note this level may cause excessive stack usage, which can lead to stack
> +         overflow and subsequent crashes.
> +
> +config RUST_OPT_LEVEL_2
> +       bool "Some optimizations (-Copt-level=2)"
> +       help
> +         The sensible choice in most cases.
> +
> +config RUST_OPT_LEVEL_3
> +       bool "All optimizations (-Copt-level=3)"
> +       help
> +         Yet more performance (hopefully).
> +
> +config RUST_OPT_LEVEL_S
> +       bool "Optimize for size (-Copt-level=s)"
> +       help
> +         Smaller kernel, ideally without too much performance loss.
> +
> +config RUST_OPT_LEVEL_Z
> +       bool "Optimize for size, no loop vectorization (-Copt-level=z)"
> +       help
> +         Like the previous level, but also turn off loop vectorization.
> +
> +endchoice
> +
> +choice
> +       prompt "Build-time assertions"
> +       default RUST_BUILD_ASSERT_ALLOW if RUST_OPT_LEVEL_0
> +       default RUST_BUILD_ASSERT_DENY if !RUST_OPT_LEVEL_0
> +       depends on RUST
> +       help
> +         Controls how are `build_error!` and `build_assert!` handled during build.
> +
> +         If calls to them exist in the binary, it may indicate a violated invariant
> +         or that the optimizer failed to verify the invariant during compilation.
> +         You can choose to abort compilation or ignore them during build and let the
> +         check be carried to runtime.
> +
> +         If optimizations are turned off, you cannot select "Deny".
> +
> +         If unsure, say "Deny".
> +
> +config RUST_BUILD_ASSERT_ALLOW
> +       bool "Allow"
> +       help
> +         Unoptimized calls to `build_error!` will be converted to `panic!`
> +         and checked at runtime.
> +
> +config RUST_BUILD_ASSERT_WARN
> +       bool "Warn"
> +       help
> +         Unoptimized calls to `build_error!` will be converted to `panic!`
> +         and checked at runtime, but warnings will be generated when building.
> +
> +config RUST_BUILD_ASSERT_DENY
> +       bool "Deny"
> +       depends on !RUST_OPT_LEVEL_0
> +       help
> +         Unoptimized calls to `build_error!` will abort compilation.
> +
> +endchoice
> +
> +
> +endmenu # "Rust"
> +
>  source "Documentation/Kconfig"
>
>  endmenu # Kernel hacking
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
> +
> +obj-$(CONFIG_RUST) += exports.o
> +
> +ifeq ($(quiet),silent_)
> +cargo_quiet=-q
> +rust_test_quiet=-q
> +rustdoc_test_quiet=--test-args -q
> +else ifeq ($(quiet),quiet_)
> +rust_test_quiet=-q
> +rustdoc_test_quiet=--test-args -q
> +else
> +cargo_quiet=--verbose
> +endif
> +
> +core-cfgs = \
> +    --cfg no_fp_fmt_parse
> +
> +alloc-cfgs = \
> +    --cfg no_global_oom_handling \
> +    --cfg no_rc \
> +    --cfg no_sync
> +
> +quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
> +      cmd_rustdoc = \
> +       OBJTREE=$(abspath $(objtree)) \
> +       $(RUSTDOC) $(if $(rustdoc_host),,$(rust_cross_flags)) \
> +               $(filter-out -Cpanic=abort, $(filter-out --emit=%, $(rust_flags))) \
> +               $(rustc_target_flags) -L $(objtree)/rust \
> +               --output $(objtree)/rust/doc --crate-name $(subst rustdoc-,,$@) \
> +               @$(objtree)/include/generated/rustc_cfg $<
> +
> +rustdoc: rustdoc-core rustdoc-macros rustdoc-compiler_builtins rustdoc-alloc rustdoc-kernel
> +       $(Q)cp $(srctree)/Documentation/rust/assets/* $(objtree)/rust/doc
> +
> +rustdoc-macros: private rustdoc_host = yes
> +rustdoc-macros: private rustc_target_flags = --crate-type proc-macro \
> +    --extern proc_macro
> +rustdoc-macros: $(srctree)/rust/macros/lib.rs FORCE
> +       $(call if_changed,rustdoc)
> +
> +rustdoc-compiler_builtins: $(srctree)/rust/compiler_builtins.rs rustdoc-core FORCE
> +       $(call if_changed,rustdoc)
> +
> +# We need to allow `rustdoc::broken_intra_doc_links` because some
> +# `no_global_oom_handling` functions refer to non-`no_global_oom_handling`
> +# functions. Ideally `rustdoc` would have a way to distinguish broken links
> +# due to things that are "configured out" vs. entirely non-existing ones.
> +rustdoc-alloc: private rustc_target_flags = $(alloc-cfgs) \
> +    -Arustdoc::broken_intra_doc_links
> +rustdoc-alloc: $(srctree)/rust/alloc/lib.rs rustdoc-core \
> +    rustdoc-compiler_builtins FORCE
> +       $(call if_changed,rustdoc)
> +
> +rustdoc-kernel: private rustc_target_flags = --extern alloc \
> +    --extern build_error \
> +    --extern macros=$(objtree)/rust/libmacros.so
> +rustdoc-kernel: $(srctree)/rust/kernel/lib.rs rustdoc-core \
> +    rustdoc-macros rustdoc-compiler_builtins rustdoc-alloc \
> +    $(objtree)/rust/libmacros.so $(objtree)/rust/bindings_generated.rs \
> +    $(objtree)/rust/bindings_helpers_generated.rs FORCE
> +       $(call if_changed,rustdoc)
> +
> +quiet_cmd_rustc_test_library = RUSTC TL $<
> +      cmd_rustc_test_library = \
> +       OBJTREE=$(abspath $(objtree)) \
> +       $(RUSTC) $(filter-out --sysroot=%, $(filter-out -Cpanic=abort, $(filter-out --emit=%, $(rust_flags)))) \
> +               $(rustc_target_flags) --crate-type $(if $(rustc_test_library_proc),proc-macro,rlib) \
> +               --out-dir $(objtree)/rust/test/ --cfg testlib \
> +               --sysroot $(objtree)/rust/test/sysroot \
> +               -L $(objtree)/rust/test/ --crate-name $(subst rusttest-,,$(subst rusttestlib-,,$@)) $<
> +
> +rusttestlib-build_error: $(srctree)/rust/build_error.rs rusttest-prepare FORCE
> +       $(call if_changed,rustc_test_library)
> +
> +rusttestlib-macros: private rustc_target_flags = --extern proc_macro
> +rusttestlib-macros: private rustc_test_library_proc = yes
> +rusttestlib-macros: $(srctree)/rust/macros/lib.rs rusttest-prepare FORCE
> +       $(call if_changed,rustc_test_library)
> +
> +quiet_cmd_rustdoc_test = RUSTDOC T $<
> +      cmd_rustdoc_test = \
> +       OBJTREE=$(abspath $(objtree)) \
> +       $(RUSTDOC) --test $(filter-out --sysroot=%, $(filter-out -Cpanic=abort, $(filter-out --emit=%, $(rust_flags)))) \

Seeing repeated filter-out rules makes me wonder if we could DRY up
some of these rules with function definitions?

> +               $(rustc_target_flags) $(rustdoc_test_target_flags) \
> +               --sysroot $(objtree)/rust/test/sysroot $(rustdoc_test_quiet) \
> +               -L $(objtree)/rust/test \
> +               --output $(objtree)/rust/doc --crate-name $(subst rusttest-,,$@) \
> +               @$(objtree)/include/generated/rustc_cfg $<
> +
> +# We cannot use `-Zpanic-abort-tests` because some tests are dynamic,
> +# so for the moment we skip `-Cpanic=abort`.
> +quiet_cmd_rustc_test = RUSTC T  $<
> +      cmd_rustc_test = \
> +       OBJTREE=$(abspath $(objtree)) \
> +       $(RUSTC) --test $(filter-out --sysroot=%, $(filter-out -Cpanic=abort, $(filter-out --emit=%, $(rust_flags)))) \
> +               $(rustc_target_flags) --out-dir $(objtree)/rust/test \
> +               --sysroot $(objtree)/rust/test/sysroot \
> +               -L $(objtree)/rust/test/ --crate-name $(subst rusttest-,,$@) $<; \
> +       $(objtree)/rust/test/$(subst rusttest-,,$@) $(rust_test_quiet) \
> +               $(rustc_test_run_flags)
> +
> +rusttest: rusttest-macros rusttest-kernel
> +
> +# This prepares a custom sysroot with our custom `alloc` instead of
> +# the standard one.
> +#
> +# This requires several hacks:
> +#   - Unlike `core` and `alloc`, `std` depends on more than a dozen crates,
> +#     including third-party crates that need to be downloaded, plus custom
> +#     `build.rs` steps. Thus hardcoding things here is not maintainable.
> +#   - `cargo` knows how to build the standard library, but it is an unstable
> +#     feature so far (`-Zbuild-std`).
> +#   - `cargo` only considers the use case of building the standard library
> +#     to use it in a given package. Thus we need to create a dummy package
> +#     and pick the generated libraries from there.
> +#   - Since we only keep a subset of upstream `alloc` in-tree, we need
> +#     to recreate it on the fly by putting our sources on top.
> +#   - The usual ways of modifying the dependency graph in `cargo` do not seem
> +#     to apply for the `-Zbuild-std` steps, thus we have to mislead it
> +#     by modifying the sources in the sysroot.
> +#   - To avoid messing with the user's Rust installation, we create a clone
> +#     of the sysroot. However, `cargo` ignores `RUSTFLAGS` in the `-Zbuild-std`
> +#     steps, thus we use a wrapper binary passed via `RUSTC` to pass the flag.

Are there links to corresponding feature requests upstream so that one
day we can drop technical debt here?  In particular, having to create
a custom sysroot as is done here isn't particularly pretty.

I'd be curious if we could remove the dependency on cargo for rust tests.

> +#
> +# In the future, we hope to avoid the whole ordeal by either:
> +#   - Making the `test` crate not depend on `std` (either improving upstream
> +#     or having our own custom crate).
> +#   - Making the tests run in kernel space (requires the previous point).
> +#   - Making `std` and friends be more like a "normal" crate, so that
> +#     `-Zbuild-std` and related hacks are not needed.
> +quiet_cmd_rustsysroot = RUSTSYSROOT
> +      cmd_rustsysroot = \
> +       rm -rf $(objtree)/rust/test; \
> +       mkdir -p $(objtree)/rust/test; \
> +       cp -a $(rustc_sysroot) $(objtree)/rust/test/sysroot; \
> +       cp -r $(srctree)/rust/alloc/* \
> +               $(objtree)/rust/test/sysroot/lib/rustlib/src/rust/library/alloc/src; \
> +       echo '\#!/bin/sh' > $(objtree)/rust/test/rustc_sysroot; \
> +       echo "$(RUSTC) --sysroot=$(abspath $(objtree)/rust/test/sysroot) \"\$$@\"" \
> +               >> $(objtree)/rust/test/rustc_sysroot; \
> +       chmod u+x $(objtree)/rust/test/rustc_sysroot; \
> +       $(CARGO) -q new $(objtree)/rust/test/dummy; \
> +       RUSTC=$(objtree)/rust/test/rustc_sysroot $(CARGO) $(cargo_quiet) \
> +               test -Zbuild-std --target $(rustc_host_target) \
> +               --manifest-path $(objtree)/rust/test/dummy/Cargo.toml; \
> +       rm $(objtree)/rust/test/sysroot/lib/rustlib/$(rustc_host_target)/lib/*; \
> +       cp $(objtree)/rust/test/dummy/target/$(rustc_host_target)/debug/deps/* \
> +               $(objtree)/rust/test/sysroot/lib/rustlib/$(rustc_host_target)/lib
> +
> +rusttest-prepare: FORCE
> +       $(call if_changed,rustsysroot)
> +
> +rusttest-macros: private rustc_target_flags = --extern proc_macro
> +rusttest-macros: private rustdoc_test_target_flags = --crate-type proc-macro
> +rusttest-macros: $(srctree)/rust/macros/lib.rs rusttest-prepare FORCE
> +       $(call if_changed,rustc_test)
> +       $(call if_changed,rustdoc_test)
> +
> +rusttest-kernel: private rustc_target_flags = --extern alloc \
> +    --extern build_error --extern macros
> +rusttest-kernel: private rustc_test_run_flags = \
> +    --skip bindgen_test_layout_
> +rusttest-kernel: $(srctree)/rust/kernel/lib.rs rusttest-prepare \
> +    rusttestlib-build_error rusttestlib-macros FORCE
> +       $(call if_changed,rustc_test)
> +       $(call if_changed,rustc_test_library)
> +       $(call if_changed,rustdoc_test)
> +
> +ifdef CONFIG_CC_IS_CLANG
> +bindgen_c_flags = $(c_flags)
> +else
> +# bindgen relies on libclang to parse C. Ideally, bindgen would support a GCC
> +# plugin backend and/or the Clang driver would be perfectly compatible with GCC.
> +#
> +# For the moment, here we are tweaking the flags on the fly. Some config
> +# options may not work (e.g. `GCC_PLUGIN_RANDSTRUCT` if we end up using one

Do we denote the conflict in KCONFIG?

> +# of those structs).
> +bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
> +       -mskip-rax-setup -mgeneral-regs-only -msign-return-address=% \
> +       -mindirect-branch=thunk-extern -mindirect-branch-register -mrecord-mcount \
> +       -mabi=lp64 -mstack-protector-guard% -fconserve-stack -falign-jumps=% \
> +       -falign-loops=% -femit-struct-debug-baseonly \
> +       -fno-ipa-cp-clone -fno-ipa-sra -fno-partial-inlining \
> +       -fplugin-arg-arm_ssp_per_task_plugin-% \
> +       -fno-reorder-blocks -fno-allow-store-data-races -fasan-shadow-offset=% \
> +       -Wno-packed-not-aligned -Wno-format-truncation -Wno-format-overflow \
> +       -Wno-stringop-truncation -Wno-unused-but-set-variable \
> +       -Wno-stringop-overflow -Wno-restrict -Wno-maybe-uninitialized \
> +       -Werror=designated-init -Wno-zero-length-bounds \
> +       -Wno-alloc-size-larger-than --param=% --param asan-%

Why do we need to strip out all these warning flags when running
bindgen?  Should be just be using -w to silence all warnings from
clang when invoking bindgen?

> +
> +# We need to keep the quotes for this one -- it comes from a `Kconfig`
> +bindgen_skip_c_flags += "-Wimplicit-fallthrough=%"
> +
> +# PowerPC
> +bindgen_skip_c_flags += -mtraceback=no -mno-pointers-to-nested-functions \
> +       -mno-string -mno-strict-align

I don't understand why the PowerPC specific flags are pulled out, but
the x86 specific ones (like most of the -m flags in the initial
defiition of bindgen_skip_c_flags) are not.

> +
> +# Derived from `scripts/Makefile.clang`
> +BINDGEN_TARGET_arm     := arm-linux-gnueabi
> +BINDGEN_TARGET_arm64   := aarch64-linux-gnu
> +BINDGEN_TARGET_powerpc := powerpc64le-linux-gnu
> +BINDGEN_TARGET_riscv   := riscv64-linux-gnu
> +BINDGEN_TARGET_x86     := x86_64-linux-gnu
> +BINDGEN_TARGET         := $(BINDGEN_TARGET_$(SRCARCH))
> +
> +bindgen_extra_c_flags = --target=$(BINDGEN_TARGET) \
> +       -Wno-address-of-packed-member \
> +       -Wno-gnu-variable-sized-type-not-at-end
> +bindgen_c_flags = $(filter-out $(bindgen_skip_c_flags), $(c_flags)) \
> +       $(bindgen_extra_c_flags)
> +endif
> +
> +ifdef CONFIG_LTO
> +bindgen_c_flags_lto = $(filter-out $(CC_FLAGS_LTO), $(bindgen_c_flags))
> +else
> +bindgen_c_flags_lto = $(bindgen_c_flags)
> +endif
> +
> +# To avoid several recompilations in PowerPC, which inserts `-D_TASK_CPU`
> +bindgen_c_flags_final = $(filter-out -D_TASK_CPU=%, $(bindgen_c_flags_lto))
> +
> +quiet_cmd_bindgen = BINDGEN $@
> +      cmd_bindgen = \
> +       $(BINDGEN) $< $(shell grep -v '^\#\|^$$' $(srctree)/rust/bindgen_parameters) \
> +               --use-core --with-derive-default --ctypes-prefix c_types \
> +               --no-debug '.*' \
> +               --size_t-is-usize -o $@ -- $(bindgen_c_flags_final) -DMODULE
> +
> +$(objtree)/rust/bindings_generated.rs: $(srctree)/rust/kernel/bindings_helper.h \
> +       $(srctree)/rust/bindgen_parameters FORCE
> +       $(call if_changed_dep,bindgen)
> +
> +quiet_cmd_bindgen_helper = BINDGEN $@
> +      cmd_bindgen_helper = \
> +       $(BINDGEN) $< --blacklist-type '.*' --whitelist-var '' \
> +               --whitelist-function 'rust_helper_.*' \
> +               --use-core --with-derive-default --ctypes-prefix c_types \
> +               --no-debug '.*' \
> +               --size_t-is-usize -o $@ -- $(bindgen_c_flags_final) \
> +               -I$(objtree)/rust/ -DMODULE; \
> +       sed -Ei 's/pub fn rust_helper_([a-zA-Z0-9_]*)/\#[link_name="rust_helper_\1"]\n    pub fn \1/g' $@
> +
> +$(objtree)/rust/bindings_helpers_generated.rs: $(srctree)/rust/helpers.c FORCE
> +       $(call if_changed_dep,bindgen_helper)
> +
> +quiet_cmd_exports = EXPORTS $@
> +      cmd_exports = \
> +       $(NM) -p --defined-only $< \
> +               | grep -E ' (T|R|D) ' | cut -d ' ' -f 3 \
> +               | xargs -Isymbol \
> +               echo 'EXPORT_SYMBOL_RUST_GPL(symbol);' > $@

This doesn't accidentally export non-GPL symbols as GPL does it?

... snip ...

--
Thanks,
~Nick Desaulniers
