Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F748599E79
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 17:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349750AbiHSPcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 11:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349193AbiHSPcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 11:32:07 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42934100F04
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 08:32:05 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 6B62C5FD04;
        Fri, 19 Aug 2022 18:32:03 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660923123;
        bh=zWyiUptZ4RZ1jpiAfefgEeFDZyzEDGukVbRT30Gs/vw=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=PfFkMXnscG1yDH+Nv/ivVooJyvrMfCAjavKxn8c3DPtvOtsbiuy3vpUeXjFfOBJWj
         vkefRkIx7Cpz9eSc7Wr2HFAqDK7RtepmGGHND+QM8+6cE/uEFOmX6EYqx1ImO821Mf
         64ta3LvHROlDHlRdE5/fRbsI2NkYVHIUshbTFx6OEYW/bgjYkkqXp1RrFbFu0v5VBe
         58G+hAlENe1aCrTrcKQj9yCDo+Vrn2kn3I4E+PfVCFmywUVPmK5hD7NIYv1vHYKh9k
         ezGj6EchzuSabyQolyjdFO5F2QPT1nJSfkollRNlzvYph0Yk5AtMPWTpeTFF5mNLJX
         K6wodP83Gu3Ug==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Fri, 19 Aug 2022 18:32:02 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Marc Zyngier <maz@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux@rasmusvillemoes.dk>" <linux@rasmusvillemoes.dk>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] regmap: introduce value tracing for regmap bulk
 operations
Thread-Topic: [PATCH v1] regmap: introduce value tracing for regmap bulk
 operations
Thread-Index: AQHYsZwRTOzZdLxKvkqpBNcAgWIdzq20YtWAgAAaSQCAAB/4gIABfIkAgAADjYCAAA71gA==
Date:   Fri, 19 Aug 2022 15:31:34 +0000
Message-ID: <20220819153159.tddgfjind7mnvuax@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220816181451.5628-1-ddrokosov@sberdevices.ru>
 <20220818121515.6azkxyqetnunwsc6@CAB-WSD-L081021.sigma.sbrf.ru>
 <87mtc1wtjz.wl-maz@kernel.org> <Yv5eMcmNOmyLmd++@sirena.org.uk>
 <5793e1a9ef6d5a8fafd3f22cda0bb5e4@kernel.org>
 <Yv+gY34CRfqu3sCS@sirena.org.uk>
In-Reply-To: <Yv+gY34CRfqu3sCS@sirena.org.uk>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1A8138459735B4489626ADB24E354F39@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/19 07:02:00 #20132955
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 03:38:27PM +0100, Mark Brown wrote:
> On Fri, Aug 19, 2022 at 03:25:44PM +0100, Marc Zyngier wrote:
> > On 2022-08-18 16:43, Mark Brown wrote:
> > > On Thu, Aug 18, 2022 at 02:49:20PM +0100, Marc Zyngier wrote:
>=20
> > > > I don't care much about regmap as a MMIO backend, but it strikes me=
 as
> > > > odd that you end up with multiple ways of logging the same stuff (w=
ith
> > > > a memcpy in the middle of it).
>=20
> > > > Why can't this be done with a small amount of trace post-processing=
?
>=20
> > > At the minute we don't put the actual data for the bulk transfers int=
o
> > > the trace so the information simply isn't there.
>=20
> > But isn't that what this patch should do?
>=20
> I'd imagine so based on a quick glance at the description, I've not
> actually reviewed it yet, but in that case I'm not sure what your
> concern is here?
>=20
> > We also have recently merged the CONFIG_TRACE_MMIO_ACCESS which
> > already dumps all sort of MMIO crap^Winformation.
>=20
> Yes, that'd also cover it for MMIO based regmaps when enabled but
> obviously other buses exist and can also be accessed via regmap.
>=20
> > Surely there should be a more common approach to this.
>=20
> There's an argument for tracing at each abstraction layer since they're
> generally all doing *something*, people will look to the layer they're
> accessing and for things like tracing register accesses with buses like
> I2C and SPI regmap is adding the register semantics on top of a bus
> that's just a byte stream.  Even on buses with a native concept of an
> address there's stuff like paging which might be added on depending on
> the device.  They should probably all follow a similar pattern but I'm
> not sure we can do everything at once.

Oh, I see what you mean. Actually, I tested my patch only on I2C-regmap
abstraction only. I thought on the regmap level, it doesn't matter how
byte stream will be interleaved on the bus layer. On the other hand, from
a developer's perspective, we want to see a real bus stream trace with
already rearranged data chunks...

--=20
Thank you,
Dmitry=
