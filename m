Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBB24E74D8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 15:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359278AbiCYOLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 10:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349372AbiCYOLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 10:11:50 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6892664BF9;
        Fri, 25 Mar 2022 07:10:15 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id q14so10442828ljc.12;
        Fri, 25 Mar 2022 07:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vjMQKB7f98Z5J+/YkB4ittNRPhfVz3vZoLW+Mp/DFBM=;
        b=b//i+uq5BpLjo7jrpuEtgpcU6FVbeJcxvGSJ5DGChh+zTG2S3gOkEcCRlYgdUM3xuP
         W6995GNRJANIHrohgpH6+YbaYBE7qJFiA0Yrk7wiKug+9ERZD6nKHkoGM/mJpmUG2cup
         ixeKH57/sFnDv0fDcv/eazgQsUM3zq0A5/36Hc70N7HiuueuGn9xk4E/gX3+LHfdO7sc
         Yjcv5unAhx+vCt8pRr0uy30igInAsQmBZi3JVMhKx/DvgS8OU+1MYHqj0Bt1aCOP3GaE
         Y8tE0slKyE6TUs4MbxKbQAlwaXt8VSW3bUuUI8fbrHeS914IlkD14MPTQKQrW4fq1Bw4
         S/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vjMQKB7f98Z5J+/YkB4ittNRPhfVz3vZoLW+Mp/DFBM=;
        b=iQLm3vVrcHMBruHYFmgG7IbF9Md4ThjribmRkaanQKrlL1pk0F84+PTExzv1hggHO3
         stQkWX34iGqg2E8m9cEj2Qqdof40FP0JnJOJdOG+c0c9Y5mM+4mP5lGWyhthrU4CIorh
         Vd8pRs1TLz70uN9UArIctS6/NtN+FDT8F9QhPBcpEnTT3pMDjPw6bcvfrVdPdY1bez2c
         Pj0qw0Zj+oCqHCj7IerHW0D84mFBO+wJVDz0bRrHHvqjGlYRszhNRSqJnl5vl+NcxH+b
         hxNOQp6Jx9U+N1Sb8Vva1Ma9+XyuDBwkg3pTQtMMRjhS2+idC1J64m9P7xCqBD7Lkj/n
         s5CQ==
X-Gm-Message-State: AOAM532xk09N+tz4jvwv8IbyaffKldoR5QdP/mXxA9QYUr25fF+juu2a
        r2OxJGCaEFwmrVYsrJgtZpAswN7OYLmmkFttipjcV4eS
X-Google-Smtp-Source: ABdhPJxRH3WembxAMMA6TLjnNrs1XxrqE0d6wcy+bOkpzaikLcMU+GfR6UNvb3yw2MRQMQBScX3kDOD6mEuWL+yH43U=
X-Received: by 2002:a2e:888a:0:b0:249:8e84:65b8 with SMTP id
 k10-20020a2e888a000000b002498e8465b8mr8241848lji.56.1648217413668; Fri, 25
 Mar 2022 07:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <1648170401-6351-1-git-send-email-u0084500@gmail.com>
 <1648170401-6351-3-git-send-email-u0084500@gmail.com> <d2b431f8-9197-4a42-4ee2-4e771e20e0aa@kernel.org>
In-Reply-To: <d2b431f8-9197-4a42-4ee2-4e771e20e0aa@kernel.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Fri, 25 Mar 2022 22:10:02 +0800
Message-ID: <CADiBU39RGQj1-+yK18mZf3MR78KACKqb2kAxkCFKGXKpJ6Nqxw@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: rt5759: Add support for Richtek RT5759
 DCDC converter
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
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

Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2022=E5=B9=B43=E6=9C=8825=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=888:17=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 25/03/2022 02:06, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add support for Richtek RT5759 high-performance DCDC converter.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  drivers/regulator/Kconfig            |  10 +
> >  drivers/regulator/Makefile           |   1 +
> >  drivers/regulator/rt5759-regulator.c | 372 +++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 383 insertions(+)
> >  create mode 100644 drivers/regulator/rt5759-regulator.c
> >
>
> (...)
>
> > +static int rt5759_init_device_property(struct rt5759_priv *priv)
> > +{
> > +     unsigned int val =3D 0;
> > +     bool wdt_enable;
> > +
> > +     /*
> > +      * Only RT5759A support external watchdog input
> > +      */
> > +     if (priv->chip_type !=3D CHIP_TYPE_RT5759A)
> > +             return 0;
> > +
> > +     wdt_enable =3D device_property_read_bool(priv->dev,
> > +                                            "richtek,watchdog-enable")=
;
> > +     if (wdt_enable)
>
> No need for separate wdt_enable variable.
>
Ack in next.
> > +             val =3D RT5759A_WDTEN_MASK;
> > +
> > +     return regmap_update_bits(priv->regmap, RT5759A_REG_WDTEN,
> > +                               RT5759A_WDTEN_MASK, val);
> > +}
> > +
> > +static int rt5759_manufacturer_check(struct rt5759_priv *priv)
> > +{
> > +     unsigned int vendor;
> > +     int ret;
> > +
> > +     ret =3D regmap_read(priv->regmap, RT5759_REG_VENDORINFO, &vendor)=
;
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (vendor !=3D RT5759_MANUFACTURER_ID) {
> > +             dev_err(priv->dev, "vendor info not correct (%d)\n", vend=
or);
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static bool rt5759_is_accessible_reg(struct device *dev, unsigned int =
reg)
> > +{
> > +     struct rt5759_priv *priv =3D dev_get_drvdata(dev);
> > +
> > +     if (reg <=3D RT5759_REG_DCDCSET)
> > +             return true;
> > +
> > +     if (priv->chip_type =3D=3D CHIP_TYPE_RT5759A && reg =3D=3D RT5759=
A_REG_WDTEN)
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> > +static const struct regmap_config rt5759_regmap_config =3D {
> > +     .reg_bits =3D 8,
> > +     .val_bits =3D 8,
> > +     .max_register =3D RT5759A_REG_WDTEN,
> > +     .readable_reg =3D rt5759_is_accessible_reg,
> > +     .writeable_reg =3D rt5759_is_accessible_reg,
> > +};
> > +
> > +static int rt5759_probe(struct i2c_client *i2c)
> > +{
> > +     struct rt5759_priv *priv;
> > +     int ret;
> > +
> > +     priv =3D devm_kzalloc(&i2c->dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     priv->dev =3D &i2c->dev;
> > +     priv->chip_type =3D (unsigned long)of_device_get_match_data(&i2c-=
>dev);
> > +     i2c_set_clientdata(i2c, priv);
> > +
> > +     priv->regmap =3D devm_regmap_init_i2c(i2c, &rt5759_regmap_config)=
;
> > +     if (IS_ERR(priv->regmap)) {
> > +             ret =3D PTR_ERR(priv->regmap);
> > +             dev_err(&i2c->dev, "Failed to allocate regmap (%d)\n", re=
t);
> > +             return ret;
> > +     }
> > +
> > +     ret =3D rt5759_manufacturer_check(priv);
> > +     if (ret) {
> > +             dev_err(&i2c->dev, "Failed to check device (%d)\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     ret =3D rt5759_init_device_property(priv);
> > +     if (ret) {
> > +             dev_err(&i2c->dev, "Failed to init device (%d)\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     return rt5759_regulator_register(priv);
> > +}
> > +
> > +static const struct of_device_id __maybe_unused rt5759_device_table[] =
=3D {
>
> I don't think this can be __maybe_unused. It is always referenced via
> of_match_table, isn't it?
>
I think it can declared as '__maybe_unused'.
If 'of_device_id' is unused, then in probe stage,
'of_device_get_match_data' will return NULL.
priv->chip_type will get zero as the return value. And it will be
treated as rt5759, not rt5759a.
The difference between these two are only watchdog function supported or no=
t.

> > +     { .compatible =3D "richtek,rt5759", .data =3D (void *)CHIP_TYPE_R=
T5759 },
> > +     { .compatible =3D "richtek,rt5759a", .data =3D (void *)CHIP_TYPE_=
RT5759A },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, rt5759_device_table);
> > +
> > +static struct i2c_driver rt5759_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "rt5759",
> > +             .of_match_table =3D rt5759_device_table,
> > +     },
> > +     .probe_new =3D rt5759_probe,
> > +};
> > +module_i2c_driver(rt5759_driver);
> > +
> > +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> > +MODULE_DESCRIPTION("Richtek RT5759 Regulator Driver");
> > +MODULE_LICENSE("GPL v2");
>
>
> Best regards,
> Krzysztof
