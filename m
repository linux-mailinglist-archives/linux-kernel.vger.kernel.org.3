Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2255A4980ED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 14:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243088AbiAXNUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 08:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240337AbiAXNUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:20:50 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C86C06173B;
        Mon, 24 Jan 2022 05:20:50 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id m4so21360888ejb.9;
        Mon, 24 Jan 2022 05:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CIZGS2SAMR/gpbVGvhy9had6qJchmjOEY265YVA93o4=;
        b=qE+qaP9sGlHPXM4zqosVFhnWWd23cnDGogF/zAbT8jE9qje/EesNkgIvVAOB53NGwB
         mBp1jDF46E7uiC1cdkzKq+XEZMvsoow/3YpmPhtmUCIkNQaCbu5O/SaZx5/IZnfwcZX4
         l3wnqlcUoQ/Wo+SsiVyLzY5MLYaxpHb8a5lSrbtQuhYF123R6JOPhUE2SkJxz+VN105s
         iM5Fib3rpRqxi+0nxZuQUm2kzufR2uBmMOXPvO3H1VwV5sgo2sQSHqHgo5AuhOTDTvGO
         JCRHpUu7EGXgjKgyFPVKwq27o97UUmGgwOgz0V0Vr+FxnoQ3xD/OjhqQAfpxFx3DU37j
         kUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CIZGS2SAMR/gpbVGvhy9had6qJchmjOEY265YVA93o4=;
        b=kw1LUkx29aGIt4CC8mZV6SYarkWSJcI7WGK5bk94ICEdZ6O9A8lpnSYrVibvqLRkIF
         u6U4vjvAlYOJneG+AZjaqPltIKgZtseNwO81kGHgQJ3Z2ITJZ8GPiSt8QrGV8QFOlMQd
         A6HrYOdlOH8ZpEJ/h+cYyFyjO5Dm7IhzSppK9QmZr1r1owFWNBvMcyYCHIEFiBDduv1g
         HRYUqCyhvSXsVFji7msy03t/+JhwZEvVrLBq0ol7nIYaiZxP+iQTGcnWP3y3YH+iekRB
         KId2h9n1p/2QrjDrUXbIH+edUCD83KwephjMXdsTW7eSeIXDbdIlSMgosPJ68qBw+UQT
         FC0A==
X-Gm-Message-State: AOAM531Td/Al/wGQOV/X3jL/NA3wD1dIjYTu/FVO0KAy6jOrefOFy+vn
        aHnvi5lxSy3uzTn2Cjg5+l4mXSDyrCqUJMcGYsM=
X-Google-Smtp-Source: ABdhPJyuOM1fzUtCGOlsYlj/L1Xow/TMI76Y0aJT/9jq059RQvhdJ0tUHl1c3iUQ/nh2Hz4ZmN5Sw988XivGP7w1gjE=
X-Received: by 2002:a17:907:948d:: with SMTP id dm13mr12399566ejc.497.1643030448827;
 Mon, 24 Jan 2022 05:20:48 -0800 (PST)
MIME-Version: 1.0
References: <20220124093912.2429190-1-Qing-wu.Li@leica-geosystems.com.cn> <20220124093912.2429190-6-Qing-wu.Li@leica-geosystems.com.cn>
In-Reply-To: <20220124093912.2429190-6-Qing-wu.Li@leica-geosystems.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 24 Jan 2022 15:19:09 +0200
Message-ID: <CAHp75VeNFj3Hz1+quqpuWGuVYhPFngC20Gk=AfG+ZVEsrU9Qeg@mail.gmail.com>
Subject: Re: [PATCH V1 5/6] iio: accel: sca3300: Add inclination channels.
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Tomas Melin <tomas.melin@vaisala.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 11:39 AM LI Qingwu
<Qing-wu.Li@leica-geosystems.com.cn> wrote:
>
> Different with SCA3300, SCL3300 can output inclination angles.
> Angles are formed from acceleration with following equations:
> ANG_X =3D atan2(accx / =E2=88=9A(accy^2 + accz^2)),
> ANG_Y =3D atan2(accy / =E2=88=9A(accx^2 + accz^2)),
> ANG_Z =3D atan2(accz / =E2=88=9A(accx^2 + accy^2)),
>
> The commit add output of the raw value,scale
> and scale_available of angles.
> add interface for enable/disable of the angle output.
>
> new interfaces:

New

> in_incli_en
> in_incli_scale
> in_incli_scale_available
> in_incli_x_raw
> in_incli_y_raw
> in_incli_z_raw

Indent them by 2 spaces.

Wondering if these need to be described in ABI documentation.

...

>         SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Y, 0x2, Y),
>         SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Z, 0x3, Z),
>         SCA3300_TEMP_CHANNEL(SCA3300_TEMP, 0x05),
> -       IIO_CHAN_SOFT_TIMESTAMP(4)

> +       IIO_CHAN_SOFT_TIMESTAMP(SCA3300_TIMESTAMP)

+ Comma (while at it)?

...

> -       IIO_CHAN_SOFT_TIMESTAMP(4),
> +       SCA3300_INCLI_CHANNEL(SCA3300_INCLI_X, 0x09, X),
> +       SCA3300_INCLI_CHANNEL(SCA3300_INCLI_Y, 0x0A, Y),
> +       SCA3300_INCLI_CHANNEL(SCA3300_INCLI_Z, 0x0B, Z),
> +       IIO_CHAN_SOFT_TIMESTAMP(SCA3300_TIMESTAMP)

Ditto.

> +static const int sca3300_incli_scale[CHIP_CNT][OP_MOD_CNT][2] =3D {
> +       [CHIP_SCA3300] =3D {{0, 0}, {0, 0}, {0, 0}, {0, 0}},

> +       [CHIP_SCL3300] =3D {{0, 5495}, {0, 5495}, {0, 5495}, {0, 5495}}

+ Comma.

> +};

...

>         struct {
> -               s16 channels[4];
> +               s16 channels[SCA3300_TIMESTAMP-1];

Missed spaces around the arithmetic operator.

>                 s64 ts __aligned(sizeof(s64));
>         } scan;
>         const struct sca3300_chip_info *chip_info;
>         u8 txbuf[4] ____cacheline_aligned;
>         u8 rxbuf[4];

> -

Stray change.

>  };

...

> +               /*Inclination scale info tied to accel scale.*/
> +               /*not allowed to set separately.      */

Please, follow the proper style for multi-line comments, including
necessary spaces, periods, starting and ending lines.

...

> +       case IIO_CHAN_INFO_ENABLE:
> +               if (data->chip_info->chip_type =3D=3D CHIP_SCL3300) {

> +                       if (chan->type =3D=3D IIO_INCLI) {

See below.

> +                               if (val !=3D 0)

   if (val)

> +                                       reg_val =3D 0x1F;
> +                               else
> +                                       reg_val =3D 0x00;
> +                               return sca3300_write_reg(data, SCA3300_RE=
G_ANG_CTRL, reg_val);
> +                       }
> +               }

...

> -               if (chan->type =3D=3D IIO_ACCEL) {
> +
> +               if (chan->type =3D=3D IIO_INCLI) {

> +               } else if (chan->type =3D=3D IIO_ACCEL) {

I would recommend using switch-case for channel type as well.

...

> +       case IIO_CHAN_INFO_ENABLE:
> +               if (chan->type =3D=3D IIO_INCLI) {

> +                       ret =3D sca3300_read_reg(data, SCA3300_REG_ANG_CT=
RL, &reg_val);

How is ret supposed to be used?

> +                       *val =3D reg_val;
> +                       return IIO_VAL_INT;
> +               }
> +               return -EINVAL;

--=20
With Best Regards,
Andy Shevchenko
