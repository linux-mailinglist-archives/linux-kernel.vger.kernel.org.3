Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F495892A2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 21:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbiHCTQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 15:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiHCTQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 15:16:33 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C729E18395;
        Wed,  3 Aug 2022 12:16:30 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id E610E5FD36;
        Wed,  3 Aug 2022 22:16:28 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1659554188;
        bh=Kpzdj+AezZZQE2JzuZqUbOUqyj1bustjTvV/De0YWqE=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=rm/CXNZkJSKZKM9Y/WGj4EaMT8OLn8GD3SZOrSe3IGXh9ikmZDqrytLDcDHA10Fs+
         UN8U1wk2ysxPK+WVGIXZQ+cVYB48LrgoL0fHV8VOMV7RdTFBUlvCOKLbf5RVTekyc7
         JYiKVH9KWIh3tK03xUmPaW74DSTxGfj47TFaJEoOk/Uj0GI9U3aCB/8i0IBEiGDuMp
         5BY4aMwtdK+UEEsBhCOuOIX0WHxwGDek3cGl+2/J2bFNrSZ3B5GcBfZjB/niM09sNl
         dP5m1oky18sEcBwxhajdMl1Acl6wISZz0snNlO1RLFkLzwQCLuF6b/w7ZuDgFu0zjV
         rn+doqUQUnBCg==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Wed,  3 Aug 2022 22:16:28 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Topic: [PATCH v4 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Index: AQHYpzqIoQnaRj7vNkq2cXUUGjAB/62dQgeAgAAYQIA=
Date:   Wed, 3 Aug 2022 19:16:13 +0000
Message-ID: <20220803191621.tzrmndkygfe7nlpx@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220803131132.19630-1-ddrokosov@sberdevices.ru>
 <20220803131132.19630-3-ddrokosov@sberdevices.ru>
 <CAHp75VcVuC6yVoB1kycCOfqMa=JfCtbe3WYSK5qndtYcJy3vpg@mail.gmail.com>
In-Reply-To: <CAHp75VcVuC6yVoB1kycCOfqMa=JfCtbe3WYSK5qndtYcJy3vpg@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7FD1F7CB0435154A9FAC73ABD0CFD427@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/03 16:08:00 #20044033
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

Thank you for quick review,

On Wed, Aug 03, 2022 at 07:49:33PM +0200, Andy Shevchenko wrote:
> On Wed, Aug 3, 2022 at 3:11 PM Dmitry Rokosov <DDRokosov@sberdevices.ru> =
wrote:
> >
> > MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
> > sensitivity consumer applications. It has dynamic user-selectable full
> > scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measuremen=
ts
> > with output data rates from 1Hz to 1000Hz.
> >
> > Spec: https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.=
pdf
> >
> > This driver supports following MSA311 features:
> >     - IIO interface
> >     - Different power modes: NORMAL and SUSPEND (using pm_runtime)
> >     - ODR (Output Data Rate) selection
> >     - Scale and samp_freq selection
> >     - IIO triggered buffer, IIO reg access
> >     - NEW_DATA interrupt + trigger
> >
> > Below features to be done:
> >     - Motion Events: ACTIVE, TAP, ORIENT, FREEFALL
> >     - Low Power mode
>=20
> Thanks for an update, my comments below.
>=20
> ...
>=20
> > +#include <linux/i2c.h>
>=20
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/iio/trigger.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/triggered_buffer.h>
>=20
> I would split this group out of generic headers...
>=20
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/pm.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/regmap.h>
> > +#include <linux/string_helpers.h>
> > +#include <linux/units.h>
> > +
>=20
> ...and move it here to clearly show that the driver belongs to the IIO
> subsystem.

Sure, no problem.

>=20
> ...
>=20
> > +/*
> > + * Possible Full Scale ranges
> > + *
> > + * Axis data is 12-bit signed value, so
> > + *
> > + * fs0 =3D (2 + 2) * 9.81 / (2<<11) =3D 0.009580
> > + * fs1 =3D (4 + 4) * 9.81 / (2<<11) =3D 0.019160
> > + * fs2 =3D (8 + 8) * 9.81 / (2<<11) =3D 0.038320
> > + * fs3 =3D (16 + 16) * 9.81 / (2<<11) =3D 0.076641
>=20
> I'm not sure if you are using programming language here or math language?
> In math we refer to powers like 2^11, the 2<<11 puzzles me.
>=20

Agree, will change in the v5.

> > + */
>=20
> ...
>=20
> > +static const struct {
> > +       int val;
> > +       int val2;
> > +} msa311_fs_table[] =3D {
> > +       {0, 9580}, {0, 19160}, {0, 38320}, {0, 76641}
> > +};
>=20
> Besides that this struct is defined not only once in the file, this is
> very well NIH struct s32_fract. Why not use the latter?
>=20
> ...
>=20

Good point, but looks like this struct is not so popular in the other
kernel drivers:

=3D=3D=3D
grep "s32_fract" -r -l . | wc -l   =20
3
=3D=3D=3D

[...]

> > +static const char * const msa311_pwr_modes[] =3D {
> > +       [MSA311_PWR_MODE_NORMAL] =3D "normal",
> > +       [MSA311_PWR_MODE_LOW] =3D "low",
> > +       [MSA311_PWR_MODE_UNKNOWN] =3D "unknown",
> > +       [MSA311_PWR_MODE_SUSPEND] =3D "suspend"
>=20
> Leave a comma here even if we know that in the nearest future it won't
> be changed.
>=20

Good catch, forgot it.

> > +};
>=20
> ...
>=20
> > +       .cache_type =3D REGCACHE_RBTREE,
>=20
> Tree hash is good for sparse data, do you really have it sparse (a lot
> of  big gaps in between)?

I suppose so. MSA311 regmap has ~6 gaps.

[...]

>=20
> > +               dev_err(dev,
> > +                       "failed to set odr %u.%uHz, not available in %s=
 mode\n",
> > +                       msa311_odr_table[odr].val,
> > +                       msa311_odr_table[odr].val2 / 1000,
>=20
> KILO ?

MILLIHZ_PER_HZ :)

>=20
> > +                       msa311_pwr_modes[pwr_mode]);
>=20
> ...
>=20
> > +       static const int unintr_thresh_ms =3D 20;
>=20
> You seem not using it as _ms, but always as _us, why not define according=
ly?
> Also the other one is defined as unsigned long and this is as int. Why
> not unsigned?
>=20
> ...
>=20

I compare unintr_thresh_ms with wait_ms and use wait_ms with
msleep_interruptible(), and I think 20ms is more readable than 20000us
or 20 * USEC_PER_MSEC us.

But I agree about sign. It should be unsigned anyway.

> > +       for (fs =3D 0; fs < ARRAY_SIZE(msa311_fs_table); ++fs)
>=20
> fs++ will work as well.
>=20

I would prefer ++fs if you don't mind :)

> > +               /* Do not check msa311_fs_table[fs].val, it's always 0 =
*/
> > +               if (val2 =3D=3D msa311_fs_table[fs].val2) {
> > +                       mutex_lock(&msa311->lock);
> > +                       err =3D regmap_field_write(msa311->fields[F_FS]=
, fs);
> > +                       mutex_unlock(&msa311->lock);
>=20
> > +                       if (err)
> > +                               dev_err(dev, "cannot update scale (%d)\=
n", err);
>=20
> This can be done after putting the device back into (auto)sleep, right?
>=20

Are you talking about dev_err logging? Sure, it can be moved after
pm_runtime* calls.

> > +                       break;
> > +               }
> > +
> > +       pm_runtime_mark_last_busy(dev);
> > +       pm_runtime_put_autosuspend(dev);
>=20
> ...
>=20
> > +       for (odr =3D 0; odr < ARRAY_SIZE(msa311_odr_table); ++odr)
>=20
> odr++ works well also.

I would prefer ++odr if you don't mind :)

>=20
> ...
>=20
> > +                               dev_err(dev, "cannot update freq (%d)\n=
", err);
>=20
> frequency

It will be more ugly due 80 symbols restriction.

>=20
> ...
>=20
> > +               dev_err(dev, "cannot %s register %u from debugfs (%d)\n=
",
> > +                       readval ? "read" : "write", reg, err);
>=20
> You may consider taking [1] as a precursor here and use str_read_write().
>=20
> [1]: https://lore.kernel.org/linux-i2c/20220703154232.55549-1-andriy.shev=
chenko@linux.intel.com/

Oh, really... Thank you for suggestion!
>=20
> ...
>=20
> > +       struct device *dev =3D msa311->dev;
>=20
> Isn't it the same as indio_dev->dev.parent?
> Do you really need that member?

Should be the same... I will check.

>=20
> ...
>=20
> > +       int bit =3D 0, err, i =3D 0;
>=20
> How is the bit initial assignment used?

You are right, for for_each_set_bit() initializes bit inside.

[...]

> > +               dev_dbg(dev, "found MSA311 compatible chip[%#x]\n", par=
tid);
>=20
> Useless message.
>=20

Why? It's under dynamic debug, so I will see it if I really want to.

> ...
>=20
> > +               return dev_err_probe(dev, err, "cannot disable set0 int=
rs\n");
>=20
> interrupts

It will be more ugly due 80 symbols restriction.

[...]

> > +       /* Disable all axis by default */
>=20
> axis...
>=20
> > +       err =3D regmap_update_bits(msa311->regs, MSA311_ODR_REG,
> > +                                MSA311_GENMASK(F_X_AXIS_DIS) |
> > +                                MSA311_GENMASK(F_Y_AXIS_DIS) |
> > +                                MSA311_GENMASK(F_Z_AXIS_DIS), 0);
> > +       if (err)
> > +               return dev_err_probe(dev, err, "cannot enable all axes\=
n");
>=20
> ...or axes?

Axes of course.

>=20
> ...
>=20
> > +               return dev_err_probe(dev, err, "failed to set accel fre=
q\n");
>=20
> frequency
>=20

It will be more ugly due 80 symbols restriction.

[...]

> > +               return dev_err_probe(dev, -ENOMEM,
> > +                                    "cannot allocate newdata trig\n");
>=20
> trigger

It will be more ugly due 80 symbols restriction.

[...]

> > +               return dev_err_probe(dev, err, "cannot enable push-pull=
 int\n");
>=20
> interrupt

It will be more ugly due 80 symbols restriction.

> > +       indio_dev->modes =3D 0; /* setup buffered mode later */
>=20
> Why explicit assignment to 0? Doesn't kzalloc() do it for you?

kzalloc() will do it for me, of course. Previously, I initialized modes to
INDIO_DIRECT_MODE to just provide default value for that. Jonathan
suggested to replace it with 0. I can remove this line at all, no problem.
I just thought, it's more readable.

>=20
> ...
>=20
> > +               return dev_err_probe(dev, err, "cannot setup iio trig b=
uf\n");
>=20
> IIO trigger buffer

It will be more ugly due 80 symbols restriction.

>=20
> ...
>=20
> > +               return dev_err_probe(dev, err, "iio device register fai=
led\n");
>=20
> IIO
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

--=20
Thank you,
Dmitry=
