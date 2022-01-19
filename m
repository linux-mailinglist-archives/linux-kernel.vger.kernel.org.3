Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C1D493A26
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 13:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354387AbiASMS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 07:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234677AbiASMSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 07:18:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1454BC061574;
        Wed, 19 Jan 2022 04:18:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C680615D5;
        Wed, 19 Jan 2022 12:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF92C004E1;
        Wed, 19 Jan 2022 12:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642594734;
        bh=iDwIc+DUc7OXya/bdZZtCN1X2ndJaDk5bFsU0zq/2TI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UbAM2eQiEL1rH1KxWDPHCYiWRrleLvCXprfbHIiVN84PDsQF31gC5IgxT+sHhWfBJ
         yOl//lTT17LwljJrkIXb6fk8nROOoF/K8kjvfB67vsJNKcVfQUk2sAg10CMSfsFV6t
         JZnCSsEbMWZLe1VXKeSJKzDEMtpKknJXRNyGS/uY38A/SonbxxVnErqyuaiJwXfI//
         tnl4IbzhaYFOxEwiQbNGP/1roievIafNKAFmG82lqyU1K4qa5uYnFVIqcaAlKs8S7u
         gh3+jbwHaJghTxYP/cpS5TQ3rtF2M+8dK8XYULOTTJ8UUcH+OXWEAQ8Qb9l+P7Tb8i
         uWz0AoH7ads6g==
Received: by mail-wm1-f54.google.com with SMTP id c66so5047891wma.5;
        Wed, 19 Jan 2022 04:18:53 -0800 (PST)
X-Gm-Message-State: AOAM531/ikJIMuAsz+e5ycyLI84G/E9uz4ACMWXS1zi0xp1KoVRp3y/h
        sbr0X2pKcYiW8EmA+zY5kR7KdWBgd3DoVw0d6h8=
X-Google-Smtp-Source: ABdhPJxZk6fKzMkFX1LYAekV1S8lD5eU9AS8iqvCI/XPeSpX8nrMJRY7q6XCGwhbCk0JTQJr+o/N2W1N4R3t8GmwHnM=
X-Received: by 2002:a5d:4087:: with SMTP id o7mr28303504wrp.189.1642594732270;
 Wed, 19 Jan 2022 04:18:52 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9oX+4Ek81xy0nBOegqABH0xYqyONAqinsu7GZ7AaQaqYQ@mail.gmail.com>
 <20220119100615.5059-1-miles.chen@mediatek.com> <CAHmME9pQcUxs87EwQwBZNDA4ZzqugTggH+uiNPh=mv5zjp3g3A@mail.gmail.com>
 <CAHmME9pPKjRLmR6zpYFZT7rOOfHsG2ESnDi+QQrDJuGLo1X4JQ@mail.gmail.com> <CAHmME9oGTPS-gVyHQ4o=AxvMJrGH44_tyQ2KPQcfAKgcqC2SnA@mail.gmail.com>
In-Reply-To: <CAHmME9oGTPS-gVyHQ4o=AxvMJrGH44_tyQ2KPQcfAKgcqC2SnA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Jan 2022 13:18:40 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEo8kQNeoCdwvBkkW0UeYFQEJwkZ_nj06qjsBDF2Qu2pQ@mail.gmail.com>
Message-ID: <CAMj1kXEo8kQNeoCdwvBkkW0UeYFQEJwkZ_nj06qjsBDF2Qu2pQ@mail.gmail.com>
Subject: Re: [PATCH] lib/crypto: blake2s: fix a CFI failure
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Miles Chen <miles.chen@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 at 13:15, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> The below kludge of a patch fixes the issue. Still unclear whether we
> should go with something like this or get clang fixed or what.
>
> diff --git a/arch/arm/crypto/blake2s-shash.c b/arch/arm/crypto/blake2s-shash.c
> index 17c1c3bfe2f5..be8cde5f1719 100644
> --- a/arch/arm/crypto/blake2s-shash.c
> +++ b/arch/arm/crypto/blake2s-shash.c
> @@ -13,12 +13,12 @@
>  static int crypto_blake2s_update_arm(struct shash_desc *desc,
>                                      const u8 *in, unsigned int inlen)
>  {
> -       return crypto_blake2s_update(desc, in, inlen, blake2s_compress);
> +       return crypto_blake2s_update(desc, in, inlen);
>  }
>
>  static int crypto_blake2s_final_arm(struct shash_desc *desc, u8 *out)
>  {
> -       return crypto_blake2s_final(desc, out, blake2s_compress);
> +       return crypto_blake2s_final(desc, out);
>  }
>
>  #define BLAKE2S_ALG(name, driver_name, digest_size)                    \
> diff --git a/arch/x86/crypto/blake2s-shash.c b/arch/x86/crypto/blake2s-shash.c
> index f9e2fecdb761..c81ffedb4865 100644
> --- a/arch/x86/crypto/blake2s-shash.c
> +++ b/arch/x86/crypto/blake2s-shash.c
> @@ -18,12 +18,12 @@
>  static int crypto_blake2s_update_x86(struct shash_desc *desc,
>                                      const u8 *in, unsigned int inlen)
>  {
> -       return crypto_blake2s_update(desc, in, inlen, blake2s_compress);
> +       return crypto_blake2s_update(desc, in, inlen);
>  }
>
>  static int crypto_blake2s_final_x86(struct shash_desc *desc, u8 *out)
>  {
> -       return crypto_blake2s_final(desc, out, blake2s_compress);
> +       return crypto_blake2s_final(desc, out);
>  }
>
>  #define BLAKE2S_ALG(name, driver_name, digest_size)                    \
> diff --git a/crypto/blake2s_generic.c b/crypto/blake2s_generic.c
> index 72fe480f9bd6..050874588a84 100644
> --- a/crypto/blake2s_generic.c
> +++ b/crypto/blake2s_generic.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All
> Rights Reserved.
>   */
>
> +#define FORCE_BLAKE2S_GENERIC
>  #include <crypto/internal/blake2s.h>
>  #include <crypto/internal/hash.h>
>

I'd prefer it if we could avoid magic #define's like this. We could
fix it up locally to crypto/internal/blake2s.h just by doing something
like the below.

diff --git a/include/crypto/internal/blake2s.h
b/include/crypto/internal/blake2s.h
index d39cfa0d333e..9e52c07c54cc 100644
--- a/include/crypto/internal/blake2s.h
+++ b/include/crypto/internal/blake2s.h
@@ -39,7 +39,11 @@ static inline void __blake2s_update(struct
blake2s_state *state,
                return;
        if (inlen > fill) {
                memcpy(state->buf + state->buflen, in, fill);
-               (*compress)(state, state->buf, 1, BLAKE2S_BLOCK_SIZE);
+               if (IS_ENABLED(CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S))
+                       (*compress)(state, state->buf, 1, BLAKE2S_BLOCK_SIZE);
+               else
+                       blake2s_compress_generic(state, state->buf, 1,
+                                                BLAKE2S_BLOCK_SIZE);
                state->buflen = 0;
                in += fill;
                inlen -= fill;
@@ -47,7 +51,11 @@ static inline void __blake2s_update(struct
blake2s_state *state,
        if (inlen > BLAKE2S_BLOCK_SIZE) {
                const size_t nblocks = DIV_ROUND_UP(inlen, BLAKE2S_BLOCK_SIZE);
                /* Hash one less (full) block than strictly possible */
-               (*compress)(state, in, nblocks - 1, BLAKE2S_BLOCK_SIZE);
+               if (IS_ENABLED(CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S))
+                       (*compress)(state, in, nblocks - 1, BLAKE2S_BLOCK_SIZE);
+               else
+                       blake2s_compress_generic(state, in, nblocks - 1,
+                                                BLAKE2S_BLOCK_SIZE);
                in += BLAKE2S_BLOCK_SIZE * (nblocks - 1);
                inlen -= BLAKE2S_BLOCK_SIZE * (nblocks - 1);
        }
@@ -61,7 +69,10 @@ static inline void __blake2s_final(struct
blake2s_state *state, u8 *out,
        blake2s_set_lastblock(state);
        memset(state->buf + state->buflen, 0,
               BLAKE2S_BLOCK_SIZE - state->buflen); /* Padding */
-       (*compress)(state, state->buf, 1, state->buflen);
+       if (IS_ENABLED(CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S))
+               (*compress)(state, state->buf, 1, state->buflen);
+       else
+               blake2s_compress_generic(state, state->buf, 1, state->buflen);
        cpu_to_le32_array(state->h, ARRAY_SIZE(state->h));
