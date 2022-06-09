Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74B0544FE2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbiFIOzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbiFIOzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:55:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A8236BD8D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 07:55:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A05A61EAF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 14:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4979BC34115;
        Thu,  9 Jun 2022 14:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654786521;
        bh=eg4c/i/irnZMEP6mKQEIVBuI8eTDIHIJs8haa+fIvEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G/lF9txPIpYj7wQCrO7ZR6jp1sCTYQsybNCn462UCC20Ci3sPcCtD2QbMjR64aUI6
         Y0x0H7GAHpjc3ONci92SBr0BdLzfFXiI2vvpJ3OONtzxraxqGoms9/azOVfHind3bq
         oG9PhpLNWWb+675nxPEeME6Ks9ILtA3my/WHcRT97J2lANfgERYKRLE29Ul01ioW5f
         4DCeAzjxWTvnH+dSHExpt3TURfviqsm8lJAb7xbPh1lkjUiu2fQDFjVzWbEdLpyhh1
         1F320MFREkEUuIdXQBBxpwUzp+6doe4pqO+dGaJx90XR8jay2eeYQE2tjkS9BRrTJ4
         2xnnMClezxPnw==
Date:   Thu, 9 Jun 2022 07:55:18 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390: disable -Warray-bounds
Message-ID: <YqIJ1iimwIlFDa4n@dev-arch.thelio-3990X>
References: <20220422134308.1613610-1-svens@linux.ibm.com>
 <202204221052.85D0C427@keescook>
 <CAHk-=wjahn2fZtMxmc4D9UOUGWVws1wZ=X46jrTV=_tEpzXeoA@mail.gmail.com>
 <202206081404.F98F5FC53E@keescook>
 <CAHk-=wiFn-_OaWKY=nXt3YSiy=obrNoQW_u7zKO7qoArez=GUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiFn-_OaWKY=nXt3YSiy=obrNoQW_u7zKO7qoArez=GUw@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 04:59:29PM -0700, Linus Torvalds wrote:

Just one small drive by comment in case this ends up going in in one
form or another.

>  Makefile                         |  4 ++++
>  arch/s390/Makefile               | 10 +---------
>  drivers/gpu/drm/imx/ipuv3-crtc.c |  2 +-
>  init/Kconfig                     |  5 +++++
>  4 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index c43d825a3c4c..b2e93c1a8021 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -788,6 +788,7 @@ stackp-flags-$(CONFIG_STACKPROTECTOR_STRONG)      := -fstack-protector-strong
>  KBUILD_CFLAGS += $(stackp-flags-y)
>  
>  KBUILD_CFLAGS-$(CONFIG_WERROR) += -Werror
> +KBUILD_CFLAGS-$(CONFIG_CC_NO_ARRAY_BOUNDS) += -Wno-array-bounds
>  KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
>  
>  ifdef CONFIG_CC_IS_CLANG
> @@ -805,6 +806,9 @@ endif
>  KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
>  KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
>  
> +# These result in bogus false positives
> +KBUILD_CFLAGS += $(call cc-disable-warning, dangling-pointer)
> +
>  ifdef CONFIG_FRAME_POINTER
>  KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
>  else
> diff --git a/arch/s390/Makefile b/arch/s390/Makefile
> index d73611b35164..e1abb0d03824 100644
> --- a/arch/s390/Makefile
> +++ b/arch/s390/Makefile
> @@ -32,15 +32,7 @@ KBUILD_CFLAGS_DECOMPRESSOR += -fno-stack-protector
>  KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning, address-of-packed-member)
>  KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
>  KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))
> -
> -ifdef CONFIG_CC_IS_GCC
> -	ifeq ($(call cc-ifversion, -ge, 1200, y), y)
> -		ifeq ($(call cc-ifversion, -lt, 1300, y), y)
> -			KBUILD_CFLAGS += $(call cc-disable-warning, array-bounds)
> -			KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning, array-bounds)
> -		endif
> -	endif
> -endif
> +KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CC_NO_ARRAY_BOUNDS),-Wno-array-bounds)

I think this should be $(CONFIG_CC_NO_ARRAY_BOUNDS)?

>  
>  UTS_MACHINE	:= s390x
>  STACK_SIZE	:= $(if $(CONFIG_KASAN),65536,16384)
> diff --git a/drivers/gpu/drm/imx/ipuv3-crtc.c b/drivers/gpu/drm/imx/ipuv3-crtc.c
> index 9c8829f945b2..f7863d6dea80 100644
> --- a/drivers/gpu/drm/imx/ipuv3-crtc.c
> +++ b/drivers/gpu/drm/imx/ipuv3-crtc.c
> @@ -69,7 +69,7 @@ static void ipu_crtc_disable_planes(struct ipu_crtc *ipu_crtc,
>  	drm_atomic_crtc_state_for_each_plane(plane, old_crtc_state) {
>  		if (plane == &ipu_crtc->plane[0]->base)
>  			disable_full = true;
> -		if (&ipu_crtc->plane[1] && plane == &ipu_crtc->plane[1]->base)
> +		if (ipu_crtc->plane[1] && plane == &ipu_crtc->plane[1]->base)
>  			disable_partial = true;
>  	}
>  
> diff --git a/init/Kconfig b/init/Kconfig
> index c984afc489de..ccb1302d6edd 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -885,6 +885,11 @@ config CC_IMPLICIT_FALLTHROUGH
>  	default "-Wimplicit-fallthrough=5" if CC_IS_GCC && $(cc-option,-Wimplicit-fallthrough=5)
>  	default "-Wimplicit-fallthrough" if CC_IS_CLANG && $(cc-option,-Wunreachable-code-fallthrough)
>  
> +config CC_NO_ARRAY_BOUNDS
> +	bool
> +	depends on CC_IS_GCC
> +	default y if GCC_VERSION >= 120000 && GCC_VERSION < 130000
> +
>  #
>  # For architectures that know their GCC __int128 support is sound
>  #

Cheers,
Nathan
