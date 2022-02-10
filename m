Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5CB4B11C3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 16:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243650AbiBJPeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 10:34:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243638AbiBJPeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 10:34:01 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34C11DF;
        Thu, 10 Feb 2022 07:34:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D844BCE249E;
        Thu, 10 Feb 2022 15:33:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91140C004E1;
        Thu, 10 Feb 2022 15:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644507238;
        bh=BKeitxpfCGIJQJTATObfn7bUY4xpEWQny+fdU8bKBgg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i5uVIOpEclbZZ3IneV185GXY860waI1Ss4TIko7UGsQyI9pzMlQfunc2xKUJTLDBY
         PLIlyt50KiwOImwL0Z7UI+v7iD7TASoWEQeUBN3oXC9mbgVmqviNPj6oLRj//z4loK
         FR47sNNdeeeBp9iVykUDSxtjqlG5+nohsB7jjYogxBX4RGO0Q4vNNBFMcrXYS8ggZs
         I17f7KiYUjx3AEzf2x0Ve3N++TrUT7H0wDS068kDh7bnuGUO/yEfE6FsIs0tC5Uu8h
         NSt1Ig03zrBTZX27rmmfokPEA/qZ83c29MWAoWJ3kXQE5nT+DEUW2UCPXU3Kd2y2XB
         SYi6SnOsfWfug==
Date:   Thu, 10 Feb 2022 15:40:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "tomas.melin@vaisala.com" <tomas.melin@vaisala.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH V1 2/6] iio: accel: sca3300: Add interface for operation
 modes.
Message-ID: <20220210154035.62ef7bf6@jic23-huawei>
In-Reply-To: <AM9PR06MB78448AE3641602CA8E52603AD72F9@AM9PR06MB7844.eurprd06.prod.outlook.com>
References: <20220124093912.2429190-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20220124093912.2429190-3-Qing-wu.Li@leica-geosystems.com.cn>
        <20220130114014.38923fb4@jic23-huawei>
        <AM9PR06MB78448AE3641602CA8E52603AD72F9@AM9PR06MB7844.eurprd06.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2022 10:08:53 +0000
LI Qingwu <qing-wu.li@leica-geosystems.com.cn> wrote:

> Thanks a lot all of your inputs, I'm just back from long holiday and star=
t to rework on the patches.
>=20
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Sunday, January 30, 2022 7:40 PM
> > To: LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
> > Cc: lars@metafoo.de; robh+dt@kernel.org; tomas.melin@vaisala.com;
> > andy.shevchenko@gmail.com; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH V1 2/6] iio: accel: sca3300: Add interface for oper=
ation
> > modes.
> >=20
> > This email is not from Hexagon=E2=80=99s Office 365 instance. Please be=
 careful while
> > clicking links, opening attachments, or replying to this email.
> >=20
> >=20
> > On Mon, 24 Jan 2022 09:39:08 +0000
> > LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:
> >  =20
> > > The acceleration scale and the frequency were set via operation modes,
> > > the scal and frequency are both non-uniqueness, this leads to logic
> > > confusion for setting scale.and.frequency.
> > > it getting worse if add more different sensor types into the driver.
> > >
> > > The commit add an interface for set and get the operation modes.
> > > the following interfaces added:
> > > in_accel_op_mode_available
> > > in_op_mode
> > >
> > > SCA3300 operation modes table:
> > > | Mode | Full-scale | low pass filter frequency |
> > > | ---- | ---------- | ------------------------- |
> > > | 1    | =C2=B1 3 g      | 70 Hz                     |
> > > | 2    | =C2=B1 6 g      | 70 Hz                     |
> > > | 3    | =C2=B1 1.5 g    | 70 Hz                     |
> > > | 4    | =C2=B1 1.5 g    | 10 Hz                     |
> > >
> > > Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> =20
> >=20
> > While it may seem convenient to expose this to userspace, the reality i=
s that
> > generic userspace has no way to know how to use it.
> >=20
> > That makes supplying this control a bad idea however convenient it may =
seem.
> > It's not unusual to have these sorts of constraints on devices and so t=
he ABI
> > always assumes any setting may modify any other and / or change what is
> > available for a given setting.
> >=20
> > If you need a particular combination for your own userspace, then make =
the
> > userspace aware of the constraints rather than exposing it as a 'mode' =
which
> > the userspace will need to know about anyway.
> >=20
> > Jonathan =20
>=20

+cc linux-iio@vger.kernel.org

> Thanks a lot Jonathan, I couldn't agree with you more, the mode is not go=
od for userspace,
> I would like to ask you how to handle this.
> Since the change for 'mode' was a prepare for support SCL3300,
> For SCL3300, mode 3 and mode 4 are totally same for both scale and freque=
ncy.
> The only different is mode 4 is low noise mode, but no difference from so=
ftware point of view.
> Then it's impossible to set to between mode 3/4, let's say normal noise a=
nd low noise mode, with index of frequency and scale.
> Set between mode 3 and 4 is necessary, I have no idea how to handle it.

Why would a user ever select the 'high noise' option?
My guess is power saving?  Probably not enough to be relevant
in a system running Linux.

I would suggest just not supporting that option.
It is not uncommon for some modes to make limited sense and
to just be there as an artefact of the underlying hardware
architecture.  Doesn't mean we have to support them :)

Jonathan





>=20
> | Mode             | Full-scale   | frequency |
> | -------------------      | ----------------- | ------------- |
> | 1                 | =C2=B1 1.2 g     | 40 Hz    |
> | 2                 | =C2=B1 2.4 g     | 70 Hz    |
> | 3                 | =C2=B1 0.6 g     | 10 Hz    |
> | 4 (Low noise mode)  | =C2=B1 0.6 g     | 10 Hz    |  =20
>               =20
> The link of the SCL3300 datasheet:
> https://www.murata.com/-/media/webrenewal/products/sensor/pdf/datasheet/d=
atasheet_scl3300-d01.ashx?la=3Den&cvid=3D20210316063715000000
>=20
> >=20
> >  =20
> > > ---
> > >  drivers/iio/accel/sca3300.c | 55
> > > +++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 55 insertions(+)
> > >
> > > diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
> > > index 083ae2a47ad9..e26b3175b3c6 100644
> > > --- a/drivers/iio/accel/sca3300.c
> > > +++ b/drivers/iio/accel/sca3300.c
> > > @@ -42,6 +42,38 @@
> > >  /* Device return status and mask */
> > >  #define SCA3300_VALUE_RS_ERROR       0x3
> > >  #define SCA3300_MASK_RS_STATUS       GENMASK(1, 0)
> > > +enum sca3300_op_mode_indexes {
> > > +     OP_MOD_1 =3D 0,
> > > +     OP_MOD_2,
> > > +     OP_MOD_3,
> > > +     OP_MOD_4,
> > > +     OP_MOD_CNT
> > > +};
> > > +
> > > +static const char * const sca3300_op_modes[] =3D {
> > > +     [OP_MOD_1] =3D "1",
> > > +     [OP_MOD_2] =3D "2",
> > > +     [OP_MOD_3] =3D "3",
> > > +     [OP_MOD_4] =3D "4"
> > > +};
> > > +
> > > +static int sca3300_get_op_mode(struct iio_dev *indio_dev,
> > > +             const struct iio_chan_spec *chan); static int
> > > +sca3300_set_op_mode(struct iio_dev *indio_dev,
> > > +             const struct iio_chan_spec *chan, unsigned int mode);
> > > +
> > > +static const struct iio_enum sca3300_op_mode_enum =3D {
> > > +     .items =3D sca3300_op_modes,
> > > +     .num_items =3D ARRAY_SIZE(sca3300_op_modes),
> > > +     .get =3D sca3300_get_op_mode,
> > > +     .set =3D sca3300_set_op_mode,
> > > +};
> > > +
> > > +static const struct iio_chan_spec_ext_info sca3300_ext_info[] =3D {
> > > +     IIO_ENUM("op_mode", IIO_SHARED_BY_DIR, =20
> > &sca3300_op_mode_enum), =20
> > > +     IIO_ENUM_AVAILABLE("op_mode", &sca3300_op_mode_enum),
> > > +     { }
> > > +};
> > >
> > >  enum sca3300_scan_indexes {
> > >       SCA3300_ACC_X =3D 0,
> > > @@ -70,6 +102,7 @@ enum sca3300_scan_indexes {
> > >               .storagebits =3D 16, =20
> > \ =20
> > >               .endianness =3D IIO_CPU, =20
> > \ =20
> > >       }, =20
> > \ =20
> > > +     .ext_info =3D sca3300_ext_info, =20
> > \ =20
> > >  }
> > >
> > >  #define SCA3300_TEMP_CHANNEL(index, reg) =20
> > {                           \ =20
> > > @@ -400,6 +433,28 @@ static int sca3300_read_avail(struct iio_dev =20
> > *indio_dev, =20
> > >       }
> > >  }
> > >
> > > +static int sca3300_get_op_mode(struct iio_dev *indio_dev,
> > > +             const struct iio_chan_spec *chan) {
> > > +     int mode;
> > > +     int ret;
> > > +     struct sca3300_data *data =3D iio_priv(indio_dev);
> > > +
> > > +     ret =3D sca3300_read_reg(data, SCA3300_REG_MODE, &mode);
> > > +     if (ret)
> > > +             return ret;
> > > +     return mode;
> > > +
> > > +}
> > > +
> > > +static int sca3300_set_op_mode(struct iio_dev *indio_dev,
> > > +             const struct iio_chan_spec *chan, unsigned int mode) {
> > > +     struct sca3300_data *data =3D iio_priv(indio_dev);
> > > +
> > > +     return sca3300_write_reg(data, SCA3300_REG_MODE, mode); }
> > > +
> > >  static const struct iio_info sca3300_info =3D {
> > >       .read_raw =3D sca3300_read_raw,
> > >       .write_raw =3D sca3300_write_raw, =20
>=20

