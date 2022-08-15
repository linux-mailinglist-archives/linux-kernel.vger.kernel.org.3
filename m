Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A59592CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242081AbiHOJmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiHOJmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:42:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1925D1CB34;
        Mon, 15 Aug 2022 02:42:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEAD960FF1;
        Mon, 15 Aug 2022 09:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11076C433D6;
        Mon, 15 Aug 2022 09:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660556541;
        bh=mIIGTw4aMzZ/OGv8lX0rJKJzHZ9/juqllmTKoHRRuhE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N0D3MH8E8sRUuyIISUB0yg0MTGKTs+svFi/lTl6j9NLut5T1CmxLRaV3NvrJE1/Ft
         O2Kc6H6qirviHJVUbSUUx1rF0hOUFv2CGDrmfLsOIq8Tts7zQRWEPxoR37u5FkPIfK
         S3orIWnDsO8P3SleGpSYQz3xgZXZP5I8PorJgCW7sf8QqtCUM8QHMtfKS5M3UmF9yf
         kNdaxVwA298T3CHhbUxzcsOO3YR0opEdWzidz2H9v1wCEpEBOX5HULsslrC32I8lDn
         HTQQwCcuIponvsZ2IFu4tQL4vRFFoMI9g13eNGaOlKbj8I6a+IZeRMmGCIt2wUE2Z/
         coT04CdADqLIA==
Received: by mail-wr1-f41.google.com with SMTP id j7so8453737wrh.3;
        Mon, 15 Aug 2022 02:42:20 -0700 (PDT)
X-Gm-Message-State: ACgBeo3cCKAHrmguHqqlALQ2ryq3VrgMu76OUy7/vajJlP+osofxkU/d
        vFzNk6diQfoZU1ZMSheVGH7iSgNNmDAE6vdeDKY=
X-Google-Smtp-Source: AA6agR4sVq1vePjI1vORqyjjgxd+/zzwKVWOL7SwNmNgiAKdmWT73zj5V2uLM0EH2VK1oXNXIBhbRYCzkz8x8zO+4Fg=
X-Received: by 2002:a5d:64a6:0:b0:21f:b3b:5cc9 with SMTP id
 m6-20020a5d64a6000000b0021f0b3b5cc9mr7806696wrp.601.1660556539286; Mon, 15
 Aug 2022 02:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220815042915.44547-1-elliott@hpe.com>
In-Reply-To: <20220815042915.44547-1-elliott@hpe.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 15 Aug 2022 11:42:08 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH1rU=HCd8bV4AP18JXhMKSs7wdJoiYQkPFsPRj=iuZPQ@mail.gmail.com>
Message-ID: <CAMj1kXH1rU=HCd8bV4AP18JXhMKSs7wdJoiYQkPFsPRj=iuZPQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: tcrypt - remove mode=1000
To:     Robert Elliott <elliott@hpe.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        toshi.kani@hpe.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2022 at 06:30, Robert Elliott <elliott@hpe.com> wrote:
>
> The lists of algothms checked for existence by
>     modprobe tcrypt mode=1000
> generates three bogus errors:
>     modprobe tcrypt mode=1000
>
>     console log:
>     tcrypt: alg rot13 not found
>     tcrypt: alg cts not found
>     tcrypt: alg arc4 not found
>
> rot13 is not an algorithm in the crypto API or tested.
>
> cts is a wrapper, not a base algorithm.
>
> arc4 is named ecb(arc4), not arc4.
>
> Also, the list is missing numerous algorithms that are tested by
> other test modes:
>     blake2b-512
>     blake2s-256
>     crct10dif
>     xxhash64
>     ghash
>     cast5
>     sm4
>     ansi_prng
>
> Several of the algorithms are only available if
> CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE is enabled:
>     arc4
>     khazad
>     seed
>     tea, xtea, xeta
>
> Rather that fix that list, remove test mode=1000 entirely.
> It seems to have limited utility, and a web search shows no
> discussion of anybody using it.
>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Robert Elliott <elliott@hpe.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  crypto/tcrypt.c | 28 ----------------------------
>  1 file changed, 28 deletions(-)
>
> diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
> index 2bacf8384f59..35d70382ee54 100644
> --- a/crypto/tcrypt.c
> +++ b/crypto/tcrypt.c
> @@ -65,18 +65,6 @@ static int mode;
>  static u32 num_mb = 8;
>  static unsigned int klen;
>  static char *tvmem[TVMEMSIZE];
> -
> -static const char *check[] = {
> -       "des", "md5", "des3_ede", "rot13", "sha1", "sha224", "sha256", "sm3",
> -       "blowfish", "twofish", "serpent", "sha384", "sha512", "md4", "aes",
> -       "cast6", "arc4", "michael_mic", "deflate", "crc32c", "tea", "xtea",
> -       "khazad", "wp512", "wp384", "wp256", "xeta",  "fcrypt",
> -       "camellia", "seed", "rmd160",
> -       "lzo", "lzo-rle", "cts", "sha3-224", "sha3-256", "sha3-384",
> -       "sha3-512", "streebog256", "streebog512",
> -       NULL
> -};
> -
>  static const int block_sizes[] = { 16, 64, 128, 256, 1024, 1420, 4096, 0 };
>  static const int aead_sizes[] = { 16, 64, 256, 512, 1024, 1420, 4096, 8192, 0 };
>
> @@ -1454,18 +1442,6 @@ static void test_cipher_speed(const char *algo, int enc, unsigned int secs,
>                                    false);
>  }
>
> -static void test_available(void)
> -{
> -       const char **name = check;
> -
> -       while (*name) {
> -               printk("alg %s ", *name);
> -               printk(crypto_has_alg(*name, 0, 0) ?
> -                      "found\n" : "not found\n");
> -               name++;
> -       }
> -}
> -
>  static inline int tcrypt_test(const char *alg)
>  {
>         int ret;
> @@ -2825,10 +2801,6 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
>                 test_mb_skcipher_speed("ctr(blowfish)", DECRYPT, sec, NULL, 0,
>                                        speed_template_8_32, num_mb);
>                 break;
> -
> -       case 1000:
> -               test_available();
> -               break;
>         }
>
>         return ret;
> --
> 2.37.1
>
