Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A80B58AC14
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240750AbiHEOEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiHEOEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:04:38 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3351F2CE;
        Fri,  5 Aug 2022 07:04:36 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id DA4E85FD06;
        Fri,  5 Aug 2022 17:04:34 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1659708274;
        bh=KBHblqB033On8iyxviJajlqGBNdVHnA7KT9CW2gE/Lw=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=nmsuo8O3gjphxB1Y+GR8qX5k5BykpoyJSqR+ckPCrQ5Cj979RpcfWQwAaD0ZD3Q40
         XJ3/8drpy5pv699lF8DRllZvu6LPobl3Vfc1k9AHbQSzJqlux8AsCE3xOO8OBvtgPE
         GftZHWSXtpS4wAx9Bd7/Adj51D3qcr6ASlCCM2DEVhdrCp4ijyTXpTwndVfRaBD4/C
         vSJk1OZGGMXuW4QcZIjCnN21XQIe+P0SP3CcQd97dKCVr1qFKw1a8eJmnIygxINnnu
         cG2jlfmiK1e9kjrShzeLrebOSSE4MopfN2I2NhUMGyLNIgdf7NocCiEDmH309UtAPE
         Tt5nY+m4VEGSA==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Fri,  5 Aug 2022 17:04:34 +0300 (MSK)
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
Thread-Index: AQHYpzqIoQnaRj7vNkq2cXUUGjAB/62dQgeAgAAYQICAAYHbgIAAA5UAgAFIGQA=
Date:   Fri, 5 Aug 2022 14:04:06 +0000
Message-ID: <20220805140430.c773smfzxg5zcj4b@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220803131132.19630-1-ddrokosov@sberdevices.ru>
 <20220803131132.19630-3-ddrokosov@sberdevices.ru>
 <CAHp75VcVuC6yVoB1kycCOfqMa=JfCtbe3WYSK5qndtYcJy3vpg@mail.gmail.com>
 <20220803191621.tzrmndkygfe7nlpx@CAB-WSD-L081021.sigma.sbrf.ru>
 <20220804181723.4bljpxcwkj6cnn2f@CAB-WSD-L081021.sigma.sbrf.ru>
 <CAHp75Vcn6JCDDvugop2Ho1cayLi1CX78O42v3GifvnuSY5fvPA@mail.gmail.com>
In-Reply-To: <CAHp75Vcn6JCDDvugop2Ho1cayLi1CX78O42v3GifvnuSY5fvPA@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2569579201B2C14EB99D8D1151005A20@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/05 06:43:00 #20054623
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 08:30:12PM +0200, Andy Shevchenko wrote:
> > > > > +               dev_err(dev, "cannot %s register %u from debugfs =
(%d)\n",
> > > > > +                       readval ? "read" : "write", reg, err);
> > > >
> > > > You may consider taking [1] as a precursor here and use str_read_wr=
ite().
> > > >
> > > > [1]: https://lore.kernel.org/linux-i2c/20220703154232.55549-1-andri=
y.shevchenko@linux.intel.com/
> > >
> > > Oh, really... Thank you for suggestion!
> >
> > I have taken it closer, and it's really helpful and nice, but looks lik=
e
> > it's not merged to linux-next.
> > Please advise how I can use it in the driver. Should I provide
> > "Depends-On:" tag as I did for my HZ units patchset?
>=20
> No, just take that patch into your series.

Do you mean include your patch to this reply-thread through the
message-id linking? If my understanding is correct, maybe also it's better =
to
include HZ units series to the current series? I mean patch series on
below link:

https://lore.kernel.org/linux-iio/20220801143811.14817-1-ddrokosov@sberdevi=
ces.ru/

--=20
Thank you,
Dmitry=
