Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EA8573DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 22:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbiGMUPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 16:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiGMUPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:15:02 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B4E22B3A;
        Wed, 13 Jul 2022 13:15:01 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-31c89111f23so124898607b3.0;
        Wed, 13 Jul 2022 13:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JcckXV4vcsS2l/x+/u953cckoakHIp9f7/cP8rerxZE=;
        b=anlOJCiMrQgqUL3vsJNDj/PuCveRb4PSCTzrBgey28HdzAIh2iRanGaXPZj+BvoCIC
         aZiKguqPQq9NuLjBsPcHaEgTOrayU2x0jPiljTZMV8qiuxXdLzcgYZ2+NG7R8yU98Ffp
         e1QmJlYMpF7fIG/l8zGF9Z7myRnNDKme02Mr+6JpS3HdzeyjdgkLaDUfvUlkQbgOjOxs
         2x9/mZch870lKcWV45aNseqRHnH7bAKkWganEVdY8yPD9cqsd9Fy3MY23D6xtKSoNF+5
         ryTR5ZFM7JBBAWjRCv79rmJJ6GHP54I2QxFvPke4XNNd4QeV/QtlgnNg0dFRks9fMpDc
         QnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JcckXV4vcsS2l/x+/u953cckoakHIp9f7/cP8rerxZE=;
        b=bNiU6dWDI9CHpXV9guYg6qF887GYnskoke7jQ5gyipmSLXsswNwOGwTuDdxvwYJnj8
         QmJwUM5RrUYzRHyBToJ6Z3TF42AeZqYqWg3Fqo/YAih9KPR2f0m6dz6Nh38EL5dfZE5O
         pXcQ/+fXiTFwsxoFRamUW/uQtUsTF5+zTwGFzm31dF36hPhBVVcRNzTmAz9nDMTlfVAF
         giIfJEWm8HX4v2UKqWncA7QEVtL46JPUfcFbKXiglkcmLyAjrAD/txoMsCQ1q8aN/tlq
         YkGYccJLkKof2ITV4FhHcc9qW1MopBy4jZXdpxIAqaH5l7E6F2zQsLs2qbm1pGm9Y0VF
         wGpg==
X-Gm-Message-State: AJIora+k8vXh/vl9JkVhvKzqJ9JOD4VvHye/uK7v6PyOKE5DkufxDBCE
        w/s1XvLN+e+eDKYvbfpRH1Ty7eRo9DahE0fL9EA=
X-Google-Smtp-Source: AGRyM1sdgv3mvfCz2ZSOb164tqPgKAdiyD+LPHLwhHyC3p3u3G4R9aGXA/Q080Jl/AzHSEipJn65gDAlH35Cxg34xoI=
X-Received: by 2002:a81:3984:0:b0:31c:b59e:a899 with SMTP id
 g126-20020a813984000000b0031cb59ea899mr6196759ywa.195.1657743300495; Wed, 13
 Jul 2022 13:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220713163201.136202-1-sebastian.fricke@collabora.com>
 <Ys8Txuq9/u/EL6sj@yury-laptop> <CAHp75VeOLfKw4-+Dpn54yy6j=tdiBNA_2Kvhj7mUUjTD-M_vYA@mail.gmail.com>
 <Ys8gpl3m+vvEM7Sy@yury-laptop>
In-Reply-To: <Ys8gpl3m+vvEM7Sy@yury-laptop>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jul 2022 22:14:24 +0200
Message-ID: <CAHp75VeGSWoq-a10nA9NLKBEX7L_eiL0zPMJHUbX=c64wG8hkg@mail.gmail.com>
Subject: Re: [PATCH 3/6] bitops: bitmap helper to set variable length values
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>, knaerzche@gmail.com,
        Collabora Kernel ML <kernel@collabora.com>,
        bob.beckett@collabora.com,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-staging@lists.linux.dev, nicolas.dufresne@collabora.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 9:44 PM Yury Norov <yury.norov@gmail.com> wrote:
> On Wed, Jul 13, 2022 at 09:10:33PM +0200, Andy Shevchenko wrote:
> > On Wed, Jul 13, 2022 at 8:56 PM Yury Norov <yury.norov@gmail.com> wrote:
> > > On Wed, Jul 13, 2022 at 06:31:59PM +0200, Sebastian Fricke wrote:
> >
> > ...
> >
> > > I'd suggest you to try implementing
> > >         bitmap_copy_from(dst, src, dst_off, len)
> > > or even
> > >         bitmap_copy_from(dst, dst_off, src, src_off, len)
> > > if you expect that you'll need more flexibility in the future.
> >
> > Do you think it would be useful?
> >
> > We have bitmap_replace() & bitmap_remap(). Wouldn't that be enough?
>
> bitmap_replace and bitmap_remap have no an 'offset' parameter.

True.

But then it's a bit too generic to have this src_off, no?

I would rather expect for asymmetrical bitmaps that the other side
will be either one of the fixed width types (it makes sense to have
for 32- or 64-bit arguments.

When you have a source bitmap of x bits and  you would like to copy it
into a y-bit one, I would think that either you have a small amount of
bits in x anyway, or x is a full-sized bitmap (same order as y). Also
keep in mind that granularity is long, so less than long it makes no
sense.

  bitmap_copy_from_T(unsigned long *map, start, len, T src),

where T is type, start is the offset in map, len is the amount of bits
from src starting from 0. That's what is required in most of the cases
I believe.

-- 
With Best Regards,
Andy Shevchenko
