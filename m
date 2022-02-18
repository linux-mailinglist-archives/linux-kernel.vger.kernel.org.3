Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6284BAFBA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 03:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiBRCdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 21:33:37 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiBRCdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 21:33:35 -0500
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2466C2C9E9C;
        Thu, 17 Feb 2022 18:33:18 -0800 (PST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 21I2Wqbn013536;
        Fri, 18 Feb 2022 11:32:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 21I2Wqbn013536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1645151573;
        bh=LEKfwPhCYFoWZc1q0MrZum0LuLfEq93Z5NIneZTPJ2k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E0YUw4elxUu8K9sK0lqwW1TbvQJAYmuvDRfXXw/WFPC33Pj7EzTR4GXh7QY9a6YBt
         AKlOUCG/f0p7qti6DNGdSQ23HOgGlz4wttQ/MMZaUkC8boEahaoNg/5jnjdr4i84Z1
         5sER77O0uYrniZysjY7ejg9FVsHFvJXgZEJGXR18YfvUiJctntR1b8qrc3cjqW15Sr
         wGXtf8Q4326UId6uS3WP6x+pHv79nFp+oYhXhV9J0z7VpQxA73LW/+mSrXTFde2WP2
         c3HERKt8Ixe9LOmTprs49TP9YoQo+3vssWz5tzS6PkwIgc+X30pUMbaCwL9NaXLz2o
         kHm4lcnhB/twA==
X-Nifty-SrcIP: [209.85.210.172]
Received: by mail-pf1-f172.google.com with SMTP id c4so1208318pfl.7;
        Thu, 17 Feb 2022 18:32:52 -0800 (PST)
X-Gm-Message-State: AOAM530E302xmgfi2kCGujLAkQf0TcI1G80Cr+jyGG1Lt7O+S+G7LUa3
        4ezelhd/DjgFbHb8LoR4sgdNC0Xfjl48Wohb5Vw=
X-Google-Smtp-Source: ABdhPJzK/U5/giNpFutHEqZ8mACF2Xo2lL+8QC0ahWNbyq79F5ASP/VIPtqO5v8bxjmM7PXkKARr0/S63Z1kUvJXutQ=
X-Received: by 2002:a63:1d44:0:b0:373:5612:629b with SMTP id
 d4-20020a631d44000000b003735612629bmr4766469pgm.352.1645151569975; Thu, 17
 Feb 2022 18:32:49 -0800 (PST)
MIME-Version: 1.0
References: <20220211051411.2141549-1-masahiroy@kernel.org>
In-Reply-To: <20220211051411.2141549-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 18 Feb 2022 11:32:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNASh_4k4AqGbub2_5VNcxDBRcL0srZrpiEs__ZTdw=W70A@mail.gmail.com>
Message-ID: <CAK7LNASh_4k4AqGbub2_5VNcxDBRcL0srZrpiEs__ZTdw=W70A@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: replace $(if A,A,B) with $(or A,B)
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 2:14 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> $(or ...) is available since GNU Make 3.81, and useful to shorten the
> code in some places.
>
> Covert as follows:
>
>   $(if A,A,B)  -->  $(or A,B)
>
> This patch also converts:
>
>   $(if A, A, B) --> $(or A, B)
>
> Strictly speaking, the latter is not an equivalent conversion because
> spaces after commas remain; if A is not empty, $(if A, A, B) expands
> to " A", while $(or A, B) expands to "A".
>
> Anyway, preceding spaces are not significant in the code hunks I touched.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
> ---

Applied to linux-kbuild.



> Changes in v2:
>   - Fix misconversion in tools/lib/perf/Makefile
>   - Remove spaces before the stray backslash in tools/lib/bpf/Makefile
>   - Mention the presence of preceding spaces is not important this case
>
>  Makefile                                    | 8 ++++----
>  scripts/Makefile.build                      | 3 +--
>  scripts/Makefile.clean                      | 2 +-
>  scripts/Makefile.lib                        | 4 ++--
>  tools/bpf/bpftool/Makefile                  | 4 ++--
>  tools/build/Makefile                        | 2 +-
>  tools/counter/Makefile                      | 2 +-
>  tools/gpio/Makefile                         | 2 +-
>  tools/hv/Makefile                           | 2 +-
>  tools/iio/Makefile                          | 2 +-
>  tools/lib/api/Makefile                      | 2 +-
>  tools/lib/bpf/Makefile                      | 2 +-
>  tools/lib/perf/Makefile                     | 2 +-
>  tools/lib/subcmd/Makefile                   | 2 +-
>  tools/objtool/Makefile                      | 2 +-
>  tools/pci/Makefile                          | 2 +-
>  tools/perf/Makefile.perf                    | 4 ++--
>  tools/power/x86/intel-speed-select/Makefile | 2 +-
>  tools/scripts/utilities.mak                 | 2 +-
>  tools/spi/Makefile                          | 6 +++---
>  tools/tracing/rtla/Makefile                 | 2 +-
>  tools/usb/Makefile                          | 2 +-
>  22 files changed, 30 insertions(+), 31 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 402121aca40a..a700edb54939 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1240,8 +1240,8 @@ define filechk_version.h
>         echo \#define LINUX_VERSION_SUBLEVEL $(SUBLEVEL)
>  endef
>
> -$(version_h): PATCHLEVEL := $(if $(PATCHLEVEL), $(PATCHLEVEL), 0)
> -$(version_h): SUBLEVEL := $(if $(SUBLEVEL), $(SUBLEVEL), 0)
> +$(version_h): PATCHLEVEL := $(or $(PATCHLEVEL), 0)
> +$(version_h): SUBLEVEL := $(or $(SUBLEVEL), 0)
>  $(version_h): FORCE
>         $(call filechk,version.h)
>
> @@ -1624,7 +1624,7 @@ help:
>         @$(MAKE) -f $(srctree)/Documentation/Makefile dochelp
>         @echo  ''
>         @echo  'Architecture specific targets ($(SRCARCH)):'
> -       @$(if $(archhelp),$(archhelp),\
> +       @$(or $(archhelp),\
>                 echo '  No architecture specific help defined for $(SRCARCH)')
>         @echo  ''
>         @$(if $(boards), \
> @@ -1841,7 +1841,7 @@ $(clean-dirs):
>
>  clean: $(clean-dirs)
>         $(call cmd,rmfiles)
> -       @find $(if $(KBUILD_EXTMOD), $(KBUILD_EXTMOD), .) $(RCS_FIND_IGNORE) \
> +       @find $(or $(KBUILD_EXTMOD), .) $(RCS_FIND_IGNORE) \
>                 \( -name '*.[aios]' -o -name '*.ko' -o -name '.*.cmd' \
>                 -o -name '*.ko.*' \
>                 -o -name '*.dtb' -o -name '*.dtbo' -o -name '*.dtb.S' -o -name '*.dt.yaml' \
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index a4b89b757287..7e177d0ee02d 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -40,8 +40,7 @@ include $(srctree)/scripts/Makefile.compiler
>
>  # The filename Kbuild has precedence over Makefile
>  kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
> -kbuild-file := $(if $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Kbuild,$(kbuild-dir)/Makefile)
> -include $(kbuild-file)
> +include $(or $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Makefile)
>
>  include $(srctree)/scripts/Makefile.lib
>
> diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
> index fd6175322470..74cb1c5c3658 100644
> --- a/scripts/Makefile.clean
> +++ b/scripts/Makefile.clean
> @@ -12,7 +12,7 @@ include $(srctree)/scripts/Kbuild.include
>
>  # The filename Kbuild has precedence over Makefile
>  kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
> -include $(if $(wildcard $(kbuild-dir)/Kbuild), $(kbuild-dir)/Kbuild, $(kbuild-dir)/Makefile)
> +include $(or $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Makefile)
>
>  # Figure out what we need to build from the various variables
>  # ==========================================================================
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 40735a3adb54..49377d2c2d20 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -111,7 +111,7 @@ subdir-ym   := $(addprefix $(obj)/,$(subdir-ym))
>  modname-multi = $(sort $(foreach m,$(multi-obj-ym),\
>                 $(if $(filter $*.o, $(call suffix-search, $m, .o, -objs -y -m)),$(m:.o=))))
>
> -__modname = $(if $(modname-multi),$(modname-multi),$(basetarget))
> +__modname = $(or $(modname-multi),$(basetarget))
>
>  modname = $(subst $(space),:,$(__modname))
>  modfile = $(addprefix $(obj)/,$(__modname))
> @@ -434,7 +434,7 @@ MKIMAGE := $(srctree)/scripts/mkuboot.sh
>  # SRCARCH just happens to match slightly more than ARCH (on sparc), so reduces
>  # the number of overrides in arch makefiles
>  UIMAGE_ARCH ?= $(SRCARCH)
> -UIMAGE_COMPRESSION ?= $(if $(2),$(2),none)
> +UIMAGE_COMPRESSION ?= $(or $(2),none)
>  UIMAGE_OPTS-y ?=
>  UIMAGE_TYPE ?= kernel
>  UIMAGE_LOADADDR ?= arch_must_set_this
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 83369f55df61..ebd21a609910 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -78,7 +78,7 @@ CFLAGS += -O2
>  CFLAGS += -W -Wall -Wextra -Wno-unused-parameter -Wno-missing-field-initializers
>  CFLAGS += $(filter-out -Wswitch-enum -Wnested-externs,$(EXTRA_WARNINGS))
>  CFLAGS += -DPACKAGE='"bpftool"' -D__EXPORTED_HEADERS__ \
> -       -I$(if $(OUTPUT),$(OUTPUT),.) \
> +       -I$(or $(OUTPUT),.) \
>         -I$(LIBBPF_INCLUDE) \
>         -I$(srctree)/kernel/bpf/ \
>         -I$(srctree)/tools/include \
> @@ -186,7 +186,7 @@ endif
>
>  $(OUTPUT)%.bpf.o: skeleton/%.bpf.c $(OUTPUT)vmlinux.h $(LIBBPF_BOOTSTRAP)
>         $(QUIET_CLANG)$(CLANG) \
> -               -I$(if $(OUTPUT),$(OUTPUT),.) \
> +               -I$(or $(OUTPUT),.) \
>                 -I$(srctree)/tools/include/uapi/ \
>                 -I$(LIBBPF_BOOTSTRAP_INCLUDE) \
>                 -g -O2 -Wall -target bpf -c $< -o $@
> diff --git a/tools/build/Makefile b/tools/build/Makefile
> index 6f11e6fc9ffe..17cdf01e29a0 100644
> --- a/tools/build/Makefile
> +++ b/tools/build/Makefile
> @@ -36,7 +36,7 @@ TMP_O := $(if $(OUTPUT),$(OUTPUT)feature/,./)
>
>  clean:
>         $(call QUIET_CLEAN, fixdep)
> -       $(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
> +       $(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
>         $(Q)rm -f $(OUTPUT)fixdep
>         $(call QUIET_CLEAN, feature-detect)
>  ifneq ($(wildcard $(TMP_O)),)
> diff --git a/tools/counter/Makefile b/tools/counter/Makefile
> index 5ebc195fd9c0..8843f0fa6119 100644
> --- a/tools/counter/Makefile
> +++ b/tools/counter/Makefile
> @@ -40,7 +40,7 @@ $(OUTPUT)counter_example: $(COUNTER_EXAMPLE)
>  clean:
>         rm -f $(ALL_PROGRAMS)
>         rm -rf $(OUTPUT)include/linux/counter.h
> -       find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
> +       find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
>
>  install: $(ALL_PROGRAMS)
>         install -d -m 755 $(DESTDIR)$(bindir);          \
> diff --git a/tools/gpio/Makefile b/tools/gpio/Makefile
> index 440434027557..d29c9c49e251 100644
> --- a/tools/gpio/Makefile
> +++ b/tools/gpio/Makefile
> @@ -78,7 +78,7 @@ $(OUTPUT)gpio-watch: $(GPIO_WATCH_IN)
>  clean:
>         rm -f $(ALL_PROGRAMS)
>         rm -f $(OUTPUT)include/linux/gpio.h
> -       find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
> +       find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
>
>  install: $(ALL_PROGRAMS)
>         install -d -m 755 $(DESTDIR)$(bindir);          \
> diff --git a/tools/hv/Makefile b/tools/hv/Makefile
> index b57143d9459c..fe770e679ae8 100644
> --- a/tools/hv/Makefile
> +++ b/tools/hv/Makefile
> @@ -47,7 +47,7 @@ $(OUTPUT)hv_fcopy_daemon: $(HV_FCOPY_DAEMON_IN)
>
>  clean:
>         rm -f $(ALL_PROGRAMS)
> -       find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
> +       find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
>
>  install: $(ALL_PROGRAMS)
>         install -d -m 755 $(DESTDIR)$(sbindir); \
> diff --git a/tools/iio/Makefile b/tools/iio/Makefile
> index 5d12ac4e7f8f..fa720f062229 100644
> --- a/tools/iio/Makefile
> +++ b/tools/iio/Makefile
> @@ -58,7 +58,7 @@ $(OUTPUT)iio_generic_buffer: $(IIO_GENERIC_BUFFER_IN)
>  clean:
>         rm -f $(ALL_PROGRAMS)
>         rm -rf $(OUTPUT)include/linux/iio
> -       find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
> +       find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
>
>  install: $(ALL_PROGRAMS)
>         install -d -m 755 $(DESTDIR)$(bindir);          \
> diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
> index a13e9c7f1fc5..e21e1b40b525 100644
> --- a/tools/lib/api/Makefile
> +++ b/tools/lib/api/Makefile
> @@ -60,7 +60,7 @@ $(LIBFILE): $(API_IN)
>
>  clean:
>         $(call QUIET_CLEAN, libapi) $(RM) $(LIBFILE); \
> -       find $(if $(OUTPUT),$(OUTPUT),.) -name \*.o -or -name \*.o.cmd -or -name \*.o.d | xargs $(RM)
> +       find $(or $(OUTPUT),.) -name \*.o -or -name \*.o.cmd -or -name \*.o.d | xargs $(RM)
>
>  FORCE:
>
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index f947b61b2107..36b85aea0393 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -60,7 +60,7 @@ ifndef VERBOSE
>    VERBOSE = 0
>  endif
>
> -INCLUDES = -I$(if $(OUTPUT),$(OUTPUT),.)                               \
> +INCLUDES = -I$(or $(OUTPUT),.) \
>            -I$(srctree)/tools/include -I$(srctree)/tools/include/uapi
>
>  export prefix libdir src obj
> diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
> index 08fe6e3c4089..21df023a2103 100644
> --- a/tools/lib/perf/Makefile
> +++ b/tools/lib/perf/Makefile
> @@ -153,7 +153,7 @@ $(TESTS_STATIC): $(TESTS_IN) $(LIBPERF_A) $(LIBAPI)
>         $(QUIET_LINK)$(CC) -o $@ $^
>
>  $(TESTS_SHARED): $(TESTS_IN) $(LIBAPI)
> -       $(QUIET_LINK)$(CC) -o $@ -L$(if $(OUTPUT),$(OUTPUT),.) $^ -lperf
> +       $(QUIET_LINK)$(CC) -o $@ -L$(or $(OUTPUT),.) $^ -lperf
>
>  make-tests: libs $(TESTS_SHARED) $(TESTS_STATIC)
>
> diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
> index 1c777a72bb39..8f1a09cdfd17 100644
> --- a/tools/lib/subcmd/Makefile
> +++ b/tools/lib/subcmd/Makefile
> @@ -63,7 +63,7 @@ $(LIBFILE): $(SUBCMD_IN)
>
>  clean:
>         $(call QUIET_CLEAN, libsubcmd) $(RM) $(LIBFILE); \
> -       find $(if $(OUTPUT),$(OUTPUT),.) -name \*.o -or -name \*.o.cmd -or -name \*.o.d | xargs $(RM)
> +       find $(or $(OUTPUT),.) -name \*.o -or -name \*.o.cmd -or -name \*.o.d | xargs $(RM)
>
>  FORCE:
>
> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> index 92ce4fce7bc7..0dbd397f319d 100644
> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -13,7 +13,7 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
>  endif
>
>  SUBCMD_SRCDIR          = $(srctree)/tools/lib/subcmd/
> -LIBSUBCMD_OUTPUT       = $(if $(OUTPUT),$(OUTPUT),$(CURDIR)/)
> +LIBSUBCMD_OUTPUT       = $(or $(OUTPUT),$(CURDIR)/)
>  LIBSUBCMD              = $(LIBSUBCMD_OUTPUT)libsubcmd.a
>
>  OBJTOOL    := $(OUTPUT)objtool
> diff --git a/tools/pci/Makefile b/tools/pci/Makefile
> index 4b95a5176355..57744778b518 100644
> --- a/tools/pci/Makefile
> +++ b/tools/pci/Makefile
> @@ -42,7 +42,7 @@ $(OUTPUT)pcitest: $(PCITEST_IN)
>  clean:
>         rm -f $(ALL_PROGRAMS)
>         rm -rf $(OUTPUT)include/
> -       find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
> +       find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
>
>  install: $(ALL_PROGRAMS)
>         install -d -m 755 $(DESTDIR)$(bindir);          \
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index ac861e42c8f7..8583d18a3739 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -724,7 +724,7 @@ endif
>  # get relative building directory (to $(OUTPUT))
>  # and '.' if it's $(OUTPUT) itself
>  __build-dir = $(subst $(OUTPUT),,$(dir $@))
> -build-dir   = $(if $(__build-dir),$(__build-dir),.)
> +build-dir   = $(or $(__build-dir),.)
>
>  prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioctl_array) \
>         $(fadvise_advice_array) \
> @@ -1090,7 +1090,7 @@ bpf-skel-clean:
>
>  clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean
>         $(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-with-kcore $(OUTPUT)perf-iostat $(LANG_BINDINGS)
> -       $(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
> +       $(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
>         $(Q)$(RM) $(OUTPUT).config-detected
>         $(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf perf-read-vdso32 perf-read-vdsox32 $(OUTPUT)pmu-events/jevents $(OUTPUT)$(LIBJVMTI).so
>         $(call QUIET_CLEAN, core-gen)   $(RM)  *.spec *.pyc *.pyo */*.pyc */*.pyo $(OUTPUT)common-cmds.h TAGS tags cscope* $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex* \
> diff --git a/tools/power/x86/intel-speed-select/Makefile b/tools/power/x86/intel-speed-select/Makefile
> index 12c6939dca2a..7eaa517cd403 100644
> --- a/tools/power/x86/intel-speed-select/Makefile
> +++ b/tools/power/x86/intel-speed-select/Makefile
> @@ -43,7 +43,7 @@ $(OUTPUT)intel-speed-select: $(ISST_IN)
>  clean:
>         rm -f $(ALL_PROGRAMS)
>         rm -rf $(OUTPUT)include/linux/isst_if.h
> -       find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
> +       find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
>
>  install: $(ALL_PROGRAMS)
>         install -d -m 755 $(DESTDIR)$(bindir);          \
> diff --git a/tools/scripts/utilities.mak b/tools/scripts/utilities.mak
> index c16ce833079c..172e47273b5d 100644
> --- a/tools/scripts/utilities.mak
> +++ b/tools/scripts/utilities.mak
> @@ -175,5 +175,5 @@ _ge-abspath = $(if $(is-executable),$(1))
>  define get-executable-or-default
>  $(if $($(1)),$(call _ge_attempt,$($(1)),$(1)),$(call _ge_attempt,$(2)))
>  endef
> -_ge_attempt = $(if $(get-executable),$(get-executable),$(call _gea_err,$(2)))
> +_ge_attempt = $(or $(get-executable),$(call _gea_err,$(2)))
>  _gea_err  = $(if $(1),$(error Please set '$(1)' appropriately))
> diff --git a/tools/spi/Makefile b/tools/spi/Makefile
> index 0aa6dbd31fb8..7fccd245a535 100644
> --- a/tools/spi/Makefile
> +++ b/tools/spi/Makefile
> @@ -53,9 +53,9 @@ $(OUTPUT)spidev_fdx: $(SPIDEV_FDX_IN)
>  clean:
>         rm -f $(ALL_PROGRAMS)
>         rm -rf $(OUTPUT)include/
> -       find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete
> -       find $(if $(OUTPUT),$(OUTPUT),.) -name '\.*.o.d' -delete
> -       find $(if $(OUTPUT),$(OUTPUT),.) -name '\.*.o.cmd' -delete
> +       find $(or $(OUTPUT),.) -name '*.o' -delete
> +       find $(or $(OUTPUT),.) -name '\.*.o.d' -delete
> +       find $(or $(OUTPUT),.) -name '\.*.o.cmd' -delete
>
>  install: $(ALL_PROGRAMS)
>         install -d -m 755 $(DESTDIR)$(bindir);          \
> diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
> index 7c39728d08de..3097f132f096 100644
> --- a/tools/tracing/rtla/Makefile
> +++ b/tools/tracing/rtla/Makefile
> @@ -45,7 +45,7 @@ DATADIR       :=      /usr/share
>  DOCDIR :=      $(DATADIR)/doc
>  MANDIR :=      $(DATADIR)/man
>  LICDIR :=      $(DATADIR)/licenses
> -SRCTREE        :=      $(if $(BUILD_SRC),$(BUILD_SRC),$(CURDIR))
> +SRCTREE        :=      $(or $(BUILD_SRC),$(CURDIR))
>
>  # If running from the tarball, man pages are stored in the Documentation
>  # dir. If running from the kernel source, man pages are stored in
> diff --git a/tools/usb/Makefile b/tools/usb/Makefile
> index 1b128e551b2e..c6235667dd46 100644
> --- a/tools/usb/Makefile
> +++ b/tools/usb/Makefile
> @@ -38,7 +38,7 @@ $(OUTPUT)ffs-test: $(FFS_TEST_IN)
>
>  clean:
>         rm -f $(ALL_PROGRAMS)
> -       find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete -o -name '\.*.o.cmd' -delete
> +       find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete -o -name '\.*.o.cmd' -delete
>
>  install: $(ALL_PROGRAMS)
>         install -d -m 755 $(DESTDIR)$(bindir);          \
> --
> 2.32.0
>


-- 
Best Regards
Masahiro Yamada
