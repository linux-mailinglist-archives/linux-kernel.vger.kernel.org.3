Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC138534AC5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 09:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbiEZHZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 03:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346406AbiEZHZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 03:25:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E3894192;
        Thu, 26 May 2022 00:25:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DAEC61A8A;
        Thu, 26 May 2022 07:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AE6C385A9;
        Thu, 26 May 2022 07:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653549908;
        bh=8zWwYRkLEgdPAjovWgZqSLEqwiWs98UEK8E5JfHC8y4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HHrruBbz2nRvfAFpeznVaV6wga8FrcRJlNUhTqMfAORQDyVyhjr62RVcmyn26ryZn
         h8+WFrnKa7hb8aIopQexqoi/moMoAF8vrTDpP78XcG9/35aGUw0IXvbpXUR32Lyps0
         hrg5zETs3oZDBnfyH0AHmyT3ft3uIUDtaK3lhLiMT+j+JzjQPJNeVy3Y0LXe8n4dFq
         UkPf7A0xONi5C91qfGc2+f6F5r+HaJWZYD9/igXF2+NLJc8YUc3xvHwvNkQAFXh9LG
         uBTtE3EGoJyob4YiRtdo3mirfNeuLuiyGmXh1lDD3sQhyilrg5hIO2+Ya2H18gK5VK
         nv4HoRPo73eRA==
Date:   Thu, 26 May 2022 00:25:06 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     gaochao <gaochao49@huawei.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH -next] crypto: Fix build error when CRYPTO_BLAKE2S_X86=m
 && CRYPTO_ALGAPI2=m && CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
Message-ID: <Yo8rUkE1/hxum6gt@sol.localdomain>
References: <20220517033630.1182-1-gaochao49@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517033630.1182-1-gaochao49@huawei.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc Jason

On Tue, May 17, 2022 at 11:36:30AM +0800, gaochao wrote:
> If CRYPTO=m, CRYPTO_ALGAPI=m, CRYPTO_ALGAPI2=m, CRYPTO_BLAKE2S_X86=m,
> CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
> bulding fails:
> 
> arch/x86/crypto/blake2s-glue.o: In function `blake2s_compress':
> (.text+0x5a): undefined reference to `crypto_simd_disabled_for_test'
> make: *** [vmlinux] Error 1
> 
> When CRYPTO_MANAGER_EXTRA_TESTS=y, blake2s_compress will call
> crypto_simd_disabled_for_test.
> When CRYPTO_ALGAPI2=m, crypto_algapi build as a module,
> but if CONFIG_CRYPTO_BLAKE2S_X86=m at the same time,
> libblake2s-x86_64.o build with obj-y, this will accuse the above error.
> 
> To fix this error:
> 1 Choose CRYPTO_ALGAPI2 for CRYPTO_BLAKE2S_X86
> when CRYPTO_MANAGER_EXTRA_TESTS=y.
> 2 build libblake2s-x86_64.o as a module when CONFIG_CRYPTO_BLAKE2S_X86=y
> 
> Fixes: 8fc5f2ad896b ("crypto: testmgr - Move crypto_simd_disabled_for_test out")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: gaochao <gaochao49@huawei.com>
> ---
>  arch/x86/crypto/Makefile | 2 +-
>  crypto/Kconfig           | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
> index 2831685adf6f..54b2469fa49a 100644
> --- a/arch/x86/crypto/Makefile
> +++ b/arch/x86/crypto/Makefile
> @@ -63,7 +63,7 @@ sha512-ssse3-y := sha512-ssse3-asm.o sha512-avx-asm.o sha512-avx2-asm.o sha512_s
> 
>  obj-$(CONFIG_CRYPTO_BLAKE2S_X86) += blake2s-x86_64.o
>  blake2s-x86_64-y := blake2s-shash.o
> -obj-$(if $(CONFIG_CRYPTO_BLAKE2S_X86),y) += libblake2s-x86_64.o
> +obj-$(CONFIG_CRYPTO_BLAKE2S_X86) += libblake2s-x86_64.o
>  libblake2s-x86_64-y := blake2s-core.o blake2s-glue.o

I think the (somewhat unusual) use of "obj-$(if $(CONFIG_CRYPTO_BLAKE2S_X86),y)"
is working as intended.  The goal to build the x86 BLAKE2s library into the core
kernel if CONFIG_CRYPTO_BLAKE2S_X86 is set to either y or m.  This change would
break that.  And if we were to make this change, then there would no longer be
any need to have blake2s-x86_64 and libblake2s-x86_64 be separate modules.

> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index 19197469cfab..e61598f8f8c5 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -714,6 +714,7 @@ config CRYPTO_BLAKE2S_X86
>  	depends on X86 && 64BIT
>  	select CRYPTO_LIB_BLAKE2S_GENERIC
>  	select CRYPTO_ARCH_HAVE_LIB_BLAKE2S
> +	select CRYPTO_ALGAPI2 if CRYPTO_MANAGER_EXTRA_TESTS

I expect that we'll run into this problem in the future too.  So just fixing it
for CRYPTO_BLAKE2S_X86 specifically isn't ideal.

How about just making CRYPTO_MANAGER_EXTRA_TESTS depend on CRYPTO_ALGAPI=y?

Or alternatively, move the crypto_simd_disabled_for_test variable into a file in
lib/crypto/.  But the other suggestion would be a bit simpler for now.

- Eric
