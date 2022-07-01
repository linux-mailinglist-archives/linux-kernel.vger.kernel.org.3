Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60591563313
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbiGAMAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiGAMAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:00:37 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB62F83F08;
        Fri,  1 Jul 2022 05:00:31 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 5CC6F5FD04;
        Fri,  1 Jul 2022 15:00:28 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1656676828;
        bh=gyPwB5+OVO7siaEhrsEb3sbbKDhwy+paF7E/JsUmC4o=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=eDjzAQcaJMOWRF96FnZqGtaG2uqpv70+/HYiJdlEJlXceRdQTaaS1kH7u7CkU2hDa
         AtpoXSaPdwPwOUL4+WjbXLk/5iVFXmocr/xsBvien4bGoxTErP9Y+qqH7ATtlHReK6
         LYUTE+uzSzuFHJJEcwlX3aB+L38EnmZvPlw8wag0pOH0Cv0mjtwSPUsDZ3zns4e7gT
         YVgxcc5nBHPm2XPbcdWahSvsI7DD3MHjOHkkpXS/uTJVNJ/ZAKoh4zJHRLYa0JOuQ/
         9DFyISIg/fwdjRK+20POfGmHzU5T5hREjPp5gK4V/s/zh6yttn9GyoikOWRpWdBuAk
         SoVKM3N3BeG/w==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Fri,  1 Jul 2022 15:00:27 +0300 (MSK)
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
Thread-Index: AQHYdd/Pt2zXEFx7c0Or/RCut5+rEK0/GLKAgCpM/oA=
Date:   Fri, 1 Jul 2022 11:59:59 +0000
Message-ID: <20220701115823.vywhifktaxcr72cc@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220601174837.20292-1-ddrokosov@sberdevices.ru>
 <20220604145955.2a1108ca@jic23-huawei>
In-Reply-To: <20220604145955.2a1108ca@jic23-huawei>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18D36DC6D25ED14FBF5A05D4E02E3307@sberdevices.ru>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan,

This patch has been on the mailing list for one month already, but no
comments from other IIO reviewers. What do you think we should do with it?
Is it a helpful change or not?

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
> Note I'm still keen that in general we keep the flow such that
> we do allocate()/register()/get() as there is no guarantee that the get()
> will never do anything that requires the trigger to be registered, even
> though that is true today.  Which is another way of saying I'm still
> keen we fix up any cases that sneak in after your fix up set dealt with
> the current ones.
>=20
> Thanks for following up on this!
>=20
> Jonathan
>=20

--=20
Thank you,
Dmitry=
