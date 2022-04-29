Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C17514058
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 03:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354056AbiD2Bpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 21:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiD2Bpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 21:45:35 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256EABF517
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 18:42:17 -0700 (PDT)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 23T1g281017396
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 10:42:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 23T1g281017396
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651196523;
        bh=MbzkYcIg1gO/oM/adwpVtBKnxxzi/JDtIqr5Bk6XPVk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JComcDRTMmEU5OgYfFF4kavL8KM7Zl57Du93mkNJMrzOk4oxJZ+/P/Bz+bUM9xyhU
         ozLcU72PG5sM1unJFcGhr8NFjP4LUiE7FMHMPOsSshlegsw4NAjt6S/JxxrJaYpuF1
         qODWuffQqVTVeRm1bR1O1UvmfZvEpsacIXiE5aI25rfb2+o9GHXjQyXzRzndPRfvyA
         qC4IhFVPAtxx+dhKtrA61HxkgYUfY1NqmLTg2hOc/OJbHGDrgnqX5DdPfwri6Mu5+c
         auOA2LUBcYWFsGk/fXbiAa8drHbNKRHKriSMW523qWBgXrPkLHri0uBaFcAHPlAn5g
         916Kz7kHbYu+g==
X-Nifty-SrcIP: [209.85.214.180]
Received: by mail-pl1-f180.google.com with SMTP id d15so5890628plh.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 18:42:02 -0700 (PDT)
X-Gm-Message-State: AOAM5322KBTt4fHM1MKR2TnltcCKzzF3DTX9NyXJvd41xAYOw5qrstdo
        U2/WdZaVwqXCLTKRAWGpsGMRdcWLvzFNIH1QWW8=
X-Google-Smtp-Source: ABdhPJzosr2XVQPb/kB7wG4ek5O6PZTPZQMF98jxwX57wMPti9ScJ8Y7+UrUoJBpqzoYymD8bMUQDpkjwLMgoDZzHMo=
X-Received: by 2002:a17:90a:e7d1:b0:1da:30d0:9327 with SMTP id
 kb17-20020a17090ae7d100b001da30d09327mr1286983pjb.144.1651196521892; Thu, 28
 Apr 2022 18:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220428043850.1706973-1-aik@ozlabs.ru>
In-Reply-To: <20220428043850.1706973-1-aik@ozlabs.ru>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 29 Apr 2022 10:40:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS6=OasZXA2cLWoGJr5prQaJuoGpY0toRxNpX3RsUGr0Q@mail.gmail.com>
Message-ID: <CAK7LNAS6=OasZXA2cLWoGJr5prQaJuoGpY0toRxNpX3RsUGr0Q@mail.gmail.com>
Subject: Re: [PATCH kernel] RFC: zstd: Fixing mixed module-builtin objects
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tom Rix <trix@redhat.com>, Nick Terrell <terrelln@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 1:39 PM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
> With CONFIG_ZSTD_COMPRESS=m and CONFIG_ZSTD_DECOMPRESS=y we end up in
> a situation when files from lib/zstd/common/ are compiled once for
> ZSTD_DECOMPRESS (build-in) and ZSTD_COMPRESS (module) even though
> CFLAGS are different for builtins and modules. So far somehow
> this was not a problem until enabling LLVM LTO where it fails:
>
> ld.lld: error: linking module flags 'Code Model': IDs have conflicting values in 'lib/built-in.a(zstd_common.o at 5868)' and 'ld-temp.o'
>
> This particular conflict is caused by KBUILD_CFLAGS=-mcmodel=medium vs.
> KBUILD_CFLAGS_MODULE=-mcmodel=large , modules use the large model on
> POWERPC as explained at
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/Makefile?h=v5.18-rc4#n127
> but the current use of common files is wrong anyway.
>
> This works around the issue by inlining common files and fixing few
> conflicts.
>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>


This patch breaks the build for

CONFIG_ZSTD_COMPRESS=y &&
CONFIG_ZSTD_DECOMPRESS=y

due to so many multiple definitions.


0-day bot may point this out sooner or later.



  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  AR      init/built-in.a
  LD      vmlinux.o
ld: lib/zstd/zstd_decompress_module.o: in function `FSE_versionNumber':
zstd_decompress_module.c:(.text+0x2260): multiple definition of
`FSE_versionNumber';
lib/zstd/zstd_compress_module.o:zstd_compress_module.c:(.text+0x2490):
first defined here
ld: lib/zstd/zstd_decompress_module.o: in function `FSE_getErrorName':
zstd_decompress_module.c:(.text+0x2270): multiple definition of
`FSE_getErrorName';
lib/zstd/zstd_compress_module.o:zstd_compress_module.c:(.text+0x24a0):
first defined here
ld: lib/zstd/zstd_decompress_module.o: in function `HUF_getErrorName':
zstd_decompress_module.c:(.text+0x22a0): multiple definition of
`HUF_getErrorName';
lib/zstd/zstd_compress_module.o:zstd_compress_module.c:(.text+0x24d0):
first defined here
ld: lib/zstd/zstd_decompress_module.o: in function `FSE_readNCount_bmi2':
zstd_decompress_module.c:(.text+0x22d0): multiple definition of
`FSE_readNCount_bmi2';
lib/zstd/zstd_compress_module.o:zstd_compress_module.c:(.text+0x2500):
first defined here
ld: lib/zstd/zstd_decompress_module.o: in function `FSE_readNCount':
zstd_decompress_module.c:(.text+0x22e0): multiple definition of
`FSE_readNCount';
lib/zstd/zstd_compress_module.o:zstd_compress_module.c:(.text+0x2510):
first defined here
ld: lib/zstd/zstd_decompress_module.o: in function `HUF_readStats':
zstd_decompress_module.c:(.text+0x22f0): multiple definition of
`HUF_readStats';
lib/zstd/zstd_compress_module.o:zstd_compress_module.c:(.text+0x2520):
first defined here





> ---
>
> I tried fixing it by hacking Makefile to produce a separate .o for "y" and
> "m", like this:
>
> +obj-common-y =  common/debug-y.o \
> +               common/entropy_common-y.o \
> +               common/error_private-y.o \
> +               common/fse_decompress-y.o \
> +               common/zstd_common-y.o
> +obj-common-m =  common/debug-m.o \
> +               common/entropy_common-m.o \
> +               common/error_private-m.o \
> +               common/fse_decompress-m.o \
> +               common/zstd_common-m.o
> +obj-common-m := $(addprefix $(obj)/, $(obj-common-m))
> +obj-common-y := $(addprefix $(obj)/, $(obj-common-y))
> +
> +$(obj-common-m): $(obj)/%-m.o: %.c FORCE
> +        $(call if_changed_dep,cc_o_c)
> +$(obj-common-y): $(obj)/%-y.o: %.c FORCE
> +        $(call if_changed_dep,cc_o_c)
> +
>
> and so on but could not make it work and I suspect there is
> a better solution to the problem anyway, what is it?
>
>
> ---
>  lib/zstd/Makefile                 | 10 ----------
>  lib/zstd/common/error_private.h   |  2 +-
>  lib/zstd/common/entropy_common.c  |  4 ++--
>  lib/zstd/zstd_compress_module.c   |  6 ++++++
>  lib/zstd/zstd_decompress_module.c |  6 ++++++
>  5 files changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/lib/zstd/Makefile b/lib/zstd/Makefile
> index fc45339fc3a3..ee42f07711ea 100644
> --- a/lib/zstd/Makefile
> +++ b/lib/zstd/Makefile
> @@ -13,11 +13,6 @@ obj-$(CONFIG_ZSTD_DECOMPRESS) += zstd_decompress.o
>
>  zstd_compress-y := \
>                 zstd_compress_module.o \
> -               common/debug.o \
> -               common/entropy_common.o \
> -               common/error_private.o \
> -               common/fse_decompress.o \
> -               common/zstd_common.o \
>                 compress/fse_compress.o \
>                 compress/hist.o \
>                 compress/huf_compress.o \
> @@ -33,11 +28,6 @@ zstd_compress-y := \
>
>  zstd_decompress-y := \
>                 zstd_decompress_module.o \
> -               common/debug.o \
> -               common/entropy_common.o \
> -               common/error_private.o \
> -               common/fse_decompress.o \
> -               common/zstd_common.o \
>                 decompress/huf_decompress.o \
>                 decompress/zstd_ddict.o \
>                 decompress/zstd_decompress.o \
> diff --git a/lib/zstd/common/error_private.h b/lib/zstd/common/error_private.h
> index d14e686adf95..e1570545c6af 100644
> --- a/lib/zstd/common/error_private.h
> +++ b/lib/zstd/common/error_private.h
> @@ -42,7 +42,7 @@ typedef ZSTD_ErrorCode ERR_enum;
>  #define ERROR(name) ZSTD_ERROR(name)
>  #define ZSTD_ERROR(name) ((size_t)-PREFIX(name))
>
> -ERR_STATIC unsigned ERR_isError(size_t code) { return (code > ERROR(maxCode)); }
> +ERR_STATIC inline unsigned ERR_isError(size_t code) { return (code > ERROR(maxCode)); }
>
>  ERR_STATIC ERR_enum ERR_getErrorCode(size_t code) { if (!ERR_isError(code)) return (ERR_enum)0; return (ERR_enum) (0-code); }
>
> diff --git a/lib/zstd/common/entropy_common.c b/lib/zstd/common/entropy_common.c
> index 53b47a2b52ff..863afecb7743 100644
> --- a/lib/zstd/common/entropy_common.c
> +++ b/lib/zstd/common/entropy_common.c
> @@ -28,10 +28,10 @@ unsigned FSE_versionNumber(void) { return FSE_VERSION_NUMBER; }
>
>
>  /*===   Error Management   ===*/
> -unsigned FSE_isError(size_t code) { return ERR_isError(code); }
> +#define FSE_isError  ERR_isError
>  const char* FSE_getErrorName(size_t code) { return ERR_getErrorName(code); }
>
> -unsigned HUF_isError(size_t code) { return ERR_isError(code); }
> +#define HUF_isError  ERR_isError
>  const char* HUF_getErrorName(size_t code) { return ERR_getErrorName(code); }
>
>
> diff --git a/lib/zstd/zstd_compress_module.c b/lib/zstd/zstd_compress_module.c
> index 65548a4bb934..a4ad46fc1f12 100644
> --- a/lib/zstd/zstd_compress_module.c
> +++ b/lib/zstd/zstd_compress_module.c
> @@ -158,3 +158,9 @@ EXPORT_SYMBOL(zstd_end_stream);
>
>  MODULE_LICENSE("Dual BSD/GPL");
>  MODULE_DESCRIPTION("Zstd Compressor");
> +
> +#include "common/debug.c"
> +#include "common/entropy_common.c"
> +#include "common/error_private.c"
> +#include "common/fse_decompress.c"
> +#include "common/zstd_common.c"
> diff --git a/lib/zstd/zstd_decompress_module.c b/lib/zstd/zstd_decompress_module.c
> index f4ed952ed485..21820588835d 100644
> --- a/lib/zstd/zstd_decompress_module.c
> +++ b/lib/zstd/zstd_decompress_module.c
> @@ -103,3 +103,9 @@ EXPORT_SYMBOL(zstd_get_frame_header);
>
>  MODULE_LICENSE("Dual BSD/GPL");
>  MODULE_DESCRIPTION("Zstd Decompressor");
> +
> +#include "common/debug.c"
> +#include "common/entropy_common.c"
> +#include "common/error_private.c"
> +#include "common/fse_decompress.c"
> +#include "common/zstd_common.c"
> --
> 2.30.2
>


-- 
Best Regards
Masahiro Yamada
