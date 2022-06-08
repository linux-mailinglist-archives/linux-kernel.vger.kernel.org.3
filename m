Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8982454262D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbiFHFrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbiFHFn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:43:56 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6062F339F;
        Tue,  7 Jun 2022 20:16:09 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id s6so31142964lfo.13;
        Tue, 07 Jun 2022 20:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vo0VMstPODsOVm9F+73hmx2i5yuGMiFhVrn2x2r0IPw=;
        b=kZ0NxovVuEcmTxA0c8KeSzivNgtqLnmU9P6g7jVG5R6Nm98gZDH+YyCFSTWn5aG0Pe
         3PGEOTXeur5M47QgsreQRMVGBCig4rBAgL0tLPH0wbCLQW3bCY9WHPpHinlq/vqadrLW
         26B6MhXfotbIzgaZ9ybots3cFg2i6pMaXXG4FV52Cmc3RSmt/No3EsYHIfbKVunK7tSx
         PDMATWge6fHaTrycSJRlk9PFsxqpmjFBU7s3NTj0piGkCHiJvcxA88TcVuxJojof2HwL
         7ry6l1IEHS8HReUnZx2mUI/57Kp8OkmlxKclEl7l3NmRPy3g6u5wxA/4vI3nNzHh+a2L
         jtiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vo0VMstPODsOVm9F+73hmx2i5yuGMiFhVrn2x2r0IPw=;
        b=3dpqjuverZ8ixz3GmPed6bvn+vc32dzaKgej+M0RqsLMNTEiwnD6pG7OFPl7G06irU
         bSHEJ6d3rzqdZt2csYngM3p9ONzYHqK+TB0GtGVY4e1j1RHkDIWOzXfy9o/b30qvZWuw
         chd8Jeo12F5cKE3HCfZoEnz+xhX1gTwkEFpAfC2IjE3p82X36qkJc8IQbWZVrY8tuuaW
         /fer+97wFCvuOrOmJKyVoWL1hY9hooSn0BajRpxAtuGVdXexdMKebqffhx6GxuTHao+w
         rkWiCDwY8PLgZA7vX49PJiMZMbxMXCm+FVBQqrLxLPVyCMcrAFxF/98v4Dcn9TD1YGZE
         258A==
X-Gm-Message-State: AOAM531TtKhFIUbgJH+SKuUfjh4CC8ddvp1G/P4t2juWFO2SoecvQ0xJ
        nx/eQ68oIJUr/zw4hx7PWWXBqcFDKpG3YVt5O5G1PEhgqEY=
X-Google-Smtp-Source: ABdhPJxTZqjwPD8Nqt09D6WBDUTMk9TPZFYrD71DVuO6JDezzrn67akC+sEJFYGZJ3RkbHhYnMPlY1LXkINJghXZG+8=
X-Received: by 2002:a05:6512:3a89:b0:479:52fc:f80a with SMTP id
 q9-20020a0565123a8900b0047952fcf80amr7232607lfu.120.1654658167965; Tue, 07
 Jun 2022 20:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <1654581161-12349-1-git-send-email-u0084500@gmail.com>
 <1654581161-12349-4-git-send-email-u0084500@gmail.com> <Yp+gS6r5Kpi33Ags@sirena.org.uk>
In-Reply-To: <Yp+gS6r5Kpi33Ags@sirena.org.uk>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 8 Jun 2022 11:15:56 +0800
Message-ID: <CADiBU38+0vp3Dv6i7uYzCwR431PKBr-HNQnY0Qe7fvvRYGEJmw@mail.gmail.com>
Subject: Re: [PATCH 3/4] regulator: rt5120: Add PMIC regulator support
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, dmitry.torokhov@gmail.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
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

Mark Brown <broonie@kernel.org> =E6=96=BC 2022=E5=B9=B46=E6=9C=888=E6=97=A5=
 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=883:00=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Jun 07, 2022 at 01:52:40PM +0800, cy_huang wrote:
>
> This looks mostly good, a few things though:
>
> > +static void rt5120_fillin_regulator_desc(struct regulator_desc *desc, =
int rid)
> > +{
> > +     static const char * const name[] =3D { "buck1", "buck2", "buck3",=
 "buck4",
> > +                                          "ldo", "exten" };
> > +     static const char * const sname[] =3D { "vin1", "vin2", "vin3", "=
vin4",
> > +                                           "vinldo", NULL };
>
> It would be easier and clearer to just make this a static table like
> other drivers do, there's no need to generate anything dynamically as
> far as I can see.
My excuse. let me explain it.
buck1 voltage range from 600mV to 1393.75mV.
buck2~4/ldo/exten is the fixed regulator.
buck3 and buck4 is fixed by the IC efuse default.
buck2 and ldo is fixed by the external resistor chosen.
exten is designed to connected to the external power.

That's why I cannot directly declared it as the static regulator_desc.
>
> > +static int rt5120_of_parse_cb(struct rt5120_priv *priv, int rid,
> > +                           struct of_regulator_match *match)
> > +{
> > +     struct regulator_desc *desc =3D priv->rdesc + rid;
> > +     struct regulator_init_data *init_data =3D match->init_data;
> > +
> > +     if (!init_data || rid =3D=3D RT5120_REGULATOR_BUCK1)
> > +             return 0;
> > +
> > +     if (init_data->constraints.min_uV !=3D init_data->constraints.max=
_uV) {
> > +             dev_err(priv->dev, "Variable voltage for fixed regulator\=
n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     desc->fixed_uV =3D init_data->constraints.min_uV;
> > +     init_data->constraints.apply_uV =3D 0;
>
> Drivers should never override constraints passed in by machine drivers,
> if there's validation needed let the core do it.  The same probably
> applies to providing a voltage range for a fixed regulator though that's
> not modifying everything so not such a problem.
Please check the above explanation about each power rails.
>
> > +static int rt5120_parse_regulator_dt_data(struct rt5120_priv *priv)
> > +{
> > +     struct device *dev =3D priv->dev->parent;
> > +     struct device_node *reg_node;
> > +     int i, ret;
> > +
> > +     for (i =3D 0; i < RT5120_MAX_REGULATOR; i++) {
> > +             rt5120_fillin_regulator_desc(priv->rdesc + i, i);
> > +
> > +             rt5120_regu_match[i].desc =3D priv->rdesc + i;
> > +     }
>
> Like I said above just make the list of regulators static data and loop
> through registering them.
Ditto
>
> > +
> > +     reg_node =3D of_get_child_by_name(dev->of_node, "regulators");
> > +     if (!reg_node) {
> > +             dev_err(priv->dev, "Couldn't find 'regulators' node\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     ret =3D of_regulator_match(priv->dev, reg_node, rt5120_regu_match=
,
> > +                              ARRAY_SIZE(rt5120_regu_match));
> > +
> > +     of_node_put(reg_node);
> > +
> > +     if (ret < 0) {
> > +             dev_err(priv->dev,
> > +                     "Error parsing regulator init data (%d)\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     for (i =3D 0; i < RT5120_MAX_REGULATOR; i++) {
> > +             ret =3D rt5120_of_parse_cb(priv, i, rt5120_regu_match + i=
);
> > +             if (ret) {
> > +                     dev_err(priv->dev, "Failed in [%d] of_passe_cb\n"=
, i);
> > +                     return ret;
> > +             }
> > +     }
>
> This is all open coding stuff that's in the core - just provde an
> of_parse_cb() operation and let the core take care of calling it.
Ditto
>
> > +static int rt5120_device_property_init(struct rt5120_priv *priv)
> > +{
> > +     struct device *dev =3D priv->dev->parent;
> > +     bool prot_enable;
> > +     unsigned int prot_enable_val =3D 0;
> > +
> > +     /* Assign UV/OV HW protection behavior */
> > +     prot_enable =3D device_property_read_bool(dev,
> > +                                     "richtek,enable-undervolt-hiccup"=
);
> > +     if (prot_enable)
> > +             prot_enable_val |=3D RT5120_UVHICCUP_MASK;
>
> Use the DT APIs to parse DT - since ACPI has a very strong idea of how
> power management works which is fundamentally incompatible with with the
> DT model we should be writing code in a way that minimises the risk that
> we'll end up trying to parse DT properties out of ACPI systems and
> creating confusion as DT and ACPI software tries to run on the same
> system.
Ok, I'll replace it by DT API 'of_property_read_bool'.
