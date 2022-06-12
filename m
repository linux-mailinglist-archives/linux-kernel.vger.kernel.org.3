Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0B1547964
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 11:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbiFLJAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 05:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbiFLI77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 04:59:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF6050003;
        Sun, 12 Jun 2022 01:59:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D17AB80B49;
        Sun, 12 Jun 2022 08:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EDBC34115;
        Sun, 12 Jun 2022 08:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655024395;
        bh=2uqxVJ6jg6AwdHG0+C7+HQBXmirKuPi56pYKZPGKkCU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gr6stL0vss5dlzJyCOgtqr6VGyPaDsNrheFDEXSHs4p0Y/J51CfagmXK44//qr6DU
         pp3e8S/1AaBzYzeChlGrrUH1/YCxJ1kTIJG2Bau2VTAZRLfgISEEvcHjq62AUQLuif
         aDahCJU85DqqJ8YCKrZbLG6fzfXDLslBJz7rUv0JLavzErW48xbQF/mE/cZpZt6Y3L
         faECM0YTXIRSYqhUfaLwB+Glon1bsXQ2pTU7iJJK1wvTYFRZvb/PW4PVc0YEn4zaQm
         jrrnue0D2aYHK0Hk8gHvo8LQrTQEXoZ5Pivq5uioAo7f6QGUrJFMn+lyI8Mpxl084u
         DK8h2a1MntWFg==
Date:   Sun, 12 Jun 2022 10:08:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Cixi Geng <cixi.geng1@unisoc.com>, linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH v1 1/1] iio: adc: sc27xx_adc: Re-use generic struct
 u32_fract
Message-ID: <20220612100854.22e2c441@jic23-huawei>
In-Reply-To: <CAF12kFueRHQJy2t6xitqfYwsY0kPagDSH289QKp0y0W0HzsshA@mail.gmail.com>
References: <20220530180910.2533-1-andriy.shevchenko@linux.intel.com>
        <20220603180347.2b0d0f08@jic23-huawei>
        <CAF12kFueRHQJy2t6xitqfYwsY0kPagDSH289QKp0y0W0HzsshA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2022 11:12:15 +0800
Cixi Geng <gengcixi@gmail.com> wrote:

> Jonathan Cameron <jic23@kernel.org> =E4=BA=8E2022=E5=B9=B46=E6=9C=884=E6=
=97=A5=E5=91=A8=E5=85=AD 01:44=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Mon, 30 May 2022 21:09:10 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > =20
> > > Instead of custom data type re-use generic struct u32_fract. =20
> >
> > There isn't a custom data type  - I'll reword this whilst applying
> > if there is no reason for a v2.
> > =20
> > > No changes intended. =20
> >
> > functional changes
> > =20
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com> =20
> > Given they have been active recently I'd ideally like Cixi Geng
> > to take a quick glance at this before I apply it. =20
> Acked-by: Cixi Geng <cixi.geng1@unisoc.com>

Applied to the togreg branch of iio.git and will be pushed out initially
as testing for 0-day to take a look.

Thanks,

Jonathan

> >
> > Thanks,
> >
> > Jonathan
> > =20
> > > ---
> > >  drivers/iio/adc/sc27xx_adc.c | 15 +++++++--------
> > >  1 file changed, 7 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_ad=
c.c
> > > index e9ff2d6a8a57..f8421cbba8fa 100644
> > > --- a/drivers/iio/adc/sc27xx_adc.c
> > > +++ b/drivers/iio/adc/sc27xx_adc.c
> > > @@ -579,15 +579,14 @@ static int sc27xx_adc_read(struct sc27xx_adc_da=
ta *data, int channel,
> > >       return ret;
> > >  }
> > >
> > > -static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data,
> > > -                               int channel, int scale,
> > > -                               u32 *div_numerator, u32 *div_denomina=
tor)
> > > +static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data, int =
channel, int scale,
> > > +                               struct u32_fract *fract)
> > >  {
> > >       u32 ratio;
> > >
> > >       ratio =3D data->var_data->get_ratio(channel, scale);
> > > -     *div_numerator =3D ratio >> SC27XX_RATIO_NUMERATOR_OFFSET;
> > > -     *div_denominator =3D ratio & SC27XX_RATIO_DENOMINATOR_MASK;
> > > +     fract->numerator =3D ratio >> SC27XX_RATIO_NUMERATOR_OFFSET;
> > > +     fract->denominator =3D ratio & SC27XX_RATIO_DENOMINATOR_MASK;
> > >  }
> > >
> > >  static int adc_to_volt(struct sc27xx_adc_linear_graph *graph,
> > > @@ -615,7 +614,7 @@ static int sc27xx_adc_to_volt(struct sc27xx_adc_l=
inear_graph *graph,
> > >  static int sc27xx_adc_convert_volt(struct sc27xx_adc_data *data, int=
 channel,
> > >                                  int scale, int raw_adc)
> > >  {
> > > -     u32 numerator, denominator;
> > > +     struct u32_fract fract;
> > >       u32 volt;
> > >
> > >       /*
> > > @@ -637,9 +636,9 @@ static int sc27xx_adc_convert_volt(struct sc27xx_=
adc_data *data, int channel,
> > >               break;
> > >       }
> > >
> > > -     sc27xx_adc_volt_ratio(data, channel, scale, &numerator, &denomi=
nator);
> > > +     sc27xx_adc_volt_ratio(data, channel, scale, &fract);
> > >
> > > -     return DIV_ROUND_CLOSEST(volt * denominator, numerator);
> > > +     return DIV_ROUND_CLOSEST(volt * fract.denominator, fract.numera=
tor);
> > >  }
> > >
> > >  static int sc27xx_adc_read_processed(struct sc27xx_adc_data *data, =
=20
> > =20

