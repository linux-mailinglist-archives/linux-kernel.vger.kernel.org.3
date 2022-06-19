Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D80A550A24
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 13:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbiFSLXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 07:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbiFSLXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 07:23:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E3B218B;
        Sun, 19 Jun 2022 04:23:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3395061008;
        Sun, 19 Jun 2022 11:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70964C3411D;
        Sun, 19 Jun 2022 11:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655637783;
        bh=Ga08aNWEm/9YKJKYn977YCoDC642zSlRjrKCmmG2dr4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hgCPWRz7NonQqi9E5oyzdRA7Fgr7xkxVv6vUQscGxN/AcQ8a+pljM/aGoGaCGWci9
         73o/J3GgOWvedfTJ8qM+jZ4Io2z317cTmcS0ip7ho/dEn+OlMtJsX2EvRQlA8WVpqx
         GB4Qy2Uzr3OmY9g3wEeFSwMF1x3G3xRfN6TcBwlplLSacuXEWA1vYwMrpxb69MCgcq
         HNpyMRlxYUmkZIyohx44PTKFCFUpCfm8g3r1M1aD5CXO0nVBF53E5ubcqiAa6MJW/q
         gys/sc/zrgTVtRXtCbqNXp1UwVHuxSq0j0aybkwPyQLW/TMiWCDK1DRKQWOh3fV8sJ
         eZTp9EpzhhDJw==
Date:   Sun, 19 Jun 2022 12:32:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        cy_huang <cy_huang@richtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: Add rtq6056 support
Message-ID: <20220619123221.6c2bbf69@jic23-huawei>
In-Reply-To: <CADiBU3_LSwDcCrVFTHb8sLBEQWmyUpz94k=yQ=QQ+mC73sGx_w@mail.gmail.com>
References: <1655458375-30478-1-git-send-email-u0084500@gmail.com>
        <1655458375-30478-3-git-send-email-u0084500@gmail.com>
        <20220617181027.000074a8@Huawei.com>
        <CADiBU3_LSwDcCrVFTHb8sLBEQWmyUpz94k=yQ=QQ+mC73sGx_w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jun 2022 23:49:27 +0800
ChiYuan Huang <u0084500@gmail.com> wrote:

> Jonathan Cameron <Jonathan.Cameron@huawei.com> =E6=96=BC 2022=E5=B9=B46=
=E6=9C=8818=E6=97=A5 =E9=80=B1=E5=85=AD =E5=87=8C=E6=99=A81:10=E5=AF=AB=E9=
=81=93=EF=BC=9A
> >
> > On Fri, 17 Jun 2022 17:32:55 +0800
> > cy_huang <u0084500@gmail.com> wrote:
> > =20
> > > From: ChiYuan Huang <cy_huang@richtek.com>
> > >
> > > Add Richtek RTQ6056 supporting.
> > >
> > > It can be used for the system to monitor load current and power with =
16bit
> > > resolution.
> > >
> > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com> =20
> >
> > Hi ChiYuan,
> >
> > Comments inline.
> >
> > It would be nice to consider how to take advantage of the fact we know =
which
> > channels are of interest in buffered mode, and change the operating mod=
e to
> > suite.
> > =20
> I implement the  buffered mode is for the debugging or continuous
> tracking purpose.
>=20
> BUS channel is for input power source voltage
> Shunt channel is for the cross voltage difference for Rshunt.
> Current channel is calculated by Vshunt/Rshunt and the value converted by=
 HW.
> Power channel is calculated by BUS voltage multiple Current channel,
> and also the value converted by HW.
>=20
> For the opmode question, this IC already designed for low quiescent.
> If IC's in continuous mode, the typical quiescent current is still around=
 550uA.
> 'Shutdown' mode only use typical 3.5uA.
>=20
> Like as you said, I may consider to use pm_runtime plus autosuspend to
> minimize the wait time for the first new sample ready.
Ok.

>=20
> > > ---
> > >  .../ABI/testing/sysfs-bus-iio-adc-rtq6056          |  58 +++
> > >  drivers/iio/adc/Kconfig                            |  15 +
> > >  drivers/iio/adc/Makefile                           |   1 +
> > >  drivers/iio/adc/rtq6056-adc.c                      | 548 +++++++++++=
++++++++++
> > >  4 files changed, 622 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-rtq60=
56
> > >  create mode 100644 drivers/iio/adc/rtq6056-adc.c
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056 b/Do=
cumentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
> > > new file mode 100644
> > > index 00000000..0516429
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
> > > @@ -0,0 +1,58 @@
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage0_ra=
w =20
> >
> > Documentation can't be duplicated in mulitple files so these standard
> > attributes should rely only on the main docs.  If we duplicate it breaks
> > building the html docs unfortunately.
> > =20
> Does it mean there's no need to explain it here and covert this
> voltage to millivolt?

Yes, in_voltage0_raw * in_voltage0_scale must be in millivolts
and you can't have extra documentation here without breaking the
docs build.


> > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > index 48ace74..0b2d17c 100644
> > > diff --git a/drivers/iio/adc/rtq6056-adc.c b/drivers/iio/adc/rtq6056-=
adc.c
> > > new file mode 100644
> > > index 00000000..8374fce
> > > --- /dev/null
> > > +++ b/drivers/iio/adc/rtq6056-adc.c
> > > @@ -0,0 +1,548 @@

> > > +
> > > +#define RTQ6056_VENDOR_ID    0x1214
> > > +#define RTQ6056_DEFAULT_CONFIG       0x4127 =20
> >
> > This is not defined in terms of the field provided below
> > so it's not obvious what the initial state is.
> > =20
> To leave a comment about the default state?
> Or use the macro to define the all field?

Macro to define all fields means we don't have to check the
comment matches the code, so I would prefer that approach.
If hard to use macros for some reason, comment would be acceptable.




> > > +
> > > +static const char *rtq6056_channel_labels[RTQ6056_MAX_CHANNEL] =3D {
> > > +     [RTQ6056_CH_VSHUNT] =3D "Vshunt(uV)", =20
> >
> > Units must be the standard ones for the IIO channel types.
> > Hence documenting them here is misleading.
> > =20
> Can I use the "extend_name' and remove all the 'read_label' and
> channel_label variable?

No.  We very very rarely use extend name these days.  It was a bad
design decision and makes it harder to write userspace code.  Label
is the preferred way to provide this information today.

static const char *rtq6056_channel_labels[RTQ6056_MAX_CHANNEL] =3D {
     [RTQ6056_CH_VSHUNT] =3D "Vshunt", =20
     [RTQ6056_CH_VBUS] =3D "Vbus",
     [RTQ6056_CH_POWER] =3D "Power",
     [RTQ6056_CH_CURRENT] =3D "Current",
};

would be my suggestion for the labels.  Power and Current are a bit
redundant but we need to provide something alongside the useful
Vshunt and Vbus.




> And also , the unit will be removed. Thx.
> > > +     [RTQ6056_CH_VBUS] =3D "Vbus(mV)",
> > > +     [RTQ6056_CH_POWER] =3D "Power(mW)",
> > > +     [RTQ6056_CH_CURRENT] =3D "Current(mA)",
> > > +};
> > ... =20
> > > +static int rtq6056_probe(struct i2c_client *i2c)
> > > +{
> > > +     struct iio_dev *indio_dev;
> > > +     struct rtq6056_priv *priv;
> > > +     unsigned int vendor_id, shunt_resistor_uohm;
> > > +     int ret;
> > > +
> > > +     if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_WORD_=
DATA))
> > > +             return -EOPNOTSUPP;
> > > +
> > > +     indio_dev =3D devm_iio_device_alloc(&i2c->dev, sizeof(*priv));
> > > +     if (!indio_dev)
> > > +             return -ENOMEM;
> > > +
> > > +     priv =3D iio_priv(indio_dev);
> > > +     priv->dev =3D &i2c->dev;
> > > +     priv->vshuntct =3D priv->vbusct =3D RTQ6056_DEFAULT_CONVT;
> > > +     priv->avg_sample =3D RTQ6056_DEFAULT_AVG;
> > > +     i2c_set_clientdata(i2c, priv);
> > > +
> > > +     priv->regmap =3D devm_regmap_init_i2c(i2c, &rtq6056_regmap_conf=
ig); =20
> > You make a lot of use of regmap in this function. I would suggest
> > first allocating into a local variable, then using that to set
> > priv->regmap.  The local variable can then be used avoid having
> > priv->regmap everywhere.
> > =20
> dev_get_regmap(), instead?

You could use that, but I was thinking just

	struct regmap *regmap;
	...
	regmap =3D devm_regmap_init_i2c(i2c, &...)
	if (IS_ERR(regmap))
		return ...

	priv->regmap =3D regmap;

	ret =3D regmap_read(regmap, ....
etc.=09


...

> > > +static void rtq6056_shutdown(struct i2c_client *i2c)
> > > +{
> > > +     struct rtq6056_priv *priv =3D i2c_get_clientdata(i2c);
> > > +
> > > +     /* Config opmode to 'shutdown' mode to minimize quiescient curr=
ent */
> > > +     regmap_field_write(priv->rm_fields[F_OPMODE], 0); =20
> >
> > Unusual to provide a shutdown for a device as simple as an ADC.  I'd ex=
pect
> > the overall system to power down if we hit this and hence also cover
> > the ADC.  If that's not the case, then perhaps add a comment explaining
> > that.
> > =20
> That's because some application use VBAT as the VDD source.
> Not all applcation use the PMIC buck or ldo as the supply for RTQ6056.
> If use VBAT, then the shutdown quiescent current is important.

Ok. Add that information as a comment so we know why this is done
when looking back at the driver in future.

Btw, to save on long emails that need scrolling through it's fine
to just crop out any sections where you are accepting the feedback
and no additional discussion is needed.  Makes the whole process
more efficient as if you don't reply to some feedback I'll assume
you are accepting it.

Thanks,

Jonathan
