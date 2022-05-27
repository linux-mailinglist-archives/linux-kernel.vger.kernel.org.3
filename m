Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEF8535788
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 04:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbiE0CY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 22:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiE0CY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 22:24:56 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0B5E27A5;
        Thu, 26 May 2022 19:24:54 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id h4so3058898vsr.13;
        Thu, 26 May 2022 19:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QvhKBJjGUiG7G8PpadcKf8ELEDTEzExAiqgsG99aSxM=;
        b=mBbmAl6FjJyf8/uGuc+JM8m3jjGD4++wND89c0YwmoUfKv9uxtcnlFOm6SAVysFfR8
         LuV7S6P1tMqdJ+AWryZ4E+GduRTIiJvOAAlESpU6RQqzaCRI23M9y8FYiyJFgsXUKOcm
         2L9peqMteW+4GSorZyudGmiIXphWNVVJ/CxXo238lHvM/d5RGvlmwyPsc6kmAlf9+j/9
         fqPCUG/YS3oABatxSC2rvKJg2XSxHu9X3YrAx2DQoVzHPd2vCGTWf6/2NcPJEng0CRLx
         jnY/niKmADvaV1vgnSePz9UGymiEJ0qaYdApQ+SnsGkJWg8NcbvJjp8aDYtGYb+OZ8b/
         knyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QvhKBJjGUiG7G8PpadcKf8ELEDTEzExAiqgsG99aSxM=;
        b=jfrZF8j9l1CcX3/HRUsKGlgQ7bfL0fJWaKJeM8wP4+lg1dBUNVX+Q5P+XJwJM9FYkB
         +Tj2hhI7n7y5o/rxVrDheHsbeu4WwgZDDqpLs9fk4+FcpSlEWyvXnjB5zRfB6fksDd8Q
         LecG7Fu2Sd7xBgJ6q228OeFJUdcnrnmEt6d5Fs96AlDtl984rIgVl5IdqJRwNd0HvXrP
         ePtAp8Fy0T/u/7JZUjolMMDYn2OZTfxGbwsATu7rbuMm8C7Vj9ggC1tWTN4f/Nk0rLqp
         DwmauooEO4Vr+y15GMYHyQk3R9YzImFvwa7h1FZy47bTgkhBM1HMtxCF2S/PwauT8nuy
         dLDQ==
X-Gm-Message-State: AOAM532nKoRFfale2F72KzFjYV51a3zE86u8Tlb75oOwi1hbWiBVcEK2
        5l5tKFpEM2LR/1xy2R30mc3YraaH4epVUu8nXRQ=
X-Google-Smtp-Source: ABdhPJwkZPvj4AjNTutTU0UnZb0VBCu1HQ5FumUGt7iv+OBdH1kfcKU5DRWqD7wVat93IE/BS4BJmsVF9rwuvgX1dsM=
X-Received: by 2002:a67:ef5b:0:b0:335:e3a3:9b33 with SMTP id
 k27-20020a67ef5b000000b00335e3a39b33mr16969880vsr.57.1653618293351; Thu, 26
 May 2022 19:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <1653534995-30794-1-git-send-email-u0084500@gmail.com>
 <1653534995-30794-3-git-send-email-u0084500@gmail.com> <20220526100510.3utwh5bov4ax2jmg@maple.lan>
In-Reply-To: <20220526100510.3utwh5bov4ax2jmg@maple.lan>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Fri, 27 May 2022 10:24:42 +0800
Message-ID: <CADiBU3_3rJ6uCYx_W+TZJpuPzGtt61QEDwZWtxy_abzynTr8VQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] backlight: rt4831: Add the property parsing for ocp
 level selection
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, jingoohan1@gmail.com,
        Pavel Machek <pavel@ucw.cz>, deller@gmx.de,
        cy_huang <cy_huang@richtek.com>, lucas_tsai@richtek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Thompson <daniel.thompson@linaro.org> =E6=96=BC 2022=E5=B9=B45=E6=9C=
=8826=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:05=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Thu, May 26, 2022 at 11:16:35AM +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add the property parsing for ocp level selection.
>
> Isn't this just restating the Subject: line?
>
Ah, that's my fault. I didn't state too much in the patch comment.
I only left it in the cover letter.

> It would be better to provide information useful to the reviewer here.
> Something like:
>
> "Currently this driver simply inherits whatever over-current protection
> level is programmed into the hardware when it is handed over. Typically
> this will be the reset value, <whatever>A, although the bootloader could
> have established a different value.
>
> Allow the correct OCP value to be provided by the DT."
>
> BTW please don't uncritically copy the above into the patch header. It is
> just made something up as an example and I did no fact checking...
>
OK, got it.
>
> >
> > Reported-by: Lucas Tsai <lucas_tsai@richtek.com>
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  drivers/video/backlight/rt4831-backlight.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/video/backlight/rt4831-backlight.c b/drivers/video=
/backlight/rt4831-backlight.c
> > index 42155c7..c81f7d9 100644
> > --- a/drivers/video/backlight/rt4831-backlight.c
> > +++ b/drivers/video/backlight/rt4831-backlight.c
> > @@ -12,6 +12,7 @@
> >  #define RT4831_REG_BLCFG     0x02
> >  #define RT4831_REG_BLDIML    0x04
> >  #define RT4831_REG_ENABLE    0x08
> > +#define RT4831_REG_BLOPT2    0x11
> >
> >  #define RT4831_BLMAX_BRIGHTNESS      2048
> >
> > @@ -23,6 +24,8 @@
> >  #define RT4831_BLDIML_MASK   GENMASK(2, 0)
> >  #define RT4831_BLDIMH_MASK   GENMASK(10, 3)
> >  #define RT4831_BLDIMH_SHIFT  3
> > +#define RT4831_BLOCP_MASK    GENMASK(1, 0)
> > +#define RT4831_BLOCP_SHIFT   0
> >
> >  struct rt4831_priv {
> >       struct device *dev;
> > @@ -120,6 +123,16 @@ static int rt4831_parse_backlight_properties(struc=
t rt4831_priv *priv,
> >       if (ret)
> >               return ret;
> >
> > +     ret =3D device_property_read_u8(dev, "richtek,bled-ocp-sel", &pro=
pval);
> > +     if (ret)
> > +             propval =3D RT4831_BLOCPLVL_1P2A;
>
> Is 1.2A the reset value for the register?
Yes, it's the HW default value.
>
> Additionally, it looks like adding a hard-coded default would cause
> problems for existing platforms where the bootloader doesn't use
> richtek,bled-ocp-sel and pre-configures a different value itself.
>
> Would it be safer (in terms of working nicely with older bootloaders)
> to only write to the RT4831_BLOCP_MASK if the new property is set?
>
Ah, my excuse. I really didn't consider the case that you mentioned.
It seems it's better to do the judgement here for two cases.
1) property not exist, keep the current HW value
2) property exist, clamp align and update the suitable selector to HW.

Thanks.
>
> Daniel.
>
>
>
> > +
> > +     propval =3D min_t(u8, propval, RT4831_BLOCPLVL_1P8A);
> > +     ret =3D regmap_update_bits(priv->regmap, RT4831_REG_BLOPT2, RT483=
1_BLOCP_MASK,
> > +                              propval << RT4831_BLOCP_SHIFT);
> > +     if (ret)
> > +             return ret;
> > +
> >       ret =3D device_property_read_u8(dev, "richtek,channel-use", &prop=
val);
> >       if (ret) {
> >               dev_err(dev, "richtek,channel-use DT property missing\n")=
;
> > --
> > 2.7.4
> >
