Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454584839BC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 02:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiADBWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 20:22:03 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58904 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230227AbiADBWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 20:22:02 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1n4YWO-0001Ly-LN; Tue, 04 Jan 2022 12:21:53 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 04 Jan 2022 12:21:52 +1100
Date:   Tue, 4 Jan 2022 12:21:52 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v7] lib/crypto: blake2s: include as built-in
Message-ID: <YdOhMPwL9sXllm8X@gondor.apana.org.au>
References: <CAHmME9oPcEjRnqDesPNKJNOsT+i9vmWRxy9c62t+Xu9Nohsi2A@mail.gmail.com>
 <20220103123152.1043972-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103123152.1043972-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 01:31:52PM +0100, Jason A. Donenfeld wrote:
> In preparation for using blake2s in the RNG, we change the way that it
> is wired-in to the build system. Instead of using ifdefs to select the
> right symbol, we use weak symbols. And because ARM doesn't need the
> generic implementation, we make the generic one default only if an arch
> library doesn't need it already, and then have arch libraries that do
> need it opt-in. So that the arch libraries can remain tristate rather
> than bool, we then split the shash part from the glue code.
> 
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: linux-kbuild@vger.kernel.org
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: linux-crypto@vger.kernel.org
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Herbert - As discussed, I still intend to take this via the
> crng/random.git tree because it forms a dependency, and I'd like to send
> a pull very early in the 5.17 cycle. I've taken some care to minimize
> changes to the {arch/*/}crypto/Kconfig files, as you mentioned this
> might cause some conflicts. Your tree should work cleanly on top of this
> commit.

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

> Changes v6->v7:
> - Split arch shash implementations out from the glue code, so that they
>   can remain as tristates, and we thus don't need to touch
>   arch/*/crypto/Kconfig at all.

This looks good to me although I confess that I haven't actually
tried to build it :) Hopefully the build robots will take care of
this.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
