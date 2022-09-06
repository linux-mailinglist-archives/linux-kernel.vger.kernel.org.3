Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4F15AF7B9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 00:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiIFWMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 18:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiIFWMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 18:12:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70889F0D4;
        Tue,  6 Sep 2022 15:12:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48479615B0;
        Tue,  6 Sep 2022 22:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDA6C433C1;
        Tue,  6 Sep 2022 22:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662502350;
        bh=YLor/aNRqp6Ff9o1HUmyK/bQsNc6c5Q+mE1K1VOmqBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TFGcimLmrqBAShEGqbUXWvHVTCjY5gvJXjNwfW4HiMg+FVpHHMJn0ovDTHjI+IP90
         +C4bdFBMXs8h+R344F9i8e6BbQ3EjzL/criSDPIEq1k9h0EaEa45+TcIc3cojMUvAJ
         8ZXD6BMBhdNa6ka00KuHwbr1T83kAwK/bcUWg7vBYcXWTPufoBflv5GfTLgNZ6p/Ov
         Sv0/BrQZk9QcEkHzsfJGBPwPM4Zq2PNj2yXhlVv/7hGDohgUSjWE7JaBIixLSoDJah
         ztYz774d8UNL/qUfkcAUHUk0903HQRn5Mvq/C2W4so+T7jXj7VRnrKUlkI2B9obZSz
         J1jQZCpFdJiJw==
Date:   Tue, 6 Sep 2022 15:12:28 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Robert Elliott <elliott@hpe.com>
Subject: Re: linux-next: manual merge of the mm tree with the crypto tree
Message-ID: <YxfFzGObDWsylCK+@quark>
References: <20220906202017.5093fd23@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906202017.5093fd23@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 08:20:17PM +1000, Stephen Rothwell wrote:
> diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
> index 9bb0f7939c6b..856f5d8ca65f 100644
> --- a/arch/x86/crypto/Kconfig
> +++ b/arch/x86/crypto/Kconfig
> @@ -5,6 +5,7 @@ menu "Accelerated Cryptographic Algorithms for CPU (x86)"
>  config CRYPTO_CURVE25519_X86
>  	tristate "Public key crypto: Curve25519 (ADX)"
>  	depends on X86 && 64BIT
> +	depends on !KMSAN # avoid false positives from assembly
>  	select CRYPTO_LIB_CURVE25519_GENERIC
>  	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
>  	help
> @@ -16,6 +17,7 @@ config CRYPTO_CURVE25519_X86
>  config CRYPTO_AES_NI_INTEL
>  	tristate "Ciphers: AES, modes: ECB, CBC, CTS, CTR, XTR, XTS, GCM (AES-NI)"
>  	depends on X86
> +	depends on !KMSAN # avoid false positives from assembly
>  	select CRYPTO_AEAD
>  	select CRYPTO_LIB_AES
>  	select CRYPTO_ALGAPI
> @@ -32,6 +34,7 @@ config CRYPTO_AES_NI_INTEL
>  config CRYPTO_BLOWFISH_X86_64
>  	tristate "Ciphers: Blowfish, modes: ECB, CBC"
>  	depends on X86 && 64BIT
> +	depends on !KMSAN # avoid false positives from assembly
>  	select CRYPTO_SKCIPHER
>  	select CRYPTO_BLOWFISH_COMMON
>  	imply CRYPTO_CTR
> @@ -44,6 +47,7 @@ config CRYPTO_BLOWFISH_X86_64
>  config CRYPTO_CAMELLIA_X86_64
>  	tristate "Ciphers: Camellia with modes: ECB, CBC"
>  	depends on X86 && 64BIT
> +	depends on !KMSAN # avoid false positives from assembly
>  	select CRYPTO_SKCIPHER
>  	imply CRYPTO_CTR
>  	help
> @@ -55,6 +59,7 @@ config CRYPTO_CAMELLIA_X86_64
>  config CRYPTO_CAMELLIA_AESNI_AVX_X86_64
>  	tristate "Ciphers: Camellia with modes: ECB, CBC (AES-NI/AVX)"
>  	depends on X86 && 64BIT
> +	depends on !KMSAN # avoid false positives from assembly
>  	select CRYPTO_SKCIPHER
>  	select CRYPTO_CAMELLIA_X86_64
>  	select CRYPTO_SIMD

Are there any options in arch/x86/crypto/Kconfig that *don't* need a dependency
on !KMSAN?  If not, this could be done in a much simpler way.

- Eric
