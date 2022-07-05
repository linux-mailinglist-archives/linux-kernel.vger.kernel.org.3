Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516505676FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbiGES44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbiGES4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:56:54 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554E21CB08;
        Tue,  5 Jul 2022 11:56:53 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 76so7869234ybd.0;
        Tue, 05 Jul 2022 11:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dDpLmzgCTNaag0l7E/auT86quNK4kZ8UAf8vd4GL+vY=;
        b=FSTgQmjT1A5oPfD0QfDB0xn+jyjsEW0QRgR1S8VKPO6GqcMTMG/veArbE39Y+fz0lj
         fIxOY7vPZIZ+eZFNgycrrsJOOREu5eyEZvru0H691bRCsb1oqKB9ySOZhfyx6ANnhCbr
         rKX/SvxuO5qChcBBoHMcvpFy/IS7FLSZEsHuQc0TxtfxwW59LS8N6gbOFEL/FJlC2dXS
         C2zv5Pzv3NUAG1GiBCf6vTMKpm9BBJGjpHRMA/QKwCUVB1qIIc+otnsX8atwLhnzEIb5
         HajuQ0BWnfeGCciivylxEHlk4Q10fup8BRAm5Rcxe/nzAoDatYnQgt1YTC0P0niMqjsj
         3G5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dDpLmzgCTNaag0l7E/auT86quNK4kZ8UAf8vd4GL+vY=;
        b=30oK/C7O6SVesK0JIso+Q+uwLVIFxgbZbeH4QFmtej5S2rYpLiEwlUMmI0cTKa0YK5
         yLyx80lUOON5WjgxTbXjCeyeelKeBxW+70/2xXRX4Gn5+h6j02jwL6wO0LKEd2qK5mtf
         mC/nNLWvL7C6EGOMyritRDspkVWUSARS+51x9eddaoDks8Vvksbkfrzxf8G3V2vn0BRD
         CCfT6mIf+bdQIBYuiCLJP/VMhbC7AZ03gfCN0UNt/EnRULMLig2UHwXEfKjV20RaQpbJ
         EGhhXtvUyJnfuG/S5aoKDKI9iBRXujGazoA22XekVs4x/TTfkwavGRkVU8vV/zIdDuqM
         415Q==
X-Gm-Message-State: AJIora9lO2fe8ux3NymCogCwtwJhdwfyqKSId7XRw/eIUCatjxIzs9xj
        ZcoGbvywOI2EqfI7ENTBFEuoDp+qpQpJj1oyklo=
X-Google-Smtp-Source: AGRyM1vhXskzcKZ6sXq/AtW3jjNFnj4urMoKIla7gCjfhBXmvrqCipn1iAay4wMX66hYNqInxrSIZ70fLjn7SopMcv8=
X-Received: by 2002:a25:dd83:0:b0:66c:8d8d:4f5f with SMTP id
 u125-20020a25dd83000000b0066c8d8d4f5fmr38806189ybg.79.1657047412542; Tue, 05
 Jul 2022 11:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220705163136.2278662-1-vincent.knecht@mailoo.org> <20220705163136.2278662-7-vincent.knecht@mailoo.org>
In-Reply-To: <20220705163136.2278662-7-vincent.knecht@mailoo.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Jul 2022 20:56:16 +0200
Message-ID: <CAHp75VfrROx1oM54x1Bc8+zLkPi6-ivxPtFS2ECyPPLKsYFd1g@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] leds: is31fl319x: Add support for is31fl319{0,1,3} chips
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
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

On Tue, Jul 5, 2022 at 6:32 PM Vincent Knecht <vincent.knecht@mailoo.org> w=
rote:
>
> Set specific chipset structs values for is31fl319{0,1,3}
> so that those chips can actually work.
> Datasheets:
> https://lumissil.com/assets/pdf/core/IS31FL3190_DS.pdf
> https://lumissil.com/assets/pdf/core/IS31FL3191_DS.pdf
> https://lumissil.com/assets/pdf/core/IS31FL3193_DS.pdf
> https://lumissil.com/assets/pdf/core/IS31FL3196_DS.pdf
> https://lumissil.com/assets/pdf/core/IS31FL3199_DS.pdf

...

Two comments as per previous patch reviews.

...

> +       struct is31fl319x_led *led =3D container_of(cdev, struct is31fl31=
9x_led,
> +                                                 cdev);

One line?

...

> +               ret =3D regmap_read(is31->regmap, IS31FL3190_PWM(i), &pwm=
_value);

> +               dev_dbg(&is31->client->dev, "%s read %d: ret=3D%d: %d\n",
> +                       __func__, i, ret, pwm_value);

regmap has tracepoints Do you need to duplicate it with slow printk()?

...

> +static inline int is31fl3190_microamp_to_cs(struct device *dev, u32 micr=
oamp)
> +{
> +       switch (microamp) {
> +       case 5000:
> +               return IS31FL3190_CURRENT_5_mA;
> +       case 10000:
> +               return IS31FL3190_CURRENT_10_mA;
> +       case 17500:
> +               return IS31FL3190_CURRENT_17dot5_mA;
> +       case 30000:
> +               return IS31FL3190_CURRENT_30_mA;
> +       case 42000:
> +               return IS31FL3190_CURRENT_42_mA;
> +       default:
> +               dev_warn(dev, "Unsupported current value: %d, using 5000 =
=C2=B5A!\n", microamp);
> +       }
> +
> +       return IS31FL3190_CURRENT_5_mA;

It's more consistent to return directly from the default case.

> +}

--=20
With Best Regards,
Andy Shevchenko
