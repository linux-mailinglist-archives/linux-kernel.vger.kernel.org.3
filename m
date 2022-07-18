Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E505780AC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiGRLY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbiGRLY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:24:56 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9ED219B;
        Mon, 18 Jul 2022 04:24:53 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 9F14F5FD2C;
        Mon, 18 Jul 2022 14:24:50 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1658143490;
        bh=wGEeIQWWGtUa/UelB/KX1+Ok9OTnuuq+f1pYAYE6qF8=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=htKR2Puy5cXqexK4g/yiTKmkgj/VY4lXUoTfY47f6egQQTBzXefQVDmQ44zcdCq0A
         VFHUBQhbWb79fNN9ILbwaM6IY/oRGo0HZdSnsXacS/GkzpHv4hND6hNC7VmFsAD+x0
         XdgPGsM+CnC0j27P6WN83LYg9Y5cHApd3BbIDRjeDG0c+P6ZVqUNzJJgJbw14sVehA
         V5W2iX+oD1rusI23T28nXa4YzN1YzTcssDMCUuP112vB5zQZTe5VyBHm2Y13YJMCwR
         7IRIJtcnlCmAwTja6zGKas1CuScUy38JXjJaQmTTdwgXknJrnxPnss/G72ikc8uyI5
         rov8Z1qby6D8A==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Mon, 18 Jul 2022 14:24:50 +0300 (MSK)
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
Thread-Index: AQHYdd/Pt2zXEFx7c0Or/RCut5+rEK0/GLKAgCpM/oCAEyDEAIAErDEAgALhSAA=
Date:   Mon, 18 Jul 2022 11:23:59 +0000
Message-ID: <20220718112446.lucl7omialqri7yv@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220601174837.20292-1-ddrokosov@sberdevices.ru>
 <20220604145955.2a1108ca@jic23-huawei>
 <20220701115823.vywhifktaxcr72cc@CAB-WSD-L081021.sigma.sbrf.ru>
 <20220713170436.32330fa6@jic23-huawei> <20220716162556.2e919bf7@jic23-huawei>
In-Reply-To: <20220716162556.2e919bf7@jic23-huawei>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AF8CF10F72894E429D9BAA345C244FE0@sberdevices.ru>
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

Hello Jonathan,

On Sat, Jul 16, 2022 at 04:25:56PM +0100, Jonathan Cameron wrote:
> On Wed, 13 Jul 2022 17:04:36 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> > On Fri, 1 Jul 2022 11:59:59 +0000
> > Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
> >=20
> > > Hello Jonathan,
> > >=20
> > > This patch has been on the mailing list for one month already, but no
> > > comments from other IIO reviewers. What do you think we should do wit=
h it?
> > > Is it a helpful change or not? =20
> >=20
> > Given I'm way behind and timing in cycle, I'm probably going to kick th=
is
> > back to start of the next cycle. Sorry for delay,
> Applied to the togreg branch of iio.git.
>=20
> I'm unlikely to do another pull request this cycle unless there is a dela=
y in
> the release for some reason (and probably not even if there is), so this
> is queued up for next cycle.  As such it'll sit exposed only in the testi=
ng
> branch until I rebase on rc1.
>=20
> Thanks,
>=20
> Jonathan
>=20

Thank you for the patch applied.
I have one question about the previous already applied patchset

https://lore.kernel.org/all/20220607183907.20017-1-ddrokosov@sberdevices.ru=
/

I see this patchset already merged to linux-next more than a month ago.
But it's still not available in the linux stable branch. Could you please
explain what's the problem with this one? Was some bug found during
linux-next testing stage? Should I fix something?

Appreciate any help to understand what's I missing.

--=20
Thank you,
Dmitry=
