Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64C24C9FF8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240266AbiCBIzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235558AbiCBIzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:55:17 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7508160062;
        Wed,  2 Mar 2022 00:54:34 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 91B021C0B81; Wed,  2 Mar 2022 09:54:32 +0100 (CET)
Date:   Wed, 2 Mar 2022 09:54:32 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        linux-leds@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 0/2] leds: pca955x: Expose GPIOs for all pins
Message-ID: <20220302085432.GA11054@duo.ucw.cz>
References: <20210921043936.468001-1-andrew@aj.id.au>
 <d2b85ad7-aef7-6088-03f5-cbd6e0bcab5d@kaod.org>
 <CACPK8Xdvns7PK9t1ZutAbkJqhb5eRcoWCDySQGsfbtLv+XMvqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <CACPK8Xdvns7PK9t1ZutAbkJqhb5eRcoWCDySQGsfbtLv+XMvqQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Without these patches the driver limits the number of pins exposed on
> > > the gpiochip to the number of pins specified as GPIO in the devicetre=
e,
> > > but doesn't map between the GPIO and pin number spaces. The result is
> > > that specifying offset or interleaved GPIOs in the devicetree gives
> > > unexpected behaviour in userspace.
> > >
> > > By always exposing all pins as GPIOs the patches resolve the lack of
> > > mapping between GPIO offsets and pins on the package in the driver by
> > > ensuring we always have a 1-to-1 mapping.
> > >
> > > The issue is primarily addressed by patch 1/2. Patch 2/2 makes it
> > > possible to not expose any pins as LEDs (and therefore make them all
> > > accessible as GPIOs). This has a follow-on effect of allowing the dri=
ver
> > > to bind to a device instantiated at runtime without requiring a
> > > description in the devicetree.
> > >
> > > I've tested the series under qemu to inspect the various interactions
> > > between LEDs vs GPIOs as well as conflicting GPIO requests.
>=20
> > > Please review!
> >
> > This is simpler than the 'ngpio' business we had before.
> >
> > Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> I saw that you recently merged some LED patches. I was wondering if
> you could consider this series for v5.18. It still applies cleanly,
> and we've been running it for a while now, so it's very well tested.

Thanks, applied. I must say this is really ninja-mutant driver, but I
see no better way.

+++ b/drivers/leds/leds-pca955x.c
@@ -429,7 +429,7 @@ pca955x_get_pdata(struct i2c_client *client, struct pca=
955x_chipdef *chip)
        int count;

This really should be unsigned. Care to fix/submit a patch?

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYh8wyAAKCRAw5/Bqldv6
8oNLAJ96DjXmoElXBR+MSiaDzZLxaLlC0QCdGgbx+NMDlutN+emWDQPClInhLhc=
=IHSy
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
