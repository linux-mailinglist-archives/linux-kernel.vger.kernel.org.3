Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C72B4F07AA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 07:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbiDCFDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 01:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiDCFD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 01:03:28 -0400
X-Greylist: delayed 137896 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Apr 2022 22:01:34 PDT
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B09833EA6;
        Sat,  2 Apr 2022 22:01:34 -0700 (PDT)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 2335175g015229;
        Sun, 3 Apr 2022 14:01:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 2335175g015229
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648962068;
        bh=7SzukooFgeghZVMUYhWQ07kkC17jh3OESGJfc/DPBx0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L9OkPG7UUg+KXNZtDhrIRpmLGyeWbhPBAdtKdKTHYVI6WMFs3TYJ+7kC1KKygWQj8
         9STzmexLKBhLGDdZBUNHE5dA31Nkjbu8r4wCElI+le+eWjtm3Uo1j3ZZsZU0xIpmVE
         AMm7pISlY4cLWDQkVYUGTXvdQytRPeY4AywuEbUb9Kou7etmXFjj5QaVCWI2X3b29W
         e5BiRPQAkCwFrN8C708lvHNsSk4QihoUpUJqVthkbeHpIiptS0xUzAthVb6Vqe2SRm
         Ssf6rYdjOTGrxgTyJl2v1slw5dEU9122a91WCwKPnw0g92G4KZ8A8/Yo5QlhR9ThHS
         TY0mQ25PK05FQ==
X-Nifty-SrcIP: [209.85.216.41]
Received: by mail-pj1-f41.google.com with SMTP id c15-20020a17090a8d0f00b001c9c81d9648so6081316pjo.2;
        Sat, 02 Apr 2022 22:01:07 -0700 (PDT)
X-Gm-Message-State: AOAM532umrDYqPDfmKZYb9Ir00iBVj/pSELUrJNL0Gu09qPxJbu92oic
        dxIDZoH/czcW/V6IDkNmEmHCYo/+i+I8Yy4bwbg=
X-Google-Smtp-Source: ABdhPJwR8rNVft7v5DbeAHFlj8N/xiu+8oHc4lsybNDccgS/xALkPI4r4Vahx1I0UgAgx+hOOeKxvdIfEiLcdkKJLVc=
X-Received: by 2002:a17:90b:4d01:b0:1c9:ec79:1b35 with SMTP id
 mw1-20020a17090b4d0100b001c9ec791b35mr19436318pjb.77.1648962066513; Sat, 02
 Apr 2022 22:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220401231801.1532486-1-ctshao@google.com>
In-Reply-To: <20220401231801.1532486-1-ctshao@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 3 Apr 2022 14:00:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ4EWPvwMc1Rraj9sAH38t7MttU6keaTx_Nb+zJTXDifw@mail.gmail.com>
Message-ID: <CAK7LNAQ4EWPvwMc1Rraj9sAH38t7MttU6keaTx_Nb+zJTXDifw@mail.gmail.com>
Subject: Re: [PATCH v5] kbuild: Allow kernel installation packaging to
 override pkg-config
To:     Chun-Tse Shao <ctshao@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        keyrings@vger.kernel.org, DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 2, 2022 at 8:32 AM Chun-Tse Shao <ctshao@google.com> wrote:
>
> Add HOSTPKG_CONFIG to allow tooling that builds the kernel to override
> what pkg-config and parameters are used.
>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>


Applied to linux-kbuild
with rebasing and Nick'ed Reviewed-by.

Thanks.


> ---
> Changes from v4: https://lore.kernel.org/all/20220306223016.2239094-1-ctshao@google.com/
>   - Fix inconsistent pkg-config in kconfig shell scripts
>   - Tested with make allmodconfig
>
> Changes from v3: https://lore.kernel.org/all/20220304041449.939308-1-ctshao@google.com
>   - Dereference variables using {} instead of () in shell scripts
>   - Tested with make allmodconfig
>
> Changes from v2: https://lore.kernel.org/all/20220302193638.11034-1-ctshao@google.com/
>   - Fix more open coded instance of pkg-config in scripts and certs
>   - Tested with make allmodconfig
>
> Changes from v1: https://lore.kernel.org/all/20220301230629.1892828-1-ctshao@google.com/
>   - Make the commit message more clearer.
> ---
>  Makefile                     |  3 ++-
>  certs/Makefile               |  4 ++--
>  scripts/Makefile             |  4 ++--
>  scripts/dtc/Makefile         |  6 +++---
>  scripts/kconfig/gconf-cfg.sh | 12 ++++++------
>  scripts/kconfig/mconf-cfg.sh | 16 ++++++++--------
>  scripts/kconfig/nconf-cfg.sh | 16 ++++++++--------
>  scripts/kconfig/qconf-cfg.sh | 14 +++++++-------
>  tools/objtool/Makefile       |  4 ++--
>  9 files changed, 40 insertions(+), 39 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index daeb5c88b50b..f6c5bef7e141 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -430,6 +430,7 @@ else
>  HOSTCC = gcc
>  HOSTCXX        = g++
>  endif
> +HOSTPKG_CONFIG = pkg-config
>
>  export KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
>                               -O2 -fomit-frame-pointer -std=gnu89
> @@ -525,7 +526,7 @@ KBUILD_LDFLAGS_MODULE :=
>  KBUILD_LDFLAGS :=
>  CLANG_FLAGS :=
>
> -export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE LD CC
> +export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE LD CC HOSTPKG_CONFIG
>  export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX YACC AWK INSTALLKERNEL
>  export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
>  export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
> diff --git a/certs/Makefile b/certs/Makefile
> index 3ea7fe60823f..fa540d14ef2d 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -89,5 +89,5 @@ targets += x509_revocation_list
>
>  hostprogs := extract-cert
>
> -HOSTCFLAGS_extract-cert.o = $(shell pkg-config --cflags libcrypto 2> /dev/null)
> -HOSTLDLIBS_extract-cert = $(shell pkg-config --libs libcrypto 2> /dev/null || echo -lcrypto)
> +HOSTCFLAGS_extract-cert.o = $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null)
> +HOSTLDLIBS_extract-cert = $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
> diff --git a/scripts/Makefile b/scripts/Makefile
> index ce5aa9030b74..f084f08ed176 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -14,8 +14,8 @@ hostprogs-always-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE)   += insert-sys-cert
>  HOSTCFLAGS_sorttable.o = -I$(srctree)/tools/include
>  HOSTLDLIBS_sorttable = -lpthread
>  HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include
> -HOSTCFLAGS_sign-file.o = $(shell pkg-config --cflags libcrypto 2> /dev/null)
> -HOSTLDLIBS_sign-file = $(shell pkg-config --libs libcrypto 2> /dev/null || echo -lcrypto)
> +HOSTCFLAGS_sign-file.o = $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null)
> +HOSTLDLIBS_sign-file = $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
>
>  ifdef CONFIG_UNWINDER_ORC
>  ifeq ($(ARCH),x86_64)
> diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
> index 95aaf7431bff..743fc08827ea 100644
> --- a/scripts/dtc/Makefile
> +++ b/scripts/dtc/Makefile
> @@ -18,7 +18,7 @@ fdtoverlay-objs       := $(libfdt) fdtoverlay.o util.o
>  # Source files need to get at the userspace version of libfdt_env.h to compile
>  HOST_EXTRACFLAGS += -I $(srctree)/$(src)/libfdt
>
> -ifeq ($(shell pkg-config --exists yaml-0.1 2>/dev/null && echo yes),)
> +ifeq ($(shell $(HOSTPKG_CONFIG) --exists yaml-0.1 2>/dev/null && echo yes),)
>  ifneq ($(CHECK_DT_BINDING)$(CHECK_DTBS),)
>  $(error dtc needs libyaml for DT schema validation support. \
>         Install the necessary libyaml development package.)
> @@ -27,9 +27,9 @@ HOST_EXTRACFLAGS += -DNO_YAML
>  else
>  dtc-objs       += yamltree.o
>  # To include <yaml.h> installed in a non-default path
> -HOSTCFLAGS_yamltree.o := $(shell pkg-config --cflags yaml-0.1)
> +HOSTCFLAGS_yamltree.o := $(shell $(HOSTPKG_CONFIG) --cflags yaml-0.1)
>  # To link libyaml installed in a non-default path
> -HOSTLDLIBS_dtc := $(shell pkg-config yaml-0.1 --libs)
> +HOSTLDLIBS_dtc := $(shell $(HOSTPKG_CONFIG) yaml-0.1 --libs)
>  endif
>
>  # Generated files need one more search path to include headers in source tree
> diff --git a/scripts/kconfig/gconf-cfg.sh b/scripts/kconfig/gconf-cfg.sh
> index 480ecd8b9f41..cbd90c28c05f 100755
> --- a/scripts/kconfig/gconf-cfg.sh
> +++ b/scripts/kconfig/gconf-cfg.sh
> @@ -3,14 +3,14 @@
>
>  PKG="gtk+-2.0 gmodule-2.0 libglade-2.0"
>
> -if [ -z "$(command -v pkg-config)" ]; then
> +if [ -z "$(command -v ${HOSTPKG_CONFIG})" ]; then
>         echo >&2 "*"
> -       echo >&2 "* 'make gconfig' requires 'pkg-config'. Please install it."
> +       echo >&2 "* 'make gconfig' requires '${HOSTPKG_CONFIG}'. Please install it."
>         echo >&2 "*"
>         exit 1
>  fi
>
> -if ! pkg-config --exists $PKG; then
> +if ! ${HOSTPKG_CONFIG} --exists $PKG; then
>         echo >&2 "*"
>         echo >&2 "* Unable to find the GTK+ installation. Please make sure that"
>         echo >&2 "* the GTK+ 2.0 development package is correctly installed."
> @@ -19,12 +19,12 @@ if ! pkg-config --exists $PKG; then
>         exit 1
>  fi
>
> -if ! pkg-config --atleast-version=2.0.0 gtk+-2.0; then
> +if ! ${HOSTPKG_CONFIG} --atleast-version=2.0.0 gtk+-2.0; then
>         echo >&2 "*"
>         echo >&2 "* GTK+ is present but version >= 2.0.0 is required."
>         echo >&2 "*"
>         exit 1
>  fi
>
> -echo cflags=\"$(pkg-config --cflags $PKG)\"
> -echo libs=\"$(pkg-config --libs $PKG)\"
> +echo cflags=\"$(${HOSTPKG_CONFIG} --cflags $PKG)\"
> +echo libs=\"$(${HOSTPKG_CONFIG} --libs $PKG)\"
> diff --git a/scripts/kconfig/mconf-cfg.sh b/scripts/kconfig/mconf-cfg.sh
> index b520e407a8eb..025b565e0b7c 100755
> --- a/scripts/kconfig/mconf-cfg.sh
> +++ b/scripts/kconfig/mconf-cfg.sh
> @@ -4,16 +4,16 @@
>  PKG="ncursesw"
>  PKG2="ncurses"
>
> -if [ -n "$(command -v pkg-config)" ]; then
> -       if pkg-config --exists $PKG; then
> -               echo cflags=\"$(pkg-config --cflags $PKG)\"
> -               echo libs=\"$(pkg-config --libs $PKG)\"
> +if [ -n "$(command -v ${HOSTPKG_CONFIG})" ]; then
> +       if ${HOSTPKG_CONFIG} --exists $PKG; then
> +               echo cflags=\"$(${HOSTPKG_CONFIG} --cflags $PKG)\"
> +               echo libs=\"$(${HOSTPKG_CONFIG} --libs $PKG)\"
>                 exit 0
>         fi
>
> -       if pkg-config --exists $PKG2; then
> -               echo cflags=\"$(pkg-config --cflags $PKG2)\"
> -               echo libs=\"$(pkg-config --libs $PKG2)\"
> +       if ${HOSTPKG_CONFIG} --exists $PKG2; then
> +               echo cflags=\"$(${HOSTPKG_CONFIG} --cflags $PKG2)\"
> +               echo libs=\"$(${HOSTPKG_CONFIG} --libs $PKG2)\"
>                 exit 0
>         fi
>  fi
> @@ -46,7 +46,7 @@ echo >&2 "* Unable to find the ncurses package."
>  echo >&2 "* Install ncurses (ncurses-devel or libncurses-dev"
>  echo >&2 "* depending on your distribution)."
>  echo >&2 "*"
> -echo >&2 "* You may also need to install pkg-config to find the"
> +echo >&2 "* You may also need to install ${HOSTPKG_CONFIG} to find the"
>  echo >&2 "* ncurses installed in a non-default location."
>  echo >&2 "*"
>  exit 1
> diff --git a/scripts/kconfig/nconf-cfg.sh b/scripts/kconfig/nconf-cfg.sh
> index c212255070c0..3a10bac2adb3 100755
> --- a/scripts/kconfig/nconf-cfg.sh
> +++ b/scripts/kconfig/nconf-cfg.sh
> @@ -4,16 +4,16 @@
>  PKG="ncursesw menuw panelw"
>  PKG2="ncurses menu panel"
>
> -if [ -n "$(command -v pkg-config)" ]; then
> -       if pkg-config --exists $PKG; then
> -               echo cflags=\"$(pkg-config --cflags $PKG)\"
> -               echo libs=\"$(pkg-config --libs $PKG)\"
> +if [ -n "$(command -v ${HOSTPKG_CONFIG})" ]; then
> +       if ${HOSTPKG_CONFIG} --exists $PKG; then
> +               echo cflags=\"$(${HOSTPKG_CONFIG} --cflags $PKG)\"
> +               echo libs=\"$(${HOSTPKG_CONFIG} --libs $PKG)\"
>                 exit 0
>         fi
>
> -       if pkg-config --exists $PKG2; then
> -               echo cflags=\"$(pkg-config --cflags $PKG2)\"
> -               echo libs=\"$(pkg-config --libs $PKG2)\"
> +       if ${HOSTPKG_CONFIG} --exists $PKG2; then
> +               echo cflags=\"$(${HOSTPKG_CONFIG} --cflags $PKG2)\"
> +               echo libs=\"$(${HOSTPKG_CONFIG} --libs $PKG2)\"
>                 exit 0
>         fi
>  fi
> @@ -44,7 +44,7 @@ echo >&2 "* Unable to find the ncurses package."
>  echo >&2 "* Install ncurses (ncurses-devel or libncurses-dev"
>  echo >&2 "* depending on your distribution)."
>  echo >&2 "*"
> -echo >&2 "* You may also need to install pkg-config to find the"
> +echo >&2 "* You may also need to install ${HOSTPKG_CONFIG} to find the"
>  echo >&2 "* ncurses installed in a non-default location."
>  echo >&2 "*"
>  exit 1
> diff --git a/scripts/kconfig/qconf-cfg.sh b/scripts/kconfig/qconf-cfg.sh
> index fa564cd795b7..9b695e5cd9b3 100755
> --- a/scripts/kconfig/qconf-cfg.sh
> +++ b/scripts/kconfig/qconf-cfg.sh
> @@ -3,22 +3,22 @@
>
>  PKG="Qt5Core Qt5Gui Qt5Widgets"
>
> -if [ -z "$(command -v pkg-config)" ]; then
> +if [ -z "$(command -v ${HOSTPKG_CONFIG})" ]; then
>         echo >&2 "*"
> -       echo >&2 "* 'make xconfig' requires 'pkg-config'. Please install it."
> +       echo >&2 "* 'make xconfig' requires '${HOSTPKG_CONFIG}'. Please install it."
>         echo >&2 "*"
>         exit 1
>  fi
>
> -if pkg-config --exists $PKG; then
> -       echo cflags=\"-std=c++11 -fPIC $(pkg-config --cflags $PKG)\"
> -       echo libs=\"$(pkg-config --libs $PKG)\"
> -       echo moc=\"$(pkg-config --variable=host_bins Qt5Core)/moc\"
> +if ${HOSTPKG_CONFIG} --exists $PKG; then
> +       echo cflags=\"-std=c++11 -fPIC $(${HOSTPKG_CONFIG} --cflags $PKG)\"
> +       echo libs=\"$(${HOSTPKG_CONFIG} --libs $PKG)\"
> +       echo moc=\"$(${HOSTPKG_CONFIG} --variable=host_bins Qt5Core)/moc\"
>         exit 0
>  fi
>
>  echo >&2 "*"
> -echo >&2 "* Could not find Qt5 via pkg-config."
> +echo >&2 "* Could not find Qt5 via ${HOSTPKG_CONFIG}."
>  echo >&2 "* Please install Qt5 and make sure it's in PKG_CONFIG_PATH"
>  echo >&2 "*"
>  exit 1
> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> index 92ce4fce7bc7..549acc5859e9 100644
> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -19,8 +19,8 @@ LIBSUBCMD             = $(LIBSUBCMD_OUTPUT)libsubcmd.a
>  OBJTOOL    := $(OUTPUT)objtool
>  OBJTOOL_IN := $(OBJTOOL)-in.o
>
> -LIBELF_FLAGS := $(shell pkg-config libelf --cflags 2>/dev/null)
> -LIBELF_LIBS  := $(shell pkg-config libelf --libs 2>/dev/null || echo -lelf)
> +LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
> +LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
>
>  all: $(OBJTOOL)
>
> --
> 2.35.1.1094.g7c7d902a7c-goog
>


-- 
Best Regards
Masahiro Yamada
