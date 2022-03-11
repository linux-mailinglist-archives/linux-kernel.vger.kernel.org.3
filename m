Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AC54D5AC9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346514AbiCKFve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbiCKFvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:51:32 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9A6E98EA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:50:29 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id 195so9119786iou.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3B8QjIlmdJC8Bd0Vem9hqomGTMW6ZUxC9fqa1LEpXd8=;
        b=QZGS63PS9pfUSfyFr/oDhhJNtJFuik3KIdwKY3PpvuP3fY8aefSNurgtEJ75OAJyXL
         CbRQeVKeQor4yz60nSIWEdR5TZyN0QV5+FekbuenDvWrWpkFpxM/C4z3yTEHlb/CMZsz
         3tk7l0R0YAf4zaLJ8CRpfdHIa8eu6xV20zKYwP2lEhHwTocUGa2bGeUbL+8BP4kzFmk/
         qspHqatyaz920KEXdhgy+7n0G4bWFdblmhL49w9f0cn27W06zm6HVcD9ApjQMvrHUGEc
         nEV34M7C8hyfoRJKqjBc5ni9sld+2F3Ibx0OyfKLTKdJiIRDULBT4HlyFk2YUmbGdvLr
         7VsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3B8QjIlmdJC8Bd0Vem9hqomGTMW6ZUxC9fqa1LEpXd8=;
        b=SUlq/6VP+A0zjr03k55EJpU9m8/8fA73NcIgdXlKOTpuFb3Yrk76mpS0oqieumCxCl
         LuntwUjFI4FYBNI90UdJikrBtcYObIduhKFer9fObI2/P1KHb6OQmj+exzeawa5H2ias
         9qT7lDaS+h99Dv4f2yjNbuxbEIceY+H+VEP2IvLaio9SCVaa4nmSkIlyYybOcQU3veN+
         9MQ96lfvtwz9h8WTfP+MosDWn3EgtFHqrfq+XDmaxzNBESoXPgt1AWicFhAiKx7Z24Gi
         Kms8+Ea5yiAw/0FC8IVeyUI60yy3pOHJiyzx+jZgsBrJdkVBVEh2KNxcLPU1AeOoQfA6
         xhxQ==
X-Gm-Message-State: AOAM533GHFuKz+xUap7M2U3mchDb/0sw33l5ONCWqaZcDFQCKFIceJIl
        a0t61w0eBQSGPKa3RKdTaA19oiYXM52gPCBmTBI=
X-Google-Smtp-Source: ABdhPJzAbtdKwaCEOZhQzztbjFX7GP+aQtiKKok15pkU1whKZ1twhEO8IZfK457hIHx3+Bb+/kd5NE5f7iIGcTsyC+U=
X-Received: by 2002:a05:6602:168f:b0:648:c800:3d61 with SMTP id
 s15-20020a056602168f00b00648c8003d61mr514167iow.197.1646977829264; Thu, 10
 Mar 2022 21:50:29 -0800 (PST)
MIME-Version: 1.0
References: <20220310081548.31846-1-steve.lee.analog@gmail.com> <SJ0PR03MB67794358405FA661992A206D990B9@SJ0PR03MB6779.namprd03.prod.outlook.com>
In-Reply-To: <SJ0PR03MB67794358405FA661992A206D990B9@SJ0PR03MB6779.namprd03.prod.outlook.com>
From:   Lee Steve <steve.lee.analog@gmail.com>
Date:   Fri, 11 Mar 2022 14:50:18 +0900
Message-ID: <CA+Fz0PbNBXfC_0SYKVuHDic0ZREpHBk+oSqU5sO9Mq0AjY8_-w@mail.gmail.com>
Subject: Re: [PATCH] ASoC: max98390: Add reset gpio control
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "rf@opensource.wolfsonmicro.com" <rf@opensource.wolfsonmicro.com>,
        "shumingf@realtek.com" <shumingf@realtek.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "dmurphy@ti.com" <dmurphy@ti.com>,
        "jack.yu@realtek.com" <jack.yu@realtek.com>,
        "steves.lee@maximintegrated.com" <steves.lee@maximintegrated.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
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

On Thu, Mar 10, 2022 at 5:48 PM Sa, Nuno <Nuno.Sa@analog.com> wrote:
>
> Hi Steve,
>
> > From: Steve Lee <steve.lee.analog@gmail.com>
> > Sent: Thursday, March 10, 2022 9:16 AM
> > To: lgirdwood@gmail.com; broonie@kernel.org; perex@perex.cz;
> > tiwai@suse.com; ckeepax@opensource.cirrus.com; geert@linux-
> > m68k.org; rf@opensource.wolfsonmicro.com; shumingf@realtek.com;
> > srinivas.kandagatla@linaro.org; krzk@kernel.org; dmurphy@ti.com;
> > jack.yu@realtek.com; Sa, Nuno <Nuno.Sa@analog.com>;
> > steves.lee@maximintegrated.com; linux-kernel@vger.kernel.org;
> > alsa-devel@alsa-project.org
> > Cc: Steve Lee <steve.lee.analog@gmail.com>
> > Subject: [PATCH] ASoC: max98390: Add reset gpio control
> >
> > [External]
> >
> >  Add reset gpio control to support RESET PIN connected to gpio.
> >
> > Signed-off-by: Steve Lee <steve.lee.analog@gmail.com>
> > ---
> >  sound/soc/codecs/max98390.c | 18 ++++++++++++++++++
> >  sound/soc/codecs/max98390.h |  1 +
> >  2 files changed, 19 insertions(+)
> >
> > diff --git a/sound/soc/codecs/max98390.c
> > b/sound/soc/codecs/max98390.c
> > index b392567c2b3e..574d8d5f1119 100644
> > --- a/sound/soc/codecs/max98390.c
> > +++ b/sound/soc/codecs/max98390.c
> > @@ -1073,6 +1073,24 @@ static int max98390_i2c_probe(struct
> > i2c_client *i2c,
> >               return ret;
> >       }
> >
> > +     max98390->reset_gpio =3D of_get_named_gpio(i2c-
> > >dev.of_node,
> > +                                             "maxim,reset-gpios", 0);
>
> Why not using devm_gpiod_get_optional()? We could request the pin
> already in the asserted state and make the code slightly better...
>
> /* I guess there's no need to save it in our struct as we only use it her=
e? */
> struct gpio_desc *reset_gpio;
>
> reset_gpio =3D devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_HIGH=
);
> if (reset_gpio) {
>       usleep_range(1000, 2000);
>      /* bring out of reset */
>       gpio_direction_output(max98390->reset_gpio, 0);
>       usleep_range(1000, 2000);
> }
>
> Also, do we have this on the bindings doc? If not, it should be done on a=
 second
> patch on this series...
>
> - Nuno S=C3=A1
>

Thanks for comment on this patch. I will check and update as commented.
