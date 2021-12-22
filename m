Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F34147D954
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 23:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbhLVWfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 17:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhLVWff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 17:35:35 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53739C061574;
        Wed, 22 Dec 2021 14:35:35 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id j11so6631130lfg.3;
        Wed, 22 Dec 2021 14:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=509cil0OJ5qdfWw2ojcCOYSwHBJ9P8vwyQkD+G8mLLA=;
        b=ddZKfL8FvoJ0XwnKMMmKWLGJ3VqFSFGglRVDb0+PqM2DxuwldMzReXdg0Ebtk9Yobi
         AVztMug/XvayfxM3v8GOeWIfRsrkU3pfCylaBXUmoqsMO81lth0cxfRUKMa/jua7By8h
         fSZ6R/sGKPh5nSmA0ASRGeLeb6wdCjfYNft0YG0y8ivi5U/BpBfokB9hcGa9coBwNOMN
         Gg+cjCxIPhQ2b7TcbEc1gjiCTijvdkgEF9rXZGv3s6zgXp/f1hq5bp68059Gc1Z9wTvm
         bIqvGf1ZD6DqjfSFh05rCeUC0528fcV+nKXNDyihLdVmnm+p0/XORPV26mvKGpvGa4Zb
         OjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=509cil0OJ5qdfWw2ojcCOYSwHBJ9P8vwyQkD+G8mLLA=;
        b=fPeJNrcjM0I21LFplQ6E42/HD1nBdO6KIBrT2hzIxhad8b4k2Yon4YRl15g0szmmPg
         c6Z0VReoQToYgyNI0e8EirDlkXtDc5rKJMvlhqC+RFFF8NE43rE79aAP4WzSM2Px96cM
         WVyxHH8I78qg1D1BFMSTzc7P5ai3RkHE1X7A+/dIFV4/Cuw2eu6xmtYV5LbjxKYh+Qw7
         kbLiH3vL6MbxaUcfFWHmGcDxKxvuY4kUpsGfTnqFRrKj5M37p/uawi96DHpsq2/iX7p5
         G4C8WAm40iW/1mP1vlEq4HZY5klMQcbeE2W4+C7K9tq8kLp6Gisk1Qi/mVm3vZrlFmzp
         6Jjg==
X-Gm-Message-State: AOAM532L3Jo3ZsQYkTP6XdfVAzOy0FX5nfBkvqDDQ5Na9hI9XfW8dzBh
        alHtqg6JaY8sIRWgGJ9SeCcgyvC275L6/aAk89DsfBPvaUM=
X-Google-Smtp-Source: ABdhPJyfufBHYdDFQz+ah/Iw/iZGRxjmctUcUf2op+2vKNZiQPXrZB6SUilBWwF8JJMaI1eDbZeGr+HUSlFNJ5XDS4Q=
X-Received: by 2002:a05:6512:3486:: with SMTP id v6mr3634731lfr.483.1640212533273;
 Wed, 22 Dec 2021 14:35:33 -0800 (PST)
MIME-Version: 1.0
References: <20211220092318.5793-1-tianjia.zhang@linux.alibaba.com> <20211220092318.5793-2-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20211220092318.5793-2-tianjia.zhang@linux.alibaba.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Thu, 23 Dec 2021 09:35:21 +1100
Message-ID: <CAGRGNgXE_5H20K+e9oejqybOGh8JezMpi2yrDJKqaZ4rWJkZdA@mail.gmail.com>
Subject: Re: [PATCH 1/5] crypto: sha256 - remove duplicate generic hash init function
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-crypto@vger.kernel.org, linux-mips@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tianjia,

On Mon, Dec 20, 2021 at 8:25 PM Tianjia Zhang
<tianjia.zhang@linux.alibaba.com> wrote:
>
> crypto_sha256_init() and sha256_base_init() are the same repeated
> implementations, remove the crypto_sha256_init() in generic
> implementation, sha224 is the same process.
>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  crypto/sha256_generic.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
>
> diff --git a/crypto/sha256_generic.c b/crypto/sha256_generic.c
> index 3b377197236e..bf147b01e313 100644
> --- a/crypto/sha256_generic.c
> +++ b/crypto/sha256_generic.c
> @@ -72,7 +60,7 @@ EXPORT_SYMBOL(crypto_sha256_finup);
>
>  static struct shash_alg sha256_algs[2] = { {
>         .digestsize     =       SHA256_DIGEST_SIZE,
> -       .init           =       crypto_sha256_init,
> +       .init           =       sha256_base_init,
>         .update         =       crypto_sha256_update,
>         .final          =       crypto_sha256_final,
>         .finup          =       crypto_sha256_finup,
> @@ -86,7 +74,7 @@ static struct shash_alg sha256_algs[2] = { {
>         }
>  }, {
>         .digestsize     =       SHA224_DIGEST_SIZE,
> -       .init           =       crypto_sha224_init,
> +       .init           =       sha224_base_init,
>         .update         =       crypto_sha256_update,
>         .final          =       crypto_sha256_final,
>         .finup          =       crypto_sha256_finup,

Aren't these two functions defined as static inline functions? It
appears that these crypto_ wrappers were added so there's "actual"
referenceable functions for these structs.

Did this actually compile?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
