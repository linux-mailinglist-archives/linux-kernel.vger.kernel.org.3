Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACEA52BAA1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbiERM02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbiERM0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:26:23 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6FD5FF0D;
        Wed, 18 May 2022 05:26:18 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 3618C5FD02;
        Wed, 18 May 2022 15:26:15 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1652876775;
        bh=sFH5idW86lWQdWvgqVFesZuStLdWb38v0wu7UBLxe5s=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=hZpoRYairtXzQsb9c6qOeMBgrb8K9oiH3VkZuemIMBxs5nKXZXTdbtviPfb4H5iZE
         1U0jaQnb83VUKUBQrSJ19/alHHVHqV++bFrralWmYqg5pC6/+By+OCM+KRdx5F/jkq
         5U6WeMTFmEx093VTdDHbY4mxBSsMCXzi9rh0nZAyuWOIABJHJ5I1WGuOkkVMkF3kxd
         N2TM1n4NBzCjPvQg+00dPGlr3QoouZP0DwTLkblzcc8YCQNeIUSioAPg4fQcY2Ib83
         +3HyBTbeTVSXF6eRzTQidNzeojsVWkpD1EeQkADFk9vOOe22JdXGsQgybKEufKQMqr
         lb3sR67M5lemA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Wed, 18 May 2022 15:26:13 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Topic: [PATCH v1 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Index: AQHYVASOybrxT0DjfUWoYWuGUlWOX6z4bouAgAnb/gCAIkALgA==
Date:   Wed, 18 May 2022 12:25:59 +0000
Message-ID: <20220518122515.aby5lbb4xusr6pdt@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220419154555.24191-1-ddrokosov@sberdevices.ru>
 <20220419154555.24191-3-ddrokosov@sberdevices.ru>
 <20220420115023.00006a25@Huawei.com>
 <20220426172406.s4h6g7nrpytaq263@CAB-WSD-L081021.sigma.sbrf.ru>
In-Reply-To: <20220426172406.s4h6g7nrpytaq263@CAB-WSD-L081021.sigma.sbrf.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AC753801DB3F2E4DBCBE5465066DECA8@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/05/18 09:28:00 #19466841
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

I have two items to be discussed about iio_trigger_get().
Please see my questions below and correct me if I'm wrong.

On Tue, Apr 26, 2022 at 08:24:10PM +0300, Dmitry Rokosov wrote:
> > > +							       "%s-new-data",
> > > +							       indio_dev->name);
> > > +		if (!msa311->new_data_trig) {
> > > +			dev_err(&i2c->dev, "cannot allocate new data trig\n");
> > > +			err =3D -ENOMEM;
> > > +			goto err_lock_destroy;
> > > +		}
> > > +
> > > +		msa311->new_data_trig->dev.parent =3D &i2c->dev;
> > > +		msa311->new_data_trig->ops =3D &msa311_new_data_trig_ops;
> > > +		iio_trigger_set_drvdata(msa311->new_data_trig, indio_dev);
> > > +		indio_dev->trig =3D msa311->new_data_trig;
> >=20
> > This will create a double free if you were to change the trigger.
> > 		indio_dev->trig =3D iio_trigger_get(trig);
> >=20
>=20
> I didn't take into account other trigger usage.
> I'll rework this place for the v2.
>=20

The first one problem is module_get() calling for trigger get()
semantic.
I've applied iio_trigger_get() function to acquire module refcnt,
but I've faced with rmmod busy problem. IIO driver module doesn't want to
stop and unload due to not having zero module refcnt.
Syscall delete_module() tries to stop module first and after calls
driver exit() function (which executes devm_* handlers inside, including II=
O
trigger unregister). It means we have the chicken or the egg dilemma here.
Module can't be unloaded until module refcnt is not zero and we can't
execute IIO trigger unregister (decrease module refcnt) only when module
refcnt is zero.
I suppose the possible solution to such a problem is a different semantic
for internal triggers (inside driver itself) and external drivers (like
hwtimer trigger). What do you think?

The second one issue is located in the different IIO drivers. Some modules
call iio_trigger_get() before iio_trigger_register(), trig->owner is not
initialized to the right value (THIS_MODULE) and we don't acquire refcnt
for proper driver object.
I'm going to send patchset to problem driver set, but I can test only
buildable status for such modules, are you okay with that?

--=20
Thank you,
Dmitry
