Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14864E1DC1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 21:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243643AbiCTUpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 16:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbiCTUpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 16:45:43 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C42DFD9;
        Sun, 20 Mar 2022 13:44:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 4C0B7E0167;
        Sun, 20 Mar 2022 13:44:18 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 79DKE2slsi-k; Sun, 20 Mar 2022 13:44:17 -0700 (PDT)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To:     Hans de Goede <hdegoede@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Purism Kernel Team <kernel@puri.sm>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] power: supply: max17042_battery: use ModelCfg refresh on max17055
Date:   Sun, 20 Mar 2022 21:44:12 +0100
Message-ID: <2957015.e9J7NaK4W3@pliszka>
In-Reply-To: <5d43031e-382d-b12c-bba2-0e630fbec1ad@kernel.org>
References: <20220318001048.20922-1-sebastian.krzyszkowiak@puri.sm> <7080597.aeNJFYEL58@pliszka> <5d43031e-382d-b12c-bba2-0e630fbec1ad@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3296970.aeNJFYEL58"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3296970.aeNJFYEL58
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Date: Sun, 20 Mar 2022 21:44:12 +0100
Message-ID: <2957015.e9J7NaK4W3@pliszka>
In-Reply-To: <5d43031e-382d-b12c-bba2-0e630fbec1ad@kernel.org>

On niedziela, 20 marca 2022 13:18:49 CET Krzysztof Kozlowski wrote:
> On 18/03/2022 20:58, Sebastian Krzyszkowiak wrote:
> > On pi=C4=85tek, 18 marca 2022 09:22:16 CET Krzysztof Kozlowski wrote:
> >> On 18/03/2022 01:10, Sebastian Krzyszkowiak wrote:
> >>> Unlike other models, max17055 doesn't require cell characterization
> >>> data and operates on smaller amount of input variables (DesignCap,
> >>> VEmpty, IChgTerm and ModelCfg). Input data can already be filled in
> >>> by max17042_override_por_values, however model refresh bit has to be
> >>> set after adjusting input variables in order to make them apply.
> >>>=20
> >>> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> >>> ---
> >>>=20
> >>>  drivers/power/supply/max17042_battery.c | 73 +++++++++++++++--------=
=2D-
> >>>  include/linux/power/max17042_battery.h  |  3 +
> >>>  2 files changed, 48 insertions(+), 28 deletions(-)
> >>>=20
> >>> diff --git a/drivers/power/supply/max17042_battery.c
> >>> b/drivers/power/supply/max17042_battery.c index
> >>> c019d6c52363..c39250349a1d 100644
> >>> --- a/drivers/power/supply/max17042_battery.c
> >>> +++ b/drivers/power/supply/max17042_battery.c
> >>> @@ -806,6 +806,13 @@ static inline void
> >>> max17042_override_por_values(struct max17042_chip *chip)>
> >>>=20
> >>>  	    (chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX17055)) {
> >>>  	=09
> >>>  		max17042_override_por(map, MAX17047_V_empty, config-
> >>=20
> >> vempty);
> >>=20
> >>>  	}
> >>>=20
> >>> +
> >>> +	if (chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX17055) {
> >>> +		max17042_override_por(map, MAX17055_ModelCfg, config-
> >>=20
> >> model_cfg);
> >>=20
> >>> +		// VChg is 1 by default, so allow it to be set to 0
> >>=20
> >> Consistent comment, so /* */
> >>=20
> >> I actually do not understand fully the comment and the code. You write
> >> entire model_cfg to MAX17055_ModelCfg and then immediately do it again,
> >> but with smaller mask. Why?
> >=20
> > That's because VChg is 1 on POR, and max17042_override_por doesn't do
> > anything when value equals 0 - which means that if the whole
> > config->model_cfg is 0, VChg won't get unset (which is needed for 4.2V
> > batteries).
> >=20
> > This could actually be replaced with a single regmap_write.
>=20
> I got it now. But if config->model_cfg is 0, should VChg be unset?

That's a good question.

max17042_override_por doesn't override the register value when the given va=
lue=20
equals zero in order to not override POR defaults with unset platform data.=
=20
This way one can set only the registers that they want to change in `config=
`=20
and the rest are untouched. This, however, only works if we assume that zer=
o=20
means "don't touch", which isn't the case for ModelCfg.

On the Librem 5, we need to unset VChg bit because our battery is only bein=
g=20
charged up to 4.2V. Allowing to unset this bit only without having to touch=
=20
the rest of the register was the motivation behind the current version of t=
his=20
patch, however, thinking about it now I can see that it fails to do that in=
=20
the opposite case - when the DT contains a simple-battery with maximum volt=
age=20
higher than 4.25V, VChg will be set in config->model_cfg causing the whole=
=20
register to be overwritten.

So, I see two possible solutions:

1) move VChg handling to a separate variable in struct max17042_config_data=
=2E=20
This way model_cfg can stay zero when there's no need to touch the rest of =
the=20
register. This minimizes changes over current code.

2) remove max17042_override_por_values in its current shape altogether and=
=20
make it only deal with the values that are actually being set by the driver=
=20
(and only extend it in the future as it gains more ability). Currently most=
 of=20
this function is only usable with platform data - is there actually any use=
r=20
of max17042 that would need to configure the gauge without DT in the mainli=
ne=20
kernel? My quick search didn't find any. Do we need or want to keep platfor=
m=20
data support at all?

I'm leaning towards option 2, as it seems to me that currently this driver =
is=20
being cluttered quite a lot by what's essentially a dead code. Adding new=20
parameters to read from DT for POR initialization (which is necessary for=20
other models than MAX17055) should be rather easy, but trying to fit them i=
nto=20
current platform_data-oriented code may be not.

Regards,
Sebastian
--nextPart3296970.aeNJFYEL58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIt2frgBqEUNYNmF86PI1zzvbw/8FAmI3khwACgkQ6PI1zzvb
w//8VA//RbpNAFv5HMrfF8HJSGTu79QpRPowLM/TXgSFxiQ4yQxhPy/yWvCXIAN2
pDr703YyU9NMQVEp9r+OE3OrOE5Qh4n2V6Lq8lClz1aamcfX9ZcTrDRnuv4BNJLk
TWD4j05gaj5Sg8PgU4Bi/1qE9nlPS+X20KWkYPjfhPoEWet4f7hzZVbeVDXsY56z
5I1d8CMXd9UJ5X6JXLfvNlkERmpzBuR3OsjNa/QC82Itxfy10qBUqDnH6zv0R8vm
n46FX2Ja6Xsrl4rU8gcNeQJoVgD4/MmSt/8pj4o0jjcATTwH5bcfWAz4PsFB0Ygp
9w5EOo330Sn73ENUPHic+oDb3EYLv6LKtYLp1QJxH9DcCdwJyGeXkd3MDAvel7jB
6sHmLZgO071fkQ8iCJ7cT6tU7D87C7YqJngArZU6tKJ2+XK2PcPPXqKwQgH9N2iC
aKWOxjLt2f4pbeuCImCeIp1Wy8PPMY3noLLQPLWmz878egxw+otg1tVFd94bi3qO
N8Bje9SW6PCTibVGxC0htHEeuIGvpXmp6utx9v277RXvgueTBpt3LHyxPBuH8xH/
exiAC6x+CTdH0PhpfCKAu4Y5gS+Rlz00+dg+XhSUyb/HKypWu5x7ykxA8JitFdaq
QGil5M9EFbUB3WmMyRCYVgGTY0By9fkkh+2aDObjNhG9GPoFNWQ=
=l8wm
-----END PGP SIGNATURE-----

--nextPart3296970.aeNJFYEL58--



