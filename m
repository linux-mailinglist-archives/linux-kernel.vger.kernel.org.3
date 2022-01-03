Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07836482DA0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 04:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiACDXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 22:23:46 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58842 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbiACDXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 22:23:45 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1n4Dwc-0006Rn-K0; Mon, 03 Jan 2022 14:23:35 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 03 Jan 2022 14:23:34 +1100
Date:   Mon, 3 Jan 2022 14:23:34 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v6] lib/crypto: blake2s: include as built-in
Message-ID: <YdJsNrsXqPf0CNEc@gondor.apana.org.au>
References: <20220101155937.381821-1-Jason@zx2c4.com>
 <20220102204203.521148-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220102204203.521148-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2022 at 09:42:03PM +0100, Jason A. Donenfeld wrote:
> In preparation for using blake2s in the RNG, we change the way that it
> is wired-in to the build system. Instead of using ifdefs to select the
> right symbol, we use weak symbols. And because ARM doesn't need the
> generic implementation, we make the generic one default only if an arch
> library doesn't need it already, and then have arch libraries that do
> need it opt-in.
> 
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: linux-kbuild@vger.kernel.org
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: linux-crypto@vger.kernel.org
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Herbert - As mentioned with the vPrev, I intend to take this via the
> crng/random.git tree, since it forms a dependency and I'd like to send a
> pull early in 5.17 cycle.

At this point I think we should push this through crypto.  The
changes are too invasive with respect to the crypto Kconfig files.

> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index 285f82647d2b..b7a2e50dcbc8 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -702,7 +702,7 @@ config CRYPTO_BLAKE2S
>  	  See https://blake2.net for further information.
>  
>  config CRYPTO_BLAKE2S_X86
> -	tristate "BLAKE2s digest algorithm (x86 accelerated version)"
> +	bool "BLAKE2s digest algorithm (x86 accelerated version)"
>  	depends on X86 && 64BIT
>  	select CRYPTO_LIB_BLAKE2S_GENERIC
>  	select CRYPTO_ARCH_HAVE_LIB_BLAKE2S

This will break when CRYPTO is disabled because the x86 crypto
glue code depends on the crypto subsystem.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
