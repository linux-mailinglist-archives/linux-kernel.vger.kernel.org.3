Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF465A6EF5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 23:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiH3VNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 17:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiH3VNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 17:13:34 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29C686C09
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:13:33 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p5so14121653lfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=oywZfDIsGL4tKXcPq28Sz6Q76UuTz9kWGjkId3y4V+M=;
        b=omqrweNUqnXpZ7v6XrnYmw432ZzRF8uJMDL5xZmfWKIGxZin/iyuL7r1sxyHjeS+XU
         0lNDFH7n4FE5kRMnZRWqrFCmaJu0bU9BKos6I2zwOZ2gQmXm4udCEurpPdPmzREC9V7q
         Pr1wtslE5QgUDM5eLOlCwS7NditreSOwiFlZwKjp3+paDkV7wNHRzHxJj2t5sykz4QgW
         Sk2qk49eW2q/EZ8+1L5oK7An9clv2FSpukfmevTyMVWcASOWUre4Ny0eN36R0pPHbQDA
         3JCUC9wb0WzKvH+4mZklMFO0VuKpjbCA2lSTX2EgvCFri1JO0Gkqqe13Shjya+wpH3nF
         aPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=oywZfDIsGL4tKXcPq28Sz6Q76UuTz9kWGjkId3y4V+M=;
        b=1z5FbT4KX00Z5NMGHJoC0ZG7b8OP5Sgt/jFUT1hI2GJICIYk99viCYTiWV2hkC8tjh
         5ZZChMbzIP0ivWh92q57Tz+K9Hzd4BxCog0XzJf5vqbuy8FOp/ssvX3SEof6ouHN8a/A
         db7MRawGh7SlDrBlyVSCgegrKQsfs6zrd69mekuJcgoYsWjUSxzhZOiY5eoXqXAOVCIu
         rLn/eu2S3H3e8D7uf8U/8kZA72wgEZb8CcPaTl7NKp0l5jnuYr2dE2udyO0LLuBALZl7
         BeXFZ1vnnb1dudh5TUh/FYYcFKv9RFfxqlMjhc2XpAvdAJmsNBaVQhh1FsKsz8X0c4WP
         /ZCg==
X-Gm-Message-State: ACgBeo3/CHr8GHdmm6ZAKPFNRRJJjdSuaS9xAhNOmZL6R8jYnpK2e7eL
        IGCNStSz9LdbqMSU5iuH8nAaPnsuRC0N2P/K7HqnwapKctA=
X-Google-Smtp-Source: AA6agR5Mm35Ff7nsNoWDk1epY0voEja9ujnt3RTA8tTQVeTCGAk7FouatgDLGRjCpky8mt9zUKKLq00C9B92u31uczU=
X-Received: by 2002:ac2:4f03:0:b0:48a:6061:bd8e with SMTP id
 k3-20020ac24f03000000b0048a6061bd8emr9136668lfr.647.1661894011886; Tue, 30
 Aug 2022 14:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220830190811.323760-1-masahiroy@kernel.org> <20220830190811.323760-2-masahiroy@kernel.org>
In-Reply-To: <20220830190811.323760-2-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 30 Aug 2022 14:13:20 -0700
Message-ID: <CAKwvOd=4F-_5+txzbNy4sC8tADGmiEtbVL64CCiAp7nmgyUTnQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc: remove old code for binutils < 2.25
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
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

On Tue, Aug 30, 2022 at 12:10 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The minimum supported version of binutils has been raised to 2.25.1.
> Drop the old code.
>
> PPC is the last user of ld-ifversion. With all the callers removed,
> the macro definition in scripts/Makefile.compiler can go away.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/powerpc/Makefile     | 21 ---------------------
>  arch/powerpc/lib/Makefile |  8 --------
>  scripts/Makefile.compiler |  4 ----
>  3 files changed, 33 deletions(-)
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

^ Perhaps this comment is still relevant and should not yet be
discarded? Or updated, dropping " if possible".

Either way:
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

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
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
