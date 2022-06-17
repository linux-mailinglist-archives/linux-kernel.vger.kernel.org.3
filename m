Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8644154F3E3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381472AbiFQJHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380185AbiFQJHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:07:00 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E003F4B1DC;
        Fri, 17 Jun 2022 02:06:59 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id m16so1072511ilf.6;
        Fri, 17 Jun 2022 02:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qSNsJXRAq4gUj6ivdXbrjgAuRPp+HHbhKrKeTXicOCg=;
        b=Dl6LB9Q7n5EpkbYyX81Yn4cmxCMk5bOsvIkbCtCocr/dTjXuNz2CrJSviTnH0BS1ZA
         csEqG/oDAowT6GKI5Jv33GJEiHpYxvdMlDZhfZBBuw/eZ9Eo831Cknv0KsMHy7G0DWSs
         3swp9MPgLARrnm6iLy+/DP1EEaXbJ7LnAHzCQlBxp5v/D0UiuJmor5kJKMxWAzEUyXZI
         1+858U9fStR05SV0oD9CPijH25+Hp8jW+T2+F6TYxR/pS4vViGBRihmxY3Mm2QYpLSfc
         pMc8NksdwBd9eDGRApyinNjzZgukXbDtZkXMIRDLUvQKRqSpj3sI5S1JKd3VMT+YO5Eb
         /7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qSNsJXRAq4gUj6ivdXbrjgAuRPp+HHbhKrKeTXicOCg=;
        b=Oc49Mh4jy5yl8WXqLr2F8DcSrI9ZuHuz1dXMVc9JOcwhcUf6nI0bmU4cC7QLqT7kFM
         HCgdGhkkZFGHm30nqdWCK8eS8HBTkVibeQi4wLfeQNqQRmLzuSSwnk+OKU+sBQ902OJX
         NkqAiCMon0ihKbyV1t8YjUZkDPXwaKq68qllN3vsl40ZugTHS6wj52ptzJ7Lqo8fpgnB
         ykCyfNffEpTpTvUqzTesyv6sIPGANiStbAmSdUf6SNYyrBPkoqE3N/WuKxeaIXKE7Njw
         3kdVVdXosCNsix5DLGpgm/oL91hQC9orfoU9EbkifkklxV7rmU55lDqHuAxFiU39wBgj
         NTuA==
X-Gm-Message-State: AJIora8ExwknEIcqRGu/HaKBcPU02TaKCUGFiwIvEtyxn0a0a+50kta5
        Yu3J99mRA4IjTPW6fn3PFLcR9UCt4S00vXfiseNmvMY/gBE=
X-Google-Smtp-Source: AGRyM1tGCu6AS9wDCH8Gur5zYW6uSfoWWJs4DOW5mFrlMgAa3+NrBz1Bdl1bq12S+LuODQiyUM9pGAPCWwXJA6zrKuk=
X-Received: by 2002:a05:6e02:1aa4:b0:2d3:aeb9:930 with SMTP id
 l4-20020a056e021aa400b002d3aeb90930mr5026082ilv.45.1655456819325; Fri, 17 Jun
 2022 02:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220613111146.25221-1-peterwu.pub@gmail.com> <20220613111146.25221-11-peterwu.pub@gmail.com>
 <31b588e9-2233-3b40-e452-83f0f6bfb744@infradead.org>
In-Reply-To: <31b588e9-2233-3b40-e452-83f0f6bfb744@infradead.org>
From:   ChiaEn Wu <peterwu.pub@gmail.com>
Date:   Fri, 17 Jun 2022 17:06:48 +0800
Message-ID: <CABtFH5K9SiOO-JDMoJJ9=5Y2XpMBirgX0ce+8F4e_Kgsk9Udaw@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] regulator: mt6370: Add mt6370 DisplayBias and
 VibLDO support
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     jic23@kernel.org, lars@metafoo.de, matthias.bgg@gmail.com,
        lee.jones@linaro.org, Daniel Thompson <daniel.thompson@linaro.org>,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com, ChiYuan Huang <cy_huang@richtek.com>
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

Hi Randy,

Thanks for your helpful comments!
We will refine them in the next patch, thanks!

Randy Dunlap <rdunlap@infradead.org> =E6=96=BC 2022=E5=B9=B46=E6=9C=8814=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E5=87=8C=E6=99=A84:15=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
>
> On 6/13/22 04:11, ChiaEn Wu wrote:
> > diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> > index cbe0f96ca342..dcb6866dab53 100644
> > --- a/drivers/regulator/Kconfig
> > +++ b/drivers/regulator/Kconfig
> > @@ -804,6 +804,14 @@ config REGULATOR_MT6360
> >         2-channel buck with Thermal Shutdown and Overload Protection
> >         6-channel High PSRR and Low Dropout LDO.
> >
> > +config REGULATOR_MT6370
> > +     tristate "MT6370 SubPMIC Regulator"
> > +     depends on MFD_MT6370
> > +     help
> > +       Say Y here to enable MT6370 regulator support.
> > +       This driver support the control for DisplayBias voltages and on=
e
>
>                       supports
>
> > +       general purpose LDO which commonly used to drive the vibrator.
>
>                               which is commonly used to drive the vibrato=
r.
>
>
> --
> ~Randy

Best regards,
ChiaEn Wu
