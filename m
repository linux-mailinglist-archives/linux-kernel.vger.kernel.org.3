Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6D65443DF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 08:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbiFIGf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 02:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbiFIGfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 02:35:21 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7DA30557;
        Wed,  8 Jun 2022 23:35:20 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id w20so14806501lfa.11;
        Wed, 08 Jun 2022 23:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5k/LjccvaikJ+eBEqduBSIW5NO0M91symnhTe30/FZI=;
        b=TG5P/jOhm/GqNEc+I2Txp4nZ30m6y7oVShefLeKz7zQuPkVhSUUMeuZu30kuzHW7YZ
         5C8lO9ukM5+unqVpCQwQE/5uGwFTm8Radr7eubJfq4K9RjzzHhzPARzNzWC1Pscg3CMz
         nPOfztGg4t6ujCy3FXi7LOFxHSQ5RjTVuv9G5kO1lgLJk90A8tawyxufWIfF2XaUmzlo
         04+GFdOGwfQvDS5TamfE4mTlQC0te0ZULJOisXZDLeX5FpLoPTNG9qd0qTPsBv+ZBo3W
         gLTDpmFQINCTxDD/i4QB0UQCAfDN5fy/x8WgPD/CXalargPvX0di6CqjEigWCW0DdNi/
         3bxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5k/LjccvaikJ+eBEqduBSIW5NO0M91symnhTe30/FZI=;
        b=aSe4GqPGF8mT1kSVJtkSynmfu4q1uZsDqvBbHMyQ06pAgWxOEjNH08NiKR+8vdwWWp
         e/OWPcY9pN92jsLA0oIs/tCQfixW4H0QZD9aOlrSu9AvBYvrcuxWHm1WizIOQelqCw5z
         hILf1qwzA85lyvriLrVKTyF2hhQk76V+YDi9miKk31rSo3AodNblyTnwm4IzLqcR12Vw
         nm7Vq7H7+BFM3cD3V2ak1TGKVMqVw+Ll1Ivvs5fNzlx7xLksiT4iUySXj7z+gZ3l+zpF
         2Df69UFNGop5AB/mV1okhDOTp0MJk0BUT+lI66dS5d24Z+J2eHVyvoc5rCZobYS7zT41
         ADog==
X-Gm-Message-State: AOAM5314ibLclCu4nftqXcGl2OKj3m3E/27HBGMr/dO1EEd0QeZEn9GA
        mX6v4al2vGgFzttseq138PTPhx85VttOJBUBVnDvemYS
X-Google-Smtp-Source: ABdhPJyFnfJae7mt5bBlEmzK1eNW7vfgBpZsel/i2E0gdbwP8xGDAayfM3kLMnkWeD0k4eBnDvZzvsU0rIGMu/wmvSA=
X-Received: by 2002:a05:6512:529:b0:479:2158:da27 with SMTP id
 o9-20020a056512052900b004792158da27mr17202634lfc.389.1654756518692; Wed, 08
 Jun 2022 23:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <1654581161-12349-1-git-send-email-u0084500@gmail.com>
 <1654581161-12349-4-git-send-email-u0084500@gmail.com> <Yp+gS6r5Kpi33Ags@sirena.org.uk>
 <CADiBU38+0vp3Dv6i7uYzCwR431PKBr-HNQnY0Qe7fvvRYGEJmw@mail.gmail.com> <YqB19O/HYvEAxdiM@sirena.org.uk>
In-Reply-To: <YqB19O/HYvEAxdiM@sirena.org.uk>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Thu, 9 Jun 2022 14:35:07 +0800
Message-ID: <CADiBU390XRXZ2yx5CT2NxhN3aROHXcxs7w2d-xhB6+EYn+uTfA@mail.gmail.com>
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
 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:12=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Jun 08, 2022 at 11:15:56AM +0800, ChiYuan Huang wrote:
> > Mark Brown <broonie@kernel.org> =E6=96=BC 2022=E5=B9=B46=E6=9C=888=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=883:00=E5=AF=AB=E9=81=93=EF=BC=9A
> > > On Tue, Jun 07, 2022 at 01:52:40PM +0800, cy_huang wrote:
>
> > > > +     static const char * const name[] =3D { "buck1", "buck2", "buc=
k3", "buck4",
> > > > +                                          "ldo", "exten" };
> > > > +     static const char * const sname[] =3D { "vin1", "vin2", "vin3=
", "vin4",
> > > > +                                           "vinldo", NULL };
>
> > > It would be easier and clearer to just make this a static table like
> > > other drivers do, there's no need to generate anything dynamically as
> > > far as I can see.
>
> > My excuse. let me explain it.
> > buck1 voltage range from 600mV to 1393.75mV.
> > buck2~4/ldo/exten is the fixed regulator.
> > buck3 and buck4 is fixed by the IC efuse default.
> > buck2 and ldo is fixed by the external resistor chosen.
> > exten is designed to connected to the external power.
>
> > That's why I cannot directly declared it as the static regulator_desc.
>
> So buck 2-4 need some dynamic handling then but the rest can be static -
> that would be a lot clearer.  You could also have a template for the
> ones with some dynamic values and just override the few fields that need
> it.
>
Not just buck2/3, buck2/3/4/ldo/exten all need the dynamic handling.

> > > > +     if (init_data->constraints.min_uV !=3D init_data->constraints=
.max_uV) {
> > > > +             dev_err(priv->dev, "Variable voltage for fixed regula=
tor\n");
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > > +     desc->fixed_uV =3D init_data->constraints.min_uV;
> > > > +     init_data->constraints.apply_uV =3D 0;
>
> > > Drivers should never override constraints passed in by machine driver=
s,
> > > if there's validation needed let the core do it.  The same probably
> > > applies to providing a voltage range for a fixed regulator though tha=
t's
> > > not modifying everything so not such a problem.
>
> > Please check the above explanation about each power rails.
>
> I'm not sure what you're referencing here?
>
Sorry. Let me explain it.
You mean 'of_parse_cb' must not override constraint.
But if the regulator is fixed and dynamic, after
'of_get_regulation_constraint', apply_uV will be true.
The is referring to 'fixed.c'

> > > > +     for (i =3D 0; i < RT5120_MAX_REGULATOR; i++) {
> > > > +             ret =3D rt5120_of_parse_cb(priv, i, rt5120_regu_match=
 + i);
> > > > +             if (ret) {
> > > > +                     dev_err(priv->dev, "Failed in [%d] of_passe_c=
b\n", i);
> > > > +                     return ret;
> > > > +             }
> > > > +     }
> > >
> > > This is all open coding stuff that's in the core - just provde an
> > > of_parse_cb() operation and let the core take care of calling it.
>
> > Ditto
>
> Or here.
If I put 'of_parce_cb' to make core handling it, the input parameter
'init_data' is declared as const.
I cannot override the 'apply_uV'.
Right?
