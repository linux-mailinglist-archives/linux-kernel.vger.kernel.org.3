Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6F653E80C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbiFFLin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 07:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbiFFLij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 07:38:39 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0854C248D4;
        Mon,  6 Jun 2022 04:38:37 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 02CED5FD02;
        Mon,  6 Jun 2022 14:38:35 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1654515515;
        bh=DCRzAOFNcwchMzh3Qw9HmKBEcRjHpcR6MWajCtB3vMQ=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=IMeWX4/yurvJRs1DIJEO9pjGRSpAlVZmGF/VxEbns5msssR/6Xv8ZuFj09ROgRKpy
         Ms3qkrKCmRLqqJ+Ndl8dUt+nNdwR+J9pseTeBScc6aGeeavtpP6DKWH7vKGalFjdU/
         H7OxyAOzileID5sPzbptfIR6hLmQnx6BcK89m2yMXX4SOeDqdvgJww6bdH9mgitrMj
         g2LAa0Qm0AfLDrJGvltxY8ATpkPZ9FS0Rrq5xTlPUcFaWkpa9iJ7BSQaU6F6Lu13aT
         ZcKOHPu1FkYbcKINIiIeb8XvhK535CV2ObqAMAFspEj3opDatSYlWlPu0WYSlsB9o1
         +h6S8KDAuUdnQ==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Mon,  6 Jun 2022 14:38:34 +0300 (MSK)
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
Thread-Index: AQHYdd/Pt2zXEFx7c0Or/RCut5+rEK0/GLKAgAL9JoA=
Date:   Mon, 6 Jun 2022 11:37:42 +0000
Message-ID: <20220606113829.kmiudrofm2s6onpc@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220601174837.20292-1-ddrokosov@sberdevices.ru>
 <20220604145955.2a1108ca@jic23-huawei>
In-Reply-To: <20220604145955.2a1108ca@jic23-huawei>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6408C0C4B285DA44A2696A4DF252A12B@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/06/06 08:01:00 #19686715
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

Thank you for comments. I have a several questions about the flow,
please find them below.

On Sat, Jun 04, 2022 at 02:59:55PM +0100, Jonathan Cameron wrote:
> On Wed, 1 Jun 2022 17:48:32 +0000
> Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
>=20
> > To provide a new IIO trigger to the IIO core, usually driver executes t=
he
> > following pipeline: allocate()/register()/get(). Before, IIO core assig=
ned
> > trig->owner as a pointer to the module which registered this trigger at
> > the register() stage. But actually the trigger object is owned by the
> > module earlier, on the allocate() stage, when trigger object is
> > successfully allocated for the driver.
> >=20
> > This patch moves trig->owner initialization from register()
> > stage of trigger initialization pipeline to allocate() stage to
> > eliminate all misunderstandings and time gaps between trigger object
> > creation and owner acquiring.
> >=20
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
>=20
> Hi Dmitry,
>=20
> I 'think' this is fine, but its in the high risk category that I'd like
> to keep it on list for a few weeks before applying.
>=20

Could you please explain what it means? Do you have some testing branch
with such dangerous patches or do we need just to wait other developers
for more points of view? Thanks in advance.

> Note I'm still keen that in general we keep the flow such that
> we do allocate()/register()/get() as there is no guarantee that the get()
> will never do anything that requires the trigger to be registered, even
> though that is true today.  Which is another way of saying I'm still
> keen we fix up any cases that sneak in after your fix up set dealt with
> the current ones.

I fully agree with you. I suppose to resolve such a problem we need to
have some indicators that the trigger is already registered or not.
From my point of view, trig->list entry fits well to answer this question.
Trigger is added to the global IIO triggers list during register()
execution, so we can just check that entry is not empty to make sure that
trigger is registered.

I've sent a v2 patch version, where I use trig->list entry empty status to
warn it:

https://lore.kernel.org/linux-iio/20220606111316.19265-1-ddrokosov@sberdevi=
ces.ru/

>=20
> Thanks for following up on this!
>=20
> Jonathan
>=20

--=20
Thank you,
Dmitry=
