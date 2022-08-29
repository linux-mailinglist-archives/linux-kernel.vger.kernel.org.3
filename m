Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AF05A545A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiH2TOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiH2TOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:14:47 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF72926D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:14:44 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id p18so5697465ljc.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Y8cn/Ka3pcZLBE1C037RI6dkwIa2wol9roLu1FJAIwI=;
        b=cF+kdAvc4wBcoWhrn/GOzEioVwY+NRlToBqYoVLuTvU9cB/S9BjUxM8IeKAuLlNfLs
         guxPRuRbI4aNt0dY7ubYOam97BUkWCvn2zaohD+yHmSmgxHdMlkIQhOORX/BNs0DnxSD
         FT6goqc6eE2lYQLdw9NjixEPA1a3hsprxC+cDgM3/LIwOKRzCzLyD7le4hmCakgQ0D0j
         qHgxEtdVqmW+EJ5LtmaTr2QQRTXHtWLcz71Y6QM/cGMUW+VzafNLIlTf8vArp0uYIrw/
         Qh+kh8gLNj5UZZaVLMu95sLnyFB3F9eFXiMfPbmm5m1qh3iP9z4e2IbaNsvNs8IA17HF
         Qbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Y8cn/Ka3pcZLBE1C037RI6dkwIa2wol9roLu1FJAIwI=;
        b=kha/xr5dixZkIjAcAmVvHHkpmd1S7gzL79tW7ianNQj+9HzY0Nr6jv7BM1eny3ZhBJ
         QR9NpAPbMUIPeVRN0rnGnQv7XfFZW3M+Bfn/yVxOZDD0qocmOQKlOyvMvpfD/66mzvKd
         PjsC2QlOMzDZEg1x0Sm873hww0bfb5VYu4NNlyRcQT0DoQWlaar0rr7ZSF4F4jUkosAb
         3uouZ3lY2vFfWm/rtEh13Jd4vxGRsaVFWf/F3jiTRq6fEHkmiVTeVfzWa94qeRi3Uway
         oNtYrTM04tbGBN44Q4LCeh8kekMfJr9LnyZJ5Ke7bJRJQn/kUHwRFojF0s23qf4KZGmQ
         jjfA==
X-Gm-Message-State: ACgBeo2DSScoxsKgWPvArsnGqunI5qzuB1Xi3sf+fn1u8OxeWBqjrUpI
        pMnJo3k+gaG3ykudCYLUOwC/dIyYzefJ+aiUUcLk5Q==
X-Google-Smtp-Source: AA6agR5P7HwgcXKioSMOaHmqYnD0Zdm6r3YM9ykmsuJ9lZHHOWUMc2YeLsDh/5cR/Rn2ia4E+vs5JMAz7+l704S1p8U=
X-Received: by 2002:a2e:a910:0:b0:261:b408:1169 with SMTP id
 j16-20020a2ea910000000b00261b4081169mr6255451ljq.360.1661800482927; Mon, 29
 Aug 2022 12:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220827164056.3365356-1-masahiroy@kernel.org>
In-Reply-To: <20220827164056.3365356-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Aug 2022 12:14:31 -0700
Message-ID: <CAKwvOdkZY5R-pU-Obz0GgwXfL=POqXkkMwidj=C3pip_vxMuog@mail.gmail.com>
Subject: Re: [PATCH] powerpc: clean up binutils version check
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kbuild@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Daniel Axtens <dja@axtens.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Sat, Aug 27, 2022 at 9:43 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The checkbin in arch/powerpc/Makefile errors out if ld <= 2.24.
> So, the requirement on PPC is binutils >= 2.25. It is cleaner to
> specify it in scripts/min-tool-version.sh. If binutils < 2.25 is
> used, the toolchain check will fail in the Kconfig stage going
> forward.

Thoughts on making binutils 2.25.1 the new minimal support version for
all architectures? We already require GCC 5.1. Looking at

https://gcc.gnu.org/releases.html

that was released on April 22, 2015.  Looking at

https://ftp.gnu.org/gnu/binutils/

2.25 was released on 2014-12-23 and 2.25.1 on 2015-07-21.

Current minimum is 2.23 released on 2012-10-22.  Almost 10 years old.

>
> Since binutils >= 2.25 is already required, another version test
> for --save-restore-funcs on PPC64 is always met.
>
> PPC is the last user of ld-ifversion. With all the callers removed,
> the macro definition in scripts/Makefile.compiler can go away.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/powerpc/Makefile       | 21 ---------------------
>  arch/powerpc/lib/Makefile   |  8 --------
>  scripts/Makefile.compiler   |  4 ----
>  scripts/min-tool-version.sh |  8 +++++++-
>  4 files changed, 7 insertions(+), 34 deletions(-)
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 02742facf895..fb607758eeca 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -46,13 +46,7 @@ UTS_MACHINE := $(subst $(space),,$(machine-y))
>  ifdef CONFIG_PPC32
>  KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
>  else
> -ifeq ($(call ld-ifversion, -ge, 22500, y),y)
> -# Have the linker provide sfpr if possible.
> -# There is a corresponding test in arch/powerpc/lib/Makefile
>  KBUILD_LDFLAGS_MODULE += --save-restore-funcs
> -else
> -KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
> -endif
>  endif
>
>  ifdef CONFIG_CPU_LITTLE_ENDIAN
> @@ -395,8 +389,6 @@ vdso_prepare: prepare0
>                 $(build)=arch/powerpc/kernel/vdso include/generated/vdso64-offsets.h)
>  endif
>
> -archprepare: checkbin
> -
>  archheaders:
>         $(Q)$(MAKE) $(build)=arch/powerpc/kernel/syscalls all
>
> @@ -411,16 +403,3 @@ else
>         $(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "TASK_CANARY") print $$3;}' include/generated/asm-offsets.h))
>  endif
>  endif
> -
> -PHONY += checkbin
> -# Check toolchain versions:
> -# - gcc-4.6 is the minimum kernel-wide version so nothing required.
> -checkbin:
> -       @if test "x${CONFIG_LD_IS_LLD}" != "xy" -a \
> -               "x$(call ld-ifversion, -le, 22400, y)" = "xy" ; then \
> -               echo -n '*** binutils 2.24 miscompiles weak symbols ' ; \
> -               echo 'in some circumstances.' ; \
> -               echo    '*** binutils 2.23 do not define the TOC symbol ' ; \
> -               echo -n '*** Please use a different binutils version.' ; \
> -               false ; \
> -       fi
> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
> index 8560c912186d..5eb3971ccb9c 100644
> --- a/arch/powerpc/lib/Makefile
> +++ b/arch/powerpc/lib/Makefile
> @@ -38,14 +38,6 @@ obj-$(CONFIG_PPC32)  += div64.o copy_32.o crtsavres.o
>
>  obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
>
> -# See corresponding test in arch/powerpc/Makefile
> -# 64-bit linker creates .sfpr on demand for final link (vmlinux),
> -# so it is only needed for modules, and only for older linkers which
> -# do not support --save-restore-funcs
> -ifeq ($(call ld-ifversion, -lt, 22500, y),y)
> -extra-$(CONFIG_PPC64)  += crtsavres.o
> -endif
> -
>  obj-$(CONFIG_PPC_BOOK3S_64) += copyuser_power7.o copypage_power7.o \
>                                memcpy_power7.o restart_table.o
>
> diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
> index 94d0d40cddb3..63e7d79dd877 100644
> --- a/scripts/Makefile.compiler
> +++ b/scripts/Makefile.compiler
> @@ -68,7 +68,3 @@ cc-ifversion = $(shell [ $(CONFIG_GCC_VERSION)0 $(1) $(2)000 ] && echo $(3) || e
>  # ld-option
>  # Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)
>  ld-option = $(call try-run, $(LD) $(KBUILD_LDFLAGS) $(1) -v,$(1),$(2),$(3))
> -
> -# ld-ifversion
> -# Usage:  $(call ld-ifversion, -ge, 22252, y)
> -ld-ifversion = $(shell [ $(CONFIG_LD_VERSION)0 $(1) $(2)0 ] && echo $(3) || echo $(4))
> diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> index 250925aab101..7df9f2150ea1 100755
> --- a/scripts/min-tool-version.sh
> +++ b/scripts/min-tool-version.sh
> @@ -14,7 +14,13 @@ fi
>
>  case "$1" in
>  binutils)
> -       echo 2.23.0
> +       if [ "$SRCARCH" = powerpc ]; then
> +               # binutils 2.24 miscompiles weak symbols in some circumstances
> +               # binutils 2.23 do not define the TOC symbol
> +               echo 2.25.0
> +       else
> +               echo 2.23.0
> +       fi
>         ;;
>  gcc)
>         echo 5.1.0
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
