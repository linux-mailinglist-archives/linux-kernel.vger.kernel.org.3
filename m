Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7EB44763AC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhLOUqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:46:15 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:47788 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbhLOUqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:46:14 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1458D1C0B9C; Wed, 15 Dec 2021 21:46:13 +0100 (CET)
Date:   Wed, 15 Dec 2021 21:46:06 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] leds: ktd20xx: Add the KTD20xx family of the RGB
 LEDs driver from Kinetic
Message-ID: <20211215204606.GH28336@duo.ucw.cz>
References: <20211123101826.9069-1-fe@dev.tdt.de>
 <20211123101826.9069-2-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AzNpbZlgThVzWita"
Content-Disposition: inline
In-Reply-To: <20211123101826.9069-2-fe@dev.tdt.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AzNpbZlgThVzWita
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Introduce the KTD2061/58/59/60 RGB LEDs driver. The difference in these
> parts are the address number on the I2C bus the device is listen on.
>=20
> All KT20xx device could control up to 12 LEDs. The chip can be operated
> in two variants.
>=20
> Variant 1:
> The device has the ability to group LED outputs into two banks so that
> the two LED banks can be controlled with the same color. This could not
> be done via the LEDs 'sysfs' entry because of the limitation on the color
> register count. The color of the two banks can be configured via device
> 'sysfs' entry for all LEDs at once [current_color0|current_color1].
> Which color the LED is to be used can be set via the 'sysfs' of the
> individual LEDs via the 'multi_intensity' file. Valid values for the
> colors (RGB) are 0 | 1. The value 0 selects the color register 0 and the
> value 1 selects the color register 1.
>=20
> Variant 2:
> The device can also set the LED color independently. Since the chip only
> has two color registers, but we want to control the 12 LEDs
> independently via the 'led-class-multicolour' sysfs entry,
> the full RGB color depth cannot be used. Due to this limitation, only 7
> colors and the color black (off) can be set. To use this mode the color
> registers must be preset via the device tree or the device 'sysfs'. The
> color registers 0 must be preset with 0x00 (Red=3D0x00 Green=3D0x00 Blue=
=3D0x00).
> The color register1 should be preset all with the same value. This value
> depends on which light intensity is to be used in the setup.

Summary: some crazy hardware.

> +static ssize_t current_color0_store(struct device *dev,
> +		struct device_attribute *a,
> +		const char *buf, size_t size)
> +{

And now we have custom interface. Undocumented.

That is not acceptable, sorry.

Find a way to squeeze it into current RGB framework, perhaps with
reduced feature set.

AFAICT you could either pretend it is 2-LED driver with full 8bit RGB
on each, or you could pretend it is 12-LED driver with 1bit
RGB. Select one and implement that.

Best regards,
									Pavel
--=20
http://www.livejournal.com/~pavelmachek

--AzNpbZlgThVzWita
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYbpUDgAKCRAw5/Bqldv6
8jAIAJwLayuGsDv/gbU954WbGOG7AW6VYACeMjuav6P+tpCZAO1qh4oKNblyJck=
=DU/B
-----END PGP SIGNATURE-----

--AzNpbZlgThVzWita--
