Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E2957E246
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbiGVNXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGVNXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:23:41 -0400
Received: from redcrew.org (redcrew.org [37.157.195.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA518CEAE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 06:23:40 -0700 (PDT)
Received: from server.danny.cz (85-71-161-19.rce.o2.cz [85.71.161.19])
        by redcrew.org (Postfix) with ESMTP id D7B52A0C;
        Fri, 22 Jul 2022 15:23:38 +0200 (CEST)
Received: from talos.danny.cz (unknown [IPv6:2001:470:5c11:160:47df:83f6:718e:218])
        by server.danny.cz (Postfix) with SMTP id 4D41A11AA6B;
        Fri, 22 Jul 2022 15:23:38 +0200 (CEST)
Date:   Fri, 22 Jul 2022 15:23:38 +0200
From:   Dan =?UTF-8?B?SG9yw6Fr?= <dan@danny.cz>
To:     Michael Ellerman <michael@ellerman.id.au>
Cc:     amd-gfx@lists.freedesktop.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Alex Deucher <alexdeucher@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] amdgpu: re-enable DCN for ppc64le
Message-Id: <20220722152338.da89f3c445f503ab3b349e78@danny.cz>
In-Reply-To: <87o7xhcoqh.fsf@mpe.ellerman.id.au>
References: <20220722082122.571974-1-dan@danny.cz>
        <87o7xhcoqh.fsf@mpe.ellerman.id.au>
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

On Fri, 22 Jul 2022 22:32:06 +1000
Michael Ellerman <michael@ellerman.id.au> wrote:

> Hi Dan,
> 
> [ Cc += linuxppc-dev  ]
> 
> Dan Horák <dan@danny.cz> writes:
> > Commit d11219ad53dc disabled the DCN driver for all platforms that
> > define PPC64 due long build issues during "make allmodconfig" using
> > cross-compilation. Cross-compilation defaults to the ppc64_defconfig
> > and thus big-endian toolchain configuration. The ppc64le platform uses a
> > different ABI and doesn't suffer from the build issues.
> 
> Unfortunately it's a bit messier than that.

yes, seems it is :-)

> The build error occurs when the compiler is built to use a 64-bit long
> double type.
> 
> The ppc64le ABI document says that long double should be 128-bits, but
> there are ppc64le compilers out there that are configured to use 64-bit
> long double, notably the kernel.org crosstool compilers.
> 
> So just testing for CPU_LITTLE_ENDIAN means we'll still get build errors
> on those compilers.
> 
> But I think we can detect the long double size and key off that. Can you
> test the patch below works for you?

yes, it does work, meaning it defines AMD_DC_DCN on Fedora/ppc64le (and
build is OK)


		Dan

> 
> cheers
> 
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 7aa12e88c580..e9f8cd50af99 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -281,6 +281,9 @@ config PPC
>  	# Please keep this list sorted alphabetically.
>  	#
>  
> +config PCC_LONG_DOUBLE_128
> +	def_bool $(success,test "$(shell,echo __LONG_DOUBLE_128__ | $(CC) -E -P -)" = 1)
> +
>  config PPC_BARRIER_NOSPEC
>  	bool
>  	default y
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index b4029c0d5d8c..ec6771e87e73 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -6,7 +6,7 @@ config DRM_AMD_DC
>  	bool "AMD DC - Enable new display engine"
>  	default y
>  	select SND_HDA_COMPONENT if SND_HDA_CORE
> -	select DRM_AMD_DC_DCN if (X86 || PPC64) && !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
> +	select DRM_AMD_DC_DCN if (X86 || PPC_LONG_DOUBLE_128) && !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
>  	help
>  	  Choose this option if you want to use the new display engine
>  	  support for AMDGPU. This adds required support for Vega and
