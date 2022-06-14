Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E744554A8A6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 07:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbiFNFUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 01:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiFNFUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 01:20:21 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191951AF3B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 22:20:20 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2ef5380669cso18255117b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 22:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9rOQ7hvHLxB3moj1O/bwb31/4aNeEgRsTYca19oftZI=;
        b=F98r2yyvY61vmrydwDsFddEldktZVQFndjWB7jNQ9n0wdWhhoOnMyAwuR74I2dsqnf
         rSKJMgw+1KdUvhAVGZWMgFxsXd+ga9GouhuRUrZW88pEKzPcvbNJZyNeh5Dx2ErU6de9
         9wUbTQL0FAIM849aPGT6m0F+c4MsZP6tZ4Aw1ItRwPsoErpFUDHsvfCiytCFfpQ42iJQ
         3YV+7bvFXlOIA88JYvFuJoi+ULuQz0NOsUUbrszSUSHVVyoI00h8s1EBH/+pihkDWmr6
         jMowIFL7FoGcx/ir55XmMROCIiEWIJtCCGtQR4ripYqRGCuPUPP+PGm4nXi8EdBoNr5Z
         Di3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9rOQ7hvHLxB3moj1O/bwb31/4aNeEgRsTYca19oftZI=;
        b=mn3Pa2PukccJAVjqC1G0LFy9xnq7nLC1msOYbCPb+ZzEBwVVp1gtzynzndbegUUHqR
         3K1MLA2QjxYLuSRf+sC9oQbH0jlZ9hpS6/BkyU/uA8t9N+JCosDhJCPq8h+qsltTKWaP
         5Juvqln04vy2SThjgF0IqWEDJxzb1R/8YOifIJC/Fu6SoyXDk3FvflglLjLpfK4yv8jw
         RvEIjgHEK2CzGvKngWJsB3XjaG51xbwaOKdfLWnqNjredlwkMDU1LpEAkRxE2krEG5vp
         lf/dumKDKfyKfhX/Ff77djcQv5PPRpQQGVozNWAo+sxdFhtqdHgPQR5Mna0ZECs8wUAn
         vcBA==
X-Gm-Message-State: AJIora+bDsljTKM36M6AtLOq5v+uqzOVSV1q2PlEa4FIDH5r6eSK5c2T
        bog2+J0E5BY6Ma+e1hd7nDPj0mypdogaQCUrLZ4=
X-Google-Smtp-Source: AGRyM1u79B8Kpy9Yu6wMOLAwnyt0CcwFlTwrpdQCx2OBQ2ONnsbMMnZODJZNT14wScsV7XnlFCjajgxGd6UJz3SAtJI=
X-Received: by 2002:a0d:d78c:0:b0:30c:86df:ea5d with SMTP id
 z134-20020a0dd78c000000b0030c86dfea5dmr3636761ywd.389.1655184019363; Mon, 13
 Jun 2022 22:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220612105937.30862-1-wuchi.zero@gmail.com> <20220613111404.5253fe6ac69f5fd145dd437c@linux-foundation.org>
In-Reply-To: <20220613111404.5253fe6ac69f5fd145dd437c@linux-foundation.org>
From:   chi wu <wuchi.zero@gmail.com>
Date:   Tue, 14 Jun 2022 13:20:08 +0800
Message-ID: <CA+tQmHDFMJq1DH7Kmzp13vxvZoiKzRokt_TeF0w5Eboi6VaaJQ@mail.gmail.com>
Subject: Re: [PATCH] lib/genalloc: Set chunk size to real size which gen_pool managed.
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     alexs@kernel.org, sjhuang@iluvatar.ai, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> =E4=BA=8E2022=E5=B9=B46=E6=9C=881=
4=E6=97=A5=E5=91=A8=E4=BA=8C 02:14=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, 12 Jun 2022 18:59:37 +0800 wuchi <wuchi.zero@gmail.com> wrote:
>
> > The demand size (chunk->avail > size > round_down(chunk->avail)) will
> > lead to meaningless algo calls in gen_pool_alloc_algo_owner without the
> > patch, alse move the follow code:
> >       size =3D nbits << order
> > out of read-side critical section.
> >
>
> Nobody has seriously worked on this code in a long time :(
>
> Please expand more on the flaw.  What are "algo calls"?  Why are they
> meaningless, etc?  What are the runtime effects of this error?
>
The following case may be far away from the real use scenario:
1. In function gen_pool_create, we get:
    pool->min_alloc_order =3D 6;       //(64)
    pool->algo =3D gen_pool_first_fit;

2. In function gen_pool_add_owner, add chunk (size =3D 4k + 32   ?) to
pool:                              [a]
    (
     nbits =3D size >> pool->min_alloc_order =3D (4k + 32) >> 6 =3D 4k >> 6=
;
     for the nbits bitmap, we managed the 4k size.
    )
    chunk->avail =3D 4k + 32;

3. after some alloc actions, the chunk state is:
    chunk->avail =3D 32;
    (the remain 32 Byte is out of managed)

4. In function gen_pool_alloc_algo_owner, we want to alloc size =3D 32
Byte, we may do the follow step:
    list_for_each_entry_rcu(.......)
        if (32 > chunk->avail)      =3D=3D=3D> if (false)
            continue;
        .........
        start_bit =3D algo(chunk->bits, end_bit ....)      =3D=3D=3D>
gen_pool_first_fit(chunk->bits, end_bit ...)           [b]

for [b], In step 4, the real avail size chunk managed is 0, but we
still call the algo to alloc... which is meaningless.
                           the final result is ok, just there are some
redundant steps.

for [a], the root reason is the memory size  %  pool->min_alloc_order
!=3D 0. (though I also doubt if this exists).
> > --- a/lib/genalloc.c
> > +++ b/lib/genalloc.c
> > @@ -193,6 +193,7 @@ int gen_pool_add_owner(struct gen_pool *pool, unsig=
ned long virt, phys_addr_t ph
> >       if (unlikely(chunk =3D=3D NULL))
> >               return -ENOMEM;
> >
> > +     size =3D nbits << pool->min_alloc_order;
>
> If we're going to do this then gen_pool_add_owner() no longer needs its
> `size' argument.
>
>
Sorry, What point did I misunderstand=EF=BC=9F
The chunk owns a bitmap itself,  and nbits is calculate from size in
gen_pool_add_owner:

unsigned long nbits =3D size >> pool->min_alloc_order;
......
size =3D nbits << pool->min_alloc_order;
