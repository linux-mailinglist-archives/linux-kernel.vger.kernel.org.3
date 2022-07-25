Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB5A580221
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 17:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbiGYPqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 11:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbiGYPqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 11:46:07 -0400
Received: from redcrew.org (redcrew.org [37.157.195.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B561024
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 08:46:03 -0700 (PDT)
Received: from server.danny.cz (85-71-161-19.rce.o2.cz [85.71.161.19])
        by redcrew.org (Postfix) with ESMTP id E77F4A0C;
        Mon, 25 Jul 2022 17:46:00 +0200 (CEST)
Received: from talos.danny.cz (unknown [IPv6:2001:470:5c11:160:47df:83f6:718e:218])
        by server.danny.cz (Postfix) with SMTP id 1CF5211AA3A;
        Mon, 25 Jul 2022 17:46:00 +0200 (CEST)
Date:   Mon, 25 Jul 2022 17:45:59 +0200
From:   Dan =?UTF-8?B?SG9yw6Fr?= <dan@danny.cz>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     <linuxppc-dev@lists.ozlabs.org>, alexdeucher@gmail.com,
        amd-gfx@lists.freedesktop.org, linux@roeck-us.net,
        <torvalds@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        tpearson@raptorengineering.com
Subject: Re: [PATCH] drm/amdgpu: Re-enable DCN for 64-bit powerpc
Message-Id: <20220725174559.e71243fa54b48fc2183385be@danny.cz>
In-Reply-To: <20220725123918.1903255-1-mpe@ellerman.id.au>
References: <20220725123918.1903255-1-mpe@ellerman.id.au>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; powerpc64le-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2022 22:39:18 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Commit d11219ad53dc ("amdgpu: disable powerpc support for the newer
> display engine") disabled the DCN driver for all of powerpc due to
> unresolved build failures with some compilers.
> 
> Further digging shows that the build failures only occur with compilers
> that default to 64-bit long double.
> 
> Both the ppc64 and ppc64le ABIs define long double to be 128-bits, but
> there are compilers in the wild that default to 64-bits. The compilers
> provided by the major distros (Fedora, Ubuntu) default to 128-bits and
> are not affected by the build failure.
> 
> There is a compiler flag to force 128-bit long double, which may be the
> correct long term fix, but as an interim fix only allow building the DCN
> driver if long double is 128-bits by default.
> 
> The bisection in commit d11219ad53dc must have gone off the rails at
> some point, the build failure occurs all the way back to the original
> commit that enabled DCN support on powerpc, at least with some
> toolchains.
> 
> Depends-on: d11219ad53dc ("amdgpu: disable powerpc support for the newer display engine")
> Fixes: 16a9dea110a6 ("amdgpu: Enable initial DCN support on POWER")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2100

LGTM

Reviewed-by: Dan Horák <dan@danny.cz>


		Dan

> ---
>  arch/powerpc/Kconfig                | 4 ++++
>  drivers/gpu/drm/amd/display/Kconfig | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> Alex, are you OK if I take this via the powerpc tree for v5.19?
> 
> cheers
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 7aa12e88c580..287cc2d4a4b3 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -281,6 +281,10 @@ config PPC
>  	# Please keep this list sorted alphabetically.
>  	#
>  
> +config PPC_LONG_DOUBLE_128
> +	depends on PPC64
> +	def_bool $(success,test "$(shell,echo __LONG_DOUBLE_128__ | $(CC) -E -P -)" = 1)
> +
>  config PPC_BARRIER_NOSPEC
>  	bool
>  	default y
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index 0ba0598eba20..ec6771e87e73 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -6,7 +6,7 @@ config DRM_AMD_DC
>  	bool "AMD DC - Enable new display engine"
>  	default y
>  	select SND_HDA_COMPONENT if SND_HDA_CORE
> -	select DRM_AMD_DC_DCN if X86 && !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
> +	select DRM_AMD_DC_DCN if (X86 || PPC_LONG_DOUBLE_128) && !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
>  	help
>  	  Choose this option if you want to use the new display engine
>  	  support for AMDGPU. This adds required support for Vega and
> -- 
> 2.35.3
> 
