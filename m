Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F52540426
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345231AbiFGQyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237216AbiFGQyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:54:50 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3F5BC6D4;
        Tue,  7 Jun 2022 09:54:46 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 68A4F5FD02;
        Tue,  7 Jun 2022 19:54:43 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1654620883;
        bh=SxIEs4Kr3MMdE6b27V4AwRdPMYxuMtwrvbNaADakNbo=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=D33E9B0XvzoFQnefaFP2y4+CA9e9ESM9bUAYUmsFgyI4fF/laHnHWcgz8vaJzof83
         BFTykIevQMjyW6AXUaFSO4WRFu69epJNohdN59V3BzA8rOR7mymJambqs5vzAwZhJ1
         o9/khYKABTJGlTp+kniJRjzDSRtlqT29l4KReKS1h5B8r3Wdfe4BsFUwvXOqMzYv00
         0tB1CErSgIrtUzFi0oYDdMmyzWF1pDCJfQvSDB3pZKO8S/ZS9iqLb+jkGLaATR1JOh
         jyruSRIXms3QYsStTeyTpEOq4dQ0i8ao7lPeVabauRxBGseFc0UOX/5jCyF0i8mLe8
         eHR395I0Xk2/w==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Tue,  7 Jun 2022 19:54:42 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "noname.nuno@gmail.com" <noname.nuno@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: trigger: warn about non-registered iio trigger
 getting attempt
Thread-Topic: [PATCH v2] iio: trigger: warn about non-registered iio trigger
 getting attempt
Thread-Index: AQHYeZZUxOkpBS1pdUe6H6/GD97X1q1CID8AgAHY1QA=
Date:   Tue, 7 Jun 2022 16:54:35 +0000
Message-ID: <20220607165438.d4txhgccxfojlstv@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220606111316.19265-1-ddrokosov@sberdevices.ru>
 <CAHp75VfRF=NyU9TN0FJ=cj0w_C-cKL+foa+WskwpoBP9b+SfDA@mail.gmail.com>
In-Reply-To: <CAHp75VfRF=NyU9TN0FJ=cj0w_C-cKL+foa+WskwpoBP9b+SfDA@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6436944E7330F2468150E8FB336F7C2F@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/06/07 11:12:00 #19699674
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

Thank you for the quick reply.

On Mon, Jun 06, 2022 at 02:42:18PM +0200, Andy Shevchenko wrote:
> On Mon, Jun 6, 2022 at 1:23 PM Dmitry Rokosov <DDRokosov@sberdevices.ru> =
wrote:
> >
> > As a part of patch series about wrong trigger register() and get()
> > calls order in the some IIO drivers trigger initialization path:
> >
> > https://lore.kernel.org/all/20220524181150.9240-1-ddrokosov@sberdevices=
.ru/
> >
> > runtime WARN() is added to alarm IIO driver authors who make such
> > a mistake.
> >
> > When IIO driver allocates a new IIO trigger, it should register it befo=
re
>=20
> an IIO
>=20
> > calling the get() operation. In other words, each IIO driver must abide=
 by
> > IIO trigger alloc()/register()/get() calls order.
>=20
> I believe triggers usually acquired at ->probe() time, means that in
> case if the following code (however, I believe it will be quite rare)
> goes into deferred probe cycle the WARN will be repeated. Perhaps
> WARN_ONCE() ?

You are totally right. I've tested deferred probing using -EPROBE_DEFER
injection to probe() code path and WARN() was called each time. I'll fix
it in the v3 as you suggested.

--=20
Thank you,
Dmitry=
