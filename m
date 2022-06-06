Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A0653DFEE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 05:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352271AbiFFDM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 23:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349220AbiFFDMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 23:12:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3CF4F46D;
        Sun,  5 Jun 2022 20:12:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m26so6640735wrb.4;
        Sun, 05 Jun 2022 20:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xQwH03eUdhwmKSD3Wqpf/OXltVtDgOmzI8xFQdlkuAU=;
        b=o3BPeuKWpskf/nmERSRQZ7mKyW5ObyOUwafZVED4ziKHTp27U2firE+Lg3HG/d0zCy
         r1m+1Ka74YCvs/5iQS83SYRUAJeAHpJ6bLu6gbpJrkAgmn2ohmO/oIOhH1FTh15pxvav
         gruahLTIMRuBYIV9t/04c51vxOxOMIp7KXUJ2tpsIvc1gL8yQyWlGDMJ5OMHnGdTapXX
         kwjNDeeuwr8oTsjgiOgtWIk5Ki91cmRaN0nwFXMbcJNKmxXueoijYJndXK2mDxYr/iTR
         IHCgRDmrqjIoVVNdb5iYKDtkxlVLIFIKuvyR0UGXt1/utBzMJByVGN3Bdlvp/weR028I
         2MnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xQwH03eUdhwmKSD3Wqpf/OXltVtDgOmzI8xFQdlkuAU=;
        b=4tx7Nuu5ClkcDMsTtpOY6ZHC4IpioTPdFooOqneYBxitvX3gsvwvtydi11i5TuhLOI
         2ujy+aZBDRaMXkv1tsqrORc3lTSO39EeLLUpdr8WIN6kgdDZJFbL9LT+60rCTVIVta6l
         WcOoeb5VMNkUtxn0Az1P0rsY18rucsrbLWS+mDDfkHqzWMtuZtMppYkZDKHLPHzQ0c2V
         ofVdQtMlkIXUOLg8XsDTjGPYUfPWeMEYngeK/5cG63o0wSlI47Zt7UQNZKKIigk2IOyN
         Xh2RDrFmUaEXUozxbG/8JHsLrMtDhdqjJ2gRJBvvI6ajA9m8F87iZRmajDW+zzvTPq3X
         nq7Q==
X-Gm-Message-State: AOAM5313crh4r02Ex1xrfJXD3wU689zhW05+AZFdcU9kFACJIep2+SS1
        eZs8JNvxfc3MOhHzy6ZktC5hBxlaFrdPO4BhZKI=
X-Google-Smtp-Source: ABdhPJxBUbYw3U2MPjpvu/zULIajZwXsBNlyGnAUBi30WP//50Wrff8qMrY9wz1OYUHmTjLMMwBueHpZKS6TTbPiW9M=
X-Received: by 2002:a5d:4302:0:b0:20e:66db:b8f5 with SMTP id
 h2-20020a5d4302000000b0020e66dbb8f5mr18692708wrq.320.1654485171681; Sun, 05
 Jun 2022 20:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220530180910.2533-1-andriy.shevchenko@linux.intel.com> <20220603180347.2b0d0f08@jic23-huawei>
In-Reply-To: <20220603180347.2b0d0f08@jic23-huawei>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Mon, 6 Jun 2022 11:12:15 +0800
Message-ID: <CAF12kFueRHQJy2t6xitqfYwsY0kPagDSH289QKp0y0W0HzsshA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] iio: adc: sc27xx_adc: Re-use generic struct u32_fract
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Cixi Geng <cixi.geng1@unisoc.com>, linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
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

Jonathan Cameron <jic23@kernel.org> =E4=BA=8E2022=E5=B9=B46=E6=9C=884=E6=97=
=A5=E5=91=A8=E5=85=AD 01:44=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 30 May 2022 21:09:10 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > Instead of custom data type re-use generic struct u32_fract.
>
> There isn't a custom data type  - I'll reword this whilst applying
> if there is no reason for a v2.
>
> > No changes intended.
>
> functional changes
>
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Given they have been active recently I'd ideally like Cixi Geng
> to take a quick glance at this before I apply it.
Acked-by: Cixi Geng <cixi.geng1@unisoc.com>
>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/adc/sc27xx_adc.c | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.=
c
> > index e9ff2d6a8a57..f8421cbba8fa 100644
> > --- a/drivers/iio/adc/sc27xx_adc.c
> > +++ b/drivers/iio/adc/sc27xx_adc.c
> > @@ -579,15 +579,14 @@ static int sc27xx_adc_read(struct sc27xx_adc_data=
 *data, int channel,
> >       return ret;
> >  }
> >
> > -static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data,
> > -                               int channel, int scale,
> > -                               u32 *div_numerator, u32 *div_denominato=
r)
> > +static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data, int ch=
annel, int scale,
> > +                               struct u32_fract *fract)
> >  {
> >       u32 ratio;
> >
> >       ratio =3D data->var_data->get_ratio(channel, scale);
> > -     *div_numerator =3D ratio >> SC27XX_RATIO_NUMERATOR_OFFSET;
> > -     *div_denominator =3D ratio & SC27XX_RATIO_DENOMINATOR_MASK;
> > +     fract->numerator =3D ratio >> SC27XX_RATIO_NUMERATOR_OFFSET;
> > +     fract->denominator =3D ratio & SC27XX_RATIO_DENOMINATOR_MASK;
> >  }
> >
> >  static int adc_to_volt(struct sc27xx_adc_linear_graph *graph,
> > @@ -615,7 +614,7 @@ static int sc27xx_adc_to_volt(struct sc27xx_adc_lin=
ear_graph *graph,
> >  static int sc27xx_adc_convert_volt(struct sc27xx_adc_data *data, int c=
hannel,
> >                                  int scale, int raw_adc)
> >  {
> > -     u32 numerator, denominator;
> > +     struct u32_fract fract;
> >       u32 volt;
> >
> >       /*
> > @@ -637,9 +636,9 @@ static int sc27xx_adc_convert_volt(struct sc27xx_ad=
c_data *data, int channel,
> >               break;
> >       }
> >
> > -     sc27xx_adc_volt_ratio(data, channel, scale, &numerator, &denomina=
tor);
> > +     sc27xx_adc_volt_ratio(data, channel, scale, &fract);
> >
> > -     return DIV_ROUND_CLOSEST(volt * denominator, numerator);
> > +     return DIV_ROUND_CLOSEST(volt * fract.denominator, fract.numerato=
r);
> >  }
> >
> >  static int sc27xx_adc_read_processed(struct sc27xx_adc_data *data,
>
