Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7D04A3605
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 12:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354687AbiA3LkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 06:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354678AbiA3LkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 06:40:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B45CC061714;
        Sun, 30 Jan 2022 03:40:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 259F2610D5;
        Sun, 30 Jan 2022 11:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4378BC340E4;
        Sun, 30 Jan 2022 11:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643542814;
        bh=OD20yGGe1ZXowJDHG6nb9wBY2ov04C9DoiWPunmjBMs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GnUZJDzo9hxCrQiRFd2/vECcNEIKKT2PWdMAjlzJ0YxmZuoND0OJIyPycLyPdWOzu
         UHKHYZLKLKmvnEhW4aChjZVMQN9BEYayAH/LnRQ3Ljte1xdtrmpTMa1RZR9ZFicFZJ
         B+ScNJ+fUsBMdFZM3timw31A5vKlSoJRGKwfMR3VzIOWQOu/neMnC80CEdOpfK3Vtk
         D21dyMyPQ1aI0dhfmLzR3jZo3Go381lk92AzWtE9QxKO1pftPBdUU8B5Jq0pp6HRnE
         IjNRvqgxPEgO9fYpSybRt/ml6tD87psEydPH99jlovtGVCRX6M1wl6jWxYxh3IoTUE
         yiZ7n5ZUwsNYw==
Date:   Sun, 30 Jan 2022 11:46:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Tomas Melin <tomas.melin@vaisala.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH V1 5/6] iio: accel: sca3300: Add inclination channels.
Message-ID: <20220130114638.20097dd8@jic23-huawei>
In-Reply-To: <CAHp75VeNFj3Hz1+quqpuWGuVYhPFngC20Gk=AfG+ZVEsrU9Qeg@mail.gmail.com>
References: <20220124093912.2429190-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20220124093912.2429190-6-Qing-wu.Li@leica-geosystems.com.cn>
        <CAHp75VeNFj3Hz1+quqpuWGuVYhPFngC20Gk=AfG+ZVEsrU9Qeg@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022 15:19:09 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Jan 24, 2022 at 11:39 AM LI Qingwu
> <Qing-wu.Li@leica-geosystems.com.cn> wrote:
> >
> > Different with SCA3300, SCL3300 can output inclination angles.
> > Angles are formed from acceleration with following equations:
> > ANG_X =3D atan2(accx / =E2=88=9A(accy^2 + accz^2)),
> > ANG_Y =3D atan2(accy / =E2=88=9A(accx^2 + accz^2)),
> > ANG_Z =3D atan2(accz / =E2=88=9A(accx^2 + accy^2)),
> >
> > The commit add output of the raw value,scale
> > and scale_available of angles.
> > add interface for enable/disable of the angle output.
> >
> > new interfaces: =20
>=20
> New
>=20
> > in_incli_en

Why?  There are only a few reasons to have an enable for a
channel and they don't include something that we might only
sometimes read (tend to be temporal channels such as step
counters where we want to be able to pause their counting,
or output channels).

> > in_incli_scale
> > in_incli_scale_available
> > in_incli_x_raw
> > in_incli_y_raw
> > in_incli_z_raw =20
>=20
> Indent them by 2 spaces.
>=20
> Wondering if these need to be described in ABI documentation.
It's standard ABI, though we don't give much description of what
exactly these ease. It might be possible to add more information
to the generic docs, but that would require looking very carefully
at the current supporting devices.

"Inclination raw reading about axis x, y or z (may be
Arbitrarily assigned). Data converted by application of offset
and scale to degrees."

>=20
> ...
>=20
> >         SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Y, 0x2, Y),
> >         SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Z, 0x3, Z),
> >         SCA3300_TEMP_CHANNEL(SCA3300_TEMP, 0x05),
> > -       IIO_CHAN_SOFT_TIMESTAMP(4) =20
>=20
> > +       IIO_CHAN_SOFT_TIMESTAMP(SCA3300_TIMESTAMP) =20
>=20
> + Comma (while at it)?
>=20
> ...
>=20
> > -       IIO_CHAN_SOFT_TIMESTAMP(4),
> > +       SCA3300_INCLI_CHANNEL(SCA3300_INCLI_X, 0x09, X),
> > +       SCA3300_INCLI_CHANNEL(SCA3300_INCLI_Y, 0x0A, Y),
> > +       SCA3300_INCLI_CHANNEL(SCA3300_INCLI_Z, 0x0B, Z),
> > +       IIO_CHAN_SOFT_TIMESTAMP(SCA3300_TIMESTAMP) =20
>=20
> Ditto.
>=20
> > +static const int sca3300_incli_scale[CHIP_CNT][OP_MOD_CNT][2] =3D {
> > +       [CHIP_SCA3300] =3D {{0, 0}, {0, 0}, {0, 0}, {0, 0}}, =20
>=20
> > +       [CHIP_SCL3300] =3D {{0, 5495}, {0, 5495}, {0, 5495}, {0, 5495}}=
 =20
>=20
> + Comma.
>=20
> > +}; =20
>=20
> ...
>=20
> >         struct {
> > -               s16 channels[4];
> > +               s16 channels[SCA3300_TIMESTAMP-1]; =20
>=20
> Missed spaces around the arithmetic operator.
>=20
> >                 s64 ts __aligned(sizeof(s64));
> >         } scan;
> >         const struct sca3300_chip_info *chip_info;
> >         u8 txbuf[4] ____cacheline_aligned;
> >         u8 rxbuf[4]; =20
>=20
> > - =20
>=20
> Stray change.
>=20
> >  }; =20
>=20
> ...
>=20
> > +               /*Inclination scale info tied to accel scale.*/
> > +               /*not allowed to set separately.      */ =20
>=20
> Please, follow the proper style for multi-line comments, including
> necessary spaces, periods, starting and ending lines.
>=20
> ...
>=20
> > +       case IIO_CHAN_INFO_ENABLE:
> > +               if (data->chip_info->chip_type =3D=3D CHIP_SCL3300) { =
=20
>=20
> > +                       if (chan->type =3D=3D IIO_INCLI) { =20
>=20
> See below.
>=20
> > +                               if (val !=3D 0) =20
>=20
>    if (val)
>=20
> > +                                       reg_val =3D 0x1F;
> > +                               else
> > +                                       reg_val =3D 0x00;
> > +                               return sca3300_write_reg(data, SCA3300_=
REG_ANG_CTRL, reg_val);
> > +                       }
> > +               } =20
>=20
> ...
>=20
> > -               if (chan->type =3D=3D IIO_ACCEL) {
> > +
> > +               if (chan->type =3D=3D IIO_INCLI) { =20
>=20
> > +               } else if (chan->type =3D=3D IIO_ACCEL) { =20
>=20
> I would recommend using switch-case for channel type as well.
>=20
> ...
>=20
> > +       case IIO_CHAN_INFO_ENABLE:
> > +               if (chan->type =3D=3D IIO_INCLI) { =20
>=20
> > +                       ret =3D sca3300_read_reg(data, SCA3300_REG_ANG_=
CTRL, &reg_val); =20
>=20
> How is ret supposed to be used?
>=20
> > +                       *val =3D reg_val;
> > +                       return IIO_VAL_INT;
> > +               }
> > +               return -EINVAL; =20
>=20

