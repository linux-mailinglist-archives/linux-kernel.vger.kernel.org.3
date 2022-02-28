Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4484C6579
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbiB1JMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbiB1JMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:12:21 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C20466AEC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:11:43 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2d66f95f1d1so100464997b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Apq/HJBWO1/Vh/LXE1a0ZbONtRHS5rU8pD46HevklkY=;
        b=SSQZkSmtXLj3U9XbRdtbqgiXRWjZTAmimsylCosT7ruNa0h07yrpE0rUg+/kqY2bTJ
         e08yiRvm90Hyhkk8loX50L2LGZGhEWdRjq71eow0U/pQBeE0hjf/B+x/zokolDIu/Vl9
         xbc55VLyk5nyueKCI5RmhPe7dModxOw1HRIVzL82LMKmKT0ZF2uFdUA7DhyLnAGZHOVU
         Iu6jxbQF2qgsuGNz+XFFHu6uuB+oIV5I2xLp0K6lzEG5G4dU4xoRrKS/6k1QcKVNMhY9
         ixIZThviS3xBQOWMeEiLAeQNnTcTwwGD189NvxoPFTXFTaoM4wnGfNW9jp9mLDsqliIl
         XKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Apq/HJBWO1/Vh/LXE1a0ZbONtRHS5rU8pD46HevklkY=;
        b=nPXO/v0YfZtu5BcmIVqKFOKNBY/keUb0JT8VgpafvPjGpeUQDsoVO/bMGrjO86BCR0
         /6qNcbJQmUijjDMlJtZe44jmpa1jHIVpXOxkSX4eAXE+9IpvDkThdCJiwfp8JWLWRNkx
         qODLQ3HKMHS6o6N8gNNwmEm/ViVpzNaa+bLZucY0iJc3/UyR6UoQHX5gYcEZJZ+zrLs5
         itFHhc2fq5u5VWZenX3r8jHBgOjTEw6gXwQ9Bvtc5F+MoYfmDQNk/WJZ9wRmQPwjv4T7
         3KseEIoKQvJdEHo+FKVOH4xjYe6+jvgEI95J8u+6na2pHJgPrVf/D5WazdmSFJyW0JLS
         Nt2Q==
X-Gm-Message-State: AOAM532HKoMBD8ROXLEIsjP30wDoVORQpawcVF2W4yxM0Mky1Ps0MBXK
        g/y85ALRaptM06JqVebaJCxrF/KJFenUIpG/ewzzbw==
X-Google-Smtp-Source: ABdhPJxW8K/XXK18kmFDDAPAouIU00zNNJ1SeFh1/hxBOkjMYFqYyqh5qY/E10KeDKMk4Wv/SDETpxSKB0+Lbmus4fA=
X-Received: by 2002:a81:47c2:0:b0:2d6:5e1a:46c2 with SMTP id
 u185-20020a8147c2000000b002d65e1a46c2mr2443759ywa.66.1646039502216; Mon, 28
 Feb 2022 01:11:42 -0800 (PST)
MIME-Version: 1.0
References: <YgOQBNIdf0UnSH+M@Red> <CAOtvUMeoYcVm7OQdqXd1V5iPSXW_BkVxx6TA6nF7zTLVeHe0Ww@mail.gmail.com>
 <CAOtvUMfy1fF35B2sfbOMui8n9Q4iCke9rgn5TiYMUMjd8gqHsA@mail.gmail.com>
 <YhKV55t90HWm6bhv@Red> <CAOtvUMdRU4wnRCXsC+U5XBDp+b+u8w7W7JCUKW2+ohuJz3PVhQ@mail.gmail.com>
 <YhOcEQEjIKBrbMIZ@Red> <CAOtvUMfN8U4+eG-TEVW4bSE6kOzuOSsJE4dOYGXYuWQKNzv7wQ@mail.gmail.com>
In-Reply-To: <CAOtvUMfN8U4+eG-TEVW4bSE6kOzuOSsJE4dOYGXYuWQKNzv7wQ@mail.gmail.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Mon, 28 Feb 2022 11:11:43 +0200
Message-ID: <CAOtvUMeRb=j=NDrc88x8aB-3=D1mxZ_-aA1d4FfvJmj7Jrbi4w@mail.gmail.com>
Subject: Re: [BUG] crypto: ccree: driver does not handle case where cryptlen =
 authsize =0
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
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

Hi,

On Tue, Feb 22, 2022 at 9:39 AM Gilad Ben-Yossef <gilad@benyossef.com> wrot=
e:
>
> On Mon, Feb 21, 2022 at 4:05 PM Corentin Labbe
> <clabbe.montjoie@gmail.com> wrote:
> >
> > Le Mon, Feb 21, 2022 at 12:08:12PM +0200, Gilad Ben-Yossef a =C3=A9crit=
 :
> > > Hi,
> > >
> > > On Sun, Feb 20, 2022 at 9:26 PM Corentin Labbe
> > > <clabbe.montjoie@gmail.com> wrote:
> > > >
> > > ...
> > > >
> > > > Hello
> > > >
> > > > While testing your patch for this problem, I saw another warning (u=
nrelated with your patch):
> > >
> > > Dear Corentin, you are a treasure trove of bug reports. I love it.
> > > Thank you! :-)
> > >
> > > > [   34.061953] ------------[ cut here ]------------
> ...
> > >
> > > So, this is an interesting one.
> > > What I *think* is happening is that the drbg implementation is
> > > actually doing something naughty: it is passing the same exact memory
> > > buffer, both as source and destination to an encryption operation to
> > > the crypto skcipher API, BUT via two different scatter gather lists.
> > >
> > > I'm not sure but I believe this is not a legitimate use of the API,
> > > but before we even go into this, let's see if this little fix helps a=
t
> > > all and this is indeed the root cause.
> > >
> > > Can you test this small change for me, please?
> > >
> > > diff --git a/crypto/drbg.c b/crypto/drbg.c
> > > index 177983b6ae38..13824fd27627 100644
> > > --- a/crypto/drbg.c
> > > +++ b/crypto/drbg.c
> > > @@ -1851,7 +1851,7 @@ static int drbg_kcapi_sym_ctr(struct drbg_state=
 *drbg,
> > >                 /* Use scratchpad for in-place operation */
> > >                 inlen =3D scratchpad_use;
> > >                 memset(drbg->outscratchpad, 0, scratchpad_use);
> > > -               sg_set_buf(sg_in, drbg->outscratchpad, scratchpad_use=
);
> > > +               sg_in =3D sg_out;
> > >         }
> > >
> > >         while (outlen) {
> > >
> >
> > No more stacktrace !
>
> Thank you. I will send a patch later today.

> --
> Gilad Ben-Yossef
> Chief Coffee Drinker
>
> values of =CE=B2 will give rise to dom!

OK, it seems my direction of fixing the caller site has not been taken
kindly by the power that be.
Let's try something else.

Can you please drop the previous patch and test this one instead?

diff --git a/drivers/crypto/ccree/cc_buffer_mgr.c
b/drivers/crypto/ccree/cc_buffer_mgr.c
index 11e0278c8631..398843040566 100644
--- a/drivers/crypto/ccree/cc_buffer_mgr.c
+++ b/drivers/crypto/ccree/cc_buffer_mgr.c
@@ -377,6 +377,7 @@ int cc_map_cipher_request(struct cc_drvdata
*drvdata, void *ctx,
        u32 dummy =3D 0;
        int rc =3D 0;
        u32 mapped_nents =3D 0;
+       int src_direction =3D (src !=3D dst ? DMA_TO_DEVICE : DMA_BIDIRECTI=
ONAL);

        req_ctx->dma_buf_type =3D CC_DMA_BUF_DLLI;
        mlli_params->curr_pool =3D NULL;
@@ -399,7 +400,7 @@ int cc_map_cipher_request(struct cc_drvdata
*drvdata, void *ctx,
        }

        /* Map the src SGL */
-       rc =3D cc_map_sg(dev, src, nbytes, DMA_BIDIRECTIONAL, &req_ctx->in_=
nents,
+       rc =3D cc_map_sg(dev, src, nbytes, src_direction, &req_ctx->in_nent=
s,
                       LLI_MAX_NUM_OF_DATA_ENTRIES, &dummy, &mapped_nents);
        if (rc)
                goto cipher_exit;
@@ -416,7 +417,7 @@ int cc_map_cipher_request(struct cc_drvdata
*drvdata, void *ctx,
                }
        } else {
                /* Map the dst sg */
-               rc =3D cc_map_sg(dev, dst, nbytes, DMA_BIDIRECTIONAL,
+               rc =3D cc_map_sg(dev, dst, nbytes, DMA_FROM_DEVICE,
                               &req_ctx->out_nents, LLI_MAX_NUM_OF_DATA_ENT=
RIES,
                               &dummy, &mapped_nents);
                if (rc)


Thanks!
Gilad

--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
