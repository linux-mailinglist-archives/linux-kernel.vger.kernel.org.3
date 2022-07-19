Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EB75795D6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbiGSJLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbiGSJLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:11:45 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332D21E3F4;
        Tue, 19 Jul 2022 02:11:42 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id E75935FD2D;
        Tue, 19 Jul 2022 12:11:38 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1658221898;
        bh=ndyH5ftv3Kzz+sOzzgfEGnysfiLveuxF2LvHN7EM5H8=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=IN76I/eecdcEi83vEAMd4zXGN/QksoyxUwUmdC2cyW446jIVdx5GJCSHYGeG2ys7P
         CTcQVFRXddKV8n7oWnPTTpxYeUmc1sd4j3CthNp/VheRqmObPI12V947v22REO1nkm
         muuc3eE9rMBtSZl2EMwlTuNVyASKbzQ4P6H1Myisovhd0AEsYmkgKyhk0hgPZa0oa9
         m6MRyXv2EoArr6DGcWTkiqayobSaISnyFoBCHA3TB6PG2UVOwS0byIZkdkj17aNn3X
         a9KHcpT44hW+B5SMxMyZ+8HoM1BoN2chhcIDAuT4vYTbxTeFdhQKegVVfum/K4ekkK
         FDnM+Q9DIK+PQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Tue, 19 Jul 2022 12:11:38 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "noname.nuno@gmail.com" <noname.nuno@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1] iio: trigger: move trig->owner init to trigger
 allocate() stage
Thread-Topic: [RFC PATCH v1] iio: trigger: move trig->owner init to trigger
 allocate() stage
Thread-Index: AQHYdd/Pt2zXEFx7c0Or/RCut5+rEK0/GLKAgCpM/oCAEyDEAIAErDEAgALhSACAAGbVgIABBkYA
Date:   Tue, 19 Jul 2022 09:11:33 +0000
Message-ID: <20220719091132.qfax7t2ogacur65u@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220601174837.20292-1-ddrokosov@sberdevices.ru>
 <20220604145955.2a1108ca@jic23-huawei>
 <20220701115823.vywhifktaxcr72cc@CAB-WSD-L081021.sigma.sbrf.ru>
 <20220713170436.32330fa6@jic23-huawei> <20220716162556.2e919bf7@jic23-huawei>
 <20220718112446.lucl7omialqri7yv@CAB-WSD-L081021.sigma.sbrf.ru>
 <20220718183249.6f411e5c@jic23-huawei>
In-Reply-To: <20220718183249.6f411e5c@jic23-huawei>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CCB0717121BCD44BB0BFB8FC96D706E3@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/07/19 05:10:00 #19924636
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 06:32:49PM +0100, Jonathan Cameron wrote:
> On Mon, 18 Jul 2022 11:23:59 +0000
> Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
>=20
> > Hello Jonathan,
> >=20
> > On Sat, Jul 16, 2022 at 04:25:56PM +0100, Jonathan Cameron wrote:
> > > On Wed, 13 Jul 2022 17:04:36 +0100
> > > Jonathan Cameron <jic23@kernel.org> wrote:
> > >  =20
> > > > On Fri, 1 Jul 2022 11:59:59 +0000
> > > > Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
> > > >  =20
> > > > > Hello Jonathan,
> > > > >=20
> > > > > This patch has been on the mailing list for one month already, bu=
t no
> > > > > comments from other IIO reviewers. What do you think we should do=
 with it?
> > > > > Is it a helpful change or not?   =20
> > > >=20
> > > > Given I'm way behind and timing in cycle, I'm probably going to kic=
k this
> > > > back to start of the next cycle. Sorry for delay, =20
> > > Applied to the togreg branch of iio.git.
> > >=20
> > > I'm unlikely to do another pull request this cycle unless there is a =
delay in
> > > the release for some reason (and probably not even if there is), so t=
his
> > > is queued up for next cycle.  As such it'll sit exposed only in the t=
esting
> > > branch until I rebase on rc1.
> > >=20
> > > Thanks,
> > >=20
> > > Jonathan
> > >  =20
> >=20
> > Thank you for the patch applied.
> > I have one question about the previous already applied patchset
> >=20
> > https://lore.kernel.org/all/20220607183907.20017-1-ddrokosov@sberdevice=
s.ru/
> >=20
> > I see this patchset already merged to linux-next more than a month ago.
> > But it's still not available in the linux stable branch. Could you plea=
se
> > explain what's the problem with this one? Was some bug found during
> > linux-next testing stage? Should I fix something?
> >=20
> > Appreciate any help to understand what's I missing.
>=20
> It's not a fix so it will go in during the merge window in about 2 weeks =
time.
> Won't get backported to Stable though unless we ask for that to happen as=
 it's
> not really a fix so I didn't add a marking for it to be picked up for sta=
ble
> (which would only happen after 5.20-rc1 anyway).
>=20
> J

Thanks a lot for explanation!

--=20
Thank you,
Dmitry=
