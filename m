Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B984D72D6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 06:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiCMFoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 00:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiCMFoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 00:44:09 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B74A2D1C9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 21:43:02 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id h21so891418ila.7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 21:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yeehAnwXiFpjq47LCkJzC+vZeMh+kdhUAc1wvTjLTKQ=;
        b=d15j8gZEJQ2cUKh8lIyS1UGKxT0GQRDadj6U6b5zp/zFIkaK8rHI0s8XZuz4eqi8ob
         I3K6xhmzr5iV/ZIk+GweWX06qMX0wTcI41QSx+nyDNUrsaSHf4KK9ipFE2F9udgT4r1/
         bMRzGQrpRmnoWIS+vkfBy3Uku9G+ZJzXECwUIcznZ1g25LQtEeIIspETWyFJr/lUj85F
         oCGYCLmFGRNpviEw5oYvW/gDFKnBJ8waBRZjdNRb+e9mQEYuTZln7NGY7ZBd4ZKcOyr5
         gPw554sJanMM/5vvrGRKQWpsXIDM7yBzFMu1YXvqqftKcvu/HCfQVgOMJMvpd8oJPG+8
         cWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yeehAnwXiFpjq47LCkJzC+vZeMh+kdhUAc1wvTjLTKQ=;
        b=KEbLo8iPHQwW2KE73y8sqP4uBhXd/g8+Aqj5UNTQLT8FjVEdraBNGh/gGlTSmg1XFZ
         Fkq8RS436QPoV5CTELaD5U6atOq50NGs0GZZ9vIwhuAvPCJesoc7IZH/+x04u2hZGBpA
         6d5N4DKrdKNO1nnSqdCnLltu5xB+o7TCpYtVL3c+yTtuf/0WQU2WuuXTk1V8cIbauPjL
         67QQqxREyGNK1jtCx1C3LpGLwMxY2M5SNLoKin9BH5UCeMrlHaYnxfrtgcRojmlGu1Xr
         V2LwXdGXzJYeBfDe+OHreHFZ6Atj0EPeCTB8wat9HVyp2YwpVCBoJEApK4B5Dcg4LJho
         nstg==
X-Gm-Message-State: AOAM532gYsvM5eLaWomHTB9mdwGdgqSdgtTntLdnZS0V1MS/jJwchOrj
        2lc1bTLWP1IZ0Z60vnyfOKqOyjOKX9Y1k8lVpaI=
X-Google-Smtp-Source: ABdhPJyLTEK5UR27XDcIpYknILzSaUN8Y3JJAFOiT/4220BDdd+8py7fiGMLjHgDdFYZ9jhehUyR6JKiC7uNev8Uebs=
X-Received: by 2002:a92:cdad:0:b0:2c6:7b76:a086 with SMTP id
 g13-20020a92cdad000000b002c67b76a086mr14632088ild.5.1647150181750; Sat, 12
 Mar 2022 21:43:01 -0800 (PST)
MIME-Version: 1.0
References: <20220312002429.16175-1-steve.lee.analog@gmail.com> <8f4a088ffc0fc1d4aa14aa1d0adf575cdc94291b.camel@gmail.com>
In-Reply-To: <8f4a088ffc0fc1d4aa14aa1d0adf575cdc94291b.camel@gmail.com>
From:   Lee Steve <steve.lee.analog@gmail.com>
Date:   Sun, 13 Mar 2022 14:42:50 +0900
Message-ID: <CA+Fz0PaRM7zCShHsK1WDAaFGwz1D2dV5LrvRqnYXkiB5i=rFPQ@mail.gmail.com>
Subject: Re: [RESEND V2] ASoC: max98390: Add reset gpio control
To:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc:     lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
        perex@perex.cz, tiwai@suse.com, ckeepax@opensource.cirrus.com,
        geert@linux-m68k.org, rf@opensource.wolfsonmicro.com,
        shumingf@realtek.com, srinivas.kandagatla@linaro.org,
        krzk@kernel.org, jack.yu@realtek.com,
        "Sa, Nuno" <nuno.sa@analog.com>, ryans.lee@maximintegrated.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
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

On Sat, Mar 12, 2022 at 9:58 PM Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>
> On Sat, 2022-03-12 at 09:24 +0900, Steve Lee wrote:
> >  Add reset gpio control to support RESET PIN connected to gpio.
> >
> > Signed-off-by: Steve Lee <steve.lee.analog@gmail.com>
> > ---
> >  sound/soc/codecs/max98390.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/sound/soc/codecs/max98390.c
> > b/sound/soc/codecs/max98390.c
> > index 40fd6f363f35..9a9299e5cc5a 100644
> > --- a/sound/soc/codecs/max98390.c
> > +++ b/sound/soc/codecs/max98390.c
> > @@ -1022,6 +1022,7 @@ static int max98390_i2c_probe(struct i2c_client
> > *i2c,
> >
> >         struct max98390_priv *max98390 =3D NULL;
> >         struct i2c_adapter *adapter =3D i2c->adapter;
> > +       struct gpio_desc *reset_gpio;
> >
> >         ret =3D i2c_check_functionality(adapter,
> >                 I2C_FUNC_SMBUS_BYTE
> > @@ -1073,6 +1074,17 @@ static int max98390_i2c_probe(struct
> > i2c_client *i2c,
> >                 return ret;
> >         }
> >
> > +       reset_gpio =3D devm_gpiod_get_optional(&i2c->dev,
> > +                                            "maxim,reset-gpios",
> > GPIOD_OUT_LOW);
>
> A reset GPIO is a standard property so there's no need for a vendor
> prefix. This should be devm_gpiod_get_optional(&i2c->dev, "reset",
> ...). And, as said before, you need to add a reset-gpios property to
> the bindings in a different patch.
>
> I'm also not sure why you have this as RESEND...
>
> - Nuno S=C3=A1
> >
>

I forgot to add another patch mail. I will check it before sending patch ag=
ain.
