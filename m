Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2AF54B340
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344637AbiFNObe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343827AbiFNObc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:31:32 -0400
X-Greylist: delayed 877 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Jun 2022 07:31:28 PDT
Received: from mx3.securetransport.de (mx3.securetransport.de [IPv6:2a01:4f8:c0c:92be::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04693151C;
        Tue, 14 Jun 2022 07:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1655215552;
        bh=kZWe6Zc/bv5y1c1ZqXyxmMpzmoXjoTrNmG4TQBrLGXc=;
        h=From:To:CC:Subject:Date:From;
        b=Bn6KL59vtQ2XwQWrgwfpvmx+vrRJxkE38aajl1hPEdhFiqEfkWlhgnmx452oispNt
         7CCHu+dCo5jfaDDgoRAZ0A8s2m92ta8ZXGXf8aMp6cYOBpyaz6+zX9/mCjz6Y2G/NQ
         CThsZmMojAiGBWDGYT5rmU9utEsTfI8j3AfbomUfsCq4ESfRChN7ZvtBl8qlqx/5gb
         bW6B3Met3wMCKUItB4UPLIRlm1+UKoWBygcfAHlZloKg6Ho1QEHMTh8Nut7xqrerL3
         EOqKzJnjXG8FatzxDWfJLtOv6r+7VfDSgt0BGgOpECnBsnuEw0NFXsXzFT272JDMT8
         5cfDLXHZ+IS1A==
X-secureTransport-forwarded: yes
From:   Dominik Kierner <dkierner@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Javier Martinez Canillas <javierm@redhat.com>
CC:     "airlied@linux.ie" <airlied@linux.ie>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "maxime@cerno.tech" <maxime@cerno.tech>,
        "noralf@tronnes.org" <noralf@tronnes.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v6 3/6] drm: Add driver for Solomon SSD130x OLED displays
Thread-Topic: [PATCH v6 3/6] drm: Add driver for Solomon SSD130x OLED displays
Thread-Index: Adh/98yd/bFLOXDpTTiVpWIDbnNb5w==
Date:   Tue, 14 Jun 2022 14:05:36 +0000
Message-ID: <4dfc32123d1d4e38ae1afdd3f33109a9@dh-electronics.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Javier

On 6/14/22 13:39, Javier Martinez Canillas wrote:

> > I always understood regulator_get_optional() as a way of not having to =
rely on a dummy,
> > when a regulator is not present, but please correct me, if I am wrong o=
n this.
> > The dummies would only be necessary for the mandatory supplies VCC and =
VDD.
> >
>=20
> Yes, that's what I tried to say. That's regulator_get() and not _optional=
()
> the function that will provide a dummy regulator if isn't physically pres=
ent:
>=20
> https://elixir.bootlin.com/linux/latest/source/drivers/regulator/core.c#L=
2067
>=20
> > You mean this part of the documentation of regulator_get_optional(), co=
rrect?:
> >
> >> * This is intended for use by consumers for devices which can have
> >> * some supplies unconnected in normal use, such as some MMC devices.
> >> * It can allow the regulator core to provide stub supplies for other
> >> * supplies requested using normal regulator_get() calls without
> >> * disrupting the operation of drivers that can handle absent
> >> * supplies.
> >
> >
> So for example when you just use a voltage rail in let's say a board pin =
header
> then you will need to define supply nodes with compatible =3D "regulator-
> fixed" ?

Exactly.

> That is indeed more accurate from a hardware description point of view bu=
t I'm
> not convinced that this is something worth to break DT backward compatibi=
lity.

> You also mentioned (IIUC) that the regulators could be made optional and =
their
> presence be used as an indication that an atomic charge pump configuratio=
n can
> be made instead of using the current ssd130x->display_settings.use_charge=
_pump.
>=20
> I think that would prefer that the latter option, but will let others to =
chime
> in since maybe I'm not correct on the preferred approach.

Yes, here the reference for the former approach:
Chapter 2 "Charge Pump Regulator" on Page 62 of the SSD1306 datasheet:
https://cdn-shop.adafruit.com/datasheets/SSD1306.pdf

Just a TL;DR of the former approach for easier discussion:
The logic supply VDD would always be mandatory.
The low voltage supply VBAT would be optional and probed first.
If found, it would supersede the "high" voltage driving supply VCC and
the charge pump would be enabled. If VBAT is not found, then VCC is
mandatory and the charge pump will not be enabled.


--
Best regards

Dominik Kierner
Research & Development
DH electronics

