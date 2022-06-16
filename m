Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D5F54E849
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356345AbiFPRCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348065AbiFPRCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:02:34 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F218F4924C;
        Thu, 16 Jun 2022 10:02:26 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id D1E4E5FD03;
        Thu, 16 Jun 2022 20:02:23 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1655398943;
        bh=c8nGHSoCYKivIqQ2DHZGOgnkq8MRyBYS9rcB3G6l1og=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=lraNj3hbANOZtyyp9vN1jcz9gbXumsTAbW7rdcBSZ0rU3BWwT6DZO+4StTQ6Xxyq4
         sP19lwbFtAIblYisGpjBYYNFxNK9DTw31cKH+RlrWGQrNDuYCtuqw/45DN2bYRzPJ4
         uScEJEZ2ICBPrPaoIsYAIjNZhyGXN7i0cXvqeFErDRSMjQq6wDisfrotcDEHOmcN3E
         l9saVFO1jiXpzG27CcsMi4f88lHAL4bM5/awLnRe7pM145mZzOozjbG8elrHm/DmAc
         Mg3z2/4j0Gdjl9TiAbJvgknDrqmxqOxMijOIxJ5jB+HDzV16+S+pXp+BcQbj8XcO4y
         +8uXu9LBCjldw==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Thu, 16 Jun 2022 20:02:23 +0300 (MSK)
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
Subject: Re: [PATCH v3 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Topic: [PATCH v3 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Index: AQHYgW2+up0uMWdZgUWEAW/5cCPkBq1RwVQAgABPMQA=
Date:   Thu, 16 Jun 2022 17:02:08 +0000
Message-ID: <20220616170218.dihjli46spimozeg@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220616104211.9257-1-ddrokosov@sberdevices.ru>
 <20220616104211.9257-3-ddrokosov@sberdevices.ru>
 <CAHp75Vc0+ckNnm2tzLMPrjeFRjwoj3zy0C4koNShFRG3kP8b6w@mail.gmail.com>
In-Reply-To: <CAHp75Vc0+ckNnm2tzLMPrjeFRjwoj3zy0C4koNShFRG3kP8b6w@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F15C7B2110EABF4AB31F523C4E5315CF@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/06/16 07:44:00 #19785775
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

Thank you for the quick review. Please find my comments below.

On Thu, Jun 16, 2022 at 02:18:52PM +0200, Andy Shevchenko wrote:
> On Thu, Jun 16, 2022 at 12:42 PM Dmitry Rokosov
> <DDRokosov@sberdevices.ru> wrote:

...

> > +enum msa311_fields {
> > +       F_SOFT_RESET_I2C, F_SOFT_RESET_SPI,
> > +
> > +       F_ORIENT_INT, F_S_TAP_INT, F_D_TAP_INT, F_ACTIVE_INT, F_FREEFAL=
L_INT,
> > +
> > +       F_NEW_DATA_INT,
> > +
> > +       F_TAP_SIGN, F_TAP_FIRST_X, F_TAP_FIRST_Y, F_TAP_FIRST_Z, F_ACTV=
_SIGN,
> > +       F_ACTV_FIRST_X, F_ACTV_FIRST_Y, F_ACTV_FIRST_Z,
> > +
> > +       F_ORIENT_Z, F_ORIENT_X_Y,
> > +
> > +       F_FS,
> > +
> > +       F_X_AXIS_DIS, F_Y_AXIS_DIS, F_Z_AXIS_DIS, F_ODR,
> > +
> > +       F_PWR_MODE, F_LOW_POWER_BW,
> > +
> > +       F_X_POLARITY, F_Y_POLARITY, F_Z_POLARITY, F_X_Y_SWAP,
> > +
> > +       F_ORIENT_INT_EN, F_S_TAP_INT_EN, F_D_TAP_INT_EN, F_ACTIVE_INT_E=
N_Z,
> > +       F_ACTIVE_INT_EN_Y, F_ACTIVE_INT_EN_X,
> > +
> > +       F_NEW_DATA_INT_EN, F_FREEFALL_INT_EN,
> > +
> > +       F_INT1_ORIENT, F_INT1_S_TAP, F_INT1_D_TAP, F_INT1_ACTIVE,
> > +       F_INT1_FREEFALL,
> > +
> > +       F_INT1_NEW_DATA,
> > +
> > +       F_INT1_OD, F_INT1_LVL,
> > +
> > +       F_RESET_INT, F_LATCH_INT,
> > +
> > +       F_FREEFALL_MODE, F_FREEFALL_HY,
> > +
> > +       F_ACTIVE_DUR,
> > +
> > +       F_TAP_QUIET, F_TAP_SHOCK, F_TAP_DUR,
> > +
> > +       F_TAP_TH,
> > +
> > +       F_ORIENT_HYST, F_ORIENT_BLOCKING, F_ORIENT_MODE,
> > +
> > +       F_Z_BLOCKING,
> > +
> > +       F_MAX_FIELDS,
>=20
> Not sure why you put those blank lines herey, it makes code not compact.
>=20

Here I use blank lines to split fields from different registers.
In other words, in the msa311_fields enum one line contains fields from one
register. But for some heavy registers (like TAP_ACTIVE_STS) we have so man=
y
fields and their declaration doesn't fit to 80 symbols.
So I've made a decision to split registers using blank lines.

...

> > +struct msa311_priv {
>=20
> > +       struct i2c_client *i2c;
>=20
> Not sure you need this. Dropping i2c dependency from this structure
> allows much easier to add, e.g. SPI support of the same hardware.
>=20

Mainly I use i2c pointer in the probe() path, and you are right, we can
change i2c pointer to dev and generalize msa311_priv struct from bus
perspective.

> > +       struct mutex lock; /* state guard */
> > +
> > +       struct iio_trigger *new_data_trig;
> > +
> > +       struct regmap *regs;
>=20
> I believe this is used most, so making this a first member in the
> structure saves  some instructions (check with bloat-o-meter).
>=20

Are you talking about archs where offset calculation adds more bytes to
instruction? And when offset equals to 0, we can save some space.

...

> > +       struct regmap_field *fields[F_MAX_FIELDS];
> > +};
>=20
> ...
>=20
> > +       wait_ms =3D (USEC_PER_SEC * MSEC_PER_SEC) / freq_uhz;
>=20
> This looks very odd from a physics perspective: sec * sec * sec =3D=3D se=
c ?!
>=20
> Perhaps you meant some HZ* macros from units.h?
>=20

I suppose because of UHZ calculation I have to use NANO instead of
USEC_PER_SEC in the following line:

	freq_uhz =3D msa311_odr_table[odr].val * USEC_PER_SEC +
		   msa311_odr_table[odr].val2;

But below line is right from physics perspective. 1sec =3D 1/Hz, so
msec =3D (USEC_PER_SEC / freq_uhz) * MSEC_PER_SEC:

	wait_ms =3D (USEC_PER_SEC * MSEC_PER_SEC) / freq_uhz;

Or do you mean that I should change MSEC_PER_SEC to just MILLI?

> > +       err =3D -EINVAL;
> > +       mutex_lock(&msa311->lock);
> > +       for (odr =3D 0; odr < ARRAY_SIZE(msa311_odr_table); ++odr)
> > +               if (val =3D=3D msa311_odr_table[odr].val &&
> > +                   val2 =3D=3D msa311_odr_table[odr].val2) {
> > +                       err =3D msa311_set_odr(msa311, odr);
>=20
> > +                       if (err) {
> > +                               dev_err(dev, "cannot update freq (%d)\n=
", err);
> > +                               goto failed;
> > +                       }
>=20
> Why is this inside the loop and more important under lock? Also you
> may cover the initial error code by this message when moving it out of
> the loop and lock.
>=20
> Ditto for other code snippets in other function(s) where applicable.
>=20

Yes, I can move dev_err() outside of loop. But all ODR search loop
should be under lock fully, because other msa311 operations should not
be executed when we search proper ODR place.

...

> > +       mutex_lock(&msa311->lock);
> > +       err =3D regmap_field_write(msa311->fields[F_NEW_DATA_INT_EN], s=
tate);
> > +       mutex_unlock(&msa311->lock);
>=20
> > +
>=20
> No need.
>=20

Sorry, I don't understand. We do not need to call it under lock, right?
I think we have to wrap it by msa311 lock, because other msa311
operations should not be executed when we enable or disable new data
interrupt (for example ODR value changing or something else).

> > +       if (err)
> > +               dev_err(dev,
> > +                       "cannot %s buffer due to new_data_int failure (=
%d)\n",
> > +                       state ? "enable" : "disable", err);
>=20
> str_enable_disable()
>=20
> ...
>=20

Kernel has solutions on all occasions :-)

...

> > +       /* TODO: send motion events if needed */
>=20
> Are you going to address all TODOs? If no, drop ones that you are not
> going to address in the future, better to put into the top of the file
> comment what is supported and what's not.
>=20
> ...
>=20

Yes, I plan to maintain this driver and implement all motion event,
that's why I've placed TODO throughout the code.

> > +       indio_dev->modes =3D INDIO_DIRECT_MODE; /* setup buffered mode =
later */
>=20
> Leaving it 0 is probably better, it's a pity that we don't have
> INDIO_NO_MODE_SET 0 there. However, I haven't checked if it's possible
> to leave it unset like this.
>=20
> ...
>=20

I set INDIO_DIRECT_MODE by default, because this driver support noirq
mode, when device tree doesn't have irq setup.

...

> > +       mutex_lock(&msa311->lock);
> > +       err =3D msa311_set_pwr_mode(msa311, MSA311_PWR_MODE_NORMAL);
> > +       mutex_unlock(&msa311->lock);
>=20
> > +
>=20
> No need.
>=20

Again I don't understand why, sorry. We do not want to get sporadic
MSA311 attributes changing during power mode transition from another
userspace process.

--=20
Thank you,
Dmitry=
