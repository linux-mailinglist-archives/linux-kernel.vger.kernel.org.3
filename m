Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B867A5A2F16
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345093AbiHZSpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345119AbiHZSoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:44:34 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D0C167D8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:41:31 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-33dc31f25f9so57255967b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=lPP8ZIOLS6D+TcMlycR/OR+lDE15x2XXqZgNT5DKzz4=;
        b=BVoMBeOyrKSnw5NxEVstnntoqejvil646ntiJcHVzelMDsUyoG4srhTizGO05tCtK+
         CE0IZGiImHFzl1kLyh714dY5gNVaPOf8nQmzWq/if8zDPgdu9BprwDZ4WLIk6zLefVMJ
         6RRoxnlM2kFggt+ANGnUVzLD9OzLvjQXb+hW9jKKiWjkJ8qM7f9lA3Re7Lw++7VKuZdB
         EF8/CHvz/TrzEl/T6gsE1yHmkY90PncBgphWcS1QLuAj0+P4F6Tsr74swhuEiaVvBNfX
         lcQL/sPlxOc+t/BvST3O6GOemuTzNMLWae3vts46vCKVZqdN/9Wg/sx1lYQDGI0j6MNK
         xF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lPP8ZIOLS6D+TcMlycR/OR+lDE15x2XXqZgNT5DKzz4=;
        b=Jw99EmvyzWmbYSAAdOwo9G7IyW5Ay2+eGFQNCcFJpMh+fGwfCiqasy1fXjwLDsIPtQ
         hoK19m7wB+eIPu7lYIUeSjQ7zHoo7AY+E6BiQBMb8A/bNzUSTFkDKxL/rCxO/YSPhlrn
         tUwWmFRLmRtqFX/h+8/RM/ksdCV95wP6pTidFiwvW0MNKmrsyLWGewu8R90K/XbKL4w9
         5xitCIqpuc5thq6WtmHk+5dryfBTOcpEId5/Old9zy3ZZqKixf6IcNjSaBqFYyI2KeNV
         71OwMaaP2zxOjjV2XuENZjZLyUOa8SSLZHQvLNWnpq5DuFjngwjJrxmOmOlkP9+w0TLN
         0cDQ==
X-Gm-Message-State: ACgBeo1ExjlNEckl0jP/wHAiBbQr0x/O7ldlmLBb6hNOaHdSSVfeaRaX
        FiWQqNc/cwX/x/jZiJH3VeGjaelSyeUu9tTr5Tyx
X-Google-Smtp-Source: AA6agR5MtS59v09QYLLx6jYr4V9/pL3zI66lHd0PcVCw+PDNHvxhf3OxtN3YY9xkS3yHZTo8pd69rqgZk8naUfex53Y=
X-Received: by 2002:a25:6ec5:0:b0:676:d7ec:65c5 with SMTP id
 j188-20020a256ec5000000b00676d7ec65c5mr982536ybc.610.1661539288470; Fri, 26
 Aug 2022 11:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220826181035.859042-1-ndesaulniers@google.com> <20220826181035.859042-3-ndesaulniers@google.com>
In-Reply-To: <20220826181035.859042-3-ndesaulniers@google.com>
From:   Bill Wendling <morbo@google.com>
Date:   Fri, 26 Aug 2022 11:41:17 -0700
Message-ID: <CAGG=3QWSAUakO42kubrCap8fp-gm1ERJJAYXTnP1iHk_wrH=BQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] Makefile.debug: re-enable debug info for .S files
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Dmitrii Bundin <dmitrii.bundin.a@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Alexey Alexandrov <aalexand@google.com>,
        Greg Thelen <gthelen@google.com>
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

On Fri, Aug 26, 2022 at 11:10 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Alexey reported that the fraction of unknown filename instances in
> kallsyms grew from ~0.3% to ~10% recently; Bill and Greg tracked it down
> to assembler defined symbols, which regressed as a result of:
>
> commit b8a9092330da ("Kbuild: do not emit debug info for assembly with LLVM_IAS=1")
>
> In that commit, I allude to restoring debug info for assembler defined
> symbols in a follow up patch, but it seems I forgot to do so in
>
> commit a66049e2cf0e ("Kbuild: make DWARF version a choice")
>
> This patch does a few things:
> 1. Add -g to KBUILD_AFLAGS. This will instruct the compiler to instruct
>    the assembler to emit debug info. But this can cause an issue for
>    folks using a newer compiler but older assembler, because the
>    implicit default DWARF version changed from v4 to v5 in gcc-11 and
>    clang-14.
> 2. If the user is using CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT, use a
>    version check to explicitly set -Wa,-gdwarf-<version> for the
>    assembler. There's another problem with this; GAS only gained support
>    for explicit DWARF versions 3-5 in the 2.36 GNU binutils release.
> 3. Wrap -Wa,-gdwarf-<version> in as-option call to test whether the
>    assembler supports that explicit DWARF version.
>
> Link: https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=31bf18645d98b4d3d7357353be840e320649a67d
> Fixes: b8a9092330da ("Kbuild: do not emit debug info for assembly with LLVM_IAS=1")
> Reported-by: Alexey Alexandrov <aalexand@google.com>
> Reported-by: Bill Wendling <morbo@google.com>
> Reported-by: Greg Thelen <gthelen@google.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  scripts/Makefile.debug | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
> index 9f39b0130551..a7a6da7f6e7d 100644
> --- a/scripts/Makefile.debug
> +++ b/scripts/Makefile.debug
> @@ -4,18 +4,32 @@ ifdef CONFIG_DEBUG_INFO_SPLIT
>  DEBUG_CFLAGS   += -gsplit-dwarf
>  else
>  DEBUG_CFLAGS   += -g
> +KBUILD_AFLAGS  += -g
>  endif
>
> -ifndef CONFIG_AS_IS_LLVM
> -KBUILD_AFLAGS  += -Wa,-gdwarf-2
> +ifdef CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> +# gcc-11+, clang-14+
> +ifeq ($(shell [ $(CONFIG_GCC_VERSION) -ge 110000 -o $(CONFIG_CLANG_VERSION) -ge 140000 ] && echo y),y)

Do you think this would be better as a macro? Maybe something like:

if $(call cc-min-version,110000,140000)

where the first argument is GCC's min version and second Clang's min
version. It would be more readable and reusable.

-bw

> +dwarf-version-y := 5
> +else
> +dwarf-version-y := 4
>  endif
> -
> -ifndef CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> +else # !CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
>  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
>  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
>  DEBUG_CFLAGS   += -gdwarf-$(dwarf-version-y)
>  endif
>
> +# Binutils 2.35+ (or clang) required for -gdwarf-{4|5}.
> +# https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=31bf18645d98b4d3d7357353be840e320649a67d
> +ifneq ($(call as-option,-Wa$(comma)-gdwarf-$(dwarf-version-y)),)
> +KBUILD_AFLAGS  += -Wa,-gdwarf-$(dwarf-version-y)
> +else
> +ifndef CONFIG_AS_IS_LLVM
> +KBUILD_AFLAGS  += -Wa,-gdwarf-2
> +endif
> +endif
> +
>  ifdef CONFIG_DEBUG_INFO_REDUCED
>  DEBUG_CFLAGS   += -fno-var-tracking
>  ifdef CONFIG_CC_IS_GCC
> --
> 2.37.2.672.g94769d06f0-goog
>
