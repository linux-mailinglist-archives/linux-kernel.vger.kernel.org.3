Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7285552E2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377470AbiFVRwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236780AbiFVRwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:52:19 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D9135241;
        Wed, 22 Jun 2022 10:52:16 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id D165C5FD04;
        Wed, 22 Jun 2022 20:52:12 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1655920332;
        bh=N634Zf56yv5/vkYfAq7VOSnfTEBvydl4YRfmE/8zL30=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=dqSYQ7LZD/baRFrXkuxGMrMSGpBh8WY5yyxHZP+rVD2qrww5N3qpsTt+uDxytZL/U
         AN4/5M74dq9I3swXvml8kBII/5bGOJAFB18a5EsC/lvsFxAyTClgrYCwyhJgXzTShN
         jpTeu6+kAGg+e2ShsEVveLQDNv79t+zahHajvGWxVKKCd1N8cg4HQromG03kxsY1tu
         W+KK2thgZvftFFBu6ujr5m9Qp1bJHJ1QI8osTYirf7bWWDgQAgrVN+kz8kNY55bLvw
         MFEL91nU2G1WQm/7R7Q2nqgYnP3hymCSYg2kpOUaKhC20zj7JBybZ5XKS2fIy5yJRe
         9pFR7V0J8gj1Q==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Wed, 22 Jun 2022 20:52:12 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "noname.nuno@gmail.com" <noname.nuno@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rockosov@gmail.com" <rockosov@gmail.com>
Subject: Re: [PATCH v3] iio: trigger: warn about non-registered iio trigger
 getting attempt
Thread-Topic: [PATCH v3] iio: trigger: warn about non-registered iio trigger
 getting attempt
Thread-Index: AQHYep3lZdCBX5wfLkWR1miHp7T4Oq1Rmw8AgANrnICABpNhAA==
Date:   Wed, 22 Jun 2022 17:51:56 +0000
Message-ID: <20220622175206.ddyyex7bezzh4rd4@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220607183907.20017-1-ddrokosov@sberdevices.ru>
 <20220616091308.miwqkdfc77mm72hz@CAB-WSD-L081021.sigma.sbrf.ru>
 <20220618142703.75025659@jic23-huawei>
In-Reply-To: <20220618142703.75025659@jic23-huawei>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BBC3AE6F80A9864EBADE94B6544763F9@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/06/22 11:20:00 #19842104
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan,

On Sat, Jun 18, 2022 at 02:27:03PM +0100, Jonathan Cameron wrote:
> On Thu, 16 Jun 2022 09:13:00 +0000
> Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
>=20
> > Hello Jonathan,
> >=20
> > I notice the patchset from=20
> > https://lore.kernel.org/all/20220524181150.9240-1-ddrokosov@sberdevices=
.ru/
> > is not merged to stable yet.
> > I think if this WARN() patch is okay for you, maybe it's better to merg=
e
> > it together with the previous one. It will notify developers about this
> > problem as you suggested before, and the previous patchset resolves the=
 issue
> > in the all IIO drivers.
> >=20
> > What do you think about it?
>=20
> It would be a stretch to take a defensive measure like this into stable,
> so I'll just queue this up for the next merge window.  We might have
> some exciting intermediate times where anyone actually using the togreg
> branch directly will get drivers that will spit out the warning.
> That should only be people active on the list though who will find
> this quickly enough and understand what is gong on.
>=20
> I'm fine with this and it's been on list long enough for anyone else to c=
omment.
> It'll be in a branch I'm happy to rebase for at few days anyway if there
> are any last minute comments or tags.
>=20
> Applied to the togreg branch of iio.git and pushed out as testing.
>=20
> Hopefully I'll get a pull request out for the fixes-togreg branch
> sometime this weekend.

Thanks a lot for such detailed clarification! I'm seeing this warn
patchset in the linux-next already.

--=20
Thank you,
Dmitry=
