Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA92C5634A8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiGANtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiGANtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:49:45 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA32C27B32;
        Fri,  1 Jul 2022 06:49:42 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id EA7935FD03;
        Fri,  1 Jul 2022 16:49:39 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1656683380;
        bh=YXUoraWfnYfy0hSgolh/FxiWqXDsGzZ4lVAE9CP5umc=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=jeIH+5NN2v4t2D8ZdTOioxfh08oUzODDmcpPa4W2LCteNTrAtCKp100sTP77aO9LQ
         lP63XC7PgS4xkOjaUp/24GXZWAktK/YKCuyP7pYuDpSrfD51Pf7IRxDrwnc8Hpgkdf
         Fe4rY1jzWfVfsbtPibsCbbJnJ83UupA11w42xBKScvEqzi2D1tOISDC5o0w++/lZby
         I+VDly2EdmneivYbfmTzO7yg/odpxhCSdkxQTCRGx6KnLolOgViUXJhVMf9Mn8W/Yb
         jgZ/2bXUvPDdvBIfBRuiZkXbJawt7YtBJRyHyoWLf1tVKmdDXAYEDLzwqvDkbxFFqd
         msPEEzug9xiHA==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Fri,  1 Jul 2022 16:49:39 +0300 (MSK)
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
Thread-Index: AQHYgW2+up0uMWdZgUWEAW/5cCPkBq1WepyAgBLyeQA=
Date:   Fri, 1 Jul 2022 13:49:10 +0000
Message-ID: <20220701134734.nfc6xa4q7rhfi3r7@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220616104211.9257-1-ddrokosov@sberdevices.ru>
 <20220616104211.9257-3-ddrokosov@sberdevices.ru>
 <20220619132703.5cf3b090@jic23-huawei>
In-Reply-To: <20220619132703.5cf3b090@jic23-huawei>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <036813C44A635F4DA01F1C93886F5056@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/07/01 07:59:00 #19867624
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan,

Sorry for the delayed response.

On Sun, Jun 19, 2022 at 01:27:03PM +0100, Jonathan Cameron wrote:
> On Thu, 16 Jun 2022 10:42:14 +0000
> Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
>=20
> > MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
> > sensitivity consumer applications. It has dynamical user selectable ful=
l
> > scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measuremen=
ts
> > with output data rates from 1Hz to 1000Hz.
> >=20
> > Datasheet can be found at following URL:
> > https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.pdf
> >=20
> > This driver supports following MSA311 features:
> >     - IIO interface
> >     - Different power modes: NORMAL and SUSPEND (using pm_runtime)
> >     - ODR (Output Data Rate) selection
> >     - Scale and samp_freq selection
> >     - IIO triggered buffer, IIO reg access
> >     - NEW_DATA interrupt + trigger
> >=20
> > Below features to be done:
> >     - Motion Events: ACTIVE, TAP, ORIENT, FREEFALL
> >     - Low Power mode
> >=20
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> Hi Dmitry,
>=20
> A few things I missed before + I'm still not happy with the runtime
> pm handling.  One case that isn't covered well is !CONFIG_RUNTIME_PM
>=20
> Thanks,
>=20
> Jonathan
>=20

...

> > +static irqreturn_t msa311_buffer_thread(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf =3D p;
> > +	struct iio_dev *indio_dev =3D pf->indio_dev;
> > +	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
> > +	struct device *dev =3D &msa311->i2c->dev;
> > +	const struct iio_chan_spec *chan;
> > +	__le16 axis;
> > +	int bit =3D 0, err, i =3D 0;
> > +
> > +	/* Ensure correct alignment of time stamp when present */
> > +	struct {
> > +		__le16 channels[MSA311_SI_Z + 1];
> > +		s64 ts __aligned(8);
> > +	} buf;
> > +
> > +	memset(&buf, 0, sizeof(buf));
> > +
> > +	mutex_lock(&msa311->lock);
> > +
> > +	for_each_set_bit(bit, indio_dev->active_scan_mask,
> > +			 indio_dev->masklength) {
> > +		chan =3D &msa311_channels[bit];
>=20
> Nothing to do with your driver, but feels like it's worth
> exploring a
> 	for_each_chan_in_iio_scan(struct iio_chan_spec, struct iio_dev) macro.
>=20
> I'll add that to my todo list.
>=20

If you don't mind, I can prepare such a patch.

...

> When this unwind we will disable autosuspend etc, but leave the device
> in whatever state it happens to be in at that stage (if I understand
> this handling correctly).  That might seem like a bad thing, but if
> we register a devm_add_action_or_reset() callback before this which
> disables the device independently of anything to do with runtime PM,
> then the device will
> a) Be turned off as desired.
> b) It'll still be turned off even if runtime pm is disabled for the syste=
m
>    which is nice.
>=20
> Given the particular state register must be writeable and is presumably
> idempotent, can we just call=20
> err =3D msa311_set_pwr_mode(msa311, MSA311_PWR_MODE_SUSPEND);
> Unconditionally in such a callback?

I think it's a good idea. I didn't think about the configs when runtime pm
is disabled. So looks like we need to make sure that device is workable
from a pm perspective, and it is achievable only using a direct
msa311_set_pwr_mode() call as you suggested below.

> > +	err =3D devm_pm_runtime_enable(dev);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Resume msa311 logic before any interactions with registers */
> > +	err =3D pm_runtime_resume_and_get(dev);
> I missed this before, but if runtime pm is disabled, this won't do anythi=
ng
> so device won't be powered on.
>=20
> One common(ish) way to handle this is the following sequence.
>=20
> 1) Power up supply regs etc and a register a devm_ callback to turn them =
off again.
> 2) Put the device into a non suspend state (not using runtime pm calls).
> 3) Register a callback to turn it off again (that is safe against it bein=
g
>    turned off via another path such as runtime pm).
> 4) pm_runtime_set_active() to let the runtime pm code know it is turned o=
n.
> 5) devm_pm_runtime_enable()
> 6) autosuspend setup and enablement.
>=20
> If runtime pm isn't enabled then only 1-3 happen.  We waste power but the
> device works.

--=20
Thank you,
Dmitry=
