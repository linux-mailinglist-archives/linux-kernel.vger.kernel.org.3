Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0696568861
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiGFMcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbiGFMcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:32:18 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A1F26ACD;
        Wed,  6 Jul 2022 05:32:17 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 64so17773243ybt.12;
        Wed, 06 Jul 2022 05:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8fGAXjGlGnpjPR/MiR6gsPc9M+X2hCgjnxVgcSV7E3k=;
        b=P/KZVgStvwd6tySv/eqvZW97OYZrxBW12v9/apZmCsEtA/Q+sdmq9OqksdzHZulEya
         wFBpmwKk3nrt8R3dH8u2dMJgbSFpPpciBDSkjav7dd41r92zJAke3Gl4dNXktkEoa0QG
         T1nrgddl70vFVYEUx+/IizMxucxyR1Hds4UhCqPzmkDJZcTZapqwyoc1uWSH8iUJ3rdQ
         ilr6sNRvOYZktNBrDEtEg0+UKHO81nCyzOd4+bRrZAZUtVBMOKIklc3W20D3t9SoZWTf
         Hh/ladfy9L58v8UJCRMWnnNKAFOCryTiguhDsJw8bNOxZapPWrmn6TUhPofHAZ5f39b5
         SJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8fGAXjGlGnpjPR/MiR6gsPc9M+X2hCgjnxVgcSV7E3k=;
        b=oRWsjX82+2AAyrv4GpJvbyex4WGUT+TZxJnH5jJI85Vz5CPYHZk3UQwlmCssxumOMx
         TxGm16NTcdj7tTcXgHLhmYkHVPuCSOanUSCCYv6kqqCx/wglZPohPKvNxqrMfkQ9VLDL
         jDgw2YDtSOwO3KDx3wPs44PPw+9kVBjasyIOuOmTSnZ4uv3F86ZArlK6IJNAvBobCOQ9
         +O6HBwvKNSgvadFKzDFuR2mXWe4SdS5jynuiI1ILXDhq/xkLfUawxqdGUm2x+LXW38Ur
         HV490GXMGVpTfPXfg/bZLK5lCCddW5mnTQHjaiJVq1/F2tPH5gBcn0CIAPnCdjbKeR1r
         zhvg==
X-Gm-Message-State: AJIora93lbO76FL2+ZPZvVzRpUw3rvo1CMwfxrRkQOicBy4kqLJ6TjdB
        pzxRs1CEMoW/qzxGEvkB2Ha5oofGHMQiAf8vm/E=
X-Google-Smtp-Source: AGRyM1s4GlbjUriYI4OcdkNVJtgtJWpB1v8bCoaFXYo/uFZb8MEoGn1i49NyJ8LwAl23y4jn60aNhZquQqyShVxPDjM=
X-Received: by 2002:a05:6902:686:b0:66e:627f:4d29 with SMTP id
 i6-20020a056902068600b0066e627f4d29mr12612894ybt.385.1657110736868; Wed, 06
 Jul 2022 05:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220705171835.4923-1-brgl@bgdev.pl> <CAHp75Ve3sPhFOZhL=_2p+1avuo96CP995KD+bi+Pn3gyj1F9TA@mail.gmail.com>
 <CAMRc=MekRvEVjRKJn6CWpbk9GJWS0Y+kB9MYpGFSN9WSSzWC7A@mail.gmail.com>
In-Reply-To: <CAMRc=MekRvEVjRKJn6CWpbk9GJWS0Y+kB9MYpGFSN9WSSzWC7A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 6 Jul 2022 14:31:40 +0200
Message-ID: <CAHp75VdepbidJWgLZFk3ns13boZXRYvMqvLvXF_xYw=2ahZMgw@mail.gmail.com>
Subject: Re: [PATCH] gpio: pxa: schedule a devm action for the clock struct
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>, Yuan Can <yuancan@huawei.com>
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

On Wed, Jul 6, 2022 at 2:11 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> On Wed, Jul 6, 2022 at 1:49 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Jul 5, 2022 at 7:29 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

...

> > > Reported-by: Signed-off-by: Yuan Can <yuancan@huawei.com>
> >
> > Me puzzled.
>
> Yuan Can sent the following patch:
> https://patchwork.ozlabs.org/project/linux-gpio/patch/20220704130323.104294-1-yuancan@huawei.com/
>
> I responded that it was not complete and sent this instead.

I understand that, I am puzzled with Reported-by: followed by SoB.
What is this format? Is it something new and documented?


-- 
With Best Regards,
Andy Shevchenko
