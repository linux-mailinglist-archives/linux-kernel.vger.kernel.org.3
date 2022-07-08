Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDD656C360
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240083AbiGHVDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 17:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239883AbiGHVDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:03:36 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A1D38B0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 14:03:33 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id k30so20090008edk.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 14:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9D1dMV/wl41srQTjtMRnPPYS9ui9XJnIPQ6Za9rlFlg=;
        b=Mlj28zlSyiapgPsOC25mOdGjceagThnpsZDNvLIpB7QkJW/z+m4J3T6Vk8spQtLuNB
         2eWAunXuB/JvF8RbkQfVwtJSh49Ok/ziOZisiRDpFnXJpR0JdPBUL7U0IW0PPf9T7vgv
         NV5gxcEPQV45UetlaHVv3DZIizscOXMC80vExiOL93YMySdvKLSnu0hLum2XqRQl/xOw
         Rz4bevfs/GtrIiMAGs14zhOXpTGOH9YD1qXnW8gqMEeP55u4atRTA2lxBgVPGwvAqSZo
         2zbeWe5zWAAZgfSIcEMZPZp3Qho6vrLkSmuR/FRN2l/2QZVLb9UtfTL356262LScfrma
         fA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9D1dMV/wl41srQTjtMRnPPYS9ui9XJnIPQ6Za9rlFlg=;
        b=P4O8eT7+QwyfKQVBFDwL4F+GIkyP7+uOgVBMdrYuZqBTcONVNPHRtuGX35vvkPoIJY
         23XQsLj+YKrUY9GX9HCy7HpEp+eRWIZ2AGbeqaZnUnFLpwxxpzJ9Ky7qibmfZxqpX86y
         M6GN7FqLUpQdcfeFFrt0Hr0lAMpkpHkPqetnlR6z7LrKn53ls+irJmNaHvYDBSGlU7fR
         j3VF/fIap3oip9xWeIANdTBBmH4gbwq7+ovQz4bZwQqY9kiLc03Me4c+D7Xjcq9X5zkV
         icRVYBkI9UxYqQ3/U2GihHVMzTQvQBdUQoNNorxBVjlJrIIFutiBNViCDyNkLWfnwNnz
         RrVw==
X-Gm-Message-State: AJIora/g8QOIGD4Kqwd5spRdls+EV94OIGgGw1DuBP5Qaav4JYxIPlG2
        DUkMXomtYVVzLt/Yw3hgs2vLKwJqqlD2RTEvTZtzpA==
X-Google-Smtp-Source: AGRyM1tbbwYUYYk8XsfwFscqxkdupkHc0W0XT3xF1BJa3FD/cJrFY8UDnnp5VugaDFT3MkN/EHCuTvnbkg4NIYarsF4=
X-Received: by 2002:a05:6402:5306:b0:437:8bbd:b313 with SMTP id
 eo6-20020a056402530600b004378bbdb313mr7426246edb.123.1657314212044; Fri, 08
 Jul 2022 14:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220706184133.210888-1-ezequiel@vanguardiasur.com.ar> <2ae24b07-92ae-8bdb-8b2d-f90a4a9557a9@redhat.com>
In-Reply-To: <2ae24b07-92ae-8bdb-8b2d-f90a4a9557a9@redhat.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Fri, 8 Jul 2022 18:03:21 -0300
Message-ID: <CAAEAJfCwmdJEoayanWLodd9mj3hx0Y_4BME10SeTu4MF7pvWyw@mail.gmail.com>
Subject: Re: [PATCH] drm/ssd130x: Fix pre-charge period setting
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 7, 2022 at 5:37 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Hello Ezequiel,
>
> Thanks a lot for your patch.
>
> On 7/6/22 20:41, Ezequiel Garcia wrote:
> > Fix small typo which causes the mask for the 'precharge1' setting
> > to be used with the 'precharge2' value.
> >
> > Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> > ---
> >  drivers/gpu/drm/solomon/ssd130x.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
> > index 08394444dd6e..f4886e66ff34 100644
> > --- a/drivers/gpu/drm/solomon/ssd130x.c
> > +++ b/drivers/gpu/drm/solomon/ssd130x.c
> > @@ -350,7 +350,7 @@ static int ssd130x_init(struct ssd130x_device *ssd130x)
> >
> >       /* Set precharge period in number of ticks from the internal clock */
> >       precharge = (SSD130X_SET_PRECHARGE_PERIOD1_SET(ssd130x->prechargep1) |
> > -                  SSD130X_SET_PRECHARGE_PERIOD1_SET(ssd130x->prechargep2));
> > +                  SSD130X_SET_PRECHARGE_PERIOD2_SET(ssd130x->prechargep2));
>
> It's a typo indeed. Nice catch!
>
> I wonder how did you notice this. Or was it just looking at the code ?
>

Indeed, I was just reviewing the code while getting a SH1106 display to work.

> Acked-by: Javier Martinez Canillas <javierm@redhat.com>
>
> I'll push it to drm-misc (drm-misc-fixes).
>

Thanks!
Ezequiel

> --
> Best regards,
>
> Javier Martinez Canillas
> Linux Engineering
> Red Hat
>
