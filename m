Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674865B1451
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiIHGCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiIHGC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:02:26 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C79CAC63;
        Wed,  7 Sep 2022 23:02:22 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z97so1425743ede.8;
        Wed, 07 Sep 2022 23:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=pzAYh75bCi6mD7QguChUHb7Kk1cOW8K0HQEeNEeD7Ac=;
        b=isJpu1ZzOk7SWcVpQ1/WrUXtRTesDoawD1Ni2+2GCCTltnlmHOsDeu68vlyejR5Two
         ps7tS8ujfYW8GKkdtzmpUxvNDQLXFCe6kgm0tfPv3lZW11bmWreXEf6NEcetqaMobaVA
         YHbgJqj04y29x44HtR763vlkYuvmgBzTdKvLmuiFKiIlLaCzveagK4r5ebjFoxluTgcV
         bnVMy6dHkXxG/pIbCgvIStNhlFgQ5GykZHsHFawd6bCooUKGu506J8WEhXG1Fs/+hJZH
         zFxoodCiiS6u112EWKzXUpLP3fY2q9xtNDxeBQ/JkG5GsidgndnuoSiyQzRa+BYH+R3B
         k40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pzAYh75bCi6mD7QguChUHb7Kk1cOW8K0HQEeNEeD7Ac=;
        b=NE7l6t2rgeyuwTZN0AzotAssLhF0/SWehhllyCOw9J+RiJgEHCiPnOafZW63DR1gYp
         ebovGPYGefs3kpQ4QB8Csb2vFYtfwDvBaenf9DYHc3HRc40tJbJDAulb7oGt0dcI4GGF
         tdyWdvtx5TTqoXLhUBuzHcZdMaHf54lW7svyzoATLXPHemmTVsEmK4tyhpEowZT92p5y
         9/456w0z2CvYdnFHW1UjumaP4rB62uaR2oq3moDDPuPXfP4rcDhoohSD9H+itojVELww
         zrLKLukbR+K7H+SCY3gTNKAo3kUgSDBvRkynkGZQnAwqyaLPCsRKJVnZYYWtw8/qdqHk
         d4Rg==
X-Gm-Message-State: ACgBeo1cceWMaQ4evFUxIy8sYra7MOis7Ll+SQngCky+Gl3jkzEbQ93l
        Tp4eufazRnrPwZJl1OoLUN8yqxpqPSpFxl9/upZmBYscY4o=
X-Google-Smtp-Source: AA6agR7YLSA3qEKKP/tERou9Yn8POKGNnoNbNfX2RMWhngOS6mOmQu8L9WkWLpz8WwSWB0DscX9lbM+0VaFubXzMOeo=
X-Received: by 2002:a05:6402:28c8:b0:43e:8622:1c21 with SMTP id
 ef8-20020a05640228c800b0043e86221c21mr5681932edb.135.1662616940848; Wed, 07
 Sep 2022 23:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220903071543.2844698-1-dzm91@hust.edu.cn> <Yxip0d2bBOi/CB4P@kroah.com>
In-Reply-To: <Yxip0d2bBOi/CB4P@kroah.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Thu, 8 Sep 2022 14:01:15 +0800
Message-ID: <CAD-N9QWnqA_FKZ_PZ5gBgVkYykZfd3OOxSYPG7JZZ52aVwhkvg@mail.gmail.com>
Subject: Re: [PATCH] usb: misc: usb3503: call clk_disable_unprepare in the
 error handling
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, USB <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Wed, Sep 7, 2022 at 10:25 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Sep 03, 2022 at 03:15:40PM +0800, Dongliang Mu wrote:
> > From: Dongliang Mu <mudongliangabcd@gmail.com>
> >
> > Smatch reports the following warning:
> >
> > vers/usb/misc/usb3503.c:267 usb3503_probe() warn: 'hub->clk'
> > from clk_prepare_enable() not released on lines: 240,246,252
> >
> > Fix this by adding a flag to indicate if hub->clk is prepared or not and
> > invoke clk_disable_unprepare in the error handling.
> >
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >  drivers/usb/misc/usb3503.c | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/usb/misc/usb3503.c b/drivers/usb/misc/usb3503.c
> > index 330f494cd158..add47dd964b2 100644
> > --- a/drivers/usb/misc/usb3503.c
> > +++ b/drivers/usb/misc/usb3503.c
> > @@ -160,6 +160,7 @@ static int usb3503_probe(struct usb3503 *hub)
> >       struct usb3503_platform_data *pdata = dev_get_platdata(dev);
> >       struct device_node *np = dev->of_node;
> >       int err;
> > +     int is_clk_enable = 0;
>
> bool?
>
> >       u32 mode = USB3503_MODE_HUB;
> >       const u32 *property;
> >       enum gpiod_flags flags;
> > @@ -217,6 +218,8 @@ static int usb3503_probe(struct usb3503 *hub)
> >                       return err;
> >               }
> >
> > +             // set a flag for successful clk_prepare_enable
>
> Comment isn't needed.
>
> > +             is_clk_enable = 1;
> >               property = of_get_property(np, "disabled-ports", &len);
> >               if (property && (len / sizeof(u32)) > 0) {
> >                       int i;
> > @@ -236,20 +239,29 @@ static int usb3503_probe(struct usb3503 *hub)
> >       else
> >               flags = GPIOD_OUT_HIGH;
> >       hub->intn = devm_gpiod_get_optional(dev, "intn", flags);
> > -     if (IS_ERR(hub->intn))
> > +     if (IS_ERR(hub->intn)) {
> > +             if (is_clk_enable)
> > +                     clk_disable_unprepare(hub->clk);
> >               return PTR_ERR(hub->intn);
>
> This is getting messy, any way to make a common error handler at the
> bottom of the function instead?  That's the common kernel coding style
> for this type of thing.

I have addressed all the issues mentioned above:
1. change is_clk_enable to is_clk_enabled, and change its type to bool.
2. remove the comment and move the error handling code to the end of
probe function.
>
> thanks,
>
> greg k-h
