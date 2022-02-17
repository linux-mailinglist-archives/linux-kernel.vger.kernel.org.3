Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD6B4BA9EE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245255AbiBQThC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:37:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245285AbiBQThA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:37:00 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14323AA74
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:36:44 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id j12so15144439ybh.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ooI0JvtrMm1EWIWCxV5c2URZAUO8zQ/vmYnuAIZ6onk=;
        b=0CkOigzXtlWg/1yHf8eOrlWj0Xdu1g8OuW163v1hOABclEWhibv031qIzaTelNnNIg
         2wpxiy0ITL4/mJC/f9kVy5f06oL126Y5ZM3gz/uxrtFuAF38bc8dk0d/tK+/hrR24NvS
         wsVZTQxsYiryHo/62FkJZSG1ey81c9lTuYW5TlJKUWKnjuPzEhokxgcxnsVzWs2O05SB
         n0lGBLVhhRm436CbhvG08k1DRK2cImBthP0MZa7noZwCDv7jSUAcjnBzr9qFXC53vd6M
         0bPlJQrv3+/5XgdroFmEoJkPEKuVgnWkCMXgdpfg6YGSacLaffEqUQiCIsnVIYDcVTW/
         XvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ooI0JvtrMm1EWIWCxV5c2URZAUO8zQ/vmYnuAIZ6onk=;
        b=UrzO57I4nZFmxX1JrZ+i5Z7hCgJxr3/6fSSCqBCcka03lPhDzvLYcMvIY4vmlvXpCE
         FsneVPJ/Y0+bNOIyUQvVbc4sBuelFgkpKPO2rjsnmTg8cO4ZFc+w/FeEO7hYFScKbZ81
         JsJiPsGKGgXw8CaFpxPCbvQNq3De6GHUYsIZPAcafc+iAoAUSEArlc28+0/GPiIfiGTj
         pNw6U9Stvhzzt4YL4hS6vZkDgoFA9c08C2tgWZS1Xg7evu5y/NQXD5AFa53C0BDGAcDh
         ryRc65reQIwPzkvSzvy4gDk2ct7hgyN5VeBdQ7c+FZFOU7PQQqvWM09+wi6oza/Y97sf
         IVXw==
X-Gm-Message-State: AOAM5330nvBmfQ+sv7msGobNiC3na+MB1aKCKQbUvu6GQTXNrYXYBK5u
        Ufc6ebCW1orkvsENUgKFVSD+wp9lvG/yBIBupIouQVsc8G3oWQ==
X-Google-Smtp-Source: ABdhPJx+lOiB7Ua1wUV60YpmjG9bncDOD5Dbx4/P3hF0MmWKaNdLPF+e2h1dcV/bdqGjVjy/l+yWLR7pVLn3hsOyrUA=
X-Received: by 2002:a05:6902:284:b0:624:1c25:cda1 with SMTP id
 v4-20020a056902028400b006241c25cda1mr3670848ybh.480.1645126603948; Thu, 17
 Feb 2022 11:36:43 -0800 (PST)
MIME-Version: 1.0
References: <20220209070608.985213-1-clabbe@baylibre.com>
In-Reply-To: <20220209070608.985213-1-clabbe@baylibre.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Thu, 17 Feb 2022 21:36:41 +0200
Message-ID: <CAOtvUMfhgJBNhDfotkxW0wMyJK-3y4-QGTCKFxG+8oc3EQDKAg@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccree: fix xts-aes-ccree blocksize
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Again,

Thank you for taking the time to look into this!

However, this is an old topic that has been discussed before and the
answer really is that the selftests are wrong. They are looking at the
wrong thing. Yes, I know...

See the discussion here:
https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg40576.html

I also also point out this is actually documented in the code:

+               /* See
https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg40576.html
+                * for the reason why this differs from the generic
+                * implementation.
+                */

Thanks again!
Gilad


On Wed, Feb 9, 2022 at 9:06 AM Corentin Labbe <clabbe@baylibre.com> wrote:
>
> loading ccree on next-20220207 with CRYPTO_MANAGER_EXTRA_TESTS show a war=
ning:
> alg: skcipher: blocksize for xts-aes-ccree (1) doesn't match generic impl=
 (16)
> alg: self-tests for xts-aes-ccree (xts(aes)) failed (rc=3D-22)
>
> After setting the correct blocksize, selftests pass.
>
> Fixes: 67caef08a71f ("crypto: ccree - enable CTS support in AES-XTS")
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/crypto/ccree/cc_cipher.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_c=
ipher.c
> index 78833491f534..d955fe15cf40 100644
> --- a/drivers/crypto/ccree/cc_cipher.c
> +++ b/drivers/crypto/ccree/cc_cipher.c
> @@ -1010,7 +1010,7 @@ static const struct cc_alg_template skcipher_algs[]=
 =3D {
>         {
>                 .name =3D "xts(paes)",
>                 .driver_name =3D "xts-paes-ccree",
> -               .blocksize =3D 1,
> +               .blocksize =3D XTS_BLOCK_SIZE,
>                 .template_skcipher =3D {
>                         .setkey =3D cc_cipher_sethkey,
>                         .encrypt =3D cc_cipher_encrypt,
> @@ -1140,7 +1140,7 @@ static const struct cc_alg_template skcipher_algs[]=
 =3D {
>                  */
>                 .name =3D "xts(aes)",
>                 .driver_name =3D "xts-aes-ccree",
> -               .blocksize =3D 1,
> +               .blocksize =3D XTS_BLOCK_SIZE,
>                 .template_skcipher =3D {
>                         .setkey =3D cc_cipher_setkey,
>                         .encrypt =3D cc_cipher_encrypt,
> --
> 2.34.1
>


--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
