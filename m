Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77464503736
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 16:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiDPO54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 10:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbiDPO5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 10:57:54 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B268F640B
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 07:55:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q3so13084884wrj.7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 07:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wKU5suuJsQRAERFYBvrXaD3MlEybxfKoqtPkIxY/Mw0=;
        b=KpifSmm6OSHKvpAaZhZ2n6eLj8+xiV/Xs0lj49+wVce2y0BvP+pf9XdEVK7iVtX48s
         8m777MujNjMORmbAefAgEryZnfC7f01CTW1ESYtkzpQ8BoI9EmwDwqwJa7UJbrp21iwA
         GiigKQCssrNPyeAVPincev86i+fZhkDTXMl/LtS08JUTROaGSslJvVIz+U+i2E/SbUxg
         Q3lsA3xE59xXjs7me1wRyvWtjAZjgREZZqCzCdGvuiE4SrgummOHgDCcWA6uGBuIbB8j
         sh6nO5rz/fkTL8gMb6j83ZfGHc42vqOzYv1XKc+w/1kXPrdUXbZa+tkWQIH1U6fM5KlL
         M8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wKU5suuJsQRAERFYBvrXaD3MlEybxfKoqtPkIxY/Mw0=;
        b=u1d/Mcfr8C1kki/Qj660qR4cPozPvxW/y5PnjAfw/vj9cSBpWBNsE4oDg7Ki+euuVO
         zLpY4buzscfrgJOr7pI0zkt20C/8RqVE1nUOHQZYMteBw3xQhslzZ7j32tBk9CRVtnQH
         gbKEWnrXDVZ5XwW+iAJ0YQDmTk9yrejwCO6aFBgyYPJSeDTnGOSyTgOJ94LvbFWF5q9z
         cDzK+/CSgYJ+tk9J3H48YVoOZzno7nFlhsO5XJP6X0oHi5i3UdB6C45CaNF7WOLslT4s
         pl9Xjg8rcYz+cWFM73HwPRLPJYJGJL+CglcvDEoTu+U9cnlX/RJarD7+mpu4kGt9uDc6
         4kZg==
X-Gm-Message-State: AOAM530KZ+FFWAjzE4Vs7N/OxWqPUINQrBwWiHTZE5Cekg4TuZw2aiaJ
        umVv3uqJCf1i1qJeljcclfPu1rfOTKCtWe5whbDV1w==
X-Google-Smtp-Source: ABdhPJw3f8ar1F0z+loqBz/U+GUuYoFYoV/AtGsySwOXH1XwcxP7ZkFNooDW1K8kHHh/x39iUQcCzVPjE5JAnygl/oY=
X-Received: by 2002:a5d:6241:0:b0:207:ac0e:3549 with SMTP id
 m1-20020a5d6241000000b00207ac0e3549mr2655847wrv.343.1650120918999; Sat, 16
 Apr 2022 07:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220415050003.3257645-1-mattst88@gmail.com>
In-Reply-To: <20220415050003.3257645-1-mattst88@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 16 Apr 2022 10:55:05 -0400
Message-ID: <CAP-5=fXsmoOXrEfx048oMgBLz0xW0Z3MxTw82uTO0McywkLnaQ@mail.gmail.com>
Subject: Re: [PATCH] tools: port perf ui from GTK 2 to GTK 3
To:     Matt Turner <mattst88@gmail.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jelle van der Waa <jvanderwaa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 1:08 AM Matt Turner <mattst88@gmail.com> wrote:
>
> From: Jelle van der Waa <jvanderwaa@redhat.com>
>
> GTK 2 is a legacy API and the newer version is GTK 3 which changes a few
> API functions. gtk_tree_view_set_rules_hint is no longer required since
> theme's are now responsible to handle this, gtk_vbox_new is deprecated
> and replaced by passing the orientation to gtk_box_new. Apart from these
> changes the accessing of the screen changed in GTK which requires using
> new functions for getting geometry. Lastly the GTK_STOCK_OK define is
> deprecated in GTK 3.

This is super super awesome, thanks for doing it! Does it make sense
or do you know what it would take for GTK4 support? I'm trying to test
this on Debian but see missing includes on gtk/gtk.h - good news that
it applies cleanly to Arnaldo's tree. I'm suspecting something wrong
on my end and so will try harder later.

Thanks,
Ian

> Signed-off-by: Jelle van der Waa <jvanderwaa@redhat.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
> Originally sent in 2019. I've rebased it and given it a test.
>
> One problem I've noticed is that C++ symbol names are often broken.
> E.g.:
>
> (perf:3254940): Gtk-WARNING **: 21:47:46.663: Failed to set text from
> markup due to error parsing markup: Error on line 1 char 95:
> =E2=80=9Cstd::char_traits<char=E2=80=9D is not a valid name: =E2=80=9C<=
=E2=80=9D
>
> Presumably we need to call g_markup_escape_text() somewhere, but I
> struggled to find the right place.
>
> Without the patch, the GTK-2 version repeatedly segfaults, so this is an
> improvement regardless.
>
>  tools/build/Makefile.feature                  |  5 +++--
>  tools/build/feature/Makefile                  | 12 +++++-----
>  tools/build/feature/test-all.c                | 10 +++++++++
>  ...est-gtk2-infobar.c =3D> test-gtk3-infobar.c} |  0
>  .../feature/{test-gtk2.c =3D> test-gtk3.c}      |  0
>  tools/perf/Documentation/perf-report.txt      |  2 +-
>  tools/perf/Makefile                           |  2 +-
>  tools/perf/Makefile.config                    | 22 +++++++++----------
>  tools/perf/Makefile.perf                      |  6 ++---
>  tools/perf/builtin-report.c                   |  2 +-
>  tools/perf/builtin-version.c                  |  1 +
>  tools/perf/tests/make                         | 12 +++++-----
>  tools/perf/ui/gtk/annotate.c                  |  2 +-
>  tools/perf/ui/gtk/browser.c                   | 16 ++++++++------
>  tools/perf/ui/gtk/hists.c                     |  6 +----
>  tools/perf/ui/gtk/progress.c                  |  2 +-
>  tools/perf/ui/setup.c                         |  2 +-
>  17 files changed, 56 insertions(+), 46 deletions(-)
>  rename tools/build/feature/{test-gtk2-infobar.c =3D> test-gtk3-infobar.c=
} (100%)
>  rename tools/build/feature/{test-gtk2.c =3D> test-gtk3.c} (100%)
>
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index ae61f464043a..4ce9c514f30b 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -79,8 +79,8 @@ FEATURE_TESTS_EXTRA :=3D                  \
>           compile-32                     \
>           compile-x32                    \
>           cplus-demangle                 \
> -         gtk2                           \
> -         gtk2-infobar                   \
> +         gtk3                           \
> +         gtk3-infobar                   \
>           hello                          \
>           libbabeltrace                  \
>           libbfd-liberty                 \
> @@ -113,6 +113,7 @@ FEATURE_DISPLAY ?=3D              \
>           dwarf                  \
>           dwarf_getlocations     \
>           glibc                  \
> +         gtk3                   \
>           libbfd                 \
>           libbfd-buildid                \
>           libcap                 \
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index de66e1cc0734..82e2cc182c57 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -11,8 +11,8 @@ FILES=3D                                          \
>           test-fortify-source.bin                \
>           test-get_current_dir_name.bin          \
>           test-glibc.bin                         \
> -         test-gtk2.bin                          \
> -         test-gtk2-infobar.bin                  \
> +         test-gtk3.bin                          \
> +         test-gtk3-infobar.bin                  \
>           test-hello.bin                         \
>           test-libaudit.bin                      \
>           test-libbfd.bin                        \
> @@ -205,11 +205,11 @@ $(OUTPUT)test-libtracefs.bin:
>  $(OUTPUT)test-libcrypto.bin:
>         $(BUILD) -lcrypto
>
> -$(OUTPUT)test-gtk2.bin:
> -       $(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/nu=
ll) -Wno-deprecated-declarations
> +$(OUTPUT)test-gtk3.bin:
> +       $(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-3.0 2>/dev/nu=
ll)
>
> -$(OUTPUT)test-gtk2-infobar.bin:
> -       $(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/nu=
ll)
> +$(OUTPUT)test-gtk3-infobar.bin:
> +       $(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-3.0 2>/dev/nu=
ll)
>
>  grep-libs  =3D $(filter -l%,$(1))
>  strip-libs =3D $(filter-out -l%,$(1))
> diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-al=
l.c
> index 5ffafb967b6e..5ec093498cfc 100644
> --- a/tools/build/feature/test-all.c
> +++ b/tools/build/feature/test-all.c
> @@ -70,6 +70,14 @@
>  # include "test-libslang.c"
>  #undef main
>
> +#define main main_test_gtk3
> +# include "test-gtk3.c"
> +#undef main
> +
> +#define main main_test_gtk3_infobar
> +# include "test-gtk3-infobar.c"
> +#undef main
> +
>  #define main main_test_libbfd
>  # include "test-libbfd.c"
>  #undef main
> @@ -187,6 +195,8 @@ int main(int argc, char *argv[])
>         main_test_libelf_getshdrstrndx();
>         main_test_libunwind();
>         main_test_libslang();
> +       main_test_gtk3(argc, argv);
> +       main_test_gtk3_infobar(argc, argv);
>         main_test_libbfd();
>         main_test_libbfd_buildid();
>         main_test_backtrace();
> diff --git a/tools/build/feature/test-gtk2-infobar.c b/tools/build/featur=
e/test-gtk3-infobar.c
> similarity index 100%
> rename from tools/build/feature/test-gtk2-infobar.c
> rename to tools/build/feature/test-gtk3-infobar.c
> diff --git a/tools/build/feature/test-gtk2.c b/tools/build/feature/test-g=
tk3.c
> similarity index 100%
> rename from tools/build/feature/test-gtk2.c
> rename to tools/build/feature/test-gtk3.c
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Docume=
ntation/perf-report.txt
> index 24efc0583c93..e4a7c99c7853 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -314,7 +314,7 @@ OPTIONS
>         requires a tty, if one is not present, as when piping to other
>         commands, the stdio interface is used.
>
> ---gtk:: Use the GTK2 interface.
> +--gtk:: Use the GTK3 interface.
>
>  -k::
>  --vmlinux=3D<file>::
> diff --git a/tools/perf/Makefile b/tools/perf/Makefile
> index f3fe360a35c6..ea3fb4657a91 100644
> --- a/tools/perf/Makefile
> +++ b/tools/perf/Makefile
> @@ -100,7 +100,7 @@ clean:
>  # make -C tools/perf -f tests/make
>  #
>  build-test:
> -       @$(MAKE) SHUF=3D1 -f tests/make REUSE_FEATURES_DUMP=3D1 MK=3DMake=
file SET_PARALLEL=3D1 --no-print-directory tarpkg make_static make_with_gtk=
2 out
> +       @$(MAKE) SHUF=3D1 -f tests/make REUSE_FEATURES_DUMP=3D1 MK=3DMake=
file SET_PARALLEL=3D1 --no-print-directory tarpkg make_static make_with_gtk=
3 out
>
>  build-test-tarball:
>         @$(MAKE) -f tests/make REUSE_FEATURES_DUMP=3D1 MK=3DMakefile SET_=
PARALLEL=3D1 --no-print-directory out
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index f3bf9297bcc0..3bb755fb7676 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -755,20 +755,20 @@ ifndef NO_SLANG
>    endif
>  endif
>
> -ifdef GTK2
> -  FLAGS_GTK2=3D$(CFLAGS) $(LDFLAGS) $(EXTLIBS) $(shell $(PKG_CONFIG) --l=
ibs --cflags gtk+-2.0 2>/dev/null)
> -  $(call feature_check,gtk2)
> -  ifneq ($(feature-gtk2), 1)
> -    msg :=3D $(warning GTK2 not found, disables GTK2 support. Please ins=
tall gtk2-devel or libgtk2.0-dev);
> -    NO_GTK2 :=3D 1
> +ifdef GTK3
> +  FLAGS_GTK3=3D$(CFLAGS) $(LDFLAGS) $(EXTLIBS) $(shell $(PKG_CONFIG) --l=
ibs --cflags gtk+-3.0 2>/dev/null)
> +  $(call feature_check,gtk3)
> +  ifneq ($(feature-gtk3), 1)
> +    msg :=3D $(warning GTK3 not found, disables GTK3 support. Please ins=
tall gtk3-devel or libgtk3.0-dev);
> +    NO_GTK3 :=3D 1
>    else
> -    $(call feature_check,gtk2-infobar)
> -    ifeq ($(feature-gtk2-infobar), 1)
> +    $(call feature_check,gtk3-infobar)
> +    ifeq ($(feature-gtk3-infobar), 1)
>        GTK_CFLAGS :=3D -DHAVE_GTK_INFO_BAR_SUPPORT
>      endif
> -    CFLAGS +=3D -DHAVE_GTK2_SUPPORT
> -    GTK_CFLAGS +=3D $(shell $(PKG_CONFIG) --cflags gtk+-2.0 2>/dev/null)
> -    GTK_LIBS :=3D $(shell $(PKG_CONFIG) --libs gtk+-2.0 2>/dev/null)
> +    CFLAGS +=3D -DHAVE_GTK3_SUPPORT
> +    GTK_CFLAGS +=3D $(shell $(PKG_CONFIG) --cflags gtk+-3.0 2>/dev/null)
> +    GTK_LIBS :=3D $(shell $(PKG_CONFIG) --libs gtk+-3.0 2>/dev/null)
>      EXTLIBS +=3D -ldl
>    endif
>  endif
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 69473a836bae..0211a20242fe 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -48,7 +48,7 @@ include ../scripts/utilities.mak
>  #
>  # Define NO_SLANG if you do not want TUI support.
>  #
> -# Define GTK2 if you want GTK+ GUI support.
> +# Define GTK3 if you want GTK+ GUI support.
>  #
>  # Define NO_DEMANGLE if you do not want C++ symbol demangling.
>  #
> @@ -404,7 +404,7 @@ ifneq ($(OUTPUT),)
>    CFLAGS +=3D -I$(OUTPUT)
>  endif
>
> -ifdef GTK2
> +ifdef GTK3
>    ALL_PROGRAMS +=3D $(OUTPUT)libperf-gtk.so
>    GTK_IN :=3D $(OUTPUT)gtk-in.o
>  endif
> @@ -930,7 +930,7 @@ check: $(OUTPUT)common-cmds.h
>
>  ### Installation rules
>
> -ifdef GTK2
> +ifdef GTK3
>  install-gtk: $(OUTPUT)libperf-gtk.so
>         $(call QUIET_INSTALL, 'GTK UI') \
>                 $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(libdir_SQ)'; \
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 1ad75c7ba074..c3ad5e8e3098 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1213,7 +1213,7 @@ int cmd_report(int argc, const char **argv)
>  #ifdef HAVE_SLANG_SUPPORT
>         OPT_BOOLEAN(0, "tui", &report.use_tui, "Use the TUI interface"),
>  #endif
> -       OPT_BOOLEAN(0, "gtk", &report.use_gtk, "Use the GTK2 interface"),
> +       OPT_BOOLEAN(0, "gtk", &report.use_gtk, "Use the GTK3 interface"),
>         OPT_BOOLEAN(0, "stdio", &report.use_stdio,
>                     "Use the stdio interface"),
>         OPT_BOOLEAN(0, "header", &report.header, "Show data header."),
> diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
> index 9cd074a3d825..63c7e66bbc83 100644
> --- a/tools/perf/builtin-version.c
> +++ b/tools/perf/builtin-version.c
> @@ -60,6 +60,7 @@ static void library_status(void)
>         STATUS(HAVE_DWARF_SUPPORT, dwarf);
>         STATUS(HAVE_DWARF_GETLOCATIONS_SUPPORT, dwarf_getlocations);
>         STATUS(HAVE_GLIBC_SUPPORT, glibc);
> +       STATUS(HAVE_GTK3_SUPPORT, gtk3);
>  #ifndef HAVE_SYSCALL_TABLE_SUPPORT
>         STATUS(HAVE_LIBAUDIT_SUPPORT, libaudit);
>  #endif
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index da013e90a945..cb959dccbe9d 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -72,8 +72,8 @@ make_no_libpython   :=3D NO_LIBPYTHON=3D1
>  make_no_scripts     :=3D NO_LIBPYTHON=3D1 NO_LIBPERL=3D1
>  make_no_newt        :=3D NO_NEWT=3D1
>  make_no_slang       :=3D NO_SLANG=3D1
> -make_no_gtk2        :=3D NO_GTK2=3D1
> -make_no_ui          :=3D NO_NEWT=3D1 NO_SLANG=3D1 NO_GTK2=3D1
> +make_no_gtk3        :=3D NO_GTK3=3D1
> +make_no_ui          :=3D NO_NEWT=3D1 NO_SLANG=3D1 NO_GTK3=3D1
>  make_no_demangle    :=3D NO_DEMANGLE=3D1
>  make_no_libelf      :=3D NO_LIBELF=3D1
>  make_no_libunwind   :=3D NO_LIBUNWIND=3D1
> @@ -93,7 +93,7 @@ make_no_sdt       :=3D NO_SDT=3D1
>  make_no_syscall_tbl :=3D NO_SYSCALL_TABLE=3D1
>  make_with_clangllvm :=3D LIBCLANGLLVM=3D1
>  make_with_libpfm4   :=3D LIBPFM4=3D1
> -make_with_gtk2      :=3D GTK2=3D1
> +make_with_gtk3      :=3D GTK3=3D1
>  make_tags           :=3D tags
>  make_cscope         :=3D cscope
>  make_help           :=3D help
> @@ -113,7 +113,7 @@ make_install_prefix_slash :=3D install prefix=3D/tmp/=
krava/
>  make_static         :=3D LDFLAGS=3D-static NO_PERF_READ_VDSO32=3D1 NO_PE=
RF_READ_VDSOX32=3D1 NO_JVMTI=3D1
>
>  # all the NO_* variable combined
> -make_minimal        :=3D NO_LIBPERL=3D1 NO_LIBPYTHON=3D1 NO_NEWT=3D1 NO_=
GTK2=3D1
> +make_minimal        :=3D NO_LIBPERL=3D1 NO_LIBPYTHON=3D1 NO_NEWT=3D1 NO_=
GTK3=3D1
>  make_minimal        +=3D NO_DEMANGLE=3D1 NO_LIBELF=3D1 NO_LIBUNWIND=3D1 =
NO_BACKTRACE=3D1
>  make_minimal        +=3D NO_LIBNUMA=3D1 NO_LIBAUDIT=3D1 NO_LIBBIONIC=3D1
>  make_minimal        +=3D NO_LIBDW_DWARF_UNWIND=3D1 NO_AUXTRACE=3D1 NO_LI=
BBPF=3D1
> @@ -138,7 +138,7 @@ run +=3D make_no_libpython
>  run +=3D make_no_scripts
>  run +=3D make_no_newt
>  run +=3D make_no_slang
> -run +=3D make_no_gtk2
> +run +=3D make_no_gtk3
>  run +=3D make_no_ui
>  run +=3D make_no_demangle
>  run +=3D make_no_libelf
> @@ -312,7 +312,7 @@ $(run):
>         $(call test,$@) && \
>         rm -rf $@ $$TMP_DEST || (cat $@ ; false)
>
> -make_with_gtk2:
> +make_with_gtk3:
>         $(call clean)
>         @TMP_DEST=3D$$(mktemp -d); \
>         cmd=3D"cd $(PERF) && $(MAKE_F) $($@) $(PARALLEL_OPT) $(O_OPT) DES=
TDIR=3D$$TMP_DEST"; \
> diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
> index 0a50e962f9a3..efd380f124aa 100644
> --- a/tools/perf/ui/gtk/annotate.c
> +++ b/tools/perf/ui/gtk/annotate.c
> @@ -208,7 +208,7 @@ static int symbol__gtk_annotate(struct map_symbol *ms=
, struct evsel *evsel,
>                 if (!pgctx)
>                         return -1;
>
> -               vbox =3D gtk_vbox_new(FALSE, 0);
> +               vbox =3D gtk_box_new(GTK_ORIENTATION_VERTICAL, 0);
>                 notebook =3D gtk_notebook_new();
>                 pgctx->notebook =3D notebook;
>
> diff --git a/tools/perf/ui/gtk/browser.c b/tools/perf/ui/gtk/browser.c
> index 8f3e43d148a8..6fd85b5325ba 100644
> --- a/tools/perf/ui/gtk/browser.c
> +++ b/tools/perf/ui/gtk/browser.c
> @@ -13,19 +13,21 @@ void perf_gtk__signal(int sig)
>         psignal(sig, "perf");
>  }
>
> -void perf_gtk__resize_window(GtkWidget *window)
> +void perf_gtk__resize_window(GtkWidget *widget)
>  {
>         GdkRectangle rect;
> -       GdkScreen *screen;
> -       int monitor;
> +       GdkMonitor *monitor;
> +       GdkDisplay *display;
> +       GdkWindow *window;
>         int height;
>         int width;
>
> -       screen =3D gtk_widget_get_screen(window);
> +       display =3D gdk_display_get_default();
> +       window =3D gtk_widget_get_window(widget);
>
> -       monitor =3D gdk_screen_get_monitor_at_window(screen, window->wind=
ow);
> +       monitor =3D gdk_display_get_monitor_at_window(display, window);
>
> -       gdk_screen_get_monitor_geometry(screen, monitor, &rect);
> +       gdk_monitor_get_geometry(monitor, &rect);
>
>         width   =3D rect.width * 3 / 4;
>         height  =3D rect.height * 3 / 4;
> @@ -58,7 +60,7 @@ GtkWidget *perf_gtk__setup_info_bar(void)
>         content_area =3D gtk_info_bar_get_content_area(GTK_INFO_BAR(info_=
bar));
>         gtk_container_add(GTK_CONTAINER(content_area), label);
>
> -       gtk_info_bar_add_button(GTK_INFO_BAR(info_bar), GTK_STOCK_OK,
> +       gtk_info_bar_add_button(GTK_INFO_BAR(info_bar), "_OK",
>                                 GTK_RESPONSE_OK);
>         g_signal_connect(info_bar, "response",
>                          G_CALLBACK(gtk_widget_hide), NULL);
> diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
> index c83be2d57f7e..5aa2655c7a0a 100644
> --- a/tools/perf/ui/gtk/hists.c
> +++ b/tools/perf/ui/gtk/hists.c
> @@ -395,8 +395,6 @@ static void perf_gtk__show_hists(GtkWidget *window, s=
truct hists *hists,
>                 }
>         }
>
> -       gtk_tree_view_set_rules_hint(GTK_TREE_VIEW(view), TRUE);
> -
>         g_signal_connect(view, "row-activated",
>                          G_CALLBACK(on_row_activated), NULL);
>         gtk_container_add(GTK_CONTAINER(window), view);
> @@ -583,8 +581,6 @@ static void perf_gtk__show_hierarchy(GtkWidget *windo=
w, struct hists *hists,
>         perf_gtk__add_hierarchy_entries(hists, &hists->entries, store,
>                                         NULL, &hpp, min_pcnt);
>
> -       gtk_tree_view_set_rules_hint(GTK_TREE_VIEW(view), TRUE);
> -
>         g_signal_connect(view, "row-activated",
>                          G_CALLBACK(on_row_activated), NULL);
>         gtk_container_add(GTK_CONTAINER(window), view);
> @@ -616,7 +612,7 @@ int evlist__gtk_browse_hists(struct evlist *evlist, c=
onst char *help,
>         if (!pgctx)
>                 return -1;
>
> -       vbox =3D gtk_vbox_new(FALSE, 0);
> +       vbox =3D gtk_box_new(GTK_ORIENTATION_VERTICAL, 0);
>
>         notebook =3D gtk_notebook_new();
>
> diff --git a/tools/perf/ui/gtk/progress.c b/tools/perf/ui/gtk/progress.c
> index eea6fcde518a..aaa7e7f6e4aa 100644
> --- a/tools/perf/ui/gtk/progress.c
> +++ b/tools/perf/ui/gtk/progress.c
> @@ -13,7 +13,7 @@ static void gtk_ui_progress__update(struct ui_progress =
*p)
>         char buf[1024];
>
>         if (dialog =3D=3D NULL) {
> -               GtkWidget *vbox =3D gtk_vbox_new(TRUE, 5);
> +               GtkWidget *vbox =3D gtk_box_new(GTK_ORIENTATION_VERTICAL,=
 5);
>                 GtkWidget *label =3D gtk_label_new(p->title);
>
>                 dialog =3D gtk_window_new(GTK_WINDOW_TOPLEVEL);
> diff --git a/tools/perf/ui/setup.c b/tools/perf/ui/setup.c
> index 700335cde618..1d35e3ad4576 100644
> --- a/tools/perf/ui/setup.c
> +++ b/tools/perf/ui/setup.c
> @@ -14,7 +14,7 @@ int use_browser =3D -1;
>
>  #define PERF_GTK_DSO "libperf-gtk.so"
>
> -#ifdef HAVE_GTK2_SUPPORT
> +#ifdef HAVE_GTK3_SUPPORT
>
>  static int setup_gtk_browser(void)
>  {
> --
> 2.35.1
>
