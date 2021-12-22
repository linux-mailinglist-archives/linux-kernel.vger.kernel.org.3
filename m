Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A09C47CD35
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 07:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239262AbhLVG7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 01:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235912AbhLVG7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 01:59:23 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAD0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 22:59:23 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 131so3750715ybc.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 22:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PRyNRcdjB3KVBX69FUZANRLAMwSBZaeM9KNdYqEEq/s=;
        b=j8AqoSdetVvVlvcJwIdjgYg72stv34SShX/TqRDBEYMblq4OQkJXXs7ee2QUPt70nC
         V00DyElwmRnhK652Zvcfu8qr6wHv0ZeEcUyz7+UErHJCJU+wEG9utVwybz8Il9suMvIX
         G3i6DNgh0Z/JtXSVeP5O9SUox3beKkc256SsDZlC2iBS6tS1e7wufwLjmQmpQGIFewU7
         6/p4vrV2IAVJ6FON0qRn4Ljz1A/4G+OF2Gu0L+aO8ZmkHwVYOqR+VZJugGMzLcW4sn11
         pRkzHr2J1E5cTc4NkB0sgq8hzRorjkGDwbsJG2WzMJMaZwCNDmQLHGyd4OVwNvBXVGCJ
         cB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PRyNRcdjB3KVBX69FUZANRLAMwSBZaeM9KNdYqEEq/s=;
        b=nWI+G3IHYGUnem8W90ROUtUox7Zbhvu1fKbB+art5i9FzLH9oO+XUUH8EacUAvCyHG
         i7OTd0kEGq2wiD9sKiaKvfQ8SMBRQDEwVy6oZvGCZJ2kzMvXhj6uVXm1MPWxEAnoJONw
         7MTQKsGIONeZ1g0wXFsSmSYN7pHp0MVY04FsBfyhjSa9GX4apWmnA8tB4VSjjs0cs0Jn
         FC73N0Su1r9NYOBnLK+xLk432J4d3lwpiJeEkaobD6626+5o+K0wpQliEVGz24ho4k0Q
         zHEJBB7zXYpT6pxSJkuQy2HbOdWlmCJpXN182w5sLuznJqGsJ8juyBAw6kuJSFA6ozlw
         FLqw==
X-Gm-Message-State: AOAM5339ekKZ+tbsdWUx4dGGZi0/2YKHVDCCfD3eOuwXZN0SVl1vfJ5x
        Z8582WGTQkCjYmp6OXm77Bs4zfrAv8kNZJiy2yqUnQ==
X-Google-Smtp-Source: ABdhPJzVQytePBezIsAa+BFtIEIkTFRXvYlGcmYJuryHQ8kaOcid5iDPsHDhyWcnBaIrTwrRDTnNT0VxtXVIT1AcY/A=
X-Received: by 2002:a25:a109:: with SMTP id z9mr2542419ybh.700.1640156362603;
 Tue, 21 Dec 2021 22:59:22 -0800 (PST)
MIME-Version: 1.0
References: <20211222045022.27069-1-tianjia.zhang@linux.alibaba.com> <20211222045022.27069-2-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20211222045022.27069-2-tianjia.zhang@linux.alibaba.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Wed, 22 Dec 2021 08:59:11 +0200
Message-ID: <CAOtvUMehn2_HW+b0etPKAV+H=V=PoENkO1xAdL78dCuHma4m_A@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] crypto: sm3 - create SM3 stand-alone library
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Vitaly Chikunov <vt@altlinux.org>,
        Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        x86@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 6:50 AM Tianjia Zhang
<tianjia.zhang@linux.alibaba.com> wrote:
>
> Stand-alone implementation of the SM3 algorithm. It is designed
> to have as little dependencies as possible. In other cases you
> should generally use the hash APIs from include/crypto/hash.h.
> Especially when hashing large amounts of data as those APIs may
> be hw-accelerated. In the new SM3 stand-alone library,
> sm3_compress() has also been optimized, instead of simply using
> the code in sm3_generic.
>

I have a really minor nitpick: the commit message talks about changes
to sm3_compress() which was there in the original code but there is no
such function in the current code which is in a different patch and
file, so if you do another iteration for other reason, perhaps change
the commit message to refer to sm3_transform() instead? it's not
really important enough to warrant a new iteration on it's own...

Otherwise, I'm not smart enough to evaluate the changes to
sm3_transform() cryptographically  but the overall approach of moving
to a standalone library seems sane to me.

So, for what it's worth -

Reviewed-by: Gilad Ben-Yossef <gilad@benyosef.com>

Gilad


> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  include/crypto/sm3.h |  31 ++++++
>  lib/crypto/Kconfig   |   3 +
>  lib/crypto/Makefile  |   3 +
>  lib/crypto/sm3.c     | 246 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 283 insertions(+)
>  create mode 100644 lib/crypto/sm3.c
>
> diff --git a/include/crypto/sm3.h b/include/crypto/sm3.h
> index 42ea21289ba9..315adaf38007 100644
> --- a/include/crypto/sm3.h
> +++ b/include/crypto/sm3.h
> @@ -1,5 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
>  /*
>   * Common values for SM3 algorithm
> + *
> + * Copyright (C) 2017 ARM Limited or its affiliates.
> + * Copyright (C) 2021 Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>   */
>
>  #ifndef _CRYPTO_SM3_H
> @@ -39,4 +43,31 @@ extern int crypto_sm3_final(struct shash_desc *desc, u=
8 *out);
>
>  extern int crypto_sm3_finup(struct shash_desc *desc, const u8 *data,
>                              unsigned int len, u8 *hash);
> +
> +/*
> + * Stand-alone implementation of the SM3 algorithm. It is designed to
> + * have as little dependencies as possible so it can be used in the
> + * kexec_file purgatory. In other cases you should generally use the
> + * hash APIs from include/crypto/hash.h. Especially when hashing large
> + * amounts of data as those APIs may be hw-accelerated.
> + *
> + * For details see lib/crypto/sm3.c
> + */
> +
> +static inline void sm3_init(struct sm3_state *sctx)
> +{
> +       sctx->state[0] =3D SM3_IVA;
> +       sctx->state[1] =3D SM3_IVB;
> +       sctx->state[2] =3D SM3_IVC;
> +       sctx->state[3] =3D SM3_IVD;
> +       sctx->state[4] =3D SM3_IVE;
> +       sctx->state[5] =3D SM3_IVF;
> +       sctx->state[6] =3D SM3_IVG;
> +       sctx->state[7] =3D SM3_IVH;
> +       sctx->count =3D 0;
> +}
> +
> +void sm3_update(struct sm3_state *sctx, const u8 *data, unsigned int len=
);
> +void sm3_final(struct sm3_state *sctx, u8 *out);
> +
>  #endif
> diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
> index 545ccbddf6a1..36963e8f4eaa 100644
> --- a/lib/crypto/Kconfig
> +++ b/lib/crypto/Kconfig
> @@ -129,5 +129,8 @@ config CRYPTO_LIB_CHACHA20POLY1305
>  config CRYPTO_LIB_SHA256
>         tristate
>
> +config CRYPTO_LIB_SM3
> +       tristate
> +
>  config CRYPTO_LIB_SM4
>         tristate
> diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
> index 73205ed269ba..8149bc00b627 100644
> --- a/lib/crypto/Makefile
> +++ b/lib/crypto/Makefile
> @@ -38,6 +38,9 @@ libpoly1305-y                                 +=3D poly=
1305.o
>  obj-$(CONFIG_CRYPTO_LIB_SHA256)                        +=3D libsha256.o
>  libsha256-y                                    :=3D sha256.o
>
> +obj-$(CONFIG_CRYPTO_LIB_SM3)                   +=3D libsm3.o
> +libsm3-y                                       :=3D sm3.o
> +
>  obj-$(CONFIG_CRYPTO_LIB_SM4)                   +=3D libsm4.o
>  libsm4-y                                       :=3D sm4.o
>
> diff --git a/lib/crypto/sm3.c b/lib/crypto/sm3.c
> new file mode 100644
> index 000000000000..d473e358a873
> --- /dev/null
> +++ b/lib/crypto/sm3.c
> @@ -0,0 +1,246 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * SM3 secure hash, as specified by OSCCA GM/T 0004-2012 SM3 and describ=
ed
> + * at https://datatracker.ietf.org/doc/html/draft-sca-cfrg-sm3-02
> + *
> + * Copyright (C) 2017 ARM Limited or its affiliates.
> + * Copyright (C) 2017 Gilad Ben-Yossef <gilad@benyossef.com>
> + * Copyright (C) 2021 Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> + */
> +
> +#include <linux/module.h>
> +#include <asm/unaligned.h>
> +#include <crypto/sm3.h>
> +
> +static const u32 ____cacheline_aligned K[64] =3D {
> +       0x79cc4519, 0xf3988a32, 0xe7311465, 0xce6228cb,
> +       0x9cc45197, 0x3988a32f, 0x7311465e, 0xe6228cbc,
> +       0xcc451979, 0x988a32f3, 0x311465e7, 0x6228cbce,
> +       0xc451979c, 0x88a32f39, 0x11465e73, 0x228cbce6,
> +       0x9d8a7a87, 0x3b14f50f, 0x7629ea1e, 0xec53d43c,
> +       0xd8a7a879, 0xb14f50f3, 0x629ea1e7, 0xc53d43ce,
> +       0x8a7a879d, 0x14f50f3b, 0x29ea1e76, 0x53d43cec,
> +       0xa7a879d8, 0x4f50f3b1, 0x9ea1e762, 0x3d43cec5,
> +       0x7a879d8a, 0xf50f3b14, 0xea1e7629, 0xd43cec53,
> +       0xa879d8a7, 0x50f3b14f, 0xa1e7629e, 0x43cec53d,
> +       0x879d8a7a, 0x0f3b14f5, 0x1e7629ea, 0x3cec53d4,
> +       0x79d8a7a8, 0xf3b14f50, 0xe7629ea1, 0xcec53d43,
> +       0x9d8a7a87, 0x3b14f50f, 0x7629ea1e, 0xec53d43c,
> +       0xd8a7a879, 0xb14f50f3, 0x629ea1e7, 0xc53d43ce,
> +       0x8a7a879d, 0x14f50f3b, 0x29ea1e76, 0x53d43cec,
> +       0xa7a879d8, 0x4f50f3b1, 0x9ea1e762, 0x3d43cec5
> +};
> +
> +/*
> + * Transform the message X which consists of 16 32-bit-words. See
> + * GM/T 004-2012 for details.
> + */
> +#define R(i, a, b, c, d, e, f, g, h, t, w1, w2)                        \
> +       do {                                                    \
> +               ss1 =3D rol32((rol32((a), 12) + (e) + (t)), 7);   \
> +               ss2 =3D ss1 ^ rol32((a), 12);                     \
> +               d +=3D FF ## i(a, b, c) + ss2 + ((w1) ^ (w2));    \
> +               h +=3D GG ## i(e, f, g) + ss1 + (w1);             \
> +               b =3D rol32((b), 9);                              \
> +               f =3D rol32((f), 19);                             \
> +               h =3D P0((h));                                    \
> +       } while (0)
> +
> +#define R1(a, b, c, d, e, f, g, h, t, w1, w2) \
> +       R(1, a, b, c, d, e, f, g, h, t, w1, w2)
> +#define R2(a, b, c, d, e, f, g, h, t, w1, w2) \
> +       R(2, a, b, c, d, e, f, g, h, t, w1, w2)
> +
> +#define FF1(x, y, z)  (x ^ y ^ z)
> +#define FF2(x, y, z)  ((x & y) | (x & z) | (y & z))
> +
> +#define GG1(x, y, z)  FF1(x, y, z)
> +#define GG2(x, y, z)  ((x & y) | (~x & z))
> +
> +/* Message expansion */
> +#define P0(x) ((x) ^ rol32((x), 9) ^ rol32((x), 17))
> +#define P1(x) ((x) ^ rol32((x), 15) ^ rol32((x), 23))
> +#define I(i)  (W[i] =3D get_unaligned_be32(data + i * 4))
> +#define W1(i) (W[i & 0x0f])
> +#define W2(i) (W[i & 0x0f] =3D                           \
> +               P1(W[i & 0x0f]                          \
> +                       ^ W[(i-9) & 0x0f]               \
> +                       ^ rol32(W[(i-3) & 0x0f], 15))   \
> +               ^ rol32(W[(i-13) & 0x0f], 7)            \
> +               ^ W[(i-6) & 0x0f])
> +
> +static void sm3_transform(struct sm3_state *sctx, u8 const *data, u32 W[=
16])
> +{
> +       u32 a, b, c, d, e, f, g, h, ss1, ss2;
> +
> +       a =3D sctx->state[0];
> +       b =3D sctx->state[1];
> +       c =3D sctx->state[2];
> +       d =3D sctx->state[3];
> +       e =3D sctx->state[4];
> +       f =3D sctx->state[5];
> +       g =3D sctx->state[6];
> +       h =3D sctx->state[7];
> +
> +       R1(a, b, c, d, e, f, g, h, K[0], I(0), I(4));
> +       R1(d, a, b, c, h, e, f, g, K[1], I(1), I(5));
> +       R1(c, d, a, b, g, h, e, f, K[2], I(2), I(6));
> +       R1(b, c, d, a, f, g, h, e, K[3], I(3), I(7));
> +       R1(a, b, c, d, e, f, g, h, K[4], W1(4), I(8));
> +       R1(d, a, b, c, h, e, f, g, K[5], W1(5), I(9));
> +       R1(c, d, a, b, g, h, e, f, K[6], W1(6), I(10));
> +       R1(b, c, d, a, f, g, h, e, K[7], W1(7), I(11));
> +       R1(a, b, c, d, e, f, g, h, K[8], W1(8), I(12));
> +       R1(d, a, b, c, h, e, f, g, K[9], W1(9), I(13));
> +       R1(c, d, a, b, g, h, e, f, K[10], W1(10), I(14));
> +       R1(b, c, d, a, f, g, h, e, K[11], W1(11), I(15));
> +       R1(a, b, c, d, e, f, g, h, K[12], W1(12), W2(16));
> +       R1(d, a, b, c, h, e, f, g, K[13], W1(13), W2(17));
> +       R1(c, d, a, b, g, h, e, f, K[14], W1(14), W2(18));
> +       R1(b, c, d, a, f, g, h, e, K[15], W1(15), W2(19));
> +
> +       R2(a, b, c, d, e, f, g, h, K[16], W1(16), W2(20));
> +       R2(d, a, b, c, h, e, f, g, K[17], W1(17), W2(21));
> +       R2(c, d, a, b, g, h, e, f, K[18], W1(18), W2(22));
> +       R2(b, c, d, a, f, g, h, e, K[19], W1(19), W2(23));
> +       R2(a, b, c, d, e, f, g, h, K[20], W1(20), W2(24));
> +       R2(d, a, b, c, h, e, f, g, K[21], W1(21), W2(25));
> +       R2(c, d, a, b, g, h, e, f, K[22], W1(22), W2(26));
> +       R2(b, c, d, a, f, g, h, e, K[23], W1(23), W2(27));
> +       R2(a, b, c, d, e, f, g, h, K[24], W1(24), W2(28));
> +       R2(d, a, b, c, h, e, f, g, K[25], W1(25), W2(29));
> +       R2(c, d, a, b, g, h, e, f, K[26], W1(26), W2(30));
> +       R2(b, c, d, a, f, g, h, e, K[27], W1(27), W2(31));
> +       R2(a, b, c, d, e, f, g, h, K[28], W1(28), W2(32));
> +       R2(d, a, b, c, h, e, f, g, K[29], W1(29), W2(33));
> +       R2(c, d, a, b, g, h, e, f, K[30], W1(30), W2(34));
> +       R2(b, c, d, a, f, g, h, e, K[31], W1(31), W2(35));
> +
> +       R2(a, b, c, d, e, f, g, h, K[32], W1(32), W2(36));
> +       R2(d, a, b, c, h, e, f, g, K[33], W1(33), W2(37));
> +       R2(c, d, a, b, g, h, e, f, K[34], W1(34), W2(38));
> +       R2(b, c, d, a, f, g, h, e, K[35], W1(35), W2(39));
> +       R2(a, b, c, d, e, f, g, h, K[36], W1(36), W2(40));
> +       R2(d, a, b, c, h, e, f, g, K[37], W1(37), W2(41));
> +       R2(c, d, a, b, g, h, e, f, K[38], W1(38), W2(42));
> +       R2(b, c, d, a, f, g, h, e, K[39], W1(39), W2(43));
> +       R2(a, b, c, d, e, f, g, h, K[40], W1(40), W2(44));
> +       R2(d, a, b, c, h, e, f, g, K[41], W1(41), W2(45));
> +       R2(c, d, a, b, g, h, e, f, K[42], W1(42), W2(46));
> +       R2(b, c, d, a, f, g, h, e, K[43], W1(43), W2(47));
> +       R2(a, b, c, d, e, f, g, h, K[44], W1(44), W2(48));
> +       R2(d, a, b, c, h, e, f, g, K[45], W1(45), W2(49));
> +       R2(c, d, a, b, g, h, e, f, K[46], W1(46), W2(50));
> +       R2(b, c, d, a, f, g, h, e, K[47], W1(47), W2(51));
> +
> +       R2(a, b, c, d, e, f, g, h, K[48], W1(48), W2(52));
> +       R2(d, a, b, c, h, e, f, g, K[49], W1(49), W2(53));
> +       R2(c, d, a, b, g, h, e, f, K[50], W1(50), W2(54));
> +       R2(b, c, d, a, f, g, h, e, K[51], W1(51), W2(55));
> +       R2(a, b, c, d, e, f, g, h, K[52], W1(52), W2(56));
> +       R2(d, a, b, c, h, e, f, g, K[53], W1(53), W2(57));
> +       R2(c, d, a, b, g, h, e, f, K[54], W1(54), W2(58));
> +       R2(b, c, d, a, f, g, h, e, K[55], W1(55), W2(59));
> +       R2(a, b, c, d, e, f, g, h, K[56], W1(56), W2(60));
> +       R2(d, a, b, c, h, e, f, g, K[57], W1(57), W2(61));
> +       R2(c, d, a, b, g, h, e, f, K[58], W1(58), W2(62));
> +       R2(b, c, d, a, f, g, h, e, K[59], W1(59), W2(63));
> +       R2(a, b, c, d, e, f, g, h, K[60], W1(60), W2(64));
> +       R2(d, a, b, c, h, e, f, g, K[61], W1(61), W2(65));
> +       R2(c, d, a, b, g, h, e, f, K[62], W1(62), W2(66));
> +       R2(b, c, d, a, f, g, h, e, K[63], W1(63), W2(67));
> +
> +       sctx->state[0] ^=3D a;
> +       sctx->state[1] ^=3D b;
> +       sctx->state[2] ^=3D c;
> +       sctx->state[3] ^=3D d;
> +       sctx->state[4] ^=3D e;
> +       sctx->state[5] ^=3D f;
> +       sctx->state[6] ^=3D g;
> +       sctx->state[7] ^=3D h;
> +}
> +#undef R
> +#undef R1
> +#undef R2
> +#undef I
> +#undef W1
> +#undef W2
> +
> +static inline void sm3_block(struct sm3_state *sctx,
> +               u8 const *data, int blocks, u32 W[16])
> +{
> +       while (blocks--) {
> +               sm3_transform(sctx, data, W);
> +               data +=3D SM3_BLOCK_SIZE;
> +       }
> +}
> +
> +void sm3_update(struct sm3_state *sctx, const u8 *data, unsigned int len=
)
> +{
> +       unsigned int partial =3D sctx->count % SM3_BLOCK_SIZE;
> +       u32 W[16];
> +
> +       sctx->count +=3D len;
> +
> +       if ((partial + len) >=3D SM3_BLOCK_SIZE) {
> +               int blocks;
> +
> +               if (partial) {
> +                       int p =3D SM3_BLOCK_SIZE - partial;
> +
> +                       memcpy(sctx->buffer + partial, data, p);
> +                       data +=3D p;
> +                       len -=3D p;
> +
> +                       sm3_block(sctx, sctx->buffer, 1, W);
> +               }
> +
> +               blocks =3D len / SM3_BLOCK_SIZE;
> +               len %=3D SM3_BLOCK_SIZE;
> +
> +               if (blocks) {
> +                       sm3_block(sctx, data, blocks, W);
> +                       data +=3D blocks * SM3_BLOCK_SIZE;
> +               }
> +
> +               memzero_explicit(W, sizeof(W));
> +
> +               partial =3D 0;
> +       }
> +       if (len)
> +               memcpy(sctx->buffer + partial, data, len);
> +}
> +EXPORT_SYMBOL_GPL(sm3_update);
> +
> +void sm3_final(struct sm3_state *sctx, u8 *out)
> +{
> +       const int bit_offset =3D SM3_BLOCK_SIZE - sizeof(u64);
> +       __be64 *bits =3D (__be64 *)(sctx->buffer + bit_offset);
> +       __be32 *digest =3D (__be32 *)out;
> +       unsigned int partial =3D sctx->count % SM3_BLOCK_SIZE;
> +       u32 W[16];
> +       int i;
> +
> +       sctx->buffer[partial++] =3D 0x80;
> +       if (partial > bit_offset) {
> +               memset(sctx->buffer + partial, 0, SM3_BLOCK_SIZE - partia=
l);
> +               partial =3D 0;
> +
> +               sm3_block(sctx, sctx->buffer, 1, W);
> +       }
> +
> +       memset(sctx->buffer + partial, 0, bit_offset - partial);
> +       *bits =3D cpu_to_be64(sctx->count << 3);
> +       sm3_block(sctx, sctx->buffer, 1, W);
> +
> +       for (i =3D 0; i < 8; i++)
> +               put_unaligned_be32(sctx->state[i], digest++);
> +
> +       /* Zeroize sensitive information. */
> +       memzero_explicit(W, sizeof(W));
> +       memzero_explicit(sctx, sizeof(*sctx));
> +}
> +EXPORT_SYMBOL_GPL(sm3_final);
> +
> +MODULE_DESCRIPTION("Generic SM3 library");
> +MODULE_LICENSE("GPL v2");
> --
> 2.32.0
>


--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
