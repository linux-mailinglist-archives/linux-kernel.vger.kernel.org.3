Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B53577F38
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbiGRKCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGRKCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:02:32 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB7A1A834;
        Mon, 18 Jul 2022 03:02:30 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 88BB05FD05;
        Mon, 18 Jul 2022 13:02:27 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1658138547;
        bh=m9CRKGODooL4ihV8IeV3aZLTDchk2WPpgnXqO4mdqD0=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=lUz16sVi86oL6Ht9iepWW9JMp0GFev8V4AkRVtnRIXMdIUjZP2IAnCf6CPY3KeprH
         uzCLj/9HEhjRbOUy5QSLLalP6fOtgUciiThUQUzTwpy8fD2yNZnJWsNKRCxTy6+uUh
         pL7Hg7SPW6CEo6K5YmTKN7+wY+zi87ntX8KxeNXc6tImRGiFX1Qm9vBN59AO7JeSU2
         7wVKUHx4Pq1lFXDVom1iQT2PdGiMG3hS7n/bxSgIPOL/9k6gMDP46pP0rfv4ZWaePI
         sN4vHPOCWdfymvghSoz6T96UooQfDPSy8KEuZUCGQWVn75kS1EeIXHzZnf5ly77DRe
         igkxl13XA3Akw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Mon, 18 Jul 2022 13:02:26 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Topic: [PATCH v3 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Index: AQHYgW2+up0uMWdZgUWEAW/5cCPkBq1WepyAgBLyeQCAF7WOgIACwyYA
Date:   Mon, 18 Jul 2022 10:01:36 +0000
Message-ID: <20220718100220.atptgzmy4htm7l34@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220616104211.9257-1-ddrokosov@sberdevices.ru>
 <20220616104211.9257-3-ddrokosov@sberdevices.ru>
 <20220619132703.5cf3b090@jic23-huawei>
 <20220701134734.nfc6xa4q7rhfi3r7@CAB-WSD-L081021.sigma.sbrf.ru>
 <20220716165121.3f0120df@jic23-huawei>
In-Reply-To: <20220716165121.3f0120df@jic23-huawei>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CDE8F2E907CBF64EBDE8C5F597CBF672@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/07/18 07:04:00 #19921665
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan,

On Sat, Jul 16, 2022 at 04:51:21PM +0100, Jonathan Cameron wrote:
> On Fri, 1 Jul 2022 13:49:10 +0000
> Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
>=20
> > Hello Jonathan,
> >=20
> > Sorry for the delayed response.
> >=20
> > On Sun, Jun 19, 2022 at 01:27:03PM +0100, Jonathan Cameron wrote:
> > > On Thu, 16 Jun 2022 10:42:14 +0000
> > > Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
> > >  =20
> > > > MSA311 is a tri-axial, low-g accelerometer with I2C digital output =
for
> > > > sensitivity consumer applications. It has dynamical user selectable=
 full
> > > > scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measur=
ements
> > > > with output data rates from 1Hz to 1000Hz.
> > > >=20
> > > > Datasheet can be found at following URL:
> > > > https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.pd=
f
> > > >=20
> > > > This driver supports following MSA311 features:
> > > >     - IIO interface
> > > >     - Different power modes: NORMAL and SUSPEND (using pm_runtime)
> > > >     - ODR (Output Data Rate) selection
> > > >     - Scale and samp_freq selection
> > > >     - IIO triggered buffer, IIO reg access
> > > >     - NEW_DATA interrupt + trigger
> > > >=20
> > > > Below features to be done:
> > > >     - Motion Events: ACTIVE, TAP, ORIENT, FREEFALL
> > > >     - Low Power mode
> > > >=20
> > > > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru> =20
> > > Hi Dmitry,
> > >=20
> > > A few things I missed before + I'm still not happy with the runtime
> > > pm handling.  One case that isn't covered well is !CONFIG_RUNTIME_PM
> > >=20
> > > Thanks,
> > >=20
> > > Jonathan
> > >  =20
> >=20
> > ...
> >=20
> > > > +static irqreturn_t msa311_buffer_thread(int irq, void *p)
> > > > +{
> > > > +	struct iio_poll_func *pf =3D p;
> > > > +	struct iio_dev *indio_dev =3D pf->indio_dev;
> > > > +	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
> > > > +	struct device *dev =3D &msa311->i2c->dev;
> > > > +	const struct iio_chan_spec *chan;
> > > > +	__le16 axis;
> > > > +	int bit =3D 0, err, i =3D 0;
> > > > +
> > > > +	/* Ensure correct alignment of time stamp when present */
> > > > +	struct {
> > > > +		__le16 channels[MSA311_SI_Z + 1];
> > > > +		s64 ts __aligned(8);
> > > > +	} buf;
> > > > +
> > > > +	memset(&buf, 0, sizeof(buf));
> > > > +
> > > > +	mutex_lock(&msa311->lock);
> > > > +
> > > > +	for_each_set_bit(bit, indio_dev->active_scan_mask,
> > > > +			 indio_dev->masklength) {
> > > > +		chan =3D &msa311_channels[bit]; =20
> > >=20
> > > Nothing to do with your driver, but feels like it's worth
> > > exploring a
> > > 	for_each_chan_in_iio_scan(struct iio_chan_spec, struct iio_dev) macr=
o.
> > >=20
> > > I'll add that to my todo list.
> > >  =20
> >=20
> > If you don't mind, I can prepare such a patch.
>=20
> I had a look at this whilst travelling and it's a lot more complex than I
> thought it would be because of gaps in the scan_index in some drivers (no=
t
> all channels have scan indexes and not all scan indexes are used)
>=20
> If we write such a thing we need to resolve that in the core and I suspec=
t
> it will require creation of an indirection structure that lets us
> do scan_index based look up of channels.  Whilst that works in many drive=
rs
> because there is a nice 1 to 1 mapping, there are exceptions.
> Hence I think we would be looking at:
>=20
> 1) Check at registration time on whether scan_index =3D=3D location in
> iio_dev->channels, if so set another pointer say iio_dev->channels_linear=
 =3D
> iio_dev->channels.
> 2) If not, create a lookup table and make iio_dev->channels_linear
> point to that.
> 3) Finally introduce a macro that uses channels_linear.
>=20
> What fun ;)
>=20
> Jonathan
> =20

Okay, I'll try looking for proper solution and prepare RFC patch.

--=20
Thank you,
Dmitry=
