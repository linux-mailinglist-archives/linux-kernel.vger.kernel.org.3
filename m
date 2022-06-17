Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0295500A6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383647AbiFQXVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383585AbiFQXVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:21:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2735D63BC9;
        Fri, 17 Jun 2022 16:20:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACC526139D;
        Fri, 17 Jun 2022 23:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E45C3411B;
        Fri, 17 Jun 2022 23:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655508058;
        bh=rGQzkd/UiwUfhQgTDoLXwSrTOXjHekgheMJITyy09uA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DIxpLU7+kssPmhfoNmY4ItatQtANUCZiyuF4u5aMlisfvlnT0ESt60Zl5bKpNKfyW
         aT3iYZ11rgDHBlrPoJ+SO6pYiEg1aOesizeXYRtX+vFAbXTj0YDFmHV9u64bYK4p5+
         Vv1mtbsDQRmvMoVC7QEyynrc6x8Po+Jg09eRbue+6wJHZsfKj2i006Mjx1K70cks8k
         7tnN49u/VFd8Kj4SeG43ltbog/mshHR5pwRSd4lk+jXEafdegg0y9kAfUP8vQwU237
         oJa6H74fvuRinmyH3ujlKoDZfm06Benh0STXmaqmscJ6ed1f6u5JCYeoMLotCeoH+p
         tcf/LY8yZOv5g==
Date:   Fri, 17 Jun 2022 16:20:55 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Tom Rix <trix@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] scripts/Makefile.clang: set --target for host based on
 make -v
Message-ID: <Yq0MV2Z/hqSuSYbt@dev-arch.thelio-3990X>
References: <20220617203948.3714905-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617203948.3714905-1-ndesaulniers@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 01:39:48PM -0700, Nick Desaulniers wrote:
> We're working on providing statically linked images of clang to host on
> kernel.org. We're building them in Alpine Linux based Docker containers,
> which are MUSL based systems.
> 
> In order to keep bootstrapping simpler, I'd like for them to have an
> implicit default --target of x86_64-alpine-linux-musl (set via LLVM's
> cmake variable LLVM_DEFAULT_TARGET_TRIPLE).
> 
> Similarly, if one were to use a different build of clang meant for a
> glibc or bionic based system on a MUSL based host, we'd prefer to use
> the correct MUSL based triple for target hosts.
> 
> Borrowed from the Zen of Python: Explicit is better than implicit. Let's
> be explicit about the target triple for HOSTCC when building with
> HOSTCC=clang or LLVM=1.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

I have tested this with a few different distributions on both aarch64
and x86_64:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

One small comment below.

> ---
>  Makefile               |  3 +--
>  scripts/Makefile.clang | 10 ++++++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 1a6678d817bd..87712d9b043c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -600,10 +600,9 @@ endif
>  # CC_VERSION_TEXT is referenced from Kconfig (so it needs export),
>  # and from include/config/auto.conf.cmd to detect the compiler upgrade.
>  CC_VERSION_TEXT = $(subst $(pound),,$(shell LC_ALL=C $(CC) --version 2>/dev/null | head -n 1))
> +HOSTCC_VERSION_TEXT = $(subst $(pound),,$(shell LC_ALL=C $(HOSTCC) --version 2>/dev/null | head -n 1))
>  
> -ifneq ($(findstring clang,$(CC_VERSION_TEXT)),)
>  include $(srctree)/scripts/Makefile.clang
> -endif
>  
>  # Include this also for config targets because some architectures need
>  # cc-cross-prefix to determine CROSS_COMPILE.
> diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> index 87285b76adb2..a4505cd62d7b 100644
> --- a/scripts/Makefile.clang
> +++ b/scripts/Makefile.clang
> @@ -1,3 +1,4 @@
> +ifneq ($(findstring clang,$(CC_VERSION_TEXT)),)
>  # Individual arch/{arch}/Makefiles should use -EL/-EB to set intended
>  # endianness and -m32/-m64 to set word size based on Kconfigs instead of
>  # relying on the target triple.
> @@ -39,3 +40,12 @@ CLANG_FLAGS	+= -Werror=ignored-optimization-argument
>  KBUILD_CFLAGS	+= $(CLANG_FLAGS)
>  KBUILD_AFLAGS	+= $(CLANG_FLAGS)
>  export CLANG_FLAGS
> +endif
> +
> +# If HOSTCC is clang, set the host target triple explicitly; do not rely on
> +# implicit defaults.
> +ifneq ($(findstring clang,$(HOSTCC_VERSION_TEXT)),)
> +HOST_TRIPLE		:= --target=$(shell make --version | head -n2 | tail -n1 | cut -d ' ' -f 3)

Should we use $(MAKE) instead of make here? I guess the only case where
it would matter is if someone was calling make via an explicit path and
did not have it available in their PATH so maybe it is not worth
worrying about.

> +KBUILD_HOSTCFLAGS	+= $(HOST_TRIPLE)
> +KBUILD_HOSTLDFLAGS	+= $(HOST_TRIPLE)
> +endif
> 
> base-commit: 79fe0f863f920c5fcf9dea61676742f813f0b7a6
> -- 
> 2.36.1.476.g0c4daa206d-goog
> 
> 
