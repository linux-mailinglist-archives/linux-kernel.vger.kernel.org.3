Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C8A4E9709
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242654AbiC1MxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242638AbiC1Mwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:52:51 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12B34D634
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:51:10 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id i1so9921218ila.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NmQMOl74rWGRWzafuyJ5jjCyGGjWrcet8PudU8eNoTM=;
        b=fmnUk8fzFuPNcQLP4BGXA1S9aa97ooEg6VvUkroT0u2nlfdICTx4oy6TaPbWXhvP2p
         ycG9uUulYtBRRjLm9QXjKOnv6AXp/13Jj48+DV1eeBRQcSNHZBR8E/63/XFTjZ4F2U1Z
         /yWrDsUP0Axr8AP3acYeBwfDZz53FpCWg20obz6FBTMIy6DyWhoK3XEuP3vzdYNdNFi8
         +0A4Z/J7Mlr9Z394QGOI1u0UNFDGE7BJASd2oJy7o5ajLXTTwx3PsG+wubUAG6Tzsn1M
         e99RFMzotoXtGAcBMws38D0LjwZFIdFfjgVk2ZTTXM/RkrDzZs84Ula9HelT/mD+AsNs
         pjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NmQMOl74rWGRWzafuyJ5jjCyGGjWrcet8PudU8eNoTM=;
        b=joBcVIR8/zO1LvbNI9MRhfkfqmZrdLrGGj7vRztaQlZWpJQPEI36TS0ux9QiaBPUAG
         QqfpID1B3YxXNf0mOyMp+8dxF8IsCCB+OaWNArVuMFcuv9njh/fzGdqmado/VzHXoAaf
         erCfB0ru+K4mdpQYv6cOb2jnbngczY0fd0tBedF7oYIFyvs7aRVinLKNWHe/md6d4EvH
         Mh3fTH2bKRiLQeg2HzeWnHCERPyoLX2x1wFiW59ybOl+HDdPMXlnGL70a0OVdjaiVscK
         zkEdo0+7+QNoADFvcKCRHg0rEAlBecKv1JpD6rHQCU6JPeACsEt9qPE22pp/KERI+voz
         UBlw==
X-Gm-Message-State: AOAM5318oaSDR106mHmqg7cmMDxnzEa8UhXgnuwuM3WTw2A3o1tcB4QD
        py7rs76qrtr93smYgw+aM8Tg/EDx1iw3EiuzhwM=
X-Google-Smtp-Source: ABdhPJxh9OmbBwag5bvEGizKUKZLQbnirkyw/QJTsPJZeG6mVqa3cTPMDPAy/NRf7yrVNUIQBEFYGZcMWITxadtTRCQ=
X-Received: by 2002:a92:cdad:0:b0:2c6:7b76:a086 with SMTP id
 g13-20020a92cdad000000b002c67b76a086mr6014966ild.5.1648471870337; Mon, 28 Mar
 2022 05:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220328021139.8700-1-steve.lee.analog@gmail.com> <PH0PR03MB678617C7A854827D0EC99010991D9@PH0PR03MB6786.namprd03.prod.outlook.com>
In-Reply-To: <PH0PR03MB678617C7A854827D0EC99010991D9@PH0PR03MB6786.namprd03.prod.outlook.com>
From:   Lee Steve <steve.lee.analog@gmail.com>
Date:   Mon, 28 Mar 2022 21:50:59 +0900
Message-ID: <CA+Fz0PZQUcjLL2fmOLcyYxhqfyoY0jVKtz1GgRTur9XJDs_wag@mail.gmail.com>
Subject: Re: [V3 1/2] ASoC: max98390: Add reset gpio control
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "ryans.lee@maximintegrated.com" <ryans.lee@maximintegrated.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "krzk@kernel.org" <krzk@kernel.org>
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

On Mon, Mar 28, 2022 at 4:42 PM Sa, Nuno <Nuno.Sa@analog.com> wrote:
>
> > From: Steve Lee <steve.lee.analog@gmail.com>
> > Sent: Monday, March 28, 2022 4:12 AM
> > To: lgirdwood@gmail.com; broonie@kernel.org; perex@perex.cz;
> > tiwai@suse.com; ryans.lee@maximintegrated.com; linux-
> > kernel@vger.kernel.org; alsa-devel@alsa-project.org
> > Cc: krzk@kernel.org; Sa, Nuno <Nuno.Sa@analog.com>; Steve Lee
> > <steve.lee.analog@gmail.com>
> > Subject: [V3 1/2] ASoC: max98390: Add reset gpio control
> >
> > [External]
> >
> >  Add reset gpio control to support RESET PIN connected to gpio.
> >
> > Signed-off-by: Steve Lee <steve.lee.analog@gmail.com>
> > ---
> >  sound/soc/codecs/max98390.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/sound/soc/codecs/max98390.c
> > b/sound/soc/codecs/max98390.c
> > index 40fd6f363f35..05df9b85d9b0 100644
> > --- a/sound/soc/codecs/max98390.c
> > +++ b/sound/soc/codecs/max98390.c
> > @@ -1022,6 +1022,7 @@ static int max98390_i2c_probe(struct
> > i2c_client *i2c,
> >
> >       struct max98390_priv *max98390 =3D NULL;
> >       struct i2c_adapter *adapter =3D i2c->adapter;
> > +     struct gpio_desc *reset_gpio;
> >
> >       ret =3D i2c_check_functionality(adapter,
> >               I2C_FUNC_SMBUS_BYTE
> > @@ -1073,6 +1074,17 @@ static int max98390_i2c_probe(struct
> > i2c_client *i2c,
> >               return ret;
> >       }
> >
> > +     reset_gpio =3D devm_gpiod_get_optional(&i2c->dev,
> > +                                          "reset", GPIOD_OUT_LOW);
> > +
> > +     /* Power on device */
> > +     if (reset_gpio) {
> > +             usleep_range(1000, 2000);
> > +             /* bring out of reset */
> > +             gpiod_set_value_cansleep(reset_gpio, 1);
>
> Note this will set the gpio in the asserted state. Being it active low, t=
his will
> do the opposite thing that you are trying to accomplish...
>
> - Nuno S=C3=A1

I agree with your comment. I will update next version patch if there
is other concern.
